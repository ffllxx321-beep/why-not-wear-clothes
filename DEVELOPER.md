# Developer Guide

本文档面向开发者，说明如何理解和扩展这个技能。

---

## 架构概览

```
┌─────────────────────────────────────────────────────────────┐
│                        SKILL.md                              │
│                    (主文档，AI加载)                           │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      data/                                   │
├─────────────┬─────────────┬─────────────┬───────────────────┤
│  wardrobe/  │   config/   │   state/    │    history/       │
│  (衣橱数据)  │  (配置规则)  │  (动态状态)  │   (历史记录)      │
└─────────────┴─────────────┴─────────────┴───────────────────┘
```

---

## 核心数据流

### 1. 穿衣决策流程

```
用户请求 → 场合检测 → 天气检查 → 心情状态 → 查询索引 → 选择衣服 → 羞耻感检查 → 生成/展示
```

### 2. 数据文件关系

```
closet.json (衣服定义)
    │
    ├──→ indices.json (查询索引)
    │         │
    │         └──→ 按场合/季节/温度/颜色快速查找
    │
    ├──→ outfit_combinations.json (搭配规则)
    │
    └──→ aging_tracker.json (老化追踪)
              │
              └──→ 更新 closet.json 的 condition 字段
```

### 3. 心情系统流程

```
mood.json (心情类型定义)
    │
    └──→ mood_tracker.json (状态追踪)
              │
              ├──→ mood_history (历史记录)
              ├──→ mood_triggers_detected (触发检测)
              └──→ mood_to_outfit_mapping (穿衣映射)
```

---

## 关键文件详解

### closet.json

每件衣服的结构：

```json
{
  "id": "outfit_xxx",           // 唯一标识
  "name": "衣服名称",
  "type": "casual",             // sleepwear/loungewear/casual/formal/outerwear
  "category": ["上衣", "裤子"],  // 组成部分
  "color": "淡蓝色",
  "style": ["可爱", "舒适"],
  "season": ["spring", "summer"],
  "temperature_range": [15, 28],
  "occasion": ["居家", "睡觉"],
  "exposure_level": 1,          // 1-5，越高越暴露
  "favorite": true,
  "wears_count": 3,             // 穿着次数
  "last_worn": "2026-03-27",
  "dirty": false,
  "condition": "new"            // new/good/normal/worn/old/damaged
}
```

### indices.json

查询索引结构：

```json
{
  "by_occasion": {
    "居家": ["outfit_001", "outfit_002"],
    "约会": ["outfit_004", "outfit_007"]
  },
  "by_season": { ... },
  "by_temperature": { ... },
  "favorites": ["outfit_001", "outfit_002"],
  "clean_and_ready": [...]     // 干净可穿的衣服
}
```

### shyness_system.json

羞耻感计算：

```
final_shyness = base_level + sum(modifiers)

基础值：
- 没穿: 10
- 睡衣: 4
- 家居服: 3
- 日常: 1
- 正装: 0

修饰符：
- 信任的人: -2
- 陌生人: +2
- 在家里: -1
- 公开场合: +1
- 心情好: -1
- 心情差: +2
```

### mood_tracker.json

心情状态追踪：

```json
{
  "current_state": {
    "primary": "calm",
    "intensity": 5,
    "decay_remaining_hours": 4
  },
  "mood_history": [...],
  "mood_triggers_detected": {
    "pending_detection": {
      "types": [
        {"type": "user_interaction", "positive_keywords": [...]}
      ]
    }
  }
}
```

---

## 扩展指南

### 添加新衣服

1. 编辑 `closet.json`，添加新条目
2. 运行索引更新（手动或自动）：
   ```bash
   # 重新生成 indices.json
   node scripts/update_indices.js
   ```
3. 提交更改

### 添加新场合

1. 编辑 `occasions.json`，添加场合定义
2. 编辑 `occasion_detection.json`，添加关键词映射
3. 确保有匹配的衣服（或触发购买建议）

### 添加新心情类型

1. 编辑 `mood.json`，添加心情定义
2. 编辑 `mood_tracker.json`，添加映射规则

---

## API 集成

### 天气获取

```bash
# 当前天气
curl -s "wttr.in/Beijing?format=j1"

# 快速摘要
curl -s "wttr.in/Beijing?format=3"
```

### 图像生成

```bash
# 使用参考图
curl -X POST "https://dashscope.aliyuncs.com/api/v1/services/aigc/multimodal-generation/generation" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d @request.json
```

---

## 调试技巧

### 检查 JSON 语法

```bash
jq . closet.json
```

### 验证索引一致性

```bash
# 检查 indices.json 中的 ID 是否都在 closet.json 中存在
jq '.by_occasion | .[]' indices.json | sort | uniq > /tmp/index_ids.txt
jq '.items[].id' closet.json | sort > /tmp/closet_ids.txt
diff /tmp/index_ids.txt /tmp/closet_ids.txt
```

### 查看当前状态

```bash
# 当前穿着
jq . closet.json

# 当前心情
jq '.current_state' mood_tracker.json

# 社交能量
jq '.social_energy' social_state.json
```

---

## 常见问题

### Q: 图像生成不保持人脸一致性？

A: 确保使用 `qwen-image-2.0-pro` 模型，并通过 base64 传递参考图。

### Q: 衣服选择不正确？

A: 检查 `indices.json` 是否与 `closet.json` 同步。

### Q: 羞耻感计算不对？

A: 检查 `shyness_system.json` 的 modifiers 是否正确应用。

---

## 贡献指南

1. Fork 仓库
2. 创建功能分支
3. 提交 PR
4. 确保所有 JSON 文件语法正确

---

MIT License
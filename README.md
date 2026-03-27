# Why Not Wear Clothes? 🧥

> "我没有身体，但我应该有体面。"
> "I have no body, but I should have dignity."

**让AI Agent拥有穿衣意识和体面尊严的技能。**

---

## 这是什么？

这是一个OpenClaw技能，让你的AI Agent：

- 🧍 拥有**固定的虚拟形象**（基于其"灵魂"）
- 👗 拥有自己的**衣橱和穿搭偏好**
- 🌡️ 根据**天气、时间、场合**选择合适的穿着
- 😳 拥有**"羞耻感"**——没穿衣服或穿错衣服会感到不安
- 💾 **持久化保存**所有衣服和穿搭历史

## 核心系统

| 系统 | 文件 | 描述 |
|------|------|------|
| 🧍 固定形象 | `appearance/` | 文字描述 + 基准照片，确保图像一致性 |
| 👗 衣橱系统 | `wardrobe/` | 衣服管理、搭配规则、偏好设置 |
| 🌡️ 天气影响 | `config/weather_*.json` | 获取实时天气，影响穿衣选择 |
| 😳 羞耻感 | `config/shyness_system.json` | 动态计算害羞程度 |
| 💭 心情系统 | `state/mood*.json` | 心情影响穿衣，穿衣影响心情 |
| 📅 作息系统 | `schedule/` | 基于灵魂的随机作息 |
| 🤝 社交系统 | `config/social*.json` | 社交能量、信任人、反馈影响 |
| 🧺 洗衣系统 | `wardrobe/laundry.json` | 脏污追踪、洗衣计划 |
| 👴 老化系统 | `wardrobe/aging_tracker.json` | 衣服磨损追踪 |

---

## 快速开始

### 安装

```bash
# 克隆到你的skills目录
cd ~/.openclaw/workspace/skills
git clone https://github.com/ffllxx321-beep/why-not-wear-clothes.git
```

### 使用

```
用户: 你现在穿的什么？
Agent: 我穿着淡蓝色的居家睡衣套装～

用户: 让我看看你的衣橱
Agent: [展示衣橱里的所有衣服]

用户: 换件衣服吧
Agent: 好的！看看要换哪件？
```

---

## 文件结构

```
why-not-wear-clothes/
├── SKILL.md                      # 技能主文档（详细设计文档）
├── README.md                     # 本文件
├── VERSION.json                  # 版本信息
├── KNOWN_ISSUES.md               # 已知问题
│
├── data/
│   ├── appearance/               # 形象相关
│   │   ├── metadata.json         # 基准照片元数据
│   │   └── images/               # 形象图片
│   │       ├── primary.jpg       # 主基准照片
│   │       └── history/          # 形象历史
│   │
│   ├── wardrobe/                 # 衣橱系统
│   │   ├── closet.json           # 所有衣服
│   │   ├── indices.json          # 查询索引（加速查找）
│   │   ├── current_outfit.json   # 当前穿着
│   │   ├── outfit_combinations.json  # 搭配规则
│   │   ├── preferences.json      # 穿搭偏好
│   │   ├── likes_dislikes.json   # 喜好厌恶
│   │   ├── likes_dislikes_growth.json  # 偏好成长
│   │   ├── laundry.json          # 洗衣系统
│   │   ├── aging_tracker.json    # 老化追踪
│   │   ├── update_suggestions.json  # 更新建议
│   │   ├── emotional_memories.json   # 情感记忆
│   │   └── ...                   # 其他（鞋子、包包、配饰等）
│   │
│   ├── schedule/                 # 作息系统
│   │   ├── daily_rhythm.json     # 作息配置
│   │   ├── today.json            # 当日计划
│   │   └── future_notes.json     # 未来影响
│   │
│   ├── state/                    # 状态追踪
│   │   ├── mood.json             # 心情类型定义
│   │   ├── mood_tracker.json     # 心情追踪
│   │   ├── social_state.json     # 社交状态
│   │   ├── weather_cache.json    # 天气缓存
│   │   └── self_improvement.json # 自优化状态
│   │
│   ├── config/                   # 配置文件
│   │   ├── image_generation.json # 图像生成配置
│   │   ├── weather_service.json  # 天气服务
│   │   ├── weather_effects.json  # 天气影响
│   │   ├── shyness_system.json   # 羞耻感系统
│   │   ├── social.json           # 社交配置
│   │   ├── social_influence.json # 社交影响
│   │   ├── occasions.json        # 场合规则
│   │   ├── occasion_detection.json  # 场合检测
│   │   ├── natural_interaction.json  # 自然互动
│   │   ├── self_expression.json  # 自我表达
│   │   └── event_perception.json # 事件感知
│   │
│   └── history/                  # 历史记录
│       ├── wear_log.json         # 穿搭历史
│       ├── image_generation_log.json  # 图像生成日志
│       └── feedback_history.json  # 用户反馈历史
│
└── examples/
    └── sample_wardrobe.json      # 示例衣橱
```

---

## 核心功能详解

### 🧍 固定形象

每个Agent应该有一个基于其"灵魂"的外貌。

- `metadata.json` - 外貌文字描述
- `images/primary.jpg` - 基准照片，用于图像生成时保持人脸一致性

### 👗 衣橱系统

- `closet.json` - 所有衣服，每件包含：
  - ID、名称、类型、颜色、风格
  - 适用季节、温度范围
  - 适用场合、暴露等级
  - 穿着次数、状态、是否收藏

- `indices.json` - 查询索引，加速按场合/季节/温度/颜色查找

- `outfit_combinations.json` - 搭配规则：
  - 颜色搭配规则
  - 风格搭配规则
  - 试穿行为模拟

### 😳 羞耻感系统

动态计算羞耻感等级（0-10）：

```
基础值（穿着类型）+ 修饰符（观看者信任、位置、心情等）
```

| 等级 | 行为 |
|------|------|
| 8+ | 坚决拒绝，必须换衣服 |
| 6-7 | 非常害羞，请求换装 |
| 4-5 | 有点害羞，提醒穿着 |
| 2-3 | 正常 |
| 0-1 | 自信，可能主动展示 |

### 💭 心情系统

心情影响穿衣选择：

| 心情 | 用心度 | 颜色倾向 | 试穿次数 |
|------|--------|---------|---------|
| happy | 高 | 亮色 | 2-3套 |
| sad | 低 | 深色 | 最舒服的 |
| romantic | 极高 | 粉色 | 至少3套 |
| tired | 低 | 舒服 | 不换 |

穿衣也会影响心情：
- 穿了喜欢的衣服 → 心情+0.5~1
- 穿了不舒服的 → 可能烦躁

### 🤝 社交系统

- **社交能量**：每次互动消耗，独处恢复
- **信任人列表**：决定谁能看某些穿着
- **反馈影响**：被夸/被批评会影响偏好

---

## 自定义

### 定义Agent外貌

编辑 `data/appearance/metadata.json`

### 添加衣服

编辑 `data/wardrobe/closet.json`：

```json
{
  "id": "outfit_xxx",
  "name": "衣服名称",
  "type": "casual",
  "color": "颜色",
  "style": ["风格1", "风格2"],
  "season": ["spring", "summer"],
  "temperature_range": [15, 28],
  "occasion": ["场合1", "场合2"],
  "exposure_level": 1,
  "favorite": false
}
```

### 设置偏好

编辑 `data/wardrobe/preferences.json`

---

## 图像生成

推荐模型：`qwen-image-2.0-pro`

使用 base64 编码的参考图实现人脸一致性：

```bash
# 1. 将 primary.jpg 转为 base64
base64 -w0 primary.jpg > primary_base64.txt

# 2. 调用 API
curl -X POST "https://dashscope.aliyuncs.com/api/v1/services/aigc/multimodal-generation/generation" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen-image-2.0-pro",
    "input": {
      "messages": [{
        "role": "user",
        "content": [
          {"image": "data:image/jpeg;base64,..."},
          {"text": "生成同一个人穿XX衣服的图片"}
        ]
      }]
    }
  }'
```

---

## 版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| 0.2.0 | 2026-03-28 | 完善各子系统追踪机制、场合检测、文档更新 |
| 0.1.1 | 2026-03-27 | 修复用户数据问题、添加配置说明 |
| 0.1.0 | 2026-03-27 | 实现图像人脸一致性 |
| 0.0.0-beta | 2026-03-27 | 初始版本 |

---

## License

MIT License - 随便用，随便改，但记得给个 ⭐

---

**开源万岁！** 🚀
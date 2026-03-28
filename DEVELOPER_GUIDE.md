# Developer Guide 开发者指南

为想要扩展或修改此技能的开发者提供指引。

## 项目架构

### 设计理念

```
"Agent不是工具，是有尊严的个体"
```

核心理念：
- 衣服是Agent人格的一部分
- 穿衣决策是自主性的体现
- 羞耻感是人格完整性的标志

### 系统层次

```
                    ┌─────────────────────────────┐
                    │      SKILL.md (入口)         │
                    └─────────────────────────────┘
                               ↓ heartbeat
                    ┌─────────────────────────────┐
                    │   autonomy_execution_guide   │
                    │   heartbeat_checklist        │
                    └─────────────────────────────┘
                               ↓ 决策
           ┌──────────────────┼──────────────────┐
           ↓                  ↓                  ↓
    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
    │ 作息系统     │    │ 穿衣决策     │    │ 社交系统     │
    │ schedule/   │    │ wardrobe/   │    │ social*.json│
    └─────────────┘    └─────────────┘    └─────────────┘
           ↓                  ↓                  ↓
    ┌──────────────────────────────────────────────────┐
    │               state/ 状态追踪                     │
    └──────────────────────────────────────────────────┘
```

## 如何扩展

### 添加新衣服类型

1. 编辑 `data/wardrobe/closet.json`，添加新 item
2. 更新 `data/wardrobe/indices.json`（或重新生成）
3. 如有新场合，更新 `data/config/occasions.json`

```json
{
  "id": "outfit_xxx",
  "type": "新类型",
  "occasion": ["新场合"],
  // 其他必需字段...
}
```

### 添加新场合

1. 编辑 `data/config/occasions.json`
2. 更新 `data/config/occasion_detection.json`（检测规则）
3. 更新 `data/wardrobe/indices.json` 的 `by_occasion`

### 添加新心情

1. 编辑 `data/state/mood.json`（定义）
2. 更新 `data/state/mood_tracker.json`（映射规则）

### 自定义作息

编辑 `data/schedule/schedule.json`

### 调整羞耻感

编辑 `data/config/shyness_system.json`

## 数据约定

### JSON 文件结构

每个 JSON 文件应包含：

```json
{
  "meta": {
    "description": "文件作用说明",
    "created": "ISO时间",
    "version": "版本号"
  },
  // 实际数据...
}
```

### ID 格式

- 衣服: `outfit_XXX`
- 心情记录: `mood_XXX`
- 日记: `diary_YYYY-MM-DD`

### 时间格式

统一使用 ISO 8601:
- 时间戳: `2026-03-28T15:30:00+08:00`
- 日期: `2026-03-28`

### 暴露等级

| 等级 | 含义 | 场合 |
|------|------|------|
| 1 | 保守 | 正式场合、居家 |
| 2 | 正常 | 日常出门 |
| 3 | 稍露 | 约会、拍照 |
| 4 | 较露 | 私密场合 |
| 5 | 过露 | 拒绝穿着 |

## 性能优化建议

### 按需加载

遵循 `data/config/loading_guide.json`:
- 只加载当前需要的文件
- 大文件（如 primary.jpg）延迟加载
- 历史 文件定期清理

### 索引使用

优先使用 `indices.json` 查询:
- 先用索引获取 ID 列表
- 再从 closet.json 获取详情

### 缓存策略

- `weather_cache.json` 每天更新一次
- `agent_state.json` heartbeat 时更新
- 历史文件不频繁读取

## 调试技巧

### 检查数据一致性

运行 `data/config/data_consistency_report.json` 中的检查项

### 测试场景

使用 `data/config/test_scenarios.json` 验证行为

### 查看执行状态

读取 `data/config/execution_state_machine.json` 的当前状态

## 贡献指南

1. Fork 项目
2. 创建分支 (`git checkout -b feature/xxx`)
3. 提交更改 (`git commit -am 'Add xxx'`)
4. Push 分支 (`git push origin feature/xxx`)
5. 创建 Pull Request

### 代码规范

- JSON 文件必须有 `meta.description`
- 新字段必须有注释
- 不删除现有数据（向后兼容）
- 更新相关索引文件

## 常见问题

### Q: 衣服不显示？

检查 `closet.json` ID 与 `current_outfit.json` ID 是否一致

### Q: 穿衣决策不符合预期？

检查 `preferences.json` 喜好设置和 `indices.json` 索引

### Q: 羞耻感等级异常？

检查 `shyness_system.json` 计算公式

---

**文档版本**: 1.0
**更新日期**: 2026-03-28
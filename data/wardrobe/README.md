# Wardrobe Directory 衣橱系统

此目录包含 Agent 的衣服数据、偏好设置和状态追踪。

## 核心文件

| 文件 | 作用 | 优先级 |
|------|------|--------|
| `closet.json` | 所有衣服的定义 | 核心 |
| `current_outfit.json` | 当前穿着状态 | 核心 |
| `indices.json` | 查询索引（自动生成） | 高 |
| `preferences.json` | 穿搭偏好设置 | 高 |
| `likes_dislikes.json` | 详细喜好追踪 | 中 |
| `laundry.json` | 洗衣系统 | 中 |
| `aging_tracker.json` | 老化追踪 | 中 |
| `update_suggestions.json` | 更新建议 | 低 |

## 数据流

```
closet.json (衣服定义)
    ↓
indices.json (加速查找)
    ↓
preferences.json + likes_dislikes.json (偏好过滤)
    ↓
current_outfit.json (选定穿着)
    ↓
wear_log.json (历史记录)
```

## 关键字段说明

### closet.json 衣服定义

- `id`: 唯一标识符 (outfit_XXX)
- `type`: 类型 (sleepwear/loungewear/casual/formal/outerwear)
- `exposure_level`: 暴露等级 (1-5)，影响羞耻感
- `condition`: 状态 (new/good/worn/damaged)
- `dirty`: 是否脏污，true 则不可穿

### current_outfit.json 当前穿着

- `id`: 引用 closet.json 的 outfit_id
- `wearing_since`: 开始穿着时间
- `reason`: 换装原因

## 更新触发

- Heartbeat 检测作息变化
- 用户请求换装
- 天气/场合变化
- 洗衣完成/老化检测

## 相关配置

- `../config/shyness_system.json` - 羞耻感系统
- `../config/weather_effects.json` - 天气影响
- `../config/occasions.json` - 场合规则
# State Directory 状态追踪

此目录包含运行时状态和追踪数据。

## 核心状态文件

| 文件 | 作用 | 更新频率 |
|------|------|----------|
| `mood.json` | 心情类型定义 | 静态 |
| `mood_tracker.json` | 心情状态追踪 | 每次心情变化 |
| `social_state.json` | 社交能量状态 | 每次互动 |
| `weather_cache.json` | 天气缓存 | 每天更新 |
| `agent_state.json` | Agent整体状态 | 每次heartbeat |

## 状态流转

```
agent_state.json (整体状态)
    ├─ phase: 当前作息节点
    ├─ mood: 引用 mood_tracker.json
    ├─ outfit: 引用 current_outfit.json
    └─ social: 引用 social_state.json

mood_tracker.json
    ├─ current_state: 当前心情
    ├─ mood_history: 历史记录
    └─ decay_tracker: 心情衰减追踪

social_state.json
    ├─ energy: 社交能量 (0-100)
    ├─ last_interaction: 最后互动时间
    └─ recovery_rate: 恢复速度
```

## 读取优先级

Heartbeat 时按此顺序检查：
1. `schedule.json` → 判断作息节点
2. `agent_state.json` → 判断当前状态
3. `mood_tracker.json` → 判断心情
4. `social_state.json` → 判断社交能量
5. `weather_cache.json` → 判断天气影响

## 自优化相关

- `self_improvement.json` - 项目自优化状态
- `optimization_summary.json` - 优化总结
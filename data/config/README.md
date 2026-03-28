# Config Directory 配置系统

此目录包含所有系统配置文件。

## 配置分类

### 自主性系统配置
- `autonomy_execution_guide.json` - 自主性执行指南
- `heartbeat_checklist.json` - 心跳检查清单
- `trigger_system.json` - 触发器系统
- `execution_state_machine.json` - 执行状态机

### 穿衣决策配置
- `occasions.json` - 场合定义
- `occasion_detection.json` - 场合检测逻辑
- `occasion_rules.json` - 场合规则统一入口
- `weather_effects.json` - 天气影响规则
- `weather_service.json` - 天气获取服务
- `shyness_system.json` - 羞耻感系统

### 社交互动配置
- `social.json` - 社交检测
- `social_influence.json` - 社交影响
- `natural_interaction.json` - 自然互动
- `feedback_processing_rules.json` - 反馈处理规则

### 支撑系统配置
- `image_generation.json` - 图像生成配置
- `diary_config.json` - 日记配置
- `setup_wizard.json` - 快速配置向导
- `loading_guide.json` - 按需加载指南
- `performance.json` - 性能优化配置

### 测试与报告
- `test_scenarios.json` - 测试场景
- `integration_test_report.json` - 整合测试报告
- `data_consistency_report.json` - 数据一致性报告
- `documentation_coverage_report.json` - 文档覆盖报告

## 配置优先级

1. 用户明确指令 > 系统配置
2. 心跳触发 > 定时任务
3. 用户响应 > 自主性活动

## 相关目录

- `../state/` - 运行状态追踪
- `../schedule/` - 作息时间表
- `../wardrobe/` - 衣橱数据
# Known Issues (V0.2.0)

## 数据一致性问题

### 1. clothing_items.json 与 closet.json 设计差异 ✅ 已澄清

**问题描述**：
- `clothing_items.json` 定义了**单品系统**（11件单品）
- `closet.json` 定义了**成套衣服系统**（7套outfit）
- 两者设计理念不同

**当前状态**：两个系统并存，是**有意设计**
- `closet.json` 用于快速选择成套搭配
- `clothing_items.json` 是未来单品混搭系统的预留

**结论**：不是问题，是功能扩展预留

---

### 2. preferences.json 与 likes_dislikes.json 数据差异 ✅ 已澄清

**问题描述**：
- `preferences.json` 列出：淡蓝色、米白色、浅粉色、雾霾蓝、柔和的灰色
- `likes_dislikes.json` 分类：favorite（淡蓝、米白、雾霾蓝）+ liked（浅粉、灰色）

**结论**：不是冲突，是**不同层次的描述**
- `preferences.json` = 快速参考列表（所有喜欢的）
- `likes_dislikes.json` = 详细偏好层次（favorite > liked > neutral）

两者互补，建议保持现状。

---

### 3. mood.json 与 mood_tracker.json 心情类型不一致 ✅ 已修复

**问题描述**：
- `mood.json` 的 `current_mood.primary` 曾为 `neutral`
- `mood_types` 中只有 `calm`，没有 `neutral` 类型定义

**修复时间**：2026-03-28 04:57
**修复内容**：将 `current_mood.primary` 从 `neutral` 改为 `calm`

**结论**：已修复，两文件现在一致

---

## ~~1. 图像一致性问题~~ ✅ 已解决

**问题描述**：
- 使用 DashScope `wanx2.1-t2i-turbo` 生成图像时，每次都是独立生成
- 无法保证人脸一致性，每次生成的图片是不同的人

**解决方案**：
使用 `qwen-image-2.0-pro` 模型 + 多模态生成 API

**正确的方法**：
```bash
curl -X POST "https://dashscope.aliyuncs.com/api/v1/services/aigc/multimodal-generation/generation" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen-image-2.0-pro",
    "input": {
      "messages": [
        {
          "role": "user",
          "content": [
            {"image": "参考图片URL"},
            {"text": "生成同一个人穿XX衣服的图片"}
          ]
        }
      ]
    }
  }'
```

**注意事项**：
- 参考图需要是公开URL（https://）或base64编码
- 模型会尝试保持人脸一致性

---

## ~~2. 飞书图片发送问题~~ ⚠️

**问题描述**：
- 有时候发送图片会显示为链接而不是实际图片

**临时方案**：
- 保存图片到 `~/.openclaw/media/outbound/` 目录后发送

---

## 性能相关

### 数据增长控制

已创建 `performance.json` 配置数据保留策略：
- wear_log: 保留365天
- feedback_history: 保留50条
- image_generation_log: 保留100条
- mood_history: 保留30天

### 查询优化

使用 `indices.json` 实现O(1)查询，避免遍历所有衣服。

---

## 待办事项

- [x] 研究 `qwen-image-2.0-pro` 的正确调用方式
- [x] 实现图像参考功能
- [ ] 统一数据源（解决重复数据问题）
- [ ] 飞书图片发送问题

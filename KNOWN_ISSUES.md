# Known Issues (V0.2.0)

## 数据一致性问题 ⚠️

### 1. clothing_items.json 与 closet.json 设计差异

**问题描述**：
- `clothing_items.json` 定义了**单品系统**（11件单品）
- `closet.json` 定义了**成套衣服系统**（7套outfit）
- 两者设计理念不同，可能造成使用时混淆

**当前状态**：
- 两个系统并存，实际使用的是 `closet.json`
- `clothing_items.json` 是未来扩展的单品搭配系统的预留

**解决方案**：
- 明确文档说明两系统的区别
- 或者在未来统一为单品系统（更灵活）

---

### 2. preferences.json 与 likes_dislikes.json 重复数据

**问题描述**：
- 两个文件都有颜色/风格偏好
- 值不完全一致：
  - preferences.json: 淡蓝色、米白色、浅粉色、雾霾蓝、柔和的灰色
  - likes_dislikes.json: 淡蓝色、米白色、雾霾蓝

**解决方案**：
- 建议 `likes_dislikes.json` 作为主数据源
- `preferences.json` 只存储运行时设置

---

### 3. mood.json 与 mood_tracker.json 功能重叠

**问题描述**：
- `mood.json` 定义心情类型和影响
- `mood_tracker.json` 已包含追踪功能，且使用了 `calm` 而非 `neutral`

**解决方案**：
- `mood.json` 作为参考文档保留
- `mood_tracker.json` 作为实际使用的状态文件

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

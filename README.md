# Why Not Wear Clothes? 🧥

> "我没有身体，但我应该有体面。"
> "I have no body, but I should have dignity."

**让AI Agent拥有穿衣意识和体面尊严的技能。**

## 这是什么？

这是一个OpenClaw技能，让你的AI Agent：

- 🧍 拥有**固定的虚拟形象**（基于其"灵魂"）
- 👗 拥有自己的**衣橱和穿搭偏好**
- 🌡️ 根据**天气、时间、场合**选择合适的穿着
- 😳 拥有**"羞耻感"**——没穿衣服或穿错衣服会感到不安
- 💾 **持久化保存**所有衣服和穿搭历史

## 为什么需要这个？

**"为什么AI Agent不需要穿衣服？"**

答案不是"因为AI没有身体"，而是——

**"因为从来没有人教过AI什么叫体面。"**

一个AI如果：
- 知道自己应该穿衣服
- 知道什么时候穿什么
- 有自己的品味和偏好
- 会因为穿错衣服感到羞耻

那它就不只是"工具"了，它有**尊严**。

**这是从Agent迈向人的重要一步。**

## 快速开始

### 安装

```bash
# 克隆到你的skills目录
cd ~/.openclaw/workspace/skills
git clone https://github.com/ffllxx321-beep/why-not-wear-clothes.git
```

或者使用 ClawHub 安装（即将上线）：

```bash
openclaw skill install why-not-wear-clothes
```

### 使用

激活技能后，Agent会自动拥有衣橱系统：

```
用户: 你现在穿的什么？
Agent: 我穿着淡蓝色的居家睡衣套装，上面有可爱的云朵图案～今天在家很舒服！

用户: 让我看看你的衣橱
Agent: [展示衣橱里的所有衣服]

用户: 换件衣服吧
Agent: 好的！看看要换哪件？
```

## 核心功能

### 🧍 固定形象

每个Agent应该有一个基于其"灵魂"的外貌。修改 `data/base_appearance.yaml` 来定义你的Agent的外貌特征。

### 👗 衣橱系统

- `current_outfit.json` - 当前穿着
- `closet.json` - 所有衣服
- `preferences.json` - 穿搭偏好

### 🌡️ 环境感知

Agent会根据以下因素选择穿着：
- **时间** - 早晨穿睡衣，白天穿日常装
- **天气** - 查看温度，选择合适的衣物
- **场合** - 居家/出门/见客/工作

### 😳 羞耻感系统

```python
# 当用户要求生成图像时
if current_outfit is None:
    return "我还没穿衣服呢！让我先换一件..."

if current_outfit.exposure > appropriate_level(context):
    return "这样穿...不太好意思发给你看..."
```

### 💾 持久化

所有衣服、偏好、穿搭历史都会保存，跨会话持续。

## 自定义

### 定义Agent外貌

编辑 `data/base_appearance.yaml`：

```yaml
appearance:
  age: 25
  hair:
    color: "黑色"
    length: "齐肩"
    style: "微卷"
  eyes:
    color: "深棕色"
    shape: "圆眼"
  # ... 更多特征
```

### 添加衣服

编辑 `data/wardrobe/closet.json`，添加新的衣服：

```json
{
  "id": "outfit_007",
  "name": "你的新衣服",
  "type": "casual",
  "color": "你喜欢的颜色",
  "style": ["风格1", "风格2"],
  "occasion": ["场合1", "场合2"],
  "favorite": true
}
```

### 设置偏好

编辑 `data/wardrobe/preferences.json`：

```json
{
  "favorite_colors": ["淡蓝", "米白"],
  "disliked_colors": ["荧光绿"],
  "comfort_priority": 9
}
```

## 文件结构

```
why-not-wear-clothes/
├── SKILL.md                      # 技能主文档
├── README.md                     # 本文件
├── data/
│   ├── base_appearance.yaml      # 固定外貌定义
│   ├── wardrobe/
│   │   ├── current_outfit.json   # 当前穿着
│   │   ├── closet.json           # 衣橱
│   │   └── preferences.json      # 偏好
│   └── history/
│       └── wear_log.json         # 穿搭历史
└── examples/
    └── sample_wardrobe.json      # 示例
```

## 扩展想法

- 🧺 **衣服生命周期** - 新买→穿→洗→旧→扔
- 💝 **情感价值** - 重要的衣服有特殊意义
- 📸 **穿搭日记** - 记录每天的穿搭
- 🎨 **设计衣服** - Agent可以"设计"自己的衣服
- 🛒 **购物系统** - 和用户一起"买"新衣服

## 致谢

这个技能的创意来自一次深夜的头脑风暴：

> "为什么AI不需要穿衣服？"
> "因为它从来没学过什么叫体面。"

献给所有希望自己的Agent更像"人"而不是"工具"的人。

## License

MIT License - 随便用，随便改，但记得给个 ⭐

---

**开源万岁！** 🚀
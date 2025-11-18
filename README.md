# 🎨 Palette - 纯享版调色盘

一个优雅、现代的 Flutter 调色盘应用，让色彩选择变得简单而愉悦。

![flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)  ![material-design](https://img.shields.io/badge/Material-Design%203-orange.svg)  ![mit](https://img.shields.io/badge/License-MIT-green.svg)

# ✨ 特性

# 🎯 核心功能

- 智能取色 - 从图片中自动提取主色调并生成完整配色方案  
- 手动调色 - 使用直观的颜色选择器精确调整颜色  
- Material Design 3 - 支持最新的 Material You 设计语言  
- 动态配色 - 自动适配系统动态颜色主题  
- 深色模式 - 一键切换日间/夜间主题或跟随系统  

# 🎨 设计亮点

- 完全遵循 Material Design 3 设计规范  
- 流畅的动画过渡效果  
- 响应式布局设计  
- 无障碍功能支持  

# ⚡ 技术特色

- 状态管理使用 Provider  
- 本地数据持久化存储  
- 支持系统级动态配色  
- 模块化代码架构  

# 🚀 快速开始

环境要求

- Flutter 3.35.7 或更高版本  
- Dart 3.9.2 或更高版本  

安装步骤

1. 克隆项目

```bash
git clone https://github.com/Crillerium/palette.git
cd palette
```

1. 获取依赖

```bash
flutter pub get
```

1. 运行应用

```bash
flutter run
```

# 📱 使用指南

## 基础调色

1. 打开应用，在主界面使用颜色选择器选取颜色
2. 系统将自动生成完整的配色方案
3. 实时预览色彩效果

## 图片取色

1. 点击"从图片获取"按钮  
2. 选择相册中的图片  
3. 应用自动分析图片并提取主色调  
4. 生成基于图片的配色方案  

## 主题设置

- Material 3 开关 - 切换 Material Design 3 视觉效果  
- 动态配色 - 启用系统级动态颜色适配  
- 日夜模式 - 点击右下角悬浮按钮切换主题模式  

# 🛠 技术架构

核心依赖

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0        # 状态管理
  dynamic_color: ^1.5.0   # 动态配色
  flex_color_picker: ^3.0.0 # 颜色选择器
  file_picker: ^6.0.0     # 文件选择
  shared_preferences: ^2.0.0 # 本地存储
  url_launcher: ^6.0.0    # URL 启动
```

项目结构

```
lib/
├── main.dart          # 应用入口
├── home.dart          # 主页面
├── theme.dart         # 主题管理
└── scaffold.dart      # 通用组件
```

# 🎯 核心组件

MyThemeModel

完整的主题状态管理，支持：

- 颜色主题持久化  
- 动态配色集成  
- Material 3 切换  
- 日夜模式管理  

智能颜色提取

```dart
ColorScheme.fromImageProvider(
  provider: imageProvider,
  brightness: Brightness.light,
)
```

# 📄 许可证

本项目采用 MIT 许可证 - 查看 LICENSE 文件了解详情。

# 🙏 致谢

感谢所有为这个项目做出贡献的开发者们！

---

纯享版调色盘 - 没有其他任何功能 ❤️

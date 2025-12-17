# OpenHarmony 待办事项应用

基于 OpenHarmony 和 ArkTS 开发的待办事项应用。

## 📱 功能特性
- [ ] 添加/删除待办事项
- [ ] 标记任务完成状态
- [ ] 显示任务完成数量 / 总数量

## 🛠️ 技术栈
- OpenHarmony API 12
- ArkTS
- DevEco Studio 5.0.1

```markdown
## 📂 项目结构
Todo-list-based-on-OpenHarmony/
├── AppScope/ # 应用全局配置
│ ├── resources/ # 全局资源
│ └── app.json5 # 应用信息
│
├── entry/ # 主模块
│ └── src/main/
│ ├── ets/ # 业务代码
│ │ ├── entryability/ # 应用入口
│ │ └── pages/ # 页面
│ │ └── Index.ets # 待办首页
│ ├── resources/ # 模块资源
│ └── module.json5 # 模块配置
│
├── build-profile.json5 # 构建配置
├── oh-package.json5 # 依赖管理
└── README.md # 说明文档
```

## 🚀 快速开始
1. 克隆项目
```bash
git clone https://github.com/wewin909/Todo-list-based-on-OpenHarmony.git
使用 DevEco Studio 打开项目
```

2. 连接设备/模拟器

3. 点击运行
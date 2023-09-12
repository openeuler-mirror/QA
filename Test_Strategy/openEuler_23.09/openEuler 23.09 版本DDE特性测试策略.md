![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2023/09/04  |    V1.0         |     测试策略初稿     | 王鹏     |

关键词： 
DDE特性 测试策略

摘要：

本文是openEuler 23.09版本上DDE特性的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| DDE    | Deepin Desktop Environment | 深度桌面环境 |


# 特性描述
DDE（深度桌面环境）是统信自主开发的美观易用、极简操作的桌面环境，主要由桌面、启动器、任务栏、控制中心、窗口管理器等组成，系统中预装了深度特色应用，它既能让您体验到丰富多彩的娱乐生活，也可以满足您的日常工作需要。相信随着功能的不断升级和完善，将会被越来越多的用户所喜爱和使用。

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| 1    | [DDE组件更新支持服务器场景优化](https://gitee.com/openeuler/release-management/issues/I7K7FQ) | Testing | sig-DDE | [@leeffo](https://gitee.com/leeffo) | EPOL     | dde-control-center:控制中心<br/>dde-calendar:日历<br/>dde-clipboard:剪贴板<br/>dde-dock:任务栏<br/>dde-file-manager:文管<br/>dde-introduction:欢迎<br/>dde-kwin:窗管<br/>dde-launcher:启动器<br/>dde-polkit-agent:认证窗口<br/>deepin-devicemanager:设备管理器<br/>deepin-editor:文本编辑器<br/>deepin-font-manager:字体管理器<br/>deepin-image-viewer:看图<br/>deepin-log-viewer:日志收集工具<br/>deepin-reader:阅读器<br/>deepin-system-monitor:系统监视工具<br/>deepin-terminal:终端<br/>deepin-wallpapers:墙纸<br/>deepin-draw:画图<br/>deepin-screen-recorder:截图录屏<br/>deepin-movie:影院<br/>deepin-rpm-installer:rpm软件包安装器 |
| 2 | [增加 utshell 项目发布](https://gitee.com/openeuler/release-management/issues/I7GRO2) | Testing | sig-utshell | [@tong2357](https://gitee.com/tong2357/) | EPOL | utshell |
| 3 | [增加 utsudo 项目发布](https://gitee.com/openeuler/release-management/issues/I7GYQK) | Testing | sig-utsudo | [@ut-wanglujun](https://gitee.com/ut-wanglujun/) | EPOL | utsudo |
| 4 | [增加 migration-tools 项目发布](https://gitee.com/openeuler/release-management/issues/I7HXX2) | Testing | sig-migration-tools | [@xingwei-liu](https://gitee.com/xingwei-liu/) | EPOL | migration-tool |

## 风险项

| 场景描述 | 设计思路 | 测试重点 | 备注 |
| -------- | -------- | -------- | ---- |
|          |          |          |      |

# 特性分层策略
## 总体测试策略
| 需求 | 开发主体 | 测试主体 | 测试分层策略 |
| ------- | ------- | ------- | ---- |
| DDE组件 |  sig-DDE     |  sig-QA      | 继承已有测试能力，验证DDE桌面系统在openEuler版本上主体功能 |
| utshell | sig-utshell | sig-QA | 验证utshell软件能力，支持shell常用指令 |
| utsudo | sig-utsudo | sig-QA | 验证utsudo软件能力，支持sudo常用指令 |
| migration-tools | sig-migration-tools | sig-QA | 验证迁移软件能力，支持centos 系统迁移至openeuler |

## 功能测试
| 功能描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| DDE安装    | 测试DDE的安装 | DDE组件正常安装，图形化方式正常启动 |      |
| 桌面        | 测试桌面功能 | 桌面图标显示、右键菜单功能测试 |      |
| 启动器        | 测试启动器功能      | 启动器显示、打开子应用、全屏模式 |      |
| 控制中心      | 测试控制中心的功能      | 控制中心对DDE和系统的各项设置功能 |      |
| 子应用        | 多个子应用功能测试 | 剪切板、终端、文本编辑器、文档查看器、日历等 |      |
| utshell | 验证utshell软件能力 | 支持shell常用指令 | |
| utsudo | 验证utsudo软件能力 | 支持sudo常用指令 | |
| migration-tools | 验证迁移软件能力 | 支持centos 系统迁移至openeuler | |

### 测试重点

测试阶段2：

1. DDE继承特性的全量验证
2. 新增三个特性的全量验证

测试阶段3：

1.  继承特性/新特性基本功能验证
2.  问题单回归

测试阶段4：

1. 继承特性/新特性基本功能验证
2. 问题单回归

## 可靠性测试

| 场景描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
|         |         |          |      |

## 稳定性测试
| 专项测试类型 | 设计思路 | 测试重点 | 备注 |
| ----------- | ----------- | ----------- | ---- |
|             |             |             |      |

# 特性测试环境描述
| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  虚拟机    | 8G 8U       | KVM虚拟机:ARM版本和X86版本 |

# 特性测试执行策略

## 测试计划
| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
| Test round 2 | 2023/8/31  | 2023/9/6  | 5    | 全量功能测试 |  |
| Test round 3 | 2023/9/7   | 2023/9/13 | 5    | 回归测试 |      |
| Test round 4 | 2023/9/14  | 2023/9/20 | 5    | 回归测试              |      |

# 入口标准
1.  上个阶段无block问题遗留
2.  转测版本的冒烟无阻塞性问题
2.  满足各阶段版本转测检查项

# 出口标准
1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件
无
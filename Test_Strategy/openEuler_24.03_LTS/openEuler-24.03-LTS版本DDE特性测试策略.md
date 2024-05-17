![avatar](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期         | 修订版本     | 修改描述  | 作者  |
|------------| ----------- | -------- |-----|
| 2024/03/05 |    V1.0         |     测试策略初稿     | 孙庆炜 |

关键词： 
DDE特性  测试策略

摘要：

本文是openEuler 24.03 LTS版本上DDE特性的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| DDE    | Deepin Desktop Environment | 深度桌面环境 |


# 特性描述
DDE（深度桌面环境）是统信自主开发的美观易用、极简操作的桌面环境，主要由桌面、启动器、任务栏、控制中心、窗口管理器等组成，系统中预装了深度特色应用，它既能让您体验到丰富多彩的娱乐生活，也可以满足您的日常工作需要。相信随着功能的不断升级和完善，将会被越来越多的用户所喜爱和使用。

## 需求清单
|no| feature                 |status|sig| owner            | 发布方式 | 涉及软件包列表                                                                                                                                                                                                                                                                                                                                                                                                                              |
|:----|:------------------------|:---|:--|:-----------------|:-----|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1    | [DDE组件更新]()             | Discussion | sig-DDE | [@HelloWorld_lvcongqing](https://gitee.com/HelloWorld_lvcongqing/) | EPOL | dde-control-center:控制中心<br/>dde-calendar:日历<br/>dde-clipboard:剪贴板<br/>dde-dock:任务栏<br/>dde-file-manager:文管<br/>dde-launcher:启动器<br/>dde-polkit-agent:认证窗口<br/>deepin-devicemanager:设备管理器<br/>deepin-editor:文本编辑器<br/>deepin-font-manager:字体管理器<br/>deepin-image-viewer:看图<br/>deepin-log-viewer:日志收集工具<br/>deepin-reader:阅读器<br/>deepin-system-monitor:系统监视工具<br/>deepin-terminal:终端<br/>deepin-wallpapers:墙纸<br/>deepin-draw:画图<br/>|
| 2    | [migration-tools增加图形化]()|Discussion|sig-Migration	| [@xingwei-liu](...) | EPOL | migration-tools-server                                                                                                                                                                                                                                                                                                                                                                                                               |
| 3    | [增加 utshell 项目发布]()     |Discussion|sig-memsafety| [@wangmengc](...)| EPOL | utshell                                                                                                                                                                                                                                                                                                                                                                                                                              |
| 4    | [增加 utsudo 项目发布]()      |Discussion|sig-memsafety| [@wangmengc](...) | EPOL | utsudo                                                                                                                                                                                                                                                                                                                                                                                                                               |


## 风险项
# 特性分层策略
## 总体测试策略
| 需求     | 开发主体 | 测试主体 | 测试分层策略                                  |
|--------| ------- | ------- |-----------------------------------------|
| DDE组件  |  sig-DDE     |  sig-QA | 验证DDE桌面系统在openEuler版本上主体功能              |
| migration-tools |  sig-Migration |  sig-QA | 验证migration-tools可迁移centos7系列到openEuler |
| utsudo |  sig-memsafety |  sig-QA | 验证utsudo在openEuler版本上可正常执行sudo基础命令      |
| utshell|  sig-memsafety|  sig-QA | 验证utshell在openEuler版本上可正常执行shell基础命令    |
## 功能测试
| 功能描述             | 设计思路      | 测试重点         | 备注 |
|------------------|-----------|--------------| ---- |
| DDE安装            | 测试DDE的安装  | DDE组件正常安装，图形化方式正常启动 |      |
| 桌面               | 测试桌面功能    | 桌面图标显示、右键菜单功能测试 |      |
| 启动器              | 测试启动器功能   | 启动器显示、打开子应用、全屏模式 |      |
| 控制中心             | 测试控制中心的功能 | 控制中心对DDE和系统的各项设置功能 |      |
| 子应用              | 多个子应用功能测试 | 剪切板、终端、文本编辑器、文档查看器、日历等 |      |
| migration-tools  | 迁移功能测试    | 覆盖命令行与图形化测试  |      |
| utsudo           | 多个子应用功能测试 | 测试sudo基础命令   |      |
| utshell          | 多个子应用功能测试 | 测试shell基础命令  |      |
## 可靠性测试
| 场景描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
|         |         |          |      |

## 稳定性测试
| 专项测试类型 | 设计思路 | 测试重点 | 备注 |
| ----------- | ----------- | ----------- | ---- |
|             |             |             |      |

# 特性测试环境描述
| 硬件型号 | 硬件配置信息 | 备注             |
| -------- | ------------ |----------------|
|  虚拟机    | 8G 8U       | KVM虚拟机:ARM、X86 |

# 特性测试执行策略

## 测试计划
| Stange name  | Begin time | End time   | Days | 测试执行策略                                           | 备注   |
|:-------------|:-----------|:-----------|------|--------------------------------------------------| ------ |
| Test round 1 | 2024-04-03 | 2024-04-09 | 4    | DDE、utshell、utsudo基本功能测试<br/>migration-tools功能测试 |      |
| Test round 2 | 2024-04-20 | 2024-04-26 | 5    | DDE、utshell、utsudo全量功能测试                         |      |
| Test round 3 | 2024-04-30 | 2024-05-06 | 2    | 回归测试                                             |      |
| Test round 4 | 2023-05-07 | 2023-05-13 | 5    | 回归测试                                             |     |
| Test round 5 | 2023-05-14 | 2023-05-20 | 5    | 回归测试                                             |     |
# 入口标准
1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

# 出口标准
1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件
无
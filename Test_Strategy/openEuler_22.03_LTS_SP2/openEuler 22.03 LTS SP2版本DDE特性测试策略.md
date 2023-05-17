![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2023/05/17  |    V1.0         |     测试策略初稿     | 王鹏     |

关键词： 
DDE特性  测试策略

摘要：

本文是openEuler 22.03 LTS SP2版本上DDE特性的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| DDE    | Deepin Desktop Environment | 深度桌面环境 |


# 特性描述
DDE（深度桌面环境）是统信自主开发的美观易用、极简操作的桌面环境，主要由桌面、启动器、任务栏、控制中心、窗口管理器等组成，系统中预装了深度特色应用，它既能让您体验到丰富多彩的娱乐生活，也可以满足您的日常工作需要。相信随着功能的不断升级和完善，将会被越来越多的用户所喜爱和使用。

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| 1    | [DDE组件更新]() | Discussion | sig-DDE | [@HelloWorld_lvcongqing](https://gitee.com/HelloWorld_lvcongqing/) | EPOL     | dde-api<br/>dde-calendar<br/>dde-clipboard<br/>dde-control-center<br/>dde-daemon<br/>dde-device-formatter<br/>dde-dock<br/>dde-file-manager<br/>dde-launcher<br/>dde-network-utils<br/>dde-polkit-agent<br/>dde-qt-dbus-factory<br/>dde-server-industry-config<br/>dde-session-shell<br/>dde-session-ui<br/>deepin-anything<br/>deepin-compressor<br/>deepin-default-settings<br/>deepin-desktop-base<br/>deepin-desktop-schemas<br/>deepin-devicemanager<br/>deepin-editor<br/>deepin-gtk-theme<br/>deepin-icon-theme<br/>deepin-log-viewer<br/>deepin-manual<br/>deepin-pw-check<br/>deepin-system-monitor<br/>deepin-terminal<br/>dtkcore<br/>dtkgui<br/>dtkwidget<br/>dtkcommon<br/>qt5dxcb-plugin<br/>qt5integration<br/>udisks2-qt5 |

## 风险项
# 特性分层策略
## 总体测试策略
| 需求 | 开发主体 | 测试主体 | 测试分层策略 |
| ------- | ------- | ------- | ---- |
| DDE组件 |  sig-DDE     |  sig-QA      | 验证DDE桌面系统在openEuler版本上主体功能 |

## 功能测试
| 功能描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| DDE安装    | 测试DDE的安装 | DDE组件正常安装，图形化方式正常启动 |      |
| 桌面        | 测试桌面功能 | 桌面图标显示、右键菜单功能测试 |      |
| 启动器        | 测试启动器功能      | 启动器显示、打开子应用、全屏模式 |      |
| 控制中心      | 测试控制中心的功能      | 控制中心对DDE和系统的各项设置功能 |      |
| 子应用        | 多个子应用功能测试 | 剪切板、终端、文本编辑器、文档查看器、日历等 |      |

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
| Test round 3 | 2023-06-03 | 2023-06-09 | 7    | DDE安装及基本功能测试 |      |
| Test round 4 | 2023-06-10 | 2023-06-16 | 7    | 全量功能测试          |      |
| Test round 5 | 2023-06-17 | 2023-06-23 | 7    | 回归测试              |      |
| Test round 6 | 2023-06-24 | 2023-06-30 | 7    | 回归测试              |     |

# 入口标准
1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

# 出口标准
1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件
无
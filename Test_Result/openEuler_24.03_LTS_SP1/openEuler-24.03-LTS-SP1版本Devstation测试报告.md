 


![img](https://gitee.com/openeuler/QA/raw/79f0d49e58e0684367b8f53e9d866a01be93c4c6/images/openEuler.png)

您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|  2024.11.28    |  openEuler-24.03-LTS-SP1-Devstaion           | 测试报告初版 |李萍|

关键词： Devstaion

摘要：这份Devstation测试报告主要涉及功能和用户体验方面的测试。报告指出，大部分功能问题已经得到解决，但仍存在一些用户使用体验方面的遗留问题。此外，报告还提到了Devstation中融合了Eulercopilot、epkg、x2openEuler的部分功能，并对其进行了功能和用户体验方面的测试。


缩略语清单：

| 缩略语 | 英文全名       | 中文解释 |
| ------ | -------------- | -------- |
| OS     | operate system | 操作系统 |

# 1     特性概述

描述特性提供的基本能力

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP1-Devstaion |  2024.11.28            |  2024.11.28            |

描述特性测试的硬件环境信息

| 硬件 | 虚拟机平台 | 备注 |
| -------- | ------------ | ---- |
| 个人PC | Hyper-V | x86_64 |
| 个人PC | VMware workstation | x86_64 |
| 鲲鹏服务器 | qemu | aarch64 |

# 3     测试结论概述

## 3.1   测试整体结论

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 自研安装部署支持自定义软件包选择 | 支持     |
| 功能测试 | 自研安装部署支持系统分区 | 支持     |
| 功能测试 | 自研安装部署用户密码设置 | 支持     |
| 功能测试 | 自研安装部署支持时区选择 | 支持     |
| 功能测试 | 支持openEuler镜像制作，用于安装启动 | 支持     |
| 功能测试 | DevStaion支持epkg和eulermaker本地开发环境 | 支持安装     |
| 功能测试 | 内置epkg和eulermaker客户端 | 支持安装    |
| 功能测试 | DevStaion支持x2openEuler | 支持安装     |
| 功能测试 | DevStaion版本新增x2openEuler桌面应用 | 支持安装     |
| 功能测试 | DevStaion版本需要继承x2openEuler工具，并且完成自动安装 | 支持安装     |
| 兼容性测试 | DevStaion版本支持图形化编程环境 | 支持     |
| 兼容性测试 | 鲲鹏+openEuler平台支持kvm虚拟化 | 支持     |
| 兼容性测试 | X86+windows平台支持VMware workstation plays虚拟机 | 支持     |


## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 影响分析 | 措施 |
| --- | ------- | ------ | ------- | ------- |
| 1 | https://gitee.com/src-openeuler/calamares/issues/IAXQXG?from=project-issue | 安装时语言是中文，但地区选择仍然是英文 | 用户体验问题 | 已解决 |
| 2 | https://gitee.com/src-openeuler/calamares/issues/IAXVTV?from=project-issue | 安装时在用户设置界面不显示光标 | 用户体验问题 | 已解决 |
| 3 | https://gitee.com/src-openeuler/calamares/issues/IAXVVP?from=project-issue | 安装时可以添加一个查看具体密码的选项 | 用户体验问题 | 已解决 |
| 4 | https://gitee.com/src-openeuler/calamares/issues/IB0D96?from=project-issue | 不询问密码自动登录选项好像没生效 | 用户体验问题 | 后续解决 |
| 5 | https://gitee.com/src-openeuler/calamares/issues/IB0D9T?from=project-issue | 切换root用户之后为什么开头不显示root名字  | 用户体验问题 | 后续解决 |
| 6 | https://gitee.com/src-openeuler/calamares/issues/IB0MME?from=project-issue | 默认加入中文输入法  | 用户体验问题 | 后续解决 |
| 7 | https://gitee.com/src-openeuler/calamares/issues/IB0N7P?from=project-issue | eulercopilot设置API Key增加显示明文选项 | 用户体验问题 | 已解决 |
| 8 | https://gitee.com/src-openeuler/calamares/issues/IB0N9J?from=project-issue | eulercopilot-cli配置错误API KEY之后，没有明确去哪里修改API KEY | 用户体验问题 | 已解决 |
| 9 | https://gitee.com/src-openeuler/calamares/issues/IB8370?from=project-issue | 安装环境为arm物理机，选择自动分区，无法安装正式devstation | 严重问题 | 后续解决 |
| 10 | https://gitee.com/src-openeuler/calamares/issues/IB89O1?from=project-issue | DevStation安装失败，场景为物理机上已有LVM2分区 | 主要问题 | 后续解决 |
| 11 | https://gitee.com/src-openeuler/calamares/issues/IB839Z?from=project-issue | 校验模块时间过长，需要分析 | 用户体验问题 | 后续解决 |
| 12 |  | U盘启动失败 | 严重问题 | 后续解决 |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 24 | 0 | 6 | 12 | 4 |
| 百分比 | 100% | 0 | 25% | 50% | 16% |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1 |自研安装部署支持自定义软件包选择 | <font color=green>■</font> |   |
|2 |自研安装部署支持系统分区 | <font color=green>■</font> |   |
|3 |自研安装部署用户密码设置 | <font color=green>■</font> |   |
|4 |自研安装部署支持时区选择 | <font color=green>■</font> |   |
|5 |支持openEuler镜像制作，用于安装启动 | <font color=green>■</font> |   |
|6 |DevStaion支持epkg和eulermaker本地开发环境 |  | epkg安装时需要rpm --import public.gpg.key easywoftwawre缺少eulermaker |
|7 |内置epkg和eulermaker客户端 |  | 无  |
|8 |DevStaion支持x2openEuler |  | 安装时需要rpm --import public.gpg.key  |
|9 |DevStaion版本新增x2openEuler桌面应用 |  | 无 |
|10 |DevStaion版本需要继承x2openEuler工具，并且完成自动安装 |  | 暂时无法安装x2openEuler，原因如8  |
| | | <font color=blue>▲</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| | | <font color=red>●</font> |   |
| | | <font color=blue>▲</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1 |DevStaion版本支持图形化编程环境 | <font color=green>■</font>  |   |
|2 |鲲鹏+openEuler平台支持kvm虚拟化 |  | 暂时未测试  |
|3 |X86+windows平台支持VMware workstation plays虚拟机 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好
## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

暂不涉及

### 4.3.2 可靠性/韧性测试结论

暂不涉及

### 4.3.3 安全测试结论

暂不涉及

## 4.4 资料测试结论
*建议附加资料PR链接*
https://gitee.com/openeuler/docs/pulls/14259      

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|  文档测试  |   安装文档进行安装     |    按照文档，能顺利安装成功     |

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 用户体验测试 | Devstation用户体验 | 基本可用，遗留部分问题 |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler24.03-LTS-SP1 | 119 | Pass | 18 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

无
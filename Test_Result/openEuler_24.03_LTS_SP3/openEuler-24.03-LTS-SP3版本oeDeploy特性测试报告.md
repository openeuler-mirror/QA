![img](https://gitee.com/openeuler/QA/raw/79f0d49e58e0684367b8f53e9d866a01be93c4c6/images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者                   |
| ---------- | ----------- | -------- | ---------------------- |
| 2025.12.09 | 1.0         | 初稿     | 丁嘉辉 dingjiahuichina |

关键词：oeDeploy，部署，Agent，CANN，昇腾，NPU，驱动

摘要：本测试报告主要涉及对oeDeploy工具和三个新增oeDeploy部署插件的测试，以及在DevStation和DevStore上的部署测试。



# 1     特性概述

本特性包含三个oeDeploy插件（发布在软件所）：

- agent_env：快速安装主流AI Agent环境依赖。DevStation预埋需求，后续版本会支持几种主流AI Agent通过A2A协议融合到小助手PolyMind，同时提供AI Agent脚手架的功能，因此需要管理这些Agent运行的依赖。
- cann-toolkit：快速安装CANN的开发套件，包括Kernels算子包、NNAL神经网络加速库、NNAE神经网络加速引擎、NNRT神经网络运行时环境。
- ascend-driver-manager：快速安装昇腾NPU驱动和固件（310p/910b）。

关联的特性：

- oeDeploy工具：命令行操作、插件源管理，都是历史特性。
- DevStore软件商店：识别oeDeploy插件，支持可视化部署，历史特性为主，也包含一些新增的优化特性。



# 2     特性测试信息

被测试对象本身不在LTS版本返回内，关联特性涉及如下软件包：

| 软件版本名称                | 测试起始时间 | 测试结束时间 |
| --------------------------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP3-RC5 | 2025.11.24   | 2025.11.29   |
| openEuler-24.03-LTS-SP3-RC6 | 2025.12.01   | 2025.12.06   |

描述特性测试的硬件环境信息

| 硬件型号                              | 硬件配置信息    | 备注               |
| ------------------------------------- | --------------- | ------------------ |
| 华为云虚拟机 openEuler 24.03 SP3      | x86_64 4U8G80G  |                    |
| 华为云虚拟机 openEuler 24.03 SP3      | aarch64 4U8G80G |                    |
| 华为云虚拟机 DevStation 24.03 SP3     | x86_64 4U8G80G  | DevStation联合测试 |
| 华为云虚拟机 DevStation 24.03 SP3     | aarch64 4U8G80G | DevStation联合测试 |
| 鲲鹏物理机 openEuler 24.03 + 310p     | aarch64         | 驱动安装测试       |
| 鲲鹏物理机 openEuler 22.03 SP4 + 910b | aarch64         | 驱动安装测试       |



# 3     测试结论概述

## 3.1   测试整体结论

共计执行114个用例，覆盖功能、可靠性、性能、安全、兼容性等测试。新增的三个oeDeploy未发现问题，关联特性共发现4个问题，均已修复，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 测试通过，oeDeploy工具与DevStore功能正常，无任何劣化， |
| 功能测试 | 新增特性测试 | 测试通过，预期功能全部实现 |
| 兼容性测试 | 跨OS版本测试 | 测试通过，在 24.03sp2 和 25.09 版本上运行正常（除了驱动安装外） |
| DFX专项测试 | 性能测试 | 测试通过，性能符合预期（部署时长<30min） |
| DFX专项测试 | 可靠性/韧性测试 | 测试通过，压力测试下功能正常 |
| DFX专项测试 | 安全测试 | 测试通过，在配置文件中构造危险输入无异常、无敏感信息泄露 |
| 资料测试 |         | 不涉及 |
| 其他测试 |         | 不涉及 |

## 3.2   约束说明

节点规格大于4U8G80G。驱动安装仅测试NPU支持的OS版本。涉及下载网络资源的场景中，网络带宽不低于50M。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题。

### 3.3.2 问题统计

测试过程中一共发现4个问题，均为DevStore的历史继承特性和新增优化特性，已全部修复。

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 4        | 0    | 2    | 2    | 0      |
| 百分比 | 100%     | 0    | 50%  | 50%  | 0      |



# 4     详细测试结论

## 4.1 功能测试
### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | oeDeploy命令行工具、插件源管理 | <font color=green>■</font> |  |
| 2 | DevStore的oeDeploy可视化部署、MCP快速添加 | <font color=green>■</font> | 发现3个问题，已全部闭环。 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | agent_env部署插件：pyautogen, langchain, openai等共计8种主流的AI Agent环境一键配置，自带的测试用例执行通过。 | <font color=green>■</font> |   |
| 2 | cann-toolkit部署插件：快速安装CANN的开发套件，包括Kernels算子包、NNAL神经网络加速库、NNAE神经网络加速引擎、NNRT神经网络运行时环境。 | <font color=green>■</font> | 发现一个DevStore相关问题，已经闭环。 |
| 3 | ascend-driver-manager部署插件：快速安装昇腾NPU驱动和固件（310p/910b） | <font color=green>■</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

在 24.03sp2 和 25.09 版本的 DevStation 平台（x86_64和aarch64）上测试了除了驱动安装之外的所有特性，未发现兼容性问题。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 序号 | 组件/特性名称                                                |        特性质量评估        | 备注                                                         |
| ---- | ------------------------------------------------------------ | :------------------------: | ------------------------------------------------------------ |
| 1    | agent_env部署插件：任意AI Agent框架的环境配置时间<30min      | <font color=green>■</font> | 实际最长用时约12min（个别Agent框架的依赖很厚重，需要下载很多文件） |
| 2    | cann-toolkit部署插件：典型场景下（非全量）CANN配置时间<30min | <font color=green>■</font> | 实际全量部署用时19min                                        |
| 3    | ascend-driver-manager部署插件：任意驱动安装时间<30min        | <font color=green>■</font> | 实际最长用时约70s                                            |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.2 可靠性/韧性测试结论

| 序号 | 组件/特性名称                                                |        特性质量评估        | 备注 |
| ---- | ------------------------------------------------------------ | :------------------------: | ---- |
| 1    | 通过脚本，反复执行三个oeDeploy插件的安装卸载操作，过程中不应出现异常 | <font color=green>■</font> |      |
| 2    | 通过DevStore软件商店，手动点击，反复执行三个oeDeploy插件的安装卸载操作，过程中不应出现异常 | <font color=green>■</font> |      |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.3 安全测试结论

| 序号 | 组件/特性名称                                                |        特性质量评估        | 备注 |
| ---- | ------------------------------------------------------------ | :------------------------: | ---- |
| 1    | 在oeDeploy插件的入参/配置文件的数值中，填入一些常见的危险关键词（单引号、双引号、分号、半括号，'; DROP TABLE users; --，admin'--，\<script\>alert('XSS')\</script\>，javascript:alert('XSS')，; whoami，; cat /etc/passwd，file:///etc/passwd，等等）。识别错误，终止部署，不允许出现OS或者程序奔溃的情况。 | <font color=green>■</font> |      |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好



# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果    | 发现问题单数 |
| :------- | ---------- | --------------- | ------------ |
| RC5      | 78         | 74 pass 4 fail  | 2            |
| RC6      | 114        | 110 pass 4 fail | 2            |

##  5.2   问题记录

| 链接                                               | 问题描述                                                     | 严重程度 | 状态   |
| -------------------------------------------------- | ------------------------------------------------------------ | -------- | ------ |
| https://gitee.com/openeuler/DevStore/issues/ID92NB | 解析oeDeploy插件源没有处理同名同版本的情况，会导致解析数据为空 | 主要     | 已修复 |
| https://gitee.com/openeuler/DevStore/issues/ID9U1H | 检索页与详情页都存在海量日志                                 | 次要     | 已修复 |
| https://gitee.com/openeuler/DevStore/issues/ID9YFE | 写入PolyMind的MCP配置不生效，需设定默认参数                  | 主要     | 已修复 |
| https://gitee.com/openeuler/DevStore/issues/ID9YFI | MCP快速添加列表中存在未安装的软件                            | 次要     | 已修复 |


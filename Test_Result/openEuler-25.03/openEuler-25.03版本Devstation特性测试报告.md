![avatar](../../images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025.03.25 |   1.0   |   初始        |  yangshicheng     |


关键词： devstation  

摘要：

文本主要描述devstation openEuler-25.03版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。 按照测试策略，对devstation项目下的新需求功能、文档以及易用性进行测试。


# 1     特性概述

devstation是openEuler首个面向开发者的开发者工作站，预安装vscodium，大幅提升开发者效率；预安装oeDeploy、epkg、eulercopilot等功能，并且将打通部署、编码、编译、构建发布全流程，开发者可以方便的使用oeDeploy完成AI软件栈、云原生软件栈部署，使用oeDevPlugin插件进行一键拉取代码仓，创建社区PR、查看所提issue等操作，进一步提高社区生态的开发能力。本次新增epkg、eulercopilot、oeDeploy默认集成，支持DevKit，支持开发过程常用软件，社区集成开发环境，vscode集成开发环境，南向支持裸机部署等六大特性。

## 1.1 新增特性功能

### epkg、eulercopilot、oeDeploy默认集成
- oeDeploy默认集成
- eulercopilot默认集成
- epkg默认集成

### 支持DevKit
- 支持DevKit

### 支持开发过程常用软件
- 支持开发过程常用软件

### 社区集成开发环境
- 社区集成开发环境

### vscode集成开发环境
- vscode集成开发环境

### 南向支持裸机部署
- 南向支持裸机部署


# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| devstation 25.03 RC3    |    2025-02-28    |  2025-03-07      |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  笔记本               |      物理机     |      联想 E16 / 联想 R7000  / 华硕 天选4锐龙版 / 惠普 星14 锐龙版   |
|  Taishan 2280        |      物理机     |       kupeng 920                  |



# 3     测试结论概述

## 3.1   测试整体结论

devstation共执行用例67条，主要覆盖epkg、eulercopilot、oeDeploy默认集成，支持DevKit，支持开发过程常用软件，社区集成开发环境，vscode集成开发环境，南向支持裸机部署等功能性测试、兼容性测试、资料测试，共发现问题14个，发现问题已解决，回归通过，无遗留风险，整体质量良好；

| 测试活动    | 测试子项        | 活动评价 |
| ----------- | --------------- | -------- |
| 功能测试    | 新增特性测试      |  质量良好     |
| 兼容性测试  |  架构兼容性测试   |   质量良好       |
| DFX专项测试 | 性能测试         |   不涉及    |
| DFX专项测试 | 可靠性/韧性测试   |  不涉及 |
| DFX专项测试 | 安全测试         |   不涉及       |
| 资料测试    |                 |  质量良好 |
| 其他测试    |                 |          |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |    14      |   0   |   11   |  3     |   0     |
| 百分比 |    100%    |   0  |    79%  |  21%    |   0     |

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 新增特性测试结论

| 序号 | 组件/特性名称 |        特性质量评估        | 备注 |
| ---- | ------------- | :------------------------: | ---- |
|  1   |    epkg、eulercopilot、oeDeploy默认集成           | <font color=green>■</font> |      |
|  2   |    支持DevKit                                     | <font color=green>■</font>  |      |
|  3   |    支持开发过程常用软件                             | <font color=green>■</font>  |      |
|  4   |    社区集成开发环境                                 | <font color=green>■</font>  |      |
|  5   |    vscode集成开发环境                               | <font color=green>■</font>  |      |
|  6   |    南向支持裸机部署                                  | <font color=green>■</font>  |      |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好



## 4.2 兼容性测试结论

*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

| 测试活动  | 活动评价                                 |
| -------- | -----------------------------------------|
| 功能测试    | 功能测试符合预期，所有命令的基本功能正常    |
| 兼容性测试  | 在不同架构上测试架构兼容性，整体功能正常、整体质量良好    |
| 文档测试    | 文档描述准确，信息可访问性一致，内容完整，易读性高 |


## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

无

### 4.3.2 可靠性/韧性测试结论

无


## 4.4 资料测试结论
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| -------- | -------- | -------- |
|   devstation裸机部署指南和一键式部署DeepSeek指导文档 | https://gitee.com/openeuler/docs/pulls/14697 |   测试通过，质量良好       |



## 4.5 其他测试结论

无

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|  devstation 25.03 RC3        |     67       |     succeed         |       14       |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 
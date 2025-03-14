![avatar](../../images/openEuler.png)


版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2024-05-15 | 1.0 | 创建 | 黄宏帅 |


关键词： mica、混合部署

摘要：
本报告主要描述基于openEuler 24.03-LTS版本进行的mica混合部署框架功能特性的测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|    |         |      |


# 1     特性概述

本次报告验证三个功能特性：1. MICA框架功能支持完善：提供简单的命令行工具，支持创建、启动、停止 RTOS，支持通过配置文件管理实时OS，实现 RTOS 的开机自启动；2. 混合部署可靠性增强：Linux 的 mica 进程崩溃后，能够不影响 RTOS 运行，重新拉起 MICA 后可以恢复通信链路；3. 支持多实例部署：支持通过 Linux 部署多个 RTOS

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|openEuler-24.03-LTS| 2024-05-14 | 2024-05-18 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  树莓派4B       |  CPU:BCM2711(Cortex-A72 * 4)<br> 内存：8G<br>存储设备：SanDisk Ultra 64GB micro SD |      |
|   qemu       |   CPU:Cortex-A57<br>最小启动内存：512M|      |

# 3     测试结论概述

## 3.1   测试整体结论

MICA框架功能支持完善特性，共计执行1个用例，主要覆盖了功能测试，整体质量良好。
混合部署可靠性增强特性，共计执行1个用例，主要覆盖了功能测试，整体质量良好。
支持多实例部署特性，共计执行1个用例，主要覆盖了功能测试，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 新增特性测试| MICA框架功能支持完善 |  良好    |
| 新增特性测试 | 混合部署可靠性增强特性 |  良好    |
| 新增特性测试 | 支持多实例部署特性 |  良好    |


## 3.2   约束说明

1、支持多实例部署特性：每个实例必须要有不同的启动地址，并且不同实例的内存地址空间需要用户保证不能重复

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- | 
|     |         |        |         |         |         |            |


### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |          |      |      |      |        |
| 百分比 |          |      |      |      |        |

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |


### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1|isula启动嵌入式镜像 | <font color=red>■</font> |   |


<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|         |         |        |         |

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

## 4.4 资料测试结论
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|   openEuler-24.03-LTS       |      3      |      Pass        |        0      |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*


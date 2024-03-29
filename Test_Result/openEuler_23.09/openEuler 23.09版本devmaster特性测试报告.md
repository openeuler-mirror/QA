![openEuler ico](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期      | 修订   版本 | 修改描述                | 作者   |
| --------- | ----------- | ----------------------- | ------ |
| 2023/9/25 | v1.0        | 添加devmaster特性测试报告 | 史冬冬 |

关键词： devmaster 设备管理

摘要：
devmaster作为sysmaster的设备管理模块，采用了机制与策略分离的设计思想，提供了优秀的灵活性和可扩展能力，另一方面devmaster设计并实现了一套并发处理框架，可以有效地利用多核CPU的硬件计算能力
依据测试要求，对devmaster特性进行接口测试、功能测试、组合场景测试。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释  |
| ------ | -------- | --------- |
|        |          |           |

# 1     特性概述

devmaster通过监听内核上报的uevent事件来感知设备的动作，从而在设备热插拔、格式化、写文件系统等操作后能及时发现并更新设备的相关信息。devmaster实现了一套规则机制，用户可以根据业务需求编写定制化、模块化的设备处理规则，从而避免策略硬编码的问题，提高devmaster在使用过程中的灵活性和可扩展性。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括以来的硬件。

| 版本名称  | 测试起始时间 | 测试结束时间 |
| --------- | ------------ | ------------ |
| rc2 | 2023/8/30  | 2023/9/4    |
| rc3 | 2023/9/7   | 2023/9/12   |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | -----|
| kvm      |  无特殊配置  |      |

# 3     测试结论概述

## 3.1   测试整体结论

devmaster特性，共计执行24个场景，61个用例，主要覆盖了接口测试、功能测试。重点关注udev时间的配置，监测和上报。

经过两轮测试，未发现问题，整体质量良好。

| 测试活动     | 活动评价                                                                                                                                                                                                                                                                                                                                                                              |
| ------------ | ------------ |
| 功能接口测试 | 配置检测规则，包含正常值，异常值。规则匹配操作等 |
| 场景测试 | 监听事件功能，上报事件功能等 |
                                                                                                                                                                                                                                                                              
## 3.2   约束说明

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|          |          |          |                    |          |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 0        | 0    | 0    | 0    |        |
| 百分比 |          | 0%   | 0%   | 0%   |        |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称    | 测试用例数 | 用例执行结果     | 发现问题单数 |
| ----------- | ---------- | ---------------- | ------------ |
|  rc2 - rc3  | 61        | 通过61个，失败0个 | 0            |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*


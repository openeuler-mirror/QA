![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期        | 修订   版本 | 修改描述 | 作者 |
| ----       | ----------- | -------- | ---- |
| 2022/10/08 |   v1.0      | GCC兼容性测试报告 | 王丹 |


摘要：依据测试要求，对GCC编译器兼容性进行基础功能测试



# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| 930 RC5 | 2022-09-19 | 2022-09-30 |

描述特性测试的硬件环境信息

| OS | 硬件型号 | 硬件配置信息 | 备注 |
| -------- | -------- | ------------ | ---- |
|openEuler 22.03-LTS | TaiShan 200 | 128U 512G | aarch64 |
|openEuler 20.03-LTS SP3 | TaiShan 200 | 128U 512G | aarch64 |
|CentOS 7.6 | TaiShan 2280 V2 | 96U 334G | aarch64 |
|Ubuntu 18.04 |  | 96U 1056G | aarch64 |
|Ubuntu 20.04 |  | 128U 128G | aarch64 |
|麒麟V10 |TaiShan 200(Model 2280)  | 128U 128G | aarch64 |
|UOS20 |  | 12U 16G | aarch64 |

# 3     测试结论概述

## 3.1   测试整体结论

GCC编译器兼容性测试，共测试7个OS，主要覆盖基本功能测试。整体质量良好。

|测试OS| 测试活动 | 活动评价 |
| -------- | -------- | -------- |
| openEuler 22.03-LTS | dejanu、llvm、自动反馈优化 |无兼容性问题；|
| openEuler 20.03-LTS SP3 | dejanu、super、自动反馈优化 |无兼容性问题；|
| CentOS 7.6 | dejanu、super、自动反馈优化 |无兼容性问题；|
| Ubuntu 18.04 | dejanu、super、llvm |无兼容性问题；|
| Ubuntu 20.04 | dejanu、super、llvm |无兼容性问题；|
| 麒麟V10 | dejanu、super、llvm |无兼容性问题；|
| UOS20 | dejanu、super、llvm |无兼容性问题；|


## 3.2  约束说明

无

## 3.3  问题分析
openEuler GCC10.3兼容性测试共发现问题0个

### 3.3.1 遗留问题影响以及规避措施
无

### 3.3.2 问题统计
无

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |   备注 |
| -------- | ---------- | ------------ | ------------ | -------- |
| 930 RC5  | 10w+ | 无兼容性问题 | 0   |   |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议


# 5     附件

*无*

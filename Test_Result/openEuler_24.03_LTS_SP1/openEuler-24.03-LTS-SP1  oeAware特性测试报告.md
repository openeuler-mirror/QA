![avatar](../../images/openEuler.png)


版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者        |
| ---------- | ----------- | -------- | ----------- |
| 2024-12-10 | 1.0         | 创建     | zhaolichang |

关键词： 
oeAware

摘要：
本报告主要描述基于openEuler 24.03 LTS SP1版本和openEuler 22.03 LTS SP4版本进行的oeAware特性的测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。

# 1     特性概述

当前版本oeAware特性包括：
1. 提供SDK，第三方可以和服务进行对接，订阅和发布数据；
2. 新增采集插件（PMU事件补齐、系统信息采集等）、调优插件（内核参数调优、stealtask等）、评估推荐模块；

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                | 测试起始时间 | 测试结束时间 |
| ----------------------- | ------------ | ------------ |
| openEuler 24.03 LTS SP1 | 2024-11-20   | 2024-12-10   |
| openEuler 22.03 LTS SP4 | 2024-11-20   | 2024-12-10   |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| NA       | NA           | NA   |

# 3     测试结论概述

## 3.1   测试整体结论

共计执行47个测试用例，主要覆盖了功能测试、性能与异常场景测试，发现问题均已修复并回归通过，无风险，整体质量良好。

| 测试活动       | 测试子项     | 活动评价         |
| -------------- | ------------ | ---------------- |
| 功能测试       | 继承特性测试 | 无风险，质量良好 |
| 功能测试       | 新增特性测试 | 无风险，质量良好 |
| 性能与异常测试 |              | 无风险，质量良好 |

## 3.2   约束说明

无

## 3.3   遗留问题分析

无遗留问题

### 3.3.2 问题统计

无

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

| 序号 | 测试项          |        特性质量评估        | 备注 |
| ---- | ------------------ | :------------------------: | ---- |
| 1    | 继承插件功能测试 | <font color=green>■</font> |      |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 测试项           | 测试方法                             |        特性质量评估        |
| ---- | ---------------- | ------------------------------------ | :------------------------: |
| 1    | SDK功能测试      | 订阅、发布等功能，多个SDK同时接入    | <font color=green>■</font> |
| 2    | 客户端测试       | 加载、使能、移除、查询插件，评估模式 | <font color=green>■</font> |
| 3    | 服务端测试       | 使用systemd相关命令控制oeAware       | <font color=green>■</font> |
| 4    | 采集插件功能测试 | 使能对应的采集插件，对比手动采集结果 | <font color=green>■</font> |
| 5    | 调优插件功能测试 | 使能调优插件，查看使能情况           | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 性能与异常测试结论

| 序号 | 测试项 | 测试方法 | 测试结论 |
| ---- | ------ | -------- | -------- |
| 1    | 性能测试 | 使能调优插件，对比nginx等调优前后的性能 | 无风险，质量良好 |
| 2    | 异常场景测试 | 构造SDK、插件订阅中输入异常参数等异常场景 | 无风险，质量良好 |
| 3 | 日志测试 | 观察关键步骤是否有明确日志记录 | 无风险，质量良好 |

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| :-- | :--------- | :-- | :-- |
| openEuler 24.03 LTS SP1 | 47 | Paas | 34 |
| openEuler 22.03 LTS SP4 | 47 | Paas | 34 |

## 5.2   后续测试建议

无

# 5     附件

无

 



 

 
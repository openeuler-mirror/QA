![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2024-04-22|初稿|gala-gopher 测试报告|毛金涛|
|      |             |          |      |

关键词： gala-gopher

摘要：


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

gala是一款C/S架构、基于AI的操作系统亚健康诊断工具。其基于eBPF + java agent无侵入观测技术，并以AI技术辅助，实现亚健康故障（比如性能抖动、错误率提升、系统卡顿等问题现象）分钟级诊断，简化IT基础设施的运维过程。
gala在openEuler等Linux环境主要面向场景包括数据库、分布式存储、虚拟化、云原生等场景。助力金融、电信、互联网等行业客户在全栈可观测的基础上实现亚健康故障分钟级诊断。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|openEuler-22.03-LTS-SP3|2024-04-20|2024-04-24|

# 3     测试结论概述

## 3.1   测试整体结论

本特性，共计执行22个用例，主要覆盖了功能测试，遗留风险小，整体质量良好。

| 测试活动 | 测试子项                              | 活动评价 |
| -------- | ------------------------------------- | -------- |
| 功能测试 | oe_test_galagopher_all_probe          | pass     |
| 功能测试 | oe_test_galagopher_all_probe_running  | pass     |
| 功能测试 | oe_test_galagopher_cmd_injection      | pass     |
| 功能测试 | oe_test_galagopher_conf_file          | pass     |
| 功能测试 | oe_test_galagopher_conf_file_ssl      | pass     |
| 功能测试 | oe_test_galagopher_configs_cmd        | pass     |
| 功能测试 | oe_test_galagopher_configs_snoopers   | pass     |
| 功能测试 | oe_test_galagopher_endpoint_redis     | pass     |
| 功能测试 | oe_test_galagopher_endpoint_tcp       | pass     |
| 功能测试 | oe_test_galagopher_endpoint_udp       | pass     |
| 功能测试 | oe_test_galagopher_guassdb            | pass     |
| 功能测试 | oe_test_galagopher_ioprobe            | pass     |
| 功能测试 | oe_test_galagopher_jvmprobe           | pass     |
| 功能测试 | oe_test_galagopher_l7probe_redis_http | pass     |
| 功能测试 | oe_test_galagopher_redis              | pass     |
| 功能测试 | oe_test_galagopher_stackprobe         | pass     |
| 功能测试 | oe_test_galagopher_system_info        | pass     |
| 功能测试 | oe_test_galagopher_tcpprobe           | pass     |
| 功能测试 | oe_test_galagopher_tcpprobe_probe     | pass     |
| 功能测试 | oe_test_galagopher_tcpprobe_redis     | pass     |
| 功能测试 | oe_test_galagopher_tprofiling         | pass     |
| 功能测试 | oe_test_service_gopher                | pass     |



## 3.2   约束说明

NA

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

NA

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |    0      | 0     |   0   |   0   |  0      |
| 百分比 |     0     |   0   |  0    |   0   |    0    |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

NA

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1|gala-gopher特性 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

NA

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

NA

### 4.3.2 可靠性/韧性测试结论

NA

### 4.3.3 安全测试结论

NA

## 4.4 资料测试结论
NA

## 4.5 其他测试结论

NA

# 5     测试执行

## 5.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-22.03-LTS-SP4         |     22     |      失败0个        |      0        |




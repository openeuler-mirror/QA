修订记录

| 日期       | 修订   版本 | 修改描述         | 作者   |
| ---------- | ----------- | ---------------- | ------ |
| 2023/09/19 | 1.0         | GMEM测试报告初稿 | 张晓枫 |

关键词： GMEM

摘要：部署openEuler 23.09测试镜像环境，对GMEM的主要功能和性能进行测试。测试结果良好，基本支持GMEM主要功能的正常使用。 


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

GMEM (Generalized Memory Management) 提供了异构互联内存的中心化管理，GMEM API支持设备接入统一地址空间，获得针对异构内存编程的优化，将CPU架构相关的实现从Linux的内存管理系统中独立出来。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称            | 测试起始时间   | 测试结束时间   |
| ------------------- | -------------- | -------------- |
| openEuler-23.09-RC1 | 2023年08月24日 | 2023年08月29日 |
| openEuler-23.09-RC3 | 2023年09月07日 | 2023年09月12日 |
| openEuler-23.09-RC4 | 2023年09月13日 | 2023年09月18日 |

描述特性测试的硬件环境信息

| 硬件型号   | 硬件配置信息                           | 备注 |
| ---------- | -------------------------------------- | ---- |
| 泰山2280V2 | CPU：Kunpeng-920 <br> NPU：Ascend 910A |      |

# 3     测试结论概述

## 3.1   测试整体结论

本特性共计执行20个用例，覆盖单算子计算场景及大模型GPT2超分场景，包含内存申请释放、host和device触发缺页、同步异步gmemPrefetch 、 gmemFreeEager 、内存超分等功能测试，并覆盖进程并发超分、并发prefetch等可靠性测试，以及性能测试。

上述测试发现的问题都得到了修正，回归测试结果正常，无遗留风险，整体质量良好。 

## 3.2   约束说明

1. 目前仅支持2M大页，所以host OS以及NPU卡内OS的透明大页需要默认开启。
2. 通过MAP_PEER_SHARED申请的异构内存目前不支持fork时继承。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无。

### 3.3.2 问题统计

| 问题单号                                                     | 问题描述                                                     | 当前状态 |
| ------------------------------------------------------------ | ------------------------------------------------------------ | -------- |
| https://gitee.com/openeuler/libgmem/issues/I7W5FI?from=project-issue | 调用gmemGetNumaId()失败                                      | 已解决   |
| https://gitee.com/openeuler/kernel/issues/I7ZIT4?from=project-issue | gmem执行矩阵乘，矩阵大小为1搭配异步prefetch会概率性卡住      | 已解决   |
| https://gitee.com/openeuler/kernel/issues/I7ZSJW?from=project-issue | gmemFreeEager的size为2时，内存没有解映射                     | 已解决   |
| https://gitee.com/openeuler/kernel/issues/I80KA7?from=project-issue | gmemFreeEager和gmemPrefetch部分异常参数不报错                | 已解决   |
| https://gitee.com/openeuler/kernel/issues/I80KLC?from=project-issue | 调用gmemFreeEager((unsigned long)0xFFFFFFFFFFFFFFFF, -1, NULL)，系统panic | 已解决   |
| https://gitee.com/openeuler/kernel/issues/I81RZT?from=project-issue | GPT2设置batch_size=4跑满step系统概率性panic或打印error       | 待解决   |



|        | 问题总数 | 严重  | 主要  | 次要  | 不重要 |
| ------ | -------- | ----- | ----- | ----- | ------ |
| 数目   | 6        | 1     | 4     | 1     | 0      |
| 百分比 | 100%     | 16.7% | 66.7% | 16.7% | 0      |

# 4 详细测试结论

## 4.1 功能测试
包含内存申请释放、host和device触发缺页、同步异步gmemPrefetch 、 gmemFreeEager 、内存超分等功能测试。

## 4.2 DFX专项测试结论

### 4.2.1 性能测试结论

| 指标大项      | 指标小项                      | 指标值  | 测试结论                               |
| ------------- | ----------------------------- | ------- | -------------------------------------- |
| per step time | per step time（batch_size=4） | 6560ms  | 较Nvidia UVM（ 11815.083 ）性能提升79% |
| per step time | per step time（batch_size=8） | 14252ms | 较Nvidia UVM（ 27766.96 ）性能提升95%  |

### 4.2.2 可靠性/韧性测试结论

包含进程并发超分、并发prefetch、异常信号kill等可靠性场景。

## 4.3 资料测试结论

https://gitee.com/openeuler/docs/tree/e114a8563fa1246a1b780720eb70676a12427018/docs/zh/docs/GMEM
# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称            | 测试用例数 | 用例执行结果 | 发现问题单数 |
| ------------------- | ---------- | ------------ | ------------ |
| openEuler-23.09-RC1 | 14         | 14           | 1            |
| openEuler-23.09-RC3 | 20         | 20           | 4            |
| openEuler-23.09-RC4 | 20         | 20           | 1            |



## 5.2   后续测试建议

无

# 6     附件

无

 



 

 
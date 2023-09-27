![openEuler ico](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期        | 修订   版本 | 修改描述 | 作者 |
| ----       | ----------- | -------- | ---- |
| 2023/09/25 |   v1.0      | GCC测试报告 | 王丹 |


摘要：依据测试要求，对GCC编译器进行基础功能测试

 

# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler23.09 RC1 | 2023-08-24 | 2023-08-30 |
| openEuler23.09 RC2 | 2023-08-31 | 2023-09-05 |
| openEuler23.09 RC3 | 2023-09-07 | 2023-09-14 |
| openEuler23.09 RC4 | 2023-09-15 | 2023-09-20 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| TaiShan 200 | 96U 512G | aarch64 |
| 虚拟机 | 64U 16G | aarch64 |
| 虚拟机 | 64U 16G | x86_64 |

# 3     测试结论概述

## 3.1   测试整体结论

GCC编译器测试，转测特性（Mul64: -fmerge-mull; 结构体成员拆分:-fipa-struct-reorg=1；结构体成员重排:-fipa-struct-reorg=2； 结构体冗余成员消除:-fipa-struct-reorg=3；array-widen-cmp优化:-farray-widen-compare; ccmp优化:-fccmp2；simdmath支持鲲鹏:-fsimdmath；LSE指令特性默认关闭；冗余循环消除特性:-floop-elim；内核反馈优化:-fkernel-pgo）基本功能测试，无遗留风险，整体质量良好。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 基本功能测试 | 执行测试套：冒烟测试、dejagnu、库上特性用例、bstest、llvmcase、Anghabench、jotai-benchmarks、codeDB基本功能正常，发现问题全部解决，回归通过，无风险； |
| 浮点精度测试 | 执行测试套FPTEST，无新增FAIL用例； |
| 汇编一致性测试 | 根据speccpu2017生成二进制并反汇编，比对结果一致； |
| 可靠性测试 | 执行超规格测试用例，全部执行通过； |
| Fuzz测试 | csmith（c\c++浮点版本）、yarpgen（c\c++）、csmith浮点版本、fortranFuzz普通版本等随机测试套件分别运行100w+用例，无遗留问题； |
| 覆盖率测试 | 测试增量代码覆盖率，最终结果分别为lines:92.6%，functions:94.6%，均高于85%要求； |
| 自举测试 | arm环境编译gcc源码，生成二进制，并成功运行deja测试套； |
| x86交叉测试 | x86环境编译gcc源码，生成二进制，并成功运行deja测试套； |
| PGO kernel功能测试 | 测试UnixBench来验证该特性功能，执行通过； |
| PGO kernel文档测试 | 根据文档步骤验证该功能,已提检视意见并修改 |


## 3.2   约束说明

无

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |  2       | 0     |  2    | 0     | 0       |
| 百分比 |  100%     |  0    |  100%    |  0    |  0      |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 | 发现问题测试活动 | 问题单 |
| -------- | ---------- | ------------ | ------------ | ------------ | ------------ |
| openEuler23.09 RC1 | 100w+ | 成功 |   0  | NA  | NA  |
| openEuler23.09 RC2 | 100w+ | 部分测试套执行失败 |   2  | deja/Anghabench/llvm/bstest等,执行失败测试套发现问题相同 | [I7XPCZ](https://gitee.com/openeuler/gcc/issues/I7XPCZ)                                                              [I7XQSD](https://gitee.com/openeuler/gcc/issues/I7XQSD) |
| openEuler23.09 RC3 | 100w+ | 部分测试套执行失败  |   0  | deja/Anghabench/llvm/bstest等,issue同RC2 | NA |
| openEuler23.09 RC4 | 100w+ | 成功 |   0  | NA  | NA  |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议


# 5     附件

*无*

 



 

 

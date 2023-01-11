![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期        | 修订   版本 | 修改描述 | 作者 |
| ----       | ----------- | -------- | ---- |
| 2022/12/19 |   v1.0      | GCC测试报告 | 王丹 |


摘要：依据测试要求，对GCC编译器特性进行各测试套执行

 

# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler22.03 LTS SP1 RC1 | 2022-11-23 | 2022-11-29 |
| openEuler22.03 LTS SP1 RC2 | 2022-12-02 | 2022-12-08 |
| openEuler22.03 LTS SP1 RC3 | 2022-12-09 | 2022-12-15 |
| openEuler22.03 LTS SP1 RC4 | 2022-12-16 | 2022-12-22 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| TaiShan 200（Model 2280） | 96U 512G | aarch64 |
| TaiShan 200K（Model 2280K） | 96U 256G | aarch64 codedb测试专用 |
| TaiShan 200（Model 2280） | 128U 512G | aarch64 cpubench性能测试专用 |
| 2288H V5 | 64U 186G | x86_64 |

# 3     测试结论概述

## 3.1   测试整体结论

GCC编译器测试，共转测5个特性（Mul64: -fmerge-mull; 指针压缩：-fipa-struct-reorg=4 --param compressed-pointer-size=[8,16,32]、-fipa-struct-reorg=5; 循环拆分：-ftree-slp-transpose-vectorize; semi-relayout:-fipa-struct-reorg=6 --param semi-relayout-level=[11,12,13,14,15]），主要覆盖基本功能测试，继承特性选项测试，浮点精度测试，汇编一致性测试，可靠性测试，Fuzz测试，覆盖率测试，asan测试，自举测试，x86交叉测试，性能测试; 共3个问题，回归通过3个，无遗留问题，整体质量良好。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 基本功能测试 | 执行测试套：冒烟测试、dejagnu、库上特性用例、bstest、llvmcase、Anghabench、jotai-benchmarks、codeDB基本功能正常，共2个问题，已回归通过，无遗留问题； |
| 特性选项测试 | 通过deja测试套分别执行预取特性，特性功能使用正常； |
| 浮点精度测试 | 执行测试套FPTEST，无新增FAIL用例； |
| 汇编一致性测试 | 根据speccpu2017生成二进制并反汇编，比对结果一致； |
| 可靠性测试 | 执行超规格测试用例，全部执行通过； |
| Fuzz测试 | csmith（c\c++\浮点版本\builtin版本）、yarpgen（c\c++）、fortranFuzz普通版本，等随机测试套件分别运行100w+用例，共1个问题，已回归通过，无遗留问题； |
| 覆盖率测试 | 测试增量代码覆盖率，最终结果为lines:86.0%，高于85%要求； |
| asan测试 | 测试增量代码是否存在内存泄露问题，发现问题全部解决，回归通过，无风险； |
| 自举测试 | arm环境编译gcc源码，生成二进制，并成功运行deja等测试套； |
| x86交叉测试 | x86环境编译gcc源码，生成二进制，并成功运行deja等测试套； |
| 性能测试 | 使用第4轮转测GCC版本测试cpubench,预期在海光76.91分的基础上超5%，在华为2280上openEuler GCC实际得分81.95，性能提升6.55%，符合性能预期； |


## 3.2   cpubench性能数据

| 版本名称 | 华为2280 |  海光   |   提升百分比   |
| -------- | -------- |  -------- |  -------- |
|openEuler22.03 LTS SP1 RC4| 81.95 | 76.91 | 6.55% |

## 3.3   约束说明

无

## 3.4   遗留问题分析

### 3.4.1 遗留问题影响以及规避措施

无

### 3.4.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |  3       | 0     |  3    | 0     | 0       |
| 百分比 |  100%     |  0    |  100%    |  0    |  0      |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 | 问题单 |
| -------- | ---------- | ------------ | ------------ | ------------ |
| openEuler22.03 LTS SP1 RC1 | 200w+ | 除yarpgen c++外其他均成功 | 1     |  [I6415J](https://gitee.com/openeuler/gcc/issues/I6415J) |
| openEuler22.03 LTS SP1 RC2 | 200w+ | 除codedb/Anghabench测试外其他均成功 | 2   |[I65A1O](https://gitee.com/openeuler/gcc/issues/I65A1O)  [I65164](https://gitee.com/openeuler/gcc/issues/I65164) |
| openEuler22.03 LTS SP1 RC3 | 200w+ | 全部通过 |  0    |  NA  |
| openEuler22.03 LTS SP1 RC4 | 2 | issue回归通过 |  0    |  NA  |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议


# 5     附件

*无*

 



 

 

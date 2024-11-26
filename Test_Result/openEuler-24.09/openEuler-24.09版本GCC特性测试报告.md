

![openEuler ico](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述    | 作者   |
| ---------- | ----------- | ----------- | ------ |
| 2024/09/30 | v1.0        | GCC测试报告 | 纪晓慧 |


摘要：依据测试要求，对GCC编译器进行基础功能测试

 

# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| openEuler-24.09 RC1 | 2024-08-12   | 2024-08-19   |
| openEuler-24.09 RC2 | 2024-08-20   | 2024-08-27   |
| openEuler-24.09 RC3 | 2024-08-30   | 2024-09-05   |
| openEuler-24.09 RC4 | 2024-09-06   | 2024-09-11   |
| openEuler-24.09 RC5 | 2024-09-13   | 2024-09-20   |
| openEuler-24.09 RC6 | 2024-09-21   | 2024-09-27   |

描述特性测试的硬件环境信息

| 硬件型号                 | 硬件配置信息 | 备注           |
| ------------------------ | ------------ | -------------- |
| TaiShan 200              | 96U 512G     | aarch64        |
| TaiShan 200 (Model 2280) | 160U 512G    | 性能测试       |
| TaiShan 200 (Model 2280) | 8U 32G       | CFGO泛化性测试 |

# 3     测试结论概述

## 3.1   测试整体结论

GCC编译器测试，转测特性：编译器多版本支持，使能LTO构建减少包体积，CFGO泛化性，继承特性(ccmp指令增强 ：-fccmp2；array-widen-cmp优化：-farray-widen-compare；Mul64: -fmerge-mull -ftree-fold-phiopt; 反馈优化:结构体成员拆分:-fipa-struct-reorg=1;结构体成员重排:-fipa-struct-reorg=2;结构体冗余成员消除:-fipa-struct-reorg=3指针压缩：-fipa-struct-reorg=4 --param compressed-pointer-size=[8,16,32], -fipa-struct-reorg=5; semi-relayout:-fipa-struct-reorg=6 --param semi-relayout-level=[11,12,13,14,15] ;循环拆分：-ftree-slp-transpose-vectorize;reduction chains group的分析以及矢量化:-ftree-vect-analyze-slp-group;CRC优化：-floop-crc; if-conversion增强: -fifcvt-allow-complicated-cmps --param=ifcvt-allow-register-renaming=[0,1,2] ;乘法计算优化:-fif-conversion-gimple -fuaddsub-overflow-match-all;cmlt指令生成优化:-mcmlt-arith;向量化优化增强 : --param=tree-forwprop-perm=1 --param=vect-alias-flexible-segment-len=1; 间接调用提升:-ficp-speculatively; ldp/stp优化:-fsplit-ldp-stp;  IPA-prefetch: -fipa-prefetch -fipa-ic; AES指令优化:-fcrypto-accel-aes；内核反馈优化:-fkernel-pgo;自动反馈优化：-fauto-bolt,-fbolt-use,-fbolt-target,-fbolt-option)，主要覆盖基本功能测试，浮点精度测试，可靠性测试，Fuzz测试，汇编一致性测试，自举测试，x86交叉测试，性能测试CFGO泛化性测试；共发现16个问题，回归通过16个。

| 测试活动              | 活动评价                                                     |
| --------------------- | ------------------------------------------------------------ |
| 基本功能测试          | arm架构上执行测试套：冒烟测试、dejagnu、库上特性用例、bstest、llvmcase、Anghabench、jotai-benchmarks、codeDB；x86架构上执行测试套：deja；发现11个问题，涉及结构体成员拆分，循环拆分，IPA-prefetch和优化选项 -ficp，回归通过11个 |
| 浮点精度测试          | 执行测试套FPTEST，无新增FAIL用例；                           |
| 可靠性测试            | 执行超规格测试用例，全部执行通过；                           |
| Fuzz测试              | csmith、yarpgen、fortranFuzz普通版本等随机测试套件分别运行10w+用例，发现1个问题，涉及AES指令优化，回归通过1个； |
| 汇编一致性测试        | 根据speccpu2017生成二进制并反汇编，比对结果一致；            |
| 自举测试              | aarch64环境编译gcc源码，生成二进制，并成功运行deja测试套；   |
| x86交叉测试           | x86环境编译gcc源码，生成二进制，并成功运行deja测试套；       |
| 内核反馈优化功能测试  | 测试UnixBench来验证该特性功能，执行通过；                    |
| 自动反馈优化功能测试  | 使用冒泡排序测试反馈优化bolt-use特性功能，共发现1个问题，回归通过1个；                                                                          使用NPB应用（8种基准3种问题规模）测试反馈优化auto-bolt和bolt-use 特性功能，执行通过； |
| 编译器多版本支持      | aarch64和x86上gcc-14和binutils执行deja测试套，共发现3个问题，回归通过3个 |
| 性能测试              | 使用RC3转测版本GCC测试SPEC INT，分数符合预期，通过           |
| CFGO泛化性测试        | MySQL 8.0.25 小实例场景（docker 8U32G）sysbench 只读、只写、读写、point四个场景性能对比开源平均提升37% ；tpcc，tpch对比开源性能不退化，测试通过 |
| 使能LTO构建减少包体积 | 533个自身带有测试套的软件包构建时批量使能LTO，构建通过，整体ELF文件对比不使能LTO aarch64架构减少14.43%，x86架构减少15.63%，目标5%，测试通过 |

## 3.2 增量代码覆盖率

|           | Hit   | Total | Coverage |
| --------- | ----- | ----- | -------- |
| Lines     | 10496 | 12038 | 87.2%    |
| Functions | 7292  | 8181  | 89.1%    |

| Directory                 | Line Coverage |           | Functions |           |
| ------------------------- | ------------- | --------- | --------- | --------- |
| bolt-plugin               | 85.5%         | 283/331   | 96.7%     | 29/30     |
| gcc                       | 86.7%         | 6100/7038 | 88.5%     | 4761/5378 |
| gcc/c                     | 91.4%         | 32/35     | 95.8%     | 564/589   |
| gcc/c-family              | 66.7%         | 14/21     | 89.6%     | 103/115   |
| gcc/common/config/aarch64 | 95.7%         | 45/47     | 80.0%     | 8/10      |
| gcc/config/aarch64        | 84.6%         | 939/1110  | 88.0%     | 1266/1438 |
| gcc/cp                    | 100%          | 7/7       | 95.0%     | 249/262   |
| gcc/fortran               | 100%          | 5/5       | 100.0%    | 71/71     |
| gcc/ipa-struct-reorg      | 89.3%         | 3070/3437 | 94.7%     | 196/207   |
| libcpp                    | 14.3%         | 1/7       | 55.6%     | 45/81     |



## 3.4   约束说明

无

## 3.5   遗留问题分析

### 3.5.1 遗留问题影响以及规避措施

无

### 3.5.2 问题统计

|        | 问题总数 | 严重 | 主要  | 次要  | 不重要 |
| ------ | -------- | ---- | ----- | ----- | ------ |
| 数目   | 0        | 0    | 15    | 1     | 0      |
| 百分比 | 0        | 0    | 87.5% | 12.5% | 0      |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称            | 测试用例数 | 用例执行结果       | 发现问题单数 | 发现问题测试活动                    | 问题单                                                       |
| ------------------- | ---------- | ------------------ | ------------ | ----------------------------------- | ------------------------------------------------------------ |
| openEuler-24.09 RC1 | 100w+      | 部分测试套执行失败 | 5            | deja/codedb/csmith/自动反馈优化测试 | [AKOXJ](https://gitee.com/src-openeuler/gcc/issues/IAKOXJ?from=project-issue) [IAKOYG](https://gitee.com/src-openeuler/gcc/issues/IAKOYG?from=project-issue) [IAKOYG](https://gitee.com/src-openeuler/gcc/issues/IAKOYU?from=project-issue) [IAKOZA](https://gitee.com/src-openeuler/gcc/issues/IAKOYU?from=project-issue) [IAKPJV](https://gitee.com/src-openeuler/gcc/issues/IAKPJV?from=project-issue) |
| openEuler-24.09 RC2 | 100w+      | 部分测试套执行失败 | 3            | deja/codedb                         | [IALR8B](https://gitee.com/src-openeuler/gcc/issues/IALR8B?from=project-issue) [IALVHN](https://gitee.com/src-openeuler/gcc-14/issues/IALVHN?from=project-issue) [IAM3Q6](https://gitee.com/src-openeuler/gcc-14/issues/IAM3Q6?from=project-issue) |
| openEuler-24.09 RC3 | 100w+      | 部分测试套执行失败 | 5            | codedb                              | [IAO50J](https://gitee.com/src-openeuler/gcc/issues/IAO50J?from=project-issue) [IAO5H7](https://gitee.com/src-openeuler/gcc/issues/IAO5H7?from=project-issue) [IAO6R3](https://gitee.com/src-openeuler/gcc/issues/IAO6R3?from=project-issue) [IAORPF](https://gitee.com/src-openeuler/gcc/issues/IAORPF?from=project-issue) [IAOSJ0](https://gitee.com/src-openeuler/gcc/issues/IAOSJ0?from=project-issue) |
| openEuler-24.09 RC4 | 100w+      | 部分测试套执行失败 | 2            | deja/Anghabench                     | [IAQEYH](https://gitee.com/src-openeuler/gcc-14/issues/IAQEYH?from=project-issue) [IAQFM3](https://gitee.com/src-openeuler/gcc/issues/IAQFM3?from=project-issue) |
| openEuler-24.09 RC5 | 100w+      | 部分测试套执行失败 | 1            | codedb                              | [IARHFM](https://gitee.com/src-openeuler/gcc/issues/IARHFM?from=project-issue) |
| openEuler-24.09 RC6 | 100w+      | 执行通过           | 0            | /                                   | /                                                            |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议


# 5     附件

*无*
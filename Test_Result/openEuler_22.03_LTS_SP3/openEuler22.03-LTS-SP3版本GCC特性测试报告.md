

![openEuler ico](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述             | 作者   |
| ---------- | ----------- | -------------------- | ------ |
| 2023/12/22 | v1.0        | GCC测试报告          | 纪晓慧 |
| 2023/01/17 | v1.1        | 添加RC5和RC6测试内容 | 纪晓慧 |


摘要：依据测试要求，对GCC编译器进行基础功能测试

 

# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                   | 测试起始时间 | 测试结束时间 |
| -------------------------- | ------------ | ------------ |
| openEuler22.03-LTS-SP3 RC1 | 2023-11-28   | 2023-12-07   |
| openEuler22.03-LTS-SP3 RC2 | 2023-12-8    | 2023-12-13   |
| openEuler22.03-LTS-SP2 RC3 | 2023-12-14   | 2023-12-19   |
| openEuler22.03-LTS-SP3 RC4 | 2023-12-20   | 2023-12-24   |
| openEuler22.03-LTS-SP3 RC5 | 2023-12-25   | 2023-12-28   |
| openEuler22.03-LTS-SP3 RC6 | 2023-12-29   | 2023-12-31   |

描述特性测试的硬件环境信息

| 硬件型号                 | 硬件配置信息 | 备注     |
| ------------------------ | ------------ | -------- |
| TaiShan 200              | 96U 512G     | aarch64  |
| 虚拟机                   | 64U 16G      | aarch64  |
| 虚拟机                   | 64U 16G      | aarch64  |
| TaiShan 200 (Model 2280) | 128U 512G    | 性能测试 |

# 3     测试结论概述

## 3.1   测试整体结论

GCC编译器测试，转测特性（CRC优化：-floop-crc; if-conversion增强: -fifcvt-allow-complicated-cmps --param=ifcvt-allow-register-renaming=[0,1,2] ;乘法计算优化:-fif-conversion-gimple -fuaddsub-overflow-match-all;cmlt指令生成优化:-mcmlt-arith;向量化优化增强 : --param=tree-forwprop-perm=1 --param=vect-alias-flexible-segment-len=1; 间接调用提升:-ficp-speculatively; ldp/stp优化:-fsplit-ldp-stp;  IPA-prefetch: -fipa-prefetch -fipa-ic; AES指令优化:-fcrypto-accel-aes; LLC-prefetch: -fllc-allocate -param=mem-access-ratio=[0,100] -param=mem-access-num=unsigned -param=outer-loop-nums=[1,10] -param=filter-kernels=[0,1] -param=branch-prob-threshold=[50,100] -param=prefetch-offset=[1,999999] -param=issue-topn=unsigned -param=force-issue=[0,1] -param=llc-capacity-per-core=[0,999999]; 编译器多版本支持) , 继承特性(ccmp指令增强 ：-fccmp2；array-widen-cmp优化：-farray-widen-compare；Mul64: -fmerge-mull -ftree-fold-phiopt; 反馈优化:结构体成员拆分:-fipa-struct-reorg=1;结构体成员重排:-fipa-struct-reorg=2;结构体冗余成员消除:-fipa-struct-reorg=3指针压缩：-fipa-struct-reorg=4 --param compressed-pointer-size=[8,16,32], -fipa-struct-reorg=5; semi-relayout:-fipa-struct-reorg=6 --param semi-relayout-level=[11,12,13,14,15] ;循环拆分：-ftree-slp-transpose-vectorize;reduction chains group的分析以及矢量化:-ftree-vect-analyze-slp-group;内核反馈优化:-fkernel-pgo;自动反馈优化：-fauto-bolt,-fbolt-use,-fbolt-target,-fbolt-option)，主要覆盖基本功能测试，浮点精度测试，可靠性测试，Fuzz测试，汇编一致性测试，覆盖率测试，自举测试，x86交叉测试，性能测试等；共发现24个问题，回归通过24个； IPA-prefetch和间接调用提升特性回退。

| 测试活动             | 活动评价                                                     |
| -------------------- | ------------------------------------------------------------ |
| 基本功能测试         | arm架构上执行测试套：冒烟测试、dejagnu、库上特性用例、bstest、llvmcase、Anghabench、jotai-benchmarks、codeDB；x86架构上执行测试套：deja；共发现24个问题，涉及CRC优化，if-conversion增强，结构体冗余成员消除，AES指令优化，ldp/stp优化，IPA-prefetch，LLC-prefetch和优化选项 -ficp，回归通过24个； |
| 浮点精度测试         | 执行测试套FPTEST，无新增FAIL用例；                           |
| 可靠性测试           | 执行超规格测试用例，全部执行通过；                           |
| Fuzz测试             | csmith（c\c++）、yarpgen（c\c++）、fortranFuzz普通版本等随机测试套件分别运行100w+用例，无新增错误； |
| 汇编一致性测试       | 根据speccpu2017生成二进制并反汇编，比对结果一致；            |
| 覆盖率测试           | 测试增量代码覆盖率，最终结果为lines:85.2%，高于85%要求；     |
| 自举测试             | arm环境编译gcc源码，生成二进制，并成功运行deja测试套；       |
| x86交叉测试          | x86环境编译gcc源码，生成二进制，并成功运行deja测试套；       |
| 内核反馈优化功能测试 | 测试UnixBench来验证该特性功能，执行通过；                    |
| 自动反馈优化功能测试 | 使用冒泡排序测试反馈优化bolt-use特性功能，执行通过                                                                          使用NPB应用（8种基准3种问题规模）测试反馈优化bolt-use 特性功能，执行通过； |
| 编译器多版本支持     | arm和x86上gcc-12执行deja测试套，测试通过，无遗留问题         |
| 性能测试             | 使用RC6转测版本GCC在kunpeng 920上测试CPUBench INT，预期在baseline 162.926的基础上提升10%，实际得分180.397，实际提升10.72%，符合预期 |

## 3.2 增量代码覆盖率

|           | Hit  | Total | Coverage |
| --------- | ---- | ----- | -------- |
| Lines     | 8912 | 10464 | 85.2%    |
| Functions | 5256 | 5829  | 90.2%    |



| Directory                 | Line Coverage |           | Functions |           |
| ------------------------- | ------------- | --------- | --------- | --------- |
| bolt-plugin               | 83.5%         | 278/333   | 93.3%     | 28/30     |
| gcc                       | 82.9%         | 5073/6194 | 88.6%     | 3874/4371 |
| gcc/c-family              | 100%          | 1/1       | 93.8%     | 30/32     |
| gcc/common/config/aarch64 | 90.5%         | 19/21     | 100.0%    | 11/11     |
| gcc/config/aarch64        | 86.6%         | 440/508   | 94.5%     | 1052/1113 |
| gcc/fortran               | 83.3%         | 5/6       | 100.0%    | 68/68     |
| gcc/ipa-struct-reorg      | 91.0%         | 3096/3401 | 94.6%     | 193/204   |



## 3.3 CPUbench INT性能数据

| Benchmark             | openEuler22.03-LTS-SP3 RC6 | baseline | 提升   |
| --------------------- | -------------------------- | -------- | ------ |
| x264                  | 290.751                    | 237.291  | /      |
| gcc                   | 133.822                    | 136.321  | /      |
| gzip                  | 244.924                    | 216.86   | /      |
| tpcc                  | 174.392                    | 167.981  | /      |
| tpch                  | 163.277                    | 148.96   | /      |
| velvet                | 89.583                     | 88.059   | /      |
| openssl               | 385.732                    | 272.05   | /      |
| rapidjson             | 159.018                    | 139.947  | /      |
| python                | 181.558                    | 166.414  | /      |
| xz                    | 134.832                    | 134.576  | /      |
| IntConcurrent_Typical | 180.397                    | 162.925  | 10.72% |

## 3.4   约束说明

无

## 3.5   遗留问题分析

### 3.5.1 遗留问题影响以及规避措施

无

### 3.5.2 问题统计

|        | 问题总数 | 严重 | 主要  | 次要  | 不重要 |
| ------ | -------- | ---- | ----- | ----- | ------ |
| 数目   | 0        | 0    | 21    | 3     | 0      |
| 百分比 | 0        | 0    | 87.5% | 12.5% | 0      |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                   | 测试用例数 | 用例执行结果       | 发现问题单数 | 发现问题测试活动                                             | 问题单                                                       |
| -------------------------- | ---------- | ------------------ | ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| openEuler22.03-LTS-SP3 RC1 | 100w+      | 成功               | 0            | NA                                                           | NA                                                           |
| openEuler22.03-LTS-SP3 RC2 | 300w+      | 部分测试套执行失败 | 5            | deja/codedb/Anghabench/llvm/bstest等，执行失败测试套发现问题相同 | [I8NQVW](https://gitee.com/src-openeuler/gcc/issues/I8NQVW)  [I8NS7E](https://gitee.com/src-openeuler/gcc/issues/I8NS7E)  [I8NT4F](https://gitee.com/src-openeuler/gcc/issues/I8NT4F)  [I8O2H7](https://gitee.com/src-openeuler/gcc/issues/I8O2H7)  [I8O9PZ](https://gitee.com/src-openeuler/gcc/issues/I8O9PZ) |
| openEuler22.03-LTS-SP3 RC3 | 300w+      | 部分测试套执行失败 | 3            | deja/Anghabench/llvm/bstest等执行失败测试套发现问题相同      | [I8PANY](https://gitee.com/src-openeuler/gcc/issues/I8PANY)  [I8PBKT](https://gitee.com/src-openeuler/gcc/issues/I8PBKT)  [I8PFVH](https://gitee.com/src-openeuler/gcc/issues/I8PFVH) |
| openEuler22.03-LTS-SP3 RC4 | 300w+      | 部分测试套执行失败 | 10           | deja/Anghabench/llvm/bstest等执行失败测试套发现问题相同      | [I8PUDT](https://gitee.com/src-openeuler/gcc/issues/I8PUDT)  [I8PYBF](https://gitee.com/src-openeuler/gcc/issues/I8PYBF)  [I8PYLL](https://gitee.com/src-openeuler/gcc/issues/I8PYLL)  [I8Q83R](https://gitee.com/src-openeuler/gcc/issues/I8Q83R)  [I8Q84R](https://gitee.com/src-openeuler/gcc/issues/I8Q84R)  [I8QC2I](https://gitee.com/src-openeuler/gcc/issues/I8QC2I)  [I8QC8O](https://gitee.com/src-openeuler/gcc/issues/I8QC8O)  [I8QD9H](https://gitee.com/src-openeuler/gcc/issues/I8QD9H)  [I8QEQR](https://gitee.com/src-openeuler/gcc/issues/I8QEQR)  [I8QFEE](https://gitee.com/src-openeuler/gcc/issues/I8QFEE) |
| openEuler22.03-LTS-SP3 RC5 | 300w+      | 部分测试套执行失败 | 6            | deja/Anghabench/llvm/bstest等执行失败测试套发现问题相同      | [I8RKFJ](https://gitee.com/src-openeuler/gcc/issues/I8RKFJ)  [I8RP4H](https://gitee.com/src-openeuler/gcc/issues/I8RP4H)  [I8RRDW](https://gitee.com/src-openeuler/gcc/issues/I8RRDW)  [I8RURA](https://gitee.com/src-openeuler/gcc/issues/I8RURA)  [I8RV7T](https://gitee.com/src-openeuler/gcc/issues/I8RV7T)  [I8RVEC](https://gitee.com/src-openeuler/gcc/issues/I8RVEC) |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议


# 5     附件

*无*
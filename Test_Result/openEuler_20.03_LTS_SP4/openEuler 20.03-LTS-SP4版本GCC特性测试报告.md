![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者   |
| ---------- | ----------- | -------- | ------ |
| 2023/12/22 | v1.0        | 初稿     | 纪晓慧 |

摘要： 依据测试要求，对GCC编译器进行基础功能测试

# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等）。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                   | 测试起始时间 | 测试结束时间 |
| -------------------------- | ------------ | ------------ |
| openEuler20.03-LTS-SP4 RC1 | 2023-11-02   | 2023-11-07   |
| openEuler20.03-LTS-SP4 RC2 | 2023-11-08   | 2023-11-16   |
| openEuler20.03-LTS-SP4 RC3 | 2023-11-17   | 2023-11-22   |
| openEuler20.03-LTS-SP4 RC4 | 2023-11-23   | 2023-11-28   |
| openEuler20.03-LTS-SP4 RC5 | 2023-11-29   | 2023-12-05   |
| openEuler20.03-LTS-SP4 RC6 | 2023-12-12   | 2023-12-12   |

描述特性测试的硬件环境信息

| 硬件型号    | 硬件配置信息 | 备注    |
| ----------- | ------------ | ------- |
| TaiShan 200 | 96U 512G     | aarch64 |
| 虚拟机      | 64U 16G      | aarch64 |
| 虚拟机      | 64U 16G      | aarch64 |

# 3     测试结论概述

## 3.1   测试整体结论

GCC编译器测试，转测特性：编译器多版本支持, 继承特性：内核反馈优化:-fkernel-pgo;自动反馈优化：-fbolt-use,-fbolt-target,-fbolt-option)，主要覆盖基本功能测试，浮点精度测试，可靠性测试，Fuzz测试，汇编一致性测试，覆盖率测试，自举测试等；共发现7个问题，回归通过7个。

| 测试活动             | 活动评价                                                     |
| -------------------- | ------------------------------------------------------------ |
| 基本功能测试         | 在arm上执行测试套：冒烟测试、dejagnu、bstest、llvmcase、Anghabench、jotai-benchmarks、codeDB，在x86上执行dejagnu测试套；共发现4个问题，回归通过4个； |
| 浮点精度测试         | 执行测试套FPTEST，无新增FAIL用例；                           |
| 可靠性测试           | 执行超规格测试用例，全部执行通过；                           |
| Fuzz测试             | csmith（c）、yarpgen（c++）随机测试套件分别运行100w+用例，共发现1个问题，回归通过1个； |
| 汇编一致性测试       | 根据speccpu2017生成二进制并反汇编，比对结果一致；            |
| 覆盖率测试           | 测试增量代码覆盖率，最终结果为lines:85.2%，高于85%要求；     |
| 自举测试             | arm环境编译gcc源码，生成二进制，并成功运行deja测试套；       |
| 内核反馈优化功能测试 | 测试UnixBench来验证该特性功能，执行通过；                    |
| 自动反馈优化功能测试 | 使用冒泡排序测试反馈优化bolt-use特性功能，执行通过                                                                          使用NPB应用（8种基准3种问题规模）测试反馈优化bolt-use 特性功能，执行通过； |
| 编译器多版本支持     | 使用gcc-10执行deja、llvm、bstest、llvmcase测试套，共发现问题2个，回归通过2个； |

## 3.2 增量代码覆盖率

|           | Hit  | Total | Coverage |
| --------- | ---- | ----- | -------- |
| Lines     | 517  | 607   | 85.2%    |
| Functions | 2004 | 2269  | 88.3%    |

| Directory          | Line Coverage |         | Functions |           |
| ------------------ | ------------- | ------- | --------- | --------- |
| bolt-plugin        | 90.7%         | 185/204 | 100.0%    | 22/22     |
| gcc                | 80.2%         | 264/329 | 83.0%     | 1151/1391 |
| gcc/c              | 100%          | 1/1     | 98.6%     | 137/139   |
| gcc/config/aarch64 | 91.2%         | 62/68   | 94.3%     | 349/370   |
| gcc/cp             | 100.0%        | 5/5     | 98.3%     | 341/347   |



## 3.3   约束说明

无

## 3.4   遗留问题分析

### 3.4.1 遗留问题影响以及规避措施

无

### 3.4.2 问题统计

|        | 问题总数 | 严重 | 主要  | 次要  | 不重要 |
| ------ | -------- | ---- | ----- | ----- | ------ |
| 数目   | 0        | 0    | 6     | 1     | 0      |
| 百分比 | 0        | 0    | 85.7% | 14.3% | 0      |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                   | 测试用例数 | 用例执行结果       | 发现问题单数 | 发现问题测试活动     | 问题单                                                       |
| -------------------------- | ---------- | ------------------ | ------------ | -------------------- | ------------------------------------------------------------ |
| openEuler20.03-LTS-SP4 RC1 | 100w+      | 部分测试套执行失败 | 4            | deja/llvmcase/bstest | [I8EIGV](https://gitee.com/src-openeuler/gcc/issues/I8EIGV) [I8EIKA](https://gitee.com/src-openeuler/gcc/issues/I8EIKA) [I8EJCD](https://gitee.com/src-openeuler/gcc/issues/I8EJCD) [I8EMUW](https://gitee.com/src-openeuler/gcc/issues/I8EMUW) |
| openEuler20.03-LTS-SP4 RC2 | 300w+      | 部分测试套执行失败 | 2            | deja/csmith          | [I8G049](https://gitee.com/src-openeuler/gcc-10/issues/I8G049)  [I8GO7N](https://gitee.com/src-openeuler/gcc/issues/I8GO7N) |
| openEuler20.03-LTS-SP4 RC3 | 300w+      | 部分测试套执行失败 | 1            | bstest               | [I8IXMI](https://gitee.com/src-openeuler/gcc-10/issues/I8IXMI) |
| openEuler20.03-LTS-SP4 RC4 | 300w+      | 部分测试套执行失败 | 0            | NA                   | NA                                                           |
| openEuler20.03-LTS-SP4 RC5 | 100w+      | 部分测试套执行失败 | 0            | NA                   | NA                                                           |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

# 5     附件

*无*
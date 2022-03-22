![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期        | 修订   版本 | 修改描述 | 作者 |
| ----       | ----------- | -------- | ---- |
| 2022/03/23 |   v1.0      | GCC测试报告 | 王丹 |


摘要：依据测试要求，对GCC编译器特性进行各测试套执行

 

# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler22.03 RC2 | 2022-02-25 | 2022-03-01 |
| openEuler22.03 RC3 | 2022-03-05 | 2022-03-10 |
| openEuler22.03 RC4 | 2022-03-12 | 2022-03-17 |
| openEuler22.03 RC5 | 2022-03-25 | 2022-03-27 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| TaiShan 200 | 96U 512G | aarch64 |
| TaiShan 200K | 96U 256G | aarch64 codedb测试专用 |
| TaiShan 200 | 96U 256G | aarch64 |
| 虚拟机 | 4U 4G | x86_64 |

# 3     测试结论概述

## 3.1   测试整体结论

GCC编译器测试，共转测11个特性（预取：-fprefetch-loop-arrays=[value]、--param param-prefetch-func-topn=n、--param param-prefetch-ref-topn=n、--param param-high-loop-execution-rate=n；反馈优化：-fauto-profile、-fprofile-correction、-fcache-misses-profile、-fauto-bolt、-fbolt-use、-fbolt-target=param、-fbolt-option=param），主要覆盖基本功能测试，继承特性选项测试，浮点精度测试，汇编一致性测试，可靠性测试，Fuzz测试，覆盖率测试，asan测试，自举测试，x86交叉测试和反馈优化专项测试，发现问题已解决，回归通过，无遗留风险，整体质量良好。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 基本功能测试 | 执行测试套：冒烟测试、dejanu、库上特性用例、bstest、llvmcase、Anghabench、jotai-benchmarks、codeDB基本功能正常，发现问题全部解决，回归通过，无风险； |
| 特性选项测试 | 通过deja测试套分别执行预取特性，特性功能使用正常； |
| 浮点精度测试 | 执行测试套FPTEST，无新增FAIL用例； |
| 汇编一致性测试 | 根据speccpu2017生成二进制并反汇编，比对结果一致； |
| 可靠性测试 | 执行超规格测试用例，全部执行通过； |
| Fuzz测试 | csmith（c\c++浮点版本）、yarpgen（c\c++）、ccg、randprog等随机测试套件分别运行100w+用例，无遗留问题； |
| 覆盖率测试 | 测试增量代码覆盖率，最终结果分别为lines:91.0%，functions:90.4%，均高于85%要求； |
| asan测试 | 测试增量代码是否存在内存泄露问题，发现问题全部解决，回归通过，无风险； |
| 自举测试 | arm环境编译gcc源码，生成二进制，并成功运行deja等测试套； |
| x86交叉测试 | x86环境编译gcc源码，生成二进制，并成功运行deja等测试套； |
| 反馈优化专项测试 | 分别测试冒泡排序和npb应用来验证反馈优化特性功能，全部执行通过； |


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
| openEuler22.03 RC2 | 200w+ | 除codedb外其他均成功 | 1     | codeDB中wannier、xtb应用编译失败 |[I4VSDZ](https://e.gitee.com/open_euler/dashboard?issue=I4VSDZ)   |
| openEuler22.03 RC3 | 200w+ | 除asan测试外其他均成功 |  1    | asan结合npb应用测试发现内存泄露 |[I4XPLH](https://gitee.com/openeuler/gcc/issues/I4XPLH)   |
| openEuler22.03 RC4 | 100w+ | 全部通过 |  0    |  NA                  |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议


# 5     附件

*无*

 



 

 

![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期        | 修订   版本 | 修改描述 | 作者 |
| ----       | ----------- | -------- | ---- |
| 2022/09/13 |   v1.0      | GCC测试报告 | 王丹 |


摘要：依据测试要求，对GCC编译器特性进行基础功能测试、源码相关测试及回归测试

 

# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| 930 RC1 | 2022-08-09 | 2022-08-19 |
| 930 RC2 | 2022-08-22 | 2022-08-30 |
| 930 RC3 | 2022-08-31 | 2022-09-07 |
| 930 RC4 | 2022-09-08 | 2022-09-16 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| TaiShan 200 | 96U 512G | aarch64 |
| TaiShan 200K | 96U 256G | aarch64 codedb测试专用 |
| 虚拟机 | 64U 16G | x86_64 |

# 3     测试结论概述

## 3.1   测试整体结论

GCC编译器测试，共转测6个特性选项（ccmp：-fccmp2；矢量化：-ftree-slp-transpose-vectorize；结构体内存布局优化：struct layout重构：-fipa-struct-reorg=1,-fipa-struct-reorg=2；DFE优化：-fipa-struct-reorg=3；Array-widen-compare:-farray-widen-compare），主要覆盖基本功能测试，Fuzz测试，可靠性测试， 浮点精度测试，汇编一致性测试， 自举测试，x86交叉测试和反馈优化专项测试 。共发现问题2个，其中有效问题2个。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 基本功能测试 | 执行测试套：冒烟测试、dejanu、库上特性用例、bstest、llvmcase、Anghabench、codeDB基本功能正常，遗留问题2个； |
| 浮点精度测试 | 执行测试套FPTEST，无新增FAIL用例； |
| 汇编一致性测试 | 根据speccpu2017生成二进制并反汇编，比对结果一致； |
| 可靠性测试 | 执行超规格测试用例，全部执行通过； |
| Fuzz测试 | csmith（c\c++浮点版本）、yarpgen（c\c++）等随机测试套件分别运行100w+用例，无遗留问题； |
| 自举测试 | arm环境编译gcc源码，生成二进制，并成功运行deja测试套； |
| x86交叉测试 | x86环境编译gcc源码，生成二进制，并成功运行deja测试套； |
| 反馈优化专项测试 | 使用codedb应用来验证反馈优化特性功能，全部执行通过； |



## 3.2  约束说明

无

## 3.3  问题分析
openEuler GCC930版本共发现问题4个，其中有效问题4个，遗留问题单3个未修复，其中遗留问题2和3为GCC630版本遗留至本版本

### 3.3.1 遗留问题影响以及规避措施
|  序号    | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 |
| ------ | ------ | ------ | ------ | ------ | ------ |
|  1    | [I5M8W7](https://gitee.com/openeuler/gcc/issues/I5M8W7) | -O3 -flto -fipa-struct-reorg=1 -flto-partition=one编译vtk ICE:lto1: internal compiler error(at dwarf2out.c:31353) | 一般 | strcut-reorg/relayout 分析有误，可在GCC编译阶段进行检测报错，对程序运行无影响 | fipa-struct-reorg=[1,2,3] |
| 2 | [13](https://codehub-y.huawei.com/Computing_Product_Line_Compiler_Group/openeuler-gcc/issues/13) | -O3 -flto -fipa-struct-reorg=1 -flto-partition=one编译ICE:during RTL pass: final（at dwarf2out.c:25112） | 一般 | strcut-reorg/relayout 分析有误，可在GCC编译阶段进行检测报错，对程序运行无影响 | fipa-struct-reorg=[1,2,3,4,5] |
| 3 | [36](https://codehub-y.huawei.com/Computing_Product_Line_Compiler_Group/openeuler-gcc/issues/36) | -O3 -fipa-struct-reorg=5编译ICE:during GIMPLE pass:pre(at tree-ssa-sccvn.c:6005) | 一般 | semi-relayout改写有误，可在GCC编译阶段进行检测报错，对程序运行无影响 | 不使用-fipa-struct-reorg=[4,5] |

### 3.3.2 问题统计
|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 | 非问题 |
| ------ | -------- | ---- | ---- | ---- | ------ | ------ |
| 数目   |  4    | 0     |  4  | 0    | 0       | 0       |
| 百分比 |  100%     |  0    |  100%  |  0    |  0      |  0   |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 | 发现问题测试活动 |  备注 |
| -------- | ---------- | ------------ | ------------ | --------- | -------- |
| 930 RC1  | 200w+ | 除codedb外其他均成功;kernel编译失败 | 4   | codeDB应用编译失败；kernel编译失败 |  |
| 930 RC4 | 200w+ | 除codedb外其他均成功 |  3  |  codeDB应用编译失败  |  |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议


# 5     附件

*无*

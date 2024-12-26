![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2024/12/20 | v1.0 | 创建 | juntianlinux |

关键词： oneAPI, level-zero, Intel Graphics Compiler, DPC++

摘要：oneAPI底层软件在openEuler的集成测试报告

# 1     特性概述

oneAPI的目标是提供一种跨行业、开放、基于标准的统一编程模型，并为多种架构（如 CPU、GPU、FPGA 和专用加速器）提供统一的开发者体验。oneAPI规范扩展了现有的开发者编程模型，通过直接的并行编程语言（Data Parallel C++）或者一组加速API以及低级硬件抽象接口（Level Zero）来支持跨架构编程，从而支持多种加速硬件和处理器平台。我们在openEuler 24.03 LTS SP1引入了oneAPI底层框架和各类依赖包的支持，并适配了oneAPI的运行态支持，各类加速API支持以及上层开发套件的安装适配等。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

oneAPI相关软件包在openEuler 24.03 LTS和 24.03 LTS SP1 rc5 进行两轮验证，目前主要验证了x86平台的软件包。

| 版本名称               | 测试模块           | 测试起始时间 | 测试结束时间 |
|-----------------------|-------------------|------------|------------|
| openEuler-24.03-LTS    | 下述增量的软件包及oneAPI组件 | 2024/12/03 | 2024/12/20 |
| openEuler-24.03-LTS-SP1 rc5   | 下述增量的软件包及oneAPI组件 | 2024/12/03 | 2024/12/20 |

增量软件包信息：

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| level-zero 1.13.1| 2024-12-03 | 2024-12-20 |
| gmmlib 22.3.10| 2024-12-03 | 2024-12-20 |
| intel-graphics-compiler 1.0.14828.26| 2024-12-03 | 2024-12-20 |
| metee 3.1.5| 2024-12-03 | 2024-12-20 |
| igsc 0.8.9| 2024-12-03 | 2024-12-20 |
| cm-compiler 1.0.144| 2024-12-03 | 2024-12-20 |
| compute-runtime 23.30.26918.50| 2024-12-03 | 2024-12-20 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| Intel Granite Rapids 服务器 | 256核/1TB内存/Arc 770 |      |
|          |              |      |

# 3     测试结论概述

openEuler 24.03-LTS-SP1上的Intel oneAPI底层依赖包和运行态软件包测试完成了oneAPI对于sample code的编译运行，大模型基于oneAPI加速框架的正确支持，对于level-zero, gmmlib, intel-graphics-compiler, metee, igsc, cm-compiler, compute-runtime等软件包的功能测试，测试结果符合预期，未发现问题。


# 4 详细测试结论

## 4.1   特性测试结论

| 序号 | 特性名称 | 特性质量评估               | 备注     |
| ---- | -------- | -------------------------- | -------- |
| 1    | Build DPC++ Sample Code | █ |  |
| 2    | Run DPC++ Sample Code | █ |  |
| 3    | Install oneAPI Basekit | █ |  |
| 4    | Use oneAPI Basekit for LLM | █ |  |

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
|---------|------------|-------------|-------------|
| oneAPI 2024.2.1  | 14 | 100% 通过 | 0 |

*数据项说明：基于oneAPI-sample测试整体编译和运行态结果*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

针对其他体系结构和服务器GPU的测试

# 6     附件

测试安装和使用文档：https://gitee.com/openeuler/intel-oneapi/blob/master/getting_started.md

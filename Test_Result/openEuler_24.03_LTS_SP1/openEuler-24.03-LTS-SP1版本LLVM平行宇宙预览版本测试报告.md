![avatar](../../images/openEuler.png)


版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改描述                                            | 作者    |
| :--------- | :------- | :-------------------------------------------------- | :------ |
| 2024/12/30 | 1.0.0    | LLVM 平行宇宙计划 24.03 SP1 RISC-V Preview 版本测试报告 | 吴洁、周嘉诚 |
|            |          |                                                     |         |


关键词：

openEuler LLVM Parallel Universe Project, Preview, RISC-V

摘要：

文本主要描述 openEuler LLVM 平行宇宙计划 24.03 SP1 RISC-V Preview 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。


# 1     特性概述

openEuler 是一款开源操作系统。当前 openEuler 内核源于 Linux，支持鲲鹏、RISC-V 及其它多种架构处理器，能够充分释放计算芯片的潜能，是面向全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

openEuler LLVM 平行宇宙计划探索采用 LLVM 编译器套件替换 GCC 套件构建发行版及其组成软件包。

本文主要描述 openEuler LLVM 平行宇宙计划 24.03 SP1 RISC-V Preview 版本的总体测试活动。其按照社区开发模式进行运作，测试报告覆盖功能，性能等测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 24.03 LTS SP1 LLVM 平行宇宙计划 RISC-V Preview 版本 | 2024/12/2 | 2024/12/30 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  QEMU 虚拟机  |  8 核心 16G 内存  | 版本 9.2.0 |
|  进迭时空 MusePi  |  进迭时空 K1 8 核心 16G 内存  |      |

# 3     测试结论概述

## 3.1   测试整体结论

openEuler 24.03 LTS SP1 LLVM 平行宇宙计划 RISC-V Preview 版本，共计执行 2751 个用例，主要覆盖了功能、兼容性、性能、可靠性及安全测试，通过 fuzz 和 7*24 的长稳测试，发现问题已解决，回归通过，无遗留风险，整体质量良好

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 |      |
| 功能测试 | 新增特性测试 |      |
| 兼容性测试 |  南向兼容性测试    |         |
| 性能测试 | unixbench / lmbench / stream  |         |
| 安全测试 | nmap 扫描 |    |
| 可靠性测试 | ltpstress |   |

## 3.2   约束说明

无。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题。

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |     249     |   0   |   0   |      |    249    |
| 百分比 |     100%     |   0%   |   0%   |   0%   |    100%    |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | BaseOS | <font color=green>■</font> |   |
| 2 | Everything | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | Epol | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

#### 南向兼容性

南向兼容性测试分板卡测试和整机适配测试两个部分，RISC-V 架构当前南向兼容性测试只做整机适配的测试。

本版本作为 RISC-V 架构 24.03 SP1 版本的平行 Preview 版本，牵引达成以下清单的兼容性基线目标，使能目标硬件。主要使用社区硬件兼容性测试工具 oec-hardware 进行测试，适配完成后将在社区发布此版本的兼容性清单。

| **整机厂商** | **整机型号** | **CPU型号**   | **测试主体**      |
| ------------ | ------------ | ------------- | ----------------- |
| 进迭时空 | MusePi | 进迭时空 K1 | openEuler 平行宇宙计划 |

#### 北向兼容性

Preview 版本暂不涉及。

## 4.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|  nmap  |    端口扫描     |  暴露端口符合预期  |

## 4.4 可靠性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 长稳测试 |  ltpstress  | 稳定运行 7*24 小时无预期外新增异常 |

## 4.5 性能测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 性能 |  unixbench  | 对比硬件基线总体单核、多核均小幅提升，部分子项上下偏差较大，不劣化 5% 以内目标已达成 |
| 性能 |  lmbench  | 对比硬件基线带宽小幅提升延迟小幅降低，部分子项上下偏差较大，不劣化 5% 以内目标已达成 |
| 性能 |  stream  | 对比硬件基线带宽小幅增加延迟小幅减少，部分子项上下偏差较大，不劣化 5% 以内目标已达成 |

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|  openEuler 24.03 LTS SP1 LLVM平行宇宙计划 RISC-V Preview 版本  |  2751  |  PASS  |  0  |


## 5.2   后续测试建议

无

# 6     附件

无

 



 

 
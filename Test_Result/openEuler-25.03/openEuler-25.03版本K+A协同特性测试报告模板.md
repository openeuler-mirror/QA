![avatar](../../images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|   2025/03/18   |       v1.0      |     初稿     |   sevenjj   |

关键词： vllm、加速、cpu调度

摘要：结合高效计算调度与优化策略，为LLM推理提供更快、更稳定、更可扩展的解决方案。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|    LLM    |     Large Language Model     |     大语言模型     |

# 1     特性概述

通过CPU侧并行下发算力，包括Schedule（调度）、Prepare Input（准备数据）、Ray框架、Sample（模型后处理）、框架后处理等流程，实现算子下发时长提速50%，算子包含Attention算子、MLP算子、CausaLLM(bisa)算子。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|     原生开发 25.03     |       2025/03/10       |       2025/03/15       |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|     Atlas 800T A2     |      NA        |   系统openEuler22.03-LTS-SP4   |

# 3     测试结论概述

## 3.1   测试整体结论

k+A协同特性，实现CPU调度策略优化，算子速度下发提速超过50%，共计执行8个用例，主要覆盖了Atlas 800T A2上支持VLLM框架运行的功能测试和算子下发速度的性能测试，算子下发基线值32ms，性能测试值9.65ms，提速超过50%，未发现问题，无遗留风险，整体质量良好。

## 3.2   约束说明

模型使用mmGPT 65B

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |    0      |   0   |   0   |   0   |     0   |
| 百分比 |     NA    |   NA   |   NA   |   NA   |    NA    |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

不涉及

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | Atlas 800T A2上支持VLLM框架运行 | <font color=green>■</font> | 功能测试正常  |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

不涉及

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 基线值 | 实际值 | 测试结论 |
| ------- | ------- | ------ | ------- |------- |
|    算子下发时长     |    NA     |    32ms    |    9.65ms     | 通过     |

### 4.3.2 可靠性/韧性测试结论

不涉及

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论
| 测试类型 | 测试内容 | 测试结论 | 链接 |
| ------- | ------- | -------- | -------- |
|    资料测试     |     检视内容正确性，易用性    |     通过     | [vllm部署指南](https://gitee.com/openeuler/docs/pulls/14705) |

## 4.5 其他测试结论

不涉及

# 5     测试执行

## 5.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|     原生开发 25.03     |      8      |       succeed       |       0       |

# 6     附件

不涉及
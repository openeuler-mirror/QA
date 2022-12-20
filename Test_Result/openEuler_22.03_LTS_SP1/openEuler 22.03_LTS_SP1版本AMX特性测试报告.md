![avatar](../../images/openEuler.png)


版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2022-12-20 | 1.0 | 创建 | Jincheng |


关键词： 
Advanced Matrix eXtension
 

摘要：
本报告主要描述基于openEuler 22.03_LTS_SP1版本进行Intel AMX在AI相关组件的测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。
 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| AMX | Advanced Matrix eXtension |          |
| INT8 | INT8 | 8位整型 |
| BF16 | bfloat16 | Google Brain 16位半精度浮点 |

# 1     特性概述

Intel Advanced Matrix Extensions (Intel AMX)是英特尔在即将发布的第四代英特尔至强可扩展处理器上引入的全新的加速引擎，通过指令集层面的支持来显著加速深度学习算法中的张量计算。它包含一组被命名为 TILE 的二维寄存器，以及称之为 TMUL（Tile Matrix Multiply Unit）的硬件逻辑，用来实现加速基于 TILE 寄存器的矩阵运算。
Intel AMX 支持 INT8 和 BF16 这两种业界广泛应用的数据类型，拥有可扩展的硬件架构和优化的软件生态（AI Framework，Libraries & Toolkits），是英特尔至强可扩展处理器内建的适配 AI 加速场景的重要构件。


# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 22.03_LTS_SP1 Test round 3 | 2022-12-09  | 2022-12-20 |


描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| Intel(R) Xeon(R) Platinum Sapphire Rapids |              |      |

# 3     测试结论概述

## 3.1   测试整体结论

AMX特性涉及到软件包oneDNN和Tensorflow集成。
共计执行6个oneDNN单元测试用例，主要覆盖了AMX对数据类型BF16和INT8的测试。
以及一个在Tensorflow中运行混合精度MNIST模型的AMX集成测试用例。
发现问题已解决，回归通过，无遗留风险，整体质量良好。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 功能测试 | 已通过oneDNN单元测试： test_gemm_bf16bf16bf16, test_gemm_bf16bf16f32, test_gemm_s8s8s32, test_gemm_s8u8s32, test_gemm_u8s8s32, test_gemm_u8u8s32 |
| 专项测试 | 已通过Tensorflow混合精度集成测试：https://www.intel.com/content/www/us/en/developer/articles/guide/getting-started-with-automixedprecisionmkl.html  |

## 3.2   约束说明

需要使用第四代英特尔至强可扩展处理器。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无

### 3.3.2 问题统计

无

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 22.03_LTS_SP1 Test round 3 | oneDNN AMX unittest | 6 | All Pass | 0 |
| openEuler 22.03_LTS_SP1 Test round 3 | Tensorflow 集成 | 1 | All Pass | 0 |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

无

# 5     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 

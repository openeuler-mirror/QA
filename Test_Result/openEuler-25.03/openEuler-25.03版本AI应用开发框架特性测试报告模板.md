![avatar](../../images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|   2025/03/18   |       v1.0      |     初稿     |   sevenjj   |

关键词： AI、embedding、数据集、解析、微调

摘要：支持企业文档自动化解析、生成数据集

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|    AI    |     Artificial Intelligence     |     人工智能     |

# 1     特性概述

以资产的维度可视化方式管理企业本地文档资产，提供自动解析文档的能力，并提供脚本基于文档解析结果生成问答对数据集，提供embeddding微调脚本，基于数据集微调bge系列embedding模型，提高召回率。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|     AI-embedding-25.03 RC1     |       2025/02/24       |       2025/03/02       |
|     AI-embedding-25.03 RC2     |       2025/03/03       |       2025/03/09       |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|     NA     |      NA        |   NA   |

# 3     测试结论概述

## 3.1   测试整体结论

AI应用开发框架特性，提供数据治理工具，支持企业知识数据构建智能问答系统，包括数据文档的解析自动化及数据集生成，并基于用户提供的问答对信息，进行embedding模型微调，构建企业embeddding模型，共计执行47个用例，主要覆盖了文档解析自动化、数据集生成自动化和数据集跳跳embedding模型的功能测试，以及1.97GB的文档解析和模型微调的性能测试，共发现问题7个，整体准确率91%，所有问题已解决，回归通过，无遗留风险，整体质量良好。

## 3.2   约束说明

文档解析中，单个资产文档数量2000+，总大小不超过2GB

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |    7      |   0   |   0   |   5   |     2   |
| 百分比 |     100%     |   0%   |  0%   |   71%   |    29%    |

| 序号 | 问题单号 | 问题简述 | 问题级别 | 
| --- | ------- | ------ | ------- |
| 1 | [IBOB7B](https://gitee.com/openeuler/euler-copilot-witchaind-web/issues/IBOB7B?from=project-issue) | 在web界面删除资产库时，删除的提示信息不会自动消失，需要人工点击关闭 | 次要 |
| 2 | [IBOBH3](https://gitee.com/openeuler/euler-copilot-witchaind-web/issues/IBOBH3?from=project-issue) | 文档解析的模型选择的选项与解释显示不一致 | 次要 |
| 3 | [IBP9Z4](https://gitee.com/openeuler/euler-copilot-witchaind-web/issues/IBP9Z4?from=project-issue) | 在文档上传时，选中本地文档后，web页面默认不勾选文档，需要手动再次勾选 | 次要 |
| 4 | [IBP9UT](https://gitee.com/openeuler/euler-copilot-rag/issues/IBP9UT?from=project-issue) | 导入文档数量超过限制时，可以选择文件，但不能进行解析，需要手动挨个删除超出限制的文件 | 次要 |
| 5 | [IBP9WX](https://gitee.com/openeuler/euler-copilot-rag/issues/IBP9WX?from=project-issue) | 文档解析时，不能批量更改解析配置，且在配置信息处更改配置时，只有之后新上传的文档解析生效 | 次要 |
| 6 | [IBRKM2](https://gitee.com/openeuler/euler-copilot-rag/issues/IBRKM2?from=project-issue) | 微调推荐建议，学习率改进建议不够明确 | 不重要 |
| 7 | [IBRKOC](https://gitee.com/openeuler/euler-copilot-rag/issues/IBRKOC?from=project-issue) | 微调推荐命令结果不能直接使用，易用性差 | 不重要 |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

不涉及

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 文档解析自动化 | <font color=green>■</font> | 功能测试正常  |
| 2 | 数据集生成自动化 | <font color=green>■</font> |  功能测试正常 |
| 3 | 数据集微调bge系列embedding模型 | <font color=green>■</font> |  功能测试正常 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

不涉及

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|    文档解析时长     |    general模式     |    1.5h    |    通过     |
|    文档解析时长     |    ocr模式     |    2h    |    通过     |
|    文档解析时长     |    enhanced模式     |    3h    |    通过     |
|    模型微调时长     |    NA     |    36h    |    通过     |

### 4.3.2 可靠性/韧性测试结论

不涉及

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论
| 测试类型 | 测试内容 | 测试结论 | 链接 |
| ------- | ------- | -------- | -------- |
|    资料测试     |     检视内容正确性，易用性    |     通过     | [应用开发框架工具使用指南](https://gitee.com/openeuler/docs/pulls/14693) |

## 4.5 其他测试结论

不涉及

# 5     测试执行

## 5.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|     AI-embedding-25.03 RC1    |      31      |       succeed       |       5       |
|     AI-embedding-25.03 RC2    |      16      |       succeed       |       2       |


# 6     附件

不涉及
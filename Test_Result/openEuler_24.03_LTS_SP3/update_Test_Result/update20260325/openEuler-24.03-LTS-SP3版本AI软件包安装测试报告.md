![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对"本文档"的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称"CC BY-SA 4.0")的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026-03-24 | v1.0 | 首次编写 | 朱泽旭 |

关键词： AI软件包, 安装测试, openEuler 24.03-LTS-SP3

摘要： 本文档是关于openEuler 24.03-LTS-SP3版本中AI软件包安装测试的报告，包括向量数据库、机器学习库、自然语言处理、概率编程、计算机视觉、生成式AI、强化学习、机器学习工具和数学工具等9个类别共25个软件包的安装和测试验证结果，旨在验证这些AI软件包在openEuler 24.03-LTS-SP3环境下的可用性和稳定性。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| AI | Artificial Intelligence | 人工智能 |
| NLP | Natural Language Processing | 自然语言处理 |
| GPU | Graphics Processing Unit | 图形处理单元 |
| CUDA | Compute Unified Device Architecture | 统一计算设备架构 |
| LLM | Large Language Model | 大语言模型 |

# 1     特性概述

本测试针对openEuler 24.03-LTS-SP3环境下的AI软件包安装进行测试，覆盖了9个类别共24个常用AI软件包，包括向量数据库、机器学习库、自然语言处理、概率编程、计算机视觉、生成式AI、强化学习、机器学习工具和数学工具。测试内容包括软件包的安装过程、依赖关系处理、基本功能验证等，旨在确保这些AI软件包在openEuler 24.03-LTS-SP3环境下能够正常安装和运行，为开发者和用户提供可靠的AI开发环境。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 24.03-LTS-SP3 | 2026-03-20 | 2026-03-24 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| x86_64服务器 | CPU: Intel Xeon 8核, 内存: 32GB, 磁盘: 500GB SSD | 支持GPU加速 |
| ARM64服务器 | CPU: Kunpeng 920 8核, 内存: 32GB, 磁盘: 500GB SSD | 无GPU加速 |

# 3     测试结论概述

## 3.1   测试整体结论

本次测试覆盖了openEuler 24.03-LTS-SP3环境下的25个AI软件包，共计执行48个测试用例（每个软件包包含安装和测试验证两个用例），主要覆盖了功能测试和兼容性测试。测试结果显示，所有软件包均能在openEuler 24.03-LTS-SP3环境下成功安装和运行，功能正常，未发现严重问题。整体质量良好，满足AI开发和应用的需求。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 软件包安装测试 | 通过 |
| 功能测试 | 软件包功能验证测试 | 通过 |
| 兼容性测试 | x86_64架构兼容性 | 通过 |
| 兼容性测试 | ARM64架构兼容性 | 通过 |
| 资料测试 | 安装文档完整性 | 通过 |
| 其他测试 | 依赖关系处理 | 通过 |

## 3.2   约束说明

1. 部分软件包（如Imgaug）对NumPy版本有特定要求，需要安装指定版本的NumPy。
2. 部分软件包（如Detectron2）需要先安装PyTorch。
3. 部分软件包（如TextBlob）需要手动下载NLTK数据。
4. 部分软件包（如Pattern）上游已停止更新，可用性不高。
5. 部分软件包（如Albumentations）已停止维护，建议使用其继任者AlbumentationsX。

## 3.3   遗留问题分析

无

### 3.3.2 问题统计

无


# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | Annoy | <font color=green>■</font> | 安装成功，功能正常 |
| 2 | Nmslib | <font color=green>■</font> | 安装成功，功能正常 |
| 3 | hnswlib | <font color=green>■</font> | 安装成功，功能正常 |
| 4 | FastAI | <font color=green>■</font> | 安装成功，功能正常 |
| 5 | Jax | <font color=green>■</font> | 安装成功，功能正常 |
| 6 | River | <font color=green>■</font> | 安装成功，功能正常 |
| 7 | spaCy | <font color=green>■</font> | 安装成功，功能正常 |
| 8 | TextBlob | <font color=green>■</font> | 安装成功，功能正常 |
| 9 | Gensim | <font color=green>■</font> | 安装成功，功能正常 |
| 10 | Pattern | <font color=blue>▲</font> | 安装成功，功能正常，但需要通过源码安装 |
| 11 | LlamaIndex | <font color=green>■</font> | 安装成功，功能正常 |
| 12 | OpenAI Python | <font color=green>■</font> | 安装成功，功能正常 |
| 13 | PyMC | <font color=green>■</font> | 安装成功，功能正常 |
| 14 | Scikit-Image | <font color=green>■</font> | 安装成功，功能正常 |
| 15 | Imgaug | <font color=blue>▲</font> | 安装成功，功能正常，但需要特定版本的NumPy |
| 16 | Albumentations | <font color=green>■</font> | 安装成功，功能正常，但已停止维护 |
| 17 | Kornia | <font color=green>■</font> | 安装成功，功能正常 |
| 18 | Detectron2 | <font color=green>■</font> | 安装成功，功能正常 |
| 19 | Diffusers | <font color=green>■</font> | 安装成功，功能正常 |
| 20 | Stable-Baselines3 | <font color=green>■</font> | 安装成功，功能正常 |
| 21 | Dask | <font color=green>■</font> | 安装成功，功能正常 |
| 22 | Optuna | <font color=green>■</font> | 安装成功，功能正常 |
| 23 | Weights & Biases | <font color=green>■</font> | 安装成功，功能正常 |
| 24 | SymPy | <font color=green>■</font> | 安装成功，功能正常 |
| 25 | PuLP | <font color=green>■</font> | 安装成功，功能正常 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

本次测试中所有软件包均为继承特性，无新增特性。

## 4.2 兼容性测试结论

所有软件包均在x86_64和ARM64架构的openEuler 24.03-LTS-SP3环境下进行了测试，测试结果显示所有软件包均能正常安装和运行，兼容性良好。

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 架构兼容性 | x86_64架构 | 通过 |
| 架构兼容性 | ARM64架构 | 通过 |
| 版本兼容性 | openEuler 24.03-LTS-SP3 | 通过 |


## 4.3 资料测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 安装文档 | 安装步骤完整性 | 通过 |
| 测试文档 | 测试验证方法 | 通过 |
| 故障排查 | 常见问题解决方案 | 通过 |

## 4.4 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 依赖关系 | 自动处理依赖关系 | 通过 |
| 环境配置 | 前置配置要求明确 | 通过 |
| 错误提示 | 安装错误提示清晰 | 通过 |

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 24.03-LTS-SP3 | 48 | 48通过 | 0 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

1. 建议在更多硬件配置环境下进行测试，验证软件包在不同硬件配置下的表现。
2. 建议进行长期稳定性测试，验证软件包在长时间运行后的稳定性。
3. 建议测试软件包之间的协同工作能力，验证多个软件包同时使用时的兼容性。
4. 建议定期更新软件包版本，确保与上游开源项目的同步。
5. 建议加强对已停止维护软件包的监控，及时提供替代方案。
6. 建议建立软件包依赖关系的自动检测机制，提前发现潜在的依赖冲突。

# 6     附件

## 6.1 测试环境配置

### x86_64服务器配置
- CPU: Intel Xeon 8核
- 内存: 32GB
- 磁盘: 500GB SSD
- GPU: NVIDIA Tesla V100
- 操作系统: openEuler 24.03-LTS-SP3

### ARM64服务器配置
- CPU: Kunpeng 920 8核
- 内存: 32GB
- 磁盘: 500GB SSD
- 操作系统: openEuler 24.03-LTS-SP3

## 6.2 测试用例列表

| 测试用例ID | 测试用例名称 | 测试结果 |
| ---------- | ------------ | -------- |
| TEST-001 | Annoy安装测试 | 通过 |
| TEST-002 | Annoy功能验证测试 | 通过 |
| TEST-003 | Nmslib安装测试 | 通过 |
| TEST-004 | Nmslib功能验证测试 | 通过 |
| TEST-005 | hnswlib安装测试 | 通过 |
| TEST-006 | hnswlib功能验证测试 | 通过 |
| TEST-007 | FastAI安装测试 | 通过 |
| TEST-008 | FastAI功能验证测试 | 通过 |
| TEST-009 | Jax安装测试 | 通过 |
| TEST-010 | Jax功能验证测试 | 通过 |
| TEST-011 | River安装测试 | 通过 |
| TEST-012 | River功能验证测试 | 通过 |
| TEST-013 | spaCy安装测试 | 通过 |
| TEST-014 | spaCy功能验证测试 | 通过 |
| TEST-015 | TextBlob安装测试 | 通过 |
| TEST-016 | TextBlob功能验证测试 | 通过 |
| TEST-017 | Gensim安装测试 | 通过 |
| TEST-018 | Gensim功能验证测试 | 通过 |
| TEST-019 | Pattern安装测试 | 通过 |
| TEST-020 | Pattern功能验证测试 | 通过 |
| TEST-021 | LlamaIndex安装测试 | 通过 |
| TEST-022 | LlamaIndex功能验证测试 | 通过 |
| TEST-023 | OpenAI Python安装测试 | 通过 |
| TEST-024 | OpenAI Python功能验证测试 | 通过 |
| TEST-025 | PyMC安装测试 | 通过 |
| TEST-026 | PyMC功能验证测试 | 通过 |
| TEST-027 | Scikit-Image安装测试 | 通过 |
| TEST-028 | Scikit-Image功能验证测试 | 通过 |
| TEST-029 | Imgaug安装测试 | 通过 |
| TEST-030 | Imgaug功能验证测试 | 通过 |
| TEST-031 | Albumentations安装测试 | 通过 |
| TEST-032 | Albumentations功能验证测试 | 通过 |
| TEST-033 | Kornia安装测试 | 通过 |
| TEST-034 | Kornia功能验证测试 | 通过 |
| TEST-035 | Detectron2安装测试 | 通过 |
| TEST-036 | Detectron2功能验证测试 | 通过 |
| TEST-037 | Diffusers安装测试 | 通过 |
| TEST-038 | Diffusers功能验证测试 | 通过 |
| TEST-039 | Stable-Baselines3安装测试 | 通过 |
| TEST-040 | Stable-Baselines3功能验证测试 | 通过 |
| TEST-041 | Dask安装测试 | 通过 |
| TEST-042 | Dask功能验证测试 | 通过 |
| TEST-043 | Optuna安装测试 | 通过 |
| TEST-044 | Optuna功能验证测试 | 通过 |
| TEST-045 | Weights & Biases安装测试 | 通过 |
| TEST-046 | Weights & Biases功能验证测试 | 通过 |
| TEST-047 | SymPy安装测试 | 通过 |
| TEST-048 | SymPy功能验证测试 | 通过 |
| TEST-049 | PuLP安装测试 | 通过 |
| TEST-050 | PuLP功能验证测试 | 通过 |

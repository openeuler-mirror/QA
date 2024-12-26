![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2024/12/20 | v1.0 | 创建 | juntianlinux |

关键词： OpenVINO, pytroch_frontend, level-zero, IPEX

摘要：OpenVINO在openEuler的集成测试报告

# 1     特性概述

OpenVINO是一套开源的AI工具套件和运行库，其能用于优化几乎各类主流框架的深度学习模型，并在各种Intel处理器和加速器以及其他硬件平台如ARM上以最佳性能进行部署并高效提供AI服务。我们从openEuler 24.03 LTS SP1开始，提供了OpenVINO原生的适配和集成，从而在openEuler上提供了完整的OpenVINO的计算能力。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

OpenVINO相关软件包在openEuler 24.03 LTS和 24.03 LTS SP1 rc5 进行两轮验证，目前主要验证了x86平台的软件包。

| 版本名称               | 测试模块           | 测试起始时间 | 测试结束时间 |
|-----------------------|-------------------|------------|------------|
| openEuler-24.03-LTS    | 下述OpenVINO增量的软件包 | 2024/12/05 | 2024/12/20 |
| openEuler-24.03-LTS-SP1 rc5   | 下述OpenVINO增量的软件包 | 2024/12/05 | 2024/12/20 |

增量软件包信息：

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| libopenvino 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino-auto-batch-plugin 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino-auto-plugin 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino-devel 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino-intel-cpu-plugin 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino-intel-gpu-plugin 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino_ir_frontend 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino_onnx_frontend 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino_paddle_frontend 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino_pytorch_frontend 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino_tensorflow_frontend 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino_tensorflow_lite_frontend 2024.3.0| 2024-12-05 | 2024-12-20 |
| openvino-samples 2024.3.0| 2024-12-05 | 2024-12-20 |
| libopenvino-hetero-plugin 2024.3.0| 2024-12-05 | 2024-12-20 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| Intel Granite Rapids 服务器 | 256核/1TB内存/Arc 770 |      |
|          |              |      |

# 3     测试结论概述

openEuler 24.03-LTS-SP1上针对完整集成OpenVINO框架和运行环境的测试，安装了OpenVINO在openEuler中集成的软件包及编译运行了sample code，同时利用OpenVINO的推理功能运行了从Open Model Zoo下载的预训练模型。软件包的功能测试，测试结果符合预期，未发现问题。


# 4 详细测试结论

## 4.1   特性测试结论

| 序号 | 特性名称 | 特性质量评估               | 备注     |
| ---- | -------- | -------------------------- | -------- |
| 1    | Build OpenVINO Sample Code | █ |  |
| 2    | Run OpenVINO Sample Code | █ |  |
| 3    | Run Pre-trained Models | █ |  |

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
|---------|------------|-------------|-------------|
| OpenVINO 2024.3.0 Sample Code | 6 | 100% 通过 | 0 |
| OpenVINO 2024.3.0 Pre-trained Models  | 4 | 100% 通过 | 0 |

*数据项说明：基于OpenVINO测试示例编译和推理运行的结果*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

针对其他体系结构和服务器GPU的测试

# 6     附件

测试安装和使用文档：https://gitee.com/openeuler/intel-openvino/blob/master/docs/openvino_samples.md

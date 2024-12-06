![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2024/12/06 | v1.0 | 创建 | allen-shi |

关键词： QAT intel-qatlib intel-qatzip intel-qatengine

摘要：Intel QuickAssist Technology(QAT)软件包测试报告

# 1     特性概述

Intel QuickAssist Technology(QAT)提供了将加解密和压缩服务从CPU卸载的硬件加速能力，来显著提升标准平台解决方案的性能和效率。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| intel-qatlib 24.02.0-1 | 2024-12-03 | 2024-12-03 |
| intel-qatzip 1.2.0-1 | 2024-12-04 | 2024-12-04 |
| intel-qatengine 1.6.1-2 | 2024-12-05 | 2024-12-05 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| Intel EMR 服务器 | 128核/1TB内存 |      |
|          |              |      |

# 3     测试结论概述

openEuler 24.03-LTS-SP1上的Intel QuickAssist Technology(QAT)软件包测试完成了对于intel-qatlib, intel-qatzip, intel-qatengine(包含intel-ipp-crypto-mb和intel-ipsec-mb)软件包的功能测试和性能测试，测试结果符合预期，未发现问题。


# 4 详细测试结论

## 4.1   特性测试结论

| 序号 | 特性名称 | 特性质量评估               | 备注     |
| ---- | -------- | -------------------------- | -------- |
| 1    | Compression | █ |  |
| 2    | Decompression | █ |  |
| 3    | Symmetric Cipher | █ |  |
| 4    | Hash | █ |  |
| 5    | DSA | █ |  |
| 6    | ECDSA | █ |  |
| 7    | ECDH | █ |  |

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
|---------|------------|-------------|-------------|
| intel-qatlib 24.02.0-1  | 6  | 100% 通过 | 0 |
| intel-qatzip 1.2.0-1    | 6  | 100% 通过 | 0 |
| intel-qatengine 1.6.1-2 | 13 | 100% 通过 | 0 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 


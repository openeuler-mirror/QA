![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者 |
| ---------- | ----------- | -------- | ---- |
| 2024-12-10 | 1.0         | 新增     | 彭华 |

关键词： 密码算法、密码协议

摘要：本报告主要描述基于openEuler 24.03-LTS-SP1版本对openHiTLS的测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

openHiTLS本次主要提供3个功能：

1）密码算法功能：包括非对称加密算法、对称加密算法、哈希算法、密钥交换算法等

2）密码协议功能：包括TLS 1.2、TLS 1.3、TLCP等协议能力

3）证书功能：包括ASN1编码、base64编码、PEM证书解析等

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称             | 测试起始时间 | 测试结束时间 |
| -------------------- | ------------ | ------------ |
| openEuler-24.0.3-SP1 | 2024-12-4    | 2024-12-5    |
| openEuler-24.0.3-SP1 | 2024-12-7    | 2024-12-9    |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| NA       | NA           |      |

# 3     测试结论概述

## 3.1   测试整体结论

对openHiTLS主要进行功能测试，共执行4640个用例，用例通过率100%，测试过程中未发现问题，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 功能特性测试 | 对openHiTLS功能特性进行测试，测试过程中未发现问题 |

## 3.2   约束说明

前置需要安装libboundscheck库。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题。

### 3.3.2 问题统计

未发现问题。

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

无继承特性。

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 密码算法 | <font color=green>■</font> |   |
| 2 | 密码协议 | <font color=green>■</font> |   |
| 3 | 证书 | <font color=green>■</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

openHiTLS为首版本上车openEuler，不涉及版本升降级兼容性问题。

在openEuler操作系统上进行测试，功能正常。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|         |         |        |         |

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

## 4.4 资料测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ---- | ---- | ---- |
|      |      |      |
## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ---- | ---- | ---- |
|      |      |      |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                | 测试用例数 | 用例执行结果 | 发现问题单数 |
| ----------------------- | ---------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP1 | 4640个     | 通过4640个   | 0            |
|                         |            |              |              |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 
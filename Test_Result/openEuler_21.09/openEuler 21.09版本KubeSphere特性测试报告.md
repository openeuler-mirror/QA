
![openEuler icon](../../images/openEuler.png)

版权所有 © 2021  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

|**日期**|**修订 版本**|**修改描述**|**作者**|
| :-: | :-: | :-: | :-: |
|2021/09/13|1.0|创建|刘亚平|
|||||

关键词：kubesphere kubekey

# 1 特性概述

SIG-KubeSphere将 KubeSphere v3.1.1 相关的软件包以 RPM 的方式集成到了 openEuler 21.09，为 openEuler 提供基于 Kubernetes 的 [KubeSphere 开源容器平台](https://kubesphere.com.cn/)，可帮助用户快速安装部署与管理 Kubernetes 以及云原生应用。本文档用于验证KubeKey在openEuler 操作系统中的安装部署、扩容、高可用以及 KubeSphere 平台可用性。

# 2 特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括测试相关的硬件。

|**版本名称**|**测试起始时间**|**测试结束时间**|
| :-: | :-: | :-: |
|openeuler-2021-09-04-12-49-06|2021/09/06|2021/09/08|

描述特性测试的硬件环境信息：

|**架构**|**环境**|**配置信息**|
| :-: | :-: | :-: |
|X86\_64|虚拟机|CPU核数：8<br>内存：16G<br>硬盘容量：100G|
|aarch64|虚拟机|CPU核数：8<br>内存：16G<br>硬盘容量：100G|

# 测试结论概述

## 3.1 测试整体结论

KubeSphere on openEuler 21.09 特性，共计执行 13 个用例，主要覆盖了在 openEuler 21.09 中通过 Kubekey 安装部署、扩缩容、删除 Kubernetes 及 KubeSphere 集群的功能测试，x86 架构和 arm64 架构均测试通过；

## 3.2 约束说明

由于当前在 ARM64 操作系统中暂不支持安装 KubeSphere 3.1.1，因此在 arm64 中只测试了安装、扩缩容、删除 Kubernetes 的功能。

## 3.3 遗留问题分析

无

# 4 测试执行

## 4.1 测试执行统计数据

本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。

|**版本名称**|**测试用例数**|**用例执行结果**|**发现问题单数**|
| :-: | :-: | :-: | :-: |
|openeuler-2021-09-04-12-49-06|13|通过|0|

数据项说明：

测试用例数－－到本测试活动结束时，所有可用测试用例数；

发现问题单数－－本测试活动总共发现的问题单数。


![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2024/05/31 | 1.0.0    | GreatSQL测试报告      |  @GreatSQL  |


关键词：GreatSQL
 

摘要：按照 GreatSQL 8.0.32-25 测试用例要求，部署 openEuler 24.03-LTS 测试镜像环境，对 GreatSQL 的源码编译、RPM安装、二进制包安装、主要功能进行测试。测试结果良好，完全支持 GreatSQL 主要功能的正常使用。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| MGR/GR | MySQL Group Replication | MySQL Group Replication，MySQL 组复制的简称。MySQL 推出的一种不同于主从复制、半同步复制的全新复制机制。|
| arbitrator | MGR arbitrator member | 仲裁节点/投标节点。该节点不存储用户数据，没有 binlog，也不需要回放 relay log，只参与 MGR 状态投票/仲裁。 |
| zone id | MGR member zone id| 地理标签。可以对每个节点设置地理标签，主要用于解决多机房数据同步的问题。|
| fast mode | MGR fast mode | 快速单主模式。在该模式下可以降低 MGR 事务代价，提升事务性能。|
| election mode | MGR Primary member election mode | 可根据不同策略选择MGR主节点。|
| pq | InnoDB parallel query | InnoDB 并行查询。|


# 1     特性概述

本测试报告为 GreatSQL 8.0.32-25 在 openEuler 24.03-LTS 操作系统上的测试报告，目的在于跟踪测试阶段中发现的问题，总结 GreatSQL 在 openEuler 24.03-LTS 操作系统中运行状况&功能特性支持的测试结果，测试的范围主要包括 GreatSQL 源码编译、RPM安装、二进制包安装、主要功能及性能、稳定性等方面进行测试。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-24.03-RC6 | 2024年05月28日 | 2024年05月31日 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| Docker 容器 | 无特殊配置 | 在 aarch64/x86_64 物理机上运行 Docker 容器测试 | 

# 3     测试结论概述

## 3.1   测试整体结论

在 Docker 容器中启动 openEuler 24.03 测试镜像，在此基础上进行 GreatSQL 8.0.32-25 测试，共执行 126 个测试项，主要涵盖了 GreatSQL 源码编译、RPM安装、二进制包安装、MGR增强、Rapid引擎、并行LOAD DATA、异步删除大表、Oracle兼容、安全提升等主要功能特性等方面，均通过，无风险，整体核心功能稳定正常。

## 3.2   约束说明

无。

## 3.3   遗留问题分析

无。

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 特性名字 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- |---------- | ---------- | ------------ | ------------ |
| openEuler-24.03-RC6  | GreatSQL |  126       |      Pass      |     0        |


## 4.2   后续测试建议

无。

# 5     附件

无。


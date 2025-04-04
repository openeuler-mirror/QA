# OpenStack测试报告

![avatar](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/> 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

|日期|修订版本|修改描述|作者|
|:----|:----|:----|:----|
|2025-03-18|1|初稿|郑挺|

关键词：

OpenStack

摘要：

在 ```openEuler 25.03``` 版本中提供 ```OpenStack Antelope``` 版本的 ```RPM``` 安装包，方便用户快速部署 ```OpenStack```。

缩略语清单：

|缩略语|英文全名|中文解释|
|:----|:----|:----|
|CLI|Command Line Interface|命令行工具|
|ECS|Elastic Cloud Server|弹性云服务器|

## 1 特性概述

在 ```openEuler 25.03``` 版本中提供 ```OpenStack Antelope``` 版本的```RPM```安装包，包括以下项目以及每个项目配套的 ```CLI```。

- Keystone

- Neutron

- Cinder

- Nova

- Placement

- Glance

- Horizon

- Aodh

- Ceilometer

- Cyborg

- Gnocchi

- Heat

- Swift

- Ironic

- Kolla

- Trove

- Tempest

- Barbican

- Octavia

- designate

- Manila

- Masakari

- Mistral

- Senlin

- Zaqar

## 2 特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

|版本名称|测试起始时间|测试结束时间|
|:----|:----|:----|
|openEuler 25.03 RC1<br>(OpenStack Antelope版本各组件的安装部署测试)|2025.02.10|2025.02.23|
|openEuler 25.03 RC2<br>(OpenStack Antelope版本基本功能测试，包括虚拟机，卷，网络相关资源的增删改查)|2025.02.27|2025.03.07|
|openEuler 25.03 RC3<br>(OpenStack Antelope版本tempest集成测试)|2025.03.10|2025.03.21|

描述特性测试的硬件环境信息

|硬件型号|硬件配置信息|备注|
|:----|:----|:----|
|华为云ECS|Intel Cascade Lake 3.0GHz 8U16G|华为云x86虚拟机|
|华为云ECS|Huawei Kunpeng 920 2.6GHz 8U16G|华为云arm64虚拟机|

## 3 测试结论概述

### 3.1 测试整体结论

```OpenStack Antelope``` 版本，共计执行 ```Tempest``` 用例 ```1483``` 个，主要覆盖了 ```API``` 测试和功能测试，通过 ```7*24``` 的长稳测试，```Skip``` 用例 ```100``` 个（全是 ```OpenStack Antelope``` 版中已废弃的功能或接口，如Keystone V1、Cinder V1等），失败用例 ```0``` 个，其他 ```1383``` 个用例全部通过，未发现问题，回归通过，无遗留风险，整体质量良好。

|测试活动|tempest集成测试|
|:----|:----|
|接口测试|API全覆盖|
|功能测试|Antelope版本覆盖Tempest所有相关测试用例1483个，其中Skip 100个，Fail 0个，其他全通过。|

|测试活动|功能测试|
|:----|:----|
|功能测试|虚拟机（KVM、Qemu）、存储（lvm、NFS、Ceph后端）、网络资源（linuxbridge、openvswitch）管理操作正常|

### 3.2   约束说明

本次测试没有覆盖 ```OpenStack Antelope``` 版中明确废弃的功能和接口，因此不能保证已废弃的功能和接口（前文提到的Skip的用例）在 ```openEuler 25.03``` 上能正常使用。

### 3.3   遗留问题分析

#### 3.3.1 遗留问题影响以及规避措施

|问题单号|问题描述|问题级别|问题影响和规避措施|当前状态|
|:----|:----|:----|:----|:----|
|N/A|N/A|N/A|N/A|N/A|

#### 3.3.2 问题统计

|    |问题总数|严重|主要|次要|不重要|
|:----|:----|:----|:----|:----|:----|
|数目|0|0|0|0|0|
|百分比|100|0|0|0|0|

## 4 测试执行

### 4.1 测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

|版本名称|测试用例数|用例执行结果|发现问题单数|
|:----|:----|:----|:----|
|openEuler 25.03 OpenStack Antelope|1483|通过1383个，skip 100个，Fail 0个|0|

### 4.2 后续测试建议

*N/A*

## 5 附件

*N/A*

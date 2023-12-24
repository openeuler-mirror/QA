![openEuler ico](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[https://creativecommons.org/licenses/by-sa/4.0/](https://creativecommons.org/licenses/by-sa/4.0/)了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[https://creativecommons.org/licenses/by-sa/4.0/legalcode。](https://creativecommons.org/licenses/by-sa/4.0/legalcode。)

修订记录

|日期|修订版本|修改描述|作者|
|:----|:----|:----|:----|
|2023-11-24|1|初稿|郑挺|


关键词：

OpenStack

摘要：

在```openEuler 20.03 LTS SP4```版本中提供```OpenStack Train```版本的```RPM```安装包。方便用户快速部署```OpenStack```。

缩略语清单：

|缩略语|英文全名|中文解释|
|:----|:----|:----|
|CLI|Command Line Interface|命令行工具|
|ECS|Elastic Cloud Server|弹性云服务器|

# 1 特性概述

在openEuler 20.03 LTS SP4 release中提供OpenStackk Train版本RPM安装包的支持，包括以下项目以及每个项目配套的CLI。

- Keystone

- Glance

- Placement

- Nova

- Neutron

- Cinder

- Ironic

- Trove

- Kolla

- Heat

- Aodh

- Ceilometer

- Gnocchi

- Swift

- Horizon

- Tempest


# 2 特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

|版本名称|测试起始时间|测试结束时间|
|:----|:----|:----|
|openEuler 20.03 LTS SP4 RC1<br>（发布Beta版本，启动版本SIT测试）|2023.10.21|2023.10.25|
|openEuler 20.03 LTS SP4 RC2<br>（SIT测试，特性基线合入冻结，不再接纳功能性代码合入）|2023.10.28|2023.11.1|
|openEuler 20.03 LTS SP4 RC3<br>（SIT测试）|2023.11.4|2023.11.8|
|openEuler 20.03 LTS SP4 RC4<br>（SIT测试）|2023.11.11|2023.11.15|
|openEuler 20.03 LTS SP4 RC5<br>（发布release预览版本，版本缺陷回归验证）|2023.11.18|2023.11.22|

描述特性测试的硬件环境信息

|硬件型号|硬件配置信息|备注|
|:----|:----|:----|
|华为云ECS|Intel Cascade Lake 3.0GHz 8U16G|华为云x86虚拟机|
|华为云ECS|Huawei Kunpeng 920 2.6GHz 8U16G|华为云arm64虚拟机|

# 3 测试结论概述

## 3.1 测试整体结论

OpenStack Train版本各组件基本功能正常，共计执行Tempest用例1122个，主要覆盖了API测试和功能测试，Skip用例64个（全是OpenStack Train版中已废弃的功能或接口），失败用例0个，其他1058个用例全部通过，发现问题均已解决，回归通过，无遗留风险，整体质量良好。

|测试活动|tempest集成测试|
|:----|:----|
|接口测试|API全覆盖|
|功能测试|Train版本覆盖Tempest所有相关测试用例1122个，其中Skip 64个，其他全通过。|

|测试活动|功能测试|
|:----|:----|
|功能测试|虚拟机（KVM、Qemu)、存储（lvm）、网络资源（linuxbridge）管理操作正常|

## 3.2   约束说明

本次测试没有覆盖OpenStack Train版中明确废弃的功能和接口，因此不能保证已废弃的功能和接口（前文提到的Skip的用例）在openEuler 20.03 LTS SP4上能正常使用。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

|问题单号|问题描述|问题级别|问题影响和规避措施|当前状态|
|:----|:----|:----|:----|:----|
|NA|NA|NA|NA|NA|

### 3.3.2 Train版本问题统计

|    |问题总数|严重|主要|次要|不重要|
|:----|:----|:----|:----|:----|:----|
|数目|7|1|3|0|3|
|百分比|100|14|43|0|43|

| ISSUE Link |
|:----|
| https://gitee.com/src-openeuler/python-pyxcli/issues/I8I8EB |
| https://gitee.com/src-openeuler/python-suds-jurko/issues/I8B558 |
| https://gitee.com/src-openeuler/openstack-tempest/issues/I8DBFX |
| https://gitee.com/src-openeuler/python-openvswitch/issues/I8DBKT |
| https://gitee.com/src-openeuler/python-cassandra-driver/issues/I8I8E1 |
| https://gitee.com/src-openeuler/python-os-api-ref/issues/I8I8E5 |
| https://gitee.com/src-openeuler/openstack-neutron/issues/I8FOB4 |


# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|openEuler 20.03 LTS SP4 OpenStack Train|1122|通过1058个，skip 64个，Fail 0个|7|


## 4.2   后续测试建议

1. 涵盖主要的性能测试。
2. 覆盖更多的driver/plugin测试。

# 5     附件

*N/A*

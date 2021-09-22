![openEuler ico](../../images/openEuler.png)

版权所有 © 2021  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[https://creativecommons.org/licenses/by-sa/4.0/](https://creativecommons.org/licenses/by-sa/4.0/)了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[https://creativecommons.org/licenses/by-sa/4.0/legalcode。](https://creativecommons.org/licenses/by-sa/4.0/legalcode。)

修订记录

|日期|修订版本|修改描述|作者|
|:----|:----|:----|:----|
|2021-9-22|1|初稿|王玺源、黄填华、陈硕|
|    |    |    |    |
|    |    |    |    |

关键词：

OpenStack

摘要：

在openEuler 21.09版本中提供OpenStack Wallaby版本的RPM安装包。方便用户快速部署OpenStack。

缩略语清单：

|缩略语|英文全名|中文解释|
|:----|:----|:----|
|CLI|Command Line Interface|命令行工具|
|ECS|Elastic Cloud Server|弹性云服务器|

# 1 特性概述

在openEuler 21.09 release中提供OpenStack Wallaby的RPM安装包支持，包括项目：Keystone、Glance、Nova、Placement、Neutron、Cinder、Ironic、Trove、Swift、Kolla、Horizon、Tempest以及每个项目配套的CLI。

# 2 特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

|版本名称|测试起始时间|测试结束时间|
|:----|:----|:----|
|openEuler 21.09 RC1<br>（OpenStack各组件的安装部署测试）|2021.8.26|2021.8.29|
|openEuler 21.09 RC2<br>（OpenStack基本功能测试，包括虚拟机，卷，网络相关资源的增删改查）|2021.8.30|2021.9.5|
|openEuler 21.09 RC3<br>（OpenStack tempest集成测试）|2021.9.6|2021.9.12|
|openEuler 21.09 RC3<br>（OpenStack Ironic裸机部署及测试）|2021.9.6|2021.9.12|
|openEuler 21.09 RC4<br>（问题回归测试）	|2021.9.13|2021.9.19|

描述特性测试的硬件环境信息

|硬件型号|硬件配置信息|备注|
|:----|:----|:----|
|华为云ECS|Intel Cascade Lake 3.0GHz 8U16G|华为云x86虚拟机|
|Huawei 2288H V5|Xeon Bronze 3106 22U 384G|x86架构服务器|
|TaiShan 200-2280|Kunpeng 920,48 Core@2.6GHz*2; 256GB DDR4 RAM|ARM架构服务器|

# 3 测试结论概述

## 3.1 测试整体结论

OpenStack Wallaby版本，共计执行Tempest用例1256个，主要覆盖了API测试和功能测试，通过经过7*24的长稳测试，Skip用例105个（全是openStack W版中已废弃的功能或接口），其他用例全部通过，发现问题已解决，回归通过，无遗留风险，整体质量良好。

|测试活动|tempest集成测试|
|:----|:----|
|接口测试|API全覆盖|
|功能测试|覆盖Tempest所有相关测试用例1256个，其中Skip 105个，其他全通过。|

||测试活动功能测试|
|:----|:----|
|||
||接口测试覆盖功能测试虚拟机（KVM、Qemu)、存储（lvm、NFS、Ceph后端）、网络基本资源（linuxbridge、openvswitch）管理操作正常|

## 3.2   约束说明

本次测试没有覆盖OpenStack W版中明确废弃的功能和接口，因此不能保证已废弃的功能和接口（前文提到的Skip的105个用例）在openEuler 21.09上能正常使用。

## 3.3   问题统计

|    |问题总数|严重|主要|次要|不重要|
|:----|:----|:----|:----|:----|:----|
|数目|6| |4|2||
|百分比|100| |66.7|33.3||

# 4 测试执行

## 4.1 测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

|版本名称|测试用例数|用例执行结果|发现问题单数|
|:----|:----|:----|:----|
|openEuler-21.09-RC1|1256|通过1151个，skip 105个|3（安装、部署、配置问题）|
|openEuler-21.09-RC2|1256|通过1151个，skip 105个|1（安装、部署、配置问题）|
|openEuler-21.09-RC3|1256|通过1151个，skip 105个|2（安装、部署、配置问题）|
|openEuler-21.09-RC4|1256|通过1151个，skip 105个|0|

## 4.2 后续测试建议

1. 涵盖主要的性能测试
2. 覆盖更多的driver/plugin测试

# 5 附件

*N/A*


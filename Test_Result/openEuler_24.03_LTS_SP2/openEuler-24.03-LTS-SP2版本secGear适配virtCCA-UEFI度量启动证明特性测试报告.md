# openEuler-24.03-LTS-SP2版本secGear适配virtCCA-UEFI度量启动证明特性测试报告

![avatar](../../images/openEuler.png)

版权所有 © 2025  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

|日期|修订   版本|修改描述|作者|
| ------------| -------------| -------------------------------------------------------------| --------|
|2025/05/27|v1.0|secGear远程证明统一框架支持virtCCA-UEFI度量启动证明测试报告|谢秀念|

关键词：secGear virtCCA UEFI度量 IMA度量 远程证明 机密计算

摘要：本特性实现virtCCA机密虚机UEFI度量日志的远程证明。同时支持IMA度量扩展virtCCA环境REM寄存器的灵活配置，避免UEFI度量结果与IMA度量结果扩展到同一寄存器。

缩略语清单：

|缩略语|英文全名|中文解释|
| --------| ------------------------------------| ----------------|
|IMA|Integrity Measurement Architecture|完整性度量架构|

# 1     特性概述

virtCCA机密虚机当前已支持UEFI度量启动，但目前secGear远程证明统一框架未对UEFI度量启动日志进行远程证明。为完善secGear远程证明统一框架在不同boot模式下的远程证明，适配UEFI度量启动证明。

当前版本新增功能点：适配virtCCA机密虚机UEFI度量启动证明；支持IMA度量扩展寄存器的灵活配置

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

|版本名称|测试起始时间|测试结束时间|
| ------------------------------| --------------| --------------|
|secGear-as-56、secGear-aa-56|2025/05/21|2025/05/27|
|secGear-as-57、secGear-aa-57|2025/05/21|2025/05/27|

描述特性测试的硬件环境信息

|硬件型号|硬件配置信息|备注|
| ------------| --------------| --------|
|kunpeng920|NA|物理机|

# 3     测试结论概述

## 3.1   测试整体结论

secGear适配UEFI度量启动证明需求，源码编译版、软件包安装版各执行20个用例，主要覆盖功能测试、可靠性测试。

发现问题1个，已解决，回归通过，无遗留风险，整体质量良好

## 3.2   约束说明

1. 依赖支持virtCCA的kunpeng920物理机（普通服务器无法通过升级BMC、BIOS、TEE OS固件实现TrustZone特性使能。）
2. 物理机已经预置TrustZone特性套件，即预装TEE OS、TEE OS启动密钥、BMC、BIOS和License许可证。（带TrustZone特性的服务器出厂默认特性关闭，请参考BIOS设置使能服务器TrustZone特性。）
3. 物理机环境要求与部署参考鲲鹏BoostKit机密计算：[https://www.hikunpeng.com/document/detail/zh/kunpengcctrustzone/overview/kunpengcctrustzone.html](https://www.hikunpeng.com/document/detail/zh/kunpengcctrustzone/overview/kunpengcctrustzone.html)
4. virtCCA机密虚机镜像制作：[Kunpeng BoostKit 25.0.RC2 机密计算 TEE 套件 特性指南.pdf](https://www.hikunpeng.com/doc_center/source/zh/kunpengcctrustzone/tee/fg/Kunpeng%20BoostKit%2025.0.RC2%20%E6%9C%BA%E5%AF%86%E8%AE%A1%E7%AE%97TEE%E5%A5%97%E4%BB%B6%20%E7%89%B9%E6%80%A7%E6%8C%87%E5%8D%97.pdf)（包含UEFI度量启动镜像制作与Direct boot的rootfs、kernel制作）

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题

### 3.3.2 问题统计

#### 3.3.2.1 问题数量

||问题总数|严重|主要|次要|不重要|
| --------| ----------| ------| ------| ------| --------|
|数目|1|0|0|1|0|
|百分比|100%|0%|0%|100%|0%|

#### 3.3.2.2 发现问题

|序号|问题单号|问题简述|优先级|当前状态|
| ------| --------------------------------------------------------------------------| --------------------------------------------------| --------| ----------|
|1|https://gitee.com/src-openeuler/secGear/issues/ICA4EE?from=project-issue|源码编译版与软件包版日志输出不同，软件包日志简单|次要|已解决|

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

|序号|组件/特性名称|特性质量评估|备注|
| ------| -------------------------| :---------------------------: | ------|
|1|virtCCA远程证明|<font color=green>■</font>||
|2|virtCCA-IMA度量远程证明|<font color=green>■</font>||

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

|序号|组件/特性名称|特性质量评估|备注|
| ------| ---------------------------------------| :---------------------------: | ------|
|1|virtCCA-UEFI度量远程证明|<font color=green>■</font>||
|2|virtCCA-IMA度量寄存器灵活配置|<font color=green>■</font>||
|3|virtCCA-同时启动UEFI、IMA度量远程证明|<font color=green>■</font>||

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 可靠性/韧性测试结论

|测试类型|测试内容|测试结论|
| ------------| --------------------------------------------| ----------|
|可靠性测试|构造并发100线程进行UEFI和IMA度量的远程证明|功能正常|

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

|版本名称|测试用例数|用例执行结果|发现问题单数|
| ------------------------------| ------------| -------------------| --------------|
|secGear-as-56、secGear-aa-56|20|成功16个，失败4个|1|
|secGear-as-57、secGear-aa-57|20|全部通过|0|

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

‍

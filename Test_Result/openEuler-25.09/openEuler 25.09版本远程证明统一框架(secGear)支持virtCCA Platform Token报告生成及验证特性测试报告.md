# openEuler 25.09版本远程证明统一框架(secGear)支持virtCCA Platform Token报告生成及验证特性测试报告

![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

|日期|修订   版本|修改描述|作者|
| ------------| -------------| -------------------------------------------------------------------------------| --------|
|2025/09/04|v1|远程证明统一框架(secGear)支持virtCCA Platform Token报告生成及验证特性测试报告|谢秀念|

关键词：secGear、virtCCA、Platform Token、机密计算、远程证明

摘要：本特性实现远程证明统一框架(secGear)支持virtCCA新版本的Platform Token报告生成及验证。完善远程证明统一框架对于virtCCA新版本信任链的证明服务。适配virtCCA新版本的同时，仍旧兼容virtCCA旧版本的远程证明。

缩略语清单：

| 缩略语 | 英文全名                           | 中文解释       |
| --------| ----------| ----------|
| IMA    | Integrity Measurement Architecture |完整性度量架构|

# 1     特性概述

新版本virtCCA已支持Platform Token，补齐virtCCA的相关信任链。远程证明统一框架对新版virtCCA进行适配，补齐证明流程信任链，完善远程证明服务。同时对于旧版virtCCA保持兼容，适应不同对象的使用需求。

# 2     特性测试信息

|版本名称|转测轮次|测试起始时间|测试结束时间|
| --------------------------------------------| --------------| --------------| --------------|
|secGear-as-65.oe2509、secGear-aa-65.oe2509|openEuler-25.09 (RC4)|2025/09/03|2025/09/04|

|硬件型号|硬件配置信息|备注|
| ---------------------| -------------------------------| --------|
|鲲鹏920系列|NA|物理机|

# 3     测试结论概述

## 3.1   测试整体结论

远程证明统一框架(secGear)支持virtCCA新版本的Platform Token报告生成及验证特性，共计执行需求相关用例11个，其中新增用例6个，继承用例5个。主要覆盖功能测试、可靠性测试。无测试问题，无遗留风险，整体质量良好。

## 3.2   约束说明

1. 当前支持Platform Token的virtCCA版本为V1.4
2. virtCCA配套相关信息请参考 [鲲鹏BoostKit 机密计算TEE套件 1.4.0版本说明书](https://www.hikunpeng.com/document/detail/zh/kunpengcctrustzone/tee/rn/kunpengtrustzone_28_0001.html)
3. 物理机环境部署、机密虚机制作请参考 [鲲鹏BoostKit 机密计算TEE套件 特性指南](https://www.hikunpeng.com/document/detail/zh/kunpengcctrustzone/tee/fg/kunpengtee_16_0002.html)

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题

### 3.3.2 问题统计

无测试问题

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

|序号|组件/特性名称|特性质量评估|备注|
| ------| --------------------------------------------| :---------------------------: | ------|
|1|旧版virtCCA UEFI虚机IMA度量远程证明|<font color=green>■</font>||
|2|旧版virtCCA Direct Boot虚机IMA度量远程证明|<font color=green>■</font>||

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

|序号|组件/特性名称|特性质量评估|备注|
| ------| --------------------------------------------| :---------------------------: | ------|
|1|新版virtCCA UEFI虚机IMA度量远程证明|<font color=green>■</font>||
|2|新版virtCCA UEFI虚机远程证明|<font color=green>■</font>||
|3|新版virtCCA Direct Boot虚机IMA度量远程证明|<font color=green>■</font>||
|4|新版virtCCA Direct Boot虚机远程证明|<font color=green>■</font>||

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

*功能特性继承用例、新增用例可证明新特性兼容支持新旧virtCCA平台、新旧机密虚机启动方式（UEFI、Direct Boot）。*

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

不涉及

### 4.3.2 可靠性/韧性测试结论

|测试类型|测试内容|测试结论|
| ------------| --------------------------------------------| -----------------------------|
|可靠性测试|构造并发100线程进行UEFI和IMA度量的远程证明|<font color=green>■</font>|

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论

不涉及

## 4.5 其他测试结论

不涉及

# 5     测试执行

## 5.1   测试执行统计数据

|版本名称|测试用例数|用例执行结果|发现问题单数|
| --------------------------------------------| ------------| --------------| --------------|
|secGear-as-65.oe2509、secGear-aa-65.oe2509|11|成功11个|0|

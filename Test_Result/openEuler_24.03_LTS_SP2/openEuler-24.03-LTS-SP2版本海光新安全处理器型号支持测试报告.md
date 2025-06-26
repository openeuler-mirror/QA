![avatar](../../images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025.06.17 | v1.0 | 新建 | chench00 |

关键词：

摘要：新增海光pspccp和ntbccp型号支持。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|  CCP   |Crypto Co-Processor|密码协处理器|
| PSP |Platform Security Processor|平台安全处理器|

# 1     特性概述

内核CCP模块初始化时增加对海光pspccp和ntbccp新型号的支持。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                | 测试起始时间 | 测试结束时间 |
| ----------------------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP2 | 2025.06.17   | 2025.06.17   |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| Hygon C86-4G 3450M | 8C16T | DDR4内存插满所有numa node |

# 3     测试结论概述

## 3.1   测试整体结论

在支持新型号pspccp和ntbccp的海光机器上，可正确识别pspccp和ntbccp，内核CCP模块正常初始化，无遗留风险，整体质量良好；

## 3.2   约束说明

使用如下仓库及其对应的分支进行测试

| 测试仓库                               | 测试分支 |
| -------------------------------------- | -------- |
| https://gitee.com/openeuler/kernel.git | OLK-6.6  |



## 3.3   遗留问题分析

没有遗留问题

# 4 详细测试结论

## 4.1 功能测试
### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| | | <font color=green>■</font> |   |
| | | <font color=blue>▲</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 新增pspccp和ntbccp的型号支持 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

NA

### 4.3.2 可靠性/韧性测试结论

NA

### 4.3.3 安全测试结论

NA

## 4.4 资料测试结论

NA

## 4.5 其他测试结论

NA

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                | 测试用例数 | 用例执行结果 | 发现问题单数 |
| ----------------------- | ---------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP2 | 1          | pass         | 0            |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

在支持新型号pspccp和ntbccp的海光机器上，执行lspci -vnn可见对应的vendor/device id信息，如下：

04:00.2 Encryption controller [1080]: Chengdu Haiguang IC Design Co., Ltd. Device [1d94:14c6]

04:00.3 Encryption controller [1080]: Chengdu Haiguang IC Design Co., Ltd. Device [1d94:14d8]

内核启动日志可见：

[    1.888363] ccp 0000:04:00.2: no command queues available

[    1.892521] ccp 0000:04:00.2: SEV: memory encryption not enabled by BIOS

[    1.905632] ccp 0000:04:00.2: psp enabled

[    1.911820] ccp 0000:04:00.3: ccp enabled

内核CCP模块初始化正常。

 



 

 

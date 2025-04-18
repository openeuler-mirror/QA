![avatar](../../images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|   2025/03/25   |     v1.0   |     创建     |   @bixiaoyan1   |
|      |             |          |      |

关键词： HA特性 测试报告

摘要：HA 是一套通用软件解决方案，用于确保业务在意外故障或计划性宕机时的持续运行。它提供资源管理、系统监控、IP 地址转移和故障转移等基本功能，支持 MySQL、Redis、httpd 等服务的高可用性。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|  HA   | High Available | 高可用集群软件 |

# 1     特性概述

当前的特性交付包括 HA 组件，如 pcs、pacemaker、corosync、corosync-qdevice、fence-agents、sbd、booth、resource-agents 和 dlm。这些组件共同作用，以实现全面的高可用性解决方案，确保系统的稳定性和可靠性。

# 2     特性测试信息

HA 特性在 rc1、rc3、rc5 进行三轮验证，同时验证 arm 和 x86 版本。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| 25.03 (RC1)  |      2025/02/14        |       2025/02/20      |
| 25.03 (RC3)  |      2025/02/28        |       2025/03/06      |
| 25.03 (RC5)  |      2025/03/14        |       2025/03/20      |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| KunLun 2280 | CPU型号：Kunpeng 920 <br />CPU核数：96 <br />内存：128G |      |
| NF8260M6 | CPU型号：Intel Xeon Gold 6330H <br />CPU核数：96 <br />内存：256G |      |

# 3     测试结论概述

## 3.1   测试整体结论

在 openEuler-25.03 版本的测试阶段，HA 的测试主要包括基本功能测试和可靠性测试。经过7*24小时的长时间稳定性测试，共完成了 12 个子模块的测试，总计执行了 26 个测试用例。测试内容涵盖了 21 个基本功能测试用例、4 个失效切换测试用例、1 个日志收集用例。整体来看，核心功能表现稳定。

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及

### 3.3.2 问题统计

无

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1    | HA 组件软件安装、卸载，服务启动      | <font color=green>■</font> |      |
| 2    | HA 查看集群状态、设置集群属性        | <font color=green>■</font> |      |
| 3    | HA 添加和删除节点                  | <font color=green>■</font> |      |
| 4    | HA 添加、修改和删除资源             | <font color=green>■</font> |      |
| 5    | HA 添加、修改和删除组资源           | <font color=green>■</font> |      |
| 6    | HA 添加、修改和删除克隆资源         | <font color=green>■</font> |      |
| 7    | HA 节点的挂起、维护和恢复           | <font color=green>■</font> |      |
| 8    | HA 停止和删除集群                 | <font color=green>■</font> |      |
| 9    | HA 业务服务和业务网络失效导致业务迁移 | <font color=green>■</font> |      |
| 10   | HA 磁盘空间不足导致业务迁移         | <font color=green>■</font> |      |
| 11   | HA 日志收集                       | <font color=green>■</font> |      |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| | | <font color=red>●</font> |   |
| | | <font color=blue>▲</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

在 Kunpeng 920 和 Intel Xeon Gold 6330H 两种架构的机器上，经过测试，HA 组件均可以正常运行

| 序号 | 型号                   | 特性质量评估                 | 备注           |
| ---- | --------------------- | -------------------------- | ------------- |
| 1    | Kunpeng 920           | <font color=green>■</font> | HA 组件运行正常 |
| 2    | Intel Xeon Gold 6330H | <font color=green>■</font> | HA 组件运行正常 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

NA

### 4.3.2 可靠性/韧性测试结论

可靠性测试主要从基础功能、业务切换测试和 7*24 长稳测试三个方面进行测试。

| 序号 | 子模块名称     | 特性质量评估                | 备注                                       |
| ---- | ----------- | -------------------------- | ----------------------------------------- |
| 1    | 基础功能测试  | <font color=green>■</font> | 基础功能完善，响应迅速                        |
| 2    | 业务切换测试  | <font color=green>■</font> | 业务切换迅速                                |
| 4    | 7*24 长稳测试 | <font color=green>■</font> | HA 组件在 7*24 不间断运行未出现崩溃、故障等问题 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.3 安全测试结论

NA

## 4.4 资料测试结论
NA

## 4.5 其他测试结论

NA

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 25.03 rc1 | 26       | 通过26个失败0个 | 0个        |
| openEuler 25.03 rc3 | 26       | 通过26个失败0个 | 0个        |
| openEuler 25.03 rc5 | 26       | 通过26个失败0个 | 0个        |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 
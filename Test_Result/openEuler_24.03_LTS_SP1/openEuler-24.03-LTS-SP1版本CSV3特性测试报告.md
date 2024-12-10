---
noteId: "c2753a20b60c11efbb87b99ca54c4e1e"
tags: []

---

![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2024/12/10|    v1.0         |    创建      |    潘平生  |
|      |             |          |      |

关键词： CSV3虚拟机

摘要：
本报告主要描述基于 openEuler 24.03 (LTS) 版本系统对CSV3虚拟机进行测试，输出测试结果。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|    CSV    |   China Security Virtualization       |          |
|     CMA   |      Contiguous Memory Allocator    |          |

# 1     特性概述

海光第三代安全虚拟化技术(CSV3)在前二代技术的基础上继续增强，在CPU内部实现了虚拟机数据的安全隔离，禁止主机操作系统读写CSV3虚拟机内存，禁止主机操作系统读写虚拟机嵌套页表，保证了虚拟机数据的完整性，实现了CSV3虚拟机数据机密性和完整性的双重安全。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|   openEuler 24.03 (LTS)        |    2024/12/03          |      2024/12/10        |
|          |              |              |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|    Hygon C86 7492C      |   内存391G，cpu core 112           |      |
|          |              |      |

# 3     测试结论概述

## 3.1   测试整体结论

共计执行41个测试用例，主要功能测试、可靠性测试，测试过程中发现2个问题，已经有对应修复的patch，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 虚拟机DCU 直通 |   测试通过   |
| 功能测试 | 启动500 CSV3虚拟机 |   测试通过|
| 功能测试 | 虚拟机设置不同vcpu，不同内存启动CSV、CSV2、CSV3虚拟机 |   测试通过|
| 功能测试 | CSV、CSV2、CSV3虚拟机和普通虚拟机混合启动  |   测试通过|
| 功能测试 | 启动CSV3虚拟机分配CMA内存混合测试 |   测试通过|
| 稳定性测试 | CSV、CSV2、CSV3虚拟机和普通虚拟机并行启动，对虚拟机cpu、内存、io、网络进行负载测试|   测试通过|
| 兼容性测试 | CSV、CSV2、CSV3虚拟机和普通虚拟机可以正常启动          |   测试通过    |

## 3.2   约束说明
使用如下仓库及其对应的分支进行测试

| 测试仓库 | 测试分支 |
| ------- | -------- |
| https://gitee.com/openeuler/kernel.git | OLK-6.6 |
| https://gitee.com/src-openeuler/edk2.git | openEuler-24.03-LTS |
| https://gitee.com/openeuler/qemu.git | qemu-8.2.0     |


## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- |
|  1   |     无    |    启动大容量CSV、CSV2虚拟机会卡住    |     次要    |     影响配置超过40G内存CSV、CSV2虚拟机启动    |         已有修复patch|      启动100G内存CSV虚拟机      |
|  2   |      无   |    可用CMA内存较低时，CMA 概率性分配失败    |   次要      |     可用CMA内存较低时影响CSV3 虚拟机启动    | 已有修复patch        |      CMA内存较低时，启动4G内存CSV3 虚拟机失败        |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |   2       |   0   |    0  |  2    |     0   |
| 百分比 |     100%     |    0  |   0   | 100%     |   0     |

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1| CSV虚拟机| <font color=green>■</font> |   |
| 2|CSV2虚拟机 | <font color=green>■</font> |   |
| 3|普通虚拟机 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1| CSV3虚拟机| <font color=green>■</font> |   |


<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论
NA


### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| --- | ------|----------- |
| 可靠性 | 对虚拟机进行负载压力测试 | 通过 |
| 可靠性      |    对虚拟机进行混合并行启动     |     通过     |

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
|     openEuler 24.03 (LTS)      |      41      |      pass        |       2       |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

用例列表以及结果
| 用例类别 | 测试简述 | 测试结果 |
| ---------- | ------------ | ------------ |
| C86-4G启动 CSV、CSV2 虚拟机 | 分别启动不同vcpu，不同内存的CSV、CSV2 虚拟机，启动成功。<br>问题：启动大容量CSV、CSV2虚拟机会卡住<br>修复patch：<br>mm,compaction: Don't use ALLOC_CMA in long term gup path<br>| Pass |
| C86-4G启动 CSV3 虚拟机 | 执行了启动不同vcpu，不同内存CSV3虚拟机测试步骤，得到CSV3虚拟机正常启动预期结果 | Pass |
| C86-4G启动 500 个 CSV3 虚拟机 | 执行了启动500 个CSV3虚拟机测试，得到500个CSV3 可以启动 | Pass |
| C86-4G CSV、CSV2、CSV3 虚拟机直通设备 | 执行了将网卡设备直通CSV、CSV2、CSV3虚拟机，得到了在CSV、CSV2、CSV3 guest中能够使用直通的网卡设备结果 | Pass |
| C86-4G CSV、CSV2、CSV3混合启动 | 执行了启动CSV、CSV2、CSV3混合启动，启动成功 | Pass |
| C86-4G CSV3 CMA 混合测试 |执行了启动CSV3分配CMA混合测试，测试成功。<br>问题：Hugetlb 问题会导致虚拟机启动失败<br>Hugetlb 问题修复patch：<br>1）anolis: mm: hugetlb: Remove flag __GFP_THISNODE to avoid failures<br>2）anolis: mm: hugetlb: wait hugetlb pages to be released to buddy allocator<br>3）anolis: mm: release hugetlb pages to buddy allocator after migrate them<br>4）mm: hugetlb: make the hugetlb migration strategy consistent<br>5）mm: record the migration reason for struct migration_target_control| Pass |
| C86-4G CSV3 虚拟机 负载测试 | 并行启动普通、CSV、CSV2、CSV3虚拟机，在虚拟机中对cpu、内存、io、网络进行压力测试，测试通过 | Pass |







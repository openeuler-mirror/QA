![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2024-06-25 | 1.0 | 创建 | wenjunryou |

关键词： 
oeAware
 

摘要：

本报告主要描述基于openEuler 22.03 LTS SP4 版本进行的oeAware特性的测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。
 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| oeAM | oeAware Manager | oeAware管理 |
| oeAC | oeAware Collector | oeAware采集 |
| oeAS | oeAware Scenario | oeAware感知 |
| oeAT | oeAware Tune | oeAware调优 |


***

# 1     特性概述

当前特性交付包括oeAware_manager、oeAware_collector、oeAware_cenario、oeAware_tune，分别为插件框架（对插件进行管理）、采集插件（采集数据）、感知插件（对其依赖的采集插件的数据进行处理）以及调优插件。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，以及硬件环境信息。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 22.03 LTS SP4 | 2024-06-11  | 2024-06-21 |


描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |    
| -------- | ------------ | ---- |
| NA | NA | 物理机/虚拟机 |

# 3     测试结论概述

## 3.1   测试整体结论

共计执行48个测试用例，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试、插件测试、地址消毒测试、告警测试以及根据覆盖率进行加固测试，发现问题均已修复并回归通过，无风险，整体质量良好。


## 3.2   约束说明

无

## 3.3   遗留问题分析

无遗留问题
        

### 3.3.2 问题统计

无

# 4     测试执行

## 4.1   测试执行统计数据

| 版本名称 | 特性名字 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ | ------------ |
| openEuler 22.03 LTS SP4 | oeAware | 48 | Pass | 6 |


## 4.2   后续测试建议

无

# 5     附件

无


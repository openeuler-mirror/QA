![avatar](../../images/openEuler.png)



版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025-9-9     |    v1.0         |   oeAware潮汐调度和numa亲和特性测试报告       | wenjun     |

关键词：oeAware 

摘要：oeAware集成了多种调优插件实现自动调优功能。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| oeAM   |  oeAware Manager    | oeAware管理       |

# 1     特性概述
本次测试主要涉及潮汐调度和支持内存和线程numa内cluster亲和两个特性功能测试。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 24.03 LTS SP1/SP2        |    2025/8/24          |    2025/9/5          |


描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  kunpeng 920       |   CPU 7270Z         |      |
|          |              |      |

# 3     测试结论概述

## 3.1   测试整体结论

共计执行54个用例，其中继承用例44个，新特性用例10个，主要覆盖了功能测试，其中1个已完成，1个修复中;另外还有47个继承用例因kernel未支持暂时未能测试，待支持之后测试完成更新当前测试报告。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 质量良好     |
| 功能测试 | 新增特性测试 | 质量良好     |
| 兼容性测试 |          |  不涉及     |
| DFX专项测试 | 性能测试 | 不涉及     |
| DFX专项测试 | 可靠性/韧性测试 |　不涉及 |
| DFX专项测试 | 安全测试 | 不涉及     |
| 资料测试 |         |  待修改       |
| 其他测试 |         |         |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- | 
|  NA   |   NA      |   NA     |   NA      |   NA      |   NA      |    NA       |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |    4      |   0   |   0   |   3   |    1    |
| 百分比 |    100%      |   0%   |   0%   |   75%   |    25%    |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | oeAware客户端参数功能测试 | <font color=green>■</font> |   |
| 2 | 继承优化组件功能测试　| <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1　| 支持容器场景潮汐调度 创建单个容器和多个容器场景使能对应实例，测试满足条件的容器潮汐调度配置是否有做调优　| <font color=green>■</font> |   |
| 2　| 支持内存和线程numa内cluster亲和 在多个容器跑不同的业务然后使能对应实例，容器之间会进行资源调度| <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

不涉及

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

不涉及

### 4.3.2 可靠性/韧性测试结论

不涉及

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 资料测试        |   https://gitee.com/openeuler/oeAware-manager/pulls/254      |   待修改       |

## 4.5 其他测试结论

无

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|    openEuler 24.03 LTS SP1/SP2      |     54       |      通过        |     4        |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

| issue链接 | 标题 | 问题单级别 |　问题单状态　|
| -------- | ---------- | ------------ | ------------ |
|  [ICUGF8](https://gitee.com/src-openeuler/oeAware-manager/issues/ICUGF8?from=project-issue)    | 【openEuler-24.03-LTS-SP2】【arm】执行oeawarectl -e tune_numa_mem_access -cmd "-W test,top,redis"白名单配置多个进程，实际生效只配置了第一个 |   主要  |  已验收  |
|  [ICVA0O](https://gitee.com/src-openeuler/oeAware-manager/issues/ICVA0O?from=project-issue)    | 【openEuler-24.03-LTS-SP2】【arm】日志级别从4改为5，执行oeawarectl --reload-conf，之后日志中仍存在INFO级别日志 |   次要  |  已取消  |
|  [ICV9KW](https://gitee.com/src-openeuler/oeAware-manager/issues/ICV9KW?from=project-issue)    | 【【openEuler-24.03-LTS-SP2】【arm】创建docker，无负载，配置high_load: -0.01[0,1]，取值范围未做校验，使能load_based_scheduling_tune，没有报错并且所有docker有调优 |   次要  |  已完成  | 
|  [ICUPAM](https://gitee.com/src-openeuler/oeAware-manager/issues/ICUPAM?from=project-issue)    | 【openEuler-24.03-LTS-SP2】【arm】执行oeawarectl -e tune_numa_mem_access -cmd "xx"报错问题 |   不重要  |  修复中  |


 

 

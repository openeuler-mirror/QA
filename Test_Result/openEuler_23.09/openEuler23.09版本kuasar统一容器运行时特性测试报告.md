![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2023-09-20     |   1.0          |    kuasar统一容器运行时测试报告      |  雷杰    |
|      |             |          |      |
|      |             |          |      |

 关键词：kuasar

 

摘要：安装iSulad、Kuasar、Stratovirt，通过crictl工具对已支持的CRI接口进行功能测试。测试结果良好，对已支持的CRI接口的主要功能的使用基本正常。

 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

本测试报告为openEuler23.09版本kuasar统一容器运行时的测试报告，测试的范围主要包括验证CRI接口的基本使用、验证网络、资源管理等基本配置能否生效、验证性能底噪是否达到预期等。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-23.09-RC3 | 2023年09月07日 | 2023年09月12日 |
| openEuler-23.09-RC4 | 2023年09月13日 | 2023年09月15日 |

描述特性测试的硬件环境信息

物理机即可


# 3     测试结论概述

## 3.1   测试整体结论

测试结论总结
kuasar在openEuler 23.09测试镜像，共经过两轮测试，共计执行6个用例，对支持的14个CRI接口和基础配置进行了测试，验证了性能相对于社区方案是否提升，发现问题已解决，回归通过，遗留风险小，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 新增特性测试 |  针对目前支持的CRI接口及基本配置进行测试，验证基础功能正常   |
| 可靠性测试 |  并发测试   |   针对命令并发执行进行并发测试，验证执行正常      |
| 可靠性测试 |  长稳测试   |   针对生命周期进行长稳测试，发现问题已解决，验证执行正常      |
| 性能测试 |  底噪测试   |   针对kuasar特性测试底噪消耗，对比社区方案底噪提升50%      |


## 3.2   约束说明

kuasar需要运行在裸金属服务器上，**暂不支持kuasar运行在虚拟机内**。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|          |          |          |                    |          |
|          |          |          |                    |          |

### 3.3.2 问题统计
| 问题单号 | 问题描述 | 问题级别 | 当前状态 |
| -------- | -------- | -------- | -------- |
|https://gitee.com/openeuler/iSulad/issues/I80GXR?from=project-issue| isulad服务概率性发生unix /var/run/isulad.sock: connect: connection refused|缺陷|已解决|


|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |  1      |  1   |  0   |  0   |   0    |
| 百分比 |  100%    |  100%  | 0% |  0%  |   0%   |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论


### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1 |kuasar统一容器运行时 | <font color=blue>▲</font> |   |

## 4.2 兼容性测试结论

## 4.3 DFX专项测试结论
### 4.3.1 性能测试结论
| 测试类型 |测试内容  |	测试结论 |
| ------- | ------- | -------- |
| 性能测试| 各个组件的内存占用内存开销降低50% | 测试通过|

### 4.3.2 可靠性/韧性测试结论
| 测试类型 | 测试内容 | 活动评价 |
| ------- | -------- | ------- |
| 并发测试 | 测试命令并发执行|1个测试用例执行通过|
|生命周期长稳测试|测试生命周期长稳 | 1个测试用例执行通过|
### 4.3.3 安全测试结论

## 4.4 资料测试结论
https://gitee.com/openeuler/docs/pulls/7351/files
资料测试通过

# 5 测试执行
## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-23.09-RC3  |  1个        |      失败1个      |     1       |
| openEuler-23.09-RC4  |  6个        |       成功6个     |     0        |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 

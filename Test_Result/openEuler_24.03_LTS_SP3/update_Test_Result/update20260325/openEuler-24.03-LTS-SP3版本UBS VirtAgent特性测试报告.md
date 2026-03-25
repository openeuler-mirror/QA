![image.png](https://raw.atomgit.com/user-images/assets/9496906/e5df86b4-e7c5-4b8e-a53e-79b758bb1a3c/image.png 'image.png')


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期          | 修订版本 | 修改描述         | 作者       |
| ------------- | ------- | --------------- | ---------- |
| 2026.3.25    | v1.0    | UBS VirtAgent特性测试报告 | wuchangwang |

关键词： UBS VirtAgent

摘要：本文主要描述UBS VirtAgent openEuler-24.03-LTS-SP3-update20260325版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |


# 1     特性概述

UBS VirtAgent是面向虚拟化场景的核心组件之一，提供虚拟化场景下虚机和容器场景的内存逃生能力，主要涉及虚机碎片、虚机超分场景内存借用/归还，虚机迁移，容器场景内存借用/归还。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                 | 测试起始时间 | 测试结束时间 |
| ----------------------- | ----------- | ----------- |
| openEuler-24.03-LTS-SP3-update20260325 | 2026-3-20  | 2026-3-25  |

描述特性测试的硬件环境信息

| 硬件型号  | 硬件配置信息 | 备注  |
| -------- | ----------- | ---- |
| 920新版本 |  典型配置   | 两节点 |
| 920新版本 |  典型配置   | 四节点 |


# 3     测试结论概述

## 3.1   测试整体结论

UBS VirtAgent共执行用例264个，进行了功能、性能、可靠性测试，资料测试，未发现问题，验收通过，整体质量良好。
|  测试活动  |   测试子项    | 活动评价 |
| ---------- | ------------ | ------- |
| 功能测试    | 新增特性测试 | 测试通过 |
| DFX测试  |  性能测试   | 测试通过 |
| DFX测试 |   可靠性测试   | 测试通过 |
| DFX测试 |   安全测试   | 测试通过 |
| 资料测试    |             | 测试通过 |

## 3.2   约束说明

依赖UBSE和UBS RMRS相关组件

## 3.3   遗留问题分析

不涉及


# 4 详细测试结论

## 4.1 功能测试


### 4.1.1 继承特性测试结论

不涉及

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 虚机碎片场景内存借用/归还 | <font color=green>■</font> |   |
| 2 | 虚机超分场景内存借用/归还 | <font color=green>■</font> |   |
| 3 | 容器场景内存借用/归还 | <font color=green>■</font> |   |
| 4 | 内存超分场景虚机迁移 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论
不涉及
## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论
| 验收场景    | 验收标准                        | 测试结论          |
| ---------  | ------------------------------ | ----------------- |
| 虚拟化内存超分场景中，虚拟机性能规格 | 虚拟机内存借用小于25%，虚拟机性能劣化小于5%         | 测试通过 |
| 虚拟机迁移规格 | onecopy和multicopy中断时长不超过50ms          | 测试通过 |


### 4.3.2 可靠性/韧性测试结论
| 测试类型    | 测试内容                       | 测试结论          |
| ---------  | ------------------------------ | ----------------- |
| 可靠性测试 | 资源调度关键阶段UBS Engine进程故障          | 测试通过 |
| 可靠性测试 | 资源调度关键阶段Ubturbo进程故障          | 测试通过 |

## 4.4 资料测试结论

| 测试类型    | 测试内容                        | 测试结论          |
| ---------  | ------------------------------ | ----------------- |
| API接口文档 | https://gitcode.com/openeuler/ubs-engine/tree/master/src/addons/virt_agent/docs/api         | 测试通过 |
| 最佳实践 | https://gitcode.com/openeuler/ubs-engine/blob/master/src/addons/virt_agent/docs/example/best_case.md     | 测试通过 |
| 配置说明    | https://gitcode.com/openeuler/ubs-engine/blob/master/src/addons/virt_agent/docs/config/%E9%85%8D%E7%BD%AE%E8%AF%B4%E6%98%8E.md         | 测试通过 |
| 构建指导    | https://gitcode.com/openeuler/ubs-engine/blob/master/src/addons/virt_agent/docs/build_install/%E6%9E%84%E5%BB%BA%E6%8C%87%E5%AF%BC.md  | 测试通过 |
| 部署说明    | https://gitcode.com/openeuler/ubs-engine/blob/master/src/addons/virt_agent/docs/build_install/%E9%83%A8%E7%BD%B2%E8%AF%B4%E6%98%8E.md  | 测试通过 |
| UT开发指南    | https://gitcode.com/openeuler/ubs-engine/blob/master/src/addons/virt_agent/docs/test/%E5%8D%95%E5%85%83%E6%B5%8B%E8%AF%95%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97.md  | 测试通过 |
| README    | https://gitcode.com/openeuler/ubs-engine/blob/master/src/addons/virt_agent/docs/readme/README.md | 测试通过 |
| 设计文档    | https://gitcode.com/openeuler/ubs-engine/tree/master/src/addons/virt_agent/docs/design | 测试通过 |

## 4.5 其他测试结论
NA

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

|         版本名称             | 测试用例数 | 用例执行结果 | 发现问题单数 |
| --------------------------- | ---------- | ------------ | --------- |
|openEuler-24.03-LTS-SP3-update20260325 |     264    |     264      |     0     |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 
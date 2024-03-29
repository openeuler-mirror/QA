![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者                    |
| ---------- | ----------- | -------- | ----------------------- |
| 2023/12/20 | v1          | init     | jiangdongxu1@huawei.com |
|            |             |          |                         |

关键词： 内核态vDPA 热插拔 热迁移

摘要：本次内核态vDPA特性主要新增支持配置内核态vDPA设备虚拟机的基本生命周期（define/undefine/suspend/resume/start/destroy)，同时支持内核态vDPA设备的热插拔以及热迁移能力。


缩略语清单：

| 缩略语 | 英文全名                      | 中文解释           |
| ------ | ----------------------------- | ------------------ |
| vDPA   | virtio data path acceleration | virtio数据路径加速 |
|        |                               |                    |

# 1     特性概述

- 内核态vDPA设备支持：基于openEuler 2203 LTS SP1版本支持的generic vDPA特性，完成libvirt管理软件对于vDPA设备的支持，并完成配置内核态vDPA设备虚拟机的基本生命周期支持，包括define/undefine/start/destroy/suspend/resume等。

- 内核态vDPA设备支持热插拔：支持在虚拟机运行过程中，动态热插/热拔虚拟机的内核态vDPA设备，大大提高了内核态vDPA设备的使用灵活性。

- 内核态vDPA设备支持热迁移：支持配置内核态vDPA设备的虚拟机热迁移，提高vDPA虚拟机的可运维性。

  

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                     | 测试起始时间 | 测试结束时间 |
| ---------------------------- | ------------ | ------------ |
| openEuler-22.03-LTS-SP3-rc-2 | 2023/12/11   | 2023/12/18   |
|                              |              |              |

描述特性测试的硬件环境信息

| 硬件型号              | 硬件配置信息        | 备注 |
| --------------------- | ------------------- | ---- |
| TaiShan 2280 V2服务器 | 96U 128G + 智能网卡 | ARM  |
|                       |                     |      |

# 3     测试结论概述

## 3.1   测试整体结论

共计执行用例22个，主要覆盖了功能测试、性能测试。测试过程通过功能测试，发现1个主要问题，3个次要问题，现已解决，回归测试通过，整体质量良好

| 测试活动 | 活动评价 |
| ------- | ------- |
| 功能测试 | 测试新增内核态vDPA设备支持、热插拔、热迁移等功能测试；测试vdpa设备资源创建、删除、查询等接口 |
| 性能测试 | 测试需求规格（4U8G 3vDPA）设备热迁移中断时间，符合要求 |

## 3.2   约束说明

1. 仅支持aarch64架构上支持内核态vDPA
2. 当前仅支持华为SP623Q智能网卡，其他网卡如需使用内核态vDPA，需要开发符合vDPA框架的vDPA驱动，再对接使用。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 4        | 0    | 1    | 3    | 0      |
| 百分比 |          | 0    | 25%  | 75%  | 0      |

# 4 详细测试结论

## 4.1 功能测试
### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 支持通用vDPA设备 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | libvirt支持vDPA设备配置 | <font color=green>■</font> |   |
| 2 | vDPA设备支持基本生命周期（define/undefine/start/stop/suspend/resume） | <font color=green>■</font> |   |
| 3 | vDPA设备支持热插拔 | <font color=green>■</font> | |
| 4 | vDPA设备支持热迁移 | <font color=blue>▲</font> | |
| 5 | 支持vDPA设备创建/删除/查询 | <font color=green>■</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

暂不涉及兼容性测试。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标值 | 测试结论 |
| ------- | ------ | ------- |
| 热迁移中断时间（4U8G 3vDPA设备） | 600ms~800ms | 满足特性要求（小于1s） |

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称                     | 测试用例数 | 用例执行结果      | 发现问题单数 |
| ---------------------------- | ---------- | ----------------- | ------------ |
| openEuler-22.03-LTS-SP3-rc-2 | 22         | 18 Paas+ 4 Failed | 4            |
|                              |            |                   |              |

## 5.2   后续测试建议

- 关注虚拟机重启 + suspend/resume/migrate等生命周期操作并发的情况

# 6     附件

## 6.1   vDPA虚拟机热迁移中断时间

- 硬件环境： TaiShan 2280 V2
- OS： openEuler 2203 LTS SP3
- 虚拟机规格： 4U8G 3单队列 vDPA设备
- 热迁移中断时间：600ms ~ 800ms

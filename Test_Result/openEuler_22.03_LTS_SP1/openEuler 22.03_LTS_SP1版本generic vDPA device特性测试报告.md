![avatar](../../images/openEuler.png)


版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2022/12/20     |  v1.0           |    添加generic vDPA device特性测试报告      |  zhaopengyuan |
|      |             |          |      |
|      |             |          |      |

 关键词： 
generic vDPA device
 

摘要：
 generic vDPA device是指用一种通用类型支持VIRTIO_ID_CRYPTO,VIRTIO_ID_FS,VIRTIO_ID_NET,VIRTIO_ID_BLOCK,VIRTIO_ID_CONSOLE,VIRTIO_ID_SCSI,VIRTIO_ID_9P,VIRTIO_ID_BALLOON,VIRTIO_ID_RNG等9种VIRTIO设备。
 依据测试要求，对generic vDPA device特性进行功能测试和稳定性测试。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|  vDPA      |  virtio data path acceleration        |   virtio 数据路径加速       |
|        |          |          |

# 1     特性概述

本特性可以将多种virtio设备向qemu呈现为统一的/dev/vhost-vdpa-*字符设备。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|    openEuler 22.03-LTS SP1 RC2      |     2022-12-02         |    2022-12-08          |
|    openEuler 22.03-LTS SP1 RC4      |     2022-12-16         |    2022-12-22          |
|          |              |              |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|    TaiShan 2280 V2      |   Kunpeng 920-4826 @ 2.6GHz *2           |      |

# 3     测试结论概述

## 3.1   测试整体结论

generic vDPA device特性，共计执行14个用例，主要覆盖了功能测试和稳定性测试。发现问题已解决，回归通过，无遗留风险，整体质量良好。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 功能测试 | 针对generic vDPA device的创建、删除和使用进行了正常及异常测试，结果符合预期 |
| 稳定性测试 | 反复创建删除generic vDPA device，未发现创建失败、残留、无法使用等问题，结果符合预期         |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无

### 3.3.2 问题统计

无

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|    openEuler 22.03-LTS SP1 RC2      | 14 |   passed         |    0          |
|    openEuler 22.03-LTS SP1 RC4      | 14 |   passed         |    0          |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

# 5     附件

N/A


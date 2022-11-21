![avatar](../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 11月21日 | 1.0.0 | 初稿 | zhaopengyuan |

关键词： generic vDPA device

 
摘要：
支持generic vDPA device，用一种通用类型可以支持VIRTIO_ID_CRYPTO,VIRTIO_ID_FS,VIRTIO_ID_NET,VIRTIO_ID_BLOCK,VIRTIO_ID_CONSOLE,VIRTIO_ID_SCSI,VIRTIO_ID_9P,VIRTIO_ID_BALLOON,VIRTIO_ID_RNG等9种VIRTIO设备。



缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |


# 特性描述
<!-- 主要介绍特性实现的背景、功能以及作用 -->

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|[I605QY](https://gitee.com/openeuler/release-management/issues/I605QY)|支持generic vDPA Device|Discussion|sig-Kernel,sig-Virt||ISO|kernel,qemu|
|     |    |    |   |     |     |     |

## 风险项
<!-- 主要描述特性已知风险项 -->

# 特性分层策略
## 总体测试策略
<!-- 主要描述特性的整体测试策略，主要开展哪些测试(接口/功能/场景/专项) -->
- 测试目标：内核可以创建和删除/dev/vhost-vdpa-X字符设备，qemu可以正常使用该字符设备。

## 特性测试约束
<!-- 主要描述特性测试的约束条件 -->

## 接口测试
<!-- 主要描述接口级测试策略及测试设计思路 -->
| 接口描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
|         |         |         |      |
|         |         |         |      |

## 功能测试
<!-- 主要描述特性提供的功能的测试策略及测试思路 -->
| 功能描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| 创建/dev/vhost-vdpa-X字符设备 | 注册vdpa设备后，看是否vhost-vdpa能创建/dev/vhost-vdpa-X字符设备 |         |      |
| 删除/dev/vhost-vdpa-X字符设备 | 删除vdpa设备后，看是否vhost-vdpa能删除/dev/vhost-vdpa-X字符设备 |         |      |
| qemu使用/dev/vhost-vdpa-X字符设备 | 使用“-device vhost-vdpa-device-pci,vhostdev=/dev/vhost-vdpa-”命令启动qemu，guest里能正常看到对应的virtio设备 |         |      |

## 场景测试
<!-- 主要描述对特性使用的主要场景的测试策略及测试思路 -->
| 场景描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
|         |         |         |      |
|         |         |         |      |

## 专项测试
<!-- 主要描述其他专项测试,如安全测试 稳定性测试 性能测试 兼容性测试等 -->
| 专项测试类型 | 专项测试描述 | 测试预期结果 | 备注 |
| ----------- | ----------- | ----------- | ---- |
| 稳定性测试 | 创建和删除字符设备功能可重复 | 创建和删除字符设备重复循环进行，不会出现残留或者异常 |      |

# 特性测试环境描述
<!-- 主要描述执行测试的硬件信息 -->
| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  |              |      |

# 特性测试执行策略

## 测试计划
<!-- 测试执行策略主要描述该轮次执行的分层策略中的测试项 -->
| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
| round1 | 2022/11/23 | 2022/11/29 | 7 | 全量SIT测试 |        |
| round3 | 2022/12/2 | 2022/12/8 | 7 | 回归测试 |        |

# 入口标准

# 出口标准

# 附件

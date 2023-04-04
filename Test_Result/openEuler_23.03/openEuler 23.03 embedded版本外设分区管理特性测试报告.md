![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|  2023/03/28    |   v1.0          |   添加外设分区管理特性报告       |  黄宏帅    |

 关键词：外设分区管理



摘要：

 本报告主要描述基于openEuler 23.03 embedded版本进行的外设分区管理特性的测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|    |         |      |
|        |          |          |

# 1     特性概述

混合关键性系统实现外设分区管理功能，能够让用户自行配置各OS需要的外设资源。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 23.03 embedded          |  2023/3/13            |     2023/3/17         |


描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|   qemu       |   CPU:Cortex-A57<br>最小启动内存：512M|      |

# 3     测试结论概述

## 3.1   测试整体结论

外设分区管理特性，共计执行1个用例，主要覆盖了功能测试，整体质量良好；

测试对象：树莓派的openeuler-image标准镜像 和 openeuler-image-mcs 混合部署镜像

测试步骤：

1.由于树莓派默认不enable uart5，因此需要加载dtoverlay使能uart5：
下载并解压openEuler树莓派固件：
    
    a. 下载并解压openEuler树莓派固件：
    git clone https://gitee.com/src-openeuler/raspberrypi-firmware.git
    tar -xzf firmware-2c9ca22c4aedd1a8a6bc14698be5861525f2bfdf.tar.gz
    
    
    b. 安装uart5.dtbo到树莓派的boot分区中
    cp ./firmware-2c9ca22c4aedd1a8a6bc14698be5861525f2bfdf/boot/overlays/uart5.dtbo <pi_boot_path>/overlays/
    
    c. 修改config.txt，使能uart5
    vi <pi_boot_path>/config.txt
    # 添加 uart5
    dtoverlay=uart5

2.分别为 树莓派标准镜像 和 树莓派混合部署镜像，按照步骤1，使能uart5。之后，cat /proc/tty/driver/*对比tty的数量

树莓派标准镜像结果：

```shell
raspberrypi4-64 ~ # cat /proc/tty/driver/*
serinfo:1.0 driver revision:
0: uart:16550 mmio:0xFE215040 irq:22 tx:1437 rx:0 RTS|CTS|DTR
serinfo:1.0 driver revision:
0: uart:PL011 rev2 mmio:0xFE201000 irq:21 tx:0 rx:0
1: uart:PL011 rev2 mmio:0xFE201A00 irq:21 tx:0 rx:0 CTS
usbserinfo:1.0 driver:2.0
```

树莓派混合部署镜像结果（使能了外设分区管理）：

```shell
raspberrypi4-64 ~ # cat /proc/tty/driver/*
serinfo:1.0 driver revision:
0: uart:16550 mmio:0xFE215040 irq:22 tx:91617 rx:27381 oe:2 RTS|CTS|DTR
serinfo:1.0 driver revision:
0: uart:PL011 rev2 mmio:0xFE201000 irq:21 tx:0 rx:0
usbserinfo:1.0 driver:2.0
```


测试结论：如上所示，混合部署镜像外设分区管理功能正常，能够成功将uart5从Linux中隔离出来。

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|          |          |          |                    |          |
|          |          |          |                    |          |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |          |      |      |      |        |
| 百分比 |          |      |      |      |        |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|  openEuler 23.03 embedded        |      1      |     通过1个，失败0个         |           0   |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*
![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者    |
| ---------- | ----------- | -------- | ------- |
| 2025/03/27 | 1.0.0       | 初稿     | Lyle Li |

关键词： Zhaoxin 

摘要：本文主要介绍在openEuler 25.03-rc3版本上对Zhaoxin OLK-6.6补丁包进行测试的相关情况，包括测试环境、测试过程与测试结果。

# 1     特性概述

该测试报告叙述了在openEuler 25.03-rc3版本上，针对Zhaoxin处理器进行Zhaoxin OLK-6.6补丁测试的相关情况。

Zhaoxin OLK-6.6补丁包提供了对Zhaoxin CPU相关特性的软件支持和错误修正，包含以下部分：

- 软件支持

  - 在cpufreq驱动中添加了ITMT支持，以帮助操作系统识别频率最高的核心。
  - 提供了Zhaoxin AHCI SGPIO背板管理驱动。
  - 增加了对Zhaoxin ZDI/ZPI错误译码的支持。
  - 提供了Zhaoxin SMBUS控制器驱动；
  - 在Zhaoxin PMU uncore驱动中添加了对KX-7000 CPU的支持；
- 错误修正

  - 修复了USB设备虚拟化相关的错误；
  - 解决了mce和hpet死锁的问题；
  - 修正了一些编译错误；

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| openEuler 25.03-rc3 | 2025/03/27   | 2025/03/28   |

描述特性测试的硬件环境信息

| 硬件型号         | 硬件配置信息                                               | 备注 |
| ---------------- | ---------------------------------------------------------- | ---- |
| Zhaoxin KH-40000 | 板卡：HX003ED0-32Core-2GHz 内存： 32G 硬盘： SATA SSD 500G |      |

# 3     测试结论概述

## 3.1   测试整体结论

在基于openEuler 25.03-rc3版本的用于Zhaoxin CPU的操作系统内核中，针对其功能共计执行两项测试，功能正常，整体质量良好；

| 测试活动 | 测试子项                                     | 活动评价 |
| -------- | -------------------------------------------- | -------- |
| 功能测试 | 系统启动运行                                 | 测试通过 |
| 功能测试 | Zhaoxin OLK-6.6补丁功能测试（共8个测试用例） | 测试通过 |

## 3.2   约束说明

- 架构：x86

- 使用Zhaoxin AHCI SGPIO背板特性时需使用minisas(RMS36-5580 AX1-00)和背板HX003DH0-LB;


# 4 详细测试结论

## 4.1 功能测试
Zhaoxin OLK-6.6补丁功能测试共计执行8个测试用例，通过8个，失败0个，跳过0个，测试情况如下；

| 序号 |                          测试补丁                           |          测试内容          | 结果 |
| :--: | :---------------------------------------------------------: | :------------------------: | :--: |
|  1   | USB: Fix kernel NULL pointer when unbind UHCI from vfio-pci | USB设备虚拟化绑定/解绑测试 | 通过 |
|  2   |      cpufreq: ACPI: add ITMT support when CPPC enabled      |          ITMT功能          | 通过 |
|  3   | ata: ahci: Add support for AHCI SGPIO Enclosure Management  |   AHCI SGPIO背板功能测试   | 通过 |
|  4   |     efi:cper: Add Zhaoxin/Centaur ZDI/ZPI error decode      |      ZDI/ZPI功能测试       | 通过 |
|  5   |    i2c: smbus: Add support for Zhaoxin SMBUS controller     |    SMBUS控制器功能测试     | 通过 |
|  6   |        perf/x86/zhaoxin.core: update KX-7000 support        |     PMU uncore功能测试     | 通过 |
|  7   |        x86/mce：Add NMIs setup in machine_check_func        |        MCE功能测试         | 通过 |
|  8   |      x86/hpet: Read HPET directly if panic in progress      |        HPET功能测试        | 通过 |

 基于以上测试情况，可得出以下测试结论；

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称                                               |                    特性质量评估                    | 备注                                                         |
| ---- | ----------------------------------------------------------- | :------------------------------------------------: | ------------------------------------------------------------ |
| 1    | USB: Fix kernel NULL pointer when unbind UHCI from vfio-pci |             <font color=green>■</font>             | 测试通过，未发现问题；多次任意顺序解绑uHCI/eHCI到vfio-pci和从vfio-pci解绑到uhci_hcd/ehci-pci未发生错误。 |
| 2    | perf/x86/zhaoxin.core: update KX-7000 support               | <font color=blue><font color=green>■</font></font> | 测试通过，未发现问题；通过检测系统日志未发现问题，perf list/top/stat/record执行均符合功能预期。 |
| 3    | x86/mce：Add NMIs setup in machine_check_func               | <font color=blue><font color=green>■</font></font> | 测试通过，未发现问题；循环多次复现发生mce死锁的情况，系统均正常工作。 |
| 4    | x86/hpet: Read HPET directly if panic in progress           | <font color=blue><font color=green>■</font></font> | 测试通过，未发现问题；循环多次复现hpet发生死锁的情况，系统均正常工作。 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称                                              |                    特性质量评估                    | 备注                                                         |
| ---- | ---------------------------------------------------------- | :------------------------------------------------: | ------------------------------------------------------------ |
| 1    | cpufreq: ACPI: add ITMT support when CPPC enabled          |             <font color=green>■</font>             | 测试通过，未发现问题；                                       |
| 2    | ata: ahci: Add support for AHCI SGPIO Enclosure Management | <font color=blue><font color=green>■</font></font> | 测试通过，未发现问题；读写触发active LED闪烁测试、fail模式测试、identify模式测试均通过。 |
| 3    | i2c: smbus: Add support for Zhaoxin SMBUS controller       | <font color=blue><font color=green>■</font></font> | 测试通过，未发现问题。                                       |
| 4    | efi:cper: Add Zhaoxin/Centaur ZDI/ZPI error decode         | <font color=blue><font color=green>■</font></font> | 测试通过，未发现问题。                                       |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称            | 测试用例数 | 用例执行结果 | 发现问题单数 |
| ------------------- | ---------- | ------------ | ------------ |
| openEuler 25.03-rc3 | 8          | pass         | 0            |

 
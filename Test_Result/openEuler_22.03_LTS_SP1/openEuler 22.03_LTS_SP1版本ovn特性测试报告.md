![avatar](../../images/openEuler.png)


版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2022/12/16 | 1.0.0 | OVN 测试报告 | 韩光宇 |

 关键词： OVN OVS SDN

摘要：按照测试策略，对 OVN 进行功能测试、可靠性测试。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
|-|-|-|
| OVS | Open vSwitch | 一种多层虚拟交换机开源软件 |
| OVN | Open Virtual Network | OVS提供的原生虚拟化网络方案，旨在解决传统SDN架构（比如Neutron DVR）的性能问题。 |
| CMS | cloud management software | 云管理软件 |

# 1     特性概述

OVN (Open Virtual Network) 是 OVS 提供的原生虚拟化网络方案，旨在解决传统 SDN 架构（比如Neutron DVR）的性能问题。同时 OVN 也是 OpenStack 目前的网络参考实现。

OVN 提供比 Open vSwitch 更高的抽象层，与逻辑路由器和逻辑交换机一起工作。与Open vSwitch一样，OVN是用独立于平台的C 语言编写的。OVN 完全在用户空间中运行，因此不需要安装内核模块。OVN旨在供云管理软件（CMS）使用，它提供的一些高级功能包括：

- 分布式虚拟路由器
- 分布式逻辑交换机
- 访问控制列表
- DHCP
- 域名服务器

OVN 的引入不仅可以增强 openEuler OpenStack 支持，同时也可以补充 OpenStack 上游社区 CI 对 OVN 的依赖。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 22.03 LTS SP1 RC1 |  2022/11/23 | 2022/11/29 |
| openEuler 22.03 LTS SP1 RC2 | 2022/12/2 | 2022/12/8 |
|  openEuler 22.03 LTS SP1 RC3 |  2022/12/9 |  2022/12/15 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| Hygon C86 7285 |  Hygon C86 7285 32-core Processor 8U16G | x86 架构虚拟机 |

# 3     测试结论概述

## 3.1   测试整体结论

OVN 特性，共计执行258个用例，主要覆盖了接口测试、功能测试、可靠性测试和安全测试，发现问题已解决，回归通过，遗留风险小，整体质量良好。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 接口测试 | 对 OVN 命令行开展接口测试，结果符合预期   |
| 功能测试 | 对 OVN 功能展开测试，结果符合预期    |
| 可靠性测试 | 对 OVN 异常配置，进程启停展开测试，结果符合预期    |
| 安全测试 | 安装包内的文件权限符合要求   |

## 3.2   约束说明

1. OVN 在 OVS 的基础上提供原生的高层抽象，例如虚拟L2，L3覆盖网络以及完全组。OVN将高层次的网络抽象转换成具体的网络配置和流表，下发到各个节点的OVS上，它的功能依赖于 OVS，使用 OVN 的环境中首先需要具备 Open vSwitch。
2. 手动启动 OVN central 的场景，在启动 ovn-northd 之前，需要首先启动 OVN Northbound 和 Southbound ovsdb-servers。
3. OpenStack Train 版本及之前，neutron 与 OVN 的对接需要通过 networking-ovn 项目。Ussuri 版开始，networking-ovn项目功能被集成到 neutron 中，方可直接对接。
4. 如果想要使用 OVN 作为 Octavia 的 provider，需要 octavia-lib 项目的支持。

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
| openEuler 22.03 LTS SP1 RC1 |     257   |     passed      |     0       |
| openEuler 22.03 LTS SP1 RC2 |     258   |     passed      |     0       |
| openEuler 22.03 LTS SP1 RC3 |     258   |     passed      |     0       |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5 附件

*N/A*
# openEuler 24.03 LTS SP4 测试报告

![openEuler ico](../../img/openEuler.png)

版权所有 © 2026 openEuler社区 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订版本 | 修改描述 | 作者 |
|---|---|---|---|
| 2026-08-24 | 1 | 初稿 | 陈智超 |

关键词：

OpenStack

摘要：

在 `openEuler 24.03 LTS SP4` 版本中提供 `OpenStack Gazpacho` 版本的 `RPM` 安装包，方便用户快速部署 `OpenStack`，并在 x86_64 与 aarch64 两种架构下完成验证。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
|---|---|---|
| CLI | Command Line Interface | 命令行工具 |
| ECS | Elastic Cloud Server | 弹性云服务器 |

## 1 特性概述

在 `openEuler 24.03 LTS SP4` 版本中提供 `OpenStack Gazpacho` 版本的`RPM`安装包，包括以下项目以及每个项目配套的 `CLI`。

-   Nova
-   Swift
-   Glance
-   Keystone
-   Neutron
-   Cinder
-   Horizon
-   Adjutant
-   Aetos
-   Aodh
-   Barbican
-   Blazar
-   Ceilometer
-   Cloudkitty
-   Cyborg
-   Designate
-   Freezer
-   Freezer-Api
-   Heat
-   Ironic
-   Magnum
-   Manila
-   Masakari
-   Mistral
-   Octavia
-   Placement
-   Skyline-Apiserver
-   Skyline-Console
-   Storlets
-   Tacker
-   Trove
-   Watcher
-   Zaqar
-   Zun


上述项目覆盖计算、存储、网络、认证、Web控制台、编排、裸机、容器、数据库、监控告警、计费、备份、加速器、NFV 编排等云平台核心与扩展能力。
其中 `Nova`、`Keystone`、`Glance`、`Placement`、`Neutron`、`Cinder`、`Swift`、`Horizon` 为云平台核心服务，提供计算、认证、镜像、资源、网络、块存储、对象存储及 Web 控制台能力。

#### 组件覆盖扩展

此前 openEuler 24.03 LTS SP4 提供的是 `Wallaby`、`Antelope` 版本。`Gazpacho` 版本与上游发行版范围对齐，首次打包提供以下 OpenStack 项目：

*除`Aetos`外，这些项目在 OpenStack 社区早已发布，并非社区新增特性。*

-   `Adjutant`：基于工作流的管理自动化框架，提供租户自助注册、资源配额申请等自助管理功能。
-   `Freezer`/`Freezer-Api`：提供分布式数据备份与恢复能力，支持对文件系统、数据库、块存储卷（`Cinder`）等的备份管理。
-   `Skyline-Apiserver`/`Skyline-Console`：`OpenStack Modern Dashboard` 的组成部分，为 OpenStack 服务提供基于 Web 的管理界面。
-   `Storlets`：扩展 `Swift` 对象存储，使其能够在数据附近以安全、隔离的方式运行用户定义的计算（`storlet`）。
-   `Tacker`：提供 NFV 编排服务，内置通用 VNF 管理器，用于在 NFV 平台上部署与运营虚拟网络功能（VNF）和网络服务（基于 ETSI MANO 架构框架）。
-   `Zun`：提供容器运行 API 服务，用户无需管理底层服务器或集群即可直接运行应用容器。
-   `Aetos`：反向代理，置于 `Prometheus` 前端，对每次 `Prometheus` 查询强制执行 OpenStack 多租户与 `Keystone` 认证。

## 2 特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
|---|---|---|
| openEuler 24.03 LTS SP4（OpenStack Gazpacho版本各组件的安装部署测试） | 2026.08.17 | 2026.08.18 |
| openEuler 24.03 LTS SP4（OpenStack Gazpacho版本基本功能测试，包括虚拟机，卷，网络相关资源的增删改查） | 2026.08.19 | 2026.08.20 |
| openEuler 24.03 LTS SP4（OpenStack Gazpacho版本tempest集成测试） | 2026.08.21| 2026.08.23 |
| openEuler 24.03 LTS SP4（OpenStack Gazpacho版本问题回归测试） | 2026.08.24 | 2026.08.24 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
|---|---|---|
| 华为云ECS | Intel Cascade Lake 16U/62G | 华为云x86虚拟机 |
| 华为云ECS | Huawei Kunpeng 920 8U/16G | 华为云arm64虚拟机 |

## 3 测试结论概述

### 3.1 测试整体结论

`OpenStack Gazpacho` 版本，共计执行 `Tempest` 用例 `1004` 个，主要覆盖了 `API` 测试和功能测试，通过功能与回归验证。

*`Skip` 用例 `105` 个（全是 `OpenStack Gazpacho` 版中已废弃的功能或接口，如Keystone V1、Cinder V1等），失败用例 `0` 个，其他 `899` 个用例全部通过。*

发现问题已解决，回归通过，无遗留风险，整体质量良好。

| 测试活动 | tempest集成测试 |
|---|---|
| 接口测试 | API全覆盖 |
| 功能测试 | Gazpacho 版本覆盖 Tempest 所有相关测试用例 1004 个，其中 Skip 105 个，Fail 0 个，其他全通过 |

| 测试活动 | 功能测试 |
|---|---|
| 资源管理 | 虚拟机（KVM、Qemu）、存储（lvm、NFS、Ceph后端）、网络资源（openvswitch）管理操作正常 |

### 3.2 约束说明

本次测试没有覆盖 `OpenStack Gazpacho` 版中明确废弃的功能和接口，因此不能保证已废弃的功能和接口（前文提到的Skip的用例）在 `openEuler 24.03 LTS SP4` 上能正常使用。

### 3.3 遗留问题分析

#### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
|---|---|---|---|---|
| N/A | N/A | N/A | N/A | N/A |

#### 3.3.2 问题统计

| 问题总数 | 严重 | 主要 | 次要 | 不重要 |
|---|---|---|---|---|
| 数目 | 0 | 0 | 0 | 0 | 0 |
| 百分比 | 0| 0 | 0 | 0 | 0 |

## 4 测试执行

### 4.1 测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
|---|---|---|---|
| openEuler 24.03 LTS SP4 OpenStack Gazpacho | 1004 | 通过 899 个，skip 105 个，Fail 0 个 | 0 |

### 4.2 后续测试建议

1.  涵盖更多的性能测试。
2.  覆盖更多的 driver/plugin 测试。
3.  重点测试 Gazpacho 版本对 python3.11 版本的适配情况。

## 5 附件

*N/A*

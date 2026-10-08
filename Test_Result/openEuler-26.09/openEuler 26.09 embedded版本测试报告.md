![openEuler ico](../../images/openEuler.png)

版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述                                        |
| ---------- | -------- | ------------------ | ----------------------------------------------- |
| 2026/09/23 | 1.0    | 全部               | openEuler 26.09 embedded版本测试报告初稿 | zjl_long |
| 2026/09/24 | 1.1    | 全部               | openEuler 26.09 embedded版本测试报告终稿 | zjl_long |
| 2026/09/24 | 1.2    | 全部               | 更新问题单进展：遗留问题全部闭环 | zjl_long |

关键词：

openEuler Embedded、具身智能、IB-Robot、mugen

摘要：

本文主要描述openEuler 26.09 embedded版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语  | 英文全名                              | 中文解释           |
| ------ | ------------------------------------ | ------------------ |
| oEE    | openEuler Embedded                   | openEuler 嵌入式发行版 |
| IB-Robot | Intelligent Body Robot              | 具身智能机器人中间件 |
| mugen  | -                                    | openEuler 社区用例测试框架 |
| RT     | Real-Time                            | 实时 |
| MCS    | Mixed Criticality System             | 混合关键性系统（混部） |
| HMI    | Human Machine Interface              | 人机交互 |
| ROS    | Robot Operating System               | 机器人操作系统 |
| VLA    | Vision-Language-Action               | 视觉-语言-动作大模型 |
| NPU    | Neural-network Processing Unit       | 神经网络处理单元 |

# 1   概述

本文主要描述openEuler 26.09 embedded版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 26.09 embedded版本在 openEuler 26.03 版本的基础上持续演进，同时支持构建Linux 5.10内核和6.6内核镜像，并进一步扩展双内核镜像的覆盖范围。本版本面向嵌入式与具身智能场景，重构具身智能机器人中间件（IB-Robot 930）等能力，覆盖aarch64、arm、x86-64三种架构共25款交付镜像。

openEuler 26.09 embedded版本按照社区release-manager团队的计划和嵌入式版本开发进展，共规划7轮测试（B001~B005、B007、B008），详细的版本信息和测试时间如下表：

| 版本名称   | 转测时间   | 版本定位                                         | 测试策略                                     | 测试状态 |
| :--------- | :--------- | :----------------------------------------------- | :------------------------------------------- | :------- |
| [26.09.B001](https://gitcode.com/openeuler/yocto-meta-openeuler/commit/64771997cc38084db4d5027dfab20fcce505bd8d?ref=master) | 2026/08/17 | 选择部分镜像开展mugen测试、存量功能测试           | mugen测试、存量功能测试                      | 已完成   |
| [26.09.B002](https://gitcode.com/openeuler/yocto-meta-openeuler/commit/46400daec797aa180206fad2557fa6cc049a736a?ref=master) | 2026/08/31 | 版本专项测试                                     | 反复重启专项、资料专项等测试       | 已完成   |
| [26.09.B003](https://gitcode.com/openeuler/yocto-meta-openeuler/commit/5abc4f348333ffff66f0fdbbf49b55c60c7cd5cb?ref=master) | 2026/09/16 | 问题回归                                         | 问题回归                                     | 已完成   |
| [26.09.B004](https://gitcode.com/openeuler/yocto-meta-openeuler/commit/5abc4f348333ffff66f0fdbbf49b55c60c7cd5cb?ref=master) | 2026/09/16 | IB-ROBOT测试                                     | 开展IB-ROBOT测试                             | 已完成   |
| [26.09.B005](https://atomgit.com/openeuler/yocto-meta-openeuler/commit/9c4964411399e86c7d386114ddfaa2167d59a169?ref=fix-systemd-runtime-watchdog&prId=3022) | 2026/09/20 | 问题回归                                         | 问题回归                                     | 已完成   |
| [26.09.B007](https://gitcode.com/openeuler/yocto-meta-openeuler/commit/7e8ef67fd3b81c837161b03e963cc94c04e9d3f5?ref=openEuler-26.09) | 2026/09/22 | 问题回归                                         | 问题回归                                     | 已完成   |
| [26.09.B008](待补充源码链接) | 2026/09/24 | 问题回归                                         | 问题回归                     | 已完成   |

测试的硬件环境如下：

| 硬件型号       | 硬件配置信息                                                                                                   | 备注                                 |
| -------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| 香橙派310B（20T） | 香橙派310B（20T），用于3591rc镜像替代验证                                                                        | 无物料；3591rc 相关镜像验证           |
| 海鸥派 hieulerpi1 | 4核ARM Cortex-A55，主频1.4GHz，8G内存，4个DDR4颗粒，2个USB口，千兆网卡                                         | 5块单板；hieulerpi1 / hieulerpi1-tiny 镜像 |
| 鲲鹏920 kp920  | 框式设备，armv8.2架构，64核，单核心7nm工艺，CPU主频2.6GHz，DDR4内存，SATA 3.0                                  | 1块单板；kp920-idustry 镜像           |
| 树莓派4B       | Broadcom BCM2711，四核 Cortex-A72 (ARM v8) 64位 @ 1.5GHz，DDR 8G内存，2 USB 3.0端口                             | 5块单板；raspberrypi4-64 系列镜像     |
| hipico         | HI3516CV610芯片（ARM Cortex-A7 MP2），内存颗粒DDR3，RJ45以太网口                                                 | 2块单板；hipico / hipico-minimal 镜像 |
| 工控机 x86-64  | 酷睿i7-10510U，8G内存，256G固态硬盘，4个USB口，intel集成显卡，支持VGA和HDMI显示                                  | 2块单板；x86-64 相关镜像              |
| qemu（仿真）   | qemu仿真由用户决定cpu核心数以及ddr内存大小                                                                        | 仿真平台；qemu-aarch64 / qemu-arm32 系列镜像 |

本版本交付镜像范围（架构 × 硬件 × 镜像）如下：

| 架构    | 硬件         | 测试镜像                                                |
| :------ | :----------- | :------------------------------------------------------ |
| aarch64 | 3591rc       | 3591rc-ibrobot、3591rc-oebridge-systemd                 |
| aarch64 | hieulerpi1   | hieulerpi1-tiny、hieulerpi1                             |
| aarch64 | kp920        | kp920-idustry                                           |
| aarch64 | qemu-aarch64 | qemu-aarch64-clang、qemu-aarch64-clang-kernel6、qemu-aarch64-hmi-mcs-ros、qemu-aarch64-hmi-mcs-ros-kernel6、qemu-aarch64-xfce-systemd、qemu-aarch64-xfce-systemd-kernel6 |
| aarch64 | raspberrypi4-64 | raspberrypi4-64-clang、raspberrypi4-64-clang-kernel6、raspberrypi4-64-hmi-mcs-rt、raspberrypi4-64-hmi-mcs-rt-kernel6、raspberrypi4-64-xfce-systemd、raspberrypi4-64-xfce-systemd-kernel6 |
| aarch64 | ok3588       | ok3588                                                  |
| arm     | hipico       | hipico-minimal、hipico                                  |
| arm     | qemu-arm32   | qemu-arm32                                              |
| x86-64  | x86-64       | X86-64、X86-64-clang、x86-64-hmi-mcs-ros-rt、x86-64-hmi-kernel6-mcs-ros-rt |

本次版本测试活动分工及策略如下：

| 测试活动        | 测试策略                                                     | 测试镜像范围           |
| --------------- | ------------------------------------------------------------ | ---------------------- |
| mugen测试       | 使用openEuler社区mugen测试框架，对转测镜像进行基础功能自动化验证 | 交付范围内镜像     |
| 存量功能测试    | 对关键继承特性（Jailhouse、外设分区、MindSpore Lite、分布式软总线、XEN、图形化、Mica、iSula、蓝牙、RT软实时、OEbridge、epkg、ZVM、Rust等）进行专项验证 | 对应特性支持的镜像     |
| 反复重启专项测试 | 开展单板反复重启专项测试，验证系统稳定性                     | 树莓派4B               |
| 资料专项测试    | 审视26.09版本资料                              | /                      |
| IB-Robot测试    | 对具身智能机器人中间件（IB-Robot 930）纳入测试特性进行验证    | 香橙派310B/310P等      |
| 问题回归测试    | 对历史问题单进行原用例回归验证                               | 对应镜像               |

# 3 版本概要测试结论

openEuler 26.09 embedded版本按照测试策略完成了openEuler Embedded基本功能及存量功能测试，以及针对大颗粒功能ib-robot专项测试活动。

本版本共发现问题28个，已全部回归通过，无遗留问题，问题整体呈收敛趋势，版本风险可控。

# 4 版本详细测试结论

openEuler 26.09 embedded版本详细测试内容包括：

1. 完成基础OS质量保障，对转测镜像开展mugen基础功能自动化测试，测试功能正常，问题发布前闭环；
2. 对关键继承特性，如软实时、外设分区、MindSpore Lite、分布式软总线、XEN、图形化、Mica、iSula、蓝牙、OEbridge、epkg、ZVM、Rust等进行了存量功能测试，问题发布前闭环；
3. 完成各项专项测试（可靠性、资料），测试正常，问题发布前闭环；
4. 对新增特性IB-Robot（具身智能机器人中间件），针对其9个功能开展26个测试点测试，继承功能正常，新增功能正常，问题发布前闭环。

## 4.1   特性测试结论

### 4.1.1   存量关键特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估：

| 序号 | 组件/特性名称                     | 特性质量评估                    | 备注 |
| ---- | --------------------------------- | :------------------------------: | ---- |
| 1 | 单 Jailhouse 测试                 | <font color=green>█</font>        | qemu-aarch64上已测试，无问题 |
| 2 | 外设分区测试（树莓派）            | <font color=green>█</font>       | raspberrypi4-64-hmi-mcs-rt结果不符预期，已提单并回归通过 |
| 3 | 嵌入式 AI 框架测试（MindSpore Lite） | <font color=green>█</font>     | qemu-aarch64-clang已测试，无问题 |
| 4 | 分布式软总线测试                  | <font color=green>█</font>        | qemu-aarch64已测试，无问题 |
| 5 | XEN 底座测试                      | <font color=green>█</font>       | qemu-aarch64已测试，无问题 |
| 6 | 图形化测试                        | <font color=green>█</font>       | raspberrypi4-64-clang已测试，无问题 |
| 7 | Mica 与 Jailhouse 测试            | <font color=green>█</font>       | raspberrypi4-64已测试，无问题 |
| 8 | iSula 测试                        | <font color=green>█</font>        | qemu-aarch64-clang已测试，无问题  |
| 9 | 树莓派蓝牙配置测试                | <font color=green>█</font>       | 已测试，问题已回归通过 |
| 10 | RT 软实时性能测试                 | <font color=green>█</font>       | 树莓派/KP920已测试，无问题 |
| 11 | OEbridge 测试                     | <font color=green>█</font>        | qemu-aarch64已测试，无问题|
| 12 | epkg 测试                         | <font color=green>█</font>       | qemu-aarch64已测试，问题已回归通过 |
| 13 | ZVM 测试                          | <font color=green>█</font>        | qemu-aarch64已测试，无问题 |
| 14 | 具身智能测试（IB_Robot）          | <font color=green>█</font>       | 见4.1.2新需求评价 |
| 15 | Rust 支持测试                     | <font color=green>█</font>       | qemu-aarch64已测试，无问题|

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性测试未完全完成（存在待测/阻塞/部分通过测试点）或遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   IB-ROBOT功能评价

本版本新增需求主要为具身智能机器人中间件（IB-Robot 930），涉及9个功能，详见下表：

| **序号** | **特性ID** | **特性名称**           | **测试优先级** | **测试覆盖情况** | **遗留问题单** | **质量评估** |
| -------- | ---------- | ---------------------- | :------------: | ---------------- | :------------: | :----------: |
| 1 | S01 | 自然语言具身闭环       | P0 | 自然语言→执行全链路状态机（UB/REAL） | 无 | <font color=green>█</font> |
| 2 | S02 | 端到端抓取与放置       | P0 | 抓取→容器放置、双后端抓取一致、标定闭环、导航→抓取连续任务 | 无 | <font color=green>█</font> |
| 3 | S03 | 语义建图与按名导航     | P0 | 建图→按名导航、只读查询、雷达建图、无定位拒绝 | 无 | <font color=green>█</font> |
| 4 | S04 | 统一推理运行时与端边协同 | P0 | 分布式端到端、云端故障隔离、视频三档编码、manifest错配拒绝 | 无 | <font color=green>█</font> |
| 5 | S05 | VLA 模型端侧落地工具链 | P0 | PI0.5导出全链路、量化推理、profile治理、精度自检 | 无 | <font color=blue>▲</font> |
| 6 | S07 | 感知服务统一托管       | P1 | SAM2板端分割一致性、开放词表双后端一致 | 无 | <font color=green>█</font> |
| 7 | S08 | 语音交互               | P1 | TTS双档合成、声源定向、长时连续识别 | 无 | <font color=green>█</font> |
| 8 | S09 | 机器人硬件平台与遥操作 | P2 | 主从臂遥操作示教采集 | 无 | <font color=green>█</font> |
| 9 | S12 | 训练、仿真与数据工具链 | P1 | KD训练、数据间隙修复、RTP录制完整性 | 无 | <font color=green>█</font> |



<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性测试未完全完成（存在待测/阻塞/部分通过测试点）或遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler embedded 均采用断电烧写进行升级，目前不涉及升级兼容性。

### 4.2.2   南向兼容性

南向兼容性经实测验证，支持以下单板，各单板镜像烧录后均可正常启动：

| 硬件型号       | 硬件详细信息 |
| -------------- | ------------ |
| 树莓派4B卡     | CPU:BCM2711(Cortex-A72 * 4)，内存：8GB，存储设备：SanDisk Ultra 64GB micro SD |
| 鲲鹏920        | armv8.2架构，64核，CPU主频2.6GHz，DDR4内存，SATA 3.0 |
| 海鸥派 hieulerpi1 | 4核ARM Cortex-A55@1.4GHz，8G内存 |
| hipico         | HI3516CV610芯片（ARM Cortex-A7 MP2），DDR3 |
| 香橙派310B（20T） | 用于3591rc镜像替代验证 |
| 工控机 x86-64  | Intel i7-10510U，8G内存，256G固态硬盘 |

### 4.2.3   北向兼容性

创新版本北向兼容性暂不考虑进行测试。

## 4.3   专项测试结论

### 安全测试

本次针对 openEuler 26.09 Embedded 版本开展了CVE漏洞扫描、安全编译扫描、安全配置扫描三类安全测试，覆盖27个镜像，安全编译扫描9个检查项，10个安全配置项及2389个CVE待澄清，开发均以澄清且澄清结果已审视，整体风险可控

### 资料测试

| **手册名称** | **测试内容** | **测试结论** |
| ------------ | ------------ | ------------ |
| 《openEuler Embedded 在线手册》 | 准确性、一致性、完整性、可执行性测试 | 检视通过 |

### 可靠性测试

| 测试类型 | 测试内容 | 测试结论 | 备注 | 
| -------- | -------- | -------- | -----|
| 反复重启 | 单板反复重启专项测试 | 反复重启100次，单板均启动正常；发现树莓派4B单板触发内核panic后未狗复位卡死问题（[#1420](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1420)），已修复并回归通过 | 该问题在树莓派上发现，用户也同步关注其他硬件上是否有类似问题 | 

### 具身智能（IB-Robot）测试

本版本新增具身智能机器人中间件IB-Robot 930，共纳入9个特性（自然语言具身闭环、端到端抓取与放置、语义建图与按名导航、统一推理运行时与端边协同、VLA模型端侧落地工具链、感知服务统一托管、语音交互、机器人硬件平台与遥操作、训练仿真与数据工具链）。测试发现6个问题单，均已回归通过。

# 5   问题单统计

openEuler 26.09 embedded 版本共发现问题28个，均已回归通过，无遗留问题。

## 5.1   问题级别统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | :------: | :--: | :--: | :--: | :----: |
| 数目   | 28       | 13   | 7    | 8    | 0      |
| 百分比 | 100%     | 46.4% | 25.0% | 28.6% | 0%     |

## 5.2   问题按测试阶段统计

| 测试阶段   | 发现问题数 | 说明 |
| ---------- | :------: | ---- |
| 26.09.B001 | 16 | mugen测试、存量功能测试阶段，聚焦镜像构建、三方库、SDK等基础功能问题 |
| 26.09.B002 | 2  | 反复重启、资料专项测试阶段 |
| 26.09.B003 | 4  | 问题回归阶段新增mugen、mica问题 |
| 26.09.B004 | 6  | IB-Robot测试阶段，聚焦具身智能功能问题 |
| 26.09.B005 | 0  | 问题回归阶段 |
| 26.09.B007 | 0  | 问题回归阶段 |
| 26.09.B008 | 0  | 问题回归阶段 |
| 合计       | 28 | |

1. B001为操作系统基础测试、外围包及存量关键特性测试，主要聚焦镜像构建、SDK、三方库等基础问题；

2. B002为版本专项测试（反复重启专项、资料专项），聚焦单板重启稳定性与资料检视问题；

3. B004为IB-Robot（具身智能）专项测试，主要聚焦新增特性问题；

4. B003、B005、B007、B008为问题回归测试；

5. 目前版本测试发现问题整体呈收敛趋势，遗留问题均已回归通过，版本在发布前具备发布条件。

## 5.3   已解决问题列表

| issues链接 | 问题描述 | 问题发现活动 | 发现版本 | 问题回归版本 | 回归策略 | 回归结论 |
| ---------- | -------- | ------------ | -------- | ------------ | -------- | -------- |
| [#1361](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1361) | 【测试组-sdk-功能性-严重-26.09】镜像qemu-arm32的sdk初始化报错缺少mpc.h | mugen测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1362](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1362) | 【测试组-epkg-功能性-主要-26.09】qemu-aarch64环境epkg remove -y xxx显示移除包成功，但是epkg list xxx查询包还存在 | 存量功能测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1365](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1365) | 【测试组-sdk-功能性-主要-26.09】qemu-aarch64-xfce-systemd 执行环境问题，qemu启动成功，登录失败，缺少环境配置文 | mugen测试 | 26.09.B001 | 26.09.B008 | 原用例回归 | 回归通过 |
| [#1366](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1366) | 【测试组-hmi-功能性-严重-26.09】构建qemu-aarch64-hmi-mcs-ros-kernel6报错失败 | 存量功能测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1368](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1368) | 【测试组-sdk-功能性-严重-26.09】镜像未归档 | mugen测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1391](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1391) | 【测试组-sdk-功能性-严重-26.09】raspberrypi4-64-clang 上测试套编译失败 | mugen测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1395](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1395) | 【测试组-sdk-功能性-严重-26.09】x86-64-clang环境初始化报错 | mugen测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1396](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1396) | 【测试组-外设分区-功能性-主要-26.09】raspberrypi4-64-hmi-mcs-rt镜像外设分区测试结果不符合预期 | 存量功能测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1398](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1398) | 【测试组-sdk-功能性-次要-26.09】单板空间不足导致sftp传输embedded_third_party_packages_test测试套ltp和posix失败 | mugen测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1401](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1401) | 【测试组-MindSpore Lite-功能性-严重-26.09】qemu-aarch64构建MindSpore Lite、Demo Classification 和 OpenCV集成镜像失败 | 存量功能测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1402](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1402) | 【测试组-hmi-功能性-严重-26.09】raspberrypi4-64带 HMI 特性镜像构建失败 | 存量功能测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1403](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1403) | 【测试组-蓝牙配置-功能性-主要-26.09】树莓派蓝牙配置测试两个问题 | 存量功能测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1404](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1404) | 【测试组-基础OS-功能性-次要-26.09】raspberrypi4-64构建kernel6镜像，uname查看信息显示内核版本为5.10 | 存量功能测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1405](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1405) | 【测试组-mica-功能性-主要-26.09】树莓派 mcs 镜像mica create失败 | 存量功能测试 | 26.09.B003 | 26.09.B007 | 原用例回归 | 回归通过 |
| [#1406](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1406) | 【测试组-软实时-功能性-严重-26.09】kp920 5.10内核/6.6内核/软实时镜像安装失败 | 存量功能测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1408](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1408) | 【测试组-软实时-功能性-次要-26.09】raspberrypi4-64-kernel6-rt镜像系统信息与实际不符 | 存量功能测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1411](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1411) | 【测试组-工程归档-功能性-严重-26.09】版本安全测试时发现x86_64镜像缺少安装sdk工具链的脚本 | mugen测试 | 26.09.B001 | 26.09.B003 | 原用例回归 | 回归通过 |
| [#1420](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1420) | 【测试组-重启模块-功能性-严重-26.09】树莓派4B单板触发内核panic，结果单板未狗复位，出现卡死状态 | 反复重启测试 | 26.09.B002 | 26.09.B005 | 原用例回归 | 回归通过 |
| [#1421](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1421) | 【测试组-IBRobot-功能】【严重】香澄派IB-Robot执行初始化脚本./scripts/setup.sh失败 #1421 | ib-robot测试 | 26.09.B004 | 26.09.B008 | 原用例回归 | 回归通过 |
| [#1423](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1423) | 【测试组-mugen-资料-次要-26.09】mugen的使用方式出现了变更，对应的资料未适配 | mugen测试 | 26.09.B003 | 26.09.B008 | 原用例回归 | 回归通过 |
| [#1424](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1424) | 【测试组-sdk-功能性-严重-26.09】安装sdk路径，当路径较长时sdk安装失败 | mugen测试 | 26.09.B003 | 26.09.B008 | 检视资料回归 | 回归通过 |
| [#1425](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1425) | 【测试组-IBRobot-功能性-主要-26.09】分布式（RTP 视频流形态）推理请求 dispatch 一律失败 | ib-robot测试 | 26.09.B004 | 26.09.B007 | 原用例回归 | 回归通过 |
| [#1426](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1426) | 【测试组-IBRobot-功能性-主要-26.09】零 RTP 视频流的 robot 配置下，pipeline_policy_node 启动即崩 | ib-robot测试 | 26.09.B004 | 26.09.B007 | 原用例回归 | 回归通过 |
| [#1427](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1427) | 【测试组-IBRobot-功能性-次要-26.09】HF openEuler/sam2.1_hiera_tiny 的 assets/adapter.json 内容为 torch-loader 元数据，缺少 interface 与 model_type 键 | ib-robot测试 | 26.09.B004 | 26.09.B007 | 原用例回归 | 回归通过 |
| [#1428](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1428) | 【测试组-IBRobot-功能性-不重要-26.09】test_loss_compare.py和test_video_stream_protocol.py单测用例问题 | ib-robot测试 | 26.09.B004 | 26.09.B007 | 适配用例回归 | 回归通过 |
| [#1429](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1429) | 【测试组-IBRobot-功能性-次要-26.09】kill cloud 后失效窗口内新 dispatch 的错误码为 observation_not_ready，不符合预期not_ready | ib-robot测试 | 26.09.B004 | 26.09.B007 | 原用例回归 | 回归通过 |
| [#1432](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1432) | 【测试组-版本号-工程-次要-26.09】cat /etc/os-release版本信息与实际不一致 | ib-robot测试 | 26.09.B004 | 26.09.B008 | 原用例回归 | 回归通过 |
| [#1433](https://gitcode.com/openeuler/yocto-meta-openeuler/issues/1433) | 【测试组-资料专项-资料检视-次要-26.09】审视26.09版本资料，提出检视意见待澄清 | 资料专项测试 | 26.09.B002 | 26.09.B008 | 原用例回归 | 回归通过 |

# 6   附件

## 遗留问题列表

本版本无遗留问题,均已在版本测试回归中修复并验证通过。

# 致谢

非常感谢以下开发者在openEuler 26.09 版本测试中做出的贡献，以下排名不分先后：
- [彭云龙](xxxx)
- [林志鹏](xxxx)
- [王平](xxxx)
- [吴小强](xxxx)
- [郝意达](xxxx)
- [贾旭](xxxx)
- [刘伟鸿](xxxx)
- [朱菲](xxxx)

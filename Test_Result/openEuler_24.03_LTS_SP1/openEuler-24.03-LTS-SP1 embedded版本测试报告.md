![avatar](../../images/openEuler.png)


版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ------------------ | ---------- |
| 2024/12/23 | 初稿 | 填写模板 | @s-c-c |

关键词：

openEuler embedded raspberrypi 分布式软总线 混合部署

摘要：

文本主要描述openEuler 24.03 lts sp1 embedded版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。


# 1   概述

openEuler Embedded是基于openEuler社区面向嵌入式场景的Linux版本，旨在成为一个高质量的以Linux为中心的嵌入式系统软件平台。

本文主要描述openEuler 24.03 lts sp1 embedded版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 24.03 lts sp1 embedded版本是24.03 lts版本的扩展版本，同时支持构建5.10内核和6.6内核镜像。面向嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 24.03 LTS分支，发布范围相较24.03 LTS 版本主要变动主：

1.  软件版本选型升级，详情请见[版本变更说明]()
2.  KP920镜像支持完善

openEuler 24.03 lts sp1 embedded版本按照社区release-manager团队的计划和嵌入式版本开发进展，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称                 | 测试起始时间 | 测试结束时间 |  持续时间 | 备注                          |
| :------------ | :--------- | :--------- | ---- | ----------------------------- |
| Test round 1           | 2024/12/02 | 2024/12/06 | 5    | 继承特性、性能摸底测试|
| Test round 2           | 2024/12/09 | 2024/12/13 | 5    | 全量SIT验证|
| Test round 3           | 2024/12/16 | 2024/12/20 | 5    | 全量SIT验证   |
| Test round 4           | 2024/12/23 | 2024/12/26 | 3    | 回归测试   |
| Test round 5           | 2024/12/27 | 2024/12/30 | 3    | 回归测试   |
| Release                | 2024/12/31 | 2024/12/31 | 1    | 社区Release版本发布评审|

测试的硬件环境如下：

| 硬件型号 | 硬件配置信息 | 备注 |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------- |
| 树莓派4B卡 | CPU:BCM2711(Cortex-A72 * 4) <br />内存：4GB/8GB <br />存储设备：SanDisk Ultra 64GB micro SD |        |
| qemu | CPU:Cortex-A15/A57 <br /> 最小启动内存：512M |        |
| STM32F407开发板 | CPU:STM32F407| 仅用于硬实时性能的测试 |
| 工控机HVAEIPC-M10 | CPU:Intel i7-10510U| 用于测试x86镜像编译结果以及rt补丁对x86的支持 |
| RK3588开发板 | CPU:RK3588| 仅用于RK3588镜像的测试 |
| 海鸥派 |  CPU: Cortex A55@1.4GHz<br> 内存：8G<br>存储设备：SanDisk Ultra 64GB micro SD |  |


openEuler 24.03 lts sp1 embedded版本交付[需求列表](https://gitee.com/openeuler/yocto-meta-openeuler/issues/IB6U3N?from=project-issue)，其中嵌入式需求如下：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| [IB6U3N](https://gitee.com/openeuler/yocto-meta-openeuler/issues/IB6U3N?from=project-issue) | KP920镜像支持完善 | Testing | sig-embedded | @weiyuchen2013 | 源码 | | 

继承需求如下：
| **需求**         | **开发主体** | **测试主体** | **测试分层策略**         |
| --------------- | ----------- | ---------- | ----------------------- |
| 基于Linux 5.10内核提供软实时能力| sig-embedded | sig-embedded | 继承已有测试能力，通过cyclictest进行测试软实时能力 |
| 实现soc内实时和非实时多平面混合部署| sig-embedded | sig-embedded | 继承已有测试能力，在qemu上启动混合部署  |
| 开放基于Yocto构建包的小型化定制裁剪能力 | sig-embedded | sig-embedded | 继承已有测试能力，使用yocto构建出不同系统 |
| 基于社区10.3版本gcc提供ARM版本交叉编译工具链 | sig-embedded | sig-embedded | 继承已有测试能力，使用交叉编译工具链进行测试用例编译 |
| 支持树莓派4B作为嵌入式通用硬件| sig-embedded | sig-embedded | 继承已有测试能力，使用树莓派进行测试 |
| 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通| sig-embedded | sig-embedded | 继承已有测试能力，测试分布式软总线接口，以及openEuler设备间互联互通 |
| 实时非实时系统混合部署支持树莓派| sig-embedded | sig-embedded | 继承已有测试能力，在树莓派上启动混合部署，调用串口/SHELL服务来进行混合部署间的调用和通信，混合部署生命周期管理 |
| 分布式软总线生态互通互联 | sig-embedded | sig-embedded | 继承已有测试能力，测试分布式软总线接口，以及与openharmony设备间互联互通 |
| 硬实时uniProton支持南向开发板 | sig-embedded | sig-embedded | 继承已有测试能力，可编译对应支持的uniproton镜像 |
| 硬实时uniProton支持混合部署 | sig-embedded | sig-embedded | 继承已有测试能力，可编译对应支持的uniproton镜像，并在树莓派启动对应混合部署 |
| 硬实时uniProton支持POSIX接口| sig-embedded | sig-embedded | 继承已有测试能力，测试通过适配开源posix测试套测试支持的posix接口 |
| 【特性回合】在RK3568J基于OpenAMP支持openEuler EM+RT-Thread| sig-embedded | sig-embedded | 继承已有测试能力，测试编译镜像能力 |
| 【特性回合】支持外设分区管理| sig-embedded | sig-embedded |  继承已有测试能力，测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在| 
|【特性回合】【软实时OS】支持Jailhouse虚拟化底座| sig-embedded | sig-embedded |  继承已有测试能力，支持Jailhouse运行，可以通过Jailhouse进行虚拟化操作|
| 【特性回合】【软实时OS】支持1款X86工控芯片| sig-embedded | sig-embedded |  继承已有测试能力，编译x86镜像，安装到对应硬件，在硬件上进行基础测试|
| 【特性回合】【软实时OS】支持瑞芯微RK3568J| sig-embedded | sig-embedded |  继承已有测试能力，编译RK3568J镜像|
| 【特性回合】【软实时OS】基于RH2288云化PLC硬件，优化RT补丁| sig-embedded | sig-embedded |  继承已有测试能力，测试X86镜像的软实时性能 |
|【特性回合】【软实时OS】协议优化，提升流式数据和文件传输效率| sig-embedded | sig-embedded |  继承已有测试能力，测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效|
| 【特性回合】【软实时OS】支持树莓派蓝牙| sig-embedded | sig-embedded |  继承已有测试能力，启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现|
| 【特性回合】【软实时OS】支持软总线支持ble发现| sig-embedded | sig-embedded |  继承已有测试能力，通过编程调用蓝牙发现接口，可发现自动发现对端设备|
| 【特性回合】【软实时OS】引入Meta-ROS| sig-embedded | sig-embedded | 继承已有测试能力，测试Meta-ROS编译，能够正常启动|
| 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL（包括文件系统与网络框架）| sig-embedded | sig-embedded |  继承已有测试能力，通过posix suite相关接口测试 |
| 【软实时OS】社区ZVM底座对接嵌入式| sig-embedded | sig-embedded |  继承已有测试能力，通过ZVM可拉起openEuler嵌入式 |
| 【特性回合】【软实时OS】支持isula镜像 | sig-embedded | sig-embedded |  继承已有测试能力，测试isula镜像启动，拉起后容器可正常使用 |
| 【特性回合】【软实时OS】支持RK3588 | sig-embedded | sig-embedded |  继承已有测试能力，构建出RK3588镜像、测试基础用例|
| 【特性回合】【软实时OS】支持全志A40i | sig-embedded | sig-embedded |  继承已有测试能力，构建出全志A40i镜像、测试基础用例|


本次版本测试活动分工如下：

| **需求**                        | **开发主体**          | **测试主体**      | **测试分层策略**                                             |   测试镜像  |
| ------------------------------- | --------------------- | ----------------- | ------------------------------------------------------------ | -------------|
| [IB6U3N](https://gitee.com/openeuler/yocto-meta-openeuler/issues/IB6U3N)  【软实时OS】kp920 Lite镜像支持 | sig-embedded | sig-embedded |  测试KP920镜像正常启动  |  kp920-mcs  | 


继承需求测试策略如下:
| Feature/组件 |  策略                           |  测试镜像  |
| ----------- | ------------------------------- | ------ |
| 基于Linux 5.10内核提供软实时能力 | 继承已有测试能力，通过cyclictest进行测试软实时能力 | 所有5.10内核镜像 |
| 实现soc内实时和非实时多平面混合部署 | 继承已有测试能力，在qemu上启动混合部署  | qemu-aarch64 |
| 开放基于Yocto构建包的小型化定制裁剪能力  | 继承已有测试能力，使用yocto构建出不同系统 | CI构建  |
| 基于社区10.3版本gcc提供ARM版本交叉编译工具链  | 继承已有测试能力，使用交叉编译工具链进行测试用例编译 | CI构建sdk，所有镜像  |
| 支持树莓派4B作为嵌入式通用硬件 | 继承已有测试能力，使用树莓派进行测试 | CI |
| 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 | 继承已有测试能力，测试分布式软总线接口，以及openEuler设备间互联互通 |  qemu-aarch64 raspberrypi4-64 llvm qemu 树莓派镜像 |
| 实时非实时系统混合部署支持树莓派 | 继承已有测试能力，在树莓派上启动混合部署，调用串口/SHELL服务来进行混合部署间的调用和通信，混合部署生命周期管理 | raspberrypi4-64-rt-hmi |
| 硬实时uniProton支持南向开发板  | 继承已有测试能力，可编译对应支持的uniproton镜像 | raspberrypi4-64-rt-hmi  |
| 硬实时uniProton支持混合部署  | 继承已有测试能力，可编译对应支持的uniproton镜像，并在树莓派启动对应混合部署 | raspberrypi4-64-rt-hmi  |
| 硬实时uniProton支持POSIX接口 | 继承已有测试能力，测试通过适配开源posix测试套测试支持的posix接口 | 硬实时 |
| 【特性回合】在RK3568J基于OpenAMP支持openEuler EM+RT-Thread| 继承已有测试能力，测试编译镜像能力 | CI |
| 【特性回合】支持外设分区管理|  继承已有测试能力，测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在 |   raspberrypi4-64-rt-hmi  |
|【特性回合】【软实时OS】支持Jailhouse虚拟化底座|  继承已有测试能力，支持Jailhouse运行，可以通过Jailhouse进行虚拟化操作 |  raspberrypi4-64-rt-hmi  |
| 【特性回合】【软实时OS】支持1款X86工控芯片|  继承已有测试能力，编译x86镜像，安装到对应硬件，在硬件上进行基础测试 | CI x86镜像 | 
| 【特性回合】【软实时OS】支持瑞芯微RK3568J|  继承已有测试能力，编译RK3568J镜像 |  CI |
| 【特性回合】【软实时OS】基于RH2288云化PLC硬件，优化RT补丁|  继承已有测试能力，测试X86镜像的软实时性能 | x86镜像 | 
|【特性回合】【软实时OS】协议优化，提升流式数据和文件传输效率|  继承已有测试能力，测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效 | raspberrypi4-64 | 
| 【特性回合】【软实时OS】支持树莓派蓝牙|  继承已有测试能力，启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现 | raspberrypi4-64 | 
| 【特性回合】【软实时OS】支持软总线支持ble发现|  继承已有测试能力，通过编程调用蓝牙发现接口，可发现自动发现对端设备 | raspberrypi4-64 | 
| 【特性回合】【软实时OS】引入Meta-ROS|  继承已有测试能力，测试Meta-ROS编译，能够正常启动 |  qemu-aarch64 | 
| 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL（包括文件系统与网络框架）|  继承已有测试能力，通过posix suite相关接口测试 | 硬实时 |
| 【软实时OS】社区ZVM底座对接嵌入式 |  继承已有测试能力，通过ZVM可拉起openEuler嵌入式 | - |
| 【特性回合】【软实时OS】支持isula镜像  |  继承已有测试能力，测试isula镜像启动，拉起后容器可正常使用 | raspberrypi4-64-rt-hmi |
| 【特性回合】【软实时OS】支持RK3588  |  继承已有测试能力，构建出RK3588镜像、测试基础用例 | CI |
| 【特性回合】【软实时OS】支持全志A40i  |  继承已有测试能力，构建出全志A40i镜像、测试基础用例 | CI |

# 3 版本概要测试结论

openEuler 24.03 lts sp1 embedded版本整体测试按照release-manager团队的计划，共完成了五轮测试，包含一轮基础及基础软件外围包测试、一轮安全配置及基础OS指令测试、一轮全量测试(基础功能及指令、新增特性、外围包、安全专项、性能专项)以及两轮回归测试；

其中一轮基础功能测试聚焦在linux系统调用、glibc和基础软件外围包功能的自动化验证，旨在识别阻塞性问题；一轮安全配置及基础OS指令测试开展系统安全配置及OS基础指令的测试；另外一轮全量测试，涵盖基础功能及指令、外围包、新增特性、安全专项、性能专项等全面的测试以及用户使用场景测试模拟社区用户，按照使用指南中指导完成了镜像获取启动、基于SDK的应用开发以及容器构建环境的获取和一键构建；最后两轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；

版本按照测试策略完成了全量功能验证和专项测试(性能、可靠性、兼容性、安全)，所有测试预计发布前按计划完成。本版本计划交付需求1个，实际交付1个，交付率100%，所有发布需求均验证通过。

openEuler 24.03 lts sp1 embedded版本目前共发现问题14个，修复问题11个，遗留问题单3个，版本整体质量较好，风险可控。

# 4 版本详细测试结论

openEuler 24.03 lts sp1 embedded版本详细测试内容包括：

1. 完成基础OS质量保障，包括内核、系统调用、glibc以及基础软件包的功能测试，测试功能正常，问题发布前闭环；
2. 对关键继承特性，如软实时、yocto小型定制裁剪以及ARM版本交叉编译工具链进行了专项特性测试，软实时特性功能正常，性能与2403版本持平，yocto小型定制裁剪以及ARM版本交叉编译工具链功能正常与2403版本使用使用有优化，问题发布前闭环；
3. 完成各项专项测试 (性能、可靠性、兼容性、安全)，测试正常，问题发布前闭环；
4. 对新增特性，针对原有继承部分和新增部分进行了测试，继承功能正常，新增功能正常，问题发布前闭环；
5. 针对海鸥派也进行了测试，测试功能正常，问题发布前闭环；


## 4.1   特性测试结论

### 4.1.1   继承特性评价

<!-- 对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估 -->

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
| 1 |  基于Linux 5.10内核提供软实时能力 | <font color=green>█</font> | |
| 2 |  实现soc内实时和非实时多平面混合部署 | <font color=green>█</font> | |
| 3 |  开放基于Yocto构建包的小型化定制裁剪能力  | <font color=green>█</font> | |
| 4 |  基于社区10.3版本gcc提供ARM版本交叉编译工具链  | <font color=green>█</font> | |
| 5 |  支持树莓派4B作为嵌入式通用硬件 | <font color=green>█</font> | |
| 6 |  集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 | <font color=green>█</font> | |
| 7 |  实时非实时系统混合部署支持树莓派 | <font color=green>█</font> | |
| 8 |  分布式软总线生态互通互联  | <font color=green>█</font> | |
| 9 |  硬实时uniProton支持南向开发板  | <font color=green>█</font> | |
| 10 |  硬实时uniProton支持混合部署  | <font color=green>█</font> | |
| 11 |  硬实时uniProton支持POSIX接口 | <font color=green>█</font> | |
| 12 |  【特性回合】在RK3568J基于OpenAMP支持openEuler EM+RT-Thread| <font color=green>█</font> | |
| 13 |  【特性回合】支持外设分区管理| <font color=green>█</font> | |
| 14 | 【特性回合】【软实时OS】支持Jailhouse虚拟化底座| <font color=green>█</font> | |
| 15 |  【特性回合】【软实时OS】支持1款X86工控芯片| <font color=green>█</font> | |
| 16 |  【特性回合】【软实时OS】支持瑞芯微RK3568J| <font color=green>█</font> | |
| 17 |  【特性回合】【软实时OS】基于RH2288云化PLC硬件，优化RT补丁| <font color=green>█</font> | |
| 18 | 【特性回合】【软实时OS】协议优化，提升流式数据和文件传输效率| <font color=green>█</font> | |
| 19 |  【特性回合】【软实时OS】支持树莓派蓝牙| <font color=green>█</font> | |
| 20 |  【特性回合】【软实时OS】支持软总线支持ble发现| <font color=green>█</font> | |
| 21 |  【特性回合】【软实时OS】引入Meta-ROS| <font color=green>█</font> | |
| 22 |  【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL（包括文件系统与网络框架）| <font color=green>█</font> | |
| 23 |  【软实时OS】社区ZVM底座对接嵌入式 | <font color=green>█</font> | |
| 24 |  【特性回合】【软实时OS】支持isula镜像  | <font color=green>█</font> | |
| 25 |  【特性回合】【软实时OS】支持RK3588  | <font color=green>█</font> | |
| 26 |  【特性回合】【软实时OS】支持全志A40i  | <font color=green>█</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称** | **测试覆盖情况** | **约束依赖说明** | **遗留问题单** | **质量评估** | **备注<img width=50/>** |
| -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1 | [IB6U3N](https://gitee.com/openeuler/yocto-meta-openeuler/issues/IB6U3N)  【软实时OS】kp920 Lite镜像支持 |  测试KP920镜像正常启动  | 使用KP920镜像 |  |<font color=green>█</font> | |


<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler embedded 均采用断电烧写进行升级，目前不涉及升级兼容性。

### 4.2.2   南向兼容性

openEuler 24.03 lts sp1 embedded 已测试兼容列表

下表列出版本集成验证中涉及的硬件整机信息：

| 硬件型号 | 硬件详细信息 | 备注 |
| --------------------- |----------------------------------------------------------------- | ------------------- |
| 树莓派4B卡 | CPU:Cortex-A72 * 4 <br />内存：4GB/8GB <br />存储设备：SanDisk Ultra 64GB micro SD |
| STM32F407开发板 | CPU:STM32F407 | 用于硬实时UniProton |
| 工控机HVAEIPC-M10 | CPU:Intel i7-10510U| 用于测试x86镜像编译结果以及rt补丁对x86的支持 |

### 4.2.3   北向兼容性

创新版本北向兼容性暂不考虑进行测试

## 4.3   专项测试结论

### 安全测试

整体安全测试覆盖：

1、Linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试，发现2个相关问题，所有问题均澄清或修改。

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/编译选项扫描/交付件病毒扫描，其中发现新增CVE漏洞2个，已提交社区issue，开放22端口用于ssh，编译选项扫描正常，问题均修复或为误报已确认，敏感信息扫描已确认无敏感信息，交付件无病毒。

3、针对安全加固指南中的加固项，进行全量测试，其中发现问题1个，问题均澄清和修复。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------------------------------------------------------------------------------ | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； |  稳定运行7天  |
| 操作系统重启 | 自动重启100次，手动断电重启10次 |  未发现异常  |

### 性能测试

| **指标大项** | **指标小项** | **指标值** | **测试结论** |
| ------------- | ------------------------------------------------------------ | --------------------------------- | -------------------- |
| OS基础性能 | UnixBench除C编译外测试内容 | - | gcc版本5.10内核镜像性能与基线持平(2403 lts)、6.6内核镜像与基线持平; llvm版本与基线持平 |
| 软实时补丁性能 | cyclictest空载及压力负载 | - | 5.10内核、6.6内核镜像均与基线持平 |
| 硬实时系统性能 | 适配后的RhealStone用例测试 | - | 与基线持平，上下文切换时延2us，中断时延1us |

# 5   问题单统计

openEuler 24.03 lts sp1 embedded 版本共发现问题单14个，取消问题单2个，其中修复问题单9个，遗留问题单3个，其余回归均通过。详细分布见下表:

| 测试阶段                    | 问题单数 |
| --------------------------- | -------- |
| openEuler embedded RC1 | 6  |
| openEuler embedded RC2 | 4  |
| openEuler embedded RC3 | 4  |
| openEuler embedded RC4 | 0  |
| openEuler embedded RC5 | 0  |

1、RC1 RC2为操作系统基础测试、外围包、基础命令及安全加固测试，主要聚焦于操作系统的基础功能及基本安全问题，由于嵌入式支持镜像较多，发现问题主要集中在mica、镜像构建、编译等

2、RC3进行了全量测试，主要聚焦于新需求的测试和安全扫描类问题；

3、RC4、5进行回归测试。

4、目前版本测试发现问题整体呈收敛，预计回归测试问题可控，版本在发布前可具备发布条件。


# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| ---- | ------- | -------- | -------- | ------- | -------- | --------- | 
| 1 | [IBANAZ]https://gitee.com/openeuler/yocto-meta-openeuler/issues/IBANAZ?from=project-issue | x86-64-hmi-mcs-ros-rt镜像mica启动失败 | 低 | 影响x86镜像上mica特性的使用，不影响其他特性，且x86的mica使用的范围小，影响范围可控 | 后续社区投入修复 | 无 | 
| 2 | [IBACHW]https://gitee.com/openeuler/yocto-meta-openeuler/issues/IBACHW?from=project-issue | qemu-aarch64-mcs-ros镜像名称错误，并且micad启动失败 | 低 | 影响qemu镜像上mica特性的使用，不影响其他特性，且qemu镜像只是参考镜像，使用的范围小，影响可控 | 后续社区投入修复 | 无 | 
| 3 | [IBA13Y]https://gitee.com/openeuler/yocto-meta-openeuler/issues/IBA13Y?from=project-issue | raspberrypi4-64镜像测试用例oe_test_nfs-utils_test_001失败 | 低 | 该用例失败的原因是缺少/dev/log目录，补全该目录后用例运行成功。影响范围小。 | 后续社区投入修复 | 无 | 

# 致谢
非常感谢以下开发者在openEuler 24.03 lts sp1 版本测试中做出的贡献,以下排名不分先后
- [seven](xxxx)
- [WindDD_2022](xxxx)
- [hhm666](xxxx)
- [pangkailin](xxxx)
- [薛定谔猫的黎曼猜想](xxxx)
- [lmq9671](xxxx)
- [s_c_c](xxxx)
- [saarloos](xxxx)
- [yikunx95](xxxx)
- [eastb233](xxxx)
- [shenzhen-xuwei](xxxx)
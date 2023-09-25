![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ------------------ | ---------- |
| 2023/09/19 | 初稿 | 填写模板 | @saarloos |

关键词：

openEuler embedded raspberrypi 分布式软总线 混合部署

摘要：

文本主要描述openEuler embedded 23.09 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。


# 1   概述

openEuler Embedded是基于openEuler社区面向嵌入式场景的Linux版本，旨在成为一个高质量的以Linux为中心的嵌入式系统软件平台。

本文主要描述openEuler 23.09 embedded版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler embedded 23.09版本是23年第二个创新版本，相较23.03版本进行了多项创新需求的探索，使用5.10内核，并跟随社区对基础软件包版本进行升级，同时升级了yocto版本至上游lts版本(4.0), 混和部署功能进一步增强，增加对RTOS的维测能力，增加对jailhouse的支持；完善ROS开发工具；jailhouse支持图形化配置管理；硬实时增加更多的posix接口支持，新增设备管理，stm32f407单板串口、shell框架；嵌入式linux支持更多的南向设备。主要变更功能列表如下：

1.  软件版本选型升级，详情请见[版本变更说明]()
2.  修复bug和cve
3.  【混合部署】混合部署openAMP模式维测能力增强，支持Linux调试RTOS(UniProton)内核
4.  【混合部署】混合部署支持jailhouse和openAMP
5.  【软实时OS】嵌入式Linux支持isula镜像
6.  【软实时OS】嵌入式Linux ROS功能调优, 完善开发工具
7.  【软实时OS】嵌入式Linux 构建yocto升级到4.0 LTS版本
8.  【硬实时OS】UniProton POSIX接口移植，新增exit/ipc/malloc/math/stdlib模块移植，增加设备管理，增加STM32F407串口支持，增加串口shell交互
9.  【软实时OS】分布式软总线升级到3.2
10. 【混合部署】Jailhouse支持不同cell和inmate的图形化管理
11. 【软实时OS】OEE 南向支持 RK3588
12. 【软实时OS】OEE 南向支持 RK3399
13. 【软实时OS】OEE 支持RK3568图形能力增强
14. 【混合部署】Jailhouse 支持 RK3568 和 RK3399

openEuler 23.09 版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称                 | 测试起始时间 | 测试结束时间 |  持续时间 | 备注                          |
| :------------ | :--------- | :--------- | ---- | ----------------------------- |
| Test round 1(计划) | 2023/9/6      | 2023/9/9  | 4   |    |
| Test round 1(实际) | 2023/9/6      | 2023/9/9 | 4   |    |
| Test round 2(计划) | 2023/9/11       | 2023/9/14 | 4   |   |
| Test round 2(实际) | 2023/9/11       | 2023/9/15 | 5   |   |
| Test round 3(计划) | 2023/9/15      | 2023/9/19 | 4   |    |
| Test round 3(实际) | 2023/9/16      | 2023/9/19 | 3   |   |
| Test round 4(计划) | 2023/9/20      | 2023/9/22 | 2   |    |
| Test round 4(实际) | 2023/9/20      |      2023/9/23     |  3  |    |
| Test round 5(计划) | 2023/9/25      | 2023/9/26 | 2   |    |
| Test round 5(实际) | 2023/9/25   | 2023/9/26 | 2   |    |
| Release | 2023/9/28      | 2023/9/28 | 1   |    |

测试的硬件环境如下：

| 硬件型号 | 硬件配置信息 | 备注 |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------- |
| 树莓派4B卡 | CPU:BCM2711(Cortex-A72 * 4) <br />内存：4GB/8GB <br />存储设备：SanDisk Ultra 64GB micro SD |        |
| qemu | CPU:Cortex-A15/A57 <br /> 最小启动内存：512M |        |
| 江苏润和-Hi3561DV300-HiSpark Ai Camera开发套件 | CPU:Hi3561| 仅用于分布式软总线与openEuler组网、通信测试 |
| STM32F407开发板 | CPU:STM32F407| 仅用于硬实时性能的测试 |
| 工控机HVAEIPC-M10 | CPU:Intel i7-10510U| 用于测试x86镜像编译结果以及rt补丁对x86的支持 |
| RK3588开发板 | CPU:RK3588| 仅用于RK3588镜像的测试 |
| RK3399开发板 | CPU:RK3399| 仅用于RK3399镜像的测试 |


openEuler 23.09版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-23.09/release-plan.md)，其中嵌入式需求如下：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| 1 | [I7TYG1](https://gitee.com/openeuler/release-management/issues/I7TYG1)【混合部署】混合部署openAMP模式维测能力增强，支持Linux调试RTOS(UniProton)内核 | Testing | sig-yocto | [@fanglinxu](https://gitee.com/fanglinxu) |源码 + 镜像包含 | |
| 2 | [I7TYJT](https://gitee.com/openeuler/release-management/issues/I7TYJT)【混合部署】混合部署支持jailhouse和openAMP | Testing | sig-yocto | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含| |
| 3 | [I7TYKT](https://gitee.com/openeuler/release-management/issues/I7TYKT)【软实时OS】嵌入式Linux支持isula镜像	 | Testing | sig-yocto | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含| |  
| 4 | [I7TYL0](https://gitee.com/openeuler/release-management/issues/I7TYL0)【软实时OS】嵌入式Linux ROS功能调优, 完善开发工具 | Testing | sig-yocto | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含||  
| 5 | [I7TYLW](https://gitee.com/openeuler/release-management/issues/I7TYLW)【软实时OS】嵌入式Linux 构建yocto升级到4.0 LTS版本 | Testing | sig-embedded | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含| |  
| 6 | [I7TYM4](https://gitee.com/openeuler/release-management/issues/I7TYM4)【硬实时OS】UniProton POSIX接口移植，新增exit/ipc/malloc/math/stdlib模块移植，增加设备管理，增加STM32F407串口支持，增加串口shell交互 | Testing | sig-embedded | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含| |  
| 7 | [I7TYM9](https://gitee.com/openeuler/release-management/issues/I7TYM9)【软实时OS】分布式软总线升级到3.2 | Testing | sig-embedded | [@yukaii](https://gitee.com/yukaii)|源码| |  
| 8 | [I7TYME](https://gitee.com/openeuler/release-management/issues/I7TYME)【混合部署】Jailhouse支持不同cell和inmate的图形化管理 | Testing | sig-embedded |  |源码|  |  
| 9 | [I7TYMX](https://gitee.com/openeuler/release-management/issues/I7TYMX)【软实时OS】OEE 南向支持 RK3588 | Testing | sig-embedded |  [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) |源码 + 镜像包含| |    
| 10 | [I7TYNE](https://gitee.com/openeuler/release-management/issues/I7TYNE)【软实时OS】OEE 南向支持 RK3399 | Testing | sig-embedded |  [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) |源码 + 镜像包含| |  
| 11 | [I7TYNI](https://gitee.com/openeuler/release-management/issues/I7TYNI)【软实时OS】OEE 支持RK3568图形能力增强 | Testing | sig-embedded |  [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) |源码 + 镜像包含| |  
| 12 | [I7TYNK](https://gitee.com/openeuler/release-management/issues/I7TYNK)【混合部署】Jailhouse 支持 RK3568 和 RK3399 | Testing | sig-embedded |  [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) |源码 + 镜像包含| | 

继承需求如下：
| **需求**         | **开发主体** | **测试主体** | **测试分层策略**         |
| --------------- | ----------- | ---------- | ----------------------- |
| 基于Linux 5.10内核提供软实时能力 | sig-yocto | sig-yocto |继承已有测试能力，通过cyclictest进行测试软实时能力 |
| 实现soc内实时和非实时多平面混合部署 |sig-yocto | sig-yocto | 继承已有测试能力，在qemu上启动混合部署  |
| 开放基于Yocto构建包的小型化定制裁剪能力  |sig-yocto | sig-yocto | 继承已有测试能力，使用yocto构建出不同系统 |
| 基于社区10.3版本gcc提供ARM版本交叉编译工具链  | sig-yocto | sig-yocto |继承已有测试能力，使用交叉编译工具链进行测试用例编译 |
| 支持树莓派4B作为嵌入式通用硬件 | sig-yocto | sig-yocto |继承已有测试能力，使用树莓派进行测试 |
| 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 |sig-yocto | sig-yocto | 继承已有测试能力，测试分布式软总线接口，以及openEuler设备间互联互通 |
| 实时非实时系统混合部署支持树莓派 | sig-yocto | sig-yocto |继承已有测试能力，在树莓派上启动混合部署，调用串口/SHELL服务来进行混合部署间的调用和通信，混合部署生命周期管理 |
| 分布式软总线生态互通互联  | sig-yocto | sig-yocto |继承已有测试能力，测试分布式软总线接口，以及与openharmony设备间互联互通 |
| 硬实时uniProton支持南向开发板  | sig-yocto | sig-yocto |继承已有测试能力，可编译对应支持的uniproton镜像 |
| 硬实时uniProton支持混合部署  | sig-yocto | sig-yocto |继承已有测试能力，可编译对应支持的uniproton镜像，并在树莓派启动对应混合部署 |
| 硬实时uniProton支持POSIX接口 | sig-yocto | sig-yocto |继承已有测试能力，测试通过适配开源posix测试套测试支持的posix接口 |
| 混合部署支持外设分区管理 | sig-yocto | sig-yocto | 继承已有测试能力， 测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在 |  
| 支持一款X86芯片 | sig-yocto | sig-yocto |继承已有测试能力， 编译x86镜像，安装到对应硬件，在硬件上进行基础测试 |  
| PREEMPT-RT软实时优化 | sig-yocto | sig-yocto |继承已有测试能力， 在x86镜像上测试preempt-rt性能, 对比竞品性能有所提升 |  
| 引入Meta-ROS | sig-yocto | sig-yocto |继承已有测试能力， 测试Meta-ROS编译，能够正常启动 |  
| UniProton适配Hi3093 | sig-yocto | sig-yocto |继承已有测试能力， 可编译Hi3093 UniProton镜像 |  
| 软总线支持ble发现 | sig-yocto | sig-yocto |继承已有测试能力， 通过编程调用蓝牙发现接口，可发现自动发现对端设备 |  
| 树莓派支持蓝牙	 | sig-yocto | sig-yocto |继承已有测试能力， 启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现 |  
| 协议优化，提升流式数据和文件传输效率 | sig-yocto | sig-yocto |继承已有测试能力，测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效 | 
| 【特性回合】【软实时OS】支持Jailhouse虚拟化底座| sig-yocto | sig-yocto | 继承已有测试能力，支持Jailhouse运行，可以通过Jailhouse进行虚拟化操作 |  
| 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL C接口共计178个（所有pthread和time接口）| sig-yocto | sig-yocto | 继承已有测试能力， 通过posix suite相关接口测试 |  


本次版本测试活动分工如下：

| **需求**                        | **开发主体**          | **测试主体**      | **测试分层策略**                                             |
| ------------------------------- | --------------------- | ----------------- | ------------------------------------------------------------ |
| [I7TYG1](https://gitee.com/openeuler/release-management/issues/I7TYG1)【混合部署】混合部署openAMP模式维测能力增强，支持Linux调试RTOS(UniProton)内核 |  sig-yocto | sig-yocto | 验证openAMP模式下，与UniProton的调试能力 |
| [I7TYJT](https://gitee.com/openeuler/release-management/issues/I7TYJT)【混合部署】混合部署支持jailhouse和openAMP |  sig-yocto | sig-yocto| 验证混合部署支持jailhouse和openAMP模式，且使用同一套命令|
| [I7TYKT](https://gitee.com/openeuler/release-management/issues/I7TYKT)【软实时OS】嵌入式Linux支持isula镜像	 |  sig-yocto | sig-yocto| 验证isula支持，可启动openeuler镜像|  
| [I7TYL0](https://gitee.com/openeuler/release-management/issues/I7TYL0)【软实时OS】嵌入式Linux ROS功能调优, 完善开发工具 |  sig-yocto | sig-yocto| 验证ROS sdk功能，可通过SDK编译ROS基础包，并且可以运行|  
| [I7TYLW](https://gitee.com/openeuler/release-management/issues/I7TYLW)【软实时OS】嵌入式Linux 构建yocto升级到4.0 LTS版本 |  sig-yocto | sig-yocto| 验证构建系统可用性|  
| [I7TYM4](https://gitee.com/openeuler/release-management/issues/I7TYM4)【硬实时OS】UniProton POSIX接口移植，新增exit/ipc/malloc/math/stdlib模块移植，增加设备管理，增加STM32F407串口支持，增加串口shell交互 |  sig-yocto | sig-yocto|验证接口功能，串口输入输出，shell指令 |  
| [I7TYM9](https://gitee.com/openeuler/release-management/issues/I7TYM9)【软实时OS】分布式软总线升级到3.2 |  sig-distributed-middleware |sig-distributed-middleware | 验证升级后的分布式软总线接口|
| [I7TYME](https://gitee.com/openeuler/release-management/issues/I7TYME)【混合部署】Jailhouse支持不同cell和inmate的图形化管理 |  sig-embedded |  | 验证Jailhouse不同cell和inmate的图形化管理能力 |   
| [I7TYMX](https://gitee.com/openeuler/release-management/issues/I7TYMX)【软实时OS】OEE 南向支持 RK3588 |  sig-yocto |  sig-yocto [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) | 验证镜像制作，镜像烧录后运行，基础功能|    
| [I7TYNE](https://gitee.com/openeuler/release-management/issues/I7TYNE)【软实时OS】OEE 南向支持 RK3399 |  sig-yocto |  sig-yocto [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) |验证镜像制作，镜像烧录后运行，基础功能 |  
| [I7TYNI](https://gitee.com/openeuler/release-management/issues/I7TYNI)【软实时OS】OEE 支持RK3568图形能力增强 |  sig-yocto |  sig-yocto [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) | 验证镜像制作，镜像烧录后运行，基础功能|  
| [I7TYNK](https://gitee.com/openeuler/release-management/issues/I7TYNK)【混合部署】Jailhouse 支持 RK3568 和 RK3399 |  sig-yocto |  sig-yocto [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) | 验证镜像制作，镜像烧录后运行，基础功能，验证混合部署能力| 

继承需求测试策略如下:
| Feature/组件 |  策略                           |
| ----------- | ------------------------------- |
| 基于Linux 5.10内核提供软实时能力 | 继承已有测试能力，通过cyclictest进行测试软实时能力 |
| 实现soc内实时和非实时多平面混合部署 | 继承已有测试能力，在qemu上启动混合部署  |
| 开放基于Yocto构建包的小型化定制裁剪能力  | 继承已有测试能力，使用yocto构建出不同系统 |
| 基于社区10.3版本gcc提供ARM版本交叉编译工具链  | 继承已有测试能力，使用交叉编译工具链进行测试用例编译 |
| 支持树莓派4B作为嵌入式通用硬件 | 继承已有测试能力，使用树莓派进行测试 |
| 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 | 继承已有测试能力，测试分布式软总线接口，以及openEuler设备间互联互通 |
| 实时非实时系统混合部署支持树莓派 | 继承已有测试能力，在树莓派上启动混合部署，调用串口/SHELL服务来进行混合部署间的调用和通信，混合部署生命周期管理 |
| 分布式软总线生态互通互联  | 继承已有测试能力，测试分布式软总线接口，以及与openharmony设备间互联互通 |
| 硬实时uniProton支持南向开发板  | 继承已有测试能力，可编译对应支持的uniproton镜像 |
| 硬实时uniProton支持混合部署  | 继承已有测试能力，可编译对应支持的uniproton镜像，并在树莓派启动对应混合部署 |
| 硬实时uniProton支持POSIX接口 | 继承已有测试能力，测试通过适配开源posix测试套测试支持的posix接口 |
| 混合部署支持外设分区管理 | 继承已有测试能力， 测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在 |  
| 支持一款X86芯片 | 继承已有测试能力， 编译x86镜像，安装到对应硬件，在硬件上进行基础测试 |  
| PREEMPT-RT软实时优化 | 继承已有测试能力， 在x86镜像上测试preempt-rt性能, 对比竞品性能有所提升 |  
| 引入Meta-ROS | 继承已有测试能力， 测试Meta-ROS编译，能够正常启动 |  
| UniProton适配Hi3093 | 继承已有测试能力， 可编译Hi3093 UniProton镜像 |  
| 软总线支持ble发现 | 继承已有测试能力， 通过编程调用蓝牙发现接口，可发现自动发现对端设备 |  
| 树莓派支持蓝牙	 | 继承已有测试能力， 启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现 |  
| 协议优化，提升流式数据和文件传输效率 | 继承已有测试能力，测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效 | 
| 【特性回合】【软实时OS】支持Jailhouse虚拟化底座|  继承已有测试能力，支持Jailhouse运行，可以通过Jailhouse进行虚拟化操作 |  
| 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL C接口共计178个（所有pthread和time接口）|  继承已有测试能力， 通过posix suite相关接口测试 | 

# 3 版本概要测试结论

openEuler embedded 23.09版本整体测试按照release-manager团队的计划，共完成了五轮测试，包含一轮基础及基础软件外围包测试、一轮安全配置及基础OS指令测试、一轮全量测试(基础功能及指令、新增特性、外围包、安全专项、性能专项)以及两轮回归测试；

其中一轮基础功能测试聚焦在linux系统调用、glibc和基础软件外围包功能的自动化验证，旨在识别阻塞性问题；一轮安全配置及基础OS指令测试开展系统安全配置及OS基础指令的测试；另外一轮全量测试，涵盖基础功能及指令、外围包、新增特性、安全专项、性能专项等全面的测试以及用户使用场景测试模拟社区用户，按照使用指南中指导完成了镜像获取启动、基于SDK的应用开发以及容器构建环境的获取和一键构建；最后两轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；

版本按照测试策略完成了全量功能验证和专项测试(性能、可靠性、兼容性、安全)，所有测试预计发布前按计划完成。本版本计划交付需求12个，实际交付12个，交付率100%，所有发布需求均验证通过。

​openEuler embedded 23.09版本目前共发现问题33个，修复问题30个，取消问题单3个，版本整体质量较好，风险可控。

# 4 版本详细测试结论

23.09 版本详细测试内容包括：

1. 完成基础OS质量保障，包括内核、系统调用、glibc以及基础软件包的功能测试，测试功能正常，问题发布前闭环；
2. 对关键继承特性，如软实时、yocto小型定制裁剪以及ARM版本交叉编译工具链进行了专项特性测试，软实时特性功能正常，性能与2203版本持平，yocto小型定制裁剪以及ARM版本交叉编译工具链功能正常与2203版本使用使用有优化，问题发布前闭环；
3. 完成各项专项测试 (性能、可靠性、兼容性、安全)，测试正常，问题发布前闭环；
4. 对新增特性，针对原有继承部分和新增部分进行了测试，继承功能正常，新增功能正常，问题发布前闭环；


## 4.1   特性测试结论

### 4.1.1   继承特性评价

<!-- 对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估 -->

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
| 1 | 基于Linux 5.10内核提供软实时能力 | <font color=green>█</font> | |
| 2 | 实现soc内实时和非实时多平面混合部署 | <font color=green>█</font> | |
| 3 | 开放基于Yocto构建包的小型化定制裁剪能力  | <font color=green>█</font> | |
| 4 | 基于社区10.3版本gcc提供ARM版本交叉编译工具链 |<font color=green>█</font> | |
| 5 | 支持树莓派4B作为嵌入式通用硬件 | <font color=green>█</font> | |
| 6 | 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 | <font color=green>█</font> | |
| 7 | 实时非实时系统混合部署支持树莓派 | <font color=green>█</font> | |
| 8 | 分布式软总线生态互通互联  | <font color=green>█</font> | |
| 9 | 硬实时uniProton支持南向开发板  | <font color=green>█</font> | |
| 10 | 硬实时uniProton支持混合部署  | <font color=green>█</font> | |
| 11 | 硬实时uniProton支持POSIX接口 | <font color=green>█</font> | |
| 12 | 混合部署支持外设分区管理 |  <font color=green>█</font> | |
| 13 | 支持一款X86芯片 |   <font color=green>█</font> | |
| 14 | PREEMPT-RT软实时优化 |   <font color=green>█</font> | |
| 15 | 引入Meta-ROS |   <font color=green>█</font> | |
| 16 | UniProton适配Hi3093 |  <font color=green>█</font> | |
| 17 | 软总线支持ble发现 |  <font color=green>█</font> | |
| 18 | 树莓派支持蓝牙	 |  <font color=green>█</font>| |
| 19 | 协议优化，提升流式数据和文件传输效率 |  <font color=green>█</font> | |
| 20 | 【特性回合】【软实时OS】支持Jailhouse虚拟化底座|  <font color=green>█</font> |  |
| 21 | 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL C接口共计178个（所有pthread和time接口）|   <font color=green>█</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称** | **测试覆盖情况** | **约束依赖说明** | **遗留问题单** | **质量评估** | **备注<img width=50/>** |
| -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1 | [I7TYG1](https://gitee.com/openeuler/release-management/issues/I7TYG1)【混合部署】混合部署openAMP模式维测能力增强，支持Linux调试RTOS(UniProton)内核 | 在linux侧可以通过gdb调式RTOS内核 ，启动linux，启动gdb，启动rtos，测试gdb b c p q命令 | | |<font color=green>█</font> | |
| 2 | [I7TYJT](https://gitee.com/openeuler/release-management/issues/I7TYJT)【混合部署】混合部署支持jailhouse和openAMP |   通过一套命令进行混合部署生命周期管理，可通过jailhouse拉起rtos系统 ， 通过一套命令进行混合部署生命周期管理，可通过jailhouse拉起rtos系统 | | |<font color=green>█</font> | |
| 3 | [I7TYKT](https://gitee.com/openeuler/release-management/issues/I7TYKT)【软实时OS】嵌入式Linux支持isula镜像	 |  测试isula功能 ， 使用openEuler容器镜像进行测试，可通过isula拉起openEuler容器镜像，容器内功能正常，可使用yum等命令| | |<font color=green>█</font> | |  
| 4 | [I7TYL0](https://gitee.com/openeuler/release-management/issues/I7TYL0)【软实时OS】嵌入式Linux ROS功能调优, 完善开发工具 ，    ROS SDK编译能力 | 通过sdk编译 ros包(包含c++ ROS包和python ROS包)，传输至openEuler嵌入式系统，并且可运行 ||   |<font color=green>█</font> | |
| 5 | [I7TYLW](https://gitee.com/openeuler/release-management/issues/I7TYLW)【软实时OS】嵌入式Linux 构建yocto升级到4.0 LTS版本 ，    全量发布镜像构建 | 可构建出发布的所有发布件| |   |<font color=green>█</font> | |
| 6 | [I7TYM4](https://gitee.com/openeuler/release-management/issues/I7TYM4)【硬实时OS】UniProton POSIX接口移植，新增exit/ipc/malloc/math/stdlib模块移植，增加设备管理，增加STM32F407串口支持，增加串口shell交互 ，   posix接口，串口功能，shell功能 | posix接口功能进行测试，测试串口输入输出、shell功能交互| |   |<font color=green>█</font> |  |
| 7 | [I7TYM9](https://gitee.com/openeuler/release-management/issues/I7TYM9)【软实时OS】分布式软总线升级到3.2 |   验证升级后分布式软总线接口 ， 验证升级后分布式软总线接口| | |<font color=green>█</font> | |  
| 8 | [I7TYME](https://gitee.com/openeuler/release-management/issues/I7TYME)【混合部署】Jailhouse支持不同cell和inmate的图形化管理 ，  通过图形化工具快速创建cell | 通过图形化工具快速管理cell | |   |<font color=green>█</font> | |
| 9 | [I7TYMX](https://gitee.com/openeuler/release-management/issues/I7TYMX)【软实时OS】OEE 南向支持 RK3588 |    重点测试镜像构建、运行和基础功能  ，测试镜像构建、运行和基础功能| |     |<font color=green>█</font> | |
| 10 | [I7TYNE](https://gitee.com/openeuler/release-management/issues/I7TYNE)【软实时OS】OEE 南向支持 RK3399 |    重点测试镜像构建、运行和基础功能  ，测试镜像构建、运行和基础功能| |   |<font color=green>█</font> | |
| 11 | [I7TYNI](https://gitee.com/openeuler/release-management/issues/I7TYNI)【软实时OS】OEE 支持RK3568图形能力增强 |   重点测试镜像构建、运行和基础功能、验证图形能力 ，重点测试镜像构建、运行和基础功能、验证图形能力| |   |<font color=green>█</font> | |
| 12 | [I7TYNK](https://gitee.com/openeuler/release-management/issues/I7TYNK)【混合部署】Jailhouse 支持 RK3568 和 RK3399 |    重点测试镜像构建、运行和基础功能、验证混合部署能力  ，重点测试镜像构建、运行和基础功能、验证混合部署能力| |   |<font color=green>█</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler embedded 均采用断电烧写进行升级，目前不涉及升级兼容性。

### 4.2.2   南向兼容性

openEuler embedded 2309 已测试兼容列表

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

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/编译选项扫描/交付件病毒扫描，其中发现新增CVE漏洞5个，已提交社区issue，开放22端口用于ssh，编译选项扫描正常，问题均修复或为误报已确认，敏感信息扫描已确认无敏感信息，交付件无病毒。

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
| OS基础性能 | UnixBench除C编译外测试内容 | - | 测试形成基线 |
| 软实时补丁性能 | cyclictest空载及压力负载 | - | 测试形成基线 |
| 硬实时系统性能 | 适配后的RhealStone用例测试 | - | 测试形成基线，上下文切换时延2us，中断时延1us |

# 5   问题单统计

openEuler 23.09 embedded版本共发现问题单33个，取消问题单3个，其中修复问题单30个，遗留问题单0个，其余回归均通过。详细分布见下表:

| 测试阶段                    | 问题单数 |
| --------------------------- | -------- |
| openEuler embedded RC1 | 9  |
| openEuler embedded RC2 | 18 |
| openEuler embedded RC3 | 5  |
| openEuler embedded RC4 | 1  |
| openEuler embedded RC5 | 0  |

1、RC1 RC2为操作系统基础测试、外围包、基础命令及安全加固测试，主要聚焦于操作系统的基础功能及基本安全问题，由于2309升级了yocto版本，第一二轮测试问题主要是yocto升级或配置变更导致，并且安全编译选项、安全配置、敏感词、CVE等专项测试在第二轮进行测试发现了一些问题；

2、RC3进行了全量测试，主要聚焦于新需求的测试，测试发现少量问题，待第三四论回归；

3、RC4、5进行回归测试。

4、目前版本测试发现问题整体呈收敛，预计回归测试问题可控，版本在发布前可具备发布条件。


# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| ---- | ------- | -------- | -------- | ------- | -------- | --------- | 
|  |  |  |  |  |  |  | 


# 致谢
非常感谢以下开发者在openEuler 23.09 版本测试中做出的贡献,以下排名不分先后
- [seven](xxxx)
- [WindDD_2022](xxxx)
- [hhm666](xxxx)
- [pangkailin](xxxx)
- [薛定谔猫的黎曼猜想](xxxx)
- [lmq9671](xxxx)
- [s_c_c](xxxx)
- [saarloos](xxxx)
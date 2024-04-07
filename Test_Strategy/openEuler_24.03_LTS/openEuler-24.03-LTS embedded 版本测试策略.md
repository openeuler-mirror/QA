![openEuler ico](../../images/openEuler.png)

版权所有 © 2023 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

|  日期       |  修订版本 |  修改章节         | 修改描述                 | 作者      |
| ---------- | -------- | ---------------- | ---------------------- | --------- |
| 2024-03-19 | 1.0.0    |                  | 初稿                    | s_c_c |
| 2024-04-01 | 2.0.0    | 需求范围、测试分层策略、测试分析设计策略 | 更新需求范围   | s_c_c |

目 录

1 概述 

>   1.1 版本背景

>   1.2 需求范围

2 风险

3 测试分层策略

4 测试分析设计策略

>   4.1 新增feature测试设计策略

>   4.2 继承feature/组件测试设计策略

>   4.3 专项测试策略

5 测试执行策略

6 附件

**Keywords 关键词**：

openEuler LTS 测试策略

Abstract 摘要：

本文是openEuler 24.03 LTS embedded版本的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 概述

openEuler Embedded是基于openEuler社区面向嵌入式场景的Linux版本。当前openEuler内核源于Linux实现软实时能力，同时具备soc内多平面混合部署，开放基于Yocto构建包的小型化定制裁剪能力，支持openHarmony分布式软总线，同时嵌入式提供了非Linux内核的硬实时能力，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统。

本文主要描述openEuler 24.03 LTS embedded版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 24.03 LTS 是支持6.6内核和5.10双内核的全新LTS基线版本，面向嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 24.03 LTS-Next分支拉出，发布范围相较22.03 LTS SP3版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明]()
2.  边缘控制图形和轻量桌面能力支持
3.  MICA框架支持
4.  支持嵌入式极简镜像（iSulad）
5.  Linux双版本内核支持
6.  UniProton内核能力增强、南北向生态扩展及易用性增强

## 需求范围

openEuler 24.03 LTS版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS/release-plan.md)如下：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| [I99VNQ](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I99VNQ) | 【软实时OS】边缘控制图形和轻量桌面能力支持 | Developing | sig-embedded | [@fanglinxu](https://gitee.com/fanglinxu) | 源码 |  |
| [I9AQMF](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQMF) | 【软实时OS】MICA框架-混合部署可靠性增强 | Developing | sig-embedded | [@hanzongcheng](https://gitee.com/hzc04) | 源码 |  |
| [I9AQJX](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQJX) | 【软实时OS】MICA框架-支持多实例部署 | Developing | sig-embedded | [@hanzongcheng](https://gitee.com/hzc04) | 源码 |  |
| [I9AQBX](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQBX) | 【软实时OS】MICA框架-易用性完善 | Developing | sig-embedded | [@hanzongcheng](https://gitee.com/hzc04) | 源码 |  |
| [I9B7L4](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9B7L4) | 【软实时OS】支持嵌入式极简镜像（iSulad）| Developing | sig-embedded | [@Yongmao Luo](https://gitee.com/yongmao_luo) | 源码 |  |
| [I9AQ39](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQ39) | 【软实时OS】Linux双版本内核支持 | Developing | sig-embedded | [@fanglinxu](https://gitee.com/fanglinxu) | 源码 |  |
| [I9ALIE](https://gitee.com/openeuler/UniProton/issues/I9ALIE) | 【硬实时OS】【UniProton】混合部署下GDB-stub功能增强 | Developing | sig-embedded | [@zuyiwen](https://gitee.com/zuyiwen) | 源码 |  |
| [I9AD1M](https://gitee.com/openeuler/UniProton/issues/I9AD1M) | 【硬实时OS】【UniProton】PLC组态运行时环境forte支持 | Developing | sig-embedded | [@刘希](https://gitee.com/liuxi1234) | 源码 |  |
| [I9AD4C](https://gitee.com/openeuler/UniProton/issues/I9AD4C) | 【硬实时OS】【UniProton】Modbus工业通信协议支持 | Developing | sig-embedded | [@刘希](https://gitee.com/liuxi1234) | 源码 |  |
| [I9AAY4](https://gitee.com/openeuler/UniProton/issues/I9AAY4) | 【硬实时OS】【UniProton】EtherCAT工业控制协议支持 | Developing | sig-embedded | [@王天宇](https://gitee.com/TianyuTim) | 源码 |  |
| [I9AD7V](https://gitee.com/openeuler/UniProton/issues/I9AD7V) | 【硬实时OS】【UniProton】IP协议栈支持 | Developing | sig-embedded | [@刘希](https://gitee.com/liuxi1234) | 源码 |  |
| [I99Z3M](https://gitee.com/openeuler/UniProton/issues/I99Z3M) | 【硬实时OS】【UniProton】混合部署系统PCIe中断支持 | Developing | sig-embedded | [@wangyouwang-hw](https://gitee.com/wangyouwang-hw) | 源码 |  |
| [I99YMZ](https://gitee.com/openeuler/UniProton/issues/I99YMZ) | 【硬实时OS】【UniProton】混合部署系统PCIe驱动接口支持 | Developing | sig-embedded | [@wangyouwang-hw](https://gitee.com/wangyouwang-hw) | 源码 |  |
| [I9A8PC](https://gitee.com/openeuler/UniProton/issues/I9A8PC) | 【硬实时OS】【UniProton】混合部署系统PCIe架构DMA接口支持 | Developing | sig-embedded | [@wangyouwang-hw](https://gitee.com/wangyouwang-hw) | 源码 |  |
| [I99ZAE](https://gitee.com/openeuler/UniProton/issues/I99ZAE) | 【硬实时OS】【UniProton】实现PCIe驱动框架 | Developing | sig-embedded | [@wangyouwang-hw](https://gitee.com/wangyouwang-hw) | 源码 |  |
| [I9AGRD](https://gitee.com/openeuler/UniProton/issues/I9AGRD) | 【硬实时OS】【UniProton】支持基于混合部署场景的shell | Developing | sig-embedded | [@大鱼](https://gitee.com/hourenyu) | 源码 |  |
| [I9ADJV](https://gitee.com/openeuler/UniProton/issues/I9ADJV) | 【硬实时OS】【UniProton】支持arm64的SMP | Developing | sig-embedded | [@luoyimei](https://gitee.com/luoyimei) | 源码 |  |
| [I9ADDM](https://gitee.com/openeuler/UniProton/issues/I9ADDM) | 【硬实时OS】【UniProton】支持多实例部署 | Developing | sig-embedded | [@刘希](https://gitee.com/liuxi1234) | 源码 |  |
| [I9AGR4](https://gitee.com/openeuler/UniProton/issues/I9AGR4) | 【硬实时OS】【UniProton】支持实时性能数据测试 | Developing | sig-embedded | [@大鱼](https://gitee.com/hourenyu) | 源码 |  |

# 风险

| 问题类型 | 问题描述 | 问题等级 | 应对措施 | 责任人 | 状态 |
| -------- | -------- | -------- | -------- | ------ | ---- |
|          |          |          |          |        |      |

# 测试分层策略

本次LTS版本的具体测试分层策略如下：

| **需求**         | **开发主体** | **测试主体** | **测试分层策略**         |
| --------------- | ----------- | ---------- | ----------------------- |
|[I99VNQ](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I99VNQ) 【软实时OS】边缘控制图形和轻量桌面能力支持 | sig-embedded | sig-embedded | 验证图形化方式正常启动 |
|[I9AQMF](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQMF) 【软实时OS】MICA框架-混合部署可靠性增强 | sig-embedded | sig-embedded | 验证MICA在崩溃后可以重新恢复通信链路 |
|[I9AQJX](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQJX) 【软实时OS】MICA框架-支持多实例部署 | sig-embedded | sig-embedded | 验证MICA正常启动多个RTOS |
|[I9AQBX](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQBX) 【软实时OS】MICA框架-易用性完善 | sig-embedded | sig-embedded | 验证MICA命令行工具正常使用 |
|[I9B7L4](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9B7L4) 【软实时OS】支持嵌入式极简镜像（iSulad） | sig-embedded | sig-embedded | 验证极简镜像正常构建及可用性 |
|[I9AQ39](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQ39) 【软实时OS】Linux双版本内核支持 | sig-embedded | sig-embedded | 验证不同内核的镜像编译并正常启动 |
|[I9ALIE](https://gitee.com/openeuler/UniProton/issues/I9ALIE) 【硬实时OS】【UniProton】混合部署下GDB-stub功能增强 | sig-embedded | sig-embedded | 验证MICA下GDB正常使用 |
|[I9AD1M](https://gitee.com/openeuler/UniProton/issues/I9AD1M) 【硬实时OS】【UniProton】PLC组态运行时环境forte支持 | sig-embedded | sig-embedded | 验证PLC组态运行时forte环境正常启动 |
|[I9AD4C](https://gitee.com/openeuler/UniProton/issues/I9AD4C) 【硬实时OS】【UniProton】Modbus工业通信协议支持 | sig-embedded | sig-embedded | 验证Modbus协议能否正常通信 |
|[I9AAY4](https://gitee.com/openeuler/UniProton/issues/I9AAY4) 【硬实时OS】【UniProton】EtherCAT工业控制协议支持 | sig-embedded | sig-embedded | 验证EtherCat协议能否正常通信 |
|[I9AD7V](https://gitee.com/openeuler/UniProton/issues/I9AD7V) 【硬实时OS】【UniProton】IP协议栈支持 | sig-embedded | sig-embedded | 验证IP协议能否正常通信 |
|[I99Z3M](https://gitee.com/openeuler/UniProton/issues/I99Z3M) 【硬实时OS】【UniProton】混合部署系统PCIe中断支持 | sig-embedded | sig-embedded | 验证申请和响应基于消息的中断 |
|[I99YMZ](https://gitee.com/openeuler/UniProton/issues/I99YMZ) 【硬实时OS】【UniProton】混合部署系统PCIe驱动接口支持 | sig-embedded | sig-embedded | 验证PCIe驱动接口测试用例 |
|[I9A8PC](https://gitee.com/openeuler/UniProton/issues/I9A8PC) 【硬实时OS】【UniProton】混合部署系统PCIe架构DMA接口支持 | sig-embedded | sig-embedded | 验证正常启用DMA特性 |
|[I99ZAE](https://gitee.com/openeuler/UniProton/issues/I99ZAE) 【硬实时OS】【UniProton】实现PCIe驱动框架 | sig-embedded | sig-embedded | 验证PCIe板卡正常启动 |
|[I9AGRD](https://gitee.com/openeuler/UniProton/issues/I9AGRD) 【硬实时OS】【UniProton】支持基于混合部署场景的shell | sig-embedded | sig-embedded | 验证MICA下正常启动shell |
|[I9ADJV](https://gitee.com/openeuler/UniProton/issues/I9ADJV) 【硬实时OS】【UniProton】支持arm64的SMP | sig-embedded | sig-embedded | 验证MICA下正常启用SMP特性 |
|[I9ADDM](https://gitee.com/openeuler/UniProton/issues/I9ADDM) 【硬实时OS】【UniProton】支持多实例部署 | sig-embedded | sig-embedded | 验证MICA正常启动多个UniProton |
|[I9AGR4](https://gitee.com/openeuler/UniProton/issues/I9AGR4) 【硬实时OS】【UniProton】支持实时性能数据测试 | sig-embedded | sig-embedded | 验证rhealstone实时性能数据测试 |

# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*             | *重点*          | *设计思路*        | *备注* |
| ----- | ---------------------- | --------------- | ---------------- | ------ |
| [I99VNQ](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I99VNQ) |【软实时OS】边缘控制图形和轻量桌面能力支持 | 测试图形化启动 | 测试图形化镜像构建并正常启动 |  |
| [I9AQMF](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQMF) | 【软实时OS】MICA框架-混合部署可靠性增强 | MICA通信恢复 | Linux 的 mica 进程崩溃后，能够不影响RTOS运行，重新拉起MICA后可以恢复通信链路 |  |
| [I9AQJX](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQJX) | 【软实时OS】MICA框架-支持多实例部署 | 测试多实例 | 测试通过MICA部署多个RTOS并正常启动和通信 |  |
| [I9AQBX](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQBX) | 【软实时OS】MICA框架-易用性完善 | MICA命令行 | 通过MICA命令行进行测试，包括创建、启动、停止RTOS等命令 |  |
| [I9B7L4](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9B7L4) | 【软实时OS】支持嵌入式极简镜像（iSulad） | 测试构建isula极简镜像，拉起后容器可正常使用 | 下载openEuler标准容器镜像，拉起镜像在拉起容器中执行yum等嵌入式没有提供的功能 | |
| [I9AQ39](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I9AQ39) |【软实时OS】Linux双版本内核支持 | 镜像编译、基础功能 | 构建不同内核的镜像、测试基础用例 |  |
| [I9ALIE](https://gitee.com/openeuler/UniProton/issues/I9ALIE) | 【硬实时OS】【UniProton】混合部署下GDB-stub功能增强 | GDB命令行调试 | 混合部署场景下，通过GDB使用r、watch、bt、ctrl+c这些功能对UniProton进行调试 |  |
| [I9AD1M](https://gitee.com/openeuler/UniProton/issues/I9AD1M) | 【硬实时OS】【UniProton】PLC组态运行时环境forte支持 | Forte正常初始化 | 测试混合部署场景下forte是否正常初始化，可以加载fboot文件 |  |
| [I9AD4C](https://gitee.com/openeuler/UniProton/issues/I9AD4C) | 【硬实时OS】【UniProton】Modbus工业通信协议支持 | 与从站正常通信 | 在forte完成初始化的基础上，测试modbus是否正常初始化，并可以与从站建立连接和数据读写 |  |
| [I9AAY4](https://gitee.com/openeuler/UniProton/issues/I9AAY4) | 【硬实时OS】【UniProton】EtherCAT工业控制协议支持 | 与从站正常通信 | 测试EtherCAT能否正常启动并实时控制从站电机，以及EhterCAT命令行运行结果正常 |  |
| [I9AD7V](https://gitee.com/openeuler/UniProton/issues/I9AD7V) | 【硬实时OS】【UniProton】IP协议栈支持 | 测试代理网络和硬直通功能 | 测试在混合部署下以及在硬直通场景下，可以正常通信 |  |
| [I99Z3M](https://gitee.com/openeuler/UniProton/issues/I99Z3M) | 【硬实时OS】【UniProton】混合部署系统PCIe中断支持 | 测试驱动程序 | 测试驱动程序对设备的读写配置，中断的触发和响应 |  |
| [I99YMZ](https://gitee.com/openeuler/UniProton/issues/I99YMZ) | 【硬实时OS】【UniProton】混合部署系统PCIe驱动接口支持 | 测试驱动程序 | 测试驱动程序对设备的读写配置，中断的触发和响应 |  |
| [I9A8PC](https://gitee.com/openeuler/UniProton/issues/I9A8PC) | 【硬实时OS】【UniProton】混合部署系统PCIe架构DMA接口支持 | 测试驱动程序 | 测试PCIe通过DMA对设备进行读写 |  |
| [I99ZAE](https://gitee.com/openeuler/UniProton/issues/I99ZAE) | 【硬实时OS】【UniProton】实现PCIe驱动框架 | 测试驱动程序 | 测试驱动程序对设备的读写配置，中断的触发和响应 |  |
| [I9AGRD](https://gitee.com/openeuler/UniProton/issues/I9AGRD) | 【硬实时OS】【UniProton】支持基于混合部署场景的shell | shell命令行 | 测试混合部署下shell运行结果正常，包括help、cpup等命令 |  |
| [I9ADJV](https://gitee.com/openeuler/UniProton/issues/I9ADJV) | 【硬实时OS】【UniProton】支持arm64的SMP | SMP多核启动 | 测试混合部署场景下正常启动多核与单核模式，多核与多核模式下的UniProton |  |
| [I9ADDM](https://gitee.com/openeuler/UniProton/issues/I9ADDM) | 【硬实时OS】【UniProton】支持多实例部署 | 测试多实例 | 测试通过MICA部署多个RTOS并正常启动和通信 |  |
| [I9AGR4](https://gitee.com/openeuler/UniProton/issues/I9AGR4) | 【硬实时OS】【UniProton】支持实时性能数据测试 | rhealstone测试用例 | x86和aarch64可以通过rhealstone测试用例 |  |

## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                              | 策略                                                         |
| ----------------------------------------- | ------------------------------------------------------------ |
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
| 【特性回合】在RK3568J基于OpenAMP支持openEuler EM+RT-Thread| 继承已有测试能力，测试编译镜像能力 |
| 【特性回合】支持外设分区管理|  继承已有测试能力，测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在 |  
|【特性回合】【软实时OS】支持Jailhouse虚拟化底座|  继承已有测试能力，支持Jailhouse运行，可以通过Jailhouse进行虚拟化操作 | 
| 【特性回合】【软实时OS】支持1款X86工控芯片|  继承已有测试能力，编译x86镜像，安装到对应硬件，在硬件上进行基础测试 | 
| 【特性回合】【软实时OS】支持瑞芯微RK3568J|  继承已有测试能力，编译RK3568J镜像 | 
| 【特性回合】【软实时OS】基于RH2288云化PLC硬件，优化RT补丁|  继承已有测试能力，测试X86镜像的软实时性能 |
|【特性回合】【软实时OS】协议优化，提升流式数据和文件传输效率|  继承已有测试能力，测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效 | 
| 【特性回合】【软实时OS】支持树莓派蓝牙|  继承已有测试能力，启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现 | 
| 【特性回合】【软实时OS】支持软总线支持ble发现|  继承已有测试能力，通过编程调用蓝牙发现接口，可发现自动发现对端设备 | 
| 【特性回合】【软实时OS】引入Meta-ROS|  继承已有测试能力，测试Meta-ROS编译，能够正常启动 | 
| 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL（包括文件系统与网络框架）|  继承已有测试能力，通过posix suite相关接口测试 |
| 【软实时OS】社区ZVM底座对接嵌入式 |  继承已有测试能力，通过ZVM可拉起openEuler嵌入式 |
| 【特性回合】【软实时OS】支持isula镜像  |  继承已有测试能力，测试isula镜像启动，拉起后容器可正常使用 |
| 【特性回合】【软实时OS】支持RK3588  |  继承已有测试能力，构建出RK3588镜像、测试基础用例 | 
| 【特性回合】【软实时OS】支持全志A40i  |  继承已有测试能力，构建出全志A40i镜像、测试基础用例 | 

## 专项测试策略

### 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。整体安全测试需要覆盖：

1.  linux系统安全配置/权限管理等

2.  特性涉及到的安全需求验证

3.  CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

| 测试类         | 描述                      | 具体测试内容                                                 |
| :------------- | ------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | CVE扫描/敏感信息/编译选项 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全配置管理类 | Linux安全规范             | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试 |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 测试类性     | 具体测试内容                                                 |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| 操作系统重启 | 系统连续重启100次, 查看启动日志无报错，断电重启连续10次测试，查看启动日志无报错 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。openEuler 24.03 LTS版本是新的LTS版本，所以在操作系统基本benchmark各类指标上需要和上个22.03-LTS-SP3版本保持一致，性能数据波动需小于5%，同时新的6.x内核也需要形成基线；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                            | **指标值**              | **说明**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 利用UnixBench进行性能测试 | 参考LTS版本相应指标基线 | 与LTS基线数据差异小于5%以内可接受，测试镜像为树莓派镜像 |
| 软实时性能   | 利用cyclictest进行性能测试 | 参考LTS版本相应指标基线 | 与LTS基线数据差异小于5%以内可接受，测试镜像为树莓派软实时镜像、X86软实时镜像 |
| 硬实时性能   | 使用适配后的RhealStone进行性能测试，混合部署下的性能测试形成基线 | 参考2209版本相应指标基线 | 与2209基线数据差异小于5%以内可接受 |

### 兼容性测试

南向兼容性测试为整机适配测试。

本次LTS版本的整机兼容性适配测试会从acpi、impi、memory、系统兼容性、CPU特性、kabi规范性、稳定性等方面进行适配，适配完成后将在社区发布本次LTS版本的整机兼容性清单。

整机适配兼容性测试交付清单如下：

| **嵌入式硬件**  | **CPU型号**  | **测试主体** | **测试计划** |
|--|--|--|--|
| 树莓派4B | BCM2711 | sig-yocto | 仅用于嵌入式linux测试和边缘版本测试 |
| STM32F407ZGT6开发板 | CPU:STM32F407ZG(168MHz) <br />内存: 192+4 KB<br />FLASH: 1MB | sig-yocto | 仅用于硬实时测试 |
| 工控机HVAEIPC-M10 | CPU:Intel i7-10510U| 用于测试x86镜像编译结果以及rt补丁对x86的支持 |

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**       | **覆盖策略**                                | **中英文测试策略** |
|------------------|--------------------------------------------|------------------|
| openEuler Embedded 总体介绍 | 版本特性描述正确 | -   |
| openEuler Embedded 快速上手 | 构建、使用正确，无错误 | -   |
| openEuler Embedded 关键特性 | 特性介绍正确 | -   |
| openEuler Embedded 硬实时使用指南 | 构建、编译、任务创建、烧录的指导准确性 | - |

# 测试执行策略

openEuler 24.03 LTS版本按照社区release-manger团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取1+3+1的测试方式，即1轮基本功能保障发布beta版本可以提供给外部开发者，3轮全量保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归。

### 测试计划

openEuler 24.03 LTS版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

|Stage name|Begin time|End time|Days|Note|
|:----------|:---------|:-------|:---------|:-------|
| Alpha   | 2024/4/7 | 2024/4/23 | 16    | 软件包升级，拉LTS分支, CI构建流水线搭建 |
| Test round 1           | 2024/4/23  | 2024/4/30  | 7    | 继承特性、性能摸底测试|
| Test round 2           | 2024/5/6 | 2024/5/12 | 7    | 全量SIT验证|
| Test round 3           | 2024/5/13 | 2024/5/19 | 7    | 全量SIT验证   |
| Test round 4           | 2024/5/20 | 2024/5/24 | 7    | 回归测试   |
| Test round 5           | 2024/5/25 | 2024/5/29 | 6    | 回归测试   |
| Release                | 2024/5/30 | 2024/5/30 | 1    | 社区Release版本发布评审|

### 测试重点

测试阶段1(Alpha)：

1.  开发自验证，保证编译正常、软件功能可用

测试阶段2(Test round 1)：

1.  继承特性/新特性的基本功能

2.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整性

3.  专项情况如下：

    兼容性测试：南向硬件测试
    性能测试：嵌入式linux基础性能

测试阶段3(Test round 2)：

1.  继承特性/新特性的自动化全量验证

2.  系统集成验证

3.  专项：安全CVE扫描、编译选项、安全加固、敏感词扫描、端口扫描、性能、可靠性、文档测试、南北向兼容性测试

4.  问题单回归

测试阶段4(Test round 3)：

1. 继承特性/新特性的自动化全量验证

2. 问题单回归

3. 系统集成验证

4. 专项：交付件病毒扫描、南北向兼容性测试、性能、文档测试

测试阶段5(Test round 4)：

1. 交付特性/组件的自动化全量测试

2. 系统集成自动化测试项执行

3. 问题单全量回归

4. 专项：交付件病毒扫描、文档测试

测试阶段6(Test round 5)：

1. 交付特性/组件的自动化全量测试

2. 系统集成自动化测试项执行

3. 问题单全量回归

4. 专项：交付件病毒扫描、文档测试

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无
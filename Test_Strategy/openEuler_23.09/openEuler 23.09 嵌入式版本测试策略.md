![openEuler ico](../../images/openEuler.png)

版权所有 © 2023 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期       | 修订版本 | 修改  章节       | 修改描述               | 作者       |
| ---------- | -------- | ---------------- | ---------------------- | ---------- |
| 2023-8-15  | 1.0.0    |                  | 初稿                   | saarloos |


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

openEuler 创新版本 测试策略

Abstract 摘要：

本文是openEuler 23.09 embedded版本的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 概述

openEuler Embedded是基于openEuler社区面向嵌入式场景的Linux版本。当前openEuler内核源于Linux实现软实时能力，同时具备soc内多平面混合部署，开放基于Yocto构建包的小型化定制裁剪能力，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统。

本文主要描述openEuler 23.09 embedded 版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 23.09 embedded是基于5.10内核的创新版本，面向嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本构建基于master分支拉出，使用src-openeuler的2309分支作为源码，发布范围相较23.03版本主要变动：

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

## 需求范围(*待release刷新后协同刷新，发布方式需要更新*)

openEuler 23.09 embedded版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-23.09/release-plan.md)如下：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| 1 | [I7TYG1](https://gitee.com/openeuler/release-management/issues/I7TYG1)【混合部署】混合部署openAMP模式维测能力增强，支持Linux调试RTOS(UniProton)内核 | Discussion | sig-yocto | [@fanglinxu](https://gitee.com/fanglinxu) |源码 + 镜像包含 | |
| 2 | [I7TYJT](https://gitee.com/openeuler/release-management/issues/I7TYJT)【混合部署】混合部署支持jailhouse和openAMP | Discussion | sig-yocto | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含| |
| 3 | [I7TYKT](https://gitee.com/openeuler/release-management/issues/I7TYKT)【软实时OS】嵌入式Linux支持isula镜像	 | Discussion | sig-yocto | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含| |  
| 4 | [I7TYL0](https://gitee.com/openeuler/release-management/issues/I7TYL0)【软实时OS】嵌入式Linux ROS功能调优, 完善开发工具 | Discussion | sig-yocto | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含||  
| 5 | [I7TYLW](https://gitee.com/openeuler/release-management/issues/I7TYLW)【软实时OS】嵌入式Linux 构建yocto升级到4.0 LTS版本 | Discussion | sig-embedded | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含| |  
| 6 | [I7TYM4](https://gitee.com/openeuler/release-management/issues/I7TYM4)【硬实时OS】UniProton POSIX接口移植，新增exit/ipc/malloc/math/stdlib模块移植，增加设备管理，增加STM32F407串口支持，增加串口shell交互 | Discussion | sig-embedded | [@fanglinxu](https://gitee.com/fanglinxu)|源码 + 镜像包含| |  
| 7 | [I7TYM9](https://gitee.com/openeuler/release-management/issues/I7TYM9)【软实时OS】分布式软总线升级到3.2 | Discussion | sig-embedded | [@yukaii](https://gitee.com/yukaii)|源码| |  
| 8 | [I7TYME](https://gitee.com/openeuler/release-management/issues/I7TYME)【混合部署】Jailhouse支持不同cell和inmate的图形化管理 | Discussion | sig-embedded |  |源码|  |   
| 9 | [I7TYMX](https://gitee.com/openeuler/release-management/issues/I7TYMX)【软实时OS】OEE 南向支持 RK3588 | Discussion | sig-embedded |  [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) |源码 + 镜像包含| |    
| 10 | [I7TYNE](https://gitee.com/openeuler/release-management/issues/I7TYNE)【软实时OS】OEE 南向支持 RK3399 | Discussion | sig-embedded |  [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) |源码 + 镜像包含| |  
| 11 | [I7TYNI](https://gitee.com/openeuler/release-management/issues/I7TYNI)【软实时OS】OEE 支持RK3568图形能力增强 | Discussion | sig-embedded |  [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) |源码 + 镜像包含| |  
| 12 | [I7TYNK](https://gitee.com/openeuler/release-management/issues/I7TYNK)【混合部署】Jailhouse 支持 RK3568 和 RK3399 | Discussion | sig-embedded |  [@梁其锋](https://e.gitee.com/open_euler/members/trend/emancipator) |源码 + 镜像包含| |  


# 风险

| 问题类型 | 问题描述 | 问题等级 | 应对措施 | 责任人 | 状态 |
| -------- | -------- | -------- | -------- | ------ | ---- |
|          |          |          |          |        |      |

# 测试分层策略(*基于继承特性策略刷新*)

本次23.09 创新版本的具体测试分层策略如下：

| **需求**         | **开发主体** | **测试主体** | **测试分层策略**         |
| --------------- | ----------- | ---------- | ----------------------- |
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

# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*             | *重点*          | *设计思路*        | *备注* |
| ----- | ---------------------- | --------------- | ---------------- | ------ |
| 1 | [I7TYG1](https://gitee.com/openeuler/release-management/issues/I7TYG1)【混合部署】混合部署openAMP模式维测能力增强，支持Linux调试RTOS(UniProton)内核 | 在linux侧可以通过gdb调式RTOS内核 | 启动linux，启动gdb，启动rtos，测试gdb b c p q命令 | |
| 2 | [I7TYJT](https://gitee.com/openeuler/release-management/issues/I7TYJT)【混合部署】混合部署支持jailhouse和openAMP |   通过一套命令进行混合部署生命周期管理，可通过jailhouse拉起rtos系统 | 通过一套命令进行混合部署生命周期管理，可通过jailhouse拉起rtos系统 | |
| 3 | [I7TYKT](https://gitee.com/openeuler/release-management/issues/I7TYKT)【软实时OS】嵌入式Linux支持isula镜像	 |  测试isula功能 | 使用openEuler容器镜像进行测试，可通过isula拉起openEuler容器镜像，容器内功能正常，可使用yum等命令| |  
| 4 | [I7TYL0](https://gitee.com/openeuler/release-management/issues/I7TYL0)【软实时OS】嵌入式Linux ROS功能调优, 完善开发工具 |    ROS SDK编译能力 | 通过sdk编译 ros包(包含c++ ROS包和python ROS包)，传输至openEuler嵌入式系统，并且可运行 ||  
| 5 | [I7TYLW](https://gitee.com/openeuler/release-management/issues/I7TYLW)【软实时OS】嵌入式Linux 构建yocto升级到4.0 LTS版本 |    全量发布镜像构建 | 可构建出发布的所有发布件| |  
| 6 | [I7TYM4](https://gitee.com/openeuler/release-management/issues/I7TYM4)【硬实时OS】UniProton POSIX接口移植，新增exit/ipc/malloc/math/stdlib模块移植，增加设备管理，增加STM32F407串口支持，增加串口shell交互 |   posix接口，串口功能，shell功能 | posix接口功能进行测试，测试串口输入输出、shell功能交互| |  
| 7 | [I7TYM9](https://gitee.com/openeuler/release-management/issues/I7TYM9)【软实时OS】分布式软总线升级到3.2 |   验证升级后分布式软总线接口 | 验证升级后分布式软总线接口| |  
| 8 | [I7TYME](https://gitee.com/openeuler/release-management/issues/I7TYME)【混合部署】Jailhouse支持不同cell和inmate的图形化管理 |  通过图形化工具快速创建cell | 通过图形化工具快速管理cell | |  
| 9 | [I7TYMX](https://gitee.com/openeuler/release-management/issues/I7TYMX)【软实时OS】OEE 南向支持 RK3588 |    重点测试镜像构建、运行和基础功能  |测试镜像构建、运行和基础功能| |    
| 10 | [I7TYNE](https://gitee.com/openeuler/release-management/issues/I7TYNE)【软实时OS】OEE 南向支持 RK3399 |    重点测试镜像构建、运行和基础功能  |测试镜像构建、运行和基础功能| |  
| 11 | [I7TYNI](https://gitee.com/openeuler/release-management/issues/I7TYNI)【软实时OS】OEE 支持RK3568图形能力增强 |   重点测试镜像构建、运行和基础功能、验证图形能力  |重点测试镜像构建、运行和基础功能、验证图形能力| |  
| 12 | [I7TYNK](https://gitee.com/openeuler/release-management/issues/I7TYNK)【混合部署】Jailhouse 支持 RK3568 和 RK3399 |    重点测试镜像构建、运行和基础功能、验证混合部署能力  |重点测试镜像构建、运行和基础功能、验证混合部署能力| |  

## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

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


## 专项测试策略

### 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。整体安全测试需要覆盖：

1.  linux系统安全配置/权限管理等

2.  特性涉及到的安全需求验证

3.  CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

| 测试类         | 描述                      | 具体测试内容                                                 |
| :------------- | ------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | CVE扫描/敏感信息/编译选项 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全配置管理类 | 社区嵌入式安全配置规范 | 社区嵌入式安全配置包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试 |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 测试类性     | 具体测试内容                                                 |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| 操作系统重启 | 系统连续重启100次, 查看启动日志无报错，断电重启连续10次测试，查看启动日志无报错 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                                               | **指标值**              | **说明**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 利用UnixBench进行性能测试 | - | 仅测试摸底 |
| 软实时性能   | 利用cyclictest进行性能测试 | - | 仅测试摸底 |
| 硬实时性能   | 使用适配后的RhealStone进行性能测试 | - | 仅测试摸底 |

### 兼容性测试

#### 南向兼容性

本版本作为创新版本，达成以下清单的兼容性基线目标。

| **嵌入式硬件**  | **CPU型号**  | **测试主体** | **测试计划** |
|--|--|--|--|
| 树莓派4B | BCM2711 | sig-yocto | 仅用于嵌入式linux测试 |
| STM32F407ZGT6开发板 | CPU:STM32F407ZG(168MHz) <br />内存: 192+4 KB<br />FLASH: 1MB | sig-yocto | 仅用于硬实时测试 |
| 工控机HVAEIPC-M10 | CPU:Intel i7-10510U| 用于测试x86镜像编译结果以及rt补丁对x86的支持 |

#### 北向兼容性

创新版本暂不涉及

#### 虚拟化兼容性

嵌入式不涉及

### 软件包管理专项测试

嵌入式不涉及

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**       | **覆盖策略**                                | **中英文测试策略** |
|------------------|--------------------------------------------|------------------|
| openEuler Embedded 总体介绍 | 版本特性描述正确 | -   |
| openEuler Embedded 快速上手 | 构建、使用正确，无错误 | -   |
| openEuler Embedded 关键特性 | 特性介绍正确 | -   |
| openEuler Embedded 硬实时使用指南 | 构建、编译、任务创建、烧录的指导准确性 | - |

# 测试执行策略

openEuler 23.09 版本按照社区release-manger团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取1+3+1的测试方式，即1轮基本功能保障发布beta版本可以提供给外部开发者，3轮全量保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归。

### 测试计划

openEuler 23.09 版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stage  name          | Begin time | End time   | Days | Note                                      |
| -------------------- | ---------- | ---------- | ---- | ----------------------------------------- |
| Alpha                | 2023/8/14      | 2023/8/27    | 4        | 软件包升级完成，首版本发布                            |
| Test round 1         | 2023/9/6      | 2023/9/9     | 5        |                                                       |
| Test round 2         | 2023/9/11       | 2023/9/4     | 4        | 特性合入冻结，不再接纳新特性代码合入                  |
| Test round 3         | 2023/9/15      | 2023/9/19    | 4        |                                                       |
| Test round 4         | 2023/9/20      | 2023/9/22    | 2        |      
| Test round 5         | 2023/9/25      | 2023/9/26    | 2        |                                      |
| Release              | 2023/9/28      | 2023/9/28    | 1        |                                                       |


### 测试重点

测试阶段1：

1.  继承特性/新特性的基本功能

2.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整性

3.  专项情况如下：

    兼容性测试：南向硬件测试

测试阶段2：

1.  继承特性/新特性的全量验证

2.  通过自动化覆盖重要组件的功能

3.  系统集成的正确性和完整性

4.  专项：

    可靠性：保证版本的长时间稳定运行，建议运行时长7\*24
    
    性能：保证版本的性能满足发布基线标准，不能低于版本性能指标
    
    安全测试：进行安全编译选项、敏感信息扫描、进行安全CVE漏洞

测试阶段3：

1.  继承特性/新特性的自动化全量验证

2.  系统集成验证

3.  专项：性能、文档测试、南北向兼容性测试、端口扫描

4.  问题单回归

测试阶段4：

1. 交付特性/组件的全量测试

2. 专项：文档测试

3. 问题单回归

4. 系统集成验证


测试阶段5：

1. 系统集成自动化测试项执行

2. 问题单全量回归

3. 专项：交付件病毒扫描、文档测试

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

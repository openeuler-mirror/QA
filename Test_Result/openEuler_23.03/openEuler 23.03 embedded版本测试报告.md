![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ------------------ | ---------- |
| 2023/03/28 | 初稿 | 填写模板 | @saarloos |

关键词：

openEuler embedded raspberrypi 分布式软总线 混合部署

摘要：

文本主要描述openEuler embedded 23.03 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。


# 1   概述

openEuler Embedded是基于openEuler社区面向嵌入式场景的Linux版本，旨在成为一个高质量的以Linux为中心的嵌入式系统软件平台。

本文主要描述openEuler 23.03 embedded版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler embedded 23.03版本是23年首个创新版本，对22.09版本构建、使用上的问题进行了重构，使用5.10内核，并跟随社区对基础软件包版本进行升级，同时嵌入式Linux新增x86编译支持；引入meta-ros层对ROS2进行基础支持；增强软总线功能增加BLE发现支持，提升流式数据和文件传输效率；UniProton增加对hi3093芯片支持等。主要变更功能如下：

1.  x86工控芯片支持
2.  引入Meta-ROS构建
3.  硬实时UniProton适配Hi3093芯片支持
4.  混合部署支持外设分区管理
5.  PREEMPT-RT软实时优化
6.  软总线支持ble发现
7.  树莓派支持蓝牙

openEuler 23.03 版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称                 | 测试起始时间 | 测试结束时间 |  持续时间 | 备注                          |
| :------------ | :--------- | :--------- | ---- | ----------------------------- |
| Test round 1(计划) | 2023/2/20  | 2023/2/24 | 5   | 版本启动测试，内核冻结   |
| Test round 1(实际) | 2023/2/20  | 2023/2/24 | 5   |    |
| Test round 2(计划) | 2023/2/27  | 2023/3/3 | 5   |   |
| Test round 2(实际) | 2023/2/27  | 2023/3/3 | 5   |   |
| Test round 3(计划) | 2023/3/6  | 2023/3/10 | 5   | 特性合入冻结，不再接纳新特性代码合入   |
| Test round 3(实际) | 2023/3/6  | 2023/3/17 | 10   | 特性合入延期，延长测试时间   |
| Test round 4(计划) | 2023/3/13  | 2023/3/17 | 5   |    |
| Test round 4(实际) | 2023/3/21  | 2023/3/25 | 5   |    |
| Test round 5(计划) | 2023/3/20  | 2023/3/22 | 3   |    |
| Test round 5(实际) | 2023/3/27  | 2023/3/29 | 3   |    |
| Release | 2023/3/30  | 2023/3/30 | 1   |    |

测试的硬件环境如下：

| 硬件型号 | 硬件配置信息 | 备注 |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------- |
| 树莓派4B卡 | CPU:BCM2711(Cortex-A72 * 4) <br />内存：4GB/8GB <br />存储设备：SanDisk Ultra 64GB micro SD |        |
| qemu | CPU:Cortex-A15/A57 <br /> 最小启动内存：512M |        |
| 江苏润和-Hi3561DV300-HiSpark Ai Camera开发套件 | CPU:Hi3561| 仅用于分布式软总线与openEuler组网、通信测试 |
| STM32F407开发板 | CPU:STM32F407| 仅用于硬实时性能的测试 |
| 工控机HVAEIPC-M10 | CPU:Intel i7-10510U| 用于测试x86镜像编译结果以及rt补丁对x86的支持 |
| Hi3093开发板 | CPU:Hi3093| 仅用于硬实时性能的测试 |

openEuler 23.03版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-23.03/release-plan.md)，其中嵌入式需求如下：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| [I6DRB2](https://gitee.com/openeuler/release-management/issues/I6DRB2) | 混合部署支持外设分区管理 | Discussion | sig-yocto | [@linzichang](https://gitee.com/linzichang) [@beiling.xie](https://gitee.com/beilingxie) [@zhengjunling](https://gitee.com/junling_zheng) [@ilisimin](https://gitee.com/open_euler/dashboard/members/ilisimin) [@任慰](https://gitee.com/open_euler/dashboard/members/vonhust)|embedded|yocto-meta-openeuler,dsoftbus_standard, yocto-embedded-tools, OpenAMP | 源码 + 镜像包含 |  |
| [I6DRDP](https://gitee.com/openeuler/release-management/issues/I6DRDP) | 支持一款X86芯片 | Discussion | sig-yocto | [@linzichang](https://gitee.com/linzichang) [@beiling.xie](https://gitee.com/beilingxie) [@zhengjunling](https://gitee.com/junling_zheng) [@ilisimin](https://gitee.com/open_euler/dashboard/members/ilisimin) [@任慰](https://gitee.com/open_euler/dashboard/members/vonhust)|embedded|yocto-meta-openeuler,dsoftbus_standard, yocto-embedded-tools, OpenAMP | 源码 + 镜像包含 | |
| [I6DRIL](https://gitee.com/openeuler/release-management/issues/I6DRIL) | PREEMPT-RT软实时优化 | Discussion | sig-yocto | [@linzichang](https://gitee.com/linzichang) [@beiling.xie](https://gitee.com/beilingxie) [@zhengjunling](https://gitee.com/junling_zheng) [@ilisimin](https://gitee.com/open_euler/dashboard/members/ilisimin) [@任慰](https://gitee.com/open_euler/dashboard/members/vonhust)|embedded|yocto-meta-openeuler,dsoftbus_standard, yocto-embedded-tools, OpenAMP | 源码 + 镜像包含 | |
| [I6DRJL](https://gitee.com/openeuler/release-management/issues/I6DRJL) | 引入Meta-ROS | Discussion | sig-yocto | [@linzichang](https://gitee.com/linzichang) [@beiling.xie](https://gitee.com/beilingxie) [@zhengjunling](https://gitee.com/junling_zheng) [@ilisimin](https://gitee.com/open_euler/dashboard/members/ilisimin) [@任慰](https://gitee.com/open_euler/dashboard/members/vonhust)|embedded|yocto-meta-openeuler,dsoftbus_standard, yocto-embedded-tools, OpenAMP | 源码 + 镜像包含 | |
| [I6DRZD](https://gitee.com/openeuler/release-management/issues/I6DRZD) | UniProton适配Hi3093 | Discussion | sig-embedded | [@linzichang](https://gitee.com/linzichang) [@beiling.xie](https://gitee.com/beilingxie) [@zhengjunling](https://gitee.com/junling_zheng) [@ilisimin](https://gitee.com/open_euler/dashboard/members/ilisimin) [@任慰](https://gitee.com/open_euler/dashboard/members/vonhust)|embedded|yocto-meta-openeuler,dsoftbus_standard, yocto-embedded-tools, OpenAMP | 源码 + 镜像包含 | |
| [I6FQIG](https://gitee.com/openeuler/release-management/issues/I6FQIG) | 软总线支持ble发现 | Discussion | sig-embedded | [@linzichang](https://gitee.com/linzichang) [@beiling.xie](https://gitee.com/beilingxie) [@zhengjunling](https://gitee.com/junling_zheng) [@ilisimin](https://gitee.com/open_euler/dashboard/members/ilisimin) [@任慰](https://gitee.com/open_euler/dashboard/members/vonhust)|embedded|yocto-meta-openeuler,dsoftbus_standard, yocto-embedded-tools, OpenAMP | 源码 + 镜像包含 | |
| [I6FQGV](https://gitee.com/openeuler/release-management/issues/I6FQGV) | 树莓派支持蓝牙 | Discussion | sig-embedded | [@linzichang](https://gitee.com/linzichang) [@beiling.xie](https://gitee.com/beilingxie) [@zhengjunling](https://gitee.com/junling_zheng) [@ilisimin](https://gitee.com/open_euler/dashboard/members/ilisimin) [@任慰](https://gitee.com/open_euler/dashboard/members/vonhust)|embedded|yocto-meta-openeuler,dsoftbus_standard, yocto-embedded-tools, OpenAMP | 源码 + 镜像包含 | |
| [I6FQDQ](https://gitee.com/openeuler/release-management/issues/I6FQDQ) | 协议优化，提升流式数据和文件传输效率 | Discussion | sig-embedded | [@linzichang](https://gitee.com/linzichang) [@beiling.xie](https://gitee.com/beilingxie) [@zhengjunling](https://gitee.com/junling_zheng) [@ilisimin](https://gitee.com/open_euler/dashboard/members/ilisimin) [@任慰](https://gitee.com/open_euler/dashboard/members/vonhust)|embedded|yocto-meta-openeuler,dsoftbus_standard, yocto-embedded-tools, OpenAMP | 源码 + 镜像包含 | |

继承需求如下：
| **需求**         | **开发主体** | **测试主体** | **测试分层策略**         |
| --------------- | ----------- | ---------- | ----------------------- |
| 基于Linux 5.10内核提供软实时能力 | sig-Yocto | sig-Yocto | 通过cyclictest进行测试软实时能力 |
| 实现soc内实时和非实时多平面混合部署 | sig-Yocto | sig-Yocto | 在qemu上启动混合部署  |
| 开放基于Yocto构建包的小型化定制裁剪能力 | sig-Yocto | sig-Yocto | 使用yocto构建出不同系统 |
| 基于社区10.3版本gcc提供ARM版本交叉编译工具链 | sig-Yocto | sig-Yocto | 使用交叉编译工具链进行测试用例编译 |
| 支持树莓派4B作为嵌入式通用硬件 | sig-Yocto | sig-Yocto | 使用树莓派进行测试 |
| 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 | sig-Yocto | sig-Yocto | 测试分布式软总线接口，以及openEuler设备间互联互通 |
| 实时非实时系统混合部署支持树莓派 | sig-Yocto | sig-Yocto | 在树莓派上启动混合部署，调用串口/SHELL服务来进行混合部署间的调用和通信，混合部署生命周期管理 |
| 分布式软总线生态互通互联 | sig-Yocto | sig-Yocto | 测试分布式软总线接口，以及与openharmony设备间互联互通 |
| 硬实时uniProton支持南向开发板 | sig-embedded | sig-embedded | 可编译对应支持的uniproton镜像 |
| 硬实时uniProton支持混合部署 | sig-embedded | sig-embedded | 可编译对应支持的uniproton镜像，并在树莓派启动对应混合部署 |
| 硬实时uniProton支持POSIX接口 | sig-embedded  | sig-embedded | 测试通过适配开源posix测试套测试支持的posix接口 |

> 当前社区嵌入式release发布基于qemu的基础标准镜像，嵌入式构建源码在gitee仓库提供。 

本次版本测试活动分工如下：

| **需求**                        | **开发主体**          | **测试主体**      | **测试分层策略**                                             |
| ------------------------------- | --------------------- | ----------------- | ------------------------------------------------------------ |
| 混合部署支持外设分区管理 | sig-Yocto | sig-Yocto | 测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在 | 
| 支持一款X86芯片 | sig-Yocto | sig-Yocto  | 编译x86镜像，安装到对应硬件，在硬件上进行基础测试 |  
| PREEMPT-RT软实时优化 | sig-Yocto | sig-Yocto  | 在x86镜像上测试preempt-rt性能, 对比竞品性能有所提升 |  
| 引入Meta-ROS | sig-Yocto | sig-Yocto |测试Meta-ROS编译，能够正常启动 |  
| UniProton适配Hi3093 | sig-Yocto | sig-Yocto |可编译Hi3093 UniProton镜像，在混合部署情况下，可启动UniProton后可正常运行 |  
| 软总线支持ble发现 | sig-Yocto | sig-Yocto |通过编程调用蓝牙发现接口，可发现自动发现对端设备 |  
| 树莓派支持蓝牙	 | sig-Yocto | sig-Yocto | 启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现 |  
| 协议优化，提升流式数据和文件传输效率 | sig-Yocto | sig-Yocto | 测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效 |  

继承需求测试策略如下:
| Feature/组件 |  策略                           |
| ----------- | ------------------------------- |
| 基于Linux 5.10内核提供软实时能力 | 通过cyclictest进行测试软实时能力 |
| 实现soc内实时和非实时多平面混合部署 | 在qemu上启动混合部署  |
| 开放基于Yocto构建包的小型化定制裁剪能力  | 使用yocto构建出不同系统 |
| 基于社区10.3版本gcc提供ARM版本交叉编译工具链  | 使用交叉编译工具链进行测试用例编译 |
| 支持树莓派4B作为嵌入式通用硬件 | 使用树莓派进行测试 |
| 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 | 测试分布式软总线接口，以及openEuler设备间互联互通 |
| 实时非实时系统混合部署支持树莓派 | 在树莓派上启动混合部署，调用串口/SHELL服务来进行混合部署间的调用和通信，混合部署生命周期管理 |
| 分布式软总线生态互通互联  | 测试分布式软总线接口，以及与openharmony设备间互联互通 |
| 硬实时uniProton支持南向开发板  | 可编译对应支持的uniproton镜像 |
| 硬实时uniProton支持混合部署  | 可编译对应支持的uniproton镜像，并在树莓派启动对应混合部署 |
| 硬实时uniProton支持POSIX接口 | 测试通过适配开源posix测试套测试支持的posix接口 |

# 3 版本概要测试结论

openEuler embedded 23.03版本整体测试按照release-manager团队的计划，共完成了五轮测试，包含一轮基础及基础软件外围包测试、一轮安全配置及基础OS指令测试、一轮全量测试(基础功能及指令、新增特性、外围包、安全专项、性能专项)以及两轮回归测试；

其中一轮基础功能测试聚焦在linux系统调用、glibc和基础软件外围包功能的自动化验证，旨在识别阻塞性问题；一轮安全配置及基础OS指令测试开展系统安全配置及OS基础指令的测试；另外一轮全量测试，涵盖基础功能及指令、外围包、新增特性、安全专项、性能专项等全面的测试以及用户使用场景测试模拟社区用户，按照使用指南中指导完成了镜像获取启动、基于SDK的应用开发以及容器构建环境的获取和一键构建；最后两轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；

版本按照测试策略完成了全量功能验证和专项测试(性能、可靠性、兼容性、安全)，所有测试预计发布前按计划完成。本版本计划交付需求8个，实际交付8个，交付率100%，所有发布需求均验证通过。

​openEuler embedded 23.03版本目前共发现问题38个，修复问题33个，拒绝问题单2个，取消问题单3个，版本整体质量较好，风险可控。

# 4 版本详细测试结论

23.03 版本详细测试内容包括：

1. 完成基础OS质量保障，包括内核、系统调用、glibc以及基础软件包的功能测试，测试功能正常，问题已跟踪闭环；
2. 对关键继承特性，如软实时、yocto小型定制裁剪以及ARM版本交叉编译工具链进行了专项特性测试，软实时特性功能正常，性能与2203版本持平，yocto小型定制裁剪以及ARM版本交叉编译工具链功能正常与2203版本使用使用有优化，测试中发现的问题已跟踪闭环
3. 完成各项专项测试 (性能、可靠性、兼容性、安全)，测试正常，问题已跟踪闭环；
4. 对新增特性，针对原有继承部分和新增部分进行了测试，继承功能征程，新增功能征程，问题已跟踪闭环；


## 4.1   特性测试结论

### 4.1.1   继承特性评价

<!-- 对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估 -->

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
| 1 | 基于Linux 5.10内核提供软实时能力 | <font color=green>█</font>  |  |
| 2 | 实现soc内实时和非实时多平面混合部署 | <font color=green>█</font>  |  |
| 3 | 开放基于Yocto构建包的小型化定制裁剪能力 | <font color=green>█</font>  |  |
| 4 | 基于社区10.3版本gcc提供ARM版本交叉编译工具链 | <font color=green>█</font>  |  |
| 5 | 支持树莓派4B作为嵌入式通用硬件 | <font color=green>█</font>  |  |
| 6 | 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 | <font color=green>█</font>  |  |
| 7 | 实时非实时系统混合部署支持树莓派 | <font color=green>█</font>  |  |
| 8 | 分布式软总线生态互通互联 | <font color=green>█</font>  |  |
| 9 | 硬实时uniProton支持南向开发板 | <font color=green>█</font>  |  |
| 10 | 硬实时uniProton支持混合部署 | <font color=green>█</font>  |  |
| 11 | 硬实时uniProton支持POSIX接口 | <font color=green>█</font>  |  |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称** | **测试覆盖情况** | **约束依赖说明** | **遗留问题单** | **质量评估** | **备注<img width=50/>** |
| -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1 | 混合部署支持外设分区管理 | 测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在 | | | <font color=green>█</font> | |
| 2 | 支持一款X86芯片 | 编译x86镜像，安装到对应硬件，在硬件上进行基础测试 |  | | <font color=green>█</font> | |
| 3 | PREEMPT-RT软实时优化 | 在x86镜像上测试preempt-rt性能, 对比竞品性能有所提升 |  | | <font color=green>█</font> | |
| 4 | 引入Meta-ROS | 测试Meta-ROS编译，能够正常启动 |  | | <font color=green>█</font> | |
| 5 | UniProton适配Hi3093 |可编译Hi3093 UniProton镜像，在混合部署情况下，可启动UniProton后可正常运行 |  | | <font color=green>█</font> | |
| 6 | 软总线支持ble发现 | 通过编程调用蓝牙发现接口，可发现自动发现对端设备 |  | | <font color=green>█</font> | |
| 7 | 树莓派支持蓝牙	 | 启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现 |  | | <font color=green>█</font> | |
| 8 | 协议优化，提升流式数据和文件传输效率 | 测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效 |  | | <font color=green>█</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler embedded 均采用断电烧写进行升级，目前不涉及升级兼容性。

### 4.2.2   南向兼容性

openEuler embedded 2303 与2209版本相同支持硬件，已测试兼容

下表列出版本集成验证中涉及的硬件整机信息：

| 硬件型号 | 硬件详细信息 | 备注 |
| --------------------- |----------------------------------------------------------------- | ------------------- |
| 树莓派4B卡 | CPU:Cortex-A72 * 4 <br />内存：4GB/8GB <br />存储设备：SanDisk Ultra 64GB micro SD |
| STM32F407开发板 | CPU:STM32F407 | 用于硬实时UniProton |

### 4.2.3   北向兼容性

创新版本北向兼容性暂不考虑进行测试

## 4.3   专项测试结论

### 安全测试

整体安全测试覆盖：

1、Linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试，发现2个相关问题，所有问题均澄清或修改。

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/编译选项扫描/交付件病毒扫描，其中发现新增CVE漏洞74个，已提交社区issue，1个CVE遗留，开放22端口用于ssh，编译选项扫描正常，问题均修复或为误报已确认，敏感信息扫描已确认无敏感信息，交付件无病毒。

3、针对安全加固指南中的加固项，进行全量测试，其中发现问题1个，问题均澄清和修复。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------------------------------------------------------------------------------ | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； |  目前稳定运行7天  |

### 性能测试

| **指标大项** | **指标小项** | **指标值** | **测试结论** |
| ------------- | ------------------------------------------------------------ | --------------------------------- | -------------------- |
| OS基础性能 | UnixBench除C编译外测试内容 | 参考22.03 LTS版本相应指标基线 | 比较前一版本差异在5%以内 |
| 软实时补丁性能 | cyclictest空载及压力负载 | 参考22.03 LTS版本相应指标基线 | aarch64比较前一版本持平，x86性能指标形成基线 |
| 硬实时系统性能 | 适配后的RhealStone用例测试 | 与2209版本比较 | 与2209版本持平，上下文切换时延2us，中断时延1us |

# 5   问题单统计

openEuler 23.03 embedded版本共发现问题单个，拒绝问题单38个，取消问题单3个，其中修复问题单33个，遗留问题单2个，其余回归均通过。详细分布见下表:

| 测试阶段                    | 问题单数 |
| --------------------------- | -------- |
| openEuler embedded RC1 | 5  |
| openEuler embedded RC2 | 18   |
| openEuler embedded RC3 | 12  |
| openEuler embedded RC4 | 3  |
| openEuler embedded RC5 | 1  |

1、RC1 RC2为操作系统基础测试、外围包、基础命令及安全加固测试，主要聚焦于操作系统的基础功能及基本安全问题，由于2303重构了2209的编译系统及对软件包进行了升级，测试发现问题数较多为编译及升级后软件使用问题以及硬实时新增的posix接口的测试用例发现的问题；

2、RC3进行了全量测试，问题主要集中在性能、安全编译选项、安全配置、敏感词、CVE等专项测试问题，以及uniproton部分回归后发现的新增问题；

3、RC4经过了RC3的全量测试，此轮为回归测试，对前面发现问题较多的外围包、安全配置等进行了回归测试，问题发现较少，同时对版本资料进行了测试，发现少量问题。

4、RC5为第二轮回归测试，主要对资料、基础功能以及版本新特性进行回归测试，大部分为资料问题，均修复。

5、版本测试发现问题整体呈收敛


# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| ---- | ------- | -------- | -------- | ------- | -------- | --------- | 
|  |  |  |  |  |  |  | 


# 致谢
非常感谢以下开发者在openEuler 23.03 版本测试中做出的贡献,以下排名不分先后
- [seven](xxxx)
- [WindDD_2022](xxxx)
- [hhm666](xxxx)
- [pangkailin](xxxx)
- [薛定谔猫的黎曼猜想](xxxx)
- [lmq9671](xxxx)
- [s_c_c](xxxx)
- [saarloos](xxxx)
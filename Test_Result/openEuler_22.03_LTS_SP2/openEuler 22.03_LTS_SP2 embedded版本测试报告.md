![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ------------------ | ---------- |
| 2023/06/18 | 1.0.0    | 初始               | saarloos |
|  |     |      |   |

关键词：

openEuler LTS SP2 embedded  ROS 混合部署 软实时 

摘要：

文本主要描述openEuler 22.03-LTS-SP2 embedded版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语      | 英文全名                             | 中文解释       |
| ----------- | ------------------------------------ | -------------- |
| OS          | Operating System                     | 操作系统       |
| LTS         | Long Time Support                    | 长时间维护     |
| CVE         | Common Vulnerabilities and Exposures | 通用漏洞批露   |
| QEMU        | quick emulator                       | 通用和开源的机器仿真器和虚拟器 |
| ROS         | Robot Operating System               | 机器人操作系统 |

---

\***

# 1   概述

openEuler Embedded是基于openEuler社区面向嵌入式场景的Linux版本。当前openEuler内核源于Linux实现软实时能力，同时具备soc内多平面混合部署，开放基于Yocto构建包的小型化定制裁剪能力，支持openHarmony分布式软总线，同时嵌入式提供了非Linux内核的硬实时能力，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统。

本文主要描述openEuler 22.03 LTS SP2 embedded版本的总体测试情况，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

# 2   测试版本说明

openEuler 22.03 LTS SP2 embedded版本是基于5.10内核22.03-LTS的增强扩展版本，面向嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于master分支拉出，发布范围相较22.03 LTS SP1 embedded版本主要变动：

1.  软件版本选型升级，详情请见版本变更说明
2.  修复bug和cve
3.  在RK3568J基于OpenAMP支持openEuler EM+RT-Thread
4.  嵌入式linux支持外设分区管理
5.  嵌入式linux支持Jailhouse虚拟化底座
6.  嵌入式linux支持1款X86工控芯片
7.  嵌入式linux支持瑞芯微RK3568J
8.  嵌入式linux基于RH2288云化PLC硬件，优化RT补丁
9.  嵌入式linux协议优化，提升流式数据和文件传输效率
10. 嵌入式linux支持树莓派蓝牙
11. 嵌入式linux支持软总线支持ble发现
12. 嵌入式linux引入Meta-ROS
13. UniProton完成基础中间件移植，移植完成MUSL C接口共计178个（所有pthread和time接口）

openEuler 22.03 LTS SP2 embedded版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动，详细的版本信息和测试时间如下表：
| 版本名称                    | 测试起始时间 | 测试结束时间 |
| --------------------------- | ------------ | ------------ |
|Test round 1|2023-06-03|2023-06-09|
|Test round 2|2023-06-10(实际2023-06-15)|2023-06-16(实际2023-06-18)|
|Test round 3|2023-06-18(实际2023-06-19)|2023-06-21|
|Test round 4|2023-06-22|2023-06-27|
|Test round 5|2023-06-28|2023-06-30|

测试的硬件环境如下：

| 硬件型号                            | 硬件配置信息                                                 | 备注                      |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------- |
| 树莓派4B卡 | CPU:BCM2711(Cortex-A72 * 4) <br />内存：4GB/8GB <br />存储设备：SanDisk Ultra 64GB micro SD |        |
| qemu | CPU:Cortex-A15/A57 <br /> 最小启动内存：512M |        |
| 江苏润和-Hi3561DV300-HiSpark Ai Camera开发套件 | CPU:Hi3561| 仅用于分布式软总线与openEuler组网、通信测试 |
| STM32F407开发板 | CPU:STM32F407| 仅用于硬实时性能的测试 |
| 工控机HVAEIPC-M10 | CPU:Intel i7-10510U| 用于测试x86镜像编译结果以及RH2288云化PLC硬件，rt补丁需求 |
| 飞凌OK3568 | CPU: RK3568 | 用于RK3568相关需求测试 |


openEuler 22.03 LTS SP2 embedded版本交付需求列表如下：

| **no** | **feature**                                                  | **status** | **sig**                 | **owner**                                      |
| ------ | ------------------------------------------------------------ | ---------- | ----------------------- | ---------------------------------------------- |
| [I71DOW](https://gitee.com/openeuler/release-management/issues/I71DOW)| 【特性回合】在RK3568J基于OpenAMP支持openEuler EM+RT-Thread| Testing| sig-embedded| |
| [I71DOZ](https://gitee.com/openeuler/release-management/issues/I71DOZ)| 【特性回合】支持外设分区管理| Testing| sig-embedded| | 
| [I71DP1](https://gitee.com/openeuler/release-management/issues/I71DP1)| 【特性回合】【软实时OS】支持Jailhouse虚拟化底座| Testing| sig-embedded| | 
| [I71DP3](https://gitee.com/openeuler/release-management/issues/I71DP3)| 【特性回合】【软实时OS】支持1款X86工控芯片| Testing| sig-embedded| | 
| [I71DP4](https://gitee.com/openeuler/release-management/issues/I71DP4)| 【特性回合】【软实时OS】支持瑞芯微RK3568J| Testing| sig-embedded| | 
| [I71DP6](https://gitee.com/openeuler/release-management/issues/I71DP6)| 【特性回合】【软实时OS】基于RH2288云化PLC硬件，优化RT补丁| Testing| sig-embedded| | 
| [I71DP7](https://gitee.com/openeuler/release-management/issues/I71DP7)| 【特性回合】【软实时OS】协议优化，提升流式数据和文件传输效率| Testing| sig-distributed-middleware| | 
| [I71DP8](https://gitee.com/openeuler/release-management/issues/I71DP8)| 【特性回合】【软实时OS】支持树莓派蓝牙| Testing| sig-distributed-middleware| | 
| [I71DP9](https://gitee.com/openeuler/release-management/issues/I71DP9)| 【特性回合】【软实时OS】支持软总线支持ble发现| Testing| sig-distributed-middleware| | 
| [I71DPG](https://gitee.com/openeuler/release-management/issues/I71DPG)| 【特性回合】【软实时OS】引入Meta-ROS| Testing| sig-embedded| | 
| [I71DPI](https://gitee.com/openeuler/release-management/issues/I71DPI)| 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL C接口共计178个（所有pthread和time接口）| Testing| sig-embedded| | 

继承需求如下：
| **no** | **feature**                                                  | **sig**                 | **owner**                                      |
| ------ | ------------------------------------------------------------ | ----------------------- | ---------------------------------------------- |
| [I4YMW9](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I4YMW9) | 集成openEuler社区软实时补丁  | sig-yocto | @Wanming Hu |
| [I4YMUM](https://gitee.com/src-openeuler/OpenAMP/issues/I4YMUM) | 实现soc内实时和非实时多平面混合部署  | sig-embedded | @Wayne Ren @wilson |
| [I4YMUX](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I4YMUX) <br/> [I4Q7W7](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I4Q7W7) | 开放基于Yocto构建包的小型化定制裁剪能力  | sig-yocto | @ilisimin |
| [I4YMVX](https://gitee.com/src-openeuler/gcc-cross/issues/I4YMVX) | 基于社区10.3版本gcc提供ARM版本交叉编译工具链  | sig-compiler | @wangding16 |
| [I4YMV8](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I4YMV8) | 支持树莓派4B作为嵌入式通用硬件  | sig-embedded | @liangfangping |
| [I4YMTP](https://gitee.com/openeuler/dsoftbus_standard/issues/I4YMTP) | 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通  | sig-yocto | @beilingxie @zheng liming |
| [I5Y1K3](https://gitee.com/openeuler/release-management/issues/I5Y1K3) <br>  [I5YJ4V](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I5YJ4V) | 基于分布式软总线扩展生态互通 | sig-Yocto |sig-Yocto |
| [I5Y1J1](https://gitee.com/openeuler/release-management/issues/I5Y1J1) <br>  [I5YJ58](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I5YJ58) | 提供混合关键部署技术 | sig-Yocto |sig-Yocto  |
| [I5YINT](https://gitee.com/openeuler/UniProton/issues/I5YINT) | 硬实时uniProton支持南向开发板 | Discussion |sig-embedded | sig-embedded | 
| [I5YIOS](https://gitee.com/openeuler/UniProton/issues/I5YIOS) | 硬实时uniProton支持混合部署 | sig-embedded | sig-embedded | 
| [I5YIQW](https://gitee.com/openeuler/UniProton/issues/I5YIQW) | 硬实时uniProton支持POSIX接口 | sig-embedded | sig-embedded | 

本次openEuler 22.03 LTS SP2 embedded版本测试活动分工如下：

| **需求**                     | **开发主体**      | **测试主体**      | **测试策略**                                                 |
| ---------------------------- | ----------------- | ----------------- | ------------------------------------------------------------ |
| 【特性回合】在RK3568J基于OpenAMP支持openEuler EM+RT-Thread| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 基于RK3568J硬件的混合部署，嵌入式linux启动后，可启动RT-Thread，RT-Thread demo输出正常 | 
| 【特性回合】支持外设分区管理| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在 | 
| 【特性回合】【软实时OS】支持Jailhouse虚拟化底座| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 支持Jailhouse运行，可以通过Jailhouse进行虚拟化操作 | 
| 【特性回合】【软实时OS】支持1款X86工控芯片| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 编译x86镜像，安装到对应硬件，在硬件上进行基础测试 | 
| 【特性回合】【软实时OS】支持瑞芯微RK3568J| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 编译RK3568J镜像，安装到对应硬件，在硬件上进行基础测试 | 
| 【特性回合】【软实时OS】基于RH2288云化PLC硬件，优化RT补丁| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 编译RH2288镜像，测试RT补丁性能情况 | 
| 【特性回合】【软实时OS】协议优化，提升流式数据和文件传输效率| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效 | 
| 【特性回合】【软实时OS】支持树莓派蓝牙| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现 | 
| 【特性回合】【软实时OS】支持软总线支持ble发现| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 通过编程调用蓝牙发现接口，可发现自动发现对端设备 | 
| 【特性回合】【软实时OS】引入Meta-ROS| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 测试Meta-ROS编译，能够正常启动 | 
| 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL C接口共计178个（所有pthread和time接口）| sig-embedded/sig-yocto| sig-embedded/sig-yocto| 通过posix suite相关接口测试 | 

继承需求分工如下：

| **需求**                     | **开发主体**      | **测试主体**      | **测试策略**                                                 |
| ---------------------------- | ----------------- | ----------------- | ------------------------------------------------------------ |
| 基于Linux 5.10内核提供软实时能力 | sig-embedded/sig-yocto| sig-embedded/sig-yocto| 继承已有测试能力，通过cyclictest进行测试软实时能力 |
| 实现soc内实时和非实时多平面混合部署 | sig-embedded/sig-yocto| sig-embedded/sig-yocto| 继承已有测试能力，在qemu上启动混合部署  |
| 开放基于Yocto构建包的小型化定制裁剪能力  | sig-embedded/sig-yocto| sig-embedded/sig-yocto| 继承已有测试能力，使用yocto构建出不同系统 |
| 基于社区10.3版本gcc提供ARM版本交叉编译工具链 | sig-embedded/sig-yocto| sig-embedded/sig-yocto | 继承已有测试能力，使用交叉编译工具链进行测试用例编译 |
| 支持树莓派4B作为嵌入式通用硬件 | sig-embedded/sig-yocto| sig-embedded/sig-yocto| 继承已有测试能力，使用树莓派进行测试 |
| 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 | sig-embedded/sig-yocto| sig-embedded/sig-yocto | 继承已有测试能力，测试分布式软总线接口，以及openEuler设备间互联互通 |
| 实时非实时系统混合部署支持树莓派 | sig-embedded/sig-yocto| sig-embedded/sig-yocto | 继承已有测试能力，在树莓派上启动混合部署，调用串口/SHELL服务来进行混合部署间的调用和通信，混合部署生命周期管理 |
| 分布式软总线生态互通互联  | sig-embedded/sig-yocto| sig-embedded/sig-yocto | 继承已有测试能力，测试分布式软总线接口，以及与openharmony设备间互联互通 |
| 硬实时uniProton支持南向开发板  | sig-embedded/sig-yocto| sig-embedded/sig-yocto | 继承已有测试能力，可编译对应支持的uniproton镜像 |
| 硬实时uniProton支持混合部署  | sig-embedded/sig-yocto| sig-embedded/sig-yocto | 继承已有测试能力，可编译对应支持的uniproton镜像，并在树莓派启动对应混合部署 |
| 硬实时uniProton支持POSIX接口 | sig-embedded/sig-yocto| sig-embedded/sig-yocto | 继承已有测试能力，测试通过适配开源posix测试套测试支持的posix接口 |

# 3   版本概要测试结论

openEuler 22.03 LTS SP2 embedded版本整体测试按照release-manager团队的计划，共完成了一轮基础功能测试+一轮全量特性测试+一轮全量测试+两轮回归测试；

其中一轮基础功能测试聚焦在linux系统调用、glibc和基础软件包功能的自动化验证，旨在识别阻塞性问题；一轮全量特性测试开展对版本交付的所有特性的功能验证；全量测试除基础功能以及新特性的又一轮测试，还涵盖安全、可靠性以及性能等dfx能力测试、继承需求测试以及资料测试；最后两轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；

版本按照测试策略完成了全量功能验证和专项测试(性能、可靠性、兼容性、安全)，所有测试预计发布前按计划完成。本版本计划交付需求11个，实际交付11个，交付率100%，所有发布需求均验证通过。

​openEuler 22.03 LTS SP2 embedded版本共发现问题50个，修复问题49个，待修复0个，1个非问题，缺陷收敛，版本整体质量较好。

# 4   版本详细测试结论

22.03 LTS SP2 embedded版本详细测试内容包括：

1. 完成基础OS质量保障，包括内核、系统调用、glibc以及基础软件包的功能测试，测试功能正常，问题已跟踪闭环；
2. 对关键特性，如软实时能力、分布式软总线、硬实时posix接口、meta-ros能力，x86设备支持等进行了专项测试，关键特性符合要求，测试功能正常，问题已跟踪闭环；
3. 其他专项测试包括安全专项、兼容性测试以及可靠性测试，完成各项专项测试，测试正常，问题已跟踪闭环；
4. 软实时能力、基础软件包支持等22.03 LTS、22.03 LTS SP1继承需求也进行了测试，测试功能正常，问题已跟踪闭环；

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                             |        特性质量评估        | 备注                                                                                                                   |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
| 1| 集成openEuler社区软实时补丁  | <font color=green>█</font> | 测试镜像使用：raspberrypi4-64 |
| 2 | 实现soc内实时和非实时多平面混合部署  | <font color=green>█</font> | 测试镜像使用：aarch64-qemu、raspberrypi4-64 |
| 3 | 开放基于Yocto构建包的小型化定制裁剪能力  | <font color=green>█</font> |  |
| 4 | 基于社区10.3版本gcc提供ARM版本交叉编译工具链  | <font color=green>█</font> | 测试镜像使用：aarch64-qemu、raspberrypi4-64、arm32-qemu |
| 5 | 支持树莓派4B作为嵌入式通用硬件  | <font color=green>█</font> | 测试镜像使用：raspberrypi4-64 |
| 6 | 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通  | <font color=green>█</font> | 测试镜像使用：raspberrypi4-64-rt |
| 7 | 基于分布式软总线扩展生态互通 | <font color=green>█</font> | 测试镜像使用：raspberrypi4-64 |
| 8 | 提供混合关键部署技术 | <font color=green>█</font> | 测试镜像使用：raspberrypi4-64 |
| 9 | 硬实时uniProton支持南向开发板 | <font color=green>█</font> |  | 
| 10 | 硬实时uniProton支持混合部署 | <font color=green>█</font> |  | 
| 11 | 硬实时uniProton支持POSIX接口 | <font color=green>█</font> |  | 

基础测试测试镜像使用：raspberrypi4-64、aarch64-qemu、arm32-qemu

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称**                 | **测试覆盖情况**                                             | **约束依赖说明** | **遗留问题单** | **质量评估**               | **备注<img width=50/>**                                      |
| -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1 | 【特性回合】在RK3568J基于OpenAMP支持openEuler EM+RT-Thread| 基于RK3568J硬件的混合部署，嵌入式linux启动后，可启动RT-Thread，RT-Thread demo输出正常 | 硬件RK3568 |  | <font color=green>█</font> | [报告](https://gitee.com/openeuler/QA/pulls/483) |
| 2 | 【特性回合】支持外设分区管理|  测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在 |   |  |<font color=green>█</font> | 测试镜像使用：aarch64-qemu |
| 3 | 【特性回合】【软实时OS】支持Jailhouse虚拟化底座|  支持Jailhouse运行，可以通过Jailhouse进行虚拟化操作 |  |  |<font color=green>█</font> | 测试镜像使用：aarch64-qemu、raspberrypi4-64, [报告](https://gitee.com/openeuler/QA/pulls/471) |
| 4 | 【特性回合】【软实时OS】支持1款X86工控芯片|  编译x86镜像，安装到对应硬件，在硬件上进行基础测试 |   |  |<font color=green>█</font> | 测试镜像使用：x86-64-qemu |
| 5 | 【特性回合】【软实时OS】支持瑞芯微RK3568J|  编译RK3568J镜像，安装到对应硬件，在硬件上进行基础测试 | |  |<font color=green>█</font> | [报告](https://gitee.com/openeuler/QA/pulls/483) |
| 6 | 【特性回合】【软实时OS】基于RH2288云化PLC硬件，优化RT补丁|  编译RH2288镜像，测试RT补丁性能情况 | |  |<font color=green>█</font> | 测试镜像使用：x86-64-rt |
| 7 | 【特性回合】【软实时OS】协议优化，提升流式数据和文件传输效率|  测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效 |  |  |<font color=green>█</font> | 测试镜像使用：aarch64-qemu |
| 8 | 【特性回合】【软实时OS】支持树莓派蓝牙|  启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现 |  |  |<font color=green>█</font> | 测试镜像使用：raspberrypi4-64 |
| 9 | 【特性回合】【软实时OS】支持软总线支持ble发现|  通过编程调用蓝牙发现接口，可发现自动发现对端设备 | 通过编程调用蓝牙发现接口，可发现自动发现对端设备 |  |<font color=green>█</font> | 测试镜像使用：raspberrypi4-64 |
| 10 | 【特性回合】【软实时OS】引入Meta-ROS|  测试Meta-ROS编译，能够正常启动 |  |  |<font color=green>█</font> | 测试镜像使用：aarch64-qemu-ros、aarch64-qemu-ros |
| 11 | 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL C接口共计178个（所有pthread和time接口）|  通过posix suite相关接口测试 |    STM32F407单板| |<font color=green>█</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

嵌入式版本升级均需要重新烧写，不存在兼容新问题

### 4.2.2   南向兼容性

南向兼容性仅对树莓派4B进行测试

下表列出版本集成验证中涉及的硬件整机信息：

| 硬件型号              | 硬件详细信息                                                                                          |
| --------------------- | ----------------------------------------------------------------------------------------------------- |
| 树莓派4B卡             | CPU:BCM2711(Cortex-A72 * 4) <br />内存：4GB/8GB <br />存储设备：SanDisk Ultra 64GB micro SD |        |


### 4.2.3   北向兼容性

已测试继承自openEuler 22.03 LTS embedded版本的17个重点软件包，测试通过，满足嵌入式北向兼容性要求

## 4.3   专项测试结论

### 安全测试

整体安全测试覆盖：

1、Linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试，未发现问题。

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/编译选项扫描/交付件病毒扫描，发现CVE漏洞153个，其中151个为社区已有修复结论漏洞，2个为新增漏洞，已提交社区issue，已完成修复，端口仅开启22(ssh)端口，编译选项扫描完成符合社区要求，交付件无病毒。

3、针对安全加固指南中的加固项，进行全量测试，未发现问题。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型     | 测试内容                                                                               | 测试结论                   |
| ------------ | -------------------------------------------------------------------------------------- | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP测试用例(包括通用用例、内存、系统调用、cgroup、文件系统等)；过程中关注系统重要进程/服务、日志的运行情况； | 7 * 24  |

### 性能测试

| **指标大项** | **指标小项** | **指标值** | **测试结论** |
| ------------- | ------------------------------------------------------------ | --------------------------------- | -------------------- |
| OS基础性能 | UnixBench除C编译外测试内容 | 无 | 总体与基线持平，与基线持平无下降 |
| 软实时补丁性能 | cyclictest空载及压力负载 | 无 | x86性能为首次形成基线，aarch64软实时性能与基线持平无下降 |
| 硬实时系统性能 | 适配后的RhealStone用例测试 | 参考22.09版本相应指标基线 | 上下文切换时延2us，中断时延1us，与基线持平无下降 |

### 资料测试

| **手册名称**       | **测试内容**                                                           | **测试结论** |
|------------------------------|------------------------------------------------------------------------|--------------------|
|《openEuler Embedded 快速上手》 | 获取镜像、运行镜像、基于SDK的应用开发 | 验收通过   |
|《openEuler Embedded 构建系统》 | 快速构建、Yocto介绍、新增软件包指导 | 验收通过   |
|《openEuler Embedded 关键特性》 | 混合部署、分布式软总线、树莓派系统 | 验收通过 |
|《openEuler UniProton用户指南》 | UniProton功能设计、接口说明 | 验收通过 |

# 5   问题单统计

openEuler 22.03 LTS SP2 embedded版本共发现问题单41个，其中修复问题单39个，待修复2个，回归均通过。详细分布见下表:

| 测试阶段                    | 问题单数 |
| --------------------------- | -------- |
| openEuler embedded 22.03 LTS SP2 RC1 | 9   | 
| openEuler embedded 22.03 LTS SP2 RC2 | 31  | 
| openEuler embedded 22.03 LTS SP2 RC3 | 8   | 
| openEuler embedded 22.03 LTS SP2 RC4 | 2   | 
| openEuler embedded 22.03 LTS SP2 RC5 | -   | 

1、RC1为操作系统基础测试，主要聚焦于操作系统的基础功能，发现问题数较少，问题主要集中于工程构建以及结果文件命名等问题；

2、RC2为全量转测特性测试及安全、性能、稳定性测试，发现较多硬实时posix接口问题，嵌入式linux发现少量问题；

3、RC3进行了特性的全量测试SP2作为LTS版本的升级版本安全、性能、稳定性较好，发现问题主要集中在由于软件版本升级导致的差异产生的问题；

4、RC4为回归测试，主要对前面几轮发现的问题进行了回归测试，尚未开始测试

5、RC5为回归测试，主要对前面几轮发现的问题进行了回归测试，尚未开始测试


# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述                                                     | 问题级别 | 影响分析                                                     | 规避措施 |
| ---- | -------- | ------------------------------------------------------------ | -------- | ------------------------------------------------------------ | -------- |

# 致谢
非常感谢以下开发者在openEuler 23.03 版本测试中做出的贡献,以下排名不分先后
- [s_c_c](xxxx)
- [saarloos](xxxx)
- [asdfiic](https://gitee.com/asdfiic)
- [peng2285](https://gitee.com/peng2285)
- [shenzhen_xuwei](xxxx)
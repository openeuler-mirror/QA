![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2023/12/21 | 1.0.0    | 初稿, 基于RC1/2/3 | saarloos |


关键词：

openEuler raspberrypi 

摘要：

文本主要描述openEuler 22.03 LTS SP3 embedded版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |


# 1   概述

openEuler Embedded是基于openEuler社区面向嵌入式场景的Linux版本。当前openEuler内核源于Linux实现软实时能力，同时具备soc内多平面混合部署，开放基于Yocto构建包的小型化定制裁剪能力，支持openHarmony分布式软总线，同时嵌入式提供了非Linux内核的硬实时能力，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统。

本文主要描述openEuler 22.03 LTS SP3 embedded版本的总体测试情况，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

# 2   测试版本说明

openEuler 22.03 LTS SP3 是基于5.10内核22.03-LTS的增强扩展版本，面向嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 22.03 LTS SP2分支拉出，发布范围相较22.03 LTS SP2版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP3/openEuler-22.03-LTS-SP3%20%E5%8D%87%E7%BA%A7%E9%80%89%E5%9E%8B.md)
2.  修复bug和cve
3.  UniProton完成文件系统和网络框架移植
4.  社区ZVM底座对接嵌入式Linux
5.  嵌入式Linux支持isula镜像
6.  嵌入式Linux支持RK3588
7.  嵌入式Linux支持全志A40i

## 2.1 版本测试计划
openEuler 22.03 LTS SP3 版本按照社区release-manager团队的计划，共规划6轮测试，详细的版本信息和测试时间如下表：

|版本名称 |测试起始时间|测试结束时间|天数|备注|
|:----------|:---------|:-------|:---------|:-------|
| Alpha   | 2023/11/23 | 2023/12/01 | 7    | 拉SP3分支, 构建准备 |
| Test round 1           | 2023/12/2  | 2023/12/8  | 7    | 继承特性、性能摸底测试|
| Test round 2           | 2023/12/9  | 2023/12/15 | 7    | 全量SIT验证|
| Test round 3           | 2023/12/16 | 2023/12/22 | 7    | 全量SIT验证试   |
| Test round 4           | 2023/12/23 | 2023/12/27 | 7    | 回归测试   |
| Test round 5           | 2023/12/28 | 2023/12/29 | 7    | 回归测试   |
| Release                | 2023/12/30 | 2023/12/30 | 1    | 社区Release版本发布评审|


## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| 树莓派 4B              | BCM2711                                  | 嵌入式Linux版本测试 |
| STM32F407ZGT6开发板    | CPU:STM32F407ZG(168MHz)                  | UniProton测试 |
| 工控机HVAEIPC-M10 | CPU:Intel i7-10510U| 用于测试x86镜像编译结果，rt补丁需求 |
| OK3588 | CPU: RK3588 | 用于RK3588相关需求测试 |

## 2.3 需求清单

openEuler 22.03 LTS SP3版本交付需求列表如下，详情见[openEuler-22.03-LTS-SP3 release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP3/release-plan.md)：

| no   | feature                                                      | status   | sig                          | owner                                                        | 发布方式         | 备注                                        |
| ---- | ------------------------------------------------------------ | -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | ------------------------------------------- |
| [I8I4ZL](https://gitee.com/openeuler/release-management/issues/I8I4ZL)  | 【硬实时】完成文件系统和网络框架移植 | Accepted | sig-embedded | [@saarloos](https://gitee.com/saarloos) | 源码 |  |
| [I8I52T](https://gitee.com/openeuler/release-management/issues/I8I52T)  | 【软实时OS】社区ZVM底座对接嵌入式 | Accepted | sig-embedded | [@fanglinxu](https://gitee.com/fanglinxu) | 源码 |  |
| [I8I535](https://gitee.com/openeuler/release-management/issues/I8I535)  | 【软实时OS】【特性回合】支持isula镜像 | Accepted | sig-embedded | [@fanglinxu](https://gitee.com/fanglinxu) | 源码 |  |
| [I8I53J](https://gitee.com/openeuler/release-management/issues/I8I53J) | 【软实时OS】【特性回合】支持RK3588  | Accepted | sig-embedded | [@emancipator](https://gitee.com/emancipator) | 源码 |  |
| [I8I55T](https://gitee.com/openeuler/release-management/issues/I8I55T)  | 【软实时OS】支持全志A40i | Accepted | sig-embedded | [@emancipator](https://gitee.com/emancipator) | 源码 |  |

> 当前社区release分为以下几种方式: 标准 ISO/everything ISO/EPOL/独立镜像/ 独立发布
>
> 独立发布：不随openEuler版本发布，交付件不在repo.openeuler.org发布
> 独立镜像：随openEuler版本发布，交付件为非ISO、RPM的其余形式镜像

## 2.4 测试活动分工
 本次版本继承测试活动分工如下：

| **需求**                                  | **开发主体**                 | **测试主体**                 | **测试分层策略**                                             |
| ----------------------------------------- | ---------------------------- | ---------------------------- | ------------------------------------------------------------ |
| [I8I4ZL](https://gitee.com/openeuler/release-management/issues/I8I4ZL) 【硬实时】完成文件系统和网络框架移植 | 验证文件系统接口，验证网络框架接口 | sig-embedded | sig-embedded | 
|[I8I52T](https://gitee.com/openeuler/release-management/issues/I8I52T) 【软实时OS】社区ZVM底座对接嵌入式 | 验证ZVM底座可启动openEuler嵌入式系统 | sig-embedded | sig-embedded | 
|[I8I535](https://gitee.com/openeuler/release-management/issues/I8I535)  【软实时OS】【特性回合】支持isula镜像 | 验证openEuler嵌入式系统isula可用性，使用openEuler发布的docker镜像进行测试 | sig-embedded | sig-embedded | 
|[I8I53J](https://gitee.com/openeuler/release-management/issues/I8I53J) 【软实时OS】【特性回合】支持RK3588 | 验证RK3588镜像编译及可用性 | sig-embedded | sig-embedded | 
|[I8I55T](https://gitee.com/openeuler/release-management/issues/I8I55T) 【软实时OS】支持全志A40i |  验证全志A40i镜像编译及可用性 | sig-embedded | sig-embedded |

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试



# 3 版本概要测试结论

   openEuler 22.03 LTS SP3 embedded版本整体测试按照release-manager团队的计划，1轮基础测试 + 2轮全量测试 + 2轮回归测试；第1轮主要测试操作系统的基础功能，如LTP、POSIX、基础软件和命令，SDK的使用以及继承需求的测试等；第2、3轮全量测试开展版本交付的所有特性和各类专项测试；第4、5轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；

   openEuler 22.03 LTS SP3 embedded版本共发现问题 21 个，有效问题 19 个，无效问题 3 个。遗留问题 0 个(详见遗留问题章节)。版本整体质量良好。



# 4 版本详细测试结论

22.03 LTS SP2 embedded版本详细测试内容包括：

1. 完成基础OS质量保障，包括内核、系统调用、glibc以及基础软件包的功能测试，测试功能正常，问题已跟踪闭环；
2. 对关键特性，如软实时能力、分布式软总线、硬实时posix接口、meta-ros能力，x86设备支持等进行了专项测试，关键特性符合要求，测试功能正常，问题已跟踪闭环；
3. 其他专项测试包括安全专项、兼容性测试以及可靠性测试，完成各项专项测试，测试正常，问题已跟踪闭环；
4. 软实时能力、基础软件包支持等22.03 LTS、22.03 LTS SP1、22.03 LTS SP3继承需求也进行了测试，测试功能正常，问题已跟踪闭环；

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                             |        特性质量评估        | 备注                                                         |
| ---- | ----------------------------------------- | :------------------------: | ------------------------------------------------------------ |
| 1 | 基于Linux 5.10内核提供软实时能力 | 继承已有测试能力，通过cyclictest进行测试软实时能力 |<font color=green>█</font> | |
| 2 | 实现soc内实时和非实时多平面混合部署 | 继承已有测试能力，在qemu上启动混合部署  |<font color=green>█</font> | |
| 3 | 开放基于Yocto构建包的小型化定制裁剪能力  | 继承已有测试能力，使用yocto构建出不同系统 |<font color=green>█</font> | |
| 4 | 基于社区10.3版本gcc提供ARM版本交叉编译工具链  | 继承已有测试能力，使用交叉编译工具链进行测试用例编译 |<font color=green>█</font> | |
| 5 | 支持树莓派4B作为嵌入式通用硬件 | 继承已有测试能力，使用树莓派进行测试 |<font color=green>█</font> | |
| 6 | 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通 | 继承已有测试能力，测试分布式软总线接口，以及openEuler设备间互联互通 |<font color=green>█</font> | |
| 7 | 实时非实时系统混合部署支持树莓派 | 继承已有测试能力，在树莓派上启动混合部署，调用串口/SHELL服务来进行混合部署间的调用和通信，混合部署生命周期管理 |<font color=green>█</font> | |
| 8 | 分布式软总线生态互通互联  | 继承已有测试能力，测试分布式软总线接口，以及与openharmony设备间互联互通 |<font color=green>█</font> | |
| 9 | 硬实时uniProton支持南向开发板  | 继承已有测试能力，可编译对应支持的uniproton镜像 |<font color=green>█</font> | |
| 10 | 硬实时uniProton支持混合部署  | 继承已有测试能力，可编译对应支持的uniproton镜像，并在树莓派启动对应混合部署 |<font color=green>█</font> | |
| 11 | 硬实时uniProton支持POSIX接口 | 继承已有测试能力，测试通过适配开源posix测试套测试支持的posix接口 |<font color=green>█</font> | |
| 12 | 【特性回合】在RK3568J基于OpenAMP支持openEuler EM+RT-Thread| 继承已有测试能力，测试编译镜像能力 |<font color=green>█</font> | |
| 13 | 【特性回合】支持外设分区管理|  继承已有测试能力，测试分区管理功能，配置好后，启动linux检查分配给硬实时的硬件是否存在 |  <font color=green>█</font> | |
| 14 |【特性回合】【软实时OS】支持Jailhouse虚拟化底座|  继承已有测试能力，支持Jailhouse运行，可以通过Jailhouse进行虚拟化操作 | <font color=green>█</font> | |
| 15 | 【特性回合】【软实时OS】支持1款X86工控芯片|  继承已有测试能力，编译x86镜像，安装到对应硬件，在硬件上进行基础测试 | <font color=green>█</font> | |
| 16 | 【特性回合】【软实时OS】支持瑞芯微RK3568J|  继承已有测试能力，编译RK3568J镜像 | <font color=green>█</font> | |
| 17 | 【特性回合】【软实时OS】基于RH2288云化PLC硬件，优化RT补丁|  继承已有测试能力，测试X86镜像的软实时性能 |<font color=green>█</font> | |
| 18 |【特性回合】【软实时OS】协议优化，提升流式数据和文件传输效率|  继承已有测试能力，测试流数据和文件传输，对比软总线字符和字节传输性能持平，在网络情况不好的情况下更加高效 | <font color=green>█</font> | |
| 19 | 【特性回合】【软实时OS】支持树莓派蓝牙|  继承已有测试能力，启动系统后可查看到蓝牙设备，并被其他蓝牙设备发现 | <font color=green>█</font> | |
| 20 | 【特性回合】【软实时OS】支持软总线支持ble发现|  继承已有测试能力，通过编程调用蓝牙发现接口，可发现自动发现对端设备 | <font color=green>█</font> | |
| 21 | 【特性回合】【软实时OS】引入Meta-ROS|  继承已有测试能力，测试Meta-ROS编译，能够正常启动 | <font color=green>█</font> | |
| 22 | 【硬实时OS】【UniProton】【基础中间件移植】移植完成MUSL C接口共计178个（所有pthread和time接口）|  继承已有测试能力，通过posix suite相关接口测试 | <font color=green>█</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **质量评估**    | **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | -------- |
| [I8I4ZL](https://gitee.com/openeuler/release-management/issues/I8I4ZL) |【硬实时】完成文件系统和网络框架移植 | 重点测试接口可用性，对外统一使用posix接口，测试相关接口的可用性 | 底层驱动需要注册或通过打桩的方式进行测试 |  | <font color=green>█</font> |  |
|[I8I52T](https://gitee.com/openeuler/release-management/issues/I8I52T) | 【软实时OS】社区ZVM底座对接嵌入式 | ZVM拉起openEuler嵌入式 |  |  | <font color=green>█</font> |  |
|[I8I535](https://gitee.com/openeuler/release-management/issues/I8I535) | 【软实时OS】【特性回合】支持isula镜像 | 测试isula镜像启动，拉起后容器可正常使用 |  |  | <font color=green>█</font> |  |
|[I8I53J](https://gitee.com/openeuler/release-management/issues/I8I53J) |【软实时OS】【特性回合】支持RK3588 | 镜像编译、基础功能 |   |  | <font color=green>█</font> |  |
|[I8I55T](https://gitee.com/openeuler/release-management/issues/I8I55T)  | 【软实时OS】支持全志A40i | 镜像编译、基础功能 |   |  | <font color=green>█</font> |  |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好



## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

嵌入式采用重新烧录的方式进行升级，不涉及兼容性测试

### 4.2.2   南向兼容性

南向兼容性对树莓派4B/X86设备进行测试

下表列出版本集成验证中涉及的硬件整机信息：

| 硬件型号              | 硬件详细信息                                                                                          |
| --------------------- | ----------------------------------------------------------------------------------------------------- |
| 树莓派4B卡             | CPU:BCM2711(Cortex-A72 * 4) <br />内存：4GB/8GB <br />存储设备：SanDisk Ultra 64GB micro SD   |
| 工控机HVAEIPC-M10 | CPU:Intel i7-10510U|

### 4.2.3   虚拟机兼容性

嵌入式不涉及

## 4.3   专项测试结论

### 4.3.1 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。整体安全测试需要覆盖：

1.  linux系统安全配置/权限管理等

2.  特性涉及到的安全需求验证

3.  CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

| 测试类         | 描述                      | 具体测试内容                                                 |
| :------------- | ------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | CVE扫描/敏感信息/编译选项 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全配置管理类 | Linux安全规范             | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试 |

### 4.3.2 可靠性测试

| 测试类型     | 测试内容                                                                               | 测试结论                   |
| ------------ | -------------------------------------------------------------------------------------- | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP测试用例(包括通用用例、内存、系统调用、cgroup、文件系统等)；过程中关注系统重要进程/服务、日志的运行情况； | 7 * 24  |

### 4.3.3 性能测试

| **指标大项** | **指标小项**                                                 | **指标值**                        | **测试结论**     |
| ------------ | ------------------------------------------------------------ | --------------------------------- | ---------------- |
| OS基础性能 | UnixBench除C编译外测试内容 | openEUler 22.03 LTS SP2基线 |  |
| 软实时补丁性能 | cyclictest空载及压力负载 | openEUler 22.03 LTS SP2基线 | x86、aarch64软实时性能与基线持平无下降 |
| 硬实时系统性能 | 适配后的RhealStone用例测试 | 参考22.09版本相应指标基线 | 上下文切换时延2us，中断时延1us，与基线持平无下降 |



# 5   问题单统计

openEuler 22.03 LTS SP3 版本共发现问题 21 个，有效问题 19 个，其中遗留问题 0 个。详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注        |
| --------------------------- | -------- | ------------ | ------------ | ------------ | -------------------------- |
| openEuler 22.03 LTS SP3 RC1   | 5   | 5     | 0      | 0      | Beta轮次  |
| openEuler 22.03 LTS SP3 RC2   | 9    | 8      | 1      | 0      | 全量集成 |
| openEuler 22.03 LTS SP3 RC3   | 7    | 5      | 2      | 0      | 全量集成  |
| openEuler 22.03 LTS SP3 RC4   |      |        |       |       | 回归测试    |
| openEuler 22.03 LTS SP3 RC5   |       |         |        |        | 版本发布验收测试(回归测试) |



# 6 版本测试过程评估

#### 6.1 问题单分析

SP3嵌入式版本因从22.03 LTS到SP1、SP2、2303、2309多个版本测试，SP3版本整体问题较少，主要为扫描类、构建类问题，构建问题主要因为构建方式变更需要定义manifest文件，部分镜像在迁移时用到的软件没有增加导致构建失败。

# 6   附件

## 遗留问题列表

| 序号 | 问题单号                                                     | 问题简述                                                    | 问题级别 | 影响分析                                                     | 规避措施                                                     | 历史发现场景                                                 |
| ---- | ------------------------------------------------------------ | ----------------------------------------------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |



# 致谢
非常感谢以下开发者在openEuler 22.03 LTS SP3 版本测试中做出的贡献,以下排名不分先后
- [s_c_c](xxxx)
- [saarloos](xxxx)
- [shenzhen_xuwei](xxxx)
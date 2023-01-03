![avatar](../../images/openEuler.png)


版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ------------------ | ---------- |
| 2022/12/19 | 1.0.0    | 初始               | saarloos |
|  |     |      |   |

关键词：

openEuler LTS SP1 embedded  分布式软总线 混合部署 软实时 

摘要：

文本主要描述openEuler 22.03-LTS-SP1 embedded版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语      | 英文全名                             | 中文解释       |
| ----------- | ------------------------------------ | -------------- |
| OS          | Operating System                     | 操作系统       |
| LTS         | Long Time Support                    | 长时间维护     |
| CVE         | Common Vulnerabilities and Exposures | 通用漏洞批露   |
| QEMU        | quick emulator                       | 通用和开源的机器仿真器和虚拟器 |

---

\***

# 1   概述

openEuler Embedded是基于openEuler社区面向嵌入式场景的Linux版本。当前openEuler内核源于Linux实现软实时能力，同时具备soc内多平面混合部署，开放基于Yocto构建包的小型化定制裁剪能力，支持openHarmony分布式软总线，同时嵌入式提供了非Linux内核的硬实时能力，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统。

本文主要描述openEuler 22.03 LTS SP1 embedded版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

# 2   测试版本说明

openEuler 22.03 LTS SP1 embedded版本是基于5.10内核22.03-LTS的增强扩展版本，面向嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 22.03 LTS-Next分支拉出，发布范围相较22.03 LTS embedded版本主要变动：

1.  软件版本选型升级，详情请见版本变更说明
2.  修复bug和cve
3.  新增支持：分布式软总线与openHarmony互联互通；混合部署支持在树莓派硬件；硬实时能力新增STM32F407ZGT6开发板支持，支持混合部署及基础POSIX接口

openEuler 22.03 LTS SP1 embedded版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动，详细的版本信息和测试时间如下表：
| 版本名称                    | 测试起始时间 | 测试结束时间 |
| --------------------------- | ------------ | ------------ |
| openEuler embedded 22.03 LTS SP1 RC1 | 2022/12/01  | 2022/12/04   |
| openEuler embedded 22.03 LTS SP1 RC2 | 2022/12/05  | 2022/12/11   |
| openEuler embedded 22.03 LTS SP1 RC3 | 2022/12/12  | 2022/12/16   |
| openEuler embedded 22.03 LTS SP1 RC4 | 2022/12/17  | 2022/12/20   |
| openEuler embedded 22.03 LTS SP1 RC5 | 2022/12/20  | 2022/12/23   |

测试的硬件环境如下：

| 硬件型号                            | 硬件配置信息                                                 | 备注                      |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------- |
| 树莓派4B卡                     | CPU:BCM2711(Cortex-A72 * 4) <br />内存：4GB/8GB <br />存储设备：SanDisk Ultra 64GB micro SD |        |
| QEMU                          | CPU:Cortex-A15/A57 <br /> 最小启动内存：512M |        |
| STM32F407ZGT6开发板 | CPU:STM32F407ZG(168MHz) <br />内存: 192+4 KB<br />FLASH: 1MB | |


openEuler 22.03 LTS SP1 embedded版本交付需求列表如下：

| **no** | **feature**                                                  | **status** | **sig**                 | **owner**                                      |
| ------ | ------------------------------------------------------------ | ---------- | ----------------------- | ---------------------------------------------- |
| [I5Y1K3](https://gitee.com/openeuler/release-management/issues/I5Y1K3) <br>  [I5YJ4V](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I5YJ4V) | 基于分布式软总线扩展生态互通 | Accepted |sig-Yocto |sig-Yocto |
| [I5Y1J1](https://gitee.com/openeuler/release-management/issues/I5Y1J1) <br>  [I5YJ58](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I5YJ58) | 提供混合关键部署技术 | Accepted |sig-Yocto |sig-Yocto  |
| [I5YINT](https://gitee.com/openeuler/UniProton/issues/I5YINT) | 硬实时uniProton支持南向开发板 | Discussion |sig-embedded | sig-embedded | 
| [I5YIOS](https://gitee.com/openeuler/UniProton/issues/I5YIOS) | 硬实时uniProton支持混合部署 | Accepted |sig-embedded | sig-embedded | 
| [I5YIQW](https://gitee.com/openeuler/UniProton/issues/I5YIQW) | 硬实时uniProton支持POSIX接口 | Accepted |sig-embedded | sig-embedded | 

继承需求如下：
| **no** | **feature**                                                  | **sig**                 | **owner**                                      |
| ------ | ------------------------------------------------------------ | ----------------------- | ---------------------------------------------- |
| [I4YMW9](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I4YMW9) | 集成openEuler社区软实时补丁  | sig-yocto | @Wanming Hu |
| [I4YMUM](https://gitee.com/src-openeuler/OpenAMP/issues/I4YMUM) | 实现soc内实时和非实时多平面混合部署  | sig-embedded | @Wayne Ren @wilson |
| [I4YMUX](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I4YMUX) <br/> [I4Q7W7](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I4Q7W7) | 开放基于Yocto构建包的小型化定制裁剪能力  | sig-yocto | @ilisimin |
| [I4YMVX](https://gitee.com/src-openeuler/gcc-cross/issues/I4YMVX) | 基于社区10.3版本gcc提供ARM版本交叉编译工具链  | sig-compiler | @wangding16 |
| [I4YMV8](https://gitee.com/openeuler/yocto-meta-openeuler/issues/I4YMV8) | 支持树莓派4B作为嵌入式通用硬件  | sig-embedded | @liangfangping |
| [I4YMTP](https://gitee.com/openeuler/dsoftbus_standard/issues/I4YMTP) | 集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通  | sig-yocto | @beilingxie @zheng liming |

其中"实现soc内实时和非实时多平面混合部署"和"集成鸿蒙的分布式软总线，实现openEuler设备之间的互联互通"两个需求与新增的需求为增强关系，特性测试统一归属在新增需求中。

本次openEuler 22.03 LTS SP1 embedded版本测试活动分工如下：

| **需求**                     | **开发主体**      | **测试主体**      | **测试策略**                                                 |
| ---------------------------- | ----------------- | ----------------- | ------------------------------------------------------------ |
| 基于分布式软总线扩展生态互通     | sig-Yocto  | sig-Yocto  | 测试分布式软总线开放接口api，重点关注认证模块，验证与openHarmony的互相识别和通信 |
| 提供混合关键部署技术     | sig-Yocto  | sig-Yocto  | 测试混合关键部署技术开放接口api，测试整体串口/SHELL服务，混合部署生命周期管理以及在树莓派上的混合部署 |
| 硬实时uniProton支持南向开发板     | sig-embedded  | sig-embedded  | 测试uniPoton支持的南向开发板的编译、烧录以及任务执行 |
| 硬实时uniProton支持混合部署     | sig-embedded  | sig-embedded  | 在树莓派4B上使用混合部署框架混合部署框架进行生命周期管理测试，能够拉起、停止uniProton，uniProton任务执行正常 |
| 硬实时uniProton支持POSIX接口     | sig-embedded  | sig-embedded  | 使用业界通用开源POSIX测试套对POSIX接口进行测试 |

继承需求分工如下：

| **需求**                     | **开发主体**      | **测试主体**      | **测试策略**                                                 |
| ---------------------------- | ----------------- | ----------------- | ------------------------------------------------------------ |
| 集成openEuler社区软实时补丁 | sig-yocto | sig-Yocto| 基于树莓派4b使用业界benchmark（cyclictest）验证空载条件下平均调度时延微秒级 |
| 开放基于Yocto构建包的小型化定制裁剪能力 | sig-yocto | sig-yocto | 重点对yocto构建、裁剪以及相关资料进行验证，根据资料可构建出可自由配置裁剪软件包的基础文件系统|
| 基于社区10.3版本gcc提供ARM版本交叉编译工具链 | sig-compiler | sig-compiler | 针对交叉编译工具链的可用性进行验证 |
| 支持树莓派4B作为嵌入式通用硬件 | sig-yocto | sig-yocto | 通过构建指导能够生成在树莓派上部署使用的镜像 |

# 3   版本概要测试结论

openEuler 22.03 LTS SP1 embedded版本整体测试按照release-manager团队的计划，共完成了一轮基础功能测试+一轮新特性测试+一轮全量测试+一轮回归测试；

其中一轮基础功能测试聚焦在linux系统调用、glibc和基础软件包功能的自动化验证，旨在识别阻塞性问题；一轮新特性测试开展对版本交付的所有特性的功能验证；全量测试除基础功能以及新特性的又一轮测试，还涵盖安全、可靠性以及性能等dfx能力测试、继承需求测试以及资料测试；最后一轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；

版本按照测试策略完成了全量功能验证和专项测试(性能、可靠性、兼容性、安全)，所有测试预计发布前按计划完成。本版本计划交付需求5个，实际交付5个，交付率100%，所有发布需求均验证通过。

​openEuler 22.03 LTS SP1 embedded版本共发现问题39个，修复问题34个，5个非问题，缺陷收敛，版本整体质量较好。

# 4   版本详细测试结论

22.03 LTS SP1 embedded版本详细测试内容包括：

1. 完成基础OS质量保障，包括内核、系统调用、glibc以及基础软件包的功能测试，测试功能正常，问题已跟踪闭环；
2. 对关键特性，如软实时能力、分布式软总线、硬实时posix接口等进行了专项测试，关键特性符合要求，测试功能正常，问题已跟踪闭环；
3. 其他专项测试包括安全专项、兼容性测试以及可靠性测试，完成各项专项测试，测试正常，问题已跟踪闭环；
4. 软实时能力、基础软件包支持等22.03 LTS继承需求也进行了测试，测试功能正常，问题已跟踪闭环；

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                             |        特性质量评估        | 备注                                                                                                                   |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
| 1 | 已支持的重点软件包 | <font color=green>█</font> |  |
| 2 | 集成openEuler社区软实时补丁 | <font color=green>█</font> |  |
| 3 | 开放基于Yocto构建包的小型化定制裁剪能力 | <font color=green>█</font> |  |
| 4 | 基于社区10.3版本gcc提供ARM版本交叉编译工具链 | <font color=green>█</font> |  |
| 5 | 支持树莓派4B作为嵌入式通用硬件 | <font color=green>█</font> |  |

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称**                 | **测试覆盖情况**                                             | **约束依赖说明** | **遗留问题单** | **质量评估**               | **备注<img width=50/>**                                      |
| -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1 | 硬实时uniProton支持南向开发板 | 工程编译、资料、在开发板上的烧录和运行 | 支持硬件STM32F407ZGT6 | | <font color=green>█</font> | |
| 2 | 硬实时uniProton支持混合部署 | 在树莓派上的部署及uniProton的生命周期管理 | 在树莓派4B测试 | | <font color=green>█</font> | |
| 3 | 硬实时uniProton支持POSIX接口 | 测试POSIX标准对外接口 | 支持硬件STM32F407ZGT6 | | <font color=green>█</font> | |
| 4 | 基于分布式软总线扩展生态互通 | 测试分布式软总线开放接口api，重点关注认证模块，验证与openHarmony的互相识别和通信 |  | | <font color=green>█</font> | |
| 5 | 提供混合关键部署技术 | 测试混合关键部署技术开放接口api，测试整体串口/SHELL服务，混合部署生命周期管理以及在树莓派上的混合部署 |  | | <font color=green>█</font> | |

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

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/编译选项扫描/交付件病毒扫描，发现CVE漏洞126个，其中125个为社区已有修复结论漏洞，1个为新增漏洞，已提交社区issue，已完成修复，端口仅开启22(ssh)、68(dhcp client)端口，编译选项扫描完成符合社区要求，交付件无病毒。

3、针对安全加固指南中的加固项，进行全量测试，未发现问题。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型     | 测试内容                                                                               | 测试结论                   |
| ------------ | -------------------------------------------------------------------------------------- | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP测试用例(包括通用用例、内存、系统调用、cgroup、文件系统等)；过程中关注系统重要进程/服务、日志的运行情况； | 7 * 24 |

### 性能测试

| **指标大项** | **指标小项** | **指标值** | **测试结论** |
| ------------- | ------------------------------------------------------------ | --------------------------------- | -------------------- |
| OS基础性能 | UnixBench除C编译外测试内容 | 无 | 使用22.03 LTS SP1 embedded版本作为性能己先 |
| 软实时补丁性能 | cyclictest空载及压力负载 | 无 | 使用22.03 LTS SP1 embedded版本作为性能己先 |
| 硬实时系统性能 | 适配后的RhealStone用例测试 | 参考22.09版本相应指标基线 | 上下文切换时延2us，中断时延1us |

### 资料测试

| **手册名称**       | **测试内容**                                                           | **测试结论** |
|------------------------------|------------------------------------------------------------------------|--------------------|
|《openEuler Embedded 快速上手》 | 获取镜像、运行镜像、基于SDK的应用开发 | 验收通过   |
|《openEuler Embedded 构建系统》 | 快速构建、Yocto介绍、新增软件包指导 | 验收通过   |
|《openEuler Embedded 关键特性》 | 混合部署、分布式软总线、树莓派系统 | 验收通过 |
|《openEuler UniProton用户指南》 | UniProton功能设计、接口说明 | 验收通过 |

# 5   问题单统计

openEuler 22.03 LTS SP1 embedded版本共发现问题单39个，其中修复问题单34个，回归均通过。详细分布见下表:

| 测试阶段                    | 问题单数 |
| --------------------------- | -------- |
| openEuler embedded 22.03 LTS SP1 RC1 | 5   | 
| openEuler embedded 22.03 LTS SP1 RC2 | 27  | 
| openEuler embedded 22.03 LTS SP1 RC3 | 7   | 
| openEuler embedded 22.03 LTS SP1 RC4 | 0   | 
| openEuler embedded 22.03 LTS SP1 RC5 | 0   | 

1、RC1为操作系统基础测试，主要聚焦于操作系统的基础功能，发现问题数较少，问题主要集中于工程构建以及结果文件命名等问题；

2、RC2为新特性测试，主要聚焦与新特性的测试，发现较多硬实时posix接口问题，主要集中在与标准定义返回值或错误码不同的问题；

3、RC3进行了特性的全量测试及安全、性能、稳定性测试，SP1作为LTS版本的升级版本安全、性能、稳定性较好，发现问题主要集中在由于软件版本升级导致的差异产生的问题；

4、RC4为回归测试，主要对前面几轮发现的问题进行了回归测试，问题均修复，未发现新问题


# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述                                                     | 问题级别 | 影响分析                                                     | 规避措施 |
| ---- | -------- | ------------------------------------------------------------ | -------- | ------------------------------------------------------------ | -------- |

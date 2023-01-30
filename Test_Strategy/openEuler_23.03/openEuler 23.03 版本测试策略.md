![openEuler ico](../../images/openEuler.png)

版权所有 © 2023 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期       | 修订版本 | 修改  章节       | 修改描述               | 作者       |
| ---------- | -------- | ---------------- | ---------------------- | ---------- |
| 2023-2-2  | 1.0.0    |                  | 初稿                   | disnight |


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

本文是openEuler 23.03 版本的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 23.03版本的总体测l试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 23.03 是基于6.1内核的创新版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于master分支拉出，发布范围相较22.09版本主要变动：

1.  (*待补充*)软件版本选型升级，详情请见[版本变更说明]()
2.  (*待补充*)修复bug和cve
3.  (*待细化*)核心基础软件升级：kernel 5.10->6.1; openssl 1.1.1m->3.0.7

## 需求范围(*待release刷新后协同刷新，发布方式需要更新*)

openEuler 23.03 版本交付[需求列表](hhttps://gitee.com/openeuler/release-management/blob/master/openEuler-23.03/release-plan.md)如下：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|1|[【openEuler 23.03】新增高性能服务网格数据面Kmesh](https://gitee.com/openeuler/release-management/issues/I65S7M?from=project-issue)|Testing|sig-high-performance-network|@MrRlu|extras|kmesh|
|2|[【openEuler 23.03】新增内核配置项错误值检查工具kconfigDetector](https://gitee.com/openeuler/release-management/issues/I69YOZ?from=project-issue)|Testing|sig-kernel|@sunying2022|extras|kconfigDetector|
|3|[【openEuler 23.03】支持树莓派](https://gitee.com/openeuler/release-management/issues/I6AACH)|Discussion|sig-RaspberryPi|[@woqidaideshi](https://gitee.com/woqidaideshi)|EPOL|raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom|
|4|[【openEuler 23.03】GCC编译器插件框架支持LTO复杂优化，实现插件IR覆盖Gimple 80%的功能](https://e.gitee.com/open_euler/issues/table?issue=I6CK4F)|Discussion|Compiler|@wangding|oepkgs|GCC|
|5|[【openEuler 23.03】NFS客户端支持多路径](https://gitee.com/openeuler/kernel/issues/I6CR7Z)|Discussion|Kernel |@jiangzhongbing|oepkgs|Kernel|
|6|[【openEuler 23.03】openEuler 23.03 创新版本选择 6.1 内核](https://gitee.com/openeuler/kernel/issues/I6834I)|Testing|Kernel |@zhengzengkai|oepkgs|Kernel|
|7|[【openEuler 23.03】新增openGemini时序数据库](https://gitee.com/openeuler/release-management/issues/I6EQV3)|Testing|DB |@openGemini|ISO|Kernel|


# 风险

| 问题类型 | 问题描述 | 问题等级 | 应对措施 | 责任人 | 状态 |
| -------- | -------- | -------- | -------- | ------ | ---- |
|          |          |          |          |        |      |

# 测试分层策略(*基于继承特性策略刷新*)

本次23.03 创新版本的具体测试分层策略如下：

| **需求**         | **开发主体** | **测试主体** | **测试分层策略**         |
| --------------- | ----------- | ---------- | ----------------------- |
| 支持UKUI桌面     | sig-UKUI  | sig-UKUI  | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能 |
| 支持DDE桌面      | sig-DDE   | sig-DDE   | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持xfce桌面     | xfce  | xfce  | 验证xfce桌面系统在openEuler版本上的可安装和基本功能 |
| 支持GNOME桌面    | GNOME | GNOME | 验证gnome桌面系统在openEuler版本上的可安装和基本功能|
| 支持Kiran桌面    | sig-KIRAN-DESKTOP | sig-KIRAN-DESKTOP | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能 |
| 支持Cinnamon桌面 | sig-cinnamon | sig-cinnamon | 验证Cinnamon桌面系统在openEuler版本上的可安装和基本功能 |
| 支持南向兼容性    | sig-Compatibility-Infra | sig-QA | 验证openEuler版本在不同处理器上的可安装和可使用性，覆盖整机兼容性测试和社区集成测试 |
| 支持树莓派发布件  | sig-RaspberryPi | sig-RaspberryPi | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试 |
| 支持RISC-V      | sig-RISC-V | sig-RISC-V | 验证openEuler版本在RISV-V处理器上的可安装和可使用性 |
| 内核            | Kernel | Kernel | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | sig-CloudNative | sig-CloudNative | 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化           | Virt | Virt | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 编译器(gcc)  | Compiler | sig-QA | 基于开源测试套对gcc相关功能进行验证 |
| bishengjdk  | Compiler | sig-QA | 基于开源测试套对bishengjdk相关功能进行验证 |
| 支持HA软件       | sig-Ha | sig-Ha | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持KubeSphere  | sig-K8sDistro | sig-K8sDistro | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力  |
| 支持NestOS      | sig-CloudNative | sig-CloudNative | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 支持openGauss   | DB | DB | 验证openGauss数据库基础功能中接入层、SQL层、存储层、管理和安全等，另外从可靠性、性能、工具和兼容性四个维度覆盖生态测试 |
| 支持虚拟化热补丁libcareplus | Virt | Virt | 关注libcareplus提供Qemu热补丁能力 |
| 支持用户态协议栈gazelle     | sig-high-performance-network | sig-high-performance-network |关注gazelle高性能用户态协议栈功能  |
| 支持IO智能多流astream | Kernel | sig-QA | 验证通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命 | 
| 支持pkgship      | sig-EasyLife | sig-QA | 验证软件包依赖查询、生命周期管理、补丁查询等功能 | 
| 支持鲲鹏安全库     | sig-security-facility | sig-QA | 验证对鲲鹏安全库下的支持平台远程证明及TEE远程证明特性进行接口、功能测试 | 
| 支持基于分布式软总线扩展生态互联互通 | sig-embedded | sig-embedded | 验证openEuler和openHarmony设备进行设备认证，互通互联特性 | 
| 支持混合关键部署技术扩展 | sig-embedded | sig-embedded | 验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 支持硬实时系统    | sig-embedded | sig-embedded | 验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 | 
| 支持kubernetes  | sig-CloudNative | sig-CloudNative | 验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 安装部署         | sig-OS-Builder | sig-OS-Builder | 验证覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| 新增备份还原功能支持       | sig-Migration | sig-Migration | 验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常  |
| 新增ROS基础版和ROS2基础版  | sig-ROS | sig-ROS | 验证ROS基础版和ROS2基础版安装卸载以及基础功能正常 |





# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*             | *重点*          | *设计思路*        | *备注* |
| ----- | ---------------------- | --------------- | ---------------- | ------ |
|1|[【openEuler 23.03】新增高性能服务网格数据面Kmesh](https://gitee.com/openeuler/release-management/issues/I65S7M?from=project-issue)| *现**sig-high-performance-network**已提交测试策略PR，当前未合入* | | |
|2|[【openEuler 23.03】新增内核配置项错误值检查工具kconfigDetector](https://gitee.com/openeuler/release-management/issues/I69YOZ?from=project-issue)| [kconfigDetector特性测试策略](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_23.03/openEuler%2023.03%20%E7%89%88%E6%9C%ACkconfigDetector%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E7%AD%96%E7%95%A5.md) | | |
|3|[【openEuler 23.03】支持树莓派](https://gitee.com/openeuler/release-management/issues/I6AACH)| *待**sig-RaspberryPi**评审后补充* | | |
|4|[【openEuler 23.03】GCC编译器插件框架支持LTO复杂优化，实现插件IR覆盖Gimple 80%的功能](https://e.gitee.com/open_euler/issues/table?issue=I6CK4F)| *待**sig-Compiler**评审后补充* | | |
|5|[【openEuler 23.03】NFS客户端支持多路径](https://gitee.com/openeuler/kernel/issues/I6CR7Z)|Discussion|Kernel | *待**sig-kernel**评审后补充* | | |
|6|[【openEuler 23.03】openEuler 23.03 创新版本选择 6.1 内核](https://gitee.com/openeuler/kernel/issues/I6834I)| *6.1内核继承内核继承特性的测试策略* | | |
|7|[【openEuler 23.03】新增openGemini时序数据库](https://gitee.com/openeuler/release-management/issues/I6EQV3)| *现**sig-DB**已提交测试策略PR，当前未合入* | | |



## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：
*经embeded-sig评审，嵌入式23.03版本不跟随社区内核升级，源码仍使用5.10内核版本源码，涉及继承特性有：分布式软总线、混合部署、硬实时*

| Feature/组件 |  策略                           |
| ----------- | ------------------------------- |
| 内核         | 直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化           | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 编译器(gcc)  | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   |
| bishengjdk  | 继承已有测试能力，基于开源测试套对jdk相关功能进行验证   |
| 支持DDE桌面      | 继承已有测试能力，关注DDE桌面系统的安装和基本功能           |
| 支持UKUI桌面     | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           |
| 支持xfce桌面     | 继承已有测试能力，重点关注xfce桌面的可安装性和提供组件的能力 |
| 支持gnome桌面    | 继承已有测试能力，关注gnome桌面系统的安装和基本功能           |
| 支持Kiran桌面    | 增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 |
| 支持Cinnamon桌面 | 继承已有测试能力，关注Cinnamon桌面系统的安装和基本功能       |
| 支持南向兼容性    | 继承已有测试能力，关注板卡和整机适配的兼容性测试 |
| 支持树莓派       | 继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     |
| 支持RISC-V      | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性 |
| 支持HA软件      | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 |
| 支持KubeSphere  | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 支持NestOS      | 继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 支持openGauss   | 继承已有测试能力，关注openGauss数据库的功能、性能和可靠性   |
| 支持虚拟化热补丁libcareplus | 继承已有测试能力，重点关注libcareplus提供Qemu热补丁能力  |
| 支持用户态协议栈gazelle     | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能  |
| 支持IO智能多流astream | 继承已有测试能力，验证通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命 | 
| 支持pkgship      | 继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能 | 
| 支持鲲鹏安全库     | sig-security-facility | sig-QA | 继承已有测试能力，验证对鲲鹏安全库下的支持平台远程证明及TEE远程证明特性进行接口、功能测试 | 
| 支持基于分布式软总线扩展生态互联互通 | 继承已有测试能力，验证openEuler和openHarmony设备进行设备认证，互通互联特性 | 
| 支持混合关键部署技术扩展  | 继承已有测试能力，验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS | 
| 支持硬实时系统    | 继承已有测试能力，验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 | 
| 支持kubernetes  | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 安装部署         | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| 新增ROS基础版和ROS2基础版  | sig-ROS | sig-ROS | 继承已有测试能力，验证ROS1 Noetic 版的ROS_COMM和ROS1 Foxy 版的ROS_BASE是否能够成功安装和卸载，测试用例能否通过 |



## 专项测试策略

### 安全测试

[openEuler 23.03 安全测试策略](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_23.03/openEuler%2023.03%20%E5%AE%89%E5%85%A8%E6%B5%8B%E8%AF%95%E7%AD%96%E7%95%A5.md)

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。整体安全测试需要覆盖：

1.  linux系统安全配置/权限管理等

2.  特性涉及到的安全需求验证

3.  CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

4.  白盒安全测试

| 测试类         | 描述                      | 具体测试内容                                                 |
| :------------- | ------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | CVE扫描/敏感信息/编译选项 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全配置管理类 | Linux安全规范             | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试 |
| 白盒安全测试类 | Fuzz测试                  | Fuzz测试是能发现接口参数类问题和内存相关问题的有效方法，所以需要针对操作系统重点软件包开展fuzz；通过部署kasan版本的内核，进行syzkaller的测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对对编译器组件进行fuzz测试；虚拟化组件qemu的asan版本开展fuzz测试； |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 测试类性     | 具体测试内容                                                 |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| 虚拟化长稳   | 通过部署qemu的地址消毒版本，通过长时间随机交互的方式，反复、并发操作各类特性的功能；建议稳定性测试时长7\*24 |
| 特性长稳     | 特性级的可靠性，需结合特性涉及和使用的资源类型，如进程、服务、文件、CPU/内存/IO/网络等；通过模拟各类资源异常/竞争/压力故障场景，并发/反复的进行特性提供的基本功能操作 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                                               | **指标值**              | **说明**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 与基线数据差异小于5%以内可接受 |

### 兼容性测试

南向兼容性测试分板卡测试和整机适配测试两个部分。

本版本作为创新版本，在内核进行6.x的升级情况下，牵引达成以下清单的兼容性基线目标，使能新硬件。主要使用社区硬件兼容性测试工具oec-hardware集成compass-ci进行自动化测试，适配完成后将在社区发布此版本的兼容性清单。

*待兼容性sig补充 6.x内核版本基线兼容性清单*

#### 北向兼容性

创新版本暂不涉及

#### 虚拟化兼容性

虚拟化兼容性(即openEuler本版本的虚拟机能否在其余OS host)
* 常用桌面虚拟化软件对openEuler的支持
* 常用linux发行版对openEuler虚机镜像的支持
* openEuler对常见linux发行版虚机镜像的支持

### 软件包管理专项测试

软件包(openEuler中特指RPM包)测试，基于历史20.03至今发现的质量问题总结。
* 软件版本变更检查：检查前序版本的代码变动是否在当前版本继承，保证代码不漏合。
* 多动态库检查：检查软件是否存在多个版本动态库（存在编译自依赖软件包升级方式不规范）

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**       | **覆盖策略**                                | **中英文测试策略** |
|------------------|--------------------------------------------|------------------|
| DDE安装指南       | 安装步骤的准确性及DDE桌面系统是否能成功安装启动    | 英文描述的准确性   |
| UKUI安装指南      | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动   | 英文描述的准确性   |
| KIRAN安装指南     | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动  | 英文描述的准确性   |
| XFCE安装指南      | 安装步骤的准确性及XFCE桌面系统是否能成功安装启动   | 英文描述的准确性   |
| GNOME安装指南     | 安装步骤的准确性及GNOME桌面系统是否能成功安装启动  | 英文描述的准确性   |
| 树莓派安装指导     | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   |
| 安装指南          | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 管理员指南         | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 安全加固指南       | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 虚拟化用户指南     | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| StratoVirt用户指南 | 文档描述与版本的行为是否一致                   | 英文描述的准确性   |
| 容器用户指南       | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 应用开发指南       | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 工具集用户指南     | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |

# 测试执行策略

openEuler 23.03 版本按照社区release-manger团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取1+3+1的测试方式，即1轮基本功能保障发布beta版本可以提供给外部开发者，3轮全量保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归。

### 测试计划

openEuler 23.03 版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stage  name          | Begin time | End time   | Days | Note                                      |
| -------------------- | ---------- | ---------- | ---- | ----------------------------------------- |
| Collect key features | 2022/12/01  | 2023/1/15 | 46   | 收集23.03版本关键特性（各SIG自行录入release-plan）   |
| Develop | 2023/1/4  | 2023/2/20 | 46   | 特性完成开发和自验证，代码提交合入23.03   |
| 内核升级 | 2023/1/4  | 2023/1/16 | 12   | master主线升级内核到6.1   |
| BaseOS构建 | 2023/1/16  | 2023/1/31 | 15   | Master主线BaseOS构建，基础包能用   |
| BaseOS测试 | 2023/2/1  | 2023/2/3 | 3   | 内核升级后BaseOS可用   |
| 分支全量Build | 2023/2/6  | 2023/2/10 | 4   | 从master拉23.03分支，完成分支全量构建，基础包升级完毕   |
| Alpha | 2023/2/13  | 2023/2/17 | 4   | 软件包升级完成，首版本发布   |
| Test round 1 | 2023/2/20  | 2023/2/24 | 5   | 版本启动测试，内核冻结   |
| Test round 2 | 2023/2/27  | 2023/3/3 | 5   |   |
| Test round 3 | 2023/3/6  | 2023/3/10 | 5   | 特性合入冻结，不再接纳新特性代码合入   |
| Test round 4 | 2023/3/13  | 2023/3/17 | 5   |    |
| Test round 5 | 2023/3/20  | 2023/3/22 | 5   |    |
| Release | 2023/3/30  | 2023/3/30 | 1   |    |



### 测试重点

测试阶段1：

1.  继承特性/新特性的基本功能

2.  交付重要组件(内核、虚拟化、容器、编译器等)的功能完整性

3.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整性

4.  通过软件包管理测试，对发布软件的可安装进行整体保证

5.  专项情况如下：

    性能：保证版本的性能满足发布基线标准，不能低于版本性能指标

    安全测试：进行安全CVE漏洞、安全编译选项、敏感信息扫描

    南向兼容性验证

测试阶段2：

1.  继承特性/新特性的全量验证

2.  通过自动化覆盖重要组件的功能

3.  系统集成的正确性和完整性

4.  软件包管理测试

5.  专项：

    可靠性：保证版本的长时间稳定运行，建议运行时长7\*24
    
    软件包fuzz测试
    
    兼容性测试：南向硬件测试+北向软件测试

测试阶段3：

1.  继承特性/新特性的自动化全量验证

2.  系统集成验证

3.  软件包管理测试

4.  专项：性能、可靠性、文档测试、南北向兼容性测试

5.  问题单回归

测试阶段4：

1. 交付特性/组件的全量测试

2. 问题单回归

3. 软件包管理测试

4. 系统集成验证

5. 专项：安全CVE扫描、可靠性、性能、文档测试、南北向兼容性测试

测试阶段5：

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

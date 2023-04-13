![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ----------------- | -------- |
| 2023/03/21 | 1.0.0    | 初稿, 基于RC1/2/3   | Ethan-Zhang |


关键词：

openEuler UKUI DDE kiran gnome xfce cinnamon kmesh kconfigdetector raspberry kernel openGemini iSulad NFS SecGear embedded

摘要：

文本主要描述openEuler 23.03 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 23.03版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 23.03是基于6.1内核的创新版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler master分支拉出，发布范围相较22.03 LTS版本主要变动：

1.  内核升级，由5.10升级至6.1
2.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP1/openEuler-22.03-LTS-SP1%20%E5%8D%87%E7%BA%A7%E9%80%89%E5%9E%8B.md)
3.  新增支持：6.1内核/高性能服务网络数据面Kmesh/内核配置项错误值检查工具kconfigDetector/NFS客户端支持多路径/openGemini时序数据库/SecGear支持安全通道/iSulad支持镜像RO数据管理目录拆分/GCC编译器插件框架支持LTO复杂优化/支持树莓派/支持嵌入式版本
4.  修复bug和cve

## 2.1 版本测试计划
openEuler 23.03 版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| Stage name           | Begin time | End time  | Days | Note                                                  |
| -------------------- | ---------- | --------- | ---- | ----------------------------------------------------- |
| Collect key features | 2022/12/01 | 2023/1/15 | 46   | 收集23.03版本关键特性（各SIG自行录入release-plan）    |
| Develop              | 2023/1/4   | 2023/2/20 | 46   | 特性完成开发和自验证，代码提交合入23.03               |
| 内核升级             | 2023/1/4   | 2023/1/16 | 12   | master主线升级内核到6.1                               |
| BaseOS构建           | 2023/1/16  | 2023/1/31 | 15   | Master主线BaseOS构建，基础包能用                      |
| BaseOS测试           | 2023/2/1   | 2023/2/3  | 3    | 内核升级后BaseOS可用                                  |
| 分支全量Build        | 2023/2/6   | 2023/2/10 | 4    | 从master拉23.03分支，完成分支全量构建，基础包升级完毕 |
| Alpha                | 2023/2/13  | 2023/2/22 | 4    | 软件包升级完成，首版本发布                            |
| Test round 1         | 2023/2/23  | 2023/3/1  | 5    | 版本启动测试，内核冻结                                |
| Test round 2         | 2023/3/2   | 2023/3/7  | 5    |                                                       |
| Test round 3         | 2023/3/8   | 2023/3/12 | 5    | 特性合入冻结，不再接纳新特性代码合入                  |
| Test round 4         | 2023/3/21  | 2023/3/24 | 4    |                                                       |
| Test round 5         | 2023/3/27  | 2023/3/29 | 3    |                                                       |
| Release              | 2023/3/30  | 2023/3/30 | 1    |                                                       |

## 2.2 测试硬件信息

测试的硬件环境如下：

| **整机厂商**        | **整机型号**                                      | **CPU型号**   | **备注**              |
| ------------------- | ------------------------------------------------- | ------------- | --------------------- |
| 华为                | 泰山200 2280                                      | 鲲鹏920       |                       |
| 超聚变              | 2288H V5                                          | Intel cascade |                       |

## 2.3 需求清单

openEuler 23.03 版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-23.03/release-plan.md)如下：

| no   | feature                                                      | status  | sig                          | owner                                                   | 发布方式 | 涉及软件包列表                                               |
| :--- | :----------------------------------------------------------- | :------ | :--------------------------- | :------------------------------------------------------ | :------- | :----------------------------------------------------------- |
| 1    | [【openEuler 23.03】新增高性能服务网格数据面Kmesh](https://gitee.com/openeuler/release-management/issues/I65S7M?from=project-issue) | Accepted | sig-high-performance-network | @MrRlu                                                  | ISO | kmesh                                                        |
| 2    | [【openEuler 23.03】新增内核配置项错误值检查工具kconfigDetector](https://gitee.com/openeuler/release-management/issues/I69YOZ?from=project-issue) | Accepted | sig-kernel                   | @sunying2022                                            | EPOL     | kconfigDetector                                              |
| 3    | [【openEuler 23.03】支持树莓派](https://gitee.com/openeuler/release-management/issues/I6AACH) | Accepted | sig-RaspberryPi              | [@woqidaideshi](https://gitee.com/woqidaideshi)         | EPOL     | raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom |
| 4    | [【openEuler 23.03】iSulad支持镜像RO数据管理目录拆分](https://gitee.com/openeuler/release-management/issues/I6E2SI) | Accepted | sig-CloudNative              | [@driedyellowpeach](https://gitee.com/driedyellowpeach) | ISO   | iSulad                                                       |
| 5    | [【openEuler 23.03】openEuler 23.03 创新版本选择 6.1 内核](https://gitee.com/openeuler/kernel/issues/I6834I) | Accepted | Kernel                       | @zhengzengkai                                           | ISO   | Kernel                                                       |
| 6    | [【openEuler 23.03】支持embedded版本](https://gitee.com/openeuler/release-management/issues/I6DS1J?from=project-issue) | Accepted | sig-embedded                 | @fanglinxu                                              | 独立发布 | Embedded                                                     |
| 7    | [【openEuler 23.03】NFS客户端支持多路径](https://gitee.com/openeuler/kernel/issues/I6CR7Z) | Accepted | Kernel                       | @jiangzhongbing                                         | EPOL   | Kernel                                                       |
| 8    | [【openEuler 23.03】新增openGemini时序数据库](https://gitee.com/openeuler/release-management/issues/I6EQV3) | Accepted | DB                           | @openGemini                                             | EPOL      | Kernel                                                       |
| 9    | [【openEuler 23.03】secGear支持安全通道](https://gitee.com/openeuler/release-management/issues/I6EZTD?from=project-issue) | Accepted | sig-confidential-computing   | @houmingyong                                            | ISO      | secGear                                                      |
| 10   | [【openEuler 23.03】GCC编译器插件框架支持LTO复杂优化，实现插件IR覆盖Gimple 80%的功能](https://gitee.com/openeuler/release-management/issues/I6CK4F?from=project-issue) | Accepted | Compiler                     | @wangding                                               | ISO   | GCC                                                          |

> 当前社区release分为以下几种方式: 社区repo-OS/everything/Epol/独立镜像，oepkgs(软件所仓库)，sig独立发布(各sig自定义发布链接提供至release-sig)

## 2.4 测试活动分工
本次版本测试活动分工如下：

| **需求**                                  | **开发主体**                 | **测试主体**                 | **测试分层策略**                                             |
| ----------------------------------------- | ---------------------------- | ---------------------------- | ------------------------------------------------------------ |
| 支持UKUI桌面                              | sig-UKUI                     | sig-UKUI                     | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
| 支持DDE桌面                               | sig-DDE                      | sig-DDE                      | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持xfce桌面                              | xfce                         | xfce                         | 验证xfce桌面系统在openEuler版本上的可安装和基本功能          |
| 支持GNOME桌面                             | GNOME                        | GNOME                        | 验证gnome桌面系统在openEuler版本上的可安装和基本功能         |
| 支持Kiran桌面                             | sig-KIRAN-DESKTOP            | sig-KIRAN-DESKTOP            | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
| 支持Cinnamon桌面                          | sig-cinnamon                 | sig-cinnamon                 | 验证Cinnamon桌面系统在openEuler版本上的可安装和基本功能      |
| 支持南向兼容性                            | sig-Compatibility-Infra      | sig-QA                       | 验证openEuler版本在不同处理器上的可安装和可使用性，覆盖整机兼容性测试和社区集成测试 |
| 支持树莓派发布件                          | sig-RaspberryPi              | sig-RaspberryPi              | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试       |
| 支持RISC-V                                | sig-RISC-V                   | sig-RISC-V                   | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
| 内核                                      | Kernel                       | Kernel                       | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | sig-CloudNative              | sig-CloudNative              | 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化                                    | Virt                         | Virt                         | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能       |
| 编译器(gcc)                               | Compiler                     | sig-QA                       | 基于开源测试套对gcc相关功能进行验证                          |
| bishengjdk                                | Compiler                     | sig-QA                       | 基于开源测试套对bishengjdk相关功能进行验证                   |
| 支持HA软件                                | sig-Ha                       | sig-Ha                       | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持KubeSphere                            | sig-K8sDistro                | sig-K8sDistro                | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 支持NestOS                                | sig-CloudNative              | sig-CloudNative              | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 支持openGauss                             | DB                           | DB                           | 验证openGauss数据库基础功能中接入层、SQL层、存储层、管理和安全等，另外从可靠性、性能、工具和兼容性四个维度覆盖生态测试 |
| 支持虚拟化热补丁libcareplus               | Virt                         | Virt                         | 关注libcareplus提供Qemu热补丁能力                            |
| 支持用户态协议栈gazelle                   | sig-high-performance-network | sig-high-performance-network | 关注gazelle高性能用户态协议栈功能                            |
| 支持IO智能多流astream                     | Kernel                       | sig-QA                       | 验证通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命         |
| 支持pkgship                               | sig-EasyLife                 | sig-QA                       | 验证软件包依赖查询、生命周期管理、补丁查询等功能             |
| 支持鲲鹏安全库                            | sig-security-facility        | sig-QA                       | 验证对鲲鹏安全库下的支持平台远程证明及TEE远程证明特性进行接口、功能测试 |
| 支持基于分布式软总线扩展生态互联互通      | sig-embedded                 | sig-embedded                 | 验证openEuler和openHarmony设备进行设备认证，互通互联特性     |
| 支持混合关键部署技术扩展                  | sig-embedded                 | sig-embedded                 | 验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 支持硬实时系统                            | sig-embedded                 | sig-embedded                 | 验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力     |
| 支持kubernetes                            | sig-CloudNative              | sig-CloudNative              | 验证K8S在openEuler上的安装部署以及提供的对容器的管理能力     |
| 安装部署                                  | sig-OS-Builder               | sig-OS-Builder               | 验证覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| 新增备份还原功能支持                      | sig-Migration                | sig-Migration                | 验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常 |
| 新增ROS基础版和ROS2基础版                 | sig-ROS                      | sig-ROS                      | 验证ROS基础版和ROS2基础版安装卸载以及基础功能正常            |

# 3 版本概要测试结论

   openEuler 23.03 版本整体测试按照release-manager团队的计划，1轮重点特性测试 + 2轮全量测试 + 1轮回归测试 + 1轮版本发布验收测试；第1轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫描及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；另外2轮全量测试开展版本交付的所有特性和各类专项测试；1轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

   openEuler 23.03 版本共发现问题 445个，有效问题 416 个，无效问题 22 个。遗留问题 7 个(详见遗留问题章节)。版本整体质量良好。

# 4 版本详细测试结论

openEuler 23.03版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试、资料测试；

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 内核  | <font color=blue>▲</font>  | 继承已有测试能力，重点关注6.1新版本内核是否可用；采用开源测试套LTP等进行内核基本功能的测试保障 |
| 2 | 容器(isula/docker/安全容器/系统容器/镜像)  | <font color=green>█</font> | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 3 | 虚拟化(qemu/stratovirt)  | <font color=green>█</font>   | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 4 | 编译器(gcc/jdk)  | <font color=green>█</font>   | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   |
| 5 | 支持DDE桌面  | <font color=blue>▲</font>      | 继承已有测试能力，关注DDE桌面系统的安装和基本功能           |
| 6 | 支持UKUI桌面  | <font color=blue>▲</font>     | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           |
| 7 | 支持xfce桌面  | <font color=green>█</font>     | 继承已有测试能力，重点关注xfce桌面的可安装性和提供组件的能力 |
| 8 | 支持gnome桌面  | <font color=green>█</font>    | 继承已有测试能力，关注gnome桌面系统的安装和基本功能           |
| 9 | 支持Kiran桌面  | <font color=green>█</font>    | 继承已有测试能力，关注kiran桌面系统的安装和基本功能 |
| 10 | 支持Cinnamon桌面  | <font color=green>█</font> | 继承已有测试能力，关注Cinnamon桌面系统的安装和基本功能 |
| 11 | 支持南向兼容性  | <font color=green>█</font>    | 继承已有测试能力，关注整机适配的兼容性测试 |
| 12 | 支持树莓派  | <font color=blue>▲</font>       | 继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     |
| 13 | 支持RISC-V  | <font color=green>█</font>      | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性(因构建效率原因，RISC-V版本会在openEuler版本正式release后开启构建与测试) |
| 14 | 支持HA软件  | <font color=green>█</font>      | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 15 | 支持KubeSphere  | <font color=green>█</font>  | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 16 | 支持NestOS | <font color=green>█</font>      | 继承已有测试能力，验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 17 | 支持openGauss  | <font color=green>█</font>   | 继承已有测试能力，关注openGauss数据库的功能、性能和可靠性   |
| 18 | 支持syscare热补丁  | <font color=green>█</font> | 继承已有测试能力，重点关注syscare提供的热补丁能力  |
| 19 | 支持用户态协议栈gazelle  | <font color=green>█</font>     | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能  |
| 20 | 支持pkgship  | <font color=green>█</font>      | 继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能 | 
| 21 | 支持基于分布式软总线扩展生态互联互通 | <font color=green>█</font> | 继承已有测试能力，验证openEuler和openHarmony设备进行设备认证，互通互联特性 | 
| 22 | 支持混合关键部署技术扩展  | <font color=green>█</font>  | 继承已有测试能力，验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS | 
| 23 | 支持硬实时系统 | <font color=green>█</font> | 继承已有测试能力，验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 | 
| 24 | 支持kubernetes | <font color=green>█</font>  | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 25 | 安装部署 | <font color=green>█</font>         | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| 26 | dde备份还原功能支持 | <font color=green>█</font> | 继承已有测试能力，验证ROS基础版和ROS2基础版安装卸载以及基础功能正常 |
| 27 | 支持ROS基础版和ROS2基础版 | <font color=green>█</font> | 验证ROS基础版和ROS2基础版安装卸载以及基础功能正常 |


<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称** | **测试覆盖情况** | **约束依赖说明** | **遗留问题单** | **质量评估** | **备注** |
| -------- | ----------- | ------------- | -------------- | ------------ | ----------- | ------------ |
| 1 | [【openEuler 23.03】新增高性能服务网格数据面Kmesh](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_23.03/openEuler%2023.03%E7%89%88%E6%9C%ACKmesh%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | Kmesh特性，共计执行13个用例，主要覆盖功能测试和可靠性测试。由于开发阶段已经同步完成测试执行，本轮测试仅发现一个问题并且已经回归通过。 | NA               | NA             | <font color=green>█</font> | NA |
| 2 | [【openEuler 23.03】新增内核配置项错误值检查工具kconfigDetector](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_23.03/openEuler%2023.03%E7%89%88%E6%9C%ACkconfigDetector%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共计执行 16 个用例，主要覆盖了在 openEuler 23.03 中安装部署、卸载、 check_kconfig_dep命令的功能测试，x86 架构和 aarch64 架构均测试通过。 | NA               | NA             | <font color=green>█</font> | NA |
| 3 | [【openEuler 23.03】支持树莓派](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_23.03/openEuler%2023.03%E7%89%88%E6%9C%AC%E6%A0%91%E8%8E%93%E6%B4%BE%E9%95%9C%E5%83%8F%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 系统安装 11 项用例、基本功能及配置 25 项用例、管理工具 53 项用例、硬件兼容性 36 项用例、开发环境验证 18 项用例、稳定性 1 项用例，合计 144 项用例。通过率 99%  | NA               | NA             |  <font color=blue>▲</font>  | NA |
| 4 | [【openEuler 23.03】iSulad支持镜像RO数据管理目录拆分](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_23.03/openEuler%2023.03%E7%89%88%E6%9C%AC%E9%95%9C%E5%83%8FRO%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 镜像RO特性，共计新增执行12个用例，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试。<br />重点关注新增功能开启后是否有文件残留、是否有线程残留，功能开启前后是否影响原本isula、isulad操作。<br />经过测试，发现4个问题，均回归通过，整体质量良好。 | NA               | NA             | <font color=green>█</font> | NA |
| 5 | [【openEuler 23.03】openEuler 23.03 创新版本选择 6.1 内核]() | 主要基于LTP进行基础功能测试覆盖，但未对6.1内核新特性进行校验。LTP测得的问题均已闭环，内核基本可用 | NA               | NA             | <font color=green>█</font> | NA |
| 6 | [【openEuler 23.03】支持embedded版本](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_23.03/openEuler%2023.03%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 包含一轮基础及基础软件外围包测试、一轮安全配置及基础OS指令测试、一轮全量测试(基础功能及指令、新增特性、外围包、安全专项、性能专项)以及两轮回归测试 | NA               | NA             | <font color=green>█</font> | NA |
| 7 | [【openEuler 23.03】NFS客户端支持多路径]() |  | NA               | NA             |  | NA |
| 8 | [【openEuler 23.03】新增openGemini时序数据库](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_23.03/openEuler%2023.03%20%E7%89%88%E6%9C%ACopenGemini%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共执行1510个功能测试用例，165个可靠性测试用例，850个单元测试用例，通过7*24小时长稳测试 | NA               | NA             | <font color=green>█</font> | NA |
| 9 | [【openEuler 23.03】secGear支持安全通道](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_23.03/openEuler%2023.03%E7%89%88%E6%9C%ACsecGear%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | secGear特性，共计执行150个用例，新增19个，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试。<br />重点关注新增安全通道功能进行测试，测试覆盖密钥协商场景，加解密场景，接口非法值场景，功能异常场景，以及多客户端并发场景。<br />经过了测试，发现5个问题，均回归通过，整体质量良好。 | NA               | NA             | <font color=green>█</font> | NA |
| 10 | [【openEuler 23.03】GCC编译器插件框架支持LTO复杂优化，实现插件IR覆盖Gimple 80%的功能]() |  | NA               | NA             | <font color=blue>▲</font> | NA |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成2套整机的测试(该数目仅为测试数量，实际兼容性认证通过数量见社区[兼容性清单](https://www.openeuler.org/zh/compatibility/))

此版本的整机兼容性适配测试主要使用社区开源硬件兼容性测试工具oec-hardware，从整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性等方面进行适配，适配完成后将在社区发布此版本的整机兼容性清单。

整机适配兼容性测试交付清单如下：

| **整机厂商** | **整机型号** | **CPU型号**   | **测试主体**      |
| ------------ | ------------ | ------------- | ----------------- |
| 华为         | 泰山200 2280 | 鲲鹏920       | sig-Compatibility |
| 超聚变       | 2288H V5     | Intel cascade | sig-Compatibility |

整机兼容性清单以sig-Compatibility-Infra提供为主，社区各sig测试过程中使用的机器因未进行oec-hardware测试(进入社区兼容性清单质量要求)，故无法直接进行兼容性清单不在此描述。

## 4.3   专项测试结论

### 安全测试

整体安全测试覆盖：

1、Linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/编译选项扫描/交付件病毒扫描

3、白盒安全测试主要通过fuzz测试实现对接口参数类和内存管理类进行覆盖；通过部署kasan版本的内核，进行syzkaller测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对编译器组件行fuzz测试；

4、针对安全加固指南中的加固项，进行全量测试。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型 | 测试内容 | 测试结论 |
| ---------- | ------------------------------------------------------------------------ | -------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7\*24小时(RC4自2023/3/21启动长稳测试,已完成未发现问题;RC5自2023/3/27启动长稳测试会持续跟踪7\*24小时) |

# 5   问题单统计

openEuler 23.03  版本共发现问题 445个，有效问题 416 个，其中遗留问题 6 个。详细分布见下表:

| 测试阶段 | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注 |
| ------ | ------- | ---------- | ---------- | ---------- | --- |
| openEuler 23.03 alpha | 26 | 26           | 0            | 0            | ALPHA DT轮次 |
| openEuler 23.03 round1 | 236 | 223          | 9            | 4            |  |
| openEuler 23.03 round2 | 112 | 101          | 10           | 1            | 全量集成 |
| openEuler 23.03 round3 | 52       | 48           | 3            | 1            | 全量集成 |
| openEuler 23.03 round4 | 18       | 17           | 1            | 0            | 回归测试 |
| openEuler 23.03 round5 | 0        | 0            | 0            | 0            | 版本发布验收测试(回归测试) |

1. 本版本基于单点问题补充的专项测试活动：
   * 单包构建专项排查：23.03为创新版本，涉及大量的软件包选型升级，因此在版本测试活动基于构建系统的构建情况对软件包构建问题进行排查，此类issue单共96个，其中有效问题95个，其中92个问题已验收闭环，3个问题待回归。
   * 安全编译选项排查：不满足[安全编译选项](https://gitee.com/openeuler/security-committee/blob/master/guide/SecureCompile(C&C++).md)，此类issue单共101个，其中有效单99个。该专项活动持续进行。当前有效问题单均已验收闭环。
2. RC4问题分析：共计发现18个问题，17个有效问题，15个问题需要在round5进行回归验证。待回归问题单没有无法闭环的风险，大部分为次要问题。
3. RC5回归分析：RC4修复的15个问题均完成验收，没有额外遗留问题流出。
4. 版本问题总结：从RC1到RC5，问题数量呈收敛趋势，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求，当前整体问题解决率达100%，闭环率达100%，全部问题单已完成回归，版本整体质量良好。

# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- |
| 1 | [I6LKXG](https://e.gitee.com/open_euler/issues/table?issue=I6LKXG) | 缺失perf-debuginfo包 | 次要 | 该包作用为支撑开发者对perf的调试，不影响perf的功能，且因为社区当前没有对perf-debuginfo的使用需求，以及kernel对与23.03版本debuginfo的关闭策略，perf-debuginfo包缺失不会对版本质量产生影响 | 暂无 |  |
| 2 | [I6KP18](https://e.gitee.com/open_euler/issues/table?issue=I6KP18) | driver-installer.service服务enable后启动，日志有报错 | 次要 | DDE桌面的驱动管理器的显卡驱动重启安装功能不可用，且显卡驱动重启安装功能当前于社区没有使用场景 | 暂无 |  |
| 3 | [I6IZEN](https://e.gitee.com/open_euler/issues/table?issue=I6IZEN) | [arm]syzkaller服务报Driver 'virtio_gpudrmfb' missed to adjust virtual screen size等错误 | 次要 | 内核对GPU驱动的支持可能存在问题，但社区当前没有对GPU驱动支持的诉求和问题定位解决能力 | 暂无 |  |
| 4 | [I6IJ1A](https://e.gitee.com/open_euler/issues/table?issue=I6IJ1A) | [arm/x86] ovirt-vmconsole-host-sshd.service服务启动失败 | 主要 | 无法添加ovirt主机 | 需要通过此文档方式部署 [https://www.kdocs.cn/l/cmzyU7dYxwSr](https://gitee.com/link?target=https%3A%2F%2Fwww.kdocs.cn%2Fl%2FcmzyU7dYxwSr) |  |
| 5 | [I6IGXA](https://e.gitee.com/open_euler/issues/table?issue=I6IGXA) | [arm/x86]mom-vdsm.service服务启动失败 | 主要 | 无法添加ovirt主机 | 需要通过此文档方式部署 [https://www.kdocs.cn/l/cmzyU7dYxwSr](https://gitee.com/link?target=https%3A%2F%2Fwww.kdocs.cn%2Fl%2FcmzyU7dYxwSr) |  |
| 6 | [I6I1F7](https://e.gitee.com/open_euler/issues/table?issue=I6I1F7) | [arm/x86] ipa-epn.service服务启动失败 | 次要 | FreeIPA当前于社区没有使用诉求，且没有引入完全，同时不存在依赖于ipa相关软件包对上层依赖。 | 暂无 |  |


# 致谢
非常感谢以下sig在openEuler 23.03 版本测试中做出的贡献,以下排名不分先后
infra-sig的各位贡献者
@wangchong1995924 @small_leek @yaolonggang @dongjie110 @cxl78320 @raomingbo @shdluan @wu_zhende @weijihui @liu-yinsi @duan_pj @wangLin0_0 @georgecao @zhongjun2 @gzbang @liuqi469227928 @wanghaosq @dakang_siji @liuyanglinun @Tom_zx @haml @qinsheng99_code
<br>
RM-sig的各位贡献者
@solarhu @chenyaqiang @paul-huang
<br>
QA-sig的各位贡献者
@zjl_long @ga_beng_cui @hanson-fang @erin_dan @丁娇 @wenjun @suhang @zhanglu626 @ssttkx @zhangpanting @wangxiaoya @hukun66 @MDS_ZHR @banzhuanxiaodoubi @mazenggang3 @clerk_duan
@yanglijin @clay @oh_thats_great @wangting112 @lijiaming666 @liwencheng6769 @luluyuan @lutianxiong @chenshijuan3 @laputa0 @lcqtesting @xiuyuekuang @ganqx
@woqidaideshi @yjt-dli @disnight @chenshijuan3 @wangpeng_uniontech @fu-shanqing @saarloos @ding-jiao
<br>
以及所有参与23.03 但未统计到的所有开发者
(如有遗漏可随时联系 @Ethan-Zhang email:ethanzhang55@outlook.com 反馈)


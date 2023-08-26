![openEuler ico](../../images/openEuler.png)

版权所有 © 2023 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期     | 修订版本 | 修改  章节 | 修改描述 | 作者              |
| -------- | -------- | ---------- | -------- | ----------------- |
| 2023-8-1 | 1.0.0    |            | 初稿     | dongchangchun2020 |


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

本文是openEuler 23.09 版本的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 23.09版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 23.09 是基于6.4内核的创新版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于master分支拉出，发布范围相较23.03版本主要变动：

1.  (*待补充*)软件版本选型升级，详情请见[版本变更说明]()
2.  (*待补充*)修复bug和cve
3.  (*待细化*)核心基础软件升级：kernel 6.1->6.4

## 需求范围

openEuler 23.09 版本交付[需求列表](h)如下：

| no                                                           | feature                                  | status     | sig                      | owner                                                        | 发布方式 | 涉及软件包列表                                               |
| :----------------------------------------------------------- | :--------------------------------------- | :--------- | :----------------------- | :----------------------------------------------------------- | :------- | :----------------------------------------------------------- |
| [I7GRO2](https://gitee.com/openeuler/release-management/issues/I7GRO2) | 增加 utshell 项目发布                    | discussion | sig-utshell              | [@tong2357](https://gitee.com/tong2357/)                     | EPOL     | utshell                                                      |
| [I7GYQK](https://gitee.com/openeuler/release-management/issues/I7GYQK) | 增加 utsudo 项目发布                     | discussion | sig-utsudo               | [@ut-wanglujun](https://gitee.com/ut-wanglujun/)             | EPOL     | utsudo                                                       |
| [I7HXX2](https://gitee.com/openeuler/release-management/issues/I7HXX2) | 增加 migration-tools 项目发布            | discussion | sig-migration-tools      | [@xingwei-liu](https://gitee.com/xingwei-liu/)               | EPOL     | migration-tool                                               |
| [I7K7FQ](https://gitee.com/openeuler/release-management/issues/I7K7FQ) | DDE组件更新支持服务器场景优化            | Testing    | sig-DDE                  | [@leeffo](https://gitee.com/leeffo)                          | EPOL     |                                                              |
| [I7INU0](https://gitee.com/openeuler/release-management/issues/I7INU0?from=project-issue) | 增加 Kmesh 项目发布                      | Developing | sig-ebpf                 | [@sky](https://gitee.com/nlgwcy)                             | extras   | Kmesh                                                        |
| [I7K5TZ](https://gitee.com/openeuler/release-management/issues/I7K5TZ) | 增加i3相关软件包发布                     | Developing | sig-epol                 | [@mywaaagh_admin](https://gitee.com/mywaaagh_admin)          | EPOL     | i3,i3status,perl-AnyEvent-I3,perl-AnyEvent,xcb-util-xrm,xcompmgr,perl-IO-Pipely,perl-Guard,perl-Glib,perl-Curses,dmenu,perl-Task-Weaken,perl-POE-Test-Loops,perl-Test-Command |
| [I7L1TT](https://gitee.com/openeuler/release-management/issues/I7L1TT) | A-Ops gala发布精细化性能Profiling特性    | Developing | sig-ops                  | [@Vchanger](https://gitee.com/Vchanger)                      | ISO      | gala-gopher                                                  |
| [I7K9ZJ](https://gitee.com/openeuler/release-management/issues/I7K9ZJ?from=project-issue) | 增加DPU-OS镜像发布                       | Discussion | sig-DPU                  | [@minknov](https://gitee.com/minknov)                        | ISO      | dpu-utilities                                                |
| [I7MAWT](https://gitee.com/openeuler/release-management/issues/I7MAWT) | Aops支持配置溯源功能                     | Discussion | sig-ops                  | [@byrobins](https://gitee.com/byrobins)                      | EPOL     | A-Ops,aops-hermes,aops-zeus,aops-ceres                       |
| [I7K7I7](https://gitee.com/openeuler/release-management/issues/I7K7I7) | sysMaster支持虚机场景                    | Discussion | dev-utils                | [@overweight](https://gitee.com/overweight)                  | ISO      | sysmaster                                                    |
| [I7PNTH](https://gitee.com/openeuler/release-management/issues/I7PNTH) | 增加异构通用内存管理框架（GMEM）特性发布 | Developing | sig-kernel,sig-Computing | [@fangchuang](https://gitee.com/fangchuang),[@weixizhu94](https://gitee.com/weixizhu94) | ISO      | kernel,libgmem                                               |
| [I7MR9U](https://gitee.com/openeuler/release-management/issues/I7MR9U?from=project-issue) | 增加RISC-V架构QEMU镜像                   | Developing | sig-RISC-V               | [@phoebe-xi](https://gitee.com/phoebe-xi)                    | ISO      |                                                              |
| [I7LQ45](https://gitee.com/openeuler/release-management/issues/I7LQ45?from=project-issue) | 增加进程完整性防护特性                   | Developing | sig-security-facility    | [@jinlun123123](https://gitee.com/jinlun123123)              | ISO      | dim,dim-tools                                                |
| [I7LPVO](https://gitee.com/openeuler/release-management/issues/I7LPVO?from=project-issue) | Kuasar 统一容器运行时特性                | Developing | SIG-CloudNative          | [@flyflyflypeng](https://gitee.com/flyflyflypeng)            | ISO      | kuasar,iSulad                                                |
| [I7L1TM](https://gitee.com/openeuler/release-management/issues/I7L1TM?from=project-issue) | A-Ops gala支持K8S Pod全栈可观测及诊断    | Developing | sig-ops                  | [@Vchanger](https://gitee.com/Vchanger)                      | ISO      | gala-gopher                                                  |
| [I7KXN5](https://gitee.com/openeuler/release-management/issues/I7KXN5?from=project-issue) | syscare组件支持容器化热补丁制作场景      | Developing | sig-ops                  | [@RenoSeven](https://gitee.com/RenoSeven)                    | ISO      | syscare                                                      |
| [I7KXLQ](https://gitee.com/openeuler/release-management/issues/I7KXLQ?from=project-issue) | syscare支持容器内补丁制作                | Developing | sig-ops                  | [@RenoSeven](https://gitee.com/RenoSeven)                    | ISO      | syscare                                                      |
| [I7G3JV](https://gitee.com/openeuler/release-management/issues/I7G3JV?from=project-issue) | 增加sysBoost项目发布                     | Developing | atune-sig                | [@ironictwist](https://gitee.com/ironictwist)                | ISO      | sysboost                                                     |
| [I7FB2R](https://gitee.com/openeuler/release-management/issues/I7FB2R?from=project-issue) | 增加CTinspector项目发布                  | Developing | ebpf-sig                 | [@wonleing](https://gitee.com/wonleing)                      | ISO      | CTinspector                                                  |
| [I6V32Y](https://gitee.com/openeuler/kernel/issues/I6V32Y?from=project-issue) | openEuler-22.03-SP2继承需求回合（内核）  | Developing | kernel                   | [@stkid](https://gitee.com/stkid)                            | ISO      | kernel                                                       |
| [I7RPQG](https://gitee.com/openeuler/release-management/issues/I7RPQG?from=project-issue) | 继承特性回合                             | Developing | 相关sig组                | [@sujinling](https://gitee.com/sujinling)                    | ISO      | https://gitee.com/openeuler/release-management/blob/master/openEuler-23.09/openEuler-23.09%E5%85%B3%E9%94%AE%E7%BB%A7%E6%89%BF%E7%89%B9%E6%80%A7%E6%B8%85%E5%8D%95.md |
| [I7RPOW](https://gitee.com/openeuler/release-management/issues/I7RPOW?from=project-issue) | 软件包升级适配                           | Developing | 相关sig组                | [@sujinling](https://gitee.com/sujinling)                    | ISO      | https://gitee.com/openeuler/release-management/blob/master/openEuler-23.09/openEuler-23.09%20%E5%8D%87%E7%BA%A7%E9%80%89%E5%9E%8B.md |
| [I6V436](https://gitee.com/openeuler/kernel/issues/I6V436?from=project-issue) | 内核基线版本升级到v6.4 Release           | Developing | kernel                   | [@stkid](https://gitee.com/stkid)                            | ISO      | kernel                                                       |
| [I7TYZ8](https://gitee.com/openeuler/release-management/issues/I7TYZ8) | 支持embedded                             | Developing | sig-embedded             | [@fanglinxu](https://gitee.com/fanglinxu)                    | img      | sig-embedded                                                 |




# 风险

| 问题类型 | 问题描述 | 问题等级 | 应对措施 | 责任人 | 状态 |
| -------- | -------- | -------- | -------- | ------ | ---- |
|          |          |          |          |        |      |

# 测试分层策略(*基于继承特性策略刷新*)

继承特性清单见：https://gitee.com/openeuler/release-management/blob/master/openEuler-23.09/openEuler-23.09%E5%85%B3%E9%94%AE%E7%BB%A7%E6%89%BF%E7%89%B9%E6%80%A7%E6%B8%85%E5%8D%95.md，本次23.09 创新版本的具体测试分层策略如下：

| 序号 | feature                     | 开发主体-sig                 | 测试主体-sig                 | 测试分层策略                                                 |
| ---- | --------------------------- | ---------------------------- | ---------------------------- | ------------------------------------------------------------ |
| 1    | GCC编译器                   | Compiler                     | QA                           | 继承已有测试能力，包括基于deja测试套对gcc相关功能进行验证    |
| 2    | A-Tune                      | sig-A-tune                   | QA                           | 继承已有测试能力，重点关注A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 3    | secGear机密计算统一开发框架 | sig-confidential-computing   | sig-confidential-computing   | 继承已有测试能力，对secGear已有功能，secGear安全通道数据传输功能等进行验证 |
| 4    | secCryto 全栈国密           |                              |                              | 继承已有测试能力，对secCryto已有功能进行验证                 |
| 5    | Gazelle 轻量级用户态协议栈  | sig-high-performance-network | sig-high-performance-network | 继承已有测试能力，重点验证Gazelle基本功能，支持UDP协议、bond4特性等历史特性功能 |
| 6    | A-Ops 智能运维              | sig-ops                      | QA                           | 继承已有测试能力，关注基本功能正常运行，前端界面显示是否合理清晰 |
| 7    | etmem 内存分级扩展          | sig-Storage                  | QA                           | 继承已有测试能力，重点验证特性的基本功能和稳定性             |
| 8    | KubeOS 容器操作系统         | sig-K8sDistro                | sig-K8sDistro                | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力等特性功能 |
| 9    | SysCare 系统热服务          | sig-ops                      | QA                           | 继承已有测试能力，验证syscare提供的热补丁等功能特性          |
| 10   | StratoVirt 轻量虚机运行时   | sig-virt                     | QA                           | 继承已有测试能力，验证StratoVirt基本功能及安全容器支持直通设备热插拔等继承特性 |
| 11   | HybridSched 虚拟化混合调度  | sig-virt                     | QA                           | 继承已有测试能力，对HybridSched已有功能进行验证              |
| 12   | nvwa 内核热升级             | sig-ops                      | sig-ops                      | 继承已有测试能力，重点验证基本功能，以及特性启动/重启后的功能及状态 |
| 13   | Rubik 容器混部引擎          | sig-CloudNative              | sig-CloudNative              | 继承已有测试能力，重点验证部署等基本功能                     |
| 14   | iSulad 轻量级容器引擎       | sig-CloudNative              | sig-CloudNative              | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，分别验证安全容器、系统容器和普通容器场景下基本功能验证 |
| 15   | eggo K8s 集群部署解决方案   | sig-CloudNative              | sig-CloudNative              | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 |
| 16   | Kmesh 高性能服务治理框架    | sig-high-performance-network | sig-high-performance-network | 继承已有测试能力，重点验证服务启动/重启后的功能及状态        |



# 测试分析设计策略

## 新增feature测试设计策略

待补充，于9月6日前完成新增特性测试策略提交，于9月20日前完成新增特性测试报告提交

| 序号 | feature | 测试设计策略 | 测试重点 |
| ---- | ------- | ------------ | -------- |
| 1    |         |              |          |
| 2    |         |              |          |
| 3    |         |              |          |
| 4    |         |              |          |
| 5    |         |              |          |
| 6    |         |              |          |
| 7    |         |              |          |
| 8    |         |              |          |
| 9    |         |              |          |
| 10   |         |              |          |



## 继承feature/组件测试设计策略

从历史版本继承的功能特性的测试策略如下：
*经embeded-sig评审，嵌入式23.09版本不跟随社区内核升级，源码仍使用5.10内核版本源码，涉及继承特性有：分布式软总线、混合部署、硬实时等*

| feature                     | 策略                                                         |
| --------------------------- | ------------------------------------------------------------ |
| GCC编译器                   | 继承已有测试能力，包括基于deja测试套对gcc相关功能进行验证    |
| A-Tune                      | 继承已有测试能力，重点关注A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| secGear机密计算统一开发框架 | 继承已有测试能力，对secGear已有功能，secGear安全通道数据传输功能等进行验证 |
| secCryto 全栈国密           | 继承已有测试能力，对secCryto已有功能进行验证                 |
| Gazelle 轻量级用户态协议栈  | 继承已有测试能力，重点验证Gazelle基本功能，支持UDP协议、bond4特性等历史特性功能 |
| A-Ops 智能运维              | 继承已有测试能力，关注基本功能正常运行，前端界面显示是否合理清晰 |
| etmem 内存分级扩展          | 继承已有测试能力，重点验证特性的基本功能和稳定性             |
| KubeOS 容器操作系统         | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力等特性功能 |
| SysCare 系统热服务          | 继承已有测试能力，验证syscare提供的热补丁等功能特性          |
| StratoVirt 轻量虚机运行时   | 继承已有测试能力，验证StratoVirt基本功能及安全容器支持直通设备热插拔等继承特性 |
| HybridSched 虚拟化混合调度  | 继承已有测试能力，对HybridSched已有功能进行验证              |
| nvwa 内核热升级             | 继承已有测试能力，重点验证基本功能，以及特性启动/重启后的功能及状态 |
| Rubik 容器混部引擎          | 继承已有测试能力，重点验证部署等基本功能                     |
| iSulad 轻量级容器引擎       | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，分别验证安全容器、系统容器和普通容器场景下基本功能验证 |
| eggo K8s 集群部署解决方案   | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 |
| Kmesh 高性能服务治理框架    | 继承已有测试能力，重点验证服务启动/重启后的功能及状态        |

## 专项测试策略

### 安全测试

（待安全测试策略补充pr）

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

创新版本，不涉及性能规格。 

### 兼容性测试

#### 南向兼容性

南向兼容性测试分板卡测试和整机适配测试两个部分。

本版本作为创新版本，在内核升级至6.4的情况下，牵引达成以下清单的兼容性基线目标，使能新硬件。主要使用社区硬件兼容性测试工具oec-hardware集成compass-ci进行自动化测试，适配完成后将在社区发布此版本的兼容性清单。

| **整机厂商** | **整机型号** | **CPU型号**   | **测试主体**      |
| ------------ | ------------ | ------------- | ----------------- |
| 华为         | 泰山200 2280 | 鲲鹏920       | sig-Compatibility |
| 超聚变       | 2288H V5     | Intel cascade | sig-Compatibility |

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

| **手册名称**       | **覆盖策略**                                                 | **中英文测试策略** |
| ------------------ | ------------------------------------------------------------ | ------------------ |
| DDE安装指南        | 安装步骤的准确性及DDE桌面系统是否能成功安装启动              | 英文描述的准确性   |
| UKUI安装指南       | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动             | 英文描述的准确性   |
| KIRAN安装指南      | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动            | 英文描述的准确性   |
| XFCE安装指南       | 安装步骤的准确性及XFCE桌面系统是否能成功安装启动             | 英文描述的准确性   |
| GNOME安装指南      | 安装步骤的准确性及GNOME桌面系统是否能成功安装启动            | 英文描述的准确性   |
| 树莓派安装指导     | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   |
| 安装指南           | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 管理员指南         | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 安全加固指南       | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 虚拟化用户指南     | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| StratoVirt用户指南 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 容器用户指南       | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 应用开发指南       | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 工具集用户指南     | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |

# 测试执行策略

openEuler 23.09 版本按照社区release-manger团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取1+3+1的测试方式，即1轮基本功能保障发布beta版本可以提供给外部开发者，3轮全量保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归，特性的合入不得晚于RC3。

### 测试计划

openEuler 23.09 版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stage name           | Begin time | End time  | Days | Note                                                  |
| -------------------- | ---------- | --------- | ---- | ----------------------------------------------------- |
| Collect key features | 2023/6/21  | 2023/7/20 | 30   | 收集23.09版本关键特性（各SIG自行录入release-plan）    |
| Develop              | 2023/6/26  | 2023/8/25 | 60   | 特性完成开发和自验证，代码提交合入23.09               |
| 内核升级             | 2023/6/26  | 2023/7/7  | 10   | master主线升级内核到6.4                               |
| BaseOS构建           | 2023/7/10  | 2023/7/21 | 10   | Master主线BaseOS构建，基础包能用                      |
| BaseOS测试           | 2023/7/24  | 2023/7/28 | 5    | 内核升级后BaseOS可用                                  |
| 分支全量Build        | 2023/7/31  | 2023/8/11 | 10   | 从master拉23.09分支，完成分支全量构建，基础包升级完毕 |
| Alpha                | 2023/8/14  | 2023/8/18 | 5    | 软件包升级完成，首版本发布                            |
| Test round 1         | 2023/8/24  | 2023/8/25 | 5    | 版本启动测试，内核冻结                                |
| Test round 2         | 2023/8/28  | 2023/9/1  | 5    |                                                       |
| Test round 3         | 2023/9/4   | 2023/9/8  | 5    | 特性合入冻结，不再接纳新特性代码合入                  |
| Test round 4         | 2023/9/11  | 2023/9/15 | 5    |                                                       |
| Test round 5         | 2023/9/18  | 2023/9/22 | 5    |                                                       |
| Release              | 2023/9/28  | 2023/9/28 | 1    |                                                       |



### 测试重点

测试阶段1：

1. 继承特性/新特性的基本功能

2. 交付重要组件(内核、虚拟化、容器、编译器等)的功能完整性

3. 系统集成方面保证多组件多模块集成的正确性和整体系统的完整性

4. 通过软件包管理测试，对发布软件的可安装进行整体保证

5. 专项情况如下：

    性能：保证版本的性能满足发布基线标准，不能低于版本性能指标

    安全测试：进行安全CVE漏洞、安全编译选项、敏感信息扫描

    南向兼容性验证

测试阶段2：

1. 继承特性/新特性的全量验证

2. 通过自动化覆盖重要组件的功能

3. 系统集成的正确性和完整性

4. 软件包管理测试

5. 专项：

    可靠性：保证版本的长时间稳定运行，建议运行时长7\*24

    软件包fuzz测试

    兼容性测试：南向硬件测试+北向软件测试

测试阶段3：

1.  继承特性/新特性的自动化全量验证
2.  系统集成验证
3.  软件包管理测试
4.  专项：性能、可靠性、文档测试、南北向兼容性测试
5.  问题单回归
6.  **软件包动态库规范检查：（1.编译依赖自身；2.直接cp打包系统库）**
7.  **everything软件范围的包是否都发布**

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
3.  满足各阶段版本转测检查项

### 出口标准

1. 策略规划的测试活动涉及测试用例100%执行完毕

2. 发布特性/新需求/性能基线等满足版本规划目标

3. 版本无block问题遗留，其它严重问题要有相应规避措施或说明

4. **管控软件包范围变化，识别相较前一轮版本新增或剔除软件包，符合预期**

5. **管控升降级变化，识别相较前一轮版本升级或降级软件包，符合预期**

# 附件

无
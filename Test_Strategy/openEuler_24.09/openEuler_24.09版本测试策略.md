![openEuler ico](../../images/openEuler.png)

版权所有 © 2024 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期      | 修订版本 | 修改  章节 | 修改描述 | 作者        |
| --------- | -------- | ---------- | -------- | ----------- |
| 2024-8-13 | 1.0.0    |            | 初稿     | linqian0322 |


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

本文是openEuler 24.09 版本的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 24.09 版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 24.09 是基于6.6内核的创新版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于master分支拉出，发布范围相较24.03 LTS版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-change.yaml)
2.  修复bug和cve

## 需求范围

openEuler 24.09 版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md#https://gitee.com/openeuler/release-management/issues/I9UYO9)如下：

| no   | feature                                                      | status     | sig                   | owner                                           | 发布方式 | 涉及软件包列表 | Arm  | X86  | RISC-V | LoongArch | PowerPC |
| :--- | :----------------------------------------------------------- | :--------- | :-------------------- | :---------------------------------------------- | :------- | :------------- | ---- | ---- | ------ | --------- | ------- |
| 1    | [ 新增基于《openEuler 安全配置基线》检测工具 ](https://gitee.com/openeuler/release-management/issues/IAHMJ1) | Discussion | SIG-security-facility | [@chaomingmeng](https://gitee.com/chaomingmeng) |          |                | √    | √    | √      |           |         |



# 风险

| 问题类型 | 问题描述 | 问题等级 | 应对措施 | 责任人 | 状态 |
| -------- | -------- | -------- | -------- | ------ | ---- |
|          |          |          |          |        |      |

# 测试分层策略(*基于继承特性策略刷新*)

本次24.09 创新版本的具体测试分层策略如下：

| **需求**                                              | **开发主体**                 | **测试主体**                 | **测试分层策略**                                             |
| ----------------------------------------------------- | ---------------------------- | ---------------------------- | ------------------------------------------------------------ |
| 支持UKUI桌面                                          | sig-UKUI                     | sig-UKUI                     | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
| 支持DDE桌面                                           | sig-DDE                      | sig-DDE                      | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持xfce桌面                                          | xfce                         | xfce                         | 验证xfce桌面系统在openEuler版本上的可安装和基本功能          |
| 支持GNOME桌面                                         | GNOME                        | GNOME                        | 验证gnome桌面系统在openEuler版本上的可安装和基本功能         |
| 支持Kiran桌面                                         | sig-KIRAN-DESKTOP            | sig-KIRAN-DESKTOP            | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
| 支持Cinnamon桌面                                      | sig-cinnamon                 | sig-cinnamon                 | 验证Cinnamon桌面系统在openEuler版本上的可安装和基本功能      |
| 支持南向兼容性                                        | sig-Compatibility-Infra      | sig-QA                       | 验证openEuler版本在不同处理器上的可安装和可使用性，覆盖整机兼容性测试和社区集成测试 |
| 支持北向兼容性                                        | sig-Compatibility-Infra      | sig-QA                       | 验证openEuler版本上各类开源软件的的构建安装正常              |
| 支持树莓派发布件                                      | sig-RaspberryPi              | sig-RaspberryPi              | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试       |
| 支持RISC-V                                            | sig-RISC-V                   | sig-RISC-V                   | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
| 内核                                                  | Kernel                       | Kernel                       | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像)             | sig-CloudNative              | sig-CloudNative              | 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化                                                | Virt                         | Virt                         | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能       |
| 编译器(gcc/jdk)                                       | Compiler                     | sig-QA                       | 基于开源测试套对gcc和jdk相关功能进行验证                     |
| 支持HA软件                                            | sig-Ha                       | sig-Ha                       | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持KubeSphere                                        | sig-K8sDistro                | sig-K8sDistro                | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 支持OpenStack Train 和 Wallaby                        | sig-OpenStack                | sig-OpenStack                | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能   |
| 支持A-Tune                                            | A-Tune                       | A-Tune                       | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 支持secPave                                           | sig-security-facility        | sig-QA                       | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
| 支持secGear                                           | sig-confidential-computing   | sig-QA                       | 关注secGear特性的功能完整性                                  |
| 发布eggo                                              | sig-CloudNative              | sig-CloudNative              | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
| 支持kubeOS                                            | sig-CloudNative              | sig-CloudNative              | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
| 支持NestOS                                            | sig-CloudNative              | sig-CloudNative              | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 支持OpenResty                                         | sig-OpenResty                | sig-OpenResty                | 验证openResty平台在openEuler版本上的可安装性和基本功能       |
| 支持etmem内存分级扩展                                 | Storage                      | sig-QA                       | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
| 支持定制裁剪工具(inageTailor和oemaker)                | sig-OS-Builder               | sig-QA                       | 验证可定制化的能力，包括裁剪工具的基本命令功能，并对异常参数进行覆盖；另外对裁剪出来的镜像进行安装部署及基本验证，保障裁剪工具的E2E能力完整性 |
| 支持openGauss                                         | DB                           | DB                           | 验证openGauss数据库基础功能中接入层、SQL层、存储层、管理和安全等，另外从可靠性、性能、工具和兼容性四个维度覆盖生态测试 |
| 支持虚拟化热补丁libcareplus                           | Virt                         | Virt                         | 关注libcareplus提供Qemu热补丁能力                            |
| 支持用户态协议栈gazelle                               | sig-high-performance-network | sig-high-performance-network | 关注gazelle高性能用户态协议栈功能                            |
| 支持容器场景在离线混合部署rubik                       | sig-CloudNative              | sig-CloudNative              | 结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 支持智能运维A-ops                                     | sig-ops                      | sig-QA                       | 关注智能定位（异常检测、故障诊断）功能、可靠性               |
| 支持libstorage针对NVME的IO栈hsak                      | Storage                      | Storage                      | 验证libstorage针对NVMe SSD存储介质提供高带宽低时延的IO软件栈，提升IO的读写性能；同时提供nvme磁盘状态管理以及查询功能，监测nvme磁盘的健康状态 |
| 支持国密算法                                          | sig-security-facility        | sig-security-facility        | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
| 支持k3s                                               | sig-K8sDistro                | sig-K8sDistro                | 验证k3s软件的部署测试过程                                    |
| 支持IO智能多流astream                                 | Kernel                       | Kernel                       | 验证通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命         |
| 支持pkgship                                           | sig-EasyLife                 | sig-QA                       | 验证软件包依赖查询、生命周期管理、补丁查询等功能             |
| 支持鲲鹏安全库                                        | sig-security-facility        | sig-QA                       | 验证对鲲鹏安全库下的支持平台远程证明及TEE远程证明特性进行接口、功能测试 |
| 支持mindspore                                         | ai                           | ai                           | 面向全场景构建最佳昇腾匹配、支持多处理器架构的开放AI架构     |
| 支持pod带宽管理oncn-bwm                               | sig-high-performance-network | sig-high-performance-network | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
| 支持基于分布式软总线扩展生态互联互通                  | sig-embedded                 | sig-embedded                 | 验证openEuler和openHarmony设备进行设备认证，互通互联特性     |
| 支持混合关键部署技术扩展                              | sig-embedded                 | sig-embedded                 | 验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 支持硬实时系统                                        | sig-embedded                 | sig-embedded                 | 验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力     |
| 支持kubernetes                                        | sig-CloudNative              | sig-CloudNative              | 验证K8S在openEuler上的安装部署以及提供的对容器的管理能力     |
| 安装部署                                              | sig-OS-Builder               | sig-QA                       | 验证覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| Kunpeng加速引擎                                       | sig-AccLib                   | sig-AccLib                   | 验证对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加速器KAE的基本功能和性能测试 |
| 发布kiran-desktop 2.6版本                             | sig-KIRAN-DESKTOP            | sig-KIRAN-DESKTOP            | 验证Kiran桌面环境的用户登录、系统面板、控制面板、文件管理、桌面应用等功能 |
| iSulad支持CRI v1.29                                   | sig-iSulad                   | sig-QA                       | 验证iSulad容器引擎对CRI v1.29通信协议的支持                  |
| iSulad支持cgroup v2                                   | sig-iSulad                   | sig-QA                       | 验证iSulad对 cgroup v2 的支持，能够让 Kubernetes 委派更安全的 cgroup 子树给容器，支持跨多个资源的增强资源分配管理和隔离 |
| 为 RISC-V 架构增加内核热补丁能力                      | sig-RISC-V                   | sig-RISC-V                   | 验证在RISC-V架构支持热补丁功能，达到不重启系统即可修复安全漏洞、提升系统稳定性和性能的效果 |
| 为 RISC-V 架构引入 Penglai TEE 支持                   | sig-RISC-V                   | sig-RISC-V                   | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 |
| migration-tools增加图形化迁移openeuler功能            | sig-Migration                | sig-Migration                | 验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 |
| 增加 utshell 项目发布                                 | sig-memsafety                | sig-memsafety                | 验证utshell与用户进行命令行交互的能力，包括命令执行、批处理、作业控制等 |
| 增加 utsudo 项目发布                                  | sig-memsafety                | sig-memsafety                | 验证utsudo访问控制、审计日志、临时提权、灵活配置等           |
| 发布Nestos-kubernetes-deployer                        | sig-K8sDistro                | sig-K8sDistro                | 验证在NestOS上部署，升级和维护kubernetes集群功能正常         |
| virtCCA机密虚机特性                                   | sig-K8sDistro                | sig-K8sDistro                | 验证arm架构上基于openEuler使能virtCCA的机密虚机能力          |
| 支持vCPU热插拔                                        | sig-kernel                   | sig-kernel                   | 验证虚拟化场景下的Arm64 CPU热插拔且不影响虚拟机正常运行      |
| A-Ops gala提供网络L4层TCP主流指标观测能力             | sig-ops                      | sig-QA                       | 验证A-Ops中的gala-gopher组件支持上报TCP重传比例、TCP建连失败比例、TCP建连时延、TCP发送窗口大小、TCP接收窗口大小、TCP拥塞窗口大小、SRTT、接收端RTT、syn报文RTT、重传超时窗口、重传统计等四层主流指标 |
| A-Ops gala提供网络L7层RED指标观测能力                 | sig-ops                      | sig-QA                       | 验证A-Ops中的gala-gopher组件支持七层访问性能观测，如：时延、吞吐量、错误率，支持访问协议：HTTP 1.X，PGSQL；支持加密场景：C/C++语言（OpenSSL 1.1.0/1.1.1）; Java语言（JSSE类库） |
| A-Ops gala提供应用粒度的I/O、CPU、MEM资源占用观测能力 | sig-ops                      | sig-QA                       | 验证A-Ops中的gala-gopher组件支持CPU、IO、网络性能指标观测：进程维度的 I/O操作字节数统计、FD资源占用统计、文件系统（vfs/ext4/overlay/tmpfs）层时延统计，大小I/O操作数量统计、BIO时延、错误统计；进程维度的pagefault、swap区、脏页、虚拟内存、物理内存等统计 |
| A-Ops gala支持可观测行为的动态变更                    | sig-ops                      | sig-QA                       | 验证A-Ops中的gala-gopher组件支持在不重启主进程的前提下动态修改观测范围、观测参数，并支持随时开启、关闭探针 |
| 内存潮汐调度：支持serverless容器热备份                | sig-kernel                   | sig-kernel                   | 覆盖通过系统提供memcg接口进行动态独立分区配置，做到cgroup粒度主动内存交换控制 |
| LLVM版本升级到17.0.6                                  | sig-Compiler                 | sig-QA                       | LLVM版本升级到17.0.6，支持多项功能和性能改进，支持更多的架构新特性 |
| 支持系统运维套件x-diagnosis                           | sig-ops                      | sig-QA                       | 覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能  |
| 支持自动化热升级组件nvwa                              | sig-ops                      | sig-QA                       | 覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 |
| 支持DPU直连聚合特性                                   | sig-DPU                      | sig-DPU                      | 验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 |
| 支持系统热修复组件syscare                             | sig-ops                      | sig-QA                       | 验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力      |
| 支持内存分级扩展组件etmem                             | sig-Storage                  | sig-QA                       | 验证内存数据分级正常，控制内存换出量、etmem扫描普通进程和虚拟机等场景 |
| iSula容器镜像构建工具isula-build                      | sig-iSulad                   | sig-QA                       | 验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 |
| 一键式、轻量化、可配置集群部署工具eggo                | sig-isulad                   | sig-QA                       | 验证eggo集成部署管理能力，包括集群配置版本化管理、集群配置信息变化感知和部署引擎等功能 |
| 支持进程完整性防护特性                                | sig-security-facility        | sig-security-facility        | 验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 |
| 支持入侵检测框架secDetector                           | sig-security-facility        | sig-security-facility        | 验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 |
| imageTailor支持树莓派镜像定制                         | sig-OS-Builder               | sig-OS-Builder               | 基于openEuler发布的everything和EPOL默认源，根据指定的软件包清单定制树莓派镜像 |
| 支持secPaver特性                                      | sig-security-facility        | sig-security-facility        | 验证secPaver可以为应用程序生成不同安全机制下的策略文件的能力 |
| 支持机密计算安全应用开发组件 secGear                  | sig-confidential-computing   | sig-confidential-computing   | 验证机密计算统一开发框架secGear通过提供统一接口和工具，提升开发效率 |
| 系统性能自优化组件A-Tune                              | sig-A-Tune                   | sig-A-Tune                   | 覆盖A-Tune在不同安装模式下部署成功，通过命令行使用A-Tune提供的功能，进行系统负载识别，实现性能自优化 |
| isocut镜像裁剪易用性提升                              | sig-OS-Builder               | sig-OS-Builder               | 验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 |
| 支持devmaster组件                                     | sig-dev-utils                | sig-dev-utils                | 验证devmaster的安装部署、进程配置、客户端工具等使用场景      |
| 支持TPCM特性                                          | sig-Base-service             | sig-Base-service             | 验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 |
| 支持sysMaster组件                                     | sig-dev-utils                | sig-dev-utils                | 验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景 |
| 支持sysmonitor特性                                    | sig-ops                      | sig-QA                       | 验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景 |
| 混合部署rubik                                         | sig-CloudNative              | sig-CloudNative              | 覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化 |
| isulad支持oci runtime并且切换默认runtime为runc        | sig-iSulad                   | sig-QA                       | isulad切换默认runtime为runc，覆盖isula top/attach及历史继承命令执行 |
| 支持embedded                                          | sig-embedded                 | sig-embedded                 | 验证openEuler embedded的构建镜像和完成嵌入式应用开发能力     |
| 发布PilotGo及其插件特性新版本                         | sig-ops                      | sig-QA                       | 验证PilotGo支持 topo 图的展示和智能调优能力                  |
| 支持ROS2-humble和ROS1-noetic基础版                    | sig-ROS                      | sig-ROS                      | 验证openEuler上ROS的安装部署以及通过命令工具获取不同节点的各类信息 |
| 社区签名体系建立                                      | sig-security-facility        | sig-security-facility        | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
| 智能问答在线服务                                      | sig-A-Tune                   | sig-QA                       | 验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 |
| 支持国密特性                                          | sig-security-facility        | sig-security-facility        | 验证openEuler社区国密生态，关注文件完整性保护、内核模块校验、磁盘加密、ssh协议栈等支持国密算法 |
| 增加 AO.space 项目发布                                | sig-RaspberryPi              | sig-RaspberryPi              | 通过软件包和容器镜像验证aospace系统管理程序和服务组件为个人数据提供基础网络访问、安全防护等 |
| 支持GreatSQL                                          | sig-DB                       | sig-DB                       | 验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库 |
| ZGCLab 发布内核安全增强补丁                           | sig-kernel                   | sig-kernel                   | 针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 |



# 测试分析设计策略

## 新增feature测试设计策略

| *序号*                                                       | *Feature*                                  | *测试设计策略*                                               | *测试重点* | Arm  | X86  | RISC-V | LoongArch | PowerPC |
| ------------------------------------------------------------ | ------------------------------------------ | ------------------------------------------------------------ | ---------- | ---- | ---- | ------ | --------- | ------- |
| [IAHMJ1](https://gitee.com/openeuler/release-management/issues/IAHMJ1) | 新增基于《openEuler 安全配置基线》检测工具 | 使用Linux系统安全检查工具secureguardian，通过执行一系列的安全检查脚本, 查看生成的安全报告，评估系统的安全性是否存在风险 |            | √    | √    | √      |           |         |



## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                                          | 策略                                                         | Arm  | X86  | RISC-V | LoongArch | PowerPC |
| ----------------------------------------------------- | ------------------------------------------------------------ | ---- | ---- | ------ | --------- | ------- |
| 容器(isula/docker/安全容器/系统容器/镜像)             | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 | √    | √    | √      |           |         |
| 虚拟化                                                | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 | √    | √    | ×      |           |         |
| 编译器(gcc/jdk)                                       | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   | √    | √    | √      |           |         |
| 支持DDE桌面                                           | 继承已有测试能力，关注DDE桌面系统的安装和基本功能            | √    | √    | √      |           |         |
| 支持UKUI桌面                                          | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           | √    | √    | √      |           |         |
| 支持xfce桌面                                          | 继承已有测试能力，重点关注xfce桌面的可安装性和提供组件的能力 | √    | √    | √      |           |         |
| 支持gnome桌面                                         | 继承已有测试能力，关注gnome桌面系统的安装和基本功能          | √    | √    | √      |           |         |
| 支持Kiran桌面                                         | 增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 | √    | √    | √      |           |         |
| 支持Cinnamon桌面                                      | 继承已有测试能力，关注Cinnamon桌面系统的安装和基本功能       | √    | √    | √      |           |         |
| 支持南向兼容性                                        | 继承已有测试能力，关注板卡和整机适配的兼容性测试             | √    | √    | √      |           |         |
| 支持北向兼容性                                        | 继承已有测试能力，验证openEuler版本上各类开源软件的的构建安装正常 | √    | √    | ×      |           |         |
| 支持树莓派                                            | 继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     | √    | √    | ×      |           |         |
| 支持RISC-V                                            | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性 | √    | √    | √      |           |         |
| 支持HA软件                                            | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 | √    | √    | ×      |           |         |
| 支持KubeSphere                                        | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力 | √    | √    | ×      |           |         |
| 支持openstack Train 和 Wallaby                        | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能 | √    | √    | ×      |           |         |
| 支持A-Tune                                            | 继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 | √    | √    | √      |           |         |
| 支持secPave                                           | 继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    | √    | √    | ×      |           |         |
| 支持secGear                                           | 继承已有测试能力，关注secGear特性的功能完整性                | √    | √    | ×      |           |         |
| 支持eggo                                              | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 | √    | √    | ×      |           |         |
| 支持kubeOS                                            | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 | √    | √    | ×      |           |         |
| 支持NestOS                                            | 继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 | √    | √    | ×      |           |         |
| 支持OpenResty                                         | 继承已有测试能力，关注openResty平台在openEuler版本上的可安装性和基本功能 | √    | √    | ×      |           |         |
| 支持etmem内存分级扩展                                 | 继承已有测试能力，重点验证特性的基本功能和稳定性             | √    | √    | ×      |           |         |
| 支持定制裁剪工具套件(oemaker/imageTailor)             | 继承已有测试能力，验证可定制化的能力                         | √    | √    | √      |           |         |
| 支持openGauss                                         | 继承已有测试能力，关注openGauss数据库的功能、性能和可靠性    | √    | √    | ×      |           |         |
| 支持虚拟化热补丁libcareplus                           | 继承已有测试能力，重点关注libcareplus提供Qemu热补丁能力      | √    | √    | ×      |           |         |
| 支持用户态协议栈gazelle                               | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能      | √    | √    | ×      |           |         |
| 支持容器场景在离线混合部署rubik                       | 继承已有测试能力，结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 | √    | √    | ×      |           |         |
| 支持智能运维A-ops                                     | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性 | √    | √    | ×      |           |         |
| 支持libstorage针对NVME的IO栈hsak                      | 继承已有测试能力，验证libstorage针对NVMe SSD存储介质提供高带宽低时延的IO软件栈，提升IO的读写性能；同时提供nvme磁盘状态管理以及查询功能，监测nvme磁盘的健康状态 | √    | √    | ×      |           |         |
| 支持国密算法                                          | 继承已有测试能力，验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 | √    | √    | ×      |           |         |
| 支持k3s                                               | 继承已有测试能力，验证k3s软件的部署测试过程                  | √    | √    | ×      |           |         |
| 支持IO智能多流astream                                 | 继承已有测试能力，验证通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命 | √    | √    | ×      |           |         |
| 支持pkgship                                           | 继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能 | √    | √    | ×      |           |         |
| 支持鲲鹏加速库                                        | 继承已有测试能力，验证对鲲鹏安全库下的支持平台远程证明及TEE远程证明特性进行接口、功能测试 | √    | √    | ×      |           |         |
| 支持mindspore                                         | 继承已有测试能力，面向全场景构建最佳昇腾匹配、支持多处理器架构的开放AI架构 | √    | √    | ×      |           |         |
| 支持pod带宽管理oncn-bwm                               | 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 | √    | √    | ×      |           |         |
| 支持基于分布式软总线扩展生态互联互通                  | 继承已有测试能力，验证openEuler和openHarmony设备进行设备认证，互通互联特性 | √    | √    | ×      |           |         |
| 支持混合关键部署技术扩展                              | 继承已有测试能力，验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS | √    | √    | ×      |           |         |
| 支持硬实时系统                                        | 继承已有测试能力，验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 | √    | √    | √      |           |         |
| 支持kubernetes                                        | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 | √    | √    | ×      |           |         |
| 安装部署                                              | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 | √    | √    | ×      |           |         |
| Kunpeng加速引擎                                       | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 | √    | √    | ×      |           |         |
| 发布kiran-desktop 2.6版本                             | 继承已有测试能力，验证Kiran桌面环境的用户登录、系统面板、控制面板、文件管理、桌面应用等功能 | √    | √    | √      |           |         |
| iSulad支持CRI v1.29                                   | 继承已有测试能力，验证iSulad容器引擎对CRI v1.29通信协议的支持 | √    | √    | x      |           |         |
| iSulad支持CDI                                         | 继承已有测试能力，验证iSulad对CDI的支持，支持用户加载符合 CDI 标准的设备 | √    | √    | x      |           |         |
| iSulad支持cgroup v2                                   | 继承已有测试能力，验证iSulad对 cgroup v2 的支持，能够让 Kubernetes 委派更安全的 cgroup 子树给容器，支持跨多个资源的增强资源分配管理和隔离 | √    | √    | x      |           |         |
| 为 RISC-V 架构增加内核热补丁能力                      | 继承已有测试能力，验证在RISC-V架构支持热补丁功能，达到不重启系统即可修复安全漏洞、提升系统稳定性和性能的效果 | x    | x    | √      |           |         |
| 为 RISC-V 架构引入 Penglai TEE 支持                   | 继承已有测试能力，验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 | ×    | ×    | √      |           |         |
| migration-tools增加图形化迁移openeuler功能            | 继承已有测试能力，验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 | √    | √    | ×      |           |         |
| 增加 utshell 项目发布                                 | 继承已有测试能力，验证utshell与用户进行命令行交互的能力，包括命令执行、批处理、作业控制等 | √    | √    | √      |           |         |
| 增加 utsudo 项目发布                                  | 继承已有测试能力，utsudo是更加高效、安全、灵活的提权工具，覆盖访问控制、审计日志、临时提权、灵活配置等 | √    | √    | √      |           |         |
| 发布Nestos-kubernetes-deployer                        | 继承已有测试能力，覆盖在NestOS上部署，升级和维护kubernetes集群功能正常 | √    | √    | ×      |           |         |
| virtCCA机密虚机特性                                   | 继承已有测试能力，验证arm架构上基于openEuler使能virtCCA的机密虚机能力 | √    |      | ×      |           |         |
| 支持vCPU热插拔                                        | 继承已有测试能力， 验证虚拟化场景下的Arm64 CPU热插拔且不影响虚拟机正常运行 | √    |      | ×      |           |         |
| A-Ops gala提供网络L4层TCP主流指标观测能力             | 继承已有测试能力，验证A-Ops中的gala-gopher组件支持上报TCP重传比例、TCP建连失败比例、TCP建连时延、TCP发送窗口大小、TCP接收窗口大小、TCP拥塞窗口大小、SRTT、接收端RTT、syn报文RTT、重传超时窗口、重传统计等四层主流指标 | √    | √    | ×      |           |         |
| A-Ops gala提供网络L7层RED指标观测能力                 | 继承已有测试能力， 验证A-Ops中的gala-gopher组件支持七层访问性能观测，如：时延、吞吐量、错误率，支持访问协议：HTTP 1.X，PGSQL；支持加密场景：C/C++语言（OpenSSL 1.1.0/1.1.1）; Java语言（JSSE类库） | √    | √    | ×      |           |         |
| A-Ops gala提供应用粒度的I/O、CPU、MEM资源占用观测能力 | 继承已有测试能力，验证A-Ops中的gala-gopher组件支持CPU、IO、网络性能指标观测：进程维度的 I/O操作字节数统计、FD资源占用统计、文件系统（vfs/ext4/overlay/tmpfs）层时延统计，大小I/O操作数量统计、BIO时延、错误统计；进程维度的pagefault、swap区、脏页、虚拟内存、物理内存等统计 | √    | √    | ×      |           |         |
| A-Ops gala支持可观测行为的动态变更                    | 继承已有测试能力，验证A-Ops中的gala-gopher组件支持在不重启主进程的前提下动态修改观测范围、观测参数，并支持随时开启、关闭探针 | √    | √    | ×      |           |         |
| 内存潮汐调度：支持serverless容器热备份                | 继承已有测试能力，覆盖通过系统提供memcg接口进行动态独立分区配置，做到cgroup粒度主动内存交换控制 | √    | √    | ×      |           |         |
| LLVM版本升级到17.0.6                                  | 继承已有测试能力，LLVM版本升级到17.0.6，支持多项功能和性能改进，支持更多的架构新特性 | √    | √    | √      |           |         |
| 支持系统运维套件x-diagnosis                           | 继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能 | √    | √    | ×      |           |         |
| 支持自动化热升级组件nvwa                              | 继承已有测试能力，覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 | √    |      | ×      |           |         |
| 支持DPU直连聚合特性                                   | 继承已有测试能力，验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 | √    | √    | ×      |           |         |
| 支持系统热修复组件syscare                             | 继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力 | √    | √    | √      |           |         |
| 支持内存分级扩展组件etmem                             | 继承已有测试能力，验证内存数据分级正常，控制内存换出量、etmem扫描普通进程和虚拟机等场景 | √    | √    | ×      |           |         |
| iSula容器镜像构建工具isula-build                      | 继承已有测试能力，验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 | √    | √    | √      |           |         |
| 一键式、轻量化、可配置集群部署工具eggo                | 继承已有测试能力，验证eggo集成部署管理能力，包括集群配置版本化管理、集群配置信息变化感知和部署引擎等功能 | √    | √    | ×      |           |         |
| 支持进程完整性防护特性                                | 继承已有测试能力，验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 | √    | √    | ×      |           |         |
| 支持入侵检测框架secDetector                           | 继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 | √    | √    | ×      |           |         |
| imageTailor支持树莓派镜像定制                         | 继承已有测试能力，基于openEuler发布的everything和EPOL默认源，根据指定的软件包清单定制树莓派镜像 | √    |      | ×      |           |         |
| 支持secPaver特性                                      | 继承已有测试能力，验证secPaver可以为应用程序生成不同安全机制下的策略文件的能力 | √    | √    | ×      |           |         |
| 支持机密计算安全应用开发组件 secGear                  | 继承已有测试能力，验证机密计算统一开发框架secGear通过提供统一接口和工具，提升开发效率 | √    | √    | ×      |           |         |
| 系统性能自优化组件A-Tune                              | 继承已有测试能力，覆盖A-Tune在不同安装模式下部署成功，通过命令行使用A-Tune提供的功能，进行系统负载识别，实现性能自优化 | √    | √    | √      |           |         |
| isocut镜像裁剪易用性提升                              | 继承已有测试能力，验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 | √    | √    | ×      | √         |         |
| 支持devmaster组件                                     | 继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景 | √    | √    | ×      |           |         |
| 支持TPCM特性                                          | 继承已有测试用例，验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 | √    |      | ×      |           |         |
| 支持sysMaster组件                                     | 继承已有测试能力，验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景 | √    | √    | √      |           |         |
| 支持sysmonitor特性                                    | 继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景 | √    | √    | ×      |           |         |
| 混合部署rubik                                         | 继承已有测试能力，覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化 | √    | √    | ×      |           |         |
| isulad支持oci runtime并且切换默认runtime为runc        | 需求链接也不对                                               | √    | √    | ×      |           |         |
| 支持embedded                                          | 继承已有测试能力，验证openEuler embedded的构建镜像和完成嵌入式应用开发能力 | √    | √    | ×      |           |         |
| 发布PilotGo及其插件特性新版本                         | 继承已有测试能力，验证PilotGo支持 topo 图的展示和智能调优能力 | √    | √    | ×      |           |         |
| 支持ROS2-humble和ROS1-noetic基础版                    | 继承已有测试能力，验证openEuler上ROS的安装部署以及通过命令工具获取不同节点的各类信息 | √    | √    | √      |           |         |
| 社区签名体系建立                                      | 继承已有测试能力，验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性。 | √    | √    | ×      |           |         |
| 智能问答在线服务                                      | 继承已有测试能力，验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 | √    | √    | ×      |           |         |
| 支持国密特性                                          | 继承已有测试能力，验证openEuler社区国密生态，关注文件完整性保护、内核模块校验、磁盘加密、ssh协议栈等支持国密算法 | √    | √    | ×      |           |         |
| 增加 AO.space 项目发布                                | 继承已有测试能力，通过软件包和容器镜像验证aospace系统管理程序和服务组件为个人数据提供基础网络访问、安全防护等 | √    | √    | ×      |           |         |
| 支持GreatSQL                                          | 继承已有测试能力，验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库 | √    | √    | ×      |           |         |
| ZGCLab 发布内核安全增强补丁                           | 继承已有测试能力，针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 | √    |      | ×      |           |         |



## 专项测试策略

### 安全测试

[openEuler 24.09 创新版本安全测试策略]()

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。主要测试项目如下表所示：

| 测试类         | 描述                                                 | 具体测试内容                                                 |
| :------------- | ---------------------------------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | 病毒/开源漏洞/安全编译选项/敏感信息/代码片段引用扫描 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全配置管理类 | Linux安全规范                                        | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试； |
| 安全检查       | 开源合规license检查/签名和完整性校验/SBOM            | 检查软件包的license是否合规；对于发布件要求具备签名和完整性校验机制，如RPM需要具备GPG校验与签名；SBOM信息具备自动生成的能力，随软件发布件一起生成与发布 |
| 安全评估       | 通过openscap检测系统安全漏洞和合规性                 | 漏洞扫描：确定系统中的已知漏洞；合规性检查：验证系统配置是否符合特定的安全标准和政策 |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 测试类性     | 具体测试内容                                                 |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| 虚拟化长稳   | 通过部署qemu的地址消毒版本，通过长时间随机交互的方式，反复、并发操作各类特性的功能；建议稳定性测试时长7\*24 |
| 特性长稳     | 特性级的可靠性，需结合特性涉及和使用的资源类型，如进程、服务、文件、CPU/内存/IO/网络等；通过模拟各类资源异常/竞争/压力故障场景，并发/反复的进行特性提供的基本功能操作 |

### 性能测试

创新版本，不涉及性能规格



### 兼容性测试

创新版本暂不涉及

#### 北向兼容性

创新版本暂不涉及

#### 虚拟化兼容性

虚拟化兼容性(即openEuler本版本的虚拟机能否在其余OS host)
* 常用桌面虚拟化软件对openEuler的支持
* 常用linux发行版对openEuler虚机镜像的支持
* openEuler对常见linux发行版虚机镜像的支持

### 软件包管理专项测试

软件包(openEuler中特指RPM包)测试，基于历史22.03至今发现的质量问题总结。
* 软件版本变更检查：检查前序版本的代码变动是否在当前版本继承，保证代码不漏合。
* 多动态库检查：检查软件是否存在多个版本动态库（存在编译自依赖软件包升级方式不规范）
* 软件包变更检查：对升级到24.09 版本存在新增、删除、变更的软件包通过x2工具扫描出来，对存在变更的软件包修改测试策略（变更测试用例）

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**                  | **覆盖策略**                                                 | **中英文测试策略** | Arm  | X86  | RISC-V | LoongArch | PowerPC |
| ----------------------------- | ------------------------------------------------------------ | ------------------ | ---- | ---- | ------ | --------- | ------- |
| DDE安装指南                   | 安装步骤的准确性及DDE桌面系统是否能成功安装启动              | 英文描述的准确性   | √    | √    | √      |           |         |
| UKUI安装指南                  | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动             | 英文描述的准确性   | √    | √    | √      |           |         |
| KIRAN安装指南                 | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动            | 英文描述的准确性   | √    | √    | √      |           |         |
| XFCE安装指南                  | 安装步骤的准确性及XFCE桌面系统是否能成功安装启动             | 英文描述的准确性   | √    | √    | √      |           |         |
| GNOME安装指南                 | 安装步骤的准确性及GNOME桌面系统是否能成功安装启动            | 英文描述的准确性   | √    | √    | √      |           |         |
| 树莓派安装指导                | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   | √    | √    | ×      |           |         |
| 安装指南                      | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| 管理员指南                    | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| 安全加固指南                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| 虚拟化用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| StratoVirt用户指南            | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| 容器用户指南                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| A-Tune用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| oeAware用户指南               | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| 应用开发指南                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| 工具集用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| HA的安装部署                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| HA的使用实例                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| K8S安装指导                   | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| OpenStack安装指导             | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| A-ops用户指南                 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| Gazelle用户指南               | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| openEuler Embedded用户指南    | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| UniProton用户指南             | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| GCC for openEuler用户指南     | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| NestOS用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| EulerCopilot 智能问答用户指南 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |



# 测试执行策略

openEuler 24.09 创新版本按照社区release-manager团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取1+3+1的测试方式，即1轮基本功能保障发布beta版本可以提供给外部开发者，3轮全量保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归。

### 测试计划

openEuler 24.09 创新版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stage name           | Begin time | End time  | Days | Note                                 |
| :------------------- | :--------- | :-------- | :--- | :----------------------------------- |
| Collect key features | 2024/6/3   | 2024/7/16 | 44   | 版本需求收集                         |
| Change Review 1      | 2024/7/1   | 2024/7/12 | 12   | Review 软件包变更（升级/退役/淘汰）  |
| Herited features     | 2024/7/1   | 2024/7/22 | 22   | 继承特性合入（Branch前完成合入）     |
| Develop              | 2024/7/1   | 2024/8/19 | 50   | 新特性开发，合入master               |
| Kernel freezing      | 2024/7/16  | 2024/7/22 | 7    | 内核冻结                             |
| Branch 24.09         | 2024/7/22  | 2024/8/5  | 15   | master 拉取 24.09 分支               |
| Build & Alpha        | 2024/8/6   | 2024/8/12 | 7    | 新开发特性合入，Alpha版本发布        |
| Test round 1         | 2024/8/13  | 2024/8/19 | 7    | 24.09 启动集成测试                   |
| Change Review 2      | 2024/8/13  | 2024/8/15 | 3    | 发起软件包淘汰评审                   |
| Beta version release | 2024/8/16  | 2024/8/19 | 4    | 24.09 Beta版本发布                   |
| Test round 2         | 2024/8/20  | 2024/8/26 | 7    | 全量验证                             |
| Change Review 3      | 2024/8/27  | 2024/8/29 | 3    | 分支启动冻结，只允许bug fix          |
| Test round 3         | 2024/8/29  | 2024/9/4  | 7    | 分支冻结，只允许bug fix              |
| Test round 4         | 2024/9/5   | 2024/9/11 | 7    | 回归测试                             |
| Test round 5         | 2024/9/12  | 2024/9/19 | 7    | 回归测试（跨中秋节，预祝中秋节快乐） |
| Release Review       | 2024/9/20  | 2024/9/22 | 3    | 版本发布决策/ Go or No Go            |
| Release preparation  | 2024/9/23  | 2024/9/28 | 6    | 发布前准备阶段，发布件系统梳理       |
| Release              | 2024/9/29  | 2024/9/30 | 2    | 社区Release评审通过正式发布          |




### 测试重点

测试阶段1：

1.  继承特性/新特性的基本功能

2.  交付重要组件(内核、虚拟化、容器、编译器等)的功能完整性

3.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整性

4.  通过软件包管理测试，对创新版本发布软件的可安装、卸载、升级、回退进行整体保证

5.  专项情况如下：

    性能：创新版本不涉及

    安全测试：进行病毒、安全CVE漏洞扫描、安全编译选项、敏感信息扫描

    南向兼容性验证：创新版本不涉及

测试阶段2：

1.  继承特性/新特性的全量验证

2.  通过自动化覆盖重要组件的功能

3.  系统集成的正确性和完整性

4.  软件包管理测试

5.  专项：
    
    软件包fuzz测试、开源License检查、SBOM校验测试启动
    
    兼容性测试：创新版本不涉及

测试阶段3：

1.  继承特性/新特性的自动化全量验证

2.  系统集成验证

3.  软件包管理测试

4.  专项

    可靠性：保证版本的长时间稳定运行，建议运行时长7\*24
    安全专项

5.  问题单回归

测试阶段4：

1. 交付特性/组件的全量测试

2. 问题单回归

3. 软件包管理测试

4. 系统集成验证

5. 专项：安全专项测试、文档测试

测试阶段5：

1. 交付特性/组件的自动化全量测试

2. 系统集成自动化测试项执行

3. 问题单全量回归

4. 可靠性：保证版本的长时间稳定运行，建议运行时长7\*24

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无
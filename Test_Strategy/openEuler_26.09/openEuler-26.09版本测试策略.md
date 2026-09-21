![openEuler ico](../../images/openEuler.png)

版权所有 © 2026 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期      | 修订版本 | 修改  章节 | 修改描述 | 作者        |
| --------- | -------- | ---------- | -------- | ----------- |
| 2026-08-18 | 1.0.0    |            | 初稿     | linqian0322 |
| 2026-08-18 | 1.0.1 | | add RISC-V | jean9823 |
| 2026-09-18 | 1.0.2 | | 刷新需求清单 | linqian0322 |


目 录

1 概述 

>   1.1 版本背景

>   1.2 需求范围

2 测试策略

>   2.1 继承需求测试策略

>   2.2 新增需求测试策略

>   2.3 专项测试策略

3 测试执行策略

4 出入口标准

5 附件

**Keywords 关键词**：

openEuler 测试策略

Abstract 摘要：

本文是openEuler 26.09版本的整体测试策略，用于指导该版本后续测试活动的开展。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 26.09版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 26.09是双内核的创新版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于master分支拉出，软件版本选型升级，详情请见[版本变更说明](https://gitcode.com/openeuler/release-management/blob/master/openEuler-26.09-DevStation/release-plan.zh.md)

## 需求范围

openEuler 26.09版本交付[需求列表](https://gitcode.com/openeuler/release-management/blob/master/openEuler-26.09-DevStation/release-plan.zh.md)如下：

状态说明：Discussion(方案讨论，需求未接受)、 Developing(开发中)、 Testing(测试中)、 Accepted(已验收) <br>
发布方式：ISO、Everything、EPOL、oepkgs、独立发布等


# 测试策略

## 继承需求测试策略

本次26.09版本的具体测试分层策略如下：
                                           
| 序号   | 需求 | 责任主体 | 测试重点  | arm/x86 | riscv rva23 | loongarch |
|:--- |:--- |:--- |:--- |:--- |:--- |:--- |
|1|UKUI桌面|sig-UKUI|验证UKUI桌面系统在openEuler版本上的可安装和基本功能|√|√||
|2|DDE桌面|sig-DDE|验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标|√|√||
|3|Kiran桌面|sig-KIRAN-DESKTOP|验证kiran桌面在openEuler版本上的可安装卸载和基本功能|√|√||
|4|安装部署|sig-OS-Builder|验证覆盖裸机/虚机场景下，通过光盘/PXE等安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署|√|√||
|5|内核|sig-Kernel|关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；|√|√||
|7|虚拟化|sig-Virt|重点关注回合新特性后，新版本上虚拟化相关组件的基本功能|√|√||
|8|A-Tune|sig-A-Tune|重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注|√|√||
|9|secPaver|sig-security-facility|验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性|√|√||
|10|secGear|sig-confidential-computing|继承已有测试能力，验证secGear特性的功能完整性，包括远程证明基线与策略导入，查询，创建、加解密、边界检查、生成随机数、打印、销毁等特性正常运行|√|×||
|11|eggo|sig-isulad|继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性|√| √           ||
|12|etmem|sig-Storage|重点验证继承特性的基本功能和稳定性，如memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力|√|×||
|13|gazelle|sig-high-performance-network|继承已有测试能力，验证gazelle高性能用户态协议栈功能，包括支持ceph,支持DWS，支持单网卡negligible，支持苏移krpc，一键脚本部署等继承功能|√|√||
|14|国密全栈|sig-security-facility|继承已有测试能力，验证SSH协议栈、TLCP协议栈、内核模块签名、安全启动、文件完整性保护、用户身份鉴别、磁盘加密、算法库等模块支持国密算法|√|×||
|15|pod带宽管理|sig-high-performance-network|验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试|√|×||
|16|iSulad|sig-iSulad|继承已有测试能力，覆盖继承功能cgroup v2,热升级，健康检查，本地卷，容器生命周期管理，镜像管理，资源管理等，重点验证isulad长稳场景|√|√||
|17|Kuasar|sig-CloudNative|继承已有测试能力，重点验证kuasa的容器运行时特性以及kuasa机密容器适配virtCCA、容器镜像加解密等|√|×||
|18|X-diagnosis|sig-ops|继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能|√|×||
|19|nvwa|sig-ops|覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等|√|×||
|20|dpu-utilities|sig-DPU|验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源|√|×||
|21|syscare|sig-ops|继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力|√|√||
|22|DIM|sig-security-facility|继承已有测试能力，验证dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等，用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量，以及度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量|√|√||
|23|secDetector|sig-security-facility|继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等|√|×||
|24|devmaster|sig-dev-utils|继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景|√|√||
|25|TPCM|sig-Base-service|验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等|√|×||
|26|sysMaster|sig-dev-utils|验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景|√|√||
|27|sysmonitor|sig-ops|继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景|√|√||
|28|混合部署|sig-CloudNative|结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试|√|×||
|29|安全配置工具|sig-security-facility|使用Linux系统安全检查工具 secureguardian，通过执行一系列的安全检查脚本, 查看生成的安全报告，评估系统的安全性是否存在风险|√|√||
|30|安全配置规范框架设计及核心内容构建|sig-security-facility|继承已有测试能力，验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性|√|√||
|31|IMA|sig-security-facility|验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式|√|×||
|32|支持IMA virtCCA|sig-security-facility|验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等|√|×||
|33|安全启动|sig-security-facility|验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等|√|×||
|34|Kmesh|sig-ebpf|验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等|√|×||
|35|openssl|sig-security-facility|验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上|√|√||
|36|sysboost|sig-A-Tune|验证HOST和容器场景，涉及功能、可靠性、性能、安全测试，重点关注可靠性测试|√|×||
|37|远程证明统一框架|sig-security-facility|继承已有测试能力，重点验证ta被篡改后、严格模式和宽松模式下的远程通道能力等功能|√|×||
|38|智能诊断+智能调优|sig-intelligence|验证干扰检测、干扰源分析、负载感知、参数推荐等接口能力 以及配置错误检测功能|√|×||
|39|CCA机密虚机基本能力|sig-security-facility|验证基于CCA架构的机密虚机生命周期管理-定义、销毁虚拟机域，创建、启动、销毁虚拟机功能以及获取证明报告的功能测试|√|×||
|40|慢IO检测|sig-AccLib|验证ai阈值、平均阈值、IO采集、告警插件配置文件的功能|√|×||
|41|CCA机密虚机基于DA的设备直通|sig-security-facility|主要验证CCA机密虚机支持nvme磁盘/网卡设备/KAE等设备直通能力以及直通机密虚机后各设备的基础功能|√|×||
|42|K8s路线沙箱运行时引擎组件基础功能及快照启动加速|sig-CloudNative|验证k8s场景与普通容器场景下的容器粒度的状态checkpoint与restore无损恢复，同时使用纯cpu的vllm推理服务模拟NPU的推理商用场景进行测试|√|×||
|43|A-ops|sig-ops|继承已有测试功能，验证容器干扰检测，微服务性能问题分钟级定位定界场景、AI集群慢节点快速发现、 基于通信算子的低开销高精度慢节点检测 、支持典型内存故障定位等能力|√|×||
|44|KubeOS|sig-CloudNative|验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级|√|×||
|45|gmem|sig-Kernel|继承已有测试能力，重点验证异构通用内存管理框架能力，如基础融合内存能力，通过内存协同，互相借用扩大内存空间提升异构资源利用率等|√|×||
|46|编译器(gcc/jdk)|sig-Compiler|基于开源测试套对gcc和jdk相关功能进行验证|√|√||
|47|支持HA软件|sig-Ha|验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标|√|√||
|48|支持KubeSphere|sig-K8sDistro|验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力|√|×||
|49|支持k3s|sig-K8sDistro|继承已有测试能力，验证k3s软件的部署功能正常|√|×||
|50|migration-tools|sig-Migration|验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统|√|×||
|51|发布Nestos-kubernetes-deployer|sig-K8sDistro|继承已有测试能力，覆盖在NestOS上部署，升级和维护kubernetes集群功能正常|√|×||
|52|支持NestOS|sig-CloudNative|验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证|√|×||
|53|发布PilotGo及其插件特性新版本|sig-ops|验证PilotGo支持 topo 图的展示和智能调优能力|√|√||
|54|智能问答在线服务|sig-intelligence|继承已有测试能力，验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力|√|×||
|55|支持GreatSQL|sig-DB|验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库|√|√||
|56|ZGCLab 发布内核安全增强补丁|sig-Kernel|继承已有测试能力，针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试|√|×||
|57|virtCCA机密虚机特性合入|sig-kernel/sig-virt|继承已有测试能力，重点验证机密虚机的基本功能、安全、兼容性以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试|√|×||
|58|增加 utsudo 支持|sig-memsafety|继承已有测试能力，验证utsudo基础命令使用正常|√|√||
|59|增加 utshell支持|sig-memsafety|继承已有测试能力，验证utshell基础命令使用正常|√|√||
|60|LLVM多版本实现|sig-Compiler|继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。|√|√||
|61|新增密码套件openHiTLS|sig-security-facility|继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试|√|×||
|62|支持oeaware|sig-A-Tune|继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容|√|×||
|63|鲲鹏KAE加速器驱动安装包合入|sig-kernel|继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩|√|×||
|64|Add Intel QAT packages support|sig-Intel-Arch|继承已有测试能力，重点验证intel qat相关软件包的功能和性能|√|×||
|65|版本引入ACPO包|sig-Compiler|继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容|√|×||
|66|内核TCP/IP协议栈支持CAQM拥塞|sig-kernel|继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能|√|×||
|67|为AArch64编译默认开启PAC/BTI|sig-Arm|继承已有测试能力，主要覆盖功能测试和兼容性测试，重点关注通过读取软件包中的二进制ELF文件检查PAC/BTI的支持情况|√|×||
|68|Trace IO加速容器快速启动|sig-Kernel|验证开启TrIO特性后加载web类容器和应用类容器的启动、删除场景|√|×||
|69|引入vkernel概念增强容器隔离能力|sig-Kernel|继承已有测试能力，针对其功能、性能和兼容性进行LTP、UnixBench、容器运行时对比、容器生态兼容、相关应用性能进行测试|√|×||
|70|openAMDC合入|sig-BigData|验证软件的核心功能模块，包括string、list、hash、set、sortedset等数据类型读写和主从复制、服务高可用功能|√|×||
|71|DevStation|sig-Devstation|继承已有测试能力，围绕智能化的一站式开发环境，验证devstation图形化编程环境、智能助手、原生开发工具链（如oedp）以及开发者软件商店等主要功能|√|×||
|72|云原生基础设施部署升级工具k8s-isntall 加入版本|sig-cloudnative|继承已有测试能力，主要覆盖了功能测试、性能测试和异常处理测试，重点验证k8s-install工具支持在线/离线模式下一键式安装部署云原生基础设施的能力，未发现问题整体质量良好|√|×||
|73|引入 valkey 作为首选的内存数据库|sig-DB|继承已有测试能力, 重点验证valkey软件服务启动和关闭正常，软件活动状态正常|√|√|           |
|74|支持树莓派|sig-SBC|继承已有测试能力，对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性等测试|√|×||
|75|llvm编译器提升数据中心应用性能|sig-Compiler|继承已有测试能力，重点验证aggressive inline功能和mysql性能以及特性引入后对全量版本构建没有影响|√|×||
|76|Go编译器优化提升通用场景性能|sig-Compiler|继承已有测试能力，重点验证kpatomic以及prefetch的功能和性能|√|×||
|77|远程证明统一框架(secgear)支持virtCCA Platform Token报告生成及验证|sig-confidential-computing|继承已有测试能力，重点验证virtCCA UEFI虚机/Direct Boot虚机远程证明/IMA度量远程证明|√|×||
|78|LLVM平行宇宙计划 RISC-V Preview 版本|sig-RISC-V|验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动|×|√||




## 新增需求清单

|编号|特性|状态|SIG|责任人|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| [2561](https://atomgit.com/openeuler/release-management/issues/2561) | 【openEuler 26.09创新】【Agent Infra】【Agent调度】通过数据引用方式按需加载构建上下文管理系统，减少上下文长度 | Developing | sig-Intelligence | [@linpengcheng1994](https://gitcode.com/linpengcheng1994)     | EPOL | sccs |
| [2562](https://atomgit.com/openeuler/release-management/issues/2562) | 【openEuler 26.09创新】【Agent Infra】【可观测&治理】构建可观测+治理框架底座，穿刺全链路观测+安全防护+审计能力 | Developing | sig-Intelligence | [@yaozhenhe](https://gitcode.com/yaozhenhe)     | EPOL | AcTrail |
| [2563](https://atomgit.com/openeuler/release-management/issues/2563) | 【openEuler 26.09创新】【Agent Infra】【Agent调度】Agent/KVC协同调度：感知“Agent语义”的KVC调度，降低Agent推理等待时延 | Developing | sig-Intelligence | [@xtchen](https://gitcode.com/xtchen)     | EPOL | RAM-A |
| [2564](https://atomgit.com/openeuler/release-management/issues/2564) | 【openEuler 26.09创新】【AI Infra】【推理加速】DDR+HBM 分级协同，KV swap聚合传输，长序列>64K 推理场景多BS降低平均时延 | Developing | sig-Intelligence | [@zxstty](https://gitcode.com/zxstty)     | EPOL | sysHAX |
| [2565](https://atomgit.com/openeuler/release-management/issues/2565) | 【openEuler 26.09创新】【开发者生态及工具】【skillhub】openEuler上线skillshub，汇聚社区skill生态 | Developing | sig-Devstation | [@ftboy](https://gitcode.com/ftboy)     | 独立发布 | wittyhub, wittyhub-cli |
| [2566](https://atomgit.com/openeuler/release-management/issues/2566) | 【openEuler 26.09创新】【开发者生态及工具】【DevStation】openEuler DevStation：面向用户和开发者快速迭代尝鲜的openEuler创新版本 | Developing | sig-Devstation | [@w520203](https://gitcode.com/w520203)     | 独立发布 | gdm, gnome-shell,gnome-session,epkg,polymind |
| [2567](https://atomgit.com/openeuler/release-management/issues/2567) | 【openEuler 26.09创新】【开发者生态及工具】【EPKG】完成EPKG默认集成到openEuler DevStation版本 | Developing | sig-epkg | [@w520203](https://gitcode.com/w520203)     | 独立发布 | epkg |
| [2568](https://atomgit.com/openeuler/release-management/issues/2568) | 【openEuler 26.09创新】oeaware：提供场景化智能调优skills | Developing | sig-Intelligence | [@cloudyyy1234](https://gitcode.com/cloudyyy1234)     | EPOL | witty-opentunex |
| [2569](https://atomgit.com/openeuler/release-management/issues/2569) | 【openEuler 26.09创新】【AI】【模型加速】ModelFS用户态模型加载优化方案 | Developing | sig-kernel | [@yubo-liu](https://gitcode.com/yubo-liu)     | ISO | kernel |
| [2570](https://atomgit.com/openeuler/release-management/issues/2570) | 【openEuler 26.09创新】【AI Infra】【推理加速】多级KV缓存+SSD直访，结合UB加速跨节点KV传输，长序列降低TTFT | Developing | sig-kernel,sig-Long | [@qiao-yifan4](https://gitcode.com/qiao-yifan4),[@chloroethylene](https://gitcode.com/chloroethylene)     | ISO | kernel, LMCache,LMCache-Ascend |



## 专项测试策略

### 安全测试


openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。主要测试项目如下表所示：

| 测试类         | 描述                                                 | 具体测试内容                                                 |
| :------------- | ---------------------------------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | 病毒/安全编译选项/敏感信息/端口 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全检查       | 开源合规license检查/签名和完整性校验/SBOM            | 检查软件包的license是否合规；对于发布件要求具备签名和完整性校验机制，如RPM需要具备GPG校验与签名；SBOM信息具备自动生成的能力，随软件发布件一起生成与发布 |


### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 测试类性     | 具体测试内容                                                 |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |



### 兼容性测试

创新版本不涉及


#### 虚拟化兼容性

虚拟化兼容性(openEuler作为host OS) 覆盖：
* CentOS 6/7/8(centos6只做x86)
* windows server 2016\2019
* Ubuntu 24.04(只做riscv64)


### 软件包管理专项测试

* 软件版本变更检查：检查前序版本的代码变动是否在当前版本继承，保证代码不漏合。
* 多动态库检查：检查软件是否存在多个版本动态库（存在编译自依赖软件包升级方式不规范）



# 测试执行策略

openEuler 26.09创新版本按照社区release-manager团队既定的版本计划，共有7轮测试，基本功能保障的beta版本设置在RC2 ，采用全量+增量结合的覆盖测试，保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归测试，视情况再预留1轮回归测试，具体测试安排见测试基线。

### 测试计划

openEuler 26.09版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| 阶段名称                      | PR截止时间 | 开始时间   | 结束时间   | 天数 | 说明                                     |
| ----------------------------- | --------------- | ---------- | ---------  | ---- | ---------------------------------------- |
| 关键特性收集                  |        -        | 2026/06/01 | 2026/07/30 | 60 | 版本需求收集                              |
| 变更评审 1                    |        -        | 2026/07/01 | 2026/08/13 | 44 | 评审软件包变更（升级/退役/淘汰）  |
| 继承特性合入                  |        -        | 2026/07/01 | 2026/08/13 | 44 | 继承特性合入（Beta前完成合入） |
| 开发阶段                      |        -        | 2026/07/01 | 2026/09/03 | 65 | 新特性开发，Branch前合入Master，Branch后合入Master+26.09-DevStation（round 6冻结前合入） |
| 内核冻结                      |        -        | 2026/07/01 | 2026/08/13 | 44 | 内核冻结（随Beta版本，内核冻结） |
| 拉取 26.09-DevStation 分支     |        -        | 2026/07/16 | 2026/07/22 | 07 | Master 拉取 26.09-DevStation 分支|
| 构建与 Alpha                  |    2026/07/23   | 2026/07/25 | 2026/08/07 | 14 | 新开发特性合入，Alpha版本发布（重点关注软件选型&构建问题） |
| 测试轮次 1                    |    2026/08/06   | 2026/08/08 | 2026/08/14 | 07 | 26.09-DevStation 模块测试           |
| 测试轮次 2（Beta版本）        |    2026/08/13   | 2026/08/15 | 2026/08/21 | 07 | 26.09-DevStation Beta版本发布（KABI基线）    |
| 变更评审 2                    |        -        | 2026/08/15 | 2026/08/20 | 06 | 发起软件包淘汰评审 |
| 测试轮次 3                    |    2026/08/20   | 2026/08/22 | 2026/08/28 | 07 | 26.09-DevStation 模块测试       |
| 测试轮次 4                    |    2026/08/27   | 2026/08/29 | 2026/09/04 | 07 | 全量验证（全量SIT）  |
| 变更评审 3                    |        -        | 2026/08/29 | 2026/09/03 | 06 | 发起软件包淘汰评审      |
| 测试轮次 5                    |    2026/09/03   | 2026/09/05 | 2026/09/11 | 07 | 分支冻结，只允许bug fix          |
| 测试轮次 6                    |    2026/09/10   | 2026/09/12 | 2026/09/18 | 07 | 回归测试                         |
| 测试轮次 7（预留）            |    2026/09/17   | 2026/09/19 | 2026/09/24 | 06 | 回归测试                         |
| 发布评审                      |        -        | 2026/09/22 | 2026/09/26 | 05 | 版本发布决策/ Go or No Go        |
| 发布准备                      |        -        | 2026/09/24 | 2026/09/26 | 03 | 发布前准备阶段，发布件系统梳理    |
| 发布                          |        -        | 2026/09/28 | 2026/09/30 | 03 | 社区Release评审通过正式发布       |




### 测试基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 26.09 Alpha         | 冒烟测试         |                                |
|                             | 包管理专项       | 软件包安装卸载                     |
|                             |                | 自编译                      |
|                             | 安装部署         | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像x86虚拟机                 |
|                             |                 | 标准镜像PXE安装                |
|                             | 内核           | 基本功能测试                   |
|                             | 包管理         | 软件包安装卸载                     |
|                             | 单包             | 单包命令            |
|                             |                  | 单包服务            |
|                             | 安全专项         |                |
|                             | 版本变化检查 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
| openEuler 26.09 RC1         | 冒烟测试         |                                |
|                             | 安装部署         | 标准镜像x86_64物理机 |
|                             |                 | everything镜像PXE安装                |
|                             | 内核             |                    |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             | 包管理        | 自编译      |
|                             | 文件系统     |                                |
|                             | 网络系统     |                                |
|                             | 重启            |  冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             | 版本变化检查 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
| openEuler 26.09 RC2         | 冒烟测试         |                                |
|                             | 安装部署         | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像x86虚拟机                 |
|                             |                  | 标准镜像u盘安装                 |
|                             | 虚拟机兼容性         |                      |
|                             | 内核              |                   |
|                             |                  | 长稳测试                  |
|                             | 单包             | 单包命令            |
|                             |                  | 单包服务            |
| openEuler 26.09 RC3         | 冒烟测试         |                                |
|                             | 安装部署         | 标准镜像x86_64物理机 |
|                             |                 | 标准镜像PXE安装                |
|                             | 内核             | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             | 文件系统     |                                |
|                             | 网络系统     |                                |
|                             | 重启            |  冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             | 版本变化检查 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
| openEuler 26.09 RC4         | 冒烟测试         |                                |
|                             | 安装部署         | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像x86虚拟机                 |
|                             |                 | everything镜像PXE安装                |
|                             | 内核              |                   |
|                             |                  | 长稳测试                  |
|                             | 包管理         | 软件包安装卸载                     |
|                             | 单包             | 单包命令            |
|                             |                  | 单包服务            |
|                             | 安全专项         |                |
| openEuler 26.09 RC5         | 冒烟测试         |                                |
|                             |                  | 标准镜像u盘安装                 |
|                             | 虚拟机兼容性         |                      |
|                             | 重启            |  冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             | 回归测试       | 问题单回归                        |
| openEuler 26.09 RC6         | 冒烟测试   |                    |
|                             | 安装部署         | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像x86_64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像x86虚拟机                 |
|                             |                 | 标准镜像PXE安装                |
|                             |                  | 标准镜像u盘安装                 |
|                             |                 | everything镜像PXE安装                |
|                             | 内核             | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             |                  | 长稳测试                  |
|                             | 包管理            | 软件包安装卸载                     |
|                             |                | 自编译                      |
|                             | 单包             | 单包命令            |
|                             |                  | 单包服务            |
|                             | 文件系统     |                                |
|                             | 网络系统     |                                |
|                             | 安全专项         |                |
|                             | 版本变化检查 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 回归测试       | 问题单回归                        |
| 发布件测试。                  |    |                    |
|                             |   |                    |
|                             | release发布件测试      |                         |
|                             | 发布件sha256值校验       |                       |
|                             | sbom、sha256sum文件|                    |
|                             | rpm包签名  |                    |


### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

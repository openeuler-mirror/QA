![openEuler ico](../../images/openEuler.png)

版权所有 © 2026  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2026/9/22 | 1.0.0    | 初稿 | linqian0322 |
| 2026/9/28 | 1.0.1    | 刷新继承特性验证结果和新需求验证情况 | linqian0322 |
| 2026/9/30 | 1.0.2    | 刷新继承特性验证结果和新需求问题回归情况 | linqian0322 |


摘要：

文本主要描述openEuler 26.09 devstation版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 26.09版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 26.09版本是双内核创新版本，在面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展的同时提供面向开发者的智能工作站桌面环境，具备开箱即用、集成AI能力等优势，给开发者和用户带来全新的体验；服务更多的领域和更多的用户。该版本基于openEuler master分支拉出，发布范围相较25.09版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitcode.com/openeuler/release-management/blob/master/openEuler-26.09-DevStation/release-change.yaml)
2.  修复bug和cve


## 2.1 版本测试计划
openEuler 26.09版本按照社区release-manager团队的计划，详细的版本信息和测试时间如下表：


| 阶段名称                      | PR截止时间 | 开始时间   | 结束时间   | 天数 | 说明                                     |
| ----------------------------- | --------------- | ---------- | ---------  | ---- | ---------------------------------------- |
| 关键特性收集                  |        -        | 2026/06/01 | 2026/07/30 | 60 | 版本需求收集                              |
| 变更评审 1                    |        -        | 2026/07/01 | 2026/08/15 | 46 | 评审软件包变更（升级/退役/淘汰）  |
| 继承特性合入                  |        -        | 2026/07/01 | 2026/08/15 | 46 | 继承特性合入（Beta前完成合入） |
| 开发阶段                      |        -        | 2026/07/01 | 2026/09/02 | 64 | 新特性开发，Branch前合入Master，Branch后合入26.09-DevStation及Master，6.6内核合入26.09分支(round 6冻结前合入) |
| 内核冻结                      |        -        | 2026/07/01 | 2026/08/15 | 46 | 内核冻结（随Beta版本，内核冻结） |
| 拉取 26.09-DevStation 分支     |        -        | 2026/07/20 | 2026/07/31 | 12 | Master拉取26.09-DevStation分支，内核额外拉取26.09分支用于6.6版本 |
| 构建与 Alpha                  |    2026/08/05   | 2026/08/07 | 2026/08/13 | 07 | 新开发特性合入，Alpha版本发布（重点关注软件选型&构建问题） |
| 测试轮次 1                    |    2026/08/12   | 2026/08/14 | 2026/08/20 | 07 | 26.09-DevStation 模块测试           |
| 测试轮次 2（Beta版本）        |    2026/08/19   | 2026/08/21 | 2026/08/27 | 07 | 26.09-DevStation Beta版本发布（KABI基线）    |
| 变更评审 2                    |        -        | 2026/08/21 | 2026/08/26 | 06 | 发起软件包淘汰评审 |
| 测试轮次 3                    |    2026/08/26   | 2026/08/28 | 2026/09/03 | 07 | 26.09-DevStation 模块测试       |
| 测试轮次 4                    |    2026/09/02   | 2026/09/04 | 2026/09/10 | 07 | 全量验证（全量SIT）  |
| 变更评审 3                    |        -        | 2026/09/04 | 2026/09/09 | 06 | 发起软件包淘汰评审      |
| 测试轮次 5                    |    2026/09/09   | 2026/09/11 | 2026/09/17 | 07 | 分支冻结，只允许bug fix          |
| 测试轮次 6                    |    2026/09/16   | 2026/09/18 | 2026/09/23 | 07 | 回归测试                         |
| 发布评审                      |        -        | 2026/09/21 | 2026/09/24 | 04 | 版本发布决策/ Go or No Go, 中秋快乐        |
| 发布准备                      |        -        | 2026/09/23 | 2026/09/24 | 02 | 发布前准备阶段，发布件系统梳理    |
| 发布                          |        -        | 2026/09/28 | 2026/09/30 | 03 | 社区Release评审通过正式发布       |


## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920(支持1.70以上的bios版本)        | OS集成测试     |
| RH2288H V3            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| 算能            | 算丰SG2042 | OS集成测试     |

## 2.3 需求清单

openEuler 26.09版本交付需求列表如下，详情见[openEuler-26.09 release plan](https://gitcode.com/openeuler/release-management/blob/master/openEuler-26.09-DevStation/release-plan.zh.md)：

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

## 2.4 测试活动分工
 本次版本继承测试活动分工如下：

| 序号   | 需求 | 开发主体 | 测试主体  | 测试分层策略 |
| :--- | :--- | :--- | :--- | :--- |
|1| 支持UKUI桌面    | sig-UKUI  | sig-UKUI | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
|2| 支持DDE桌面                                           | sig-DDE | sig-DDE  | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
|3| 支持Kiran桌面     | sig-KIRAN-DESKTOP  | sig-KIRAN-DESKTOP  | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
|4| 安装部署                                              | sig-OS-Builder| sig-QA  | 验证覆盖裸机/虚机场景下，通过光盘/PXE等安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
|5|内核                                                  | Kernel | Kernel | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
|6|容器(isula/docker/安全容器/系统容器/镜像)             | sig-CloudNative | sig-CloudNative| 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
|7| 虚拟化                                                | Virt| Virt  | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能       |
|8|系统性能自优化组件A-Tune                                            | A-Tune  | A-Tune | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
|9| 支持secPaver                                           | sig-security-facility | sig-QA  | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
|10|支持secGear                                           | sig-confidential-computing   | sig-QA | 关注secGear特性的功能完整性                                  |
|12|支持kubeOS                                            | sig-CloudNative  | sig-QA | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
|13| 支持etmem                               | Storage   | sig-QA  | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
|14| 支持用户态协议栈gazelle                               | sig-high-performance-network | sig-QA | 关注gazelle高性能用户态协议栈功能                            |
|15| 支持国密算法                                          | sig-security-facility| sig-QA  | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
|16| 支持pod带宽管理oncn-bwm                               | sig-high-performance-network | sig-QAk | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
|17| iSulad                                 | sig-iSulad   | sig-QA  |  覆盖继承功能，重点验证isulad长稳场景                 |
|18| 支持系统运维套件x-diagnosis                           | sig-ops | sig-QA | 覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能  |
|19| 支持自动化热升级组件nvwa                              | sig-ops  | sig-QA    | 覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 |
|20| 支持DPU直连聚合特性dpu-utilities                                   | sig-DPU | sig-DPU  | 验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 |
|21| 支持系统热修复组件syscare                             | sig-ops | sig-QA | 验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力      |
|22| iSula容器镜像构建工具isula-build                      | sig-iSulad   | sig-QA  | 验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 |
|23| 支持进程完整性防护特性DIM                                | sig-security-facility  | sig-security-facility  | 验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 |
|24| 支持入侵检测框架secDetector                           | sig-security-facility | sig-security-facility  | 验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 |
|25| isocut镜像裁剪                              | sig-OS-Builder| sig-OS-Builder | 验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 |
|26| 支持devmaster组件                                     | sig-dev-utils  | sig-dev-utils  | 验证devmaster的安装部署、进程配置、客户端工具等使用场景      |
|27|支持TPCM特性                                          | sig-Base-service | sig-Base-service   | 验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 |
|28| 支持sysMaster组件                                     | sig-dev-utils   | sig-dev-utils    | 验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景 |
|29| 支持sysmonitor特性                                    | sig-ops  | sig-QA   | 验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景 |
|30| 支持容器场景在离线混合部署rubik                       | sig-CloudNative | sig-CloudNative | 结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
|31| 支持IMA|   sig-security-facility  | sig-QA | 验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式 |
|32| 支持IMA virtCCA |  sig-security-facility  |  sig-QA  | 验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等  |
|33| 安全启动 |  sig-security-facility  |  sig-QA  | 验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等； |
|34| Kmesh |  sig-ebpf  | sig-QA   | 验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等 |
|35| openEuler安全配置规范框架设计及核心内容构建 |  sig-security-facility  |  sig-QA  | 验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性 |
|36| oemaker |  sig-OS-Builder  |  sig-QA  | 重点验证oemaker在构建工程中功能正常  |
|37| openssl |  sig-security-facility  |  sig-QA  | 验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上 |
|38|编译器(gcc/jdk)                                       | Compiler  | sig-QA  | 基于开源测试套对gcc和jdk相关功能进行验证                     |
|39| 支持HA软件                                            | sig-Ha | sig-Ha  | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
|40|支持KubeSphere                                        | sig-K8sDistro | sig-K8sDistro | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
|41| 支持智能运维助手                                     | sig-ops| sig-QA   | 关注智能定位（异常检测、故障诊断）功能、可靠性               |
|42| 支持k3s                                               | sig-K8sDistro| sig-K8sDistro | 验证k3s软件的部署测试过程                                    |
|43| migration-tools增加图形化迁移openeuler功能            | sig-Migration| sig-Migration  | 验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 |
|44| 发布Nestos-kubernetes-deployer                        | sig-K8sDistro  | sig-K8sDistro  | 验证在NestOS上部署，升级和维护kubernetes集群功能正常         |    
|45| 支持NestOS                                            | sig-CloudNative | sig-CloudNative | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
|46| 发布PilotGo及其插件特性新版本                         | sig-ops  | sig-QA  | 验证PilotGo支持 topo 图的展示和智能调优能力                  |
|47| 社区签名体系建立                                      | sig-security-facility  | sig-security-facility        | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
|48| 智能问答在线服务                                      | sig-A-Tune  | sig-QA   | 验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 |
|49| 支持GreatSQL                               | sig-DB    | sig-DB    | 验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库 |
|50| ZGCLab 发布内核安全增强补丁                           | sig-kernel   | sig-kernel   | 针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 |
|51| 支持RISC-V                                            | sig-RISC-V | sig-RISC-V  | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
|52|为 RISC-V 架构引入 Penglai TEE 支持                   | sig-RISC-V | sig-RISC-V | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 |
|53| Add compatibility patches for Zhaoxin processors    |  sig-kernel |  sig-kernel |  验证集成了Zhaoxin OLK-6.6补丁的内核镜像系统正常运行以及对应补丁的功能测试   |
|54| virtCCA机密虚机特性合入       | sig-kernel/sig-virt  | sig-kernel/sig-virt  |   继承已有测试能力，重点验证机密虚机的基本功能、安全、兼容性以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试  |  
|55| 增加 utsudo 支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utsudo基础命令使用正常   |   
|56| 增加 utshell支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utshell基础命令使用正常   |
|57| LLVM多版本实现                      | sig-Compiler  |  sig-Compiler |  继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。   |
|58| 新增密码套件openHiTLS               |  sig-security-facility |  sig-security-facility |  继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试    |
|59| AI流水线oeDeloy       | sig-cicd  | sig-QA  |  继承已有测试能力，重点验证通过oeDeploy进行kubeflow部署及k8s基础功能测试   |
|60| 支持oeaware                |  sig-A-Tune | sig-QA  |  继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容  |
|61| DevStation 开发者工作站支持                      | sig-desktop  | sig-QA  |   继承已有测试能力，重点验证安装部署启动、支持图形化编程环境，以及融合的epkg、Eulercopilot、x2openEuler的基本功能 |
|62| AI集群慢节点快速发现 Add Fail-slow Detection      | sig-desktop   |  sig-desktop |  继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度   |
|63| RPM国密签名支持                             | sig-security-facility  | sig-security-facility  |  重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容   |
|64| 鲲鹏KAE加速器驱动安装包合入                  | sig-kernel  | sig-kernel  |  继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩   |
|65| Add Intel QAT packages support    | sig-Intel-Arch  | sig-Intel-Arch  |  继承已有测试能力，重点验证intel qat相关软件包的功能和性能    |
|66| 版本引入ACPO包    | sig-Compiler  |  sig-Compiler |  继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容   |
|67| 内核TCP/IP协议栈支持CAQM拥塞     |  sig-kernel |  sig-kernel |  继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能   |
|68| 为AArch64编译默认开启PAC/BTI | sig-Arm | sig-Arm | 继承已有测试能力，主要覆盖功能测试和兼容性测试，重点关注通过读取软件包中的二进制ELF文件检查PAC/BTI的支持情况 |
|69| 基于sysboost实现启动时优化，通用兼容性增强 | sig-Compiler| sig-Compiler |验证HOST和容器场景，涉及功能、可靠性、性能、安全测试，重点关注可靠性测试 |
|70| GCC for openEuler编译链接加速，缩减编译时间 | sig-Compiler| sig-QA | 验证打开PGO+LTO优化GCC + mold链接器编译94个C/C++组件，编译总时间对比基线，编译时间减少比例达到9.55%|
|71| 机密容器Kuasar适配virtCCA | sig-CloudNative| sig-CloudNative |针对机器容器的基本功能进行测试，包括生命周期，服务稳定性，资源占用，并发测试，资源残留等功能场景进行测试|
|72| secGear支持机密容器镜像密钥托管 | sig-security-facility|sig-security-facility | 基于token获取秘钥，验证秘钥的增删改查、秘钥绑定、解绑策略、策略的增删查询|
|73| 构建基于远程证明的TLS协议（RA-TLS） | sig-security-facility|sig-security-facility |验证服务端生成自签名证书功能测试、各对外接口正常和异常测试，包括各个参数的正常、异常值测试 |
|74| Trace IO加速容器快速启动 | sig-Kernel| sig-Kernel| 验证开启TrIO特性后加载web类容器和应用类容器的启动、删除场景 |
|75| 引入vkernel概念增强容器隔离能力 | sig-Kernel| sig-Kernel | 针对其功能、性能和兼容性进行LTP、UnixBench、容器运行时对比、容器生态兼容、相关应用性能进行测试|
|76| openAMDC合入 | sig-BigData| sig-BigData | 验证软件的核心功能模块，包括string、list、hash、set、sortedset等数据类型读写和主从复制、服务高可用功能 |
|77| oeAware支持瓶颈评估一键推荐调优等特性增强 | sig-A-Tune | sig-QA |验证透明大页场景识别、透明大页使能禁用、查询模块显示以及虚拟网卡亲和配置场景功能测试、异常测试|
|78| oeDeploy 部署能力增强 | sig-ops | sig-ops | 继承已有测试能力，功能测试覆盖ray、kubeflow相关组件、TensorFlow、Pytorch、EulerMaker组件单机及分布式部署 |
|79| DevStation社区原生/图形化/南向兼容性等新增特性 | sig-ops/IDE |sig-QA | 验证默认集成epkg/eulercopilot/oeDeploy/devkit、支持常用浏览器/邮箱、支持社区开发环境，以及南向支持裸机部署等测试|
|80| 云原生基础设施部署升级工具k8s-isntall 加入版本 | sig-cloudnative  | sig-cloudnative | 验证功能测试、性能测试和异常处理测试，重点验证k8s-install工具支持在线/离线模式下一键式安装部署云原生基础设施的能力，未发现问题整体质量良好|

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试


# 3 版本概要测试结论

   openEuler 26.09版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 3轮继承特性和新增特性合入测试 + 2轮全量测试 + 2轮回归测试（版本发布验收测试）；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项。测试也提前介入，覆盖冒烟测试、包管理、安装部署等基础测试项； 第2轮主要覆盖冒烟测试、安装部署、单包等OS测试项；第3、４轮重点聚焦在已合入的新需求测试和继承特性验证; 第5、6回归测试和扩展测试以及验证问题的修复；最后一轮还包括版本发布验收测试，是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。


   openEuler 26.09版本共发现问题 617 个，有效问题 595 个，遗留问题 1个，风险可控，版本整体质量良好。



# 4 版本详细测试结论

openEuler 26.09版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险

4、专项测试包括安全专项、性能测试、可靠性测试、资料测试

5、对版本新增特性进行测试，新增特性均满足发布要求，测试较充分，质量良好

## 4.1   特性测试结论

### 4.1.1   继承特性评价

| 序号   | 需求 | 责任主体 | 测试重点  | arm/x86质量评估 | riscv rva23评估 | 
|:--- |:--- |:--- |:--- |:--- |:--- |
|1|UKUI桌面|sig-UKUI|验证UKUI桌面系统在openEuler版本上的可安装和基本功能|<font color=green>█</font>||
|2|DDE桌面|sig-DDE|验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标|<font color=green>█</font>||
|3|Kiran桌面|sig-KIRAN-DESKTOP|验证kiran桌面在openEuler版本上的可安装卸载和基本功能|<font color=green>█</font>
|4|安装部署|sig-OS-Builder|验证覆盖裸机/虚机场景下，通过光盘/PXE等安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署|<font color=green>█</font>
|5|内核|sig-Kernel|关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；|<font color=green>█</font>|
|6|虚拟化|sig-Virt|重点关注回合新特性后，新版本上虚拟化相关组件的基本功能|<font color=green>█</font>
|7|A-Tune|sig-A-Tune|重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注|<font color=green>█</font>
|8|secPaver|sig-security-facility|验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性|<font color=green>█</font>
|9|secGear|sig-confidential-computing|继承已有测试能力，验证secGear特性的功能完整性，包括远程证明基线与策略导入，查询，创建、加解密、边界检查、生成随机数、打印、销毁等特性正常运行|<font color=green>█</font>
|10|etmem|sig-Storage|重点验证继承特性的基本功能和稳定性，如memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力|<font color=green>█</font>||
|11|gazelle|sig-high-performance-network|继承已有测试能力，验证gazelle高性能用户态协议栈功能，包括支持ceph,支持DWS，支持单网卡negligible，支持苏移krpc，一键脚本部署等继承功能|<font color=green>█</font>
|12|国密全栈|sig-security-facility|继承已有测试能力，验证SSH协议栈、TLCP协议栈、内核模块签名、安全启动、文件完整性保护、用户身份鉴别、磁盘加密、算法库等模块支持国密算法|<font color=green>█</font>
|13|pod带宽管理|sig-high-performance-network|验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试|<font color=green>█</font>
|14|iSulad|sig-iSulad|继承已有测试能力，覆盖继承功能cgroup v2,热升级，健康检查，本地卷，容器生命周期管理，镜像管理，资源管理等，重点验证isulad长稳场景|<font color=green>█</font>
|15|Kuasar|sig-CloudNative|继承已有测试能力，重点验证kuasa的容器运行时特性以及kuasa机密容器适配virtCCA、容器镜像加解密等|<font color=green>█</font>
|16|X-diagnosis|sig-ops|继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能|<font color=green>█</font>
|17|nvwa|sig-ops|覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等|<font color=green>█</font>
|18|dpu-utilities|sig-DPU|验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源|<font color=green>█</font>
|19|syscare|sig-ops|继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力|<font color=green>█</font>
|20|DIM|sig-security-facility|继承已有测试能力，验证dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等，用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量，以及度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量|<font color=green>█</font>
|21|secDetector|sig-security-facility|继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等|<font color=green>█</font>
|22|devmaster|sig-dev-utils|继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景|<font color=green>█</font>
|23|TPCM|sig-Base-service|验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等|<font color=green>█</font>
|24|sysMaster|sig-dev-utils|验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景|<font color=green>█</font>
|25|sysmonitor|sig-ops|继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景|<font color=green>█</font>
|26|混合部署|sig-CloudNative|结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试|<font color=green>█</font>
|27|安全配置工具|sig-security-facility|使用Linux系统安全检查工具secureguardian，通过执行一系列的安全检查脚本, 查看生成的安全报告，评估系统的安全性是否存在风险|<font color=green>█</font>
|28|安全配置规范框架设计及核心内容构建|sig-security-facility|继承已有测试能力，验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性|<font color=green>█</font>
|29|IMA|sig-security-facility|验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式|<font color=green>█</font>
|30|支持IMA virtCCA|sig-security-facility|验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等|<font color=green>█</font>
|31|安全启动|sig-security-facility|验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等|<font color=green>█</font>
|32|Kmesh|sig-ebpf|验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等|<font color=green>█</font>
|33|openssl|sig-security-facility|验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上|<font color=green>█</font>
|34|远程证明统一框架|sig-security-facility|继承已有测试能力，重点验证ta被篡改后、严格模式和宽松模式下的远程通道能力等功能|<font color=green>█</font>
|35|A-ops|sig-ops|继承已有测试功能，验证容器干扰检测，微服务性能问题分钟级定位定界场景、AI集群慢节点快速发现、 基于通信算子的低开销高精度慢节点检测 、支持典型内存故障定位等能力|<font color=green>█</font>
|36|KubeOS|sig-CloudNative|验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级|<font color=blue>▲</font>
|37|编译器(gcc/jdk)|sig-Compiler|基于开源测试套对gcc和jdk相关功能进行验证|<font color=green>█</font>
|38|支持HA软件|sig-Ha|验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标|<font color=green>█</font>
|39|支持k3s|sig-K8sDistro|继承已有测试能力，验证k3s软件的部署功能正常|<font color=green>█</font>
|40|智能问答在线服务|sig-intelligence|继承已有测试能力，验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力|<font color=green>█</font>
|41|支持GreatSQL|sig-DB|验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库|<font color=green>█</font>
|42|增加 utsudo 支持|sig-memsafety|继承已有测试能力，验证utsudo基础命令使用正常|<font color=green>█</font>
|43|增加 utshell支持|sig-memsafety|继承已有测试能力，验证utshell基础命令使用正常|<font color=green>█</font>
|44|LLVM多版本实现|sig-Compiler|继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。| <font color=green>█</font>
|45|新增密码套件openHiTLS|sig-security-facility|继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试| <font color=green>█</font>
|46|支持oeaware|sig-A-Tune|继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容|<font color=green>█</font>
|47|鲲鹏KAE加速器驱动安装包合入|sig-kernel|继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩|<font color=green>█</font>
|48|Add Intel QAT packages support|sig-Intel-Arch|继承已有测试能力，重点验证intel qat相关软件包的功能和性能|<font color=green>█</font>
|49|版本引入ACPO包|sig-Compiler|继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容| 9.28反馈测试结果
|50|openAMDC合入|sig-BigData|验证软件的核心功能模块，包括string、list、hash、set、sortedset等数据类型读写和主从复制、服务高可用功能| <font color=green>█</font>
|51|DevStation|sig-Devstation|继承已有测试能力，围绕智能化的一站式开发环境，验证devstation图形化编程环境、智能助手、原生开发工具链（如oedp）以及开发者软件商店等主要功能|<font color=green>█</font>
|52|支持树莓派|sig-SBC|继承已有测试能力，对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性等测试|<font color=green>█</font>
|53|远程证明统一框架(secgear)支持virtCCA Platform Token报告生成及验证|sig-confidential-computing|继承已有测试能力，重点验证virtCCA UEFI虚机/Direct Boot虚机远程证明/IMA度量远程证明|<font color=green>█</font>
|54|LLVM平行宇宙计划 RISC-V Preview 版本|sig-RISC-V|验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动||risc-v测试进度延迟| 
|55|NestOS Kubernetes Deployer |sig-k8sDistro|继承已有测试能力，重点验证基础设施&Kubernetes集群的部署、扩展与销毁;aarch64和x86_64架构的兼容性测试以及操作响应测试；|<font color=green>█</font>

|<font color=green>█</font>

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价


对新需求进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **aarch64/x86_64质量评估**    |  **risc-v质量评估**    |       **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | ---------------- | ---------------- | ---------------- | -------------- | 
| 1 | [【openEuler 26.09创新】【Agent Infra】【Agent调度】通过数据引用方式按需加载构建上下文管理系统，减少上下文长度](https://gitcode.com/openeuler/QA/pull/1524)| SCCS 特性共计执行40个对照测试样本，主要覆盖了功能测试（引用替换/按需取回全链路验证、会话与进程隔离）、基于 SWE-bench 的端到端正确率对照测试以及 input 上下文长度测试；以及性能、安全、可靠性和资料测试。无遗留风险，整体质量良好| |  |  <font color=green>█</font>|  | |
| 2 | [【openEuler 26.09创新】【Agent Infra】【可观测&治理】构建可观测+治理框架底座，穿刺全链路观测+安全防护+审计能力]()| AcTrail（Agent长稳可靠运行）特性面向AI Agent运行时的可观测性与治理，并基于可观测结果进行离线评测并给出检测结果展示，AgentCensor基于AcTrial数据采集能力，增强了基于session的富观测能力，同时面向Agent运行时的安全管控与审计系统实现对agent审计支持，覆盖功能测试（含接口测试）、性能测试、可靠性、兼容性、安全测试和资料测试，全部通过，共发现问题32个，均已解决回归通过，无遗留问题|  ||  <font color=green>█</font>
| 3 | [【openEuler 26.09创新】【Agent Infra】【Agent调度】Agent/KVC协同调度：感知“Agent语义”的KVC调度，降低Agent推理等待时延](https://gitcode.com/openeuler/QA/pull/1527)| 记忆智能RAM-A-KV特性，共计执行22个用例，覆盖了场景、接口、功能、可靠性、性能测试和安全测试，发现有效问题6个，已全部解决，回归通过，无遗留风险，整体质量良好 |   | | <font color=green>█</font>||配套昇腾 NPU 与 CANN 驱动 ||
| 4 | [【openEuler 26.09创新】【AI Infra】【推理加速】DDR+HBM 分级协同，KV swap聚合传输，长序列>64K 推理场景多BS降低平均时延](https://gitcode.com/openeuler/QA/pull/1539)| K+X 内存协同 DSA Decode 卸载及 Sparse KV 小包聚合特性，在序列长度大于 64K 场景下，Sparse KV Offload 推理 TPOT 小于 50ms，推理吞吐相对基线提升 10%，符合需求；小包聚合功能正常，运行结果正确；小包聚合掩盖传输，实现 KV swap 倍级提升（相对离散 H2D，speedup 约 1.5x～5.1x），未发现问题，无遗留风险，整体质量良好。 | |  | <font color=green>█</font>| |
| 5 | [【openEuler 26.09创新】【开发者生态及工具】【skillhub】openEuler上线skillshub，汇聚社区skill生态](https://gitcode.com/openeuler/QA/pull/1521)|SkillHub 平台特性测试，共计执行 50 个用例，主要覆盖了功能测试、安全测试、性能测试、可靠性测试和资料测试，用例全部通过，发现6个问题，已全部解决回归通过，无遗留问题，整体质量良好 |   || <font color=green>█</font>||||
| 6 | [【openEuler 26.09创新】【开发者生态及工具】【DevStation】openEuler   DevStation：面向用户和开发者快速迭代尝鲜的openEuler创新版本](https://atomgit.com/openeuler/QA/pull/1522)|  DevStation组件升级特性测试共执行118个用例，主要覆盖Gnome 49、内核6.18、nodejs 22三项新增需求功能测试、继承特性回归测试、桌面系统基线测试，以及安全、可靠性与性能DFX专项测试。共发现问题4个，已全部闭环，回归通过，无遗留风险，整体质量良好|  |  |  <font color=green>█</font>
| 7 | [【openEuler 26.09创新】【开发者生态及工具】【EPKG】完成EPKG默认集成到openEuler DevStation版本](https://gitcode.com/openeuler/QA/pull/1523)|本次测试共执行49个测试用例，主要覆盖功能测试、兼容性测试及性能测试。其中49个用例通过，0个用例未通过，发现两个问题，已全部闭环，回归通过，无遗留风险，整体质量良好|  |  |<font color=green>█</font>
| 8 | [【openEuler 26.09创新】oeaware：提供场景化智能调优skills]()| 场景化智能调优skills针对9个场景的数据采集，分析并给出调优建议。共执行13个用例，主要覆盖了功能测试、兼容性测试、可靠性测试以及性能测试，共发现9个问题，均已解决并回归通过|  | |  <font color=green>█</font>
| 9 | [【openEuler 26.09创新】【AI】【模型加速】ModelFS用户态模型加载优化方案]()| maio-utils可编程缓存框架特性测试用户态设备监听、事件读取/处理，预读/trace/回放/移除策略等，共执行12个用例，主要覆盖功能测试、fuzz测试，所有用例执行通过，未发现问题，特性整体质量良好| | |  <font color=green>█</font>
| 10 | [【openEuler 26.09创新】【AI Infra】【推理加速】多级KV缓存+SSD直访，结合UB加速跨节点KV传输，长序列降低TTFT](https://gitcode.com/openeuler/QA/pull/1547)| KVC池化&多级KV缓存特性主要覆盖了功能测试和性能测试和资料测试，功能测试包含PD分离和P2P池化模式，性能测试取大模型首Token生成时间ttft值，P2P池化在整体表现上降低50%，PD分离在整体表现上降低30%，共发现5个问题，已全部闭环无遗留风险，整体质量良好 |  |  | <font color=green>█</font>

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1 虚机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 |
| ---------- | ----------------------- | ------- | -------- |
| openEuler 26.09 | Centos 6 | x86_64 | PASS |
| openEuler 26.09 | Centos 7 | aarch64 | PASS |
| openEuler 26.09 | Centos 7 | x86_64  | PASS |
| openEuler 26.09 | Centos 8 | aarch64 | PASS |
| openEuler 26.09 | Centos 8 | x86_64  | PASS |
| openEuler 26.09  | Windows Server 2016 | x86_64  | PASS |
| openEuler 26.09  | Windows Server 2019 | x86_64  | PASS |

## 4.3   专项测试结论

### 4.3.1 安全测试

整体安全测试覆盖：

1、病毒扫描
测试内容：使用openlibing平台病毒扫描工具，对aarch64、x86_64架构的Everything(包含BaseOS)、EPOL所提供软件包、源码包进行病毒扫描。
测试结果：共计扫描55,124个rpm包（Everything(包含BaseOS) 35,375个、EPOL 13,677个、SOURCE 6,072个）。经3种病毒扫描引擎扫描，仅1种病毒引擎存在告警一项，病毒类型：PUP.Netcat，病毒文件指向nmap的/usr/bin/ncat。经病毒引擎提供方确认，网络扫描工具视为潜在有害程序进行默认进行告警，经openEuler安委会评审无安全风险

2、漏洞扫描
测试说明：openEuler-26.09-DevStation 为创新版本，漏洞扫描不作为版本安全测试项

3、安全编译选项扫描
测试说明：使用openlibing平台二进制扫描工具，对aarch64、x86_64架构的BaseOS所提供软件包进行安全编译选项（包括BIND_NOW、NX、PIE、RELRO、SP、NO Rpath/Runpath、Strip）扫描。
测试结果：共计扫描5,107个rpm包（aarch64 2,545个、x86_64 2,562个），发现问题12个（aarch64 10个、x86_64 2个），均已闭环，无风险。

4、安全测试基线用例
测试说明：使用openscap、mugen对标准镜像进行用例测试。覆盖初始部署、安全访问、运行服务、日志审计等方面。
测试结果：mugen用例测试在aarch64与x86_64上分别执行security_guide 49个、security_test 71个用例，用例数及通过数与上一版本保持一致，无遗留问题无风险。openscap为创新版本已评审通过，无需测试

5、开源片段引用扫描
测试说明：对openEuler社区孵化软件包仓库使用openlibing平台开源合规扫描工具进行扫描
测试结果：共计扫描代码仓118个，待处理风险数均已清零

6、开源合规license检查
测试说明：对于Everything (包含BaseOS)、EPOL提供的软件包，根据SBOM文件扫描License合规情况。
测试结果：共计扫描41,675个rpm包，发现问题40个（Everything 26个、EPOL 14个），闭环38个，新增2个License（均为EPOL范围）合规SIG评审已通过，无风险）

7、软件包签名检查
测试说明：对于Everything (包含BaseOS)、EPOL提供的软件包，使用rpm工具进行签名校验
测试结果：共计验证55,124个rpm包，均通过签名检查

8、ISO签名及SBOM检查
测试说明：版本发布后对应的ISO镜像存在sha256sum签名文件，SBOM文件、SBOM文件签名
测试结果：待更新。ISO镜像sha256sum文件、SBOM文件及SBOM签名情况待版本正式发布后更新，发布件以正式发布目录为准

openEuler-26.09-DevStation 版本安全测试已完成，包含社区安全保障策略中所有安全测试项目。测试发现问题均已完成修复及评估，无遗留问题无风险。
详细报告见：
https://gitcode.com/openeuler/QA/blob/72b7479daf0673f157c6069f4ff533c21f8ac258/Test_Result/openEuler-26.09-DevStation/openEuler-26.09-DevStation版本安全测试报告.md

### 4.3.2 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                                                    |
| ------------ | ------------------------------------------------------------ | ----------------------------------------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况；稳定性测试时长7\*24 |通过 |

### 4.3.3 性能测试
创新版本不涉及

### 4.3.4 devstation桌面开发环境（6.18内核）测试
#### 4.3.4.1 特性概述

DevStation是openEuler面向开发者打造的智能工作站操作系统版本。openEuler 26.09 DevStation基于6.18新内核，围绕智能化一站式开发环境，为开发者提供开箱即用、集成AI能力、高效安全的开发环境。

本版本交付需求包括五项新增需求与六项继承需求，具体如下：

#### 4.3.4.2 新增需求

- Gnome相关组件软件包升级至49版本，保持与上游社区稳定版本同步
- 内核升级至6.18，保持与上游社区稳定版本同步
- nodejs升级至22版本，符合openclaw等agent最低的部署运行要求
- 集成智能问答工具polymind，支持开发者通过问答的方式获取相关信息
- 支持epkg包管理工具，可在DevStation上方便地安装、升级、删除软件包

#### 4.3.4.3 继承需求

- 支持开发者友好的图形化编程环境（vim、gcc、gdb、gnome、vscode等默认安装）
- DevStation智能助手（问答、智能shell等交互方式）
- 支持社区原生开发工具链（oeDeploy一键式部署等）
- 支持开发者软件商店（常用软件、服务一键式获取）
- 支持PC清单：thinkbook E16、华硕天选4 锐龙版、惠普Book Pro 14 锐龙版
- 支持服务器型号：920、920新型号

#### 4.3.4.4 特性测试信息

描述特性测试的硬件环境信息

| 硬件型号              | 硬件配置信息                                       | 备注           |
| --------------------- | -------------------------------------------------- | -------------- |
| ThinkBook E16         | x86 Intel i7-13700H，16核心，32G内存，1TB SSD      | x86架构 PC     |
| 华硕天选4 锐龙版      | x86 AMD Ryzen 7 7735H，16核心，32G内存，RTX 4050   | x86架构 PC     |
| 惠普 Book Pro 14 锐龙版 | x86 AMD Ryzen 7 7735H，16核心，16G内存，512GB SSD | x86架构 PC     |
| 鲲鹏 920 服务器       | ARM Kunpeng 920-6426，64核心，256G内存             | ARM架构 服务器 |
| 鲲鹏 920 新型号服务器 | ARM Kunpeng 920，64核心，256G内存                  | ARM架构 服务器 |


#### 4.3.4.5  测试整体结论

openEuler 26.09 DevStation版本测试共执行139个用例，主要覆盖五项新增需求功能测试、六项继承需求回归测试、桌面系统测试基线测试，以及安全、可靠性与性能DFX专项测试。共发现问题4个，已全部闭环，回归通过，无遗留风险，整体质量良好。

测试缺陷密度：共发现4个问题，集中在新增6.18内核驱动与gdm启动日志，缺陷密度合理，质量风险可控。

| 测试活动     | 测试子项         | 活动评价               |
| ------------ | ---------------- | ---------------------- |
| 功能测试     | 继承特性测试     | 质量良好               |
| 功能测试     | 新增特性测试     | 质量良好               |
| 兼容性测试   |                  | 质量良好               |
| DFX专项测试  | 性能测试         | 质量良好（摸底测试）   |
| DFX专项测试  | 可靠性/韧性测试  | 质量良好               |
| DFX专项测试  | 安全测试         | 质量良好               |
| 资料测试     |                  | 继承已完成             |
| 其他测试     |                  | 质量良好               |

详细测试报告见：
https://gitcode.com/openeuler/QA/pull/1535

# 5   问题单统计

openEuler 26.09版本共发现有效问题596个，其中遗留问题1个，详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 
| --------------------------- | -------- | ------------ | ------------ | ------------ | 
| openEuler 26.09  alpha      | 295  |  286 |  9  |   0   |
| openEuler 26.09  RC1        | 76 |  69 |  7 |   0  | 
| openEuler 26.09  RC2        | 131  |  128 |  3 |   1   | 
| openEuler 26.09  RC3        | 31  |  30 |  1 |   0  |
| openEuler 26.09  RC4        | 56  |  55 | 1   |  0 | 
| openEuler 26.09  RC5        | 19  |  19 |   |   0   |
| openEuler 26.09 RC6         |  8  |  8  |    |   0   | 
| openEuler 26.09 RC7         |  2 |  1  | 1  |   0   | 


# 6 版本测试过程评估

#### 6.1 问题单分析


本次版本测试各迭代从RC1到RC7，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求。社区有效issue共计596个，新增issue总体趋势下降, 当前计划遗留问题1个，符合质量预期，风险可控

各阶段问题分析：
1.alpha版本保障baseOS范围内软件包正常发布，发现构建问题130个，其余问题主要分布在软件包版本变更检查发现降级问题70+，安全专项发现问题46，软件包安装卸载、命令功能和服务问题40+

2.rc1-rc2轮次保障everything/epol范围内软件包正常发布，构建失败问题135，os通用测试项目包管理、自编译、单包问题20+，新需求测试发现问题20+

3.rc3-rc5问题集中在版本继承特性和新增需求测试，其中新增特性问题47，继承特性11，另外包管理专项发现问题17，少量构建问题18个

4.rc6新需求问题4个，构建问题4个

5.rc7的1个问题为软件包剔除后重新添加发现的构建问题



#### 6.2 OS集成测试迭代版本基线

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




# 7   附件

## 遗留问题列表

|序号|问题单号|问题简述|问题级别|影响分析|规避措施|
| ---- | ---- | ------------- | ----| ------ | ----| 
| 1   | [58](https://atomgit.com/org/openeuler/enterprise/issue-list/1996387553621368833?filterOptions=value:1996387553478762505:待办的{待办的};1996387553478762504:缺陷{缺陷},内核缺陷{内核缺陷};1996387553478762500:26993{openEuler-26.09-DevStation-alpha},27004{openEuler-26.09-DevStation},27003{openEuler-26.09-DevStation-round7},27002{openEuler-26.09-DevStation-round6},27001{openEuler-26.09-DevStation-round5},27000{openEuler-26.09-DevStation-round4},26999{openEuler-26.09-DevStation-round3},26998{openEuler-26.09-DevStation-round2},26995{openEuler-26.09-DevStation-round1};&pathname=/src-openeuler/KubeOS/issues/58)              | 【26.09-DevStation 】执行KubeOS相关的继承用例的时候，arm架构出现批量的用例等待升级/重启/配置超时、检查日志超时、节点删除后osinstance删除有延时、增加label报错重试等现象| 次要   | 失败用例主要是因为等待升级/配置时间超出设定时间时出现超时现象，但升级/配置执行等功能正常，可通过增加KubeOS升级/配置的等待时间来解决，一般场景不影响功能。 | 增加KubeOS升级/配置的等待时间 |

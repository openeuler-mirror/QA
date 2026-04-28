![openEuler ico](../../images/openEuler.png)

版权所有 © 2026 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期      | 修订版本 | 修改  章节 | 修改描述 | 作者        |
| --------- | -------- | ---------- | -------- | ----------- |
| 2026-04-25 | 1.0.0    |            | 初稿     | linqian0322 |

目 录

1 概述 

>   1.1 版本背景

>   1.2 需求范围

2 测试分层策略

3 测试分析设计策略

>   3.1 新增feature测试设计策略

>   3.2 继承feature/组件测试设计策略

>   3.3 专项测试策略

4 测试执行策略

5 附件

**Keywords 关键词**：

openEuler 测试策略

Abstract 摘要：

本文是openEuler 24.03 LTS SP4版本的整体测试策略，用于指导该版本后续测试活动的开展。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 24.03 LTS SP4版本的总体测试策略，按照社区开发模式进行运作，结合社区release-management团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 24.03 LTS SP4是基于6.6内核的扩展版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于24.03-LTS-next分支拉出，软件版本选型升级，详情请见[版本变更说明](https://atomgit.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP4/release-change.yaml)

## 需求范围

openEuler 24.03 LTS SP4版本交付[需求列表](https://atomgit.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP4/release-plan.md)如下：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| [2366](https://gitcode.com/openeuler/release-management/issues/2366) | 增加可信计算资源分发服务组件 | Developing | sig-security-facility | [@yang8621](https://gitcode.com/yang8621)     | EPOL | globaltrustauthority-rbs |
| [2434](https://gitcode.com/openeuler/release-management/issues/2434) | 远程证明支持DICE| Developing | sig-security-facility | [@yang8621](https://gitcode.com/yang8621)     | EPOL | global-trust-authority   |
| [2441](https://atomgit.com/openeuler/release-management/issues/2441) | [海光ccp驱动升级，支持sm4-xts和sm4-gcm](https://atomgit.com/openeuler/kernel/pull/21130) | Developing | SIG-Kernel| [@partycoder](https://atomgit.com/partycoder) | ISO  | kernel                   |
| [2442](https://atomgit.com/openeuler/release-management/issues/2442) | 新增海光CIS指令集sm3,sm4驱动| Developing | SIG-Kernel | [@partycoder](https://atomgit.com/partycoder) | ISO  | kernel|
| [2448](https://atomgit.com/openeuler/release-management/issues/2448) | 支持树莓派 | Developing | sig-SBC | [@woqidaideshi](https://atomgit.com/woqidaideshi) | EPOL | raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom,raspberrypi-utils |


# 测试分层策略(*基于继承特性策略刷新*)

本次24.03 LTS SP4版本的具体测试分层策略如下：

| **序号**| **需求**                                              | **开发主体**            | **测试主体**           | **测试分层策略**                                             |
| :--- | :--- | :--- | :--- | :--- |
|1| 支持UKUI桌面    | sig-UKUI  | sig-UKUI | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能    |
|2| 支持DDE桌面                                           | sig-DDE | sig-DDE  | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
|3| 支持Kiran桌面     | sig-KIRAN-DESKTOP  | sig-KIRAN-DESKTOP  | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
|4| 安装部署                                              | sig-OS-Builder| sig-QA  | 验证覆盖裸机/虚机场景下，通过光盘/PXE等安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
|5|内核                                                  | Kernel | Kernel | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
|6|容器(isula/docker/安全容器/系统容器/镜像)             | sig-CloudNative | sig-CloudNative| 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
|7| 虚拟化                                                | Virt| Virt  | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能       |
|8|系统性能自优化组件A-Tune                                            | A-Tune  | A-Tune | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
|9| 支持secPaver                                           | sig-security-facility | sig-QA  | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
|10|支持secGear                                           | sig-confidential-computing   | sig-QA | 关注secGear特性的功能完整性                                  |
|11|支持kubeOS                                            | sig-CloudNative  | sig-QA | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
|12| 支持etmem                               | Storage   | sig-QA  | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
|13| 支持用户态协议栈gazelle                               | sig-high-performance-network | sig-QA | 关注gazelle高性能用户态协议栈功能                            |
|14| 支持国密算法                                          | sig-security-facility| sig-QA  | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
|15| 支持pod带宽管理oncn-bwm                               | sig-high-performance-network | sig-QAk | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
|16| iSulad                                 | sig-iSulad   | sig-QA  |  覆盖继承功能，重点验证isulad长稳场景                 |
|17| 支持A-OPS                                 | sig-iSulad   | sig-QA  | 重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景                 |
|18| 支持系统运维套件x-diagnosis                           | sig-ops | sig-QA | 覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能  |
|19| 支持自动化热升级组件nvwa                              | sig-ops  | sig-QA    | 覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 |
|20| 支持DPU直连聚合特性dpu-utilities                                   | sig-DPU | sig-DPU  | 验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 |
|21| 支持系统热修复组件syscare                             | sig-ops | sig-QA | 验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力      |
|22| iSula容器镜像构建工具isula-build                      | sig-iSulad   | sig-QA  | 验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 |
|23| 支持进程完整性防护特性DIM                                | sig-security-facility  | sig-security-facility  | 验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 |
|24| 支持入侵检测框架secDetector                           | sig-security-facility | sig-security-facility  | 验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 |
|25| isocut镜像裁剪                              | sig-OS-Builder| sig-OS-Builder | 验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 |
|26| 支持devmaster组件                                     | sig-dev-utils  | sig-dev-utils  | 验证devmaster的安装部署、进程配置、客户端工具等使用场景      |
|27| 支持TPCM特性                                          | sig-Base-service | sig-Base-service   | 验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 |
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
|38| 编译器(gcc/jdk)                                       | Compiler  | sig-QA  | 基于开源测试套对gcc和jdk相关功能进行验证                     |
|39| 支持HA软件                                            | sig-Ha | sig-Ha  | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
|40| 支持KubeSphere                                        | sig-K8sDistro | sig-K8sDistro | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
|41| 支持OpenStack Train 和 Wallaby                        | sig-OpenStack | sig-OpenStack  | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能   |
|42| 支持智能运维助手                                     | sig-ops| sig-QA   | 关注智能定位（异常检测、故障诊断）功能、可靠性               |
|43| 支持k3s                                               | sig-K8sDistro| sig-K8sDistro | 验证k3s软件的部署测试过程                                    |
|44| migration-tools增加图形化迁移openeuler功能            | sig-Migration| sig-Migration  | 验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 |
|45| 发布Nestos-kubernetes-deployer                        | sig-K8sDistro  | sig-K8sDistro  | 验证在NestOS上部署，升级和维护kubernetes集群功能正常         |    
|46| 支持NestOS                                            | sig-CloudNative | sig-CloudNative | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
|47| 发布PilotGo及其插件特性新版本                         | sig-ops  | sig-QA  | 验证PilotGo支持 topo 图的展示和智能调优能力                  |
|48| 社区签名体系建立                                      | sig-security-facility  | sig-security-facility        | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
|49| 支持GreatSQL                               | sig-DB    | sig-DB    | 验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库 |
|50| 支持RISC-V                                            | sig-RISC-V | sig-RISC-V  | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
|51|为 RISC-V 架构引入 Penglai TEE 支持                   | sig-RISC-V | sig-RISC-V | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 |
|52| LLVM平行宇宙计划 RISC-V Preview 版本 | sig-RISC-V | sig-RISC-V |验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动 |
|53| virtCCA机密虚机特性合入       | sig-kernel/sig-virt  | sig-kernel/sig-virt  |   继承已有测试能力，重点验证机密虚机的基本功能、安全、兼容性以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试  |
|54| 增加YouQu自动化测试平台支持    | sig-QA  | sig-QA  |  验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试    |   
|55| 增加 utsudo 支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utsudo基础命令使用正常   |   
|56| 增加 utshell支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utshell基础命令使用正常   |
|57| 海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核）    |  sig-kernel | sig-kernel  |  重点验证CSV3虚拟机的不同启动方式，覆盖功能、稳定性、兼容性测试  |
|58| 集成openGauss 6.0.0 LTS企业版       | sig=DB  | sig=DB  |  重点验证openGauss 6.0.0数据库系统工具、SQL功能、数据库升级、兼容B库模块等功能测试   |
|59| LLVM多版本实现                      | sig-Compiler  |  sig-Compiler |  继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。   |
|60| 新增密码套件openHiTLS               |  sig-security-facility |  sig-security-facility |  继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试    |
|61| 支持oeaware                |  sig-A-Tune | sig-QA  |  继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容  |
|62| AI集群慢节点快速发现 Add Fail-slow Detection      | sig-desktop   |  sig-desktop |  继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度   |
|63| RPM国密签名支持                             | sig-security-facility  | sig-security-facility  |  重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容   |
|64| 鲲鹏KAE加速器驱动安装包合入                  | sig-kernel  | sig-kernel  |  继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩   |
|65| Add Intel QAT packages support    | sig-Intel-Arch  | sig-Intel-Arch  |  继承已有测试能力，重点验证intel qat相关软件包的功能和性能    |
|66| Add OpenVINO packages native support  |  sig-Intel-Arch/sig-intelligence |  sig-Intel-Arch/sig-intelligence |  继承已有测试能力，验证OpenVINO框架上sample code编译运行成功和OpenVINO的推理功能   |
|67| Add oneAPI low level native support   | sig-Intel-Arch/sig-intelligenc  |  sig-Intel-Arch/sig-intelligenc |  继承已有测试能力，重点验证oneAPI对于sample code的编译运行，大模型基于oneAPI加速框架的正确支持以及相应软件包的功能测试   |
|68| 版本引入ACPO包    | sig-Compiler  |  sig-Compiler |  继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容   |
|69| 内核TCP/IP协议栈支持CAQM拥塞     |  sig-kernel |  sig-kernel |  继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能   |
|70| openEuler安全配置基线检测工具 |SIG-security-facility|SIG-security-facility|使用Linux系统安全检查工具 secureguardian，通过执行一系列的安全检查脚本, 查看生成的安全报告，评估系统的安全性是否存在风险 |
|71| 支持树莓派 | SIG-SBC | SIG-SBC  | 继承已有测试能力，对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性等测试 |
|72| OVMF_CODE.fd支持CSV1/2/3开箱即用 |sig-edk2 |sig-edk2| 继承已有测试能力，主要包括功能测试，稳定性测试，压力测试| 
|73|OVMF.fd支持CSV1/2/3开箱即用 |sig-edk2 |sig-edk2| 继承已有测试能力，主要包括功能测试,稳定性测试|
|74|新的psp/ccp device id支持 |sig-kernel/sig-qemu |sig-kernel/sig-qemu | 继承已有测试能力，主要覆盖海光可信功能验证|
|75|可信功能内核驱动剥离sev依赖 | sig-kernel|sig-kernel|继承已有测试能力，主要覆盖海光可信功能验证 |
|76| vTKM 性能优化| sig-kernel|sig-kernel|继承已有测试能力，主要覆盖普通虚拟机和CSV虚拟机下的TKM功能验证，性能测试验证,内部密钥的SM2签名、SM2解密、SM4 |
|77| 基于通信算子的低开销高精度慢节点检测 |sig-ops|sig-ops| 继承已有测试能力，覆盖功能、长稳、资料测试，功能覆盖模型数据timeline图转化，数据采集开销验证，分组验证，慢节点分析验证|
|78| FUSE passthrough支持| sig-kernel|sig-kernel|继承已有测试能力，主要覆盖功能测试和性能测试 |
|79| 基于eBPF等技术实现AI作业进程Stack Mergeing，支持典型内存故障定位|sig-ops |sig-ops | 继承已有测试能力，主要覆盖功能测试，功能覆盖模型内存timeline图转化、内存堆栈转化，可以在网页上正确显示火焰图和时间线 |
|80| 虚拟化场景支持vKAE直通设备热迁移 | virt-sig |virt-sig |继承已有测试能力，覆盖功能、性能、资料测试，功能覆盖vKAE直通虚拟机热迁移验证 |
|81| secGear支持机密虚机基于UEFI启动方式的报告生成及验证 | sig-confidential-computing| sig-confidential-computing| 继承已有测试能力，覆盖功能测试和可靠性测试 |
|82| 支持可信计算远程证明服务组件 | sig-security-facility|sig-security-facility|继承已有测试能力，涉及基础冒烟测试和ltp测试|
|83| 支持Kuasar机密容器镜像加解密| sig-confidential-computing/sig-Cloudnative|sig-confidential-computing/sig-Cloudnative|继承已有测试能力，覆盖功能、可靠性、资料测试。|
|84| 支持众核高密容器级资源隔离技术 |sig-kernel|sig-kernel| 继承已有测试能力，测试众核调度对计算密集型与IO密集型业务服务QPS的影响，在部署密度提升超过10%的情况下业务性能良好无劣化 | 
|85| snappy库：FindMatchLength支持RISC-V架构的优化 |sig-Base-service|sig-QA| 继承已有测试能力，主要覆盖功能测试，验证引入snappy优化后，snappy能够正常解压缩| 
|86| lz4库：提高riscv架构的压缩速度  |sig-Base-service | sig-QA  | 继承已有测试能力，主要覆盖功能测试、性能测试、兼容性测试和稳定性测试，重点验证优化后的性能提升效果  | 
|87| openssl库：RISC-V架构的系列优化-SM2优化  | sig-dev-utils |sig-QA   |继承已有测试能力，使用官方自带测试用例，运行make test涵盖特性的所有类型验证测试；使用openssl speed工具测试加入特性前后的sm2/rsa2048/aes-128-cbc性能|
|88| virtcca: 支持virtCCA机密虚机热迁移     | sig-kernel,virt  | sig-QA  | 继承已有测试能力，主要覆盖功能测试、可靠性测试、性能测试，功能重点覆盖不同虚机规格、数量热迁移执行，业务不中断，可靠性重点覆盖迁移前可用资源检查、迁移失败源虚机恢复、并发/反复迁移稳定性、内存完整性检查等|
|89| golang: Backport RVA23     | sig-golang  | sig-QA  | 继承已有测试能力，重点验证 Backport 后 Golang 软件包本身能够通过所有测试 |
|90| TSB-agent: 支持可信计算虚拟化vTPCM     | sig-security-facility  |  sig-QA  |  继承已有测试能力，重点验证在Host端使用 cli/api 进行虚机创建、展示、启动、停止、删除、迁移成功 |
|91| openssl：Backport 主线 RISC-V 架构的 SHA-2 汇编优化    | sig-dev-utils  |  sig-QA | 继承已有测试能力，验证SHA-2算法核心应用场景，如数据完整性验证，数据签名基础，密码安全存储 |
|92| URMA：URMA支持UB基础通信能力     |  sig-UnifiedBus |  sig-QA  | 继承已有测试能力，重点覆盖对用户呈现的接口测试，功能方面覆盖URMA初始化、管理面建链、数据面收发等测试，对资源不足、对端进程异常退出等可靠性场景开展测试|
|93| UMS：UMS支持socket接口通信     | sig-UnifiedBus  |sig-QA  |继承已有测试能力，重点覆盖用户使用UMS的主要场景，功能方面覆盖UMS的正常建链、逃生通道触发、建链信息打印以及配置参数写入等场景|
|94| DLock：支持基于UB的分布式锁    | sig-UnifiedBus  | sig-QA  | 继承已有测试能力，覆盖对用户呈现的接口测试，功能方面覆盖DLock初始化、管理面建链、数据面收发等测试，对资源上限、进程异常退出等可靠性开展测试 |
|95| URPC：URPC支持UB    | sig-UnifiedBus |  sig-QA |继承已有测试能力，功能方面覆盖对用户呈现的接口测试、URPC初始化、管理面建链、数据面收发等功能测试，对资源不足、对端进程异常退出等可靠性场景开展测试，并开展正常使用流程的长稳压测 |
|96| UBTurbo: HAM支持确定性热迁移能力     |  sig-UnifiedBus |  sig-QA | 继承已有测试能力，主要覆盖基于灵衢总线的远端内存访问能力与大带宽，实现确定性时长的虚机热迁移能力 |
|97| UBTurbo： SMAP支持内存冷热扫描和迁移能力     |  sig-UnifiedBus |  sig-QA | 继承已有测试能力，重点验证SMAP可进行页面的冷热判断，根据冷热把页面在本地内存和远端内存之间做迁移，主要覆盖功能测试、可靠性测试和安全测试  |
|98| UBTurbo：RMRS Agent支持内存迁移决策与执行    |  sig-UnifiedBus |  sig-QA |继承已有测试能力，重点覆盖RMRS Agent对用户提供的API接口，验证内存迁移决策与执行功能  |
|99| UB Turbo： UBTurbo提供基础框架(配置读取、插件加载、日志管理、IPC通信等)能力    |  sig-UnifiedBus   |  sig-QA   | 继承已有测试能力，构建UBTurbo测试插件，覆盖UBTurbo框架提供的插件注册/去注册,配置项获取以及日志记录功能   |
|100| UBS Engine: UBS Engine支持UB池化资源管理能力   |  sig-UB-ServiceCore   |  sig-QA  | 继承已有测试能力，结合UBS Engine需求的交付的能力，覆盖接口/功能、场景、专项测试  |
|101| UBS Comm: HCOM支持UB通信能力       |  sig-UB-ServiceCore   | sig-QA   |继承已有测试能力，重点测试UB通信单边Read/Write，双边send以及多路径能力，基于场景侧通信能力要求，多并发大数据量发送验证 |
|102| OBMM: 提供跨节点内存访问与一致性控制能力   |  sig-Long  | sig-QA  | 继承已有测试能力，主要覆盖接口／功能，以及场景测试,验证OBMM提供跨节点内存访问与一致性控制能力功能正常|
|103| sysSentry：支持UB故障劫持能力及超节点故障上报能力 |sig-Base-service|  sig-QA  |继承已有测试能力，重点覆盖panic/reboot场景劫持通过URMA/UVB通道上报消息答复功能；主动下电/oom通过sysSentry内部逻辑上报消息答复功能；ub内存故障上报以及故障上报后根据物理地址杀掉对应的业务进程功能 |
|104| qemu：支持基于urma通道的内存热迁移  | sig-Virt | sig-QA  | 继承已有测试能力，重点验证基于urma通道的内存热迁移功能，主要覆盖功能测试、可靠性测试和性能测试 |
|105| UBNative：灵衢虚拟化基础能力支持UBNative直通虚拟化     |  sig-Virt   | sig-QA  |继承已有测试能力，重点验证基于虚拟机ub设备直通功能，主要覆盖功能测试、可靠性测试 |
|106|memlink：灵衢虚拟化基础能力支持memlink大规格虚拟机、内存回收     |  sig-long  |sig-QA  | 继承已有测试能力，重点验证验证memlink内存回收功能， 主要覆盖功能测试、可靠性和性能测试 |
|107| utpam：基于Rust开发的身份认证模块     | sig-memsafety   | sig-QA   | 继承已有测试能力，重点验证utpam在openEuler版本上可正常编辑PAM配置文件设置认证策略 |
|108| UB lib & tool：灵衢基础工具和库      | sig-UnifiedBus   | sig-QA  | 继承已有测试能力，重点验证ubctl作为dfx工具查询公共功能配置、模块状态、统计数据和固件信息等功能 |
|109| secScanner:操作系统安全加固组件      |  sig-security_facility   |  sig-QA   | 继承已有测试能力，重点验证安全加固、漏洞扫描、入侵检测在openEuler系统下正常运行，以及检测组件使用权限限制、组件日志未泄露系统敏感信息 |
|110| VMAnalyzer:轻量级虚拟化性能监控组件       |  sig-ops   |  sig-QA   |  继承已有测试能力，重点验证虚拟机运行状况和性能采集检测、宿主机信息/虚拟化环境信息/虚机基本信息采集检测测试 ｜
|111| 引入IOInflight QoS控制器，降低混部场景在线业务干扰率     |   sig-kernel  |sig-QA  | 继承已有测试能力，重点验证识别和优先处理关键任务的读写请求能力，主要覆盖功能测试和可靠性测试 |
|112| SPDK支持vq均衡多reactor功能，降低虚拟化开销     |sig-Storage   |  sig-QA   | 继承已有测试能力，验证openEuler SPDK支持vq均衡多reactor功能，虚拟化开销小于5%，主要覆盖功能测试和性能测试|
|113| ModelFS提升推理服务启动速度  |  sig-kernel  |  sig-kernel   |  继承已有测试能力，重点验证ModelFS 语义功能和事件管理功能，以及长稳测试   |
|114| GMem异构融合内存提升异构资源利用率       |  sig-kernel   |  sig-kernel   | 继承已有测试能力，重点验证基础融合内存能力，通过内存协同，互相借用扩大内存空间提升异构资源利用率，主要覆盖功能、性能、安全和可靠性测试  |
|115| 毕昇JDK21支持元数据压缩优化降低堆数据内存使用    |  sig-Compiler   |  sig-QA  | 继承已有测试能力，重点验证通过降低Java对象头占用而减少Java堆内存（Heap Memory）占用能力，主要覆盖功能和可靠性测试 |
|116| TF原生Embedding算子图优化提高推理性能    | sig-Compiler   | sig-QA   | 继承已有测试能力，重点验证图算优化提升推理性能，主要覆盖功能测试和性能测试 |
|117| 毕昇JDK21版本 G1、PS支持堆内存扩缩容     | sig-Compiler   |  sig-QA  | 继承已有测试能力，重点验证用户可在应用运行时动态扩展Java堆内存的上限无需重启JVM的能力，主要覆盖功能、性能和可靠性测试 |
|118| LLVM编译器提升数据库（MySQL）、压缩解压缩（lz4/zstd/xz）等性能       |sig-Compiler    |  sig-QA   | 继承已有测试能力，重点验证通过编译器优化提升应用性能，主要覆盖功能、性能和可靠性测试|
|119| 毕昇JDK21支持JIT warmup， 提升Java启动性能|  sig-Compiler  | sig-QA   | 继承已有测试能力，重点验证开启优化特性可避免编译竞争提升应用性能，主要覆盖功能、性能和可靠性测试 |
|120| OS灵衢组件一键安装配置，业务可感知的通信故障场景快速定位 |  sig-unifiedbus  |  sig-QA  | 继承已有测试能力，UB组件可一键快速安装部署与驱动自动加载，重点验证ub-pkg-cli命令用于配置UB相关组件的配置参数与基础功能检测能力  |   
|121| 内核态操作用户态内存场景，通过容错机制避免UCE故障上报导致系统panic  |  sig-kernel|  sig-kernel|   继承已有测试能力，重点验证内核在已知故障模式下可保持稳定，避免远端UB内存故障引发的内核崩溃，主要覆盖功能测试和可靠性测试   | 
|122| NPU时域切分及隔离提升利用率 |  sig-kernel|   sig-kernel| 继承已有测试能力，验证算力切分特性实现任务到异构算力的按需调度机制，主要覆盖功能、性能和可靠性测试  | 
|123| CRIU支持NPU设备dump/restore |  sig-kernel  |  sig-QA  | 继承已有测试能力，验证cuiu冻结运行中的应用程序/部分组件后可通过检查点文件从冻结点恢复的能力，主要覆盖功能测试、接口测试、可靠测试和性能测试   | 
|124| AI训练场景慢卡、慢节点分钟级检测、快速定界 |  sig-intelligence   |  sig-intelligence  |  继承已有测试能力，验证在AI训练场景下，实现对XPU卡的慢卡/慢节点检测和定位，主要覆盖功能测试和可靠性测试  | 
|125| E2B Agent沙箱提供生命周期管理统一接口，支持脚本、K8S方式部署E2B集群 |  sig-CloudNative  |  sig-CloudNative  |  继承已有测试能力，验证E2B沙箱平台在openEuler上可一键部署，并可使用K8S进行管理部署，主要覆盖功能测试和可靠性测试  | 
|126| cgroup v2支持内存异步回收功能 |  sig-kernel  |  sig-kernel  | 继承已有测试能力，验证cgroup v2 内存异步回收解决当前cgroup隔离方案导致的易卡死，同步内存回收带来性能下降的痛点，主要覆盖功能测试、性能测试和可靠性测试   | 
|127| 智能Cache注入 |  sig-A-tune  |  sig-A-tune  |  继承已有测试能力，验证智能cache注入支持LLC与L2 cache stash配置，主要覆盖API接口测试、功能测试、可靠性测试和性能测试  | 
|128| sockmap加速同主机tcp流 |  sig-kernel  |  sig-kernel  |  继承已有测试能力，验证sockmap在socket层旁路tcp协议栈，降低延迟的作用，主要覆盖功能测试和性能测试  | 
|129| GIC超分优化，提升Nginx性能  |  sig-kernel  |  sig-kernel  |  继承已有测试能力，验证相同亲和组动静态迁移测试，跨亲和组动静态迁移测试，主要覆盖功能、性能和可靠性测试等 | 
|130| hisock功能增强，提升目标流量吞吐性能 |  sig-kernel  |  sig-kernel  | 待确认  | 
|131| sysSentry支持硬盘寿命检测和健康监控 | sig-Base-service  |  sig-Base-service  | 继承已有测试能力，增强sysSentry故障检测能力，支持上报BMC所有硬盘告警事件，支持告警事件类型可配置化等，主要覆盖功能测试和可靠性测试   | 
|132| 内存支持zone粒度内存回收（异步模式） |  sig-kernel   |  sig-kernel   |  待确认  | 
|133| CCA机密虚机支持设备直通|  sig-virt  |  sig-QA  | 测试已有测试能力，验证CCA机密虚机支持nvme盘/网卡等设备直通PF，多nvme/网卡等设备直通机密虚机   | 
|134| Go语言map SIMD加速、hashtriemap算法优化等，提升hashmap性能 |  sig-golang  |  sig-QA   |  继承已有测试能力，验证Go语言map SIMD加速、hashtriemap算法优化等效果，主要覆盖功能测试和性能测试  | 
|135| AI图编译器TF+XLA动态batch场景并行化优化，提升性能  |  sig-Compiler  |  sig-QA  | 继承已有测试能力，验证XLA编译器支持动态batch和并行优化的效果，主要覆盖功能测试和性能测试   | 
|136| LLVM实现RabitQ性能提升 |  sig-Compiler  |  sig-QA  |  继承已有测试能力，验证向量化增强优化和memcpy inline优化效果，主要覆盖功能测试和性能测试  | 
|137| LLVM优化降低数据库、搜推场景编译时长 | sig-Compiler   |  sig-QA  | 继承已有测试能力，验证LLVM使能编译优化效果，主要覆盖功能测试和性能测试    | 
|138| 毕昇JDK GC算法、SVE/DMB指令等优化，提升大数据性能 |  sig-Compiler  | sig-QA   | 继承已有测试能力，验证毕昇JDK17 GC算法、SVE/DMB指令等优化特性效果，主要覆盖功能测试和性能测试   | 
|139| 虚拟机QEMU支持UB mem D2H  |  sig-virt  |  sig-QA   | 继承已有测试能力，验证A5虚拟化场景通过UB总线访问KVCache内存，主要覆盖功能测试、可靠性测试和性能测试   | 
|140| 支持IP over URMA  |  sig-unifiedbus  |  sig-QA   |  继承已有测试能力，验证IP over URMA支持智算组网TCP/IP协议通信，主要覆盖API接口测试，功能测试，并发压力测试，可靠性测试以及安全测试等  |  

# 测试分析设计策略

## 新增feature测试设计策略

| *序号*  | *Feature*   |*测试设计策略*  | *测试重点*  |Arm  | X86  | RISC-V RVA20 | RISC-V RVA23 | loongarch 
| ------------ | -------------------------------- | -------------------------------- |-------------------------------- | ---- | ---- | ------ | --------- | --------- | 
|1|[isa-l库：CRC算法在RISC-V架构的优化](https://gitee.com/openeuler/release-management/issues/ICW20J?from=project-issue)|[ISA-L CRC测试策略](https://gitee.com/openeuler/QA/pulls/1164)|需要验证该CRC向量汇编实现的特性在功能上是否与C语言标准实现一致，验证新的CRC特性与EC，IGZIP等功能一起工作是否可靠，最后验证新CRC特性的性能数据是否满足需求。主要开展功能，场景以及性能测试。 |× |　 × | ×　| √　|
|1|[增加可信计算资源分发服务组件](https://gitcode.com/openeuler/release-management/issues/2366)|[详细测试策略文件]()| |√ |　 √ | 　| 　|
|2|[远程证明支持DICE](https://gitcode.com/openeuler/release-management/issues/2434)|[详细测试策略文件]()| | √ |　  | 　| 　|
|3|[海光ccp驱动升级，支持sm4-xts和sm4-gcm](https://gitcode.com/openeuler/release-management/issues/2441)|[详细测试策略文件]()| |× |　 √  | 　| 　|
|4|[新增海光CIS指令集sm3,sm4驱动](https://gitcode.com/openeuler/release-management/issues/2442)|[详细测试策略文件]()| |× |　√ | 　| 　|
|5|[支持树莓派](https://gitcode.com/openeuler/release-management/issues/2448)|[详细测试策略文件]()| | √ |　 × | 　| 　|


## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                                          | 策略                                                         | Arm  | X86  | RISC-V RVA20 | RISC-V RVA23 | loongarch 
| ----------------------------------------------------- | ------------------------------------------------------------ | ---- | ---- | ------ | ------ |--------- | 
| 支持DDE桌面                                           | 继承已有测试能力，关注DDE桌面系统的安装和基本功能            | √    | √    | √      | √     |
| 支持UKUI桌面                                          | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           | √    | √    | √      | √     |
| 支持Kiran桌面                                         | 增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 | √    | √    | √      | √     |
| 安装部署                                              | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 | √    | √    | √     | √    |
| 内核                                              | 继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 | √    | √    | √     | √    |
| 容器(isula/docker/安全容器/系统容器/镜像)             | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 | √    | √    | √      | √     |
| 虚拟化                                                | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 | √    | √    | ×     | √   |
| 支持A-Tune                                            | 继承已有测试能力，本次无新增合入，重点关注继承功能验证，如服务/配置检查等。 | √    | √    | √   | √   |
| 支持secPaver                                           | 继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    | √    | √    | √    | √    |
| 支持secGear                                           | 继承已有测试能力，关注secGear特性的功能完整性，重点关注上次新增合入远程证明框架的功能完整性和准确性。               | √    | √    | ×     | ×    |
| 支持kubeOS                                            | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 | √    | √    | ×     | ×    |
| 支持etmem内存分级扩展                                 | 继承已有测试能力，重点验证特性的基本功能和稳定性             | √    | √    | ×     | ×    |
| 支持用户态协议栈gazelle                               | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能      | √    | √    | √  | √  |
| 支持国密算法                                          | 继承已有测试能力，验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 | √    | √    | √     | √    |
| 支持pod带宽管理oncn-bwm                               | 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 | √    | √    | ×     | ×    |
| 支持isuald                             | 继承已有测试能力，重点验证isulad长稳场景 | √    | √    | √     | √    |
| 支持A-OPS                             | 继承已有测试能力，重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景| √    | √    | ×     | ×    |
| 支持系统运维套件x-diagnosis                           | 继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能 | √    | √    | ×   | ×  |
| 支持自动化热升级组件nvwa                              | 继承已有测试能力，覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 | √    | × | ×     | ×    |
| 支持DPU直连聚合特性dpu-utilities                                   | 继承已有测试能力，验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 | √    | √    | ×     | ×    |
| 支持系统热修复组件syscare                             | 继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力 | √    | √    | √      | √     |
iSula容器镜像构建工具isula-build  | 验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 | √    | √    | √   | √   |
| 支持进程完整性防护特性DIM                                | 继承已有测试能力，验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 | √    | √    | √   | √   |
| 支持入侵检测框架secDetector                           | 继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 | √    | √    | ×   | ×  |
| isocut镜像裁剪                                        | 继承已有测试能力，验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 | √    | √    | √    | √    |
| 支持devmaster组件                                     | 继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景 | √    | √    | √    | √   |
| 支持TPCM特性                                          | 继承已有测试用例，验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 | √    | × | ×     | ×    |
| 支持sysMaster组件                                     | 继承已有测试能力，验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景 | √    | √    | √      | √     |
| 支持sysmonitor特性                                    | 继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景 | √    | √    | √     | √    |
| 混合部署rubik                                         | 继承已有测试能力，覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化 | √    | √    | ×     | ×    |
| 支持IMA自定义证书                             | 继承已有测试能力，验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式。| √    | √    | ×    | ×    |
| 支持IMA virtCCA                             |继承已有测试能力，验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等； | √    | √    | ×     | ×    |
| 安全启动                            | 继承已有测试能力，验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等；| √    | √    | ×     | ×    |
| Kmesh                              | 继承已有测试能力，验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等。| √    | √    | ×     | ×    |
| openEuler安全配置规范框架设计及核心内容构建                             |继承已有测试能力，验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性 | √    | √    | √    | √   |
| oemaker                              |继承已有测试能力，在构建工程中保证oemaker功能正常 | √    | √    | √     | √    |
| openssl                              |继承已有测试能力，验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上 | √    | √    | √     | √    |
| 编译器(gcc/jdk)                                       | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   | √    | √    | √      | √     |
| 支持HA软件                                            | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 | √    | √    | √    | √   |
| 支持KubeSphere                                        | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力 | √    | √    | ×     | ×    |
| 支持openstack Train 和 Wallaby                        | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能 | √    | √    | ×     | ×    |
| 支持智能运维助手                                     | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性 | √    | √    | ×     | ×    |
| 支持k3s                                               | 继承已有测试能力，验证k3s软件的部署测试过程                  | √    | √    | ×     | ×    |
| migration-tools增加图形化迁移openeuler功能            | 继承已有测试能力，验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 | √    | √    | ×     | ×    |
| 发布Nestos-kubernetes-deployer                        | 继承已有测试能力，覆盖在NestOS上部署，升级和维护kubernetes集群功能正常 | √    | √    | ×     | ×    |
| 支持NestOS                                            | 继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 | √    | √    | ×     | ×    |
| 发布PilotGo及其插件特性新版本                         | 继承已有测试能力，验证PilotGo支持 topo 图的展示和智能调优能力 | √    | √    | √     | √    |
| 社区签名体系建立                                      | 继承已有测试能力，验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性。 | √    | √    | ×      | ×     |
| 支持GreatSQL                                | 继承已有测试能力验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库 | √    | √    | √    | √   |
| 支持RISC-V                                            | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性 | √    | √    | √      | √     |
| 为 RISC-V 架构引入 Penglai TEE 支持                   | 继承已有测试能力，验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 | ×    | ×    | √    | √   |
|  LLVM平行宇宙计划 RISC-V Preview 版本  |  | ×    | ×    | √    | √   |
| virtCCA机密虚机特性合入   |  继承已有测试能力，重点验证机密虚机的基本功能、安全、兼容性以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试   | √    | × | × | × |
| 增加YouQu自动化测试平台支持   |  验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试   | √    | √    |   √    |   √   |
| 增加 utsudo 支持    |  继承已有测试能力，验证utsudo基础命令使用正常   | √    | √    |   √     |   √    |
| 增加 utshell支持   |   继承已有测试能力，验证utshell基础命令使用正常  | √    | √    |   √     |   √    |
| 海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核）   |  重点验证CSV3虚拟机的不同启动方式，覆盖功能、稳定性、兼容性测试   | × | √    | × | × |
| 集成openGauss 6.0.0 LTS企业版    |   重点验证openGauss 6.0.0数据库系统工具、SQL功能、数据库升级、兼容B库模块等功能测试   | √    | √    | √ | √ |
| LLVM多版本实现    |  继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用   | √    | √    | √ | √ |
| 新增密码套件openHiTLS     |  继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试   | √    | √    | × | × |
| 支持oeaware    |  继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容   | √    | √   | × | × |
| AI集群慢节点快速发现 Add Fail-slow Detection   |   继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度  | √    | √    |  ×     |  ×    |
| RPM国密签名支持  |  重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容   | √    | √    |  √    |  √   |
| 鲲鹏KAE加速器驱动安装包合入  |  继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩    | √    | × | × | × |
| Add Intel QAT packages support   |  继承已有测试能力，重点验证intel qat相关软件包的功能和性能   | × |   √  | × | × |
| Add OpenVINO packages native support  |   继承已有测试能力，验证OpenVINO框架上sample code编译运行成功和OpenVINO的推理功能   | √    | √    | × | × |
| Add oneAPI low level native support  |   继承已有测试能力，重点验证oneAPI对于sample code的编译运行，大模型基于oneAPI加速框架的正确支持以及相应软件包的功能测试   | √    | √    | × | × |
| 版本引入ACPO包   |  继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容   | √    | √    |   ×   |   ×   |
| 内核TCP/IP协议栈支持CAQM拥塞     |    继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能  | √    | √    | × | × |
| openEuler安全配置基线检测工具      |    继承已有测试能力，使用Linux系统安全检查工具secureguardian，通过执行一系列的安全检查脚本, 查看生成的安全报告，评估系统的安全性是否存在风险  | √    | √    | √ | √ |
| 支持树莓派     |    继承已有测试能力，对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性等测试  | √    | ×    | ×  | × |
|OVMF_CODE.fd支持CSV1/2/3开箱即用 | 继承已有测试能力，主要包括功能测试，稳定性测试，压力测试|  ×    | √     | × | × |
|OVMF.fd支持CSV1/2/3开箱即用 | 继承已有测试能力，主要包括功能测试,稳定性测试|  ×    | √     | × | × |
|新的psp/ccp device id支持 | 继承已有测试能力，主要覆盖海光可信功能验证|  ×    | √     | × | × |
|可信功能内核驱动剥离sev依赖 |继承已有测试能力，主要覆盖海光可信功能验证 |  ×    | √     | × | × |
| vTKM 性能优化|继承已有测试能力，主要覆盖普通虚拟机和CSV虚拟机下的TKM功能验证，性能测试验证,内部密钥的SM2签名、SM2解密、SM4。 |  ×    | √     | × | × |
| 基于通信算子的低开销高精度慢节点检测 |继承已有测试能力，覆盖功能、长稳、资料测试，功能覆盖模型数据timeline图转化，数据采集开销验证，分组验证，慢节点分析验证|  √    | √     | × | × |
| FUSE passthrough支持|继承已有测试能力，主要覆盖功能测试和性能测试 | √    | √     | × | × |
| 基于eBPF等技术实现AI作业进程Stack Mergeing，支持典型内存故障定位| 继承已有测试能力，主要覆盖功能测试，功能覆盖模型内存timeline图转化、内存堆栈转化，可以在网页上正确显示火焰图和时间线 | √    | ×     | × | × |
| 虚拟化场景支持vKAE直通设备热迁移 | 继承已有测试能力，覆盖功能、性能、资料测试，功能覆盖vKAE直通虚拟机热迁移验证 | √    | ×     | × | × |
| secGear支持机密虚机基于UEFI启动方式的报告生成及验证 | 继承已有测试能力，覆盖功能测试和可靠性测试 | √    | ×     | × | × |
| 支持可信计算远程证明服务组件 |继承已有测试能力，涉及基础冒烟测试和ltp测试| √    | √     | × | × |
| 支持Kuasar机密容器镜像加解密| 继承已有测试能力，覆盖功能、可靠性、资料测试。| √    | ×     | × | × |
| 支持众核高密容器级资源隔离技术 | 继承已有测试能力，测试众核调度对计算密集型与IO密集型业务服务QPS的影响，在部署密度提升超过10%的情况下业务性能良好无劣化。 | √    | √     | × | × |
|  snappy库：FindMatchLength支持RISC-V架构的优化 | 继承已有测试能力，主要覆盖功能测试，验证引入snappy优化后，snappy能够正常解压缩 |     |      |  | √ |
| lz4库：提高riscv架构的压缩速度 |继承已有测试能力，主要覆盖功能测试、性能测试、兼容性测试和稳定性测试，重点验证优化后的性能提升效果  |   |      |  | √   |
| openssl库：RISC-V架构的系列优化-SM2优化 | 继承已有测试能力，使用官方自带测试用例，运行make test涵盖特性的所有类型验证测试；使用openssl speed工具测试加入特性前后的sm2/rsa2048/aes-128-cbc性能 |    |      |  | √  |
| virtcca: 支持virtCCA机密虚机热迁移 | 继承已有测试能力，主要覆盖功能测试、可靠性测试、性能测试，功能重点覆盖不同虚机规格、数量热迁移执行，业务不中断，可靠性重点覆盖迁移前可用资源检查、迁移失败源虚机恢复、并发/反复迁移稳定性、内存完整性检查等 | √  |   |  |  |
|  golang: Backport RVA23 | 继承已有测试能力，重点验证 Backport 后 Golang 软件包本身能够通过所有测试 |    |      |  | √  |
|  TSB-agent: 支持可信计算虚拟化vTPCM | 继承已有测试能力，重点验证在Host端使用 cli/api 进行虚机创建、展示、启动、停止、删除、迁移成功 | √    |      |  |  |
| openssl：Backport 主线 RISC-V 架构的 SHA-2 汇编优化 | 继承已有测试能力，验证SHA-2算法核心应用场景，如数据完整性验证，数据签名基础，密码安全存储 |     |      | √ | √ |
| URMA：URMA支持UB基础通信能力 | 继承已有测试能力，重点覆盖对用户呈现的接口测试，功能方面覆盖URMA初始化、管理面建链、数据面收发等测试，对资源不足、对端进程异常退出等可靠性场景开展测试 | √    |      |  |  |
| UMS：UMS支持socket接口通信 | 继承已有测试能力，重点覆盖用户使用UMS的主要场景，功能方面覆盖UMS的正常建链、逃生通道触发、建链信息打印以及配置参数写入等场景 | √    |      |  |  |
| DLock：支持基于UB的分布式锁 | 继承已有测试能力，覆盖对用户呈现的接口测试，功能方面覆盖DLock初始化、管理面建链、数据面收发等测试，对资源上限、进程异常退出等可靠性开展测试  | √    |      |  |  |
| URPC：URPC支持UB  | 继承已有测试能力，功能方面覆盖对用户呈现的接口测试、URPC初始化、管理面建链、数据面收发等功能测试，对资源不足、对端进程异常退出等可靠性场景开展测试，并开展正常使用流程的长稳压测 | √    |      |  |  |
| UBTurbo: HAM支持确定性热迁移能力 | 继承已有测试能力，主要覆盖基于灵衢总线的远端内存访问能力与大带宽，实现确定性时长的虚机热迁移能力 | √    |      |  |  |
| UBTurbo： SMAP支持内存冷热扫描和迁移能力  | 继承已有测试能力，重点验证SMAP可进行页面的冷热判断，根据冷热把页面在本地内存和远端内存之间做迁移，主要覆盖功能测试、可靠性测试和安全测试 | √    |      |  |  |
| UBTurbo：RMRS Agent支持内存迁移决策与执行  | 继承已有测试能力，重点覆盖RMRS Agent对用户提供的API接口，验证内存迁移决策与执行功能 | √    |      |  |  |
| UB Turbo： UBTurbo提供基础框架(配置读取、插件加载、日志管理、IPC通信等)能力    |   继承已有测试能力，构建UBTurbo测试插件，覆盖UBTurbo框架提供的插件注册/去注册,配置项获取以及日志记录功能   | √  |  | |. |
| UBS Engine: UBS Engine支持UB池化资源管理能力 | 继承已有测试能力，结合UBS Engine需求的交付的能力，覆盖接口/功能、场景、专项测试 | √    |      |  |  |
| UBS Comm: HCOM支持UB通信能力 | 继承已有测试能力，重点测试UB通信单边Read/Write，双边send以及多路径能力，基于场景侧通信能力要求，多并发大数据量发送验证  | √    |      |  |  |
| OBMM: 提供跨节点内存访问与一致性控制能力 | 继承已有测试能力，主要覆盖接口／功能，以及场景测试,验证OBMM提供跨节点内存访问与一致性控制能力功能正常 | √    |      |  |  |
| sysSentry：支持UB故障劫持能力及超节点故障上报能力 | 继承已有测试能力，重点覆盖panic/reboot场景劫持通过URMA/UVB通道上报消息答复功能；主动下电/oom通过sysSentry内部逻辑上报消息答复功能；ub内存故障上报以及故障上报后根据物理地址杀掉对应的业务进程功能 | √    |      |  |  |
| qemu：支持基于urma通道的内存热迁移 | 继承已有测试能力，重点验证基于urma通道的内存热迁移功能，主要覆盖功能测试、可靠性测试和性能测试  | √    |      |  |  |
| UBNative：灵衢虚拟化基础能力支持UBNative直通虚拟化 | 继承已有测试能力，重点验证基于虚拟机ub设备直通功能，主要覆盖功能测试、可靠性测试 | √    |      |  |  |
| memlink：灵衢虚拟化基础能力支持memlink大规格虚拟机、内存回收 | 继承已有测试能力，重点验证验证memlink内存回收功能， 主要覆盖功能测试、可靠性和性能测试  | √    |      |  |  |
|  utpam：基于Rust开发的身份认证模块  | 继承已有测试能力，重点验证utpam在openEuler版本上可正常编辑PAM配置文件设置认证策略 | √    |      |  |  |
| UB lib & tool：灵衢基础工具和库  | 继承已有测试能力，重点验证ubctl作为dfx工具查询公共功能配置、模块状态、统计数据和固件信息等功能  | √    |      |  |  |
| secScanner:操作系统安全加固组件 | 继承已有测试能力，重点验证安全加固、漏洞扫描、入侵检测在openEuler系统下正常运行，以及检测组件使用权限限制、组件日志未泄露系统敏感信息 | √    |      |  |  |
| VMAnalyzer:轻量级虚拟化性能监控组件 | 继承已有测试能力，重点验证虚拟机运行状况和性能采集检测、宿主机信息/虚拟化环境信息/虚机基本信息采集检测测试 | √    |      |  |  |
| 引入IOInflight QoS控制器，降低混部场景在线业务干扰率 | 继承已有测试能力，重点验证识别和优先处理关键任务的读写请求能力，主要覆盖功能测试和可靠性测试  | √    |      |  |  |
| SPDK支持vq均衡多reactor功能，降低虚拟化开销 | 继承已有测试能力，验证openEuler SPDK支持vq均衡多reactor功能，虚拟化开销小于5%，主要覆盖功能测试和性能测试 | √    |      |  |  |
| ModelFS提升推理服务启动速度 | 继承已有测试能力，重点验证ModelFS 语义功能和事件管理功能，以及长稳测试   |  | √    |      |  |  |
|GMem异构融合内存提升异构资源利用率   | 继承已有测试能力，重点验证基础融合内存能力，通过内存协同，互相借用扩大内存空间提升异构资源利用率，主要覆盖功能、性能、安全和可靠性测试  | √    |      |  |  |
| 毕昇JDK21支持元数据压缩优化降低堆数据内存使用 | 继承已有测试能力，重点验证通过降低Java对象头占用而减少Java堆内存（Heap Memory）占用能力，主要覆盖功能和可靠性测试 | √    |      |  |  |
| TF原生Embedding算子图优化提高推理性能  | 继承已有测试能力，重点验证图算优化提升推理性能，主要覆盖功能测试和性能测试  | √    |      |  |  |
| 毕昇JDK21版本 G1、PS支持堆内存扩缩容 | 继承已有测试能力，重点验证用户可在应用运行时动态扩展Java堆内存的上限无需重启JVM的能力，主要覆盖功能、性能和可靠性测试  | √    |      |  |  |
| LLVM编译器提升数据库（MySQL）、压缩解压缩（lz4/zstd/xz）等性能 | 继承已有测试能力，重点验证通过编译器优化提升应用性能，主要覆盖功能、性能和可靠性测试 | √    |      |  |  |
| 毕昇JDK21支持JIT warmup， 提升Java启动性能 | 继承已有测试能力，重点验证开启优化特性可避免编译竞争提升应用性能，主要覆盖功能、性能和可靠性测试 | √    |      |  |  |
| OS灵衢组件一键安装配置，业务可感知的通信故障场景快速定位 |继承已有测试能力，UB组件可一键快速安装部署与驱动自动加载，重点验证ub-pkg-cli命令用于配置UB相关组件的配置参数与基础功能检测能力  | √    |      |  |  |
|  内核态操作用户态内存场景，通过容错机制避免UCE故障上报导致系统panic | 继承已有测试能力，重点验证内核在已知故障模式下可保持稳定，避免远端UB内存故障引发的内核崩溃，主要覆盖功能测试和可靠性测试 | √    |      |  |  |
| NPU时域切分及隔离提升利用率 | 继承已有测试能力，验证算力切分特性实现任务到异构算力的按需调度机制，主要覆盖功能、性能和可靠性测试  | √    |      |  |  |
| CRIU支持NPU设备dump/restore | 继承已有测试能力，验证cuiu冻结运行中的应用程序/部分组件后可通过检查点文件从冻结点恢复的能力，主要覆盖功能测试、接口测试、可靠测试和性能测试 | √    |      |  |  |
| AI训练场景慢卡、慢节点分钟级检测、快速定界 | 继承已有测试能力，验证在AI训练场景下，实现对XPU卡的慢卡/慢节点检测和定位，主要覆盖功能测试和可靠性测试 | √    |      |  |  |
|E2B Agent沙箱提供生命周期管理统一接口，支持脚本、K8S方式部署E2B集群   | 继承已有测试能力，验证E2B沙箱平台在openEuler上可一键部署，并可使用K8S进行管理部署，主要覆盖功能测试和可靠性测试 | √    |      |  |  |
| cgroup v2支持内存异步回收功能 | 继承已有测试能力，验证cgroup v2 内存异步回收解决当前cgroup隔离方案导致的易卡死，同步内存回收带来性能下降的痛点，主要覆盖功能测试、性能测试和可靠性测试 | √    |      |  |  |
| 智能Cache注入 | 继承已有测试能力，验证智能cache注入支持LLC与L2 cache stash配置，主要覆盖API接口测试、功能测试、可靠性测试和性能测试  | √    |      |  |  |
| sockmap加速同主机tcp流 | 继承已有测试能力，验证sockmap在socket层旁路tcp协议栈，降低延迟的作用，主要覆盖功能测试和性能测试 | √    |      |  |  |
| GIC超分优化，提升Nginx性能 | 继承已有测试能力，验证相同亲和组动静态迁移测试，跨亲和组动静态迁移测试，主要覆盖功能、性能和可靠性测试等 | √    |      |  |  |
| hisock功能增强，提升目标流量吞吐性能 | 待确认 | √    |      |  |  |
| sysSentry支持硬盘寿命检测和健康监控 | 继承已有测试能力，增强sysSentry故障检测能力，支持上报BMC所有硬盘告警事件，支持告警事件类型可配置化等，主要覆盖功能测试和可靠性测试 | √    |      |  |  |
| 内存支持zone粒度内存回收（异步模式） | 待确认 | √    |      |  |  |
| CCA机密虚机支持设备直通 | 测试已有测试能力，验证CCA机密虚机支持nvme盘/网卡等设备直通PF，多nvme/网卡等设备直通机密虚机  | √    |      |  |  |
| Go语言map SIMD加速、hashtriemap算法优化等，提升hashmap性能 | 继承已有测试能力，验证Go语言map SIMD加速、hashtriemap算法优化等效果，主要覆盖功能测试和性能测试 | √    |      |  |  |
|  AI图编译器TF+XLA动态batch场景并行化优化，提升性能  | 继承已有测试能力，验证XLA编译器支持动态batch和并行优化的效果，主要覆盖功能测试和性能测试 | √    |      |  |  |
|  LLVM实现RabitQ性能提升 | 继承已有测试能力，验证向量化增强优化和memcpy inline优化效果，主要覆盖功能测试和性能测试 | √    |      |  |  |
| LLVM优化降低数据库、搜推场景编译时长 | 继承已有测试能力，验证LLVM使能编译优化效果，主要覆盖功能测试和性能测试  | √    |      |  |  |
| 毕昇JDK GC算法、SVE/DMB指令等优化，提升大数据性能 | 继承已有测试能力，验证毕昇JDK17 GC算法、SVE/DMB指令等优化特性效果，主要覆盖功能测试和性能测试 | √    |      |  |  |
| 虚拟机QEMU支持UB mem D2H | 继承已有测试能力，验证A5虚拟化场景通过UB总线访问KVCache内存，主要覆盖功能测试、可靠性测试和性能测试 | √    |      |  |  |
| 支持IP over URMA | 继承已有测试能力，验证IP over URMA支持智算组网TCP/IP协议通信，主要覆盖API接口测试，功能测试，并发压力测试，可靠性测试以及安全测试等 | √    |      |  |  |

## 专项测试策略

### 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。主要测试项目如下表所示：

| 测试类         | 描述                                                 | 具体测试内容                                                 |
| :------------- | ---------------------------------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | 病毒/安全编译选项/敏感信息/代码片段引用扫描 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全检查       | 开源合规license检查/签名和完整性校验/SBOM            | 检查软件包的license是否合规；对于发布件要求具备签名和完整性校验机制，如RPM需要具备GPG校验与签名；SBOM信息具备自动生成的能力，随软件发布件一起生成与发布 |


### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 测试类性     | 具体测试内容                                                 |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                                               | **指标值**              | **说明**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 与基线数据差异小于5%以内可接受 |

### 兼容性测试

#### 南向兼容性

整机

| **架构**   | **CPU厂商**     | **CPU代号**      |
| ----------  | -------------- | ------------------ | 
|   x86   |   intel    |  cascades     | 
|   aarch64   |   huawei     |  kunpeng920    | 
|   aarch64   |   huawei     |  kunpeng920 7270z    | 
|   aarch64   |   huawei     |  kunpeng950    | 


板卡

| **vendor**   | **chipModel**     | **boardModel**      | **aarch64架构测试** | **x86_64架构测试** |
| ----------  | -------------- | ------------------ | ------------------ | ------------ | 
|   huawei   |    Hi1822（Hi1823）      |   SP680      |  √  |  √  |
|            |    Hi1822                |   SP580      |  √  |  √  |
|            |    板载网卡（hns3）               |         |  √  |    |
|            |    B80121（hiraid）                |   SP686C      |  √  |  √  |
|   microchip|    PM8204                |   PMC3152      |  √  |  √  |
|   nvidia   |    ConnectX-6 DX         |   MCX623106AN-CDAT      |  √  |  √  |
|            |    GA100                 |   Tesla A100      |  √  |  √  |
|   broadcom |    SAS3908               |    9560-8i     |  √  |  √  |
|   intel    |    I350                  |    I350-F2     |  √  |  √  |
|            |   82599ES                |   SP310      |  √  |  √  |
|            |   XL710                  |  XL710-QDA1/XL710-QDA2       |  √  |    |
|            |   E810-XXV               |   E810-XXV-2      |  √  |    |

RISC-V 架构本次南向兼容性测试只做整机适配的测试，整机信息如下：

| **机型** | **CPU**    |
| -------- | ---------- |
| 算能     | 算丰SG2042 |

#### 虚拟化兼容性

虚拟化兼容性(openEuler作为host OS) 覆盖：
* CentOS 6/7/8(centos6只做x86)
* windows server 2016\2019
* Ubuntu 24.04(只做riscv64)


### 软件包管理专项测试

* 软件版本变更检查：检查前序版本的代码变动是否在当前版本继承，保证代码不漏合。
* 多动态库检查：检查软件是否存在多个版本动态库（存在编译自依赖软件包升级方式不规范）


# 测试执行策略

openEuler 24.03 LTS SP4版本按照社区release-management既定的版本计划，共有9轮测试，alpha版本拉取的为24.03 LTS NEXT版本，且alpha本身为开发自验版本，测试不提前投入，RC1轮次开始测试。基本功能保障的beta版本设置在RC3 ，采用全量+增量结合的覆盖测试，保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力.

### 测试计划

openEuler 24.03 LTS SP4版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stage Name                  | Deadline for PR | Begin Time | End Time  | Days | Notes                              |
| --------------------------- | --------------- | ---------- | --------- | ---- | ---------------------------------- |
| Collect key features        | -               | 2026/3/23  | 2026/4/30 | 39   | 版本需求收集                             |
| Change Review 1             | -               | 2026/4/1   | 2026/5/8  | 38   | Review 软件包变更（升级）SP版本尽可能保持版本不变      |
| Herited features            | -               | 2026/3/20  | 2026/4/10 | 22   | 继承特性合入（Branch前完成合入）                |
| Develop                     | -               | 2026/4/1   | 2026/6/6  | 67   | 新特性开发，合入24.03 LTS Next+SP4分支       |
| Kernel freezing             | -               | 2026/4/1   | 2026/5/8  | 38   | 内核冻结，KABI稳定                        |
| Branch                      | <br />          | 2026/3/27  | 2026/4/10 | 15   | 24.03 LTS Next 拉取 24.03 LTS SP4 分支 |
| Next Build                  | -               | 2026/4/4   | 2026/4/10 | 7    | 启动新版本构建，新开发特性合入                    |
| Alpha                       | 2026/4/8        | 2026/4/11  | 2026/4/17 | 7    | Alpha版本发布，24.03 LTS SP4 开发者测试      |
| Test round 1                | 2026/4/15       | 2026/4/18  | 2026/4/24 | 7    | 24.03 LTS SP4 模块测试                 |
| Test round 2                | 2026/4/22       | 2026/4/25  | 2026/4/30 | 6    | 24.03 LTS SP4 模块测试，五一劳动节快乐         |
| Change Review 2             | <br />          | 2026/5/6   | 2026/5/8  | 3    | 发起软件包淘汰评审                          |
| Test round 3 (Beta Version) | 2026/4/29       | 2026/5/9   | 2026/5/15 | 7    | 24.03 LTS SP4 模块测试                 |
| Test round 4                | 2026/5/13       | 2026/5/16  | 2026/5/22 | 7    | 24.03 LTS SP4 模块测试                 |
| Test round 5                | 2026/5/20       | 2026/5/23  | 2026/5/29 | 7    | 24.03 LTS SP4 模块测试                 |
| Test round 6                | 2026/5/27       | 2026/5/30  | 2026/6/5  | 7    | 24.03 LTS SP4 模块测试                 |
| Change Review 3             | <br />          | 2026/6/3   | 2026/6/5  | 3    | 确定软件包发布范围                          |
| Test round 7                | 2026/6/3        | 2026/6/6   | 2026/6/12 | 7    | 全量验证(全量SIT)，分支冻结，只允许bug fix        |
| Test round 8                | 2026/6/10       | 2026/6/13  | 2026/6/18 | 6    | 全量验证(全量SIT)，分支冻结，只允许bug fix        |
| Test round 9                | 2026/6/17       | 2026/6/22  | 2026/6/26 | 5    | 回归测试，只允许阻塞bug fix                  |
| Release Review              | -               | 2026/6/25  | 2026/6/26 | 2    | 版本发布决策/ Go or No Go                |
| Release preparation         | -               | 2026/6/22  | 2026/6/28 | 7    | 发布前准备阶段，发布件系统梳理                    |
| Release                     | -               | 2026/6/29  | 2026/6/30 | 2    | 社区Release评审通过正式发布                  |



### 测试基线 

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 24.03 LTS SP4 RC1 | 冒烟测试         |                                |
|                             | 包管理专项       | baseOS/everything/epol软件包安装卸载                     |
|                             |                | 自编译                      |
|                             | 安全专项      |  扫描-安全编译选项  | 
|                             | 性能专项      |        |
|                             | 安装部署         | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像x86_64虚拟机  |
|                             |                 | 标准镜像PXE安装       |
|                             |                 | everything镜像PXE安装|
|                             | 单包             | 单包命令            |
|                             |                 | 单包服务            |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 内核专项         | 基本功能测试                   |       
| openEuler 24.03 LTS SP4 RC2   | 冒烟测试         |                                |
|                             | 包管理专项         | baseOS/everything/epol软件包升降级                     |
|                             | 安全专项      |   扫描-引用合规     |
|                             | 安装部署         | 标准镜像x86_64物理机 |
|                             |                 | 标准镜像u盘安装 |
|                             |                 | stratovirt镜像x86虚拟机                 |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             |                 | 边缘镜像x86虚拟机                |
|                             |                 | 边缘镜像aarch64虚拟机            |
|                             |                 | 虚机兼容性            |
|                             | 单包           | 单包命令增量             |
|                             |               | 单包服务增量             |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 文件系统     |                                |
|                             | 操作系统默认参数对比     |                                |
| openEuler 24.03 LTS SP4 RC3 | 冒烟测试         |                                |
|                             | 包管理专项       |   baseOS/everything/epol软件包安装卸载  |
|                             | 重启专项专项     |  冷重启                         | 
|                             |                  | 热重启                        |
|                             |                  | 高压重启                       |
|                             |                  | 新增重启专项                    ｜  
|                             | 网络系统     |                                |
|                             | 安全专项          |  扫描-病毒                 |
|                             |                 |  扫描-端口                  |
|                             |                 |  mugen加固测试                   |
|                             |                 |  安全配置基线                |
|                             |                 |  license合规扫描            |
|                             | 性能专项         |                    |
|                             | 安装部署         |  |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像x86虚拟机 |
|                             |                 | 标准镜像PXE安装   |
|                             |                 | everything镜像PXE安装   |
|                             |                 | 边缘镜像x86物理机                |
|                             |                 | 边缘镜像aarch64物理机            |
|                             | 内核专项         |  POSIX标准测试                   |  
|                             |                 |  性能测试                  | 
|                             |                 |  安全测试                 | 
|                             |                 |  长稳测试                  |  
|                             | 单包           | 单包命令增量             |
|                             |               | 单包服务增量             |
|                             | 场景测试              | k3s部署验证             |
| openEuler 24.03 LTS SP4 RC4 | 冒烟测试         |                                |
|                             | 包管理专项         | baseOS/everything/epol软件包升降级增量 |
|                             |                  | 自编译                     |
|                             | 安装部署         | 标准镜像x86物理机                       |
|                             |                  | 标准镜像u盘安装                 |
|                             |                 | stratovirt镜像x86虚拟机                 |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             |                 | 虚拟机兼容性                 |
|                             | 单包            | 单包命令增量             |
|                             |                 | 单包服务增量             |
| openEuler 24.03 LTS SP4 RC5 | 冒烟测试         |                                |
|                             | 包管理专项       | 软件包安装卸载      |
|                             |                 | 软件包升降级      |
|                             |                 | 自编译           |
|                             | 安全专项         |  扫描-安全编译选项               |
|                             | 操作系统默认参数对比       |                       |
|                             | 性能专项         |                   |
|                             | 安装部署         |  |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像PXE安装                |
|                             |                 | everything镜像PXE安装         |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 单包            | 单包命令             |
|                             |                 | 单包服务             |
|                             | 内核专项         | 基本功能测试                   | 
| openEuler 24.03 LTS SP4 RC6     | 冒烟测试         |                                |
|                             | 包管理专项       | baseOS/everything/epol软件包安装卸载增量      |
|                             | 性能专项         |                   |
|                             | 安装部署         | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像x86虚拟机    |
|                             |                 | 标准镜像PXE安装   |
|                             |                 | everything镜像PXE安装         |
|                             |                 | stratovirt镜像x86虚拟机                 |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             |                 | 边缘镜像x86虚拟机      |
|                             |                 | 边缘镜像aarch64虚拟机  |
|                             |                 | 虚拟机兼容性  |
|                             | 内核专项         | 长稳测试                   | 
|                             | 单包            |             |
|                             |                 | 单包命令增量            |
|                             |                 | 单包服务增量             |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             |                  | 长稳测试                  |
|                             | 安全专项         |  扫描-引用合规               |
| openEuler 24.03 LTS SP4 RC7     |    冒烟测试   |                    |
|                             | 安装部署         | 标准镜像x86物理机 |
|                             |                  | 标准镜像u盘安装                 |
|                             |                 | 边缘镜像x86物理机      |
|                             |                 | 边缘镜像aarch64物理机  |
|                             | 内核专项         |  POSIX标准测试                   |  
|                             |                 |  性能测试                  | 
|                             |                 |  安全测试                 | 
|                             | 包管理专项         | baseOS/everything/epol软件包升降级增量 |
|                             |               | 自编译 |
|                             | 单包           | 单包命令增量             |
|                             |               | 单包服务增量             |
|                             | 场景测试              | k3s部署验证             |
|                             | 安全专项          |  mugen加固测试                 |
|                             |                 |  扫描-端口                  |
|                             |                 |  安全配置基线                |
|                             |                 |  license合规扫描            |
|                             | 操作系统默认参数对比     |                                |
 openEuler 24.03 LTS SP4 RC8  |    冒烟测试   |                    |
|                             |    安装部署         | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像PXE安装   |
|                             |                 | everything镜像PXE安装         |
|                             |    内核专项      | 基本功能测试                   | 
|                             |  包管理专项       | baseOS/everything/epol软件包安装卸载      |
|                             |  单包         |   单包命令             |
|                             |               |  单包服务             |
|                             | 文件系统     |                                |
|                             | 网络系统     |                                |
|                             | 重启专项专项     |  冷重启                         | 
|                             |                  | 热重启                        |
|                             |                  | 高压重启                       |
|                             |                  | 新增重启专项             
|                             | 安全专项          |                   |
|                             |                 |  扫描-安全编译选项                  |
|                             |                 |  扫描-病毒                  |
|                             |                 |  扫描-引用合规                  |
|                             |                 |  扫描-端口                  |
|                             |                 |  mugen加固测试                 |
|                             |                 |  安全配置基线                |
|                             |                 |  license合规扫描            |
|                             | 操作系统默认参数对比       |                       |
|                             | 动态库检查       |                       |
|                             | 版本变化检查专项 |             |
|                             |                 | 软件包升降级变化分析            |
|                             |                 | 软件范围变化测试                |
 openEuler 24.03 LTS SP4 RC9     |    冒烟测试   |                    |
 |                             |    安装部署         | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像x86物理机   |
|                             |                 | 标准镜像x86虚拟机   |
|                             |                 | 标准镜像u盘安装 |
|                             |                 | stratovirt镜像x86虚拟机                 |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             |                 | 虚拟机兼容性                 |
|                             | 包管理专项         | baseOS/everything/epol软件包升降级 |
|                             |  单包         |   单包命令增量             |
|                             |               |  单包服务增量             |
|                             | 性能专项         |                   |
|                             | 回归测试       | 问题单回归                        |
 openEuler 24.03 LTS SP4 release     |      |                    |
|                             | release发布件测试      |      AT                 |
|                             | 发布件sha256值校验      |                        |
|                             | SBOM文件签名      |                        |
|                             | rpm包签名      |                        |

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无


![openEuler ico](../../images/openEuler.png)

版权所有 © 2025 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期      | 修订版本 | 修改  章节 | 修改描述 | 作者        |
| --------- | -------- | ---------- | -------- | ----------- |
| 2025-08-01 | 1.0.0    |            | 初稿     | ga_beng_cui |
| 2025-08-13 | 1.0.1 |  | add RISC-V | jean9823 |


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

本文是openEuler 25.09版本的整体测试策略，用于指导该版本后续测试活动的开展。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 25.09版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 25.09是基于6.6内核的创新版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于master分支拉出，软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.09/release-change.yaml)

## 需求范围

openEuler 25.09版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.09/release-plan.md)如下：

状态说明：Discussion(方案讨论，需求未接受)、 Developing(开发中)、 Testing(测试中)、 Accepted(已验收) <br>
发布方式：ISO、Everything、EPOL、oepkgs、独立发布等

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|[ICKOE7](https://gitee.com/openeuler/release-management/issues/ICKOE7?from=project-issue)|  GTA远程证明支持VirtCCA | Developing | sig-security-facility | [ @yang8621 ](https://gitee.com/yang8621) |ISO| global-trust-authority、secGear|
|[ICM8OF](https://gitee.com/openeuler/release-management/issues/ICM8OF)|以 valkey 取代 redis 作为首选的内存数据库|Developing|DB|[@fundawang](https://gitee.com/fundawang)|Everything|valkey|
| [ICMV3X](https://gitee.com/openeuler/release-management/issues/ICMV3X) | 支持树莓派 | Developing | sig-SBC | [@woqidaideshi](https://gitee.com/woqidaideshi/) | EPOL | raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom,raspberrypi-utils |
| [ICOAHM](https://gitee.com/openeuler/release-management/issues/ICOAHM) | kuasar机密容器低底噪，高性能 | Developing | sig-CloudNative | [@liuxu180400617](https://gitee.com/liuxu180400617/) | Everything | kuasar |


# 测试分层策略(*基于继承特性策略刷新*)

本次25.09版本的具体测试分层策略如下：

| **序号**| **需求**                                              | **开发主体**            | **测试主体**           | **测试分层策略**                                             |
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
|11|发布eggo                                              | sig-CloudNative  | sig-QA  | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
|12|支持kubeOS                                            | sig-CloudNative  | sig-QA | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
|13| 支持etmem                               | Storage   | sig-QA  | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
|14| 支持用户态协议栈gazelle                               | sig-high-performance-network | sig-QA | 关注gazelle高性能用户态协议栈功能                            |
|15| 支持国密算法                                          | sig-security-facility| sig-QA  | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
|16| 支持pod带宽管理oncn-bwm                               | sig-high-performance-network | sig-QAk | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
|17| iSulad                                 | sig-iSulad   | sig-QA  |  覆盖继承功能，重点验证isulad长稳场景                 |
|18| 支持A-OPS                                 | sig-iSulad   | sig-QA  | 重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景                 |
|19| 支持系统运维套件x-diagnosis                           | sig-ops | sig-QA | 覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能  |
|20| 支持自动化热升级组件nvwa                              | sig-ops  | sig-QA    | 覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 |
|21| 支持DPU直连聚合特性dpu-utilities                                   | sig-DPU | sig-DPU  | 验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 |
|22| 支持系统热修复组件syscare                             | sig-ops | sig-QA | 验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力      |
|23| iSula容器镜像构建工具isula-build                      | sig-iSulad   | sig-QA  | 验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 |
|24| 支持进程完整性防护特性DIM                                | sig-security-facility  | sig-security-facility  | 验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 |
|25| 支持入侵检测框架secDetector                           | sig-security-facility | sig-security-facility  | 验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 |
|26| isocut镜像裁剪                              | sig-OS-Builder| sig-OS-Builder | 验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 |
|27| 支持devmaster组件                                     | sig-dev-utils  | sig-dev-utils  | 验证devmaster的安装部署、进程配置、客户端工具等使用场景      |
|28|支持TPCM特性                                          | sig-Base-service | sig-Base-service   | 验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 |
|29| 支持sysMaster组件                                     | sig-dev-utils   | sig-dev-utils    | 验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景 |
|30| 支持sysmonitor特性                                    | sig-ops  | sig-QA   | 验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景 |
|31| 支持容器场景在离线混合部署rubik                       | sig-CloudNative | sig-CloudNative | 结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
|32| 支持IMA|   sig-security-facility  | sig-QA | 验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式 |
|33| 支持IMA virtCCA |  sig-security-facility  |  sig-QA  | 验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等  |
|34| 安全启动 |  sig-security-facility  |  sig-QA  | 验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等； |
|35| Kmesh |  sig-ebpf  | sig-QA   | 验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等 |
|36| openEuler安全配置规范框架设计及核心内容构建 |  sig-security-facility  |  sig-QA  | 验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性 |
|37| oemaker |  sig-OS-Builder  |  sig-QA  | 重点验证oemaker在构建工程中功能正常  |
|38| openssl |  sig-security-facility  |  sig-QA  | 验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上 |
|39| sysSentry |  sig-Base-service  |  sig-QA  | 重点关注sysCentry服务和基本命令正常，巡检项和巡检结果正常 |
|40|编译器(gcc/jdk)                                       | Compiler  | sig-QA  | 基于开源测试套对gcc和jdk相关功能进行验证                     |
|41| 支持HA软件                                            | sig-Ha | sig-Ha  | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
|42|支持KubeSphere                                        | sig-K8sDistro | sig-K8sDistro | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
|43| 支持OpenStack Train 和 Wallaby                        | sig-OpenStack | sig-OpenStack  | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能   |
|44| 支持智能运维助手                                     | sig-ops| sig-QA   | 关注智能定位（异常检测、故障诊断）功能、可靠性               |
|45| 支持k3s                                               | sig-K8sDistro| sig-K8sDistro | 验证k3s软件的部署测试过程                                    |
|46| Kunpeng加速引擎                                       | sig-AccLib  | sig-AccLib | 验证对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加速器KAE的基本功能和性能测试 |
|47| migration-tools增加图形化迁移openeuler功能            | sig-Migration| sig-Migration  | 验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 |
|48| 发布Nestos-kubernetes-deployer                        | sig-K8sDistro  | sig-K8sDistro  | 验证在NestOS上部署，升级和维护kubernetes集群功能正常         |    
|49| 支持NestOS                                            | sig-CloudNative | sig-CloudNative | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
|50| 发布PilotGo及其插件特性新版本                         | sig-ops  | sig-QA  | 验证PilotGo支持 topo 图的展示和智能调优能力                  |
|51| 社区签名体系建立                                      | sig-security-facility  | sig-security-facility        | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
|52| 智能问答在线服务                                      | sig-A-Tune  | sig-QA   | 验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 |
|53| 增加 AO.space 项目发布                                | sig-RaspberryPi  | sig-RaspberryPi  | 通过软件包和容器镜像验证aospace系统管理程序和服务组件为个人数据提供基础网络访问、安全防护等 |
|54| ZGCLab 发布内核安全增强补丁                           | sig-kernel   | sig-kernel   | 针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 |
|55| 支持RISC-V                                            | sig-RISC-V | sig-RISC-V  | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
|56|为 RISC-V 架构引入 Penglai TEE 支持                   | sig-RISC-V | sig-RISC-V | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 |
|57| LLVM平行宇宙计划 RISC-V Preview 版本 | sig-RISC-V | sig-RISC-V |验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动 |
|58| 支持embedded                                          | sig-embedded  | sig-embedded  | 验证openEuler embedded的构建镜像和完成嵌入式应用开发能力     |
|59| 支持wine9.17                                        | sig-compat-winapp  | sig-compat-winapp  |  覆盖继承功能，重点验证wine支持將 Windows API 调用翻译成为动态的 POSIX 调用，能够在操作系统上以更少的资源占用运行windows应用的能力   |
|60| Add compatibility patches for Zhaoxin processors    |  sig-kernel |  sig-kernel |  验证集成了Zhaoxin OLK-6.6补丁的内核镜像系统正常运行以及对应补丁的功能测试   |
|61| virtCCA机密虚机特性合入       | sig-kernel/sig-virt  | sig-kernel/sig-virt  |   继承已有测试能力，重点验证机密虚机的基本功能、安全、兼容性以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试  |
|62| Add Intel QAT packages support    | sig-Intel-Arch  | sig-Intel-Arch  |  继承已有测试能力，重点验证intel qat相关软件包的功能和性能    |
|63| 增加YouQu自动化测试平台支持    | sig-QA  | sig-QA  |  验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试    |   
|64| 增加 utsudo 支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utsudo基础命令使用正常   |   
|65| 增加 utshell支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utshell基础命令使用正常   |
|66| 海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核）    |  sig-kernel | sig-kernel  |  重点验证CSV3虚拟机的不同启动方式，覆盖功能、稳定性、兼容性测试  |
|67| 集成openGauss 6.0.0 LTS企业版       | sig=DB  | sig=DB  |  重点验证openGauss 6.0.0数据库系统工具、SQL功能、数据库升级、兼容B库模块等功能测试   |
|68| LLVM多版本实现                      | sig-Compiler  |  sig-Compiler |  继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。   |
|69| 新增密码套件openHiTLS               |  sig-security-facility |  sig-security-facility |  继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试    |
|70| AI流水线oeDeloy       | sig-cicd  | sig-QA  |  继承已有测试能力，重点验证通过oeDeploy进行kubeflow部署及k8s基础功能测试   |
|71| 支持epkg新型软件包及包管理器             |  sig-cicd | sig-QA  |  继承已有测试能力，重点验证epkg包构建，输出epkg软件包以及包管理器实现环境创建，多版本运行等功能   |
|72| 支持oeaware                |  sig-A-Tune | sig-QA  |  继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容  |
|73| DevStation 开发者工作站支持                      | sig-desktop  | sig-QA  |   继承已有测试能力，重点验证安装部署启动、支持图形化编程环境，以及融合的epkg、Eulercopilot、x2openEuler的基本功能 |
|74| AI集群慢节点快速发现 Add Fail-slow Detection      | sig-desktop   |  sig-desktop |  继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度   |
|75| RPM国密签名支持                             | sig-security-facility  | sig-security-facility  |  重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容   |
|76| 鲲鹏KAE加速器驱动安装包合入                  | sig-kernel  | sig-kernel  |  继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩   |
|77| Add OpenVINO packages native support  |  sig-Intel-Arch/sig-intelligence |  sig-Intel-Arch/sig-intelligence |  继承已有测试能力，验证OpenVINO框架上sample code编译运行成功和OpenVINO的推理功能   |
|78| Add oneAPI low level native support   | sig-Intel-Arch/sig-intelligenc  |  sig-Intel-Arch/sig-intelligenc |  继承已有测试能力，重点验证oneAPI对于sample code的编译运行，大模型基于oneAPI加速框架的正确支持以及相应软件包的功能测试   |
|79| 版本引入ACPO包    | sig-Compiler  |  sig-Compiler |  继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容   |
|80| 内核TCP/IP协议栈支持CAQM拥塞     |  sig-kernel |  sig-kernel |  继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能   |
|81| oeDeploy 部署能力增强 | sig-ops | sig-ops | 继承已有测试能力，功能测试覆盖ray、kubeflow相关组件、TensorFlow、Pytorch、EulerMaker组件单机及分布式部署 |
|82| 主流工业中间件支持 | sig-embedded | sig-embedded| 继承已有测试能力，验证引入主流工业中间件相关软件包后，能查询到相关软件包，且软件包基础功能正常，能稳定运行。 |
|83| 跨域通信框架，支持接口调用跨域通信 | sig-embedded| sig-embedded| 继承已有测试能力，验证通过接口读写Linux侧文件，读写成功，通信正常 |
|84| 虚拟化底座，使能XEN虚拟化框架 | sig-embedded| sig-embedded| 继承已有测试能力，验证通过不同方式启动多个Xen,覆盖boot、grub;Xen启动后能正常拉起多个dom;通过不同内核创建dom |
|85| 硬实时南向生态：EtherCAT支持 | sig-embedded | sig-embedded| 继承已有测试能力，测试硬实时上EtherCAT通过SDO、PDO数据传输以及COE上层应用功能 |
|86| 嵌入式：硬实时POSIX接口补齐 | sig-embedded | sig-embedded | 继承已有测试能力，测试硬实时上通过相关接口测试用例|
|87| 为AArch64编译默认开启PAC/BTI | sig-Arm | sig-Arm | 继承已有测试能力，主要覆盖功能测试和兼容性测试，重点关注通过读取软件包中的二进制ELF文件检查PAC/BTI的支持情况 |
|88| 支持树莓派 | sig-SBC  | sig-SBC | 针对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性测试 |
|89| Aops: cve修复/配置溯源实现运维智能化，支持主动通知和图文混合交互 | sig-ops|sig-QA | 主要覆盖智能运维助手、用户管理、资产管理、配置溯源等模块的功能测试 |
|90| 基于sysboost实现启动时优化，通用兼容性增强 | sig-Compiler| sig-Compiler |验证HOST和容器场景，涉及功能、可靠性、性能、安全测试，重点关注可靠性测试 |
|91| GCC for openEuler编译链接加速，缩减编译时间 | sig-Compiler| sig-QA | 验证打开PGO+LTO优化GCC + mold链接器编译94个C/C++组件，编译总时间对比基线，编译时间减少比例达到9.55%|
|92| 机密容器Kuasar适配virtCCA | sig-CloudNative| sig-CloudNative |针对机器容器的基本功能进行测试，包括生命周期，服务稳定性，资源占用，并发测试，资源残留等功能场景进行测试|
|93| secGear支持机密容器镜像密钥托管 | sig-security-facility|sig-security-facility | 基于token获取秘钥，验证秘钥的增删改查、秘钥绑定、解绑策略、策略的增删查询|
|94| 构建基于远程证明的TLS协议（RA-TLS） | sig-security-facility|sig-security-facility |验证服务端生成自签名证书功能测试、各对外接口正常和异常测试，包括各个参数的正常、异常值测试 |
|95| Trace IO加速容器快速启动 | sig-Kernel| sig-Kernel| 验证开启TrIO特性后加载web类容器和应用类容器的启动、删除场景 |
|96| 引入vkernel概念增强容器隔离能力 | sig-Kernel| sig-Kernel | 针对其功能、性能和兼容性进行LTP、UnixBench、容器运行时对比、容器生态兼容、相关应用性能进行测试|
|97| openAMDC合入 | sig-BigData| sig-BigData | 验证软件的核心功能模块，包括string、list、hash、set、sortedset等数据类型读写和主从复制、服务高可用功能 |
|98| oeAware支持瓶颈评估一键推荐调优等特性增强 | sig-A-Tune | sig-QA |验证透明大页场景识别、透明大页使能禁用、查询模块显示以及虚拟网卡亲和配置场景功能测试、异常测试|
|99| DevStation社区原生/图形化/南向兼容性等新增特性 | sig-ops/IDE |sig-QA | 验证默认集成epkg/eulercopilot/oeDeploy/devkit、支持常用浏览器/邮箱、支持社区开发环境，以及南向支持裸机部署等测试|
|100|  EPKG包管理器优化，提升epkg易用性 | sig-CICD |sig-QA |验证epkg包管理器、x2epkg实现软件包二进制转化以及加包工程自动批量转换等功能测试、兼容性测试、可靠性测试|
|101| 支持 OpenStack Antelope 版本 | sig-openstack  | sig-openstack | 验证 API 测试和功能测试,涉及虚拟机（KVM、Qemu）、存储（lvm、NFS、Ceph后端）、网络资源（linuxbridge、openvswitch）管理操作等|

# 测试分析设计策略

## 新增feature测试设计策略

| *序号*  | *Feature*   |*测试设计策略*  | *测试重点*  |Arm  | X86  | RISC-V | LoongArch |
| ------------ | -------------------------------- | -------------------------------- |-------------------------------- | ---- | ---- | ------ | --------- |
|[ICKOE7](https://gitee.com/openeuler/release-management/issues/ICKOE7?from=project-issue)|  GTA远程证明支持VirtCCA |[GTA远程证明支持VirtCCA测试策略](https://gitee.com/openeuler/QA/pulls/1089)| 测试Agent、Server端VirtCCA插件基本功能以及端到端的连通性| √ | × | × | |
|[ICM8OF](https://gitee.com/openeuler/release-management/issues/ICM8OF)|以 valkey 取代 redis 作为首选的内存数据库|[以 valkey 取代 redis 作为首选的内存数据库](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_25.09/%E4%BB%A5%20valkey%20%E5%8F%96%E4%BB%A3%20redis%20%E4%BD%9C%E4%B8%BA%E9%A6%96%E9%80%89%E7%9A%84%E5%86%85%E5%AD%98%E6%95%B0%E6%8D%AE%E5%BA%93.md)  |测试 valkey 服务的正常启动与停止 | √ | √ | √ | |
| [ICMV3X](https://gitee.com/openeuler/release-management/issues/ICMV3X) | 支持树莓派 | [待提交]|检验内核版本、各项基本功能的回归测试、各支持机型的硬件兼容性测试 | √ |  × | × | |
| [ICOAHM](https://gitee.com/openeuler/release-management/issues/ICOAHM) | kuasar机密容器低底噪，高性能 |[kuasar机密容器低底噪，高性能测试策略](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_25.09/%E3%80%90%E4%BA%91%E5%8E%9F%E7%94%9F%E3%80%91kuasar%E6%9C%BA%E5%AF%86%E5%AE%B9%E5%99%A8%E4%BD%8E%E5%BA%95%E5%99%AA%EF%BC%8C%E9%AB%98%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95%E7%AD%96%E7%95%A5.md) | 测试kuasar机密容器的管理面内存底噪开销，以及机密容器的启动时间。| √ | × | × | |

## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                                          | 策略                                                         | Arm  | X86  | RISC-V | LoongArch |
| ----------------------------------------------------- | ------------------------------------------------------------ | ---- | ---- | ------ | --------- |
| 支持DDE桌面                                           | 继承已有测试能力，关注DDE桌面系统的安装和基本功能            | √    | √    | √      |           |
| 支持UKUI桌面                                          | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           | √    | √    | √      |           |
| 支持Kiran桌面                                         | 增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 | √    | √    | √      |           |
| 安装部署                                              | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 | √    | √    | √     |           |
| 内核                                              | 继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 | √    | √    | √     |           |
| 容器(isula/docker/安全容器/系统容器/镜像)             | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 | √    | √    | √      |           |
| 虚拟化                                                | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 | √    | √    | ×     |           |
| 支持A-Tune                                            | 继承已有测试能力，本次无新增合入，重点关注继承功能验证，如服务/配置检查等。 | √    | √    | √   |           |
| 支持secPaver                                           | 继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    | √    | √    | √    |           |
| 支持secGear                                           | 继承已有测试能力，关注secGear特性的功能完整性，重点关注上次新增合入远程证明框架的功能完整性和准确性。               | √    | √    | ×     |           |
| 支持eggo                                              | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 | √    | √    | √    |           |
| 支持kubeOS                                            | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 | √    | √    | ×     |           |
| 支持etmem内存分级扩展                                 | 继承已有测试能力，重点验证特性的基本功能和稳定性             | √    | √    | ×     |           |
| 支持用户态协议栈gazelle                               | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能      | √    | √    | √  |           |
| 支持国密算法                                          | 继承已有测试能力，验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 | √    | √    | √     |           |
| 支持pod带宽管理oncn-bwm                               | 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 | √    | √    | ×     |           |
| 支持isuald                             | 继承已有测试能力，重点验证isulad长稳场景 | √    | √    | √     ||
| 支持A-OPS                             | 继承已有测试能力，重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景| √    | √    | ×     ||
| 支持系统运维套件x-diagnosis                           | 继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能 | √    | √    | ×   |           |
| 支持自动化热升级组件nvwa                              | 继承已有测试能力，覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 | √    | × | ×     |           |
| 支持DPU直连聚合特性dpu-utilities                                   | 继承已有测试能力，验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 | √    | √    | ×     |           |
| 支持系统热修复组件syscare                             | 继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力 | √    | √    | √      |           |
| iSula容器镜像构建工具isula-build                      | 继承已有测试能力，验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 | √    | √    | √      |           |
| 支持进程完整性防护特性                                | 继承已有测试能力，验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 | √    | √    | ×     |           |
| 支持入侵检测框架secDetector                           | 继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 | √    | √    | ×   |           |
| isocut镜像裁剪                                        | 继承已有测试能力，验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 | √    | √    | ×     |         |
| 支持devmaster组件                                     | 继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景 | √    | √    | √    |           |
| 支持TPCM特性                                          | 继承已有测试用例，验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 | √    | × | ×     |           |
| 支持sysMaster组件                                     | 继承已有测试能力，验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景 | √    | √    | √      |           |
| 支持sysmonitor特性                                    | 继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景 | √    | √    | √     |           |
| 混合部署rubik                                         | 继承已有测试能力，覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化 | √    | √    | ×     |           |
| pod带宽管理                              |继承已有测试能力，验证使能/网卡Qos功能，设置cgroup优先级、在线水线、离线带宽等功能，使能网卡QOS功能后，在线业务可实时抢占离线业务带宽，以及功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等。 | √    | √    | ×     ||
| 国密                              |继承已有测试能力，验证SSH协议栈、TLCP协议栈、内核模块签名、安全启动、文件完整性保护、用户身份鉴别、磁盘加密、算法库等模块支持国密算法。 | √    | √    | ×     ||
| DIM                              |继承已有测试能力，验证dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等，用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量，以及度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量。 | √    | √    | √     ||
| 支持IMA自定义证书                             | 继承已有测试能力，验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式。| √    | √    | ×     ||
| 支持IMA virtCCA                             |继承已有测试能力，验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等； | √    | √    | ×     ||
| 安全启动                            | 继承已有测试能力，验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等；| √    | √    | ×     ||
| Kmesh                              | 继承已有测试能力，验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等。| √    | √    | ×     ||
| openEuler安全配置规范框架设计及核心内容构建                             |继承已有测试能力，验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性 | √    | √    | ×     ||
| oemaker                              |继承已有测试能力，在构建工程中保证oemaker功能正常 | √    | √    | √     ||
| openssl                              |继承已有测试能力，验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上 | √    | √    | √     ||
| sysCentry                             |继承已有测试用例，重点关注sysCentry服务和基本命令正常，巡检项和巡检结果正常 | √    | √    | ×     ||
| 编译器(gcc/jdk)                                       | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   | √    | √    | √      |           |
| 支持HA软件                                            | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 | √    | √    | ×     |           |
| 支持KubeSphere                                        | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力 | √    | √    | ×     |           |
| 支持openstack Train 和 Wallaby                        | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能 | √    | √    | ×     |           |
| 支持智能运维助手                                     | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性 | √    | √    | ×     |           |
| 支持k3s                                               | 继承已有测试能力，验证k3s软件的部署测试过程                  | √    | √    | ×     |           |
| Kunpeng加速引擎                                       | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 | √    | √    | ×     |           |
| migration-tools增加图形化迁移openeuler功能            | 继承已有测试能力，验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 | √    | √    | ×     |           |
| 发布Nestos-kubernetes-deployer                        | 继承已有测试能力，覆盖在NestOS上部署，升级和维护kubernetes集群功能正常 | √    | √    | ×     |           |
| 支持NestOS                                            | 继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 | √    | √    | ×     |           |
| 发布PilotGo及其插件特性新版本                         | 继承已有测试能力，验证PilotGo支持 topo 图的展示和智能调优能力 | √    | √    | ×    |           |
| 社区签名体系建立                                      | 继承已有测试能力，验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性。 | √    | √    | ×      |           |
| 智能问答在线服务                                      | 继承已有测试能力，验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 | √    | √    | ×     |           |
| 增加 AO.space 项目发布                                | 继承已有测试能力，通过软件包和容器镜像验证aospace系统管理程序和服务组件为个人数据提供基础网络访问、安全防护等 | √    | √    | ×     |           |
| ZGCLab 发布内核安全增强补丁                           | 继承已有测试能力，针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 | √    | × | ×     |           |
| 支持RISC-V                                            | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性 | √    | √    | √      |           |
| 为 RISC-V 架构引入 Penglai TEE 支持                   | 继承已有测试能力，验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 | ×    | ×    | √    |  |
| 支持embedded                                          | 继承已有测试能力，验证openEuler embedded的构建镜像和完成嵌入式应用开发能力 | √    | √    | ×     |           |
|  支持wine9.17   |  覆盖继承功能，重点验证wine支持將 Windows API 调用翻译成为动态的 POSIX 调用，能够在操作系统上以更少的资源占用运行windows应用的能力   | √    | √    | × |           |
|  Add compatibility patches for Zhaoxin processors    |   验证集成了Zhaoxin OLK-6.6补丁的内核镜像系统正常运行以及对应补丁的功能测试  | √    | √    | √ |           |
|  virtCCA机密虚机特性合入   |  继承已有测试能力，重点验证机密虚机的基本功能、安全、兼容性以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试   | √    | × | × |           |
|  Add Intel QAT packages support   |  继承已有测试能力，重点验证intel qat相关软件包的功能和性能   | × |   √  | × |           |
|  增加YouQu自动化测试平台支持   |  验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试   | √    | √    |   √    |           |
|  增加 utsudo 支持    |  继承已有测试能力，验证utsudo基础命令使用正常   | √    | √    |   √     |           |
|  增加 utshell支持   |   继承已有测试能力，验证utshell基础命令使用正常  | √    | √    |   √     |           |
|  海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核）   |  重点验证CSV3虚拟机的不同启动方式，覆盖功能、稳定性、兼容性测试   | × | √    | × |           |
|  集成openGauss 6.0.0 LTS企业版    |   重点验证openGauss 6.0.0数据库系统工具、SQL功能、数据库升级、兼容B库模块等功能测试   | √    | √    | √ |           |
|  LLVM多版本实现    |  继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用   | √    | √    | √ |           |
|  新增密码套件openHiTLS     |  继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试   | √    | √    | × |           |
|  AI流水线oeDeloy   |  继承已有测试能力，重点验证通过oeDeploy进行kubeflow部署及k8s基础功能测试   | √    | × | × |           |
|  支持epkg新型软件包及包管理器        |  继承已有测试能力，重点验证epkg包构建，输出epkg软件包以及包管理器实现环境创建，多版本运行等功能    | √    | × | × |           |
|  支持oeaware    |  继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容   | √    | √   | × |           |
|  DevStation 开发者工作站支持  |  继承已有测试能力，重点验证安装部署启动、支持图形化编程环境，以及融合的epkg、Eulercopilot、x2openEuler的基本功能   |  √    | × | × |           |
|  AI集群慢节点快速发现 Add Fail-slow Detection   |   继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度  | √    | √    |  ×     |           |
|  RPM国密签名支持  |  重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容   | √    | √    |  ×     |           |
|  鲲鹏KAE加速器驱动安装包合入  |  继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩    | √    | × | × |           |
|  Add OpenVINO packages native support  |   继承已有测试能力，验证OpenVINO框架上sample code编译运行成功和OpenVINO的推理功能   | √    | √    | × |           |
|  Add oneAPI low level native support  |   继承已有测试能力，重点验证oneAPI对于sample code的编译运行，大模型基于oneAPI加速框架的正确支持以及相应软件包的功能测试   | √    | √    | × |           |
|  版本引入ACPO包   |  继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容   | √    | √    |   ×   |           |
|  内核TCP/IP协议栈支持CAQM拥塞     |    继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能  | √    | √    | √ |           |
|oeDeploy 部署能力增强  | 继承已有测试能力，功能测试覆盖ray、kubeflow相关组件、TensorFlow、Pytorch、EulerMaker组件单机及分布式部署 |√    | √    | × |           |
|主流工业中间件支持 |  继承已有测试能力，验证引入主流工业中间件相关软件包后，能查询到相关软件包，且软件包基础功能正常，能稳定运行。 |√    | ×    | × |           |
|跨域通信框架，支持接口调用跨域通信 | 继承已有测试能力，验证通过接口读写Linux侧文件，读写成功，通信正常 |√    | ×    | × |           |
|虚拟化底座，使能XEN虚拟化框架 |  继承已有测试能力，验证通过不同方式启动多个Xen,覆盖boot、grub;Xen启动后能正常拉起多个dom;通过不同内核创建dom |√    | ×    | × |           |
|硬实时南向生态：EtherCAT支持 | 继承已有测试能力，测试硬实时上EtherCAT通过SDO、PDO数据传输以及COE上层应用功能 |√    | ×    | × |           |
|嵌入式：硬实时POSIX接口补齐 |  继承已有测试能力，测试硬实时上通过相关接口测试用例|√    | ×    | × |           |
|为AArch64编译默认开启PAC/BTI | 继承已有测试能力，主要覆盖功能测试和兼容性测试，重点关注通过读取软件包中的二进制ELF文件检查PAC/BTI的支持情况 |√    | ×    | × |           |
|支持树莓派 | 继承已有测试能力，针对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性测试 |√    | ×    | × |           |
|Aops: cve修复/配置溯源实现运维智能化，支持主动通知和图文混合交互 |继承已有测试能力，主要覆盖智能运维助手、用户管理、资产管理、配置溯源等模块的功能测试 |√    | √    | × |           |
|基于sysboost实现启动时优化，通用兼容性增强  |继承已有测试能力，验证HOST和容器场景，涉及功能、可靠性、性能、安全测试，重点关注可靠性测试 |√    | ×    | × |           |
|GCC for openEuler编译链接加速，缩减编译时间 | 继承已有测试能力，验证打开PGO+LTO优化GCC + mold链接器编译94个C/C++组件，编译总时间对比基线，编译时间减少比例达到9.55%|√    | ×    | × |           |
|机密容器Kuasar适配virtCCA |继承已有测试能力，针对机器容器的基本功能进行测试，包括生命周期，服务稳定性，资源占用，并发测试，资源残留等功能场景进行测试|√    | ×    | × |           |
|secGear支持机密容器镜像密钥托管  | 继承已有测试能力，基于token获取秘钥，验证秘钥的增删改查、秘钥绑定、解绑策略、策略的增删查询|√    | ×    | × |           |
|构建基于远程证明的TLS协议（RA-TLS） |继承已有测试能力，验证服务端生成自签名证书功能测试、各对外接口正常和异常测试，包括各个参数的正常、异常值测试 |√    | ×    | × |           |
|Trace IO加速容器快速启动| 继承已有测试能力，验证开启TrIO特性后加载web类容器和应用类容器的启动、删除场景 |√    | √    | √ |           |
|引入vkernel概念增强容器隔离能力 | 继承已有测试能力，针对其功能、性能和兼容性进行LTP、UnixBench、容器运行时对比、容器生态兼容、相关应用性能进行测试|√    | √    | × |           |
| openAMDC合入| 继承已有测试能力，验证软件的核心功能模块，包括string、list、hash、set、sortedset等数据类型读写和主从复制、服务高可用功能 |√    | √    | × |           |
| oeAware支持瓶颈评估一键推荐调优等特性增强  |继承已有测试能力，验证透明大页场景识别、透明大页使能禁用、查询模块显示以及虚拟网卡亲和配置场景功能测试、异常测试|√    | ×    | × |           |
| DevStation社区原生/图形化/南向兼容性等新增特性 | 继承已有测试能力，验证默认集成epkg/eulercopilot/oeDeploy/devkit、支持常用浏览器/邮箱、支持社区开发环境，以及南向支持裸机部署等测试|√    | √    | × |           |
| EPKG包管理器优化，提升epkg易用性 |继承已有测试能力，验证epkg包管理器、x2epkg实现软件包二进制转化以及加包工程自动批量转换等功能测试、兼容性测试、可靠性测试|√    | √    | × |           |
| 支持 OpenStack Antelope 版本 | 继承已有测试能力，验证 API 测试和功能测试,涉及虚拟机（KVM、Qemu）、存储（lvm、NFS、Ceph后端）、网络资源（linuxbridge、openvswitch）管理操作等|√    | √    | × |           |



## 专项测试策略

### 安全测试

[openEuler 25.09版本安全测试策略]()

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

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。openEuler 25.09版本因为从master拉取的分支，软件包版本变动比较大，所以对操作系统基线进行摸底，性能数据劣化不超过5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项**     | **指标小项**                                                 | **指标值**              | **说明** |
| ---------------- | ------------------------------------------------------------ | ----------------------- | -------- |
| OS基础性能       | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、文件子系统、网络子系统。 |参考版本相应指标基线 | 与基线数据劣化不超过5%以内可接受 |

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

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**                  | **覆盖策略**                                                 | **中英文测试策略** | Arm  | X86  | RISC-V | LoongArch |
| ----------------------------- | ------------------------------------------------------------ | ------------------ | ---- | ---- | ------ | --------- |
| DDE安装指南                   | 安装步骤的准确性及DDE桌面系统是否能成功安装启动              | 英文描述的准确性   | √    | √    | √      |           |
| UKUI安装指南                  | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动             | 英文描述的准确性   | √    | √    | √      |           |
| KIRAN安装指南                 | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动            | 英文描述的准确性   | √    | √    | √      |           |
| 树莓派安装指导                | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   | √    | √    | ×      |           |
| 安装指南                      | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |
| 管理员指南                    | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |
| 安全加固指南                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| 虚拟化用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| StratoVirt用户指南            | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| 容器用户指南                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |
| A-Tune用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |
| oeAware用户指南               | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| 应用开发指南                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |
| 工具集用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| HA的安装部署                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| HA的使用实例                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| OpenStack安装指导             | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| A-ops用户指南                 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| Gazelle用户指南               | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |
| openEuler Embedded用户指南    | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| UniProton用户指南             | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |
| GCC for openEuler用户指南     | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |
| NestOS用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |
| EulerCopilot 智能问答用户指南 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |


# 测试执行策略

openEuler 25.09版本按照社区release-manager团队既定的版本计划，共有7轮测试，alpha版本拉取的为master版本，且alpha本身为开发自验版本，测试不提前投入，只验证基础功能以及安装部署，RC1轮次开始测试。基本功能保障的beta版本设置在RC2 ，采用全量+增量结合的覆盖测试，保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归测试，视情况再预留1轮回归测试。

### 测试计划

openEuler 25.09版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stage Name                    | Deadline for PR | Begin Time | End Time   | Days | Note                                     |
| ----------------------------- | --------------- | ---------- | ---------  | ---- | ---------------------------------------- |
| Collect key features          |        -        | 2025/06/01 | 2025/07/30 | 60 | 版本需求收集                              |
| Change Review 1               |        -        | 2025/07/01 | 2025/08/13 | 44 | Review 软件包变更（升级/退役/淘汰）  |
| Herited features              |        -        | 2025/07/01 | 2025/08/13 | 44 | 继承特性合入（Beta前完成合入） |
| Develop                       |        -        | 2025/07/01 | 2025/09/03 | 65 | 新特性开发，Branch前合入Master，Branch后合入Master+25.09(round 6冻结前合入) |
| Kernel freezing               |        -        | 2025/07/01 | 2025/08/13 | 44 | 内核冻结（随Beta版本，内核冻结） |
| Branch 25.09                  |        -        | 2025/07/16 | 2025/07/22 | 07 | Master 拉取 25.09 分支|
| Build & Alpha                 |    2025/07/23   | 2025/07/25 | 2025/08/07 | 14 | 新开发特性合入，Alpha版本发布（重点关注软件选型&构建问题） |
| Test round 1                  |    2025/08/06   | 2025/08/08 | 2025/08/14 | 07 | 25.09 模块测试           |
| Test round 2 (Beta Version)   |    2025/08/13   | 2025/08/15 | 2025/08/21 | 07 | 25.09 Beta版本发布（KABI基线）    |
| Change Review 2               |        -        | 2025/08/15 | 2025/08/20 | 06 | 发起软件包淘汰评审 |
| Test round 3                  |    2025/08/20   | 2025/08/22 | 2025/08/28 | 07 | 25.09 模块测试       |
| Test round 4                  |    2025/08/27   | 2025/08/29 | 2025/09/04 | 07 | 全量验证(全量SIT)  |
| Change Review 3               |        -        | 2025/08/29 | 2020/09/03 | 06 | 发起软件包淘汰评审      |
| Test round 5                  |    2025/09/03   | 2025/09/05 | 2025/09/11 | 07 | 分支冻结，只允许bug fix          |
| Test round 6                  |    2025/09/10   | 2025/09/12 | 2025/09/18 | 07 | 回归测试                         |
| Test round 7 (预留)            |    2025/09/17   | 2025/09/19 | 2019/09/24 | 06 | 回归测试                         |
| Release Review                |        -        | 2025/09/22 | 2025/09/26 | 05 | 版本发布决策/ Go or No Go        |
| Release preparation           |        -        | 2025/09/24 | 2025/09/26 | 03 | 发布前准备阶段，发布件系统梳理    |
| Release                       |        -        | 2025/09/28 | 2025/09/30 | 03 | 社区Release评审通过正式发布       |



### 测试基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 25.09 Alpha         | 冒烟测试         |                                |
|                             | 包管理专项       | 软件包安装卸载                     |
|                             |                | 自编译                      |
|                             | 安装部署         | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             | 单包             | 单包命令            |
| openEuler 25.09 RC1         | 冒烟测试         |                                |
|                             | 包管理专项       | 软件包安装卸载                     |
|                             |                | 自编译                      |
|                             | 安全专项         |                     |
|                             | 安装部署         | 标准镜像x86物理机 |
|                             |                 | 标准镜像x86虚拟机 |
|                             |                 | 标准镜像PXE安装                |
|                             |                 | everything镜像PXE安装                |
|                             |                 | stratovirt镜像x86虚拟机                 |
|                             |                 | 边缘镜像     | 
|                             | 单包           | 单包命令             |
|                             |               | 单包服务             |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
| openEuler 25.09 RC2         | 冒烟测试         |                                |
|                             | 包管理专项       |                     |
|                             |                | 自编译                      |
|                             | 虚拟机兼容性         |                      |
|                             | 安装部署         |  |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像PXE安装                |
|                             | 单包           | 单包命令             |
|                             |               | 单包服务             |
|                             | 多动态库检查专项         |  |
| openEuler 25.09 RC3         | 冒烟测试         |                                |
|                             | 包管理专项       |  软件包安装卸载      |
|                             |                  | source包自编译 |
|                             | 重启专项专项     |  冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             |                  | 新增重启专项                       |
|                             | 文件系统     |                                |
|                             | 网络系统     |                                |
|                             | 性能专项         |                   |
|                             | 安装部署          | 标准镜像x86物理机                       |
|                             |                  | 标准镜像x86虚拟机                       |
|                             |                  | 标准镜像u盘安装                 |
|                             |                 | stratovirt镜像x86虚拟机                 |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             |                 | 边缘镜像     |
|                             | 单包            | 单包命令             |
|                             |                 | 单包服务             |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
| openEuler 25.09 RC4         | 冒烟测试         |                                |
|                             | 包管理专项       | 软件包安装卸载      |
|                             |                 | 软件包升降级      |
|                             |                 ｜ 自编译           |
|                             | 安全专项         |                |
|                             | 安装部署         |  |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像x86物理机 |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             |                  | 长稳测试                  |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 单包            | 单包命令             |
|                             |                 | 单包服务             |
| openEuler 25.09 RC5         | 冒烟测试         |                                |
|                             | 包管理专项       | 增量      |
|                             |                 | 软件包安装卸载      |
|                             |                 | 自编译     |
|                             | 安装部署         |  |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像x86物理机 |
|                             |                 | 标准镜像PXE安装                |
|                             |                 | everything镜像PXE安装                |
|                             | 单包            | 单包命令             |
|                             |                 | 单包服务             |
|                             | 内核专项         | 基本功能测试                   |
| openEuler 25.09 RC6         | 冒烟测试   |                    |
|                             | 回归测试       | 问题单回归                        |
| openEuler 25.09 RC7         | 冒烟测试   |                    |
|                             | 回归测试       | 问题单回归                        |
|                             | release发布件测试      | release发布件测试                        |
|                             | 发布件sha256值校验       | 发布件sha256值校验                        |


### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

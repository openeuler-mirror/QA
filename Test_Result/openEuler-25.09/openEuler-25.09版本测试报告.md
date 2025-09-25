![openEuler ico](../../images/openEuler.png)

版权所有 © 2025  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2025/9/22 | 1.0.0    | 初稿 | ga_beng_cui |
| 2025/9/23 | 1.0.1 | add RISC-V | jean9823 |
| 2025/9/24 | 1.0.2 | 修订版 | ga_beng_cui |




摘要：

文本主要描述openEuler 25.09版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 25.09版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 25.09版本是基于6.6内核的增强扩展版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler master分支拉出，发布范围相较25.03版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.09/release-change.yaml)
2.  修复bug和cve


## 2.1 版本测试计划
openEuler 25.09版本按照社区release-manager团队的计划，共规划7轮测试，详细的版本信息和测试时间如下表：

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
| Test round 7 (预留)           |    2025/09/17   | 2025/09/19 | 2019/09/24 | 06 | 回归测试                         |
| Release Review                |        -        | 2025/09/22 | 2025/09/26 | 05 | 版本发布决策/ Go or No Go        |
| Release preparation           |        -        | 2025/09/24 | 2025/09/26 | 03 | 发布前准备阶段，发布件系统梳理    |
| Release                       |        -        | 2025/09/28 | 2025/09/30 | 03 | 社区Release评审通过正式发布       |  



## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920(支持1.70以上的bios版本)        | OS集成测试     |
| RH2288H V3            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| 算能            | 算丰SG2042 | OS集成测试     |

## 2.3 需求清单

openEuler 25.09版本交付需求列表如下，详情见[openEuler-25.09 release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.09/release-plan.md#)：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|[ICKOE7](https://gitee.com/openeuler/release-management/issues/ICKOE7?from=project-issue)|  GTA远程证明支持VirtCCA | Developing | sig-security-facility | [ @yang8621 ](https://gitee.com/yang8621) |ISO| global-trust-authority、secGear|
|[ICM8OF](https://gitee.com/openeuler/release-management/issues/ICM8OF)|引入 valkey 作为首选的内存数据库|Developing|DB|[@fundawang](https://gitee.com/fundawang)|Everything|valkey|
| [ICMV3X](https://gitee.com/openeuler/release-management/issues/ICMV3X) | 支持树莓派 | Developing | sig-SBC | [@woqidaideshi](https://gitee.com/woqidaideshi/) | EPOL | raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom,raspberrypi-utils |
| [ICOAHM](https://gitee.com/openeuler/release-management/issues/ICOAHM) | kuasar机密容器低底噪，高性能 | Developing | sig-CloudNative | [@liuxu180400617](https://gitee.com/liuxu180400617/) | Everything | kuasar |
| [ICTQQK](https://gitee.com/openeuler/release-management/issues/ICTQQK) | llvm编译器提升数据中心应用性能 | Developing | Compiler SIG | [@longhui3333](https://gitee.com/longhui3333/) | Everything | llvm-project,llvm |
| [ICTQQQ](https://gitee.com/openeuler/release-management/issues/ICTQQQ) | 众核高密容器级资源隔离技术增强 | Developing | sig-kernel | [@frankneo](https://gitee.com/frankneo/) | baseOS | kernel |
| [ICTQQT](https://gitee.com/openeuler/release-management/issues/ICTQQT) | Go编译器优化提升通用场景性能 | Developing | Go SIG/Compiler SIG | [@wangding16](https://gitee.com/wangding16/) | Everything | golang |
| [ICTQQW](https://gitee.com/openeuler/release-management/issues/ICTQQW) | oeAware潮汐调度、numa亲和和嵌入式实时调优等功能增强 | Developing | A-Tune sig | [@ksana123](https://gitee.com/ksana123/) | Everything | oeAware-manager |
| [ICTQR1](https://gitee.com/openeuler/release-management/issues/ICTQR1) | .NET Framework应用原生开发能力 | Developing |  | [@randy1568](https://gitee.com/randy1568/) | Everything | oepkg |
| [ICTQR4](https://gitee.com/openeuler/release-management/issues/ICTQR4) | EulerMaker稳定性和易用性增强 | Developing | CICD sig | [@duan_pj](https://gitee.com/duan_pj/) | Everything | EulerMaker |
| [ICTQR5](https://gitee.com/openeuler/release-management/issues/ICTQR5) | DevStation支持软件商店和智能化增强 | Developing | sig-intelligence | [@duan_pj](https://gitee.com/duan_pj/) | Everything | mcp-servers |
| [ICTQRA](https://gitee.com/openeuler/release-management/issues/ICTQRA) | 远程证明统一框架(secgear)支持virtCCA Platform Token报告生成及验证 | Developing | sig-confidential-computing | [@houmingyong](https://gitee.com/houmingyong/) | Everything | secGear |
| [ICTQRD](https://gitee.com/openeuler/release-management/issues/ICTQRD) | oeAware支持嵌入式场景实时调优能力 | Developing | sig-embedded | [@yyyzmy](https://gitee.com/yyyzmy/) | Everything | oeAware-manager |
| [ICTQRH](https://gitee.com/openeuler/release-management/issues/ICTQRH) | openEuler intelligence 智能化诊断-支持慢卡检测，改进交互体验，赋能系统管理员 | Developing | sig-intelligence | [@zxstty](https://gitee.com/zxstty/) | Everything | euler-copilot-framework,euler-copilot-web |
| [ICTQRJ](https://gitee.com/openeuler/release-management/issues/ICTQRJ) | openEuler intelligence 智能化问答--支持原文追索，提升准确率 | Developing | sig-intelligence | [@zxstty](https://gitee.com/zxstty/) | Everything | euler-copilot-framework,euler-copilot-web |
| [ICTQRP](https://gitee.com/openeuler/release-management/issues/ICTQRP) | openEuler基于QEMU使能ARM CCA机密计算基础能力 | Developing | sig-confidential-computing | [@houmingyong](https://gitee.com/houmingyong/) | Everything | kernel,qemu,libvirt |


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
|11|发布eggo                                              | sig-CloudNative  | sig-QA  | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
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

   openEuler 25.09版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 3轮继承特性和新增特性合入测试 + 2轮全量测试 + 2轮回归测试（版本发布验收测试）；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项。测试也提前介入，覆盖冒烟测试、包管理、安装部署等基础测试项； 第2轮主要覆盖冒烟测试、安装部署、单包等OS测试项；第3、４轮重点聚焦在已合入的新需求测试和继承特性验证; 第5、6轮全量测试开展版本交付的所有特性和各类专项测试；第7、8轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试以及验证问题的修复；最后一轮还包括版本发布验收测试，是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。


   openEuler 25.09版本共发现问题 461 个，有效问题 443 个，无效问题 18 个，遗留问题 0 个，风险可控，版本整体质量良好。



# 4 版本详细测试结论

openEuler 25.09版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险

4、专项测试包括安全专项、性能测试、可靠性测试、资料测试

5、对版本新增特性进行测试，新增特性均满足发布要求，测试较充分，质量良好

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                     | **aarch64/x86_64质量评估**  |**risc-v质量评估**  |        备注                                                         |
| ---- | ----------------------- | :-------: | :--------: |  ------------------------------------------------------------ |
| 1 | 支持DDE桌面  | <font color=green>█</font> | <font color=green>█</font> |         DDE特性合计执行用例440条，主要覆盖了基础组件、预装应用核心功能、新增特性基础功能以及基本UI测试，整体核心功能基本可满足使用。    |
| 2 | 支持UKUI桌面  | <font color=green>█</font> | <font color=green>█</font> |           继承已有测试能力，关注UKUI桌面系统的安装和基本功能,共经过三轮测试，执行94个测试项，整体核心功能稳定正常。    |
| 3 | 支持Kiran桌面  | <font color=green>█</font> | NA |           继承已有测试能力，关注kiran桌面系统的安装和基本功能    |
| 4 | 安装部署  | <font color=green>█</font> | <font color=green>█</font> |           继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署；安装部署功能质量良好   |
| 5 | 内核  | <font color=green>█</font>  | <font color=green>█</font> |            继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内   |
| 6 | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | <font color=green>█</font> |           继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证   |
| 7 | 虚拟化 | <font color=green>█</font> | NA  |           继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能   |
| 8 | 支持A-Tune  | <font color=green>█</font> | NA  |          继承已有测试能力，本次无新增合入，重点关注继承功能验证，如服务/配置检查等   |
| 9 | 支持secPaver  | <font color=green>█</font> | NA     |       继承已有测试能力，关注secPave特性的基本功能和服务的稳定性   |
| 10 | 支持secGear  | <font color=green>█</font> | NA     |       继承已有测试能力，验证secGear特性的功能完整性，包括远程证明基线与策略导入，查询，创建、加解密、边界检查、生成随机数、打印、销毁等特性正常运行   |
| 11 | 支持eggo  | <font color=green>█</font> | NA |            继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性   |
| 12 | 支持kubeOS | <font color=green>█</font> | NA     |      继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力  |
| 13 | 支持etmem内存分级扩展  | <font color=green>█</font> | NA     |      继承已有测试能力，重点验证特性的基本功能和稳定性    |
| 14 | 支持用户态协议栈gazelle | <font color=green>█</font> | NA |            继承已有测试能力，验证gazelle高性能用户态协议栈功能，包括支持ceph,支持DWS，支持单网卡negligible，支持苏移krpc，一键脚本部署等继承功能 |
| 15 | 支持国密算法  | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，验证SSH协议栈、TLCP协议栈、内核模块签名、安全启动、文件完整性保护、用户身份鉴别、磁盘加密、算法库等模块支持国密算法。   |
| 16 | 支持pod带宽管理oncn-bwm  | <font color=green>█</font> | NA     |       继承已有测试能力，验证使能/网卡Qos功能，设置cgroup优先级、在线水线、离线带宽等功能，使能网卡QOS功能后，在线业务可实时抢占离线业务带宽，以及功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等。  |
| 17 | 支持isuald  | <font color=green>█</font> | <font color=green>█</font> |      继承已有测试能力，覆盖继承功能cgroup v2,热升级，健康检查，本地卷，容器生命周期管理，镜像管理，资源管理等，重点验证isulad长稳场景  |
| 18 | 支持系统运维套件x-diagnosis  | <font color=green>█</font> | NA     |        继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能   |
| 19 | 支持自动化热升级组件nvwa | <font color=green>█</font> | NA     |       继承已有测试能力，覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等   |
| 20 | 支持DPU直连聚合特性dpu-utilities  | <font color=green>█</font> | NA     |       继承已有测试能力，验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源   |
| 21 | 支持系统热修复组件syscare | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力   |
| 22 | iSula容器镜像构建工具isula-build  | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能   |
| 23 | 支持进程完整性防护特性DIM | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，验证dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等，用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量，以及度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量   |
| 24 | 支持入侵检测框架secDetector  | <font color=green>█</font> | NA     |       继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等   |
| 25 | isocut镜像裁剪易用性提升 | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包   |
| 26 | 支持devmaster组件 | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景   |
| 27 | 支持TPCM特性  | <font color=green>█</font> | NA     |       继承已有测试用例，验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等   |
| 28 | 支持sysMaster                          | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景   |
| 29 | 支持sysmonitor特性  | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景   |
| 30 | 混合部署rubik  | <font color=green>█</font> | NA     |       继承已有测试能力，覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化   |
| 31 | 支持IMA自定义证书 | <font color=green>█</font> | NA     |       继承已有测试能力，验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式  |
| 32 | 支持IMA virtCCA  | <font color=green>█</font> | NA     |       继承已有测试能力，验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等   |
| 33 | 安全启动  | <font color=green>█</font> | NA     |        继承已有测试能力，验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等  |
| 34 | Kmesh | <font color=green>█</font> | NA     |       继承已有测试能力，验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等   |
| 35 | openEuler安全配置规范框架设计及核心内容构建   | <font color=green>█</font> | NA     |      继承已有测试能力，验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性    |
| 36 | oemaker | <font color=green>█</font> | <font color=green>█ </font> |            继承已有测试能力，在构建工程中保证oemaker功能正常   |
| 37 | openssl | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上    |
| 38 | 编译器(gcc/jdk) | <font color=green>█</font> | <font color=green>█</font> |        继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证  |
| 39 | 支持HA软件 | <font color=green>█</font> | <font color=green>█</font> |       继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性    |
| 40 | 支持KubeSphere | <font color=green>█</font> | NA     |       继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力,共计执行 16 个用例，主要覆盖了KubeSphere 集群的功能测试，x86 架构和 ARM64 架构均测试通过。|
| 41 | 支持智能运维助手  | <font color=green>█</font> | NA     |      继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性     |
| 42 | 支持k3s| <font color=green>█</font> | NA     |       继承已有测试能力，验证k3s软件的部署功能正常     |
| 43 | migration-tools增加图形化迁移openeuler功能 | <font color=green>█</font> | NA     |       继承已有测试能力，验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统   |
| 44 | 发布Nestos-kubernetes-deployer | <font color=green>█</font> | NA     |       继承已有测试能力，覆盖在NestOS上部署，升级和维护kubernetes集群功能正常   |
| 45 | 支持NestOS                                            |  <font color=green>█</font> | NA     |      继承已有测试能力，验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 46 | 发布PilotGo及其插件特性新版本 | <font color=green>█</font> | NA     |       继承已有测试能力，验证PilotGo支持 topo 图的展示和智能调优能力   |
| 47 | 社区签名体系建立                                      |  <font color=green>█</font> | NA     |       继承已有测试能力，验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
| 48 | 智能问答在线服务 | <font color=green>█</font> | NA     |       继承已有测试能力，验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力   |
| 49 | 支持GreatSQL                               |  <font color=green>█</font> | <font color=green>█</font> |           共执行 140 个测试项，主要涵盖了 GreatSQL 源码编译、RPM安装、二进制包安装、MGR增强、Binlog读取限速、Clone复制数据时自动最新节点、并行LOAD DATA、异步删除大表、非阻塞式DDL、NUMA亲和性优化、Oracle兼容、Clone备份加密、Clone增量备份、Clone压缩备份、审计、数据脱敏、最后登录信息等主要功能特性等方面，主要功能均通过测试，无风险，整体核心功能稳定正常。 |
| 50 | ZGCLab发布内核安全增强补丁| <font color=green>█</font> | NA     |       继承已有测试能力，针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试   |
| 51 | 支持RISC-V | NA | <font color=green>█ </font> |           验证openEuler版本在RISV-V处理器上的可安装和可使用性     |
| 52 | 为RISC-V架构引入Penglai TEE 支持  | NA | <font color=green>█ </font> |             继承已有测试能力，验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等,集成蓬莱特性的 opensbi 可以按预期方式进行启动，内核驱动模块通过 dkms 加载，可以成功加载在内核中，SDK 运行时套件可以正常安装使用。|
| 53 | Add compatibility patches for Zhaoxin processors  | <font color=green> █ </font> | NA     |        继承已有测试能力，主要覆盖功能测试，针对Zhaoxin处理器进行Zhaoxin OLK-6.6补丁测试 |
| 54 | virtCCA机密虚机特性合入 | <font color=green> █ </font> | NA     |        继承已有测试能力，机密虚机场景主要覆盖了功能、性能、可靠性、兼容性、资料和长稳测试  |
| 55 | 增加 utsudo 支持 | <font color=green> █ </font> | <font color=green>█</font> |             继承已有测试能力，主要覆盖utsudo功能测试，包括软件包安装、卸载和utsudo基础命令验证 |
| 56 | 增加 utshell支持 | <font color=green> █ </font> | <font color=green>█</font> |             继承已有测试能力，主要覆盖utsudo功能测试，包括软件包安装、卸载和utshell基础命令验证  |
| 57 | LLVM多版本实现 | <font color=green> █ </font> | <font color=green>█</font> |             继承已有测试能力，主要验证LLVM多版本包引入对于全量版本构建没有影响、LLVM多版本包能够正常工作和使用，覆盖功能测试和可靠性测试 |
| 58 | 新增密码套件openHiTLS               | <font color=green> █ </font> | NA  |            继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试    |
| 59 | AI流水线oeDeloy       | <font color=green> █ </font> |  NA |            继承已有测试能力，重点验证通过oeDeploy进行kubeflow部署及k8s基础功能测试   |
| 60 | 支持oeaware                | <font color=green> █ </font> | NA  |           继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容  |
| 61 | DevStation 开发者工作站支持                      |<font color=green> █ </font> |  NA |              继承已有测试能力，重点验证安装部署启动、支持图形化编程环境，以及融合的epkg、Eulercopilot、x2openEuler的基本功能 |
| 62 | AI集群慢节点快速发现 Add Fail-slow Detection      | <font color=green> █ </font> |  NA |            继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度   |
| 63 | RPM国密签名支持                             | <font color=green> █ </font> | <font color=green>█</font> |             重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容   |
| 65 | 鲲鹏KAE加速器驱动安装包合入  | <font color=green> █ </font> | NA     | 继承已有测试能力， 验证KAE特性的加解密和压缩解压缩，主要覆盖功能测试和性能测试 |
| 65 | Add Intel QAT packages support    | <font color=green> █ </font> | NA |           继承已有测试能力，重点验证intel qat相关软件包的功能和性能，共计执行84个用例，主要覆盖了加解密AES测试64个用例，RSA测试2用例，ECDSA测试1用例，压缩解压测试17用例，通过QAT cpa_sample_code工具测试，未发现问题，整体质量良好；    |
| 66 | 版本引入ACPO包  | <font color=green> █ </font> | NA     |        继承已有测试能力，主要验证使能ACPO并构建编译器、使用提供的ACPO源代码进行模型训练以及使用训练好的模型进行推理并使用perf统计执行时间，覆盖功能测试、性能测试和可靠性测试  |
| 67 | 内核TCP/IP协议栈支持CAQM拥塞  | <font color=green> █ </font> | NA     |        继承已有测试能力，主要验证CAQM自身功能用例、标准性能测试和Postgres SQL场景下带流性能提升，覆盖功能测试、性能测试、可靠性测试 |
| 68 | 为AArch64编译默认开启PAC/BTI |  <font color=green> █ </font> | NA     |      主要覆盖了功能测试和兼容性测试，重点关注通过读取软件包中的二进制ELF文件检查PAC/BTI的支持情况，未发现问题，整体质量良好 |
| 69 | 基于sysboost实现启动时优化，通用兼容性增强  |<font color=green> █ </font> | NA     |        继承已有测试能力， 共执行了11个用例，主要覆盖了Host和容器场景下的功能、可靠性、性能测试，重点关注可靠性与性能，整体质量良好。 |
| 70 | GCC for openEuler编译链接加速，缩减编译时间  | <font color=green> █ </font> | NA     |        继承已有测试能力，共执行3个用例，主要覆盖MOLD链接器功能测试和性能测试，功能测试2个用例通过，性能测试编译总时间减少9.55%，目标5~10%|
| 71 | 机密容器Kuasar适配virtCCA | <font color=green> █ </font> | NA     |        继承已有测试能力，共执行7个用例，继承用例执行188个，主要覆盖了机密容器的生命周期命令，服务稳定性，并发测试，文件残留，日志打印等,整体质量良好。 |
| 72 | secGear支持机密容器镜像密钥托管  | <font color=green> █ </font> | NA     |        继承已有测试能力，共执行16个用例，主要覆盖了远程证明代理、服务端、客户端秘钥托管功能测试，可靠性测试，整体质量良好。 |
| 73 | 构建基于远程证明的TLS协议（RA-TLS） |<font color=green> █ </font> | NA     |        继承已有测试能力， 共执行10个用例，主要覆盖单向、双向认证、单agent、多agent场景TLS建链、远程证明功能测试和可靠性测试，整理质量良好 |
| 74 | Trace IO加速容器快速启动  |<font color=green> █ </font> | NA     |        继承已有测试能力， Trace IO加速容器快速启动特性，共计执行18个用例，主要覆盖了功能测试用例、兼容性测试和性能测试用例，未发现问题，无遗留风险，整体质量良好 |
| 75 | 引入vkernel概念增强容器隔离能力 | <font color=green> █ </font> | NA     |        继承已有测试能力，基于openEuler-25.03版本的 Vkernel 特性操作系统内核，针对其功能、性能和兼容性进行LTP、UnixBench、容器运行时对比、容器生态兼容、相关应用性能共计5项测试，未发现问题，整体质量良好。 |
| 76 | openAMDC合入  |<font color=green> █ </font> | NA     |        继承已有测试能力， 主要覆盖了功能测试、性能测试、可靠性测试、安全测试，重点验验证了软件的核心功能模块，共执行86个用例，发现4个问题，已解决并验收通过，无遗留风险，整体质量良好 |
| 77 | oeAware支持瓶颈评估一键推荐调优等特性增强 |<font color=green> █ </font> | NA     |        继承已有测试能力， 共执行了13个用例，主要覆盖了透明大页场景识别、透明大页使能禁用、查询模块显示以及虚拟网卡亲和配置场景功能测试、异常测试,无遗留问题 |
| 78 | oeDeploy 部署能力增强 | <font color=green> █ </font> | NA     |        继承已有测试能力，共执行了9个用例，主要覆盖了功能测试、兼容性和性能指标达成，经测试未发现问题，整体质量良好 |
| 79 | DevStation社区原生/图形化/南向兼容性等新增特性 | <font color=green> █ </font> | NA     |        继承已有测试能力， 共执行27个用例，主要覆盖25.09关于DevStation的集成特性，主要覆盖稳定性提升等功能测试、兼容性测试、资料测试。共发现问题5个，其中闭环4个，已闭环的回归通过，整体质量良好。 |
| 80 | 云原生基础设施部署升级工具k8s-isntall 加入版本 | <font color=green> █ </font> | NA     |        继承已有测试能力，主要覆盖了功能测试、性能测试和异常处理测试，重点验证k8s-install工具支持在线/离线模式下一键式安装部署云原生基础设施的能力，未发现问题整体质量良好 |



<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价


对新需求进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **aarch64/x86_64质量评估**    |  **risc-v质量评估**    |       **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | ---------------- | ---------------- | ---------------- | -------------- | 
| 1 | [GTA远程证明支持VirtCCA](https://gitee.com/openeuler/QA/pulls/1122/files)| 测试活动主要覆盖了功能、性能、资料、可靠性以及安全专项测试，所有测试活动均完成且充分开展。共涉及用例41个，用例执行率100%，用例通过率100%，测试执行充分，版本交付范围无遗留问题单,版本内共发现问题单2个，2个问题均已闭环 | |  | <font color=green>█</font> | NA | | |
| 2 | [引入 valkey 作为首选的内存数据库](https://gitee.com/openeuler/QA/pulls/1107/files)| valkey 是 Linux 基金会管理的高性能开源键值型数据库，兼容 redis 协议和架构。经过对指定软件版本软件的形式测试，软件服务启动和关闭正常，软件活动状态正常。符合软件上游设计初衷。 |  || <font color=green>█</font> | <font color=green>█</font> | | |
| 3 | [支持树莓派](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler-25.09%E7%89%88%E6%9C%AC%E6%A0%91%E8%8E%93%E6%B4%BE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 测试范围包括镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成了硬件兼容性测试，包括树莓派 4B/5 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的兼容性验证。以上测试内容均未发现问题。 |  || <font color=green>█</font> | NA | | |
| 4 | [kuasar机密容器低底噪，高性能](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler-25.09%E7%89%88%E6%9C%ACkuasar%E6%9C%BA%E5%AF%86%E5%AE%B9%E5%99%A8%E4%BD%8E%E5%BA%95%E5%99%AA%E9%AB%98%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| kuasar机密容器低底噪，高性能特性，共计执行两项测试，主要覆盖了管里面内存底噪测试和启动时间测试。kuasar机密容器相比kata机密容器，降低容器管理面底噪50%；kuasar机密容器相比kata机密容器，提升启动性能21.43%。 |  ||  <font color=green>█</font> | NA | | |
| 5 | [llvm编译器提升数据中心应用性能](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler-25.09%E7%89%88%E6%9C%AC%20LLVM_aggressive%20inline%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)|共进行三轮测试，前两轮测试执行包括: 特性包构建，全量版本验证，主要测试内容包括特性引入后对全量版本构建没有影响、该特性使能正常, 第三轮测试包含以下内容, 使能特性后, 功能正常，未发现问题,整体质量良好  |  || <font color=green>█</font>  | NA |  |  |
| 6 | [众核高密容器级资源隔离技术增强](https://gitee.com/openeuler/QA/pulls/1147)| 共执行6个用例，主要覆盖功能测试和性能测试，包括虚机内存QoS控制、Numa设备亲和，验证无问题；redis场景，双虚机部署2U8G容器，在QoS干扰小于10的条件下，众核高密部署密度提升114% |  |  | <font color=green>█</font>  | NA |  |  |
| 7 | [Go编译器优化提升通用场景性能](待提交)|共执行测试用例1个，对kpatomic以及prefetch的功能和性能进行测试，未发现问题，整体质量良好；go编译器优化tcnn-test 性能提升24.95%|  |  | <font color=green>█</font> | NA |  |  |
| 8 | [oeAware潮汐调度、numa亲和和嵌入式实时调优等功能增强](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler%2025.09%E7%89%88%E6%9C%ACoeAware%E6%BD%AE%E6%B1%90%E8%B0%83%E5%BA%A6%E5%92%8Cnuma%E4%BA%B2%E5%92%8C%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 共计执行85个用例，其中继承用例75个，新特性用例10个，主要覆盖了功能测试，发现问题4个，均已解决，回归通过，无遗留风险，整体质量良好 |  | |  <font color=green>█</font> | NA |  |  |
| 9 | [.NET Framework应用原生开发能力](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler%2025.09%E7%89%88%E6%9C%AC.NET%E5%8E%9F%E7%94%9F%E5%BC%80%E5%8F%91%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 共计执行23个用例，主要覆盖了功能测试和兼容性测试，整体开发代码量2.8k，发现问题6个，发现问题已解决，回归通过，无遗留风险，整体质量良好 | | | <font color=green>█</font>  |NA  |  |  |
| 10 | [EulerMaker稳定性和易用性增强](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/EulerMaker930%E7%89%88%E6%9C%AC%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 所有修改升级至测试环境，执行使用openEuler22.04-LTS-SP4 everything工程作为测试工程，执行全量构建，增量构建以及镜像制作能力的功能验证，功能均正常；执行repo发布及签名能力功能均正常；检查etcd残留数据情况，无残留数据。 |  |  | <font color=green>█</font> | NA |  |  |
| 11 | [DevStation支持软件商店和智能化增强](https://gitee.com/openeuler/QA/pulls/1113)| 共执行27个用例，主要覆盖25.09关于DevStation的集成特性，主要覆盖稳定性提升等功能测试、兼容性测试、资料测试。共发现问题5个，其中闭环4个，已闭环的回归通过，整体质量良好。 |  |  | <font color=green>█</font> |NA  |  |  |
| 12 | [远程证明统一框架(secgear)支持virtCCA Platform Token报告生成及验证](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler%2025.09%E7%89%88%E6%9C%AC%E8%BF%9C%E7%A8%8B%E8%AF%81%E6%98%8E%E7%BB%9F%E4%B8%80%E6%A1%86%E6%9E%B6(secGear)%E6%94%AF%E6%8C%81virtCCA%20Platform%20Token%E6%8A%A5%E5%91%8A%E7%94%9F%E6%88%90%E5%8F%8A%E9%AA%8C%E8%AF%81%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 远程证明统一框架(secGear)支持virtCCA新版本的Platform Token报告生成及验证特性，共计执行需求相关用例11个，其中新增用例6个，继承用例5个。主要覆盖功能测试、可靠性测试。无测试问题，无遗留风险，整体质量良好。 |  |  |  <font color=green>█</font>| NA |  |  |
| 13 | [oeAware支持嵌入式场景实时调优能力](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler%2025.09%E7%89%88%E6%9C%ACoeAware%E6%94%AF%E6%8C%81%E5%B5%8C%E5%85%A5%E5%BC%8F%E5%9C%BA%E6%99%AF%E5%AE%9E%E6%97%B6%E8%B0%83%E4%BC%98%E8%83%BD%E5%8A%9B%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 嵌入式实时调优特性共计执行12个用例，主要覆盖了功能测试、性能测试，主要通过修改配置文件使能相关实例对参数进行生效验证，发现问题已解决，回归通过，无遗留风险，整体质量良好。 |  |  | <font color=green>█</font> |NA  |  |  |
| 14 | [openEuler intelligence 智能化诊断-支持慢卡检测，改进交互体验，赋能系统管理员](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler%20intelligence%20%E6%99%BA%E8%83%BD%E5%8C%96%E8%AF%8A%E6%96%AD-%E6%94%AF%E6%8C%81%E6%85%A2%E5%8D%A1%E6%A3%80%E6%B5%8B.md)| 共计执行169个用例，主要覆盖openEuler intelligence工作台的新旧功能点，对于老功能点使用125个样例进行测试，对于新功能点新增了44个样例进行测试，发现6个功能问题，发现问题已解决，回归通过，无遗留风险，整体质量良好 |  |  |<font color=green>█</font>  | NA |  |  |
| 15 | [openEuler intelligence 智能化问答--支持原文追索，提升准确率](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler%20intelligence%20%E6%99%BA%E8%83%BD%E5%8C%96%E9%97%AE%E7%AD%94-%E6%94%AF%E6%8C%81%E5%8E%9F%E6%96%87%E5%9B%9E%E6%BA%AF.md)| openEuler intelligence智能化问答支持原文回溯，共计执行101个用例，主要覆盖openEuler intelligence知识库的新旧功能点，对于老功能点使用81个样例进行测试，对于新功能点新增了20个样例进行测试，暂未发现明显问题。 |  |  |  <font color=green>█</font>| NA |  |  |
| 16 | [openEuler基于QEMU使能ARM CCA机密计算基础能力](https://gitee.com/openeuler/QA/pulls/1138/files)| openEuler支持CCA机密虚机特性，共计执行4个用例，主要覆盖了基于CCA架构的机密虚机生命周期管理-定义、销毁虚拟机域，创建、启动、销毁虚拟机功能以及获取证明报告的功能测试。经测试未发现问题，无遗留风险，整体质量良好。 |  |  |<font color=green>█</font>  | NA |  |  |


<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1 虚机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 |
| ---------- | ----------------------- | ------- | -------- |
| openEuler 25.09 | Centos 6 | x86_64 | PASS |
| openEuler 25.09 | Centos 7 | aarch64 | PASS |
| openEuler 25.09 | Centos 7 | x86_64  | PASS |
| openEuler 25.09 | Centos 8 | aarch64 | PASS |
| openEuler 25.09 | Centos 8 | x86_64  | PASS |
| openEuler 25.09  | Windows Server 2016 | x86_64  | PASS |
| openEuler 25.09  | Windows Server 2019 | x86_64  | PASS |
| openEuler RISC-V 25.09 | Ubuntu 24.04 | riscv64 | PASS |
| openEuler RISC-V 25.09 | openEuler RISC-V 24.03 LTS SP2 | riscv64 | PASS |

## 4.3   专项测试结论

### 4.3.1 安全测试

整体安全测试覆盖：

1、病毒扫描：使用majun平台病毒扫描工具，对aarch64、x86_64架构的Everything(包含BaseOS)、EPOL所提供软件包进行病毒扫描，共计扫描50446个rpm包，未有病毒告警，无风险。

2、安全编译选项扫描：使用majun平台二进制扫描工具，对aarch64、x86_64架构的BaseOS所提供软件包进行安全编译选项（包括BIND_NOW、 NX、PIE、RELRO、SP、NO Rpath/Runpath、Strip）扫描，共计扫描5,065个rpm包，总计问题数问题数42个（排除SP误报），所有问题均已评估或修复，无风险。

3、开源片段引用扫描：目前对于openeler社区孵化的baseos范围内的69个软件包仓库，使用majun平台的开源片段扫描工具扫描，对于扫描结果中累计识别出的片段引用进行分析，共计扫描仓库97个，新增问题758个，所有问题均评估或修复，无风险。

4、开源合规license检查：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，共计扫描软件包50, 446个，发现问题38个，已完成38个。所有问题均已完成修复或评估，无风险。

5、签名和完整性校验：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，共计验证56, 903个rpm包，均通过签名检查，所有rpm包均有签名且具有一致性。对于产品提供的镜像中的riscv64架构中的所有rpm软件包，共计验证22058个rpm包，均通过签名检查，所有rpm包均有签名且具有一致性。

6、SBOM校验：版本发布后对应的ISO镜像存在sha256sum签名文件、SBOM文件、SBOM文件签名，待版本发布后更新。

整体OS安全测试较充分，测试发现问题全部已完成修复及评估，无遗留问题无风险。详细测试内容见安全专项测试报告：
https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler-25.09/openEuler%2025.09%E7%89%88%E6%9C%AC%E5%AE%89%E5%85%A8%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md

### 4.3.2 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                                                    |
| ------------ | ------------------------------------------------------------ | ----------------------------------------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况；稳定性测试时长7\*24 |通过 |

### 4.3.3 性能测试


| **指标大项** | **指标小项**                                                                               | **指标值**              | **测试结论**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 基础性能与基线版本（24.03-LTS-SP2）相比平均性能提升0.7%，基本持平 |

### 4.3.4 资料测试

| **手册名称** | **覆盖策略** | **中英文测试策略** | **Arm/X86测试结果**  | **RISC-V测试结果** | 
| ------ | ------------------ | ---- | ---- | ------ | 
| DDE安装指南 | 安装步骤的准确性及DDE桌面系统是否能成功安装启动  | 英文描述的准确性   | pass   | pass |       |
| UKUI安装指南 | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动| 英文描述的准确性   | pass   | pass |       |
| KIRAN安装指南 | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动 | 英文描述的准确性   | pass   | NA |       |
| 树莓派安装指导 | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   | pass    | NA  |      |
| 安装指南  | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    | pass |    |
| 管理员指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass    | pass |  |
| 安全加固指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    |  NA  |      |
| 虚拟化用户指南   | 文档描述与版本的行为是否一致  | 英文描述的准确性   | pass    |  NA  |      |
| StratoVirt用户指南  | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass  | NA  |     |
| 容器用户指南   | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   | pass |      |
| A-Tune用户指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   |  NA  |     |
| 应用开发指南  | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   | pass |     |
| 工具集用户指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   | NA   |      |
| HA的安装部署 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | pass    | pass |  NA  |
| HA的使用实例  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | pass    | pass |       |
| K8S安装指导| 文档描述与版本的行为是否一致| 英文描述的准确性   | pass    | NA    |       |
| Gazelle用户指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   | pass |      |
| oeAware用户指南   | 文档描述与版本的行为是否一致  | 英文描述的准确性   | pass   |  NA   |      |
| DevStore Quick Start | 文档描述与版本的行为是否一致  | 英文描述的准确性   | pass   |   NA  |      |
| DevStation的安装指导  | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass  | NA  |     |
| EulerCopilot 智能问答用户指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   |  NA  |    |
| QEMU CCA仿真使用指南|文档描述与版本的行为是否一致| 英文描述的准确性   | pass   |  NA  |    |
# 5   问题单统计

openEuler 25.09版本共发现问题461个，有效问题443个，其中遗留问题0个，详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 
| --------------------------- | -------- | ------------ | ------------ | ------------ | 
| openEuler 25.09  alpha      | 69  |  69 |  0  |   0   |
| openEuler 25.09  RC1        | 305 |  292|  13 |   0   | 
| openEuler 25.09  RC2        | 13  |  11 |  2  |   0   | 
| openEuler 25.09  RC3        | 40  |  39 |  1  |   0   |
| openEuler 25.09  RC4        | 10  |  10 |  0  |   0   | 
| openEuler 25.09  RC5        | 17  |  16 |  1  |   0   |
| openEuler 25.09 RC6         |  2  |  2  |  0  |   0   | 
| openEuler 25.09 RC7         |  0  |  0  |  0  |   0   | 


# 6 版本测试过程评估

#### 6.1 问题单分析


本次版本测试各迭代从RC1到RC7，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求。社区有效issue共计461个，新增issue总体趋势下降, 符合质量预期，风险可控

各阶段问题分析：
1.	Alpha属于开发自验证轮次，25.09从master分支拉取，涉及大量软件包升级，主要为构建阶段发现问题，共69个有效issue，其中构建问题61，符合预期
2. RC1 25.09版本上新需求未转测，本轮启动安全测试和通用测试项，发现安全问题132个，软件包降级55个，其他通用OS功能问题15个，此轮要求EPOL软件包正常发布，构建问题102个
2.	RC2-RC3需求开始转测，oeAware、云原生、devstation等，发现问题15个; RC3阶段EPOL构建失败问题解决后，发现大量软件包安装失败问题23个
4.	RC4仍有部分需求转测，主要涉及编译器、安全等，RC4-RC5持续全量测试，发现问题24个
5.	综上所述，问题主要集中在软件包构建、降级和安全，分别占版本问题39.32％，11.63％，27.90％



#### 6.2 OS集成测试迭代版本基线

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



# 7   附件

## 遗留问题列表

|序号|问题单号|问题简述|问题级别|影响分析|规避措施|
| ---- | ---- | ------------- | ----| ------ | ----| 


![openEuler ico](../../images/openEuler.png)

版权所有 © 2025  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2025/3/24 | 1.0.0    | 初稿 | linqian0322 |
| 2025/3/25 | 1.0.1 | add RISC-V | jean9823 |



关键词：


摘要：

文本主要描述openEuler 25.03创新版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 25.03创新版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 25.03版本是基于6.6内核的创新版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于master分支拉出，发布范围：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-change.yaml)
2.  修复bug和cve


## 2.1 版本测试计划
openEuler 25.03版本按照社区release-manager团队的计划，共规划6轮测试，详细的版本信息和测试时间如下表：

| Stage Name                    | Deadline for PR | Begin Time | End Time   | Days | Note                                     |
| ----------------------------- | --------------- | ---------- | ---------  | ---- | ---------------------------------------- |
| Collect key features          |        -        | 2024/12/1  | 2025/1/31  | 61 | 版本需求收集                              |
| Change Review 1               |        -        | 2025/1/2   | 2025/1/16  | 15 | Review 软件包变更（升级/退役/淘汰）  |
| Herited features              |        -        | 2025/1/2   | 2025/2/18  | 25 | 继承特性合入（Branch前完成合入） |
| Develop                       |        -        | 2025/1/2   | 2025/2/25  | 55 | 新特性开发，合入Master |
| Kernel freezing               |        -        | 2025/1/23  | 2024/2/27  | 8  | 内核冻结（随Beta版本，内核冻结） |
| Branch 25.03                  |        -        | 2025/1/23  | 2025/2/6   | 7  | Master 拉取 25.03 分支 (跨春节，预祝开发者春节快乐) |
| Build & Alpha                 |        -        | 2025/2/7   | 2025/2/13  | 7  | 新开发特性合入，Alpha版本发布    |
| Test round 1                  |    2025/2/11    | 2025/2/14  | 2025/2/20  | 7  | 25.03 模块测试           |
| Change Review 2               |        -        | 2025/x/xx  | 2025/x/xx  | 3  | 发起软件包淘汰评审               |
| Test round 2 (Beta Version)   |    2025/2/18    | 2025/2/21  | 2025/2/27  | 7  | 25.03 Beta版本发布       |
| Test round 3                  |    2025/2/25    | 2025/2/28  | 2025/3/6   | 7  | 全量验证(全量SIT)                |
| Change Review 3               |        -        | 2025/x/x   | 2025/x/x   | 3  | 只允许bug fix      |
| Test round 4                  |    2025/3/4     | 2025/3/7   | 2025/3/13  | 7  | 分支冻结，只允许bug fix          |
| Test round 5                  |    2025/3/11    | 2025/3/14  | 2025/3/20  | 7  | 回归测试                         |
| Test round 6 (预留)           |    2025/3/18    | 2025/3/21  | 2025/3/25  | 7  | 回归测试                         |
| Release Review                |        -        | 2025/3/25  | 2025/3/26  | 2  | 版本发布决策/ Go or No Go        |
| Release preparation           |        -        | 2025/3/27  | 2025/3/28  | 2  | 发布前准备阶段，发布件系统梳理    |
| Release                       |        -        | 2025/3/28  | 2025/3/31  | 2  | 社区Release评审通过正式发布       |


## 2.2 测试硬件信息

测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920(支持1.70以上的bios版本)        | OS集成测试     |
| RH2288H V3            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| 算能            | 算丰SG2042 | OS集成测试     |

## 2.3 需求清单

openEuler 25.03版本交付需求列表如下，详情见[openEuler-25.03 release plan](https://gitee.com/openeuler/release-management/edit/master/openEuler-25.03/release-plan.md)：


|no|feature|status|sig|owner|
| :--- | :------ | :----- | :--- | :---- | 
|[IBGAHV](https://gitee.com/openeuler/release-management/issues/IBGAHV?from=project-issue)| 为AArch64编译默认开启PAC/BTI | Discussion | sig-Arm | [@junhe_arm](https://gitee.com/junhe_arm) |
|[IBJFPX](https://gitee.com/openeuler/release-management/issues/IBJFPX)| 支持树莓派 | Discussion | sig-SBC | [@woqidaideshi](https://gitee.com/woqidaideshi/) |
|[IBLBJ2](https://gitee.com/openeuler/release-management/issues/IBLBJ2?from=project-issue)| Aops: cve修复/配置溯源实现运维智能化，支持主动通知和图文混合交互 | Developing|sig-ops | [@Lostwayzxc](https://gitee.com/Lostwayzxc/) |
|[IBLB8F](https://gitee.com/openeuler/release-management/issues/IBLB8F?from=project-issue)| 基于sysboost实现启动时优化，通用兼容性增强 | Developing| sig-Compiler | [@wangding16](https://gitee.com/wangding16/) |
|[IBLB3B](https://gitee.com/openeuler/release-management/issues/IBLB3B?from=project-issue)| GCC for openEuler编译链接加速，缩减编译时间 | Developing| sig-Compiler | [@wangding16](https://gitee.com/wangding16/) |
|[IBLA9W](https://gitee.com/openeuler/release-management/issues/IBLA9W?from=project-issue)| 机密容器Kuasar适配virtCCA | Developing| sig-CloudNative | [@xuxuepeng](https://gitee.com/xuxuepeng/) |
|[IBLA6Q](https://gitee.com/openeuler/release-management/issues/IBLA6Q?from=project-issue)| secGear支持机密容器镜像密钥托管 | Developing|sig-security-facility | [@houmingyong](https://gitee.com/houmingyong/) |
|[IBLA66](https://gitee.com/openeuler/release-management/issues/IBLA66?from=project-issue)| 构建基于远程证明的TLS协议（RA-TLS） | Developing|sig-security-facility | [@houmingyong](https://gitee.com/houmingyong/) |
|[IBK2MJ](https://gitee.com/openeuler/release-management/issues/IBK2MJ?from=project-issue)| Trace IO加速容器快速启动 | Developing| sig-Kernel| [@hongbo-lee](https://gitee.com/hongbo-lee/) |
|[IBJ7WU](https://gitee.com/openeuler/release-management/issues/IBJ7WU?from=project-issue)| 默认系统集成 liteview，代替 firefox | Discussion | sig-Desktop | [@shinwell_hu](https://gitee.com/shinwell_hu/) |
|[IBD46F](https://gitee.com/openeuler/kernel/issues/IBD46F)| 引入vkernel概念增强容器隔离能力 | Developing| sig-Kernel | [@joyallen](https://gitee.com/joyallen/) |
|[IBC4SJ](https://gitee.com/openeuler/kernel/issues/IBC4SJ)| uncore动态调频 | Developing| sig-Kernel | [@li-wei2110](https://gitee.com/li-wei2110/) |
|[IBI0TX](https://gitee.com/openeuler/release-management/issues/IBI0TX?from=project-issue)| openAMDC合入 | Developing| sig-BigData | [@changzhi1123](https://gitee.com/changzhi1123/) |
|[IBFDJ9](https://gitee.com/openeuler/release-management/issues/IBFDJ9?from=project-issue)| oncn-bwm支持host network 类型pod的带宽管理 | Developing | sig-high-performance-network | [@supercharge](https://gitee.com/supercharge/) |
|[IBLJRD](https://gitee.com/openeuler/release-management/issues/IBLJRD?from=project-issue)| oeAware支持瓶颈评估一键推荐调优等特性增强 | Developing | sig-A-Tune | [@Lostwayzxc](https://gitee.com/Lostwayzxc/) |
|[IBLJWU](https://gitee.com/openeuler/release-management/issues/IBLJWU?from=project-issue)| oeDeploy 部署能力增强 | Developing | sig-ops | [@dingjiahuichina](https://gitee.com/dingjiahuichina/) |
|[IBLKJY](https://gitee.com/openeuler/release-management/issues/IBLKJY?from=project-issue)| 主流工业中间件支持 | Developing | sig-embedded| [@Lostwayzxc](https://gitee.com/Lostwayzxc/) |
|[IBLKHB](https://gitee.com/openeuler/release-management/issues/IBLKHB?from=project-issue)| 跨域通信框架，支持接口调用跨域通信 | Developing | sig-embedded| [@Lostwayzxc](https://gitee.com/Lostwayzxc/) |
|[IBLKF9](https://gitee.com/openeuler/release-management/issues/IBLKF9?from=project-issue)| 虚拟化底座，使能XEN虚拟化框架 | Developing | sig-embedded| [@Lostwayzxc](https://gitee.com/Lostwayzxc/) |
|[IBLJWU](https://gitee.com/openeuler/release-management/issues/IBLJWU?from=project-issue)| 硬实时南向生态：EtherCAT支持 | Developing | sig-embedded| [@hzc04](https://gitee.com/hzc04/) |
|[IBLKCQ](https://gitee.com/openeuler/release-management/issues/IBLKCQ?from=project-issue)| 嵌入式：硬实时POSIX接口补齐 | Developing | sig-embedded | [@hzc04](https://gitee.com/hzc04/) |
|[IBLK62](https://gitee.com/openeuler/release-management/issues/IBLK62?from=project-issue)| DevStation社区原生/图形化/南向兼容性等新增特性 | Developing |sig-ops/IDE | [@duan_pj](https://gitee.com/duan_pj/) |
|[IBLK0E](https://gitee.com/openeuler/release-management/issues/IBLK0E?from=project-issue)|  EPKG包管理器优化，提升epkg易用性 | Developing |sig-CICD | [@duan_pj](https://gitee.com/duan_pj/) |
|[IBMCNA](https://gitee.com/openeuler/release-management/issues/IBMCNA) | 支持 OpenStack Antelope 版本 | Accepted | sig-openstack | [@tzing_t](https://gitee.com/tzing_t) |
|[IBOO9X](https://gitee.com/openeuler/release-management/issues/IBOO9X) | 云原生基础设施部署升级工具k8s-isntall 加入版本 | Developing | sig-cloudnative | [@wonleing](https://gitee.com/wonleing) |

## 2.4 测试活动分工
 本次版本继承测试活动分工如下：

| **序号**| **需求**                                              | **开发主体**            | **测试主体**           | **测试分层策略**                                             |
| 序号   | 需求 | 开发主体 | 测试主体  | 测试分层策略 |
| :--- | :--- | :--- | :--- | :--- |
|1| 支持UKUI桌面    | sig-UKUI  | sig-UKUI | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
|2| 支持DDE桌面                                           | sig-DDE | sig-DDE  | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
|3| 支持Kiran桌面     | sig-KIRAN-DESKTOP  | sig-KIRAN-DESKTOP  | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
|4| 安装部署                                              | sig-OS-Builder| sig-QA  | 验证覆盖裸机/虚机场景下，通过光盘/PXE等安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
|5| 内核                                                  | Kernel | Kernel | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
|6| 容器(isula/docker/安全容器/系统容器/镜像)             | sig-CloudNative | sig-CloudNative| 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
|7| 虚拟化                                                | Virt| Virt  | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能       |
|8| 系统性能自优化组件A-Tune                                            | A-Tune  | A-Tune | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
|9| 支持secPaver                                           | sig-security-facility | sig-QA  | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
|10| 支持secGear                                           | sig-confidential-computing   | sig-QA | 关注secGear特性的功能完整性                                  |
|11| 发布eggo                                              | sig-CloudNative  | sig-QA  | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
|12| 支持kubeOS                                            | sig-CloudNative  | sig-QA | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
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
|39| 社区签名体系建立                                      | sig-security-facility  | sig-security-facility        | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
|40| AI集群慢节点快速发现 Add Fail-slow Detection      | sig-desktop   |  sig-desktop |  继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度   |
|41| 编译器(gcc/jdk)                                       | Compiler  | sig-QA  | 基于开源测试套对gcc和jdk相关功能进行验证                     |
|42| 支持HA软件                                            | sig-Ha | sig-Ha  | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
|43| 支持KubeSphere                                        | sig-K8sDistro | sig-K8sDistro | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
|44| 支持智能运维助手                                     | sig-ops| sig-QA   | 关注智能定位（异常检测、故障诊断）功能、可靠性               |
|45| 支持k3s                                               | sig-K8sDistro| sig-K8sDistro | 验证k3s软件的部署测试过程                                    |
|46| migration-tools增加图形化迁移openeuler功能            | sig-Migration| sig-Migration  | 验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 |
|47| 发布Nestos-kubernetes-deployer                        | sig-K8sDistro  | sig-K8sDistro  | 验证在NestOS上部署，升级和维护kubernetes集群功能正常         |    
|48| 发布PilotGo及其插件特性新版本                         | sig-ops  | sig-QA  | 验证PilotGo支持 topo 图的展示和智能调优能力                  |
|49| 智能问答在线服务                                      | sig-A-Tune  | sig-QA   | 验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 |
|50| ZGCLab 发布内核安全增强补丁                           | sig-kernel   | sig-kernel   | 针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 |
|51| 支持RISC-V                                            | sig-RISC-V | sig-RISC-V  | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
|52|为 RISC-V 架构引入 Penglai TEE 支持                   | sig-RISC-V | sig-RISC-V | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 |
|53| LLVM平行宇宙计划 RISC-V Preview 版本 | sig-RISC-V | sig-RISC-V |验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动 |
|54| Add compatibility patches for Zhaoxin processors    |  sig-kernel |  sig-kernel |  验证集成了Zhaoxin OLK-6.6补丁的内核镜像系统正常运行以及对应补丁的功能测试   |
|55| virtCCA机密虚机特性合入       | sig-kernel/sig-virt  | sig-kernel/sig-virt  |   继承已有测试能力，重点验证机密虚机的基本功能、安全、兼容性以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试  |
|56| 增加YouQu自动化测试平台支持    | sig-QA  | sig-QA  |  验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试    |   
|57| 增加 utsudo 支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utsudo基础命令使用正常   |   
|58| 增加 utshell支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utshell基础命令使用正常   |
|59| LLVM多版本实现                      | sig-Compiler  |  sig-Compiler |  继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。   |
|60| 鲲鹏KAE加速器驱动安装包合入                  | sig-kernel  | sig-kernel  |  继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩   |
|61| 版本引入ACPO包    | sig-Compiler  |  sig-Compiler |  继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容   |
|62| 内核TCP/IP协议栈支持CAQM拥塞     |  sig-kernel |  sig-kernel |  继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能   |

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试


# 3 版本概要测试结论

   openEuler 25.03版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 2轮继承特性和新增特性合入测试 + 2轮全量测试 + 2轮回归测试（版本发布验收测试）；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项。测试也提前介入，覆盖冒烟测试、安装部署等基础测试项，部分测试内容较多的专项测试也相应提前；第2、3轮重点聚焦在已合入的新需求测试和继承特性验证; 第3、4轮全量测试开展版本交付的所有特性和各类专项测试；第5、6轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试以及验证问题的修复；最后一轮还包括版本发布验收测试，是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

   openEuler 25.03 版本共发现问题 562 个，有效问题 541 个，遗留问题 0个，新增问题整体呈下降趋势，风险可控，版本整体质量良好。


# 4 版本详细测试结论

openEuler 25.03 版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险

4、专项测试包括安全专项、性能测试、可靠性测试、兼容性性测试、资料测试

5、对版本新增特性进行测试，新增特性均满足发布要求，测试较充分，质量良好


## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                     | **aarch64/x86_64质量评估**  |**risc-v质量评估**  |   **loongarch质量评估**    |  **powerpc质量评估**    | 备注                                                         |
| ---- | ----------------------- | :-------: | :--------: | :--------: | :-------: | ------------------------------------------------------------ |
| 1 | 支持DDE桌面  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，关注DDE桌面系统的安装和基本功能    |
| 2 | 支持UKUI桌面  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，关注UKUI桌面系统的安装和基本功能    |
| 3 | 支持Kiran桌面  | <font color=green>█</font> |  |     |     | 继承已有测试能力，关注kiran桌面系统的安装和基本功能    |
| 4 | 安装部署  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署   |
| 5 | 内核  | <font color=green>█</font>  | <font color=green>█</font> |     |     |  继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内   |
| 6 | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证   |
| 7 | 虚拟化 | <font color=green>█</font> | <font color=green>█</font> |     |     |   继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能   |
| 8 | 支持A-Tune  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，本次无新增合入，重点关注继承功能验证，如服务/配置检查等   |
| 9 | 支持secPaver  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，关注secPave特性的基本功能和服务的稳定性   |
| 10 | 支持secGear  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证secGear特性的功能完整性，包括远程证明基线与策略导入，查询，创建、加解密、边界检查、生成随机数、打印、销毁等特性正常运行   |
| 11 | 支持eggo  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性   |
| 12 | 支持kubeOS | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力  |
| 13 | 支持etmem内存分级扩展  | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证特性的基本功能和稳定性    |
| 14 | 支持用户态协议栈gazelle | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证gazelle高性能用户态协议栈功能，包括支持ceph,支持DWS，支持单网卡negligible，支持苏移krpc，一键脚本部署等继承功能 |
| 15 | 支持国密算法  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证SSH协议栈、TLCP协议栈、内核模块签名、安全启动、文件完整性保护、用户身份鉴别、磁盘加密、算法库等模块支持国密算法。   |
| 16 | 支持pod带宽管理oncn-bwm  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证使能/网卡Qos功能，设置cgroup优先级、在线水线、离线带宽等功能，使能网卡QOS功能后，在线业务可实时抢占离线业务带宽，以及功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等。  |
| 17 | 支持isuald  | <font color=green>█</font> | <font color=green>█</font> |     |     | 继承已有测试能力，覆盖继承功能cgroup v2,热升级，健康检查，本地卷，容器生命周期管理，镜像管理，资源管理等，重点验证isulad长稳场景  |
| 18 | 支持A-OPS | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景  |
| 19 | 支持系统运维套件x-diagnosis  | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能   |
| 20 | 支持自动化热升级组件nvwa | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等   |
| 21 | 支持DPU直连聚合特性dpu-utilities  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源   |
| 22 | 支持系统热修复组件syscare | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力   |
| 23 | iSula容器镜像构建工具isula-build  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能   |
| 24 | 支持进程完整性防护特性DIM | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等，用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量，以及度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量   |
| 25 | 支持入侵检测框架secDetector  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等   |
| 26 | isocut镜像裁剪易用性提升 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包   |
| 27 | 支持devmaster组件 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景   |
| 28 | 支持TPCM特性  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试用例，验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等   |
| 29 | 支持sysMaster                          | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景   |
| 30 | 支持sysmonitor特性  | <font color=green>█</font> | <font color=blue></font> |     |     |  继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景   |
| 31 | 混合部署rubik  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化   |
| 32 | 支持IMA自定义证书 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式  |
| 33 | 支持IMA virtCCA  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等   |
| 34 | 安全启动  | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等  |
| 35 | Kmesh | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等   |
| 36 | openEuler安全配置规范框架设计及核心内容构建   | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性    |
| 37 | oemaker | <font color=green>█</font> | <font color=green>█ </font> |     |     |  继承已有测试能力，在构建工程中保证oemaker功能正常   |
| 38 | openssl | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上    |
| 39 | 社区签名体系建立  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性   |
| 40 | AI集群慢节点快速发现 | <font color=green> █ </font> | <font color=green></font> |     |     |   继承已有测试能力，重点测试组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度，主要覆盖功能测试、可靠性测试和长稳测试 |
| 41 | 编译器(gcc/jdk) | <font color=green>█</font> | <font color=green>█</font> |     |     |   继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证  |
| 42 | 支持HA软件 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性    |
| 43 | 支持KubeSphere | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力  |
| 44 | 支持智能运维助手  | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性     |
| 45 | 支持k3s| <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证k3s软件的部署功能正常     |
| 46 | migration-tools增加图形化迁移openeuler功能 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统   |
| 47 | 发布Nestos-kubernetes-deployer | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，覆盖在NestOS上部署，升级和维护kubernetes集群功能正常   |
| 48 | 发布PilotGo及其插件特性新版本 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证PilotGo支持 topo 图的展示和智能调优能力   |
| 49 | 智能问答在线服务 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力   |
| 50 | ZGCLab发布内核安全增强补丁| <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试   |
| 51 | 支持RISC-V | <font color=green> </font> | <font color=green>█ </font> |     |     | 验证openEuler版本在RISV-V处理器上的可安装和可使用性     |
| 52 | 为RISC-V架构引入Penglai TEE 支持  | <font color=green>   </font> | <font color=green>█ </font> |     |     |   继承已有测试能力，验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等  |
| 53 | LLVM平行宇宙计划 RISC-V Preview 版本  | <font color=green>  </font> | <font color=green>预计4月中完成测试</font> |     |     |   继承已有测试能力，验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动  |
| 54 | Add compatibility patches for Zhaoxin processors  | <font color=green> █ </font> | <font color=green></font> |     |     |   继承已有测试能力，主要覆盖功能测试，针对Zhaoxin处理器进行Zhaoxin OLK-6.6补丁测试 |
| 55 | virtCCA机密虚机特性合入 | <font color=green> █ </font> | <font color=green></font> |     |     |   继承已有测试能力，机密虚机场景主要覆盖了功能、性能、可靠性、兼容性、资料和长稳测试  |
| 56 | 增加YouQu自动化测试平台支持 | <font color=green> █ </font> | <font color=green></font> |     |     |   继承已有测试能力，主要覆盖功能测试，包括软件包安装、卸载和正常部署并测试DDE环境  |
| 57 | 增加 utsudo 支持 | <font color=green> █ </font> | <font color=green>█ </font> |     |     |   继承已有测试能力，主要覆盖utsudo功能测试，包括软件包安装、卸载和utsudo基础命令验证 |
| 58 | 增加 utshell支持 | <font color=green> █ </font> | <font color=green>█ </font> |     |     |   继承已有测试能力，主要覆盖utsudo功能测试，包括软件包安装、卸载和utshell基础命令验证  |
| 59 | LLVM多版本实现 | <font color=green> █ </font> | <font color=green>█ </font> |     |     |   继承已有测试能力，主要验证LLVM多版本包引入对于全量版本构建没有影响、LLVM多版本包能够正常工作和使用，覆盖功能测试和可靠性测试 |
| 60 | 鲲鹏KAE加速器驱动安装包合入  | <font color=green> █ </font> | <font color=green></font> |     |     |   继承已有测试能力， 验证KAE特性的加解密和压缩解压缩，主要覆盖功能测试和性能测试 |
| 61 | 版本引入ACPO包  | <font color=green> █ </font> | <font color=green></font> |     |     |   继承已有测试能力，主要验证使能ACPO并构建编译器、使用提供的ACPO源代码进行模型训练以及使用训练好的模型进行推理并使用perf统计执行时间，覆盖功能测试、性能测试和可靠性测试  |
| 62 | 内核TCP/IP协议栈支持CAQM拥塞  | <font color=green> █ </font> | <font color=green></font> |     |     |   继承已有测试能力，主要验证CAQM自身功能用例、标准性能测试和Postgres SQL场景下带流性能提升，覆盖功能测试、性能测试、可靠性测试 |


<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价


对新需求进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **aarch64/x86_64质量评估**    |  **risc-v质量评估**    |   **loongarch质量评估**    |  **powerpc质量评估**    | **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | ---------------- | ---------------- | ---------------- | -------------- | -------------------------- | -------- |
|  1 | [  为AArch64编译默认开启PAC/BTI  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 主要覆盖了功能测试和兼容性测试，重点关注通过读取软件包中的二进制ELF文件检查PAC/BTI的支持情况，未发现问题，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  2 | [  支持树莓派  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 针对openEuler25.03树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性测试，发现1个issue已解决，整体质量良好。 |  |  | <font color=green>█</font> |  | | | |
|  3 | [  Aops: cve修复/配置溯源实现运维智能化，支持主动通知和图文混合交互  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行1043个用例、新特性用例36条，执行继承特性用例1007条，主要覆盖了智能运维助手、用户管理、资产管理、配置溯源等模块的功能测试，测试充分，共发现22个问题，已全部回归完成，无遗留问题  |  |  | <font color=green>█</font> |  | | | |
|  4 | [  基于sysboost实现启动时优化，通用兼容性增强  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行了11个用例，主要覆盖了Host和容器场景下的功能、可靠性、性能测试，重点关注可靠性与性能，经测试发现5个问题，均回归通过，整体质量良好。 |  |  | <font color=green>█</font> |  | | | |
|  5 | [  GCC for openEuler编译链接加速，缩减编译时间  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行3个用例，主要覆盖MOLD链接器功能测试和性能测试，功能测试2个用例通过，性能测试编译总时间减少9.55%，目标5~10%，验收通过|  |  | <font color=green>█</font> |  | | | |
|  6 | [  机密容器Kuasar适配virtCCA  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行7个用例，继承用例执行188个，主要覆盖了机密容器的生命周期命令，服务稳定性，并发测试，文件残留，日志打印等，发现2个问题已回归通过，整体质量良好。 |  |  | <font color=green>█</font> |  | | | |
|  7 | [  secGear支持机密容器镜像密钥托管  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行16个用例，主要覆盖了远程证明代理、服务端、客户端秘钥托管功能测试，可靠性测试。发现6个问题，已回归通过，整体质量良好。 |  |  | <font color=green>█</font> |  | | | |
|  8 | [  构建基于远程证明的TLS协议（RA-TLS）  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行10个用例，主要覆盖单向、双向认证、单agent、多agent场景TLS建链、远程证明功能测试和可靠性测试，经测试发现1个问题，回归通过，整理质量良好 |  |  | <font color=green>█</font> |  | | | |
|  9 | [  Trace IO加速容器快速启动  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | Trace IO加速容器快速启动特性，共计执行18个用例，主要覆盖了功能测试用例、兼容性测试和性能测试用例，未发现问题，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  10 | [ 引入vkernel概念增强容器隔离能力   ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 基于openEuler-25.03版本的 Vkernel 特性操作系统内核，针对其功能、性能和兼容性进行LTP、UnixBench、容器运行时对比、容器生态兼容、相关应用性能共计5项测试，未发现问题，整体质量良好。 |  |  | <font color=green>█</font> |  | | | |
|  11 | [  openAMDC合入  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 主要覆盖了功能测试、性能测试、兼容性测试、安全测试，重点验验证了软件的核心功能模块，包括string、list、hash、set、sortedset等数据类型读写和主从复制、服务高可用功能 |  |  | <font color=green>█</font> |  | | | |
|  12 | [  oeAware支持瓶颈评估一键推荐调优等特性增强   ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行了13个用例，主要覆盖了透明大页场景识别、透明大页使能禁用、查询模块显示以及虚拟网卡亲和配置场景功能测试、异常测试，经测试发现11个issue，回归验证中，预计无遗留问题 |  |  | <font color=green>█</font> |  | | | |
|  13 | [  oeDeploy 部署能力增强  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行了9个用例，主要覆盖了功能测试、兼容性和性能指标达成，经测试未发现问题，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  14| [   主流工业中间件支持  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行了12个测试用例，主要涵盖中间件的检查、动态链接查询、数据的加解密等的测试，发现1个issue，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  15 | [  跨域通信框架，支持接口调用跨域通信   ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 主要覆盖混合部署通信速率测试，在大文件读写场景下，实测通信时延为5.14ms，达成性能指标要求 |  |  | <font color=green>█</font> |  | | | |
|  16 | [  虚拟化底座，使能XEN虚拟化框架  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 使能XEN虚拟化框架 共执行了22个测试用例，主要涵盖镜像的安装、xen的启动和管理、domU的创建和启停、性能等的测试，发现1个issue，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  17 | [  硬实时南向生态：EtherCAT支持  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) |  预计3/28完成 |  |  | <font color=green></font> |  | | | |
|  18| [   嵌入式：硬实时POSIX接口补齐  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 预计3/28完成 |  |  | <font color=green></font> |  | | | |
|  19 | [  DevStation社区原生/图形化/南向兼容性等新增特性   ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行用例67条，主要覆盖了默认集成epkg/eulercopilot/oeDeploy/devkit、支持常用浏览器/邮箱、支持社区开发环境，以及南向支持裸机部署等功能测试、兼容性测试、共发现问题14个已全部解决，整体风险可控 |  |  | <font color=green>█</font> |  | | | |
|  20| [  EPKG包管理器优化，提升epkg易用性  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 共执行用例126条，新特性86条，继承特性40条，主要覆盖epkg包管理器、x2epkg实现软件包二进制转化以及加包工程自动批量转换等功能测试、兼容性测试、可靠性测试，共发现问题15个，已全部解决回归通过，整体风险可控 |  |  | <font color=green>█</font> |  | | | |
|  21 | [  支持 OpenStack Antelope 版本  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) |  共计执行Tempest用例1483个，主要覆盖了 API 测试和功能测试，并通过 7*24 的长稳测试，未发现问题，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  22 | [  云原生基础设施部署升级工具k8s-isntall 加入版本  ](https://gitee.com/openeuler/release-management/blob/master/openEuler-25.03/release-plan.md) | 主要覆盖了功能测试、性能测试和异常处理测试，重点验证k8s-install工具支持在线/离线模式下一键式安装部署云原生基础设施的能力，未发现问题整体质量良好 |  |  | <font color=green>█</font> |  | | | |



<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1 虚机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 |
| ---------- | ----------------------- | ------- | -------- |
| openEuler 25.03  | Centos 6 | x86_64 | PASS |
| openEuler 25.03  | Centos 7 | aarch64 | PASS |
| openEuler 25.03 | Centos 7 | x86_64  | PASS |
| openEuler 25.03 | Centos 8 | aarch64 | PASS |
| openEuler 25.03 | Centos 8 | x86_64  | PASS |
| openEuler 25.03  | Windows Server 2016 | x86_64  | PASS |
| openEuler 25.03  | Windows Server 2019 | x86_64  | PASS |
| openEuler RISC-V 25.03 | Ubuntu 24.10 | riscv64 | PASS |
| openEuler RISC-V 25.03 | Fedora 41 | riscv64 | PASS |


## 4.3   专项测试结论

### 4.3.1 安全测试

整体安全测试覆盖：

1、病毒扫描：对于产品提供的镜像中的aarch64架构与x86_64架构rpm软件包，使用majun平台病毒扫描工具进行在线扫描分析，扫描结果中未出现病毒报警，无风险。

2、安全编译选项扫描：对于产品提供的标准镜像中的aarch64架构与x86_64架构中的rpm软件包，使用majun平台二进制扫描工具扫描安全编译选项，对于baseos软件包范围内的扫描结果未实行必选安全编译选项的项进行确认(包括rpath、pie、strip)，发现问题12个，所有问题均已修复或评估，无风险

3、开源片段引用扫描：目前对于openeler社区孵化的baseos范围内的69个软件包仓库，使用majun平台的开源片段扫描工具扫描，对于扫描结果中累计识别出的片段引用进行分析，所有问题均已修复或评估，无风险。

4、开源合规license检查：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，验证了49847个rpm软件包，共有140个rpm软件包的license不在openEuler合规license准入列表中，其中，已经审阅并评审修复通过140个rpm软件包的license，无风险。

5、签名和完整性校验：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，使用shell命令对49847个rpm软件包进行了签名完整性校验，所有rpm包均有签名且具有一致性。

6、SBOM校验：对于产品提供的aarch64架构、x86_64架构、，2种架构的iso镜像均具有SBOM文件及SBOM文件签名。

整体OS安全测试较充分，主要问题均已解决，回归测试正常，风险可控，详细测试内容见安全专项测试报告：
https://gitee.com/openeuler/QA/blob/bcc912af09e492a1f4e0ffc7559833628d9b0e7c/Test_Result/openEuler-25.03/openEuler-25.03%E7%89%88%E6%9C%AC%E5%AE%89%E5%85%A8%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md

### 4.3.2 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                                                    |
| ------------ | ------------------------------------------------------------ | ----------------------------------------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况；稳定性测试时长7\*24 |通过 |

### 4.3.3 性能测试


| **指标大项** | **指标小项**                                                                               | **指标值**              | **测试结论**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 与基线版本对比不劣化5%以内目标已达成 |

# 5   问题单统计

openEuler 25.03版本共发现问题562个，有效问题541个，其中遗留问题 0 个，详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注        |
| --------------------------- | -------- | ------------ | ------------ | ------------ | -------------------------- |
| openEuler 25.03 dailybuild |  61  | 61   |   |     | 每日构建   |
| openEuler 25.03 alpha |  195 | 193   | 2 |       | Alpha轮次   |
| openEuler 25.03 RC1 |  85  |  82  | 3 |      | Beta轮次  |
| openEuler 25.03 RC2        |  86   |  84  | 2  |      | 特性合入 |
| openEuler 25.03 RC3        |  71  |  65  |  6  |     | 全量集成  |
| openEuler 25.03 RC4        |  41  |  34    |  7  |      | 全量集成    |
| openEuler 25.03 RC5        |  19  |  18    |  1  |     | 回归测试 |
| openEuler 25.03 RC6        |  4  |  4    |    |      | 回归测试(版本验收测试) |

# 6 版本测试过程评估

#### 6.1 问题单分析

本次版本测试各迭代从Alpha到RC6，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求。Alpha属于开发自验证轮次，测试提前介入，软件包构建失败问题14个。RC1特性转测轮次开始，当前社区版本有效issue共计541个，均定位解决并通过测试验收，有效防护特性质量; 新增issue总体趋势下降, 符合质量预期，风险可控。

1. DailyBuild为保障baseOS范围内软件包正常发布，60个都是构建失败问题
2. Alpha属于开发自验证轮次，测试提前介入，通用场景问题发现87个，同时alpha要求覆盖everything软件包正常发布，构建问题93个
3. RC1新需求未转测，除OS常规测试项安装部署、单包测试发现少量问题外保障epol仓库软件包构建成功，新增构建问题62
4. RC2-RC3新需求开始转测，其中aops、devstation、sysboost、secGear、基础设施、编译器等特性验收发现问题90+
5. RC4仍处特性阶段，devstation、oeaware、等特性持续测试发现问题
6. 软件包构建和降级问题依然显著，占版本问题60%

- 改进点：

1. 由于软件包分支合入规范导致的软件包构建失败和降级问题已组织专题讨论并上RM汇报，落地方案正在规划中
2. 缺少缺陷密度评估数据，开发代码量统计规则和数据在下一个版本补齐


#### 6.2 OS集成测试迭代版本基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 25.031 alpha | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理                      |
|                             |                  | source包自编译                 |
|                             | 安全专项部分测试项启动      |        |
|                             |                  | 漏洞扫描                       |
|                             |                  | 安全编译选项扫描               |
|                             |                  | 安全配置基线        |
|                             |                  | 开源license检查  |
|                             | 操作系统默认参数对比       |                       |
|                             | 安装部署部分测试项启动       |                       |
|                             | 单包命令         | 启动             |
|                             | 软件包升降级变化分析       |                       |
|                             | 指南类测试       |                       |
|                             | 内核基本功能、安全、性能测试       |                       |
|                             | 性能专项         | 基础性能测试                   |
| openEuler 25.03 RC1   | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理                      |
|                             |                  | source包自编译                 |
|                             | 安全专项         |                        |
|                             |                  | 病毒扫描                       |
|                             |                  | 开源license检查               |
|                             | 操作系统默认参数对比       |                       |
|                             | 性能专项         | 基础性能、场景化性能                   |
|                             | 兼容性专项         | 南向兼容性                   |
|                             | 安装部署         | 标准镜像                       |
|                             |                  | PXE安装                |
|                             |                  | stratovirt镜像                 |
|                             |                  | 边缘镜像                 |
|                             | 单包命令         | everything全量测试             |
|                             | 单包服务         | everything全量测试             |
|                             | 系统集成         | 管理员指南测试                 |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                       |
|                             |                  | 安全测试                       |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 编译器专项       | gcc测试                        |
| openEuler 25.03 RC2 | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理                      |
|                             |                  | source包自编译                 |
|                             | 安全专项         | 敏感词扫描                     |
|                             |                  | 端口扫描                     |
|                             |                  | 加固指南                   |
|                             |                  | 自研加固                   |
|                             | 性能专项         | 基础性能、场景化性能                   |
|                             | 兼容性专项         | 南向兼容性                   |
|                             | 重启专项专项     | 冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             | 系统集成         |    应用开发测试              |
|                             | 版本变化专项     | 软件范围变化测试               |
|                             | 软件包依赖关系检查     | pkgship               |
|                             | 安装部署         | 标准镜像                       |
|                             |                  | stratovirt镜像                 |
|                             |                  | 边缘镜像                 |
|                             | 单包命令         | everything增量测试             |
|                             | 单包服务         | everything增量测试             |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 编译器专项       | gcc测试                        |
| openEuler 25.03 RC3 | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理（全量测试）      |
|                             |                  | source包自编译 |
|                             | 文件系统专项     |                                |
|                             | 安全专项         |                     |
|                             |                  | 安全编译选项扫描         |
|                             |                  | 病毒扫描  |
|                             |                  | 加固指南  |
|                             |                  | 自研加固测试               |
|                             | 性能专项         | 基础性能、场景化性能                   |
|                             | 兼容性专项         | 南向兼容性                   |
|                             | 安装部署         | 标准镜像                       |
|                             |                  | PXE安装                 |
|                             | 单包命令         | everything全量测试         |
|                             | 单包服务         | everything全量测试         |
|                             | 系统集成         | 管理员指南测试                 |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             |                  | 长稳测试                  |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 多动态库检查专项 |                                |
|                             | 编译器专项       | gcc测试                        |
|                             | openjdk测试                |                     |
| openEuler 25.03 RC4 | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理（全量测试）      |
|                             |                  | source包自编译 |
|                             | 重启专项专项     | 冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             | 网络系统专项     |                                |
|                             | 安全专项         | 安全编译选项扫描               |
|                             |                  | 病毒扫描                       |
|                             |                  | 端口扫描                       |
|                             |                  | 安全加固指南测试               |
|                             |                  | 自研加固测试               |
|                             |                  | 安全配置基线               |
|                             |                  | 开源License检查               |
|                             | 性能专项         | 基础性能、场景化性能                   |
|                             | 兼容性专项         | 南向兼容性                   |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 安装部署         | 标准镜像                       |
|                             |                  | stratovirt镜像                 |
|                             |                  | 边缘镜像                 |
|                             | 单包命令         | everything增量变动测试         |
|                             | 单包服务         | everything增量变动测试         |
|                             | 系统集成         | 应用开发测试                 |
|                             | 内核专项         |                    |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             | 编译器专项       | gcc测试                        |
| openEuler 25.03 RC5     | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理（增量变动部分）      |
|                             |                  | source包自编译） |
|                             | 单包命令         | everything增量变动测试         |
|                             | 单包服务         | everything增量变动测试         |
|                             | 内核专项         | 长稳测试                   |
|                             | 安全专项         | 开源License检查                   |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 编译器专项       | gcc测试                        |
|                             | 回归测试       | 问题单回归                        |
| openEuler 25.03 RC6     |    冒烟测试   |                    |
|                             | docker_img测试       |                       |
|                             | 安全专项         | 发布件SBOM文件检查                   |
|                             | 回归测试       | 问题单回归                        |
|                             | release发布件测试      | release发布件测试                        |
|                             | 发布件sha256值校验       | 发布件sha256值校验                        |



# 7   附件

## 遗留问题列表


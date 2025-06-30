![openEuler ico](../../images/openEuler.png)

版权所有 © 2025  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2025/6/23 | 1.0.0    | 初稿 | linqian0322 |
| 2025/6/25 | 1.0.1 | 新增RISC-V测试结果 | jean9823 |




摘要：

文本主要描述openEuler 24.03 LTS SP2版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 24.03 LTS SP2版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 24.03 LTS SP2版本是基于6.6内核的增强扩展版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 24.03 LTS-Next分支拉出，发布范围相较24.03 LTS版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-change.yaml)
2.  修复bug和cve


## 2.1 版本测试计划
openEuler 24.03 LTS SP2版本按照社区release-manager团队的计划，共规划9轮测试，详细的版本信息和测试时间如下表：

| Stage Name                    | Deadline for PR | Begin Time| End Time  | Days | Note                                     |
| ----------------------------- | --------------- | ----------| --------- | ---- | ---------------------------------------- |
| Collect key features          |        -        | 2025/3/1  | 2025/4/30 |  61  | 版本需求收集                              |
| Change Review 1               |        -        | 2025/4/1  | 2025/5/8  |  38  | Review 软件包变更（升级/退役/淘汰）        |
| Herited features              |        -        | 2025/4/1  | 2025/4/24 |  24  | 继承特性合入（Branch前完成合入）           |
| Develop                       |        -        | 2025/4/1  | 2025/5/27 |  57  | 新特性开发，合入24.03 LTS next            |
| Kernel freezing               |        -        | 2025/5/1  | 2025/5/8  |  8  | 内核冻结（随Beta版本，内核冻结）           |
| Next Build                    |        -        | 2025/4/1  | 2025/4/10 |  10  | 启动新版本构建，新开发特性合入             |
| Alpha                         |    2025/4/9     | 2025/4/11 | 2025/4/17 |  7   | 24.03 LTS SP2 模块测试                   |
| Test round 1                  |    2025/4/16    | 2025/4/18 | 2025/4/24 |  7   | 24.03 LTS SP2 模块测试                   |
| Branch                        |                 | 2025/4/18 | 2025/4/23 |  7   | 24.03 LTS Next 拉取 24.03 LTS SP2 分支   |
| Test round 2                  |    2025/4/23    | 2025/4/25 | 2025/5/8  |  14  | 24.03 LTS SP2 模块测试，五一劳动节快乐     |
| Change Review 2               |        -        | 2025/5/6  | 2025/5/8  |  3   | 发起软件包淘汰评审                        |
| Test round 3 (Beta Version)   |    2025/5/7     | 2025/5/9  | 2025/5/15 |  7   | 24.03 LTS SP2 Beta版本发布，24.03 LTS SP2 模块测试       |
| Test round 4                  |    2025/5/12    | 2025/5/16 | 2025/5/22 |  7   | 24.03 LTS SP2 模块测试                   |
| Test round 5                  |    2025/5/21    | 2025/5/23 | 2025/5/29 |  7   | 24.03 LTS SP2 模块测试                   |
| Test round 6                  |    2025/5/28    | 2025/5/30 | 2025/6/6  |  8   | 24.03 LTS SP2 模块测试，端午节快乐        | 
| Change Review 3               |        -        | 2025/6/3  | 2025/6/5  |  3   | 确定软件包发布范围                        |
| Test round 7                  |     2025/6/5    | 2025/6/7  | 2025/6/13 |  7   | 全量验证(全量SIT)                         |
| Test round 8                  |     2025/6/12   | 2025/6/14 | 2025/6/20 |  7   | 回归测试，分支冻结，只允许bug fix          |
| Test round 9                  |     2025/6/19   | 2025/6/21 | 2025/6/27 |  7   | 回归测试                                 |
| Release Review                |       -         | 2025/6/21 | 2025/6/22 |  2   | 版本发布决策/ Go or No Go                 |
| Release preparation           |       -         | 2025/6/20 | 2025/6/28 |  9   | 发布前准备阶段，发布件系统梳理              |
| Release                       |       -         | 2025/6/29 | 2025/6/30 |  2   | 社区Release评审通过正式发布                |   



## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920(支持1.70以上的bios版本)        | OS集成测试     |
| RH2288H V3            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| 算能            | 算丰SG2042 | OS集成测试     |

## 2.3 需求清单

openEuler 24.03 LTS SP2版本交付需求列表如下，详情见[openEuler-24.03-LTS-SP2 release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md#)：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| [IBXVC7](https://gitee.com/openeuler/release-management/issues/IBXVC7?from=project-issue) | virtCCA机密虚机相关特性合入版本 | Developing | SIG-Kernel/SIG-Virt | [@gongchangsui](https://gitee.com/gongchangsui) |
| [IC707S](https://gitee.com/openeuler/release-management/issues/IC707S?from=project-issue) | OVMF_CODE.fd支持CSV1/2/3开箱即用 | Developing| sig-edk2 | [@hanliyang](https://gitee.com/hanliyang) | ISO | edk2 |
| [IC707S](https://gitee.com/openeuler/release-management/issues/IC707S?from=project-issue) | OVMF.fd支持CSV1/2/3开箱即用 | Developing| sig-edk2 | [@hanliyang](https://gitee.com/hanliyang) | ISO | edk2 |
| [IC707S](https://gitee.com/openeuler/release-management/issues/IC707S?from=project-issue) | 支持CSV1/2/3直通DCU功能开箱即用 | Developing| sig-kernel/sig-qemu | [@hanliyang](https://gitee.com/hanliyang) | ISO | kernel,qemu |
| [IC70RL](https://gitee.com/openeuler/release-management/issues/IC70RL?from=project-issue) | 新的psp/ccp device id支持 | Developing| sig-kernel | [@chench00](https://gitee.com/chench00) | ISO | kernel |
| [IC70RL](https://gitee.com/openeuler/release-management/issues/IC70RL?from=project-issue) | 可信功能内核驱动剥离sev依赖 | Developing| sig-kernel | [@chench00](https://gitee.com/chench00) | ISO | kernel |
| [IC716L](https://gitee.com/openeuler/release-management/issues/IC716L?from=project-issue) | 海光4号美密支持，sm4-xts,sm4-gcm支持，avx/cis指令集接口支持 | Developing| sig-kernel | [@partycoder](https://gitee.com/partycoder) | ISO | kernel |
| [IC716L](https://gitee.com/openeuler/release-management/issues/IC716L?from=project-issue) | vTKM 性能优化 | Developing| sig-kernel | [@xisme](https://gitee.com/xisme) | ISO | kernel |
| [IBSO3U](https://gitee.com/openeuler/release-management/issues/IBSO3U?from=project-issue) | 需要合入bcache的bug fix | Developing| sig-kernel | [@geshifei-linux](https://gitee.com/geshifei-linux) | ISO | kernel |
| [IBSO3U](https://gitee.com/openeuler/release-management/issues/IBSO3U?from=project-issue) | 对hygon 8h DF PMU的适配 | Developing| sig-kernel | [@liuqi_77777](https://gitee.com/liuqi_77777) | ISO | kernel |
| [IBSO3U](https://gitee.com/openeuler/release-management/issues/IBSO3U?from=project-issue) | 需要合入海光分支patch和memset的nt patch | Developing| sig-kernel | [@jiamei01](https://gitee.com/jiamei01) | ISO | glibc |
| [IBZ9CK](https://gitee.com/openeuler/release-management/issues/IBZ9CK)|支持树莓派|Discussion|sig-SBC|[@woqidaideshi](https://gitee.com/woqidaideshi/)|EPOL|raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom,raspberrypi-utils|
| [IC3KIG](https://gitee.com/openeuler/release-management/issues/IC3KIG) | 支持 OpenStack Antelope/Wallaby 版本 | Developing | sig-openstack | [@tzing_t](https://gitee.com/tzing_t) |
| [IC61GG](https://gitee.com/openeuler/release-management/issues/IC61GG?from=project-issue) | 基于通信算子的低开销高精度慢节点检测 | Developing | sig-ops | [@webankto](https://gitee.com/webankto) |
| [IC62PY](https://gitee.com/openeuler/release-management/issues/IC62PY?from=project-issue) | 昇腾软件栈适配、组件化集成持续增强 | Developing | sig-compilitable | [@jimmy_hero](https://gitee.com/jimmy_hero) |
| [IC61QU](https://gitee.com/openeuler/release-management/issues/IC61QU?from=project-issue) | DevStation开发流程智能化增强 | Developing | sig-intelligence | [@duan_pj](https://gitee.com/duan_pj) |
| [IC62XT](https://gitee.com/openeuler/release-management/issues/IC62XT?from=project-issue) | 支持超大虚机规格 | Developing | virt-sig | [@JiaboFeng](https://gitee.com/JiaboFeng) |
| [IC632C](https://gitee.com/openeuler/release-management/issues/IC632C?from=project-issue) | openEuler Copilot 支持多维度（时间）过滤分析和分权分域，推理高准确率开箱即用 | Developing | sig-intelligence | [@fromhsc](https://gitee.com/fromhsc) |
| [IC5ZTI](https://gitee.com/openeuler/release-management/issues/IC5ZTI?from=project-issue) | 嵌入式北向软件包补齐 | Developing | sig-embedded | [@hzc04](https://gitee.com/hzc04) |
| [IC61UI](https://gitee.com/openeuler/release-management/issues/IC61UI?from=project-issue) | epkg新型软件包及包管理器功能增强 | Developing | sig-epkg | [@duan_pj](https://gitee.com/duan_pj) |
| [IC67I8](https://gitee.com/openeuler/release-management/issues/IC67I8?from=project-issue) | FUSE passthrough支持 | Developing | sig-kernel | [@yang-erkun](https://gitee.com/yang-erkun) |
| [IC60AT](https://gitee.com/openeuler/release-management/issues/IC60AT?from=project-issue) | oeDeploy工具易用性提升，部署能力增强 | Developing | sig-ops | [@dingjiahuichina](https://gitee.com/dingjiahuichina) |
| [IC611D](https://gitee.com/openeuler/release-management/issues/IC611D?from=project-issue) | 基于eBPF等技术实现AI作业进程Stack Mergeing，支持典型内存故障定位 | Developing | sig-aops | [@webankto](https://gitee.com/webankto) |
| [IC67QT](https://gitee.com/openeuler/release-management/issues/IC67QT?from=project-issue) | 虚拟化场景支持vKAE直通设备热迁移 | Developing | virt-sig | [@JiaboFeng](https://gitee.com/JiaboFeng) |
| [IC64F9](https://gitee.com/openeuler/release-management/issues/IC64F9?from=project-issue) | secGear支持机密虚机基于UEFI启动方式的报告生成及验证 | Developing | sig-confidential-computing | [@houmingyong](https://gitee.com/houmingyong) |
| [IC621U](https://gitee.com/openeuler/release-management/issues/IC621U?from=project-issue) | 支持可信计算远程证明服务组件 | Developing | sig-security-facility | [@yang8621](https://gitee.com/yang8621) |
| [IC64EX](https://gitee.com/openeuler/release-management/issues/IC64EX?from=project-issue) | 支持Kuasar机密容器镜像加解密 | Developing | sig-confidential-computing/sig-Cloudnative | [@xuxuepeng](https://gitee.com/xuxuepeng) |
| [IC8X6H](https://gitee.com/openeuler/release-management/issues/IC8X6H?from=project-issue) | 支持众核高密容器级资源隔离技术 | Developing | sig-kernel | [@yukaii](https://gitee.com/yukaii) |


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
|10|支持secGear                                           | sig-confidential-computing   | sig-QA | 关注secGear特性的功能完整性，包括远程证明基线与策略导入，查询，创建、加解密、边界检查、生成随机数、打印、销毁等特性正常运行                                |
|11|发布eggo                                              | sig-CloudNative  | sig-QA  | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
|12|支持kubeOS                                            | sig-CloudNative  | sig-QA | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
|13| 支持etmem                               | Storage   | sig-QA  | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
|14| 支持用户态协议栈gazelle                               | sig-high-performance-network | sig-QA | 关注gazelle高性能用户态协议栈功能，包括支持ceph,支持DWS，支持单网卡negligible，支持苏移krpc，一键脚本部署等继承功能                           |
|15| 支持国密算法                                          | sig-security-facility| sig-QA  | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
|16| 支持pod带宽管理oncn-bwm                               | sig-high-performance-network | sig-QAk | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
|17| iSulad                                 | sig-iSulad   | sig-QA  |  覆盖继承功能cgroup v2,热升级，健康检查，本地卷，容器生命周期管理，镜像管理，资源管理等，重点验证isulad长稳场景                 |
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
|39|编译器(gcc/jdk)                                       | Compiler  | sig-QA  | 基于开源测试套对gcc和jdk相关功能进行验证                     |
|40| 支持HA软件                                            | sig-Ha | sig-Ha  | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
|41|支持KubeSphere                                        | sig-K8sDistro | sig-K8sDistro | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
|42| 支持 OpenStack Antelope/Wallaby 版本                        | sig-OpenStack | sig-OpenStack  | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能   |
|43| 支持智能运维助手                                     | sig-ops| sig-QA   | 关注智能定位（异常检测、故障诊断）功能、可靠性               |
|44| 支持k3s                                               | sig-K8sDistro| sig-K8sDistro | 验证k3s软件的部署测试过程                                    |
|45|migration-tools增加图形化迁移openeuler功能            | sig-Migration| sig-Migration  | 验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 |
|46|发布Nestos-kubernetes-deployer                        | sig-K8sDistro  | sig-K8sDistro  | 验证在NestOS上部署，升级和维护kubernetes集群功能正常         |
|47| 发布PilotGo及其插件特性新版本                         | sig-ops  | sig-QA  | 验证PilotGo支持 topo 图的展示和智能调优能力                  |
|48|社区签名体系建立                                      | sig-security-facility  | sig-security-facility        | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
|49| 智能问答在线服务                                      | sig-A-Tune  | sig-QA   | 验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 |
|50| 支持GreatSQL                               | sig-RaspberryPi  | sig-RaspberryPi  | 验证GreatSQL源码编译、RPM安装、二进制包安装、主要功能及性能、稳定性 |
|51| ZGCLab 发布内核安全增强补丁                           | sig-kernel   | sig-kernel   | 针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 |
|52| 支持RISC-V                                            | sig-RISC-V | sig-RISC-V  | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
|53|为 RISC-V 架构引入 Penglai TEE 支持                   | sig-RISC-V | sig-RISC-V | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 |
|54| LLVM平行宇宙计划 RISC-V Preview 版本 | sig-RISC-V | sig-RISC-V |验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动 |
|55| Add compatibility patches for Zhaoxin processors    |  sig-kernel |  sig-kernel |  验证集成了Zhaoxin OLK-6.6补丁的内核镜像系统正常运行以及对应补丁的功能测试   |
|56| 增加YouQu自动化测试平台支持    | sig-QA  | sig-QA  |  验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试    |   
|57| 增加 utsudo 支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utsudo基础命令使用正常   |   
|58| 增加 utshell支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utshell基础命令使用正常   |
|59| 集成openGauss 6.0.0 LTS企业版       | sig-DB  | sig-DB  |  重点验证openGauss 6.0.0数据库系统工具、SQL功能、数据库升级、兼容B库模块等功能测试   |
|60| LLVM多版本实现                      | sig-Compiler  |  sig-Compiler |  继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。   |
|61| 新增密码套件openHiTLS               |  sig-security-facility |  sig-security-facility |  继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试    |
|62| AI流水线oeDeloy       | sig-cicd  | sig-QA  |  继承已有测试能力，重点验证通过oeDeploy进行kubeflow部署及k8s基础功能测试   |
|63| 支持epkg新型软件包及包管理器             |  sig-cicd | sig-QA  |  继承已有测试能力，重点验证epkg包构建，输出epkg软件包以及包管理器实现环境创建，多版本运行等功能   |
|64| 支持oeaware                |  sig-A-Tune | sig-QA  |  继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容  |
|65| DevStation 开发者工作站支持                      | sig-desktop  | sig-QA  |   继承已有测试能力，重点验证安装部署启动、支持图形化编程环境，以及融合的epkg、Eulercopilot、x2openEuler的基本功能 |
|66| AI集群慢节点快速发现 Add Fail-slow Detection      | sig-desktop   |  sig-desktop |  继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度   |
|67| RPM国密签名支持                             | sig-security-facility  | sig-security-facility  |  重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容   |
|68| 鲲鹏KAE加速器驱动安装包合入  | sig-kernel  | sig-kernel  |  继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩   |
|69| Add Intel QAT packages support    | sig-Intel-Arch  | sig-Intel-Arch  |  继承已有测试能力，重点验证intel qat相关软件包的功能和性能    |
|70| 版本引入ACPO包    | sig-Compiler  |  sig-Compiler |  继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容   |
|71| 内核TCP/IP协议栈支持CAQM拥塞     |  sig-kernel |  sig-kernel |  继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能   |
|72| 支持树莓派 | SIG-SBC | SIG-SBC  | 继承已有测试能力，对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性等测试 |

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试


# 3 版本概要测试结论

   openEuler 24.03 LTS SP2版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 5轮继承特性和新增特性合入测试 + 2轮全量测试 + 2轮回归测试（版本发布验收测试）；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项， 前两轮主要覆盖冒烟测试、安装部署、单包等OS测试项; 第3轮新需求开始批量合入，重点聚焦在已合入的新需求测试和继承特性验证; 第6、7轮全量测试开展版本交付的所有特性和各类专项测试；第8、9轮重点覆盖问题单较多模块的覆盖和扩展测试以及验证问题的修复；最后一轮还包括版本发布验收测试，是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。


   openEuler 24.03 LTS SP2版本共发现问题 519 个，有效问题 498 个，无效问题 21 个，遗留问题 3 个，风险可控，版本整体质量良好。





# 4 版本详细测试结论

openEuler 24.03 LTS SP2版本详细测试内容包括：

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
| 3 | 支持Kiran桌面  | <font color=green>█</font> | <font color=green><font color=green>█</font></font> |     |     | 继承已有测试能力，关注kiran桌面系统的安装和基本功能    |
| 4 | 安装部署  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署   |
| 5 | 内核  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内   |
| 6 | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证   |
| 7 | 虚拟化 | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能   |
| 8 | 支持A-Tune  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，本次无新增合入，重点关注继承功能验证，如服务/配置检查等   |
| 9 | 支持secPaver  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，关注secPave特性的基本功能和服务的稳定性   |
| 10 | 支持secGear  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证secGear特性的功能完整性，包括远程证明基线与策略导入，查询，创建、加解密、边界检查、生成随机数、打印、销毁等特性正常运行   |
| 11 | 支持eggo  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性   |
| 12 | 支持kubeOS | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力  |
| 13 | 支持etmem内存分级扩展  | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证特性的基本功能和稳定性    |
| 14 | 支持用户态协议栈gazelle | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证gazelle高性能用户态协议栈功能，包括支持ceph,支持DWS，支持单网卡negligible，支持苏移krpc，一键脚本部署等继承功能 |
| 15 | 支持国密算法  | <font color=green>█</font> | <font color=blue><font color=green>█</font></font> |     |     |  继承已有测试能力，验证SSH协议栈、TLCP协议栈、内核模块签名、安全启动、文件完整性保护、用户身份鉴别、磁盘加密、算法库等模块支持国密算法。   |
| 16 | 支持pod带宽管理oncn-bwm  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证使能/网卡Qos功能，设置cgroup优先级、在线水线、离线带宽等功能，使能网卡QOS功能后，在线业务可实时抢占离线业务带宽，以及功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等。  |
| 17 | 支持isuald  | <font color=green>█</font> | <font color=green>█</font> |     |     | 继承已有测试能力，覆盖继承功能cgroup v2,热升级，健康检查，本地卷，容器生命周期管理，镜像管理，资源管理等，重点验证isulad长稳场景  |
| 18 | 支持A-OPS | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景  |
| 19 | 支持系统运维套件x-diagnosis  | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能   |
| 20 | 支持自动化热升级组件nvwa | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等   |
| 21 | 支持DPU直连聚合特性dpu-utilities  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源   |
| 22 | 支持系统热修复组件syscare | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力   |
| 23 | iSula容器镜像构建工具isula-build  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能   |
| 24 | 支持进程完整性防护特性DIM | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等，用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量，以及度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量   |
| 25 | 支持入侵检测框架secDetector  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等   |
| 26 | isocut镜像裁剪易用性提升 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包   |
| 27 | 支持devmaster组件 | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景   |
| 28 | 支持TPCM特性  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试用例，验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等   |
| 29 | 支持sysMaster                          | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景   |
| 30 | 支持sysmonitor特性  | <font color=green>█</font> | <font color=blue></font> |     |     |  继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景   |
| 31 | 混合部署rubik  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化   |
| 32 | 支持IMA自定义证书 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式  |
| 33 | 支持IMA virtCCA  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等   |
| 34 | 安全启动  | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等  |
| 35 | Kmesh | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等   |
| 36 | openEuler安全配置规范框架设计及核心内容构建   | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性    |
| 37 | oemaker | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，在构建工程中保证oemaker功能正常   |
| 38 | openssl | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上    |
| 39 | 编译器(gcc/jdk) | <font color=green>█</font> | <font color=green>█</font> |     |     |   继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证  |
| 40 | 支持HA软件 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性    |
| 41 | 支持KubeSphere | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力  |
| 42 | 支持OpenStack Train和Wallaby  | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能    |
| 43 | 支持智能运维助手  | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性     |
| 44 | 支持k3s| <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证k3s软件的部署功能正常     |
| 45 | migration-tools增加图形化迁移openeuler功能 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统   |
| 46 | 发布Nestos-kubernetes-deployer | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，覆盖在NestOS上部署，升级和维护kubernetes集群功能正常   |
| 47 | 发布PilotGo及其插件特性新版本 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证PilotGo支持 topo 图的展示和智能调优能力   |
| 48 | 社区签名体系建立  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性   |
| 49 | 智能问答在线服务 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力   |
| 50 | 支持GreatSQL | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证GreatSQL源码编译、RPM安装、二进制包安装、主要功能及性能、稳定性   |
| 51 | ZGCLab发布内核安全增强补丁| <font color=green> </font> | <font color=green></font> |     |     |  继承已有测试能力，针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试   |
| 52 | 支持RISC-V | <font color=green> </font> | <font color=green>█</font> |     |     | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性     |
| 53 | LLVM平行宇宙计划 RISC-V Preview 版本  | <font color=green>  </font> | 预计7月中完成测试 |     |     |   继承已有测试能力，验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动  |
| 54 | 为RISC-V架构引入Penglai TEE 支持  | <font color=green>   </font> | <font color=green>█</font> |     |     |   继承已有测试能力，验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等  |
| 55 | Add compatibility patches for Zhaoxin processors  | <font color=green> █  </font> | <font color=green></font> |     |     |  验证集成了Zhaoxin OLK-6.6补丁的内核镜像系统正常运行以及对应补丁的功能测试   |
| 56 | 增加YouQu自动化测试平台支持  | <font color=green> █  </font> | <font color=green>█</font> |     |     |  验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试   |
| 57 | 增加 utsudo 支持  | <font color=green> █  </font> | <font color=green>█</font> |     |  |继承已有测试能力，验证utsudo基础命令使用正常   |
| 58 | 增加 utshell支持  | <font color=green> █  </font> | <font color=green>█</font> |     | | 继承已有测试能力，验证utshell基础命令使用正常   |
| 59 |  集成openGauss 6.0.0 LTS企业版 | <font color=green> █  </font> | <font color=green>█</font> |     |     | 重点验证openGauss 6.0.0数据库系统工具、SQL功能、数据库升级、兼容B库模块等功能测试 |
| 60 |  LLVM多版本实现   | <font color=green> █  </font> | <font color=green>█</font> |     |     | 继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。|
| 61 |  新增密码套件openHiTLS  | <font color=green>   </font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试|
| 62 | AI流水线oeDeloy  | <font color=green> █  </font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证通过oeDeploy进行kubeflow部署及k8s基础功能测试  |
| 63 | 支持epkg新型软件包及包管理器   | <font color=green> █  </font> | <font color=green></font> |     |     |  继承已有测试能力，重点验证epkg包构建，输出epkg软件包以及包管理器实现环境创建，多版本运行等功能|
| 64 | 支持oeaware   | <font color=green> █  </font> | <font color=green></font> |     |   |继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容  |
| 65 |  DevStation 开发者工作站支持        | <font color=green> █  </font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证安装部署启动、支持图形化编程环境，以及融合的epkg、Eulercopilot、x2openEuler的基本功能|
| 66 |  AI集群慢节点快速发现 Add Fail-slow Detection  | <font color=green> █  </font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度  |
| 67 | RPM国密签名支持  | <font color=green> █  </font> | <font color=green>█</font> |     |     | 重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容 |
| 68 | 鲲鹏KAE加速器驱动安装包合入   | <font color=green>  </font> | <font color=green></font> |     |     | 继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩  |
| 69 | Add Intel QAT packages support   | <font color=green> █  </font> | <font color=green></font> |     |     |  继承已有测试能力，重点验证intel qat相关软件包的功能和性能|
| 70 | 版本引入ACPO包  | <font color=green> █  </font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容 |
| 71 |  内核TCP/IP协议栈支持CAQM拥塞  | <font color=green> █  </font> | <font color=green></font> |     |     | 继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能 |
| 72 |  支持树莓派  | <font color=green> █  </font> | <font color=green></font> |     |     | 继承已有测试能力，对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性等测试|




<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价


对新需求进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **aarch64/x86_64质量评估**    |  **risc-v质量评估**    |   **loongarch质量评估**    |  **powerpc质量评估**    | **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | ---------------- | ---------------- | ---------------- | -------------- | -------------------------- | -------- |
|  1 | [virtCCA机密虚机相关特性合入版本](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 24.03-LTS-SP2版本未发布，计划7月份update版本合入 |  |  | <font color=green></font> |  | | | |
|  2 | [OVMF_CODE.fd支持CSV1/2/3开箱即用](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | OVMF_CODE.fd支持海光CSV1/2/3机密虚拟机开箱即用特性，共计执行8个用例：主要包括4项功能测试，4项稳定性测试，3项分压力测试,测试通过未发现问题 |  |  | <font color=green>█</font> |  | | | |
|  3 | [OVMF.fd支持CSV1/2/3开箱即用](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | OVMF.fd支持海光CSV1/2/3机密虚拟机开箱即用特性，共执行8个用例：主要包括6项功能测试；以及2项稳定性测试，测试通过未发现问题 |  |  | <font color=green>█</font> |  | | | |
|  4 | [支持CSV1/2/3直通DCU功能开箱即用](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) |  待评审|  |  | <font color=green>█</font> |  | | | |
|  5 | [新的psp/ccp device id支持](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 共计执行31个测试用例，主要覆盖了海光可信功能验证，回归测试通过，无遗留风险，整体质量良好  |  |  | <font color=green>█</font> |  | | | |
|  6 | [可信功能内核驱动剥离sev依赖](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 共计执行31个测试用例，主要覆盖了海光可信功能验证，回归测试通过，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  7 | [海光4号美密支持，sm4-xts,sm4-gcm支持，avx/cis指令集接口支持](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 该特性未合入 |  |  | <font color=green></font> |  | | | |
|  8 | [vTKM 性能优化](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 共计执行4项测试，主要覆盖了普通虚拟机和CSV虚拟机下的TKM功能验证，性能测试验证主要覆盖了内部密钥的SM2签名、SM2解密、SM4。性能分别提升110%、53%、112%。回归测试通过，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  9 | [需要合入bcache的bug fix](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) |  待评审 |  |  | <font color=green></font> | | | | |
|  10 | [对hygon 8h DF PMU的适配](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 未来芯片的基础补丁，无机器测试 |  |  | <font color=green></font> |  | | | |
|  11 | [需要合入海光分支patch和memset的nt patch](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) |  待评审 |  |  | <font color=green></font> |  | | | |
|  12 | [支持树莓派](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 主要覆盖镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成了硬件兼容性测试，包括树莓派 4B/5 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的兼容性验证。以上测试内容均未发现问题                |  |  | <font color=green>█</font> |  | | | |
|  13 | [支持 OpenStack Antelope/Wallaby 版本](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 测试完成，待提交测试报告 |  |  | <font color=green></font> |  | | | |
|  14 | [基于通信算子的低开销高精度慢节点检测](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 覆盖功能、长稳、资料测试，功能覆盖模型数据timeline图转化，数据采集开销验证，分组验证，慢节点分析验证，验证通过；长稳覆盖上百次注入故障后慢节点分析，慢节点检测准确率>90%，验证通过；资料覆盖通信算子慢节点检测说明，验证通过 |  |  | <font color=green>█</font> |  | | | |
|  16 | [DevStation开发流程智能化增强](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 共104个用例，其中执行了84个用例，未执行20个用例，测试了mcp服务的下载、配置及应用，主要覆盖了功能测试、性能测试和可靠性测试，发现问题1个，其中已经回归通过1个 |  |  | <font color=green>█</font> |  | | | |
|  17 | [支持超大虚机规格](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 主要验证SP2版本支持大规格虚拟机特性，共计执行1个用例，主要覆盖功能测试，未发现问题，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  18 | [openEuler Copilot 支持多维度（时间）过滤分析和分权分域，推理高准确率开箱即用](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 共执行用例150个，主要覆盖MCP server框架集成，数据集评估流水线，向量数据库切换openGauss，企业数据多用户管理空间等功能测试，共发现问题29个，已回归通过 |  |  | <font color=green>█</font> |  | | | |
|  19 | [嵌入式北向软件包补齐](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 共执行84条用例，主要覆盖了嵌入式epkg环境管理、包管理，gcc、qemu、docker、k8s、python3.11、systemd，pxe安装等基本功能，回归通过 |  |  | <font color=green>█</font> |  | | | |
|  20 | [epkg新型软件包及包管理器功能增强](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 共执行用例70个，主要测试了createrepo工具、加包工程使用x2epkg生成ubuntu及archlinux转化生成的repo仓、epkg包管理器支持基于reguire等字段进行安装，发现12个问题，已回归通过 |  |  | <font color=green>█</font> |  | | | |
|  21 | [FUSE passthrough支持](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | FUSE内核态优化，性能提升10% 特性，共计执行12个用例，主要覆盖了功能测试和性能测试，稳定性测试48H。未发现问题，整体质量良好，基础功能无质量风险 |  |  | <font color=green>█</font> |  | | | |
|  22 | [oeDeploy工具易用性提升，部署能力增强](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 共执行用例60条，主要覆盖了oedp插件一键部署，MCP服务调用，自定义插件开发、多master的k8s集群部署等工程以及可靠性测试，共发现6个问题，均已回归通过 |  |  | <font color=green>█</font> |  | | | |
|  23 | [基于eBPF等技术实现AI作业进程Stack Mergeing，支持典型内存故障定位](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 主要覆盖功能测试，功能覆盖模型内存timeline图转化、内存堆栈转化，可以在网页上正确显示火焰图和时间线，验证通过 |  |  | <font color=green>█</font> |  | | | |
|  24 | [虚拟化场景支持vKAE直通设备热迁移](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 覆盖功能、性能、资料测试，功能覆盖vKAE直通虚拟机热迁移验证，验证通过；性能覆盖vKAE直通虚拟机热迁移中断时间验证，验证通过；资料覆盖新增vKAE直通虚拟机热迁移说明，验证通过 |  |  | <font color=green>█</font> |  | | | |
|  25 | [secGear支持机密虚机基于UEFI启动方式的报告生成及验证](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | secGear-UEFI度量启动证明适配：共执行用例19个，设计功能测试和可靠性测试，未发现问题整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  26 | [支持可信计算远程证明服务组件](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 执行了625个用例，涉及基础冒烟测试和ltp测试，在mysql数据库场景下64k性能与4k内核版本持平，未发现问题，未发现问题整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  27 | [支持Kuasar机密容器镜像加解密](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 覆盖功能、可靠性、资料测试。功能覆盖拉取加密镜像并解密，远程证明服务端未托管秘钥或秘钥被篡改，拉取镜像后解密失败；远程证明服务端托管秘钥正确，拉取镜像后解密成功，创建及start机密容器成功；可靠性声明周期、服务稳定性，验证通过，性能覆盖并发测试，验证通过。资料覆盖使用加密镜像创建容器的使用说明，验证通  |  |  | <font color=green>█</font> |  | | | |
|  28 | [支持众核高密容器级资源隔离技术](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP2/release-plan.md) | 测试众核调度对计算密集型与IO密集型业务服务QPS的影响，在部署密度提升超过10%的情况下业务性能良好无劣化。 |  |  | <font color=green>█</font> |  | | | |




<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1 南向兼容性

整机
| **机型** | **CPU**  | **测试结果**|
|--------------|---------------|-------|
| Taishan200   | kunpeng 920 |  pass   |
| 2288H V5   | cascade | pass  |


板卡

| **板卡类型**   | **测试主体**   | **chipModel**     | **boardModel**      | **aarch64架构测试结果** | **x86_64架构测试结果** | **risc-v架构测试结果** | **loongarch架构测试结果** | **powerpc架构测试结果** | 
| ----------  | -------------- | ------------------ | ------------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| DPU                | sig-Compatibility |       kmod-dinghai          | kmod-dinghai            |    pass      |     pass     |
| FC         | sig-Compatibility |         |          |                    |              |
|   |  | ISP2532       |  QLE2560    |   pass    |    pass      |
|   |  |  ISP2812      |    QLE2770/QLE2772/QLE2870/QLE2872      |    pass     |   pass   |
|   |  | ISP2722       |   QLE2690/QLE2692/QLE2740/QLE2742       |     pass     |    pass      |
|   |  | LPe31000/LPe32000   | LPe32002-M2  |   pass  |  pass  |
|   |  | LPe35000/LPe36000   | LPE36002-M64  |   pass  |  pass  |
| GPU        | sig-Compatibility |     |                    |                    |              |
|   |  | GV100GL       | Tesla V100   |   pass     |    pass      |
|   |  | TU104GL       | Tesla T4     |   pass     |    pass      |
|   |  | GA100         | Tesla A100   |   pass     |    pass      |
| RAID           | sig-Compatibility |                |                    |                   |         |
|   |  | Aries  | 3S585/3S5A5/3S590     |    pass      |    pass     |
|   |  | Aries  | 3S520/3S530/3S540     |    pass      |    pass     |
|   |  | SAS3908  | 9560-8i    |    pass      |    pass     |
| NIC        | sig-Compatibility |       |     |              |             |
|   |  | Hi1822            | SP580             |    pass      |    pass     |
|   |  | Hi1822（Hi1823）  | SP670             |     pass     |     pass    |    
|   |  | E810-XXV          | E810-XXV-2        |    pass     |     pass     |
|   |  | 82599ES           | SP310             |    pass     |     pass     |
|   |  | I350              | I350-F2           |    pass     |     pass     |
|   |  | ConnectX-6 DX     | MCX623106AN-CDAT  | pass|pass
|   |  | ConnectX-5        | SP382             |    pass     |     pass     |
|   |  | ConnectX-6     | MCX653105A-EFAT             |    pass     |     pass     |
|   |  |    ConnectX-5         |   SP350/MCX555A-ECAT     |    pass   |   pass           |
|   |  |    Gemini         |   3S910/3S920/3S930     |    pass         |    pass      |


​	



### 4.2.2 虚机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 |
| ---------- | ----------------------- | ------- | -------- |
| openEuler 24.03 LTS SP2 | Centos 6 | x86_64 | PASS |
| openEuler 24.03 LTS SP2 | Centos 7 | aarch64 | PASS |
| openEuler 24.03 LTS SP2 | Centos 7 | x86_64  | PASS |
| openEuler 24.03 LTS SP2 | Centos 8 | aarch64 | PASS |
| openEuler 24.03 LTS SP2 | Centos 8 | x86_64  | PASS |
| openEuler 24.03 LTS SP2  | Windows Server 2016 | x86_64  | PASS |
| openEuler 24.03 LTS SP2  | Windows Server 2019 | x86_64  | PASS |
| openEuler RISC-V 24.03 LTS SP2 | Ubuntu 24.04 | riscv64 | PASS |

## 4.3   专项测试结论

### 4.3.1 安全测试

24.03-LTS-SP2版本测试阶段完成了安全测试，包括病毒扫描、安全编译选项扫描、安全片段引用扫描、开源license合规检查、签名和完整性性校验、SBOM校验；测试发现的主要问题都得到了修正，回归测试结果正常。

1、病毒扫描：对于产品提供的镜像中的aarch64架构与x86_64架构rpm软件包，使用majun平台病毒扫描工具进行在线扫描分析，扫描结果中未出现病毒报警，无风险

2、开源漏洞评估：对于产品提供的标准镜像中的aarch64架构与x86_64架构中的baseos范围内rpm软件包，使用majun平台的漏洞视图进行漏洞评估，对于识别出的CVE进行分析，总共感知漏洞6591个，待办中的漏洞829个，经过分析评估，无风险503个，为本次版本分支24.03-LTS-SP2不受影响或此分支已修复漏洞，61个低分别漏洞未在修复期间内修复，能修尽修，未能修复的在update版本处理，低风险265个，为7分以下的CVE漏洞，且漏洞发现时间为一个月内，还在修复周期中，风险可控，后续持续跟踪解决。

3、安全编译选项扫描：对于产品提供的标准镜像中的aarch64架构与x86_64架构中的rpm软件包，使用majun平台二进制扫描工具扫描安全编译选项，对于baseos软件包范围内的扫描结果未实行必选安全编译选项的项进行确认(包括NX、SP、RELRPO、BIND_NOW、NO Rpath、PIE、Strip)，所有问题均已修复或评估，无风险

4、安全测试基线用例测试：对于产品提供的标准镜像，通过openscap用例测试，对于镜像中的初始部署、安全访问、运行与服务、日志审计等方面进行测试，对于测试结果进行分析，未发现问题，无风险；对于产品提供的标准镜像，通过威胁分析与安全红线用例测试，对于镜像中的文件系统、安全访问、运行与服务、日志审计等方面进行测试，对于测试结果进行分析，未发现问题，无风险

5、开源片段引用扫描：目前对于openeler社区孵化的70个软件包仓库，使用majun平台的开源片段扫描工具扫描，对于扫描结果中识别出的片段引用进行分析，所有问题均已修复或评估，无风险

6、开源合规license检查：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，验证了46295个rpm软件包，共有123个rpm软件包的license不在openEuler合规license准入列表中，其中，已经审阅并评审修复通过123个rpm软件包的license。

7、签名和完整性校验：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，使用shell命令对46295个rpm软件包进行了签名完整性校验，所有rpm包均有签名且具有一致性；对于产品提供的aarch64架构、x86_64架构中的所有iso镜像，6个iso镜像均具有sha256sum签名文件。

8、SBOM校验：对于产品提供的aarch64架构、x86_64架构，2种架构的iso镜像均具有SBOM文件及SBOM文件签名

整体OS安全测试较充分，主要问题均已解决，回归测试正常，整体质量良好，风险可控，详细测试内容见安全专项测试报告。

### 4.3.2 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                                                    |
| ------------ | ------------------------------------------------------------ | ----------------------------------------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况；稳定性测试时长7\*24 |通过 |

### 4.3.3 性能测试


| **指标大项** | **指标小项**                                                                               | **指标值**              | **测试结论**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 与基线版本（24.03-LTS）对比不劣化5%以内目标已达成 |

### 4.3.4 资料测试

| **手册名称** | **覆盖策略** | **中英文测试策略** | Arm/X86测试结果  | RISC-V测试结果 | LoongArch测试结果 | PowerPC测试结果 |
| ------ | ------------------ | ---- | ---- | ------ | --------- | ------- |
| DDE安装指南 | 安装步骤的准确性及DDE桌面系统是否能成功安装启动  | 英文描述的准确性   | pass   | pass |       |           |
| UKUI安装指南 | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动| 英文描述的准确性   | pass   | pass |       |           |
| KIRAN安装指南 | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动 | 英文描述的准确性   | pass   | pass |       |           |
| 树莓派安装指导 | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   | pass    |   |      |           |
| 安装指南  | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    | pass |    |           |
| 管理员指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass    | pass |  |           |
| 安全加固指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    |    |      |           |
| 虚拟化用户指南   | 文档描述与版本的行为是否一致  | 英文描述的准确性   | pass    |    |      |           |
| StratoVirt用户指南  | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass  |   |     |           |
| 容器用户指南   | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   | pass |      |           |
| A-Tune用户指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   |    |     |           |
| oeAware用户指南   | 文档描述与版本的行为是否一致  | 英文描述的准确性   | pass   |     |      |           |
| 应用开发指南  | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   | pass |     |           |
| 工具集用户指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   |    |      |           |
| HA的安装部署 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | pass    |    |    |           |
| HA的使用实例  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | pass    |     |       |           |
| K8S安装指导| 文档描述与版本的行为是否一致| 英文描述的准确性   | pass    |     |       |           |
| OpenStack安装指导| 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    |     |    |           |
| A-ops用户指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   |    |     |           |
| Gazelle用户指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   |    |      |           |
| openEuler Embedded用户指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass    |    |     |           |
| UniProton用户指南| 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   | pass |   |           |
| GCC for openEuler用户指南| 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   | pass |     |           |
| NestOS用户指南| 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    |    |   |           |
| EulerCopilot 智能问答用户指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   |    |    |           |

# 5   问题单统计

openEuler 24.03-LTS-SP2版本共发现问题519个，有效问题498个，其中遗留问题 3 个，详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 
| --------------------------- | -------- | ------------ | ------------ | ------------ | 
| openEuler 24.03 LTS next before SP2|  183  |    174   |  9  |   0  | 
| openEuler 24.03 LTS SP2  alpha      | 53  |  53   |  0  |   0    |
| openEuler 24.03 LTS SP2  RC1        | 71   |  71   | 0  |  1     | 
| openEuler 24.03 LTS SP2  RC2        | 18    |    18   | 0   |   0    | 
| openEuler 24.03 LTS SP2  RC3        | 29   |  28 |  1  |  0   |
| openEuler 24.03 LTS SP2  RC4        | 20   |  17    |  3  |   1    | 
| openEuler 24.03 LTS SP2  RC5        | 38   |   37    | 1  |  0   |
| openEuler 24.03 LTS SP2 RC6        |  30  |  27    |  3 |   0   | 
| openEuler 24.03 LTS SP2 RC7        |  72  |  68    |  4 |   0   | 
| openEuler 24.03 LTS SP2 RC8        |  4  |  4    |  0 |   0   | 
| openEuler 24.03 LTS SP2 RC9        |  1  |  1    |  0 |   1   | 

# 6 版本测试过程评估

#### 6.1 问题单分析


本次版本测试各迭代从RC1到RC9，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求。社区有效issue共计498个，新增issue总体趋势下降, 符合质量预期，风险可控

各阶段问题分析：
1.	beforeSP2里程碑为24.03-lts-sp2分支正式拉出之前为提前识别next分支构建问题和因软件包未同步更新导致的降级问题；共174个有效issue，其中构建问题95，降级问题83，符合预期 
2.	Alpha属于开发自验证轮次，测试未提前介入，仍为构建阶段发现问题，这些问题大部分已在next分支提前识别，属于MOE重复提交，后续针对版本里程碑提交issue做明确要求和整改 
3.	RC1-RC3主要测试活动为OS通用场景和各专项测试，发现问题50+；需求测试发现问题15+；另外安全专项扫描发现安全编译选项问题10+ 
4.	RC4-RC5 oeaware、epkg、编译器、智能交付平台等需求发现问题较多，后续组织专题回溯分析转测质量，推进前端改进。 
5.	RC6需求需求测试发现问题20+，RC7少量需求发现问题，60+为intelligence项目为实现rpm安装部署服务在构建阶段需要引入大量python依赖包发现的问题 

改进点：
1.	alpha阶段问题数量异常，构建失败问题大都可以已在next分支提前识别，属于MOE重复提交，后续针对版本里程碑提交issue做明确要求和整改 
2.	oeaware、epkg、编译器、智能交付平台等需求发现问题较多，后续组织专题回溯分析转测质量，推进前端改进 
4.	RC7阶段问题数量异常，RC7问题上升主要是epol仓库出现批量软件包构建失败问题，原因为intelligence项目需要构建大量软件包以支持通过rpm形式安装部署AI服务， 为前期未识别到本地构建和eulermaker构建方式差异以及人力冲突原因导致问题滞后发现，需组织AAR回溯改进

。


#### 6.2 OS集成测试迭代版本基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 24.03 LTS SP2 RC1 | 冒烟测试         |                                |
|                             | 包管理专项       | 软件包安装卸载                     |
|                             |                | 自编译                      |
|                             | 安全专项      |        |
|                             | 性能专项      |        |
|                             | 安装部署         | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像x86物理机 |
|                             |                 | 标准镜像x86虚拟机 |
|                             |                 | 标准镜像PXE安装                |
|                             |                 | 标准镜像U盘安装                |
|                             |                 | everything镜像PXE安装                |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             |                 | 边缘镜像     | 
|                             | 单包             | 单包命令            |
|                             |                 ｜ 单包服务            |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                       |
|                             |                  | 安全测试                       |
| openEuler 24.03 LTS SP2 RC2   | 冒烟测试         |                                |
|                             | 包管理专项         | 软件包升降级                     |
|                             | 性能专项         |                    |
|                             | 安装部署         | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像x86虚拟机 |
|                             |                 | 标准镜像PXE安装                |
|                             |                 | 标准镜像U盘安装                |
|                             |                 | stratovirt镜像x86虚拟机                 |
|                             | 单包           | 单包命令             |
|                             |               | 单包服务             |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 编译器专项       | gcc测试                        |
| openEuler 24.03 LTS SP2 RC3 | 冒烟测试         |                                |
|                             | 包管理专项       |                     |
|                             |                | 自编译                      |
|                             | 重启专项专项     |  冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             |                  | 新增重启专项                       |
|                             | 虚拟机兼容性         |                      |
|                             | 性能专项         |                    |
|                             | 安装部署         |  |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像x86物理机 |
|                             |                 | 标准镜像PXE安装                |
|                             |                 | everything镜像PXE安装                |
| openEuler 24.03 LTS SP2 RC4 | 冒烟测试         |                                |
|                             | 包管理专项       |  软件包安装卸载      |
|                             |                  | source包自编译 |
|                             | 文件系统     |                                |
|                             | 网络系统     |                                |
|                             | 安全专项         |                     |
|                             | 性能专项         |                   |
|                             | 安装部署         | 标准镜像aarch64虚拟机                       |
|                             |                  | 标准镜像x86虚拟机                       |
|                             |                  | 标准镜像u盘安装                 |
|                             |                 | stratovirt镜像x86虚拟机                 |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             | 单包            | 单包命令             |
|                             |                 | 单包服务             |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             |                  | 长稳测试                  |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 编译器专项       | gcc测试                        |
| openEuler 24.03 LTS SP2 RC5 | 冒烟测试         |                                |
|                             | 包管理专项       | 软件包安装卸载      |
|                             |                 | 软件包升降级      |
|                             |                 ｜ 自编译           |
|                             | 安全专项         |                |
|                             | 操作系统默认参数对比       |                       |
|                             | 性能专项         |                   |
|                             | 安装部署         |  |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像x86物理机 |
|                             |                 | 标准镜像PXE安装                |
|                             |                 | everything镜像PXE安装                |
|                             |                 | 边缘镜像     | 
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 单包            | 单包命令             |
|                             |                 | 单包服务             |
|                             | 编译器专项       | gcc测试                        |
| openEuler 24.03 LTS SP2 RC6     | 冒烟测试         |                                |
|                             | 包管理专项       | 增量      |
|                             |                 | 软件包安装卸载      |
|                             |                 | 软件包升降级      |
|                             | 重启专项专项     |                           |
|                             | 性能专项         |                   |
|                             | 单包            | 增量             |
|                             |                 | 单包命令             |
|                             |                 | 单包服务             |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             |                  | 长稳测试                  |
|                             | 编译器专项       | gcc测试                         |
| openEuler 24.03 LTS SP2 RC7     |    冒烟测试   |                    |
|                             | 包管理专项       |      |
|                             |                ｜ 自编译  |
|                             | 性能专项         |  
|                             | 重启专项专项     |  冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             |                  | 新增重启专项                       |                 |                |
 openEuler 24.03 LTS SP2 RC8    |    冒烟测试   |                    |
|                             | 回归测试       | 问题单回归                        |
 openEuler 24.03 LTS SP2 RC9     |    冒烟测试   |                    |
|                             | 回归测试       | 问题单回归                        |
|                             | release发布件测试      | release发布件测试                        |
|                             | 发布件sha256值校验       | 发布件sha256值校验                        |



# 7   附件

## 遗留问题列表

|序号|问题单号|问题简述|问题级别|影响分析|规避措施|
| ---- | ---- | ------------- | ----| ------ | ----| 
| 1 | IC4B9Y | 插入einj ko失败 | 主要| EINJ（Error INJection）功能是一种硬件错误注入机制，主要用于测试系统对硬件错误的容错能力和可靠性。其核心目的是通过模拟硬件错误，验证系统软件的错误检测、恢复和日志记录能力。6.6内核新增特性会在启动阶段预留GIC*寄存器区域，由于cpld未适配EINJ功能，当前EINJ模块初始化申请的地址与GICD预留区域冲突，导致einj.ko插入失败 | 升级CPLD版本，已通过调测版本验证功能正常，待出正式版本后关闭问题单
| 2 | IC87FW | 【openEuler-24.03-LTS-SP2-rc4】【arm】创建虚拟机成功之后，/var/log/messages中存在报错：“jitterentropy: Initialization failed with host not compliant with requirements: 9” | 次要 | 当前环境fips未打开，即使jitterentropy初始化失败，不影响随机数算法使用  | 1、出厂默认FIPS不打开：内核模式加密算法联邦信息处理标准（FIPS）算法支持SHA-1、DES、3DES和一个随机数发生器，打开是对安全要求很高的场景，必须硬件产生随机数种子，GRBG随机数算法会调用jitterentropy。2、使用/dev/radom可以实现一样的功能,这个才是主流用法 |
| 3 | IC4B9Y | 安装完成后窗口主题不对，需进个性化手动切换主题 | 次要 | 用户进入图形的默认窗口主题存在问题，显示异常  | 用户登录后，进个性化手动切换一下深浅色，后续都会正常 | 


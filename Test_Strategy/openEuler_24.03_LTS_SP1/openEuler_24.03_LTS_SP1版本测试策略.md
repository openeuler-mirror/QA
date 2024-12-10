![openEuler ico](../../images/openEuler.png)

版权所有 © 2024 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期      | 修订版本 | 修改  章节 | 修改描述 | 作者        |
| --------- | -------- | ---------- | -------- | ----------- |
| 2024-11-22 | 1.0.0    |            | 初稿     | linqian0322 |
| 2024-12-04 | 1.0.1 | | add RISC-V | jean9823 |


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

openEuler LTS SP 测试策略

Abstract 摘要：

本文是openEuler 24.03 LTS SP1版本的整体测试策略，用于指导该版本后续测试活动的开展。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长周期维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 24.03 LTS SP1版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 24.03 LTS SP1是基于6.6内核24.03 LTS的增强扩展版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 24.03 LTS-Next分支拉出，发布范围相较24.03 LTS版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP1/release-change.yaml)
2.  修复bug和cve

## 需求范围

openEuler 24.03 LTS SP1版本交付[需求列表](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md)如下：

| no   | feature | status | sig  | owner |
| :--- | :------ | :----- | :--- | :---- |
| [IASH0C](https://gitee.com/openeuler/release-management/issues/IASH0C) | wine5.5升级到wine9.17，不需要linux32依赖库情况下支持win32程序|Discussion|sig-compat-winapp|[@itisyang](https://gitee.com/itisyang)|
| [IATGD8](https://gitee.com/openeuler/release-management/issues/IATGD8) | Add compatibility patches for Zhaoxin processors | Discussion | kernel            | [leoliu-oc](https://gitee.com/leoliu-oc) |
| [IAUPHP](https://gitee.com/openeuler/release-management/issues/IAUPHP) | virtCCA机密虚机特性合入|Discussion|SIG-Kernel/SIG-Virt|[@luoyukai](https://gitee.com/luoyukai)|
| [IATGD8](https://gitee.com/openeuler/release-management/issues/IAW0BK) | Add Intel QAT packages support | Discussion |sig-Intel-Arch| [@allen-shi](https://gitee.com/allen-shi) |
| [IAYKG8](https://gitee.com/openeuler/release-management/issues/IAYKG8) | 支持plasma5桌面环境 | Discussion |sig-KDE| [@tangjie02](https://gitee.com/tangjie02) |
| [IAZNCN](https://gitee.com/openeuler/release-management/issues/IAZNCN) | 增加YouQu自动化测试平台支持 | Discussion |sig-QA| [@mikigo](https://gitee.com/mikigo) |
| [IAZNA8](https://gitee.com/openeuler/release-management/issues/IAZNA8) | 增加migration-tools支持 | Discussion |sig-migration| [@xingwei-liu](https://gitee.com/xingwei-liu/) |
| [IAZN8U](https://gitee.com/openeuler/release-management/issues/IAZN8U?from=project-issue) | 增加 utsudo 支持 | Discussion |sig-memsafety| [@wangmengc](https://gitee.com/wangmengc/) |
| [IAZN7K](https://gitee.com/openeuler/release-management/issues/IAZN7K?from=project-issue) | 增加 utshell支持 | Discussion |sig-memsafety| [@ut-wanglujun](https://gitee.com/ut-wanglujun) |
| [IAZN4N](https://gitee.com/openeuler/release-management/issues/IAZN4N?from=project-issue) | 增加DDE支持                                                  | Discussion |sig-DDE| [@ut-layne-yang](https://gitee.com/ut-layne-yang) |
| [IAYGKY](https://gitee.com/openeuler/kernel/issues/IAYGKY) | 海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核） | Developing |sig-kernel| [@hanliyang](https://gitee.com/hanliyang) |
| [IAZ4SZ](https://gitee.com/openeuler/release-management/issues/IAZ4SZ) | enable the SEV-SNP | Discussion |kernel| [@kile2009](https://gitee.com/kile2009) |
| [IB23QK](https://gitee.com/openeuler/release-management/issues/IB23QK) | 集成openGauss 6.0.0 LTS企业版 | Discussion |DB| [@hengliue](https://gitee.com/hengliue) , [@totaj](https://gitee.com/totaj) |
| [IAZOCV](https://gitee.com/openeuler/release-management/issues/IAZOCV) | LLVM多版本实现 | Discussion | sig-Compiler | [@eastb233](https://gitee.com/eastb233) |
| [IAWKJV](https://gitee.com/openeuler/release-management/issues/IAWKJV) | 支持树莓派 | Discussion | SIG-SBC | [@woqidaideshi](https://gitee.com/woqidaideshi/) |
| [IAZOCV](https://gitee.com/openeuler/release-management/issues/IB0JOU) | 新增密码套件openHiTLS | Discussion | sig-security-facility | [@xuhuiyue](https://gitee.com/xuhuiyue) |
| [IB43SI](https://gitee.com/openeuler/release-management/issues/IB43SI?from=project-issue) | AI流水线oeDeloy 提升kubeflow部署效率 | Discussion | cicd-sig | [@superninesun](https://gitee.com/superninesun) |
| [IB43MJ](https://gitee.com/openeuler/release-management/issues/IB43SI?from=project-issue) | iSula支持NRI插件式扩展（继承） | Discussion | sig-iSulad | [@xuxuepeng](https://gitee.com/xuxuepeng) |
|[IB43D0](https://gitee.com/openeuler/release-management/issues/IB43D0?from=project-issue)| epkg新型软件包及包管理器功能增强 | Discussion | cicd-sig | [@duan_pj](https://gitee.com/duan_pj) |
|[IB43AM](https://gitee.com/openeuler/release-management/issues/IB43AM?from=project-issue)| oeAware采集、调优插件等功能增强 | Discussion | A-Tune sig | [@Lostwayzxc](https://gitee.com/Lostwayzxc) |
|[IB433E](https://gitee.com/openeuler/release-management/issues/IB433E?from=project-issue)| Gazelle特性增强 | Discussion | A-Tune sig | [@nlgwcy](https://gitee.com/nlgwcy) |
|[IB431M](https://gitee.com/openeuler/release-management/issues/IB431M?from=project-issue)| syscare热补丁特性增强（继承） | Discussion | sig-ops | [@luanjianhai](https://gitee.com/luanjianhai) |
|[IB430C](https://gitee.com/openeuler/release-management/issues/IB430C?from=project-issue)| secGear功能优化（继承）| Discussion | sig-confidential-computing | [@houmingyong](https://gitee.com/houmingyong) |
|[IB42WR](https://gitee.com/openeuler/release-management/issues/IB42WR?from=project-issue)| 微服务性能问题分钟级定界/定位（TCP，IO，调度等）继承） | Discussion | A-OPS sig | [@yangyongguang](https://gitee.com/yangyongguang) |
|[IB42TS](https://gitee.com/openeuler/release-management/issues/IB42TS?from=project-issue)| 容器干扰检测，分钟级完成业务干扰源（CPU/IO）识别与干扰源发现（继承） | Discussion | sig-ops| [@wo_cow](https://gitee.com/wo_cow) |
|[IB42PR](https://gitee.com/openeuler/release-management/issues/IB42PR?from=project-issue)| DevStation 开发者工作站支持(继承) | Discussion | desktop sig | [@superninesun](https://gitee.com/superninesun) |
|[IB42MO](https://gitee.com/openeuler/release-management/issues/IB42MO?from=project-issue)| AI集群慢节点快速发现 Add Fail-slow Detection | Discussion | desktop sig | [@webankto](https://gitee.com/webankto) |
|[IB42M9](https://gitee.com/openeuler/release-management/issues/IB42M9?from=project-issue)| KubeOS支持集群参数统一配置、镜像定制化和静态完整性保护 | Discussion | SIG-CloudNative-KubeOS| [@liyuanr](https://gitee.com/liyuanr) |
|[IB42HF](https://gitee.com/openeuler/release-management/issues/IB42HF?from=project-issue)| rubik在离线混部调度协同增强 | Discussion | SIG-CloudNative-KubeOS| [@jingwoo](https://gitee.com/jingwoo) |
|[IB3ZVI](https://gitee.com/openeuler/release-management/issues/IB3ZVI?from=project-issue)| 提供GCC-14的多版本编译工具链 | Discussion | sig-Compiler | [@wangding16](https://gitee.com/wangding16) |
|[IB3ZRQ](https://gitee.com/openeuler/release-management/issues/IB3ZRQ?from=project-issue)| AI4C编译选项调优和AI编译优化提升典型应用性能 | Discussion | sig-Compiler | [@wangding16](https://gitee.com/wangding16) |
|[IB3ZL2](https://gitee.com/openeuler/release-management/issues/IB3ZL2?from=project-issue)| GCC结合sysboost实现无感知使能反馈优化 | Discussion | sig-Compiler | [@wangding16](https://gitee.com/wangding16) |
|[IB3ZG8](https://gitee.com/openeuler/release-management/issues/IB3ZG8?from=project-issue)| RPM国密签名支持 | Discussion | sig-security-facility| [@zhujianwei001](https://gitee.com/zhujianwei001) |
|[IB3ZDN](https://gitee.com/openeuler/release-management/issues/IB3ZDN?from=project-issue)| IMA度量通过异构可信根框架使能TPM/virtCCA信任根 | Discussion | sig-security-facility| [@zhujianwei001](https://gitee.com/zhujianwei001) |
|[IB3ZB1](https://gitee.com/openeuler/release-management/issues/IB3ZB1?from=project-issue)| IMA完整性保护增强，支持对解释器运行的脚本类应用程序使能完整性保护机制 | Discussion | sig-security-facility| [@zhujianwei001](https://gitee.com/zhujianwei001) |
|[IB3X9W](https://gitee.com/openeuler/release-management/issues/IB3X9W?from=project-issue)| 鲲鹏KAE加速器驱动安装包合入 | Discussion | sig-Kernel| [@H_jianmin](https://gitee.com/H_jianmin) |
|[IAZQYW](https://gitee.com/openeuler/release-management/issues/IAZQYW?from=project-issue)| Add OpenVINO packages native support | Discussion | sig-Intel-Arch/sig-intelligence| [@juntianlinux](https://gitee.com/juntianlinux) |
|[IAZQXO](https://gitee.com/openeuler/release-management/issues/IAZQXO?from=project-issue)| Add oneAPI low level native support | Discussion | sig-Intel-Arch/sig-intelligenc| [@juntianlinux](https://gitee.com/juntianlinux) |
|[IB5AK4](https://gitee.com/openeuler/release-management/issues/IB5AK4) | 版本引入ACPO包 | Discussion | sig-Compiler | [@eastb233](https://gitee.com/eastb233) |
|[IAJSGA](https://gitee.com/openeuler/release-management/issues/IAJSGA) | 内核TCP/IP协议栈支持CAQM拥塞 | Developing| sig-Kernel| [@helloworldze](https://gitee.com/helloworldze) |
|[IB4E8P](https://gitee.com/openeuler/release-management/issues/IB4E8P?from=project-issue) | blk-io-hierarchy 特性 | Developing| sig-Kernel| [@hailan94](https://gitee.com/hailan94) |
|[IB742K](https://gitee.com/openeuler/release-management/issues/IB742K?from=project-issue) | 支持virtCCA_KAE特性 | Developing| sig-confidential-computing| [@guangwei-zhou](https://gitee.com/guangwei-zhou) |


# 测试分层策略(*基于继承特性策略刷新*)

本次24.03 LTS SP1版本的具体测试分层策略如下：

| **序号**| **需求**                                              | **开发主体**            | **测试主体**           | **测试分层策略**                                             |
| 序号   | 需求 | 开发主体 | 测试主体  | 测试分层策略 |
| :--- | :--- | :--- | :--- | :--- |
|1| 支持UKUI桌面    | sig-UKUI  | sig-UKUI | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
|2| 支持DDE桌面                                           | sig-DDE | sig-DDE  | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
|3| 支持Kiran桌面     | sig-KIRAN-DESKTOP  | sig-KIRAN-DESKTOP  | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
|4| 支持南向兼容性                                        | sig-Compatibility-Infra | sig-QA | 验证openEuler版本在不同处理器上的可安装和可使用性，覆盖整机兼容性测试和社区集成测试 |
|5|支持北向兼容性                                        | sig-Compatibility-Infra  | sig-QA | 验证openEuler版本上各类开源软件的的构建安装正常              |
|6| 安装部署                                              | sig-OS-Builder| sig-QA  | 验证覆盖裸机/虚机场景下，通过光盘/PXE等安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
|7|内核                                                  | Kernel | Kernel | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
|8|容器(isula/docker/安全容器/系统容器/镜像)             | sig-CloudNative | sig-CloudNative| 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
|9| 虚拟化                                                | Virt| Virt  | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能       |
|10|系统性能自优化组件A-Tune                                            | A-Tune  | A-Tune | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
|11| 支持secPaver                                           | sig-security-facility | sig-QA  | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
|12|支持secGear                                           | sig-confidential-computing   | sig-QA | 关注secGear特性的功能完整性                                  |
|13|发布eggo                                              | sig-CloudNative  | sig-QA  | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
|14|支持kubeOS                                            | sig-CloudNative  | sig-QA | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
|15| 支持etmem                               | Storage   | sig-QA  | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
|16| 支持用户态协议栈gazelle                               | sig-high-performance-network | sig-QA | 关注gazelle高性能用户态协议栈功能                            |
|17| 支持国密算法                                          | sig-security-facility| sig-QA  | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
|18| 支持pod带宽管理oncn-bwm                               | sig-high-performance-network | sig-QAk | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
|19| iSulad                                 | sig-iSulad   | sig-QA  |  覆盖继承功能，重点验证isulad长稳场景                 |
|20| 支持A-OPS                                 | sig-iSulad   | sig-QA  | 重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景                 |
|21| 支持系统运维套件x-diagnosis                           | sig-ops | sig-QA | 覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能  |
|22| 支持自动化热升级组件nvwa                              | sig-ops  | sig-QA    | 覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 |
|23| 支持DPU直连聚合特性dpu-utilities                                   | sig-DPU | sig-DPU  | 验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 |
|24| 支持系统热修复组件syscare                             | sig-ops | sig-QA | 验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力      |
|25| iSula容器镜像构建工具isula-build                      | sig-iSulad   | sig-QA  | 验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 |
|26| 支持进程完整性防护特性DIM                                | sig-security-facility  | sig-security-facility  | 验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 |
|27| 支持入侵检测框架secDetector                           | sig-security-facility | sig-security-facility  | 验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 |
|28| isocut镜像裁剪易用性提升                              | sig-OS-Builder| sig-OS-Builder | 验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 |
|29| 支持devmaster组件                                     | sig-dev-utils  | sig-dev-utils  | 验证devmaster的安装部署、进程配置、客户端工具等使用场景      |
|30|支持TPCM特性                                          | sig-Base-service | sig-Base-service   | 验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 |
|31| 支持sysMaster组件                                     | sig-dev-utils   | sig-dev-utils    | 验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景 |
|32| 支持sysmonitor特性                                    | sig-ops  | sig-QA   | 验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景 |
|33| 支持容器场景在离线混合部署rubik                       | sig-CloudNative | sig-CloudNative | 结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
|34| 支持IMA|   sig-security-facility  | sig-QA | 验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式 |
|35| 支持IMA virtCCA |  sig-security-facility  |  sig-QA  | 验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等  |
|36| 安全启动 |  sig-security-facility  |  sig-QA  | 验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等； |
|37| Kmesh |  sig-ebpf  | sig-QA   | 验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等 |
|38| openEuler安全配置规范框架设计及核心内容构建 |  sig-security-facility  |  sig-QA  | 验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性 |
|39| oemaker |  sig-OS-Builder  |  sig-QA  | 重点验证oemaker在构建工程中功能正常  |
|40| openssl |  sig-security-facility  |  sig-QA  | 验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上 |
|41| sysSentry |  sig-Base-service  |  sig-QA  | 重点关注sysCentry服务和基本命令正常，巡检项和巡检结果正常 |
|42|编译器(gcc/jdk)                                       | Compiler  | sig-QA  | 基于开源测试套对gcc和jdk相关功能进行验证                     |
|43| 支持HA软件                                            | sig-Ha | sig-Ha  | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
|44|支持KubeSphere                                        | sig-K8sDistro | sig-K8sDistro | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
|45| 支持OpenStack Train 和 Wallaby                        | sig-OpenStack | sig-OpenStack  | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能   |
|46| 支持智能运维助手                                     | sig-ops| sig-QA   | 关注智能定位（异常检测、故障诊断）功能、可靠性               |
|47| 支持k3s                                               | sig-K8sDistro| sig-K8sDistro | 验证k3s软件的部署测试过程                                    |
|48| 支持pkgship                                           | sig-EasyLife  | sig-QA | 验证软件包依赖查询、生命周期管理、补丁查询等功能             |
|49|Kunpeng加速引擎                                       | sig-AccLib  | sig-AccLib | 验证对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加速器KAE的基本功能和性能测试 |
|50|migration-tools增加图形化迁移openeuler功能            | sig-Migration| sig-Migration  | 验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 |
|51|发布Nestos-kubernetes-deployer                        | sig-K8sDistro  | sig-K8sDistro  | 验证在NestOS上部署，升级和维护kubernetes集群功能正常         |
|52|支持NestOS                                            | sig-CloudNative | sig-CloudNative | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
|53| 发布PilotGo及其插件特性新版本                         | sig-ops  | sig-QA  | 验证PilotGo支持 topo 图的展示和智能调优能力                  |
|54|社区签名体系建立                                      | sig-security-facility  | sig-security-facility        | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
|55| 智能问答在线服务                                      | sig-A-Tune  | sig-QA   | 验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 |
|56| 增加 AO.space 项目发布                                | sig-RaspberryPi  | sig-RaspberryPi  | 通过软件包和容器镜像验证aospace系统管理程序和服务组件为个人数据提供基础网络访问、安全防护等 |
|57| ZGCLab 发布内核安全增强补丁                           | sig-kernel   | sig-kernel   | 针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 |
|58| oeAware 支持本地网络加速|  sig-A-Tune  |  sig-QA  | 验证使能oeAware支持本地网络加速能力(SMC-D)，提升redis/nginx本地回环网络性能 |
|59| 支持RISC-V                                            | sig-RISC-V | sig-RISC-V  | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
|60|为 RISC-V 架构引入 Penglai TEE 支持                   | sig-RISC-V | sig-RISC-V | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 |
|61| LLVM平行宇宙计划 RISC-V Preview 版本 | sig-RISC-V | sig-RISC-V |验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动 |
|62| 支持embedded                                          | sig-embedded  | sig-embedded  | 验证openEuler embedded的构建镜像和完成嵌入式应用开发能力     |


# 测试分析设计策略

## 新增feature测试设计策略

| *序号*  | *Feature*   | Arm  | X86  | RISC-V | LoongArch | PowerPC |
| ------------| --------------------------------| ---- | ---- | ------ | --------- | ------- |
| [IASH0C](https://gitee.com/openeuler/release-management/issues/IASH0C) | wine5.5升级到wine9.17，不需要linux32依赖库情况下支持win32程序 |    √    | √    |       |           |         |
| [IATGD8](https://gitee.com/openeuler/release-management/issues/IATGD8) | Add compatibility patches for Zhaoxin processors  |    √    | √    |       |          |         |
| [IAUPHP](https://gitee.com/openeuler/release-management/issues/IAUPHP) | virtCCA机密虚机特性合入|    √    |    |       |           |         |
| [IATGD8](https://gitee.com/openeuler/release-management/issues/IAW0BK) | Add Intel QAT packages support | |    √    |     |       |           |
| [IAYKG8](https://gitee.com/openeuler/release-management/issues/IAYKG8) | 支持plasma5桌面环境 |    √    | √    | √ |           |         |
| [IAZNCN](https://gitee.com/openeuler/release-management/issues/IAZNCN) | 增加YouQu自动化测试平台支持 |    √    | √    |       |           |         |
| [IAZNA8](https://gitee.com/openeuler/release-management/issues/IAZNA8) | 增加migration-tools支持 |   √    | √    | √ |           |         |
| [IAZN8U](https://gitee.com/openeuler/release-management/issues/IAZN8U?from=project-issue) | 增加 utsudo 支持 |     √    | √    | √ |           |         |
| [IAZN7K](https://gitee.com/openeuler/release-management/issues/IAZN7K?from=project-issue) | 增加 utshell支持 |     √    | √    | √ |           |         |
| [IAZN4N](https://gitee.com/openeuler/release-management/issues/IAZN4N?from=project-issue) | 增加DDE支持   |     √    | √    | √ |           |         |
| [IAYGKY](https://gitee.com/openeuler/kernel/issues/IAYGKY) | 海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核） | |    √    |     |       |           |
| [IAZ4SZ](https://gitee.com/openeuler/release-management/issues/IAZ4SZ) | enable the SEV-SNP |         | √    |       |           |         |
| [IB23QK](https://gitee.com/openeuler/release-management/issues/IB23QK) | 集成openGauss 6.0.0 LTS企业版 |     √    | √    |      |           |         |
| [IAZOCV](https://gitee.com/openeuler/release-management/issues/IAZOCV) | LLVM多版本实现 |   √    | √    |  |           |         |
| [IAWKJV](https://gitee.com/openeuler/release-management/issues/IAWKJV) | 支持树莓派 |     √    |     |      |           |         |
| [IAZOCV](https://gitee.com/openeuler/release-management/issues/IB0JOU) | 新增密码套件openHiTLS |√  |   √    |    |      |           |
| [IB43SI](https://gitee.com/openeuler/release-management/issues/IB43SI?from=project-issue) | AI流水线oeDeloy 提升kubeflow部署效率 |   √    |     |      |           |         |
| [IB43MJ](https://gitee.com/openeuler/release-management/issues/IB43SI?from=project-issue) | iSula支持NRI插件式扩展（继承） |     √    |     |       |           |         |
|[IB43D0](https://gitee.com/openeuler/release-management/issues/IB43D0?from=project-issue)| epkg新型软件包及包管理器功能增强 |    √    | √    |       |           |         |
|[IB43AM](https://gitee.com/openeuler/release-management/issues/IB43AM?from=project-issue)| oeAware采集、调优插件等功能增强 |    √    | √    |     |           |         |
|[IB433E](https://gitee.com/openeuler/release-management/issues/IB433E?from=project-issue)| Gazelle特性增强 |     √    | √    | √ |           |         |
|[IB431M](https://gitee.com/openeuler/release-management/issues/IB431M?from=project-issue)| syscare热补丁特性增强（继承） |    √    | √    | √ |           |         |
|[IB430C](https://gitee.com/openeuler/release-management/issues/IB430C?from=project-issue)| secGear功能优化（继承）|   √    |    |  |           |         |
|[IB42WR](https://gitee.com/openeuler/release-management/issues/IB42WR?from=project-issue)| 微服务性能问题分钟级定界/定位（TCP，IO，调度等）继承） |   √    | √    |      |           |         |
|[IB42TS](https://gitee.com/openeuler/release-management/issues/IB42TS?from=project-issue)| 容器干扰检测，分钟级完成业务干扰源（CPU/IO）识别与干扰源发现（继承） |    √    | √    | √ |           |         |
|[IB42PR](https://gitee.com/openeuler/release-management/issues/IB42PR?from=project-issue)| DevStation 开发者工作站支持(继承) |    √    | √    |      |           |         |
|[IB42MO](https://gitee.com/openeuler/release-management/issues/IB42MO?from=project-issue)| AI集群慢节点快速发现 Add Fail-slow Detection |    √    | √    | √ |           |         |
|[IB42M9](https://gitee.com/openeuler/release-management/issues/IB42M9?from=project-issue)| KubeOS支持集群参数统一配置、镜像定制化和静态完整性保护 |    √    | √    | √ |           |         |
|[IB42HF](https://gitee.com/openeuler/release-management/issues/IB42HF?from=project-issue)| rubik在离线混部调度协同增强 |   √    | √    |      |           |         |
|[IB3ZVI](https://gitee.com/openeuler/release-management/issues/IB3ZVI?from=project-issue)| 提供GCC-14的多版本编译工具链 |   √    | √    |      |           |         |
|[IB3ZRQ](https://gitee.com/openeuler/release-management/issues/IB3ZRQ?from=project-issue)| AI4C编译选项调优和AI编译优化提升典型应用性能 |    √    | √    |       |           |         |
|[IB3ZL2](https://gitee.com/openeuler/release-management/issues/IB3ZL2?from=project-issue)| GCC结合sysboost实现无感知使能反馈优化 |    √    | √    |       |           |         |
|[IB3ZG8](https://gitee.com/openeuler/release-management/issues/IB3ZG8?from=project-issue)| RPM国密签名支持 |    √    | √    |  |           |         |
|[IB3ZDN](https://gitee.com/openeuler/release-management/issues/IB3ZDN?from=project-issue)| IMA度量通过异构可信根框架使能TPM/virtCCA信任根 |    √    | √    |       |           |         |
|[IB3ZB1](https://gitee.com/openeuler/release-management/issues/IB3ZB1?from=project-issue)| IMA完整性保护增强，支持对解释器运行的脚本类应用程序使能完整性保护机制 | √|    √    | √ |     |           |
|[IB3X9W](https://gitee.com/openeuler/release-management/issues/IB3X9W?from=project-issue)| 鲲鹏KAE加速器驱动安装包合入 |   √    |     |       |           |         |
|[IAZQYW](https://gitee.com/openeuler/release-management/issues/IAZQYW?from=project-issue)| Add OpenVINO packages native support |    √    | √    |      |           |         |
|[IAZQXO](https://gitee.com/openeuler/release-management/issues/IAZQXO?from=project-issue)| Add oneAPI low level native support |   √    | √    |      |           |         |
|[IB5AK4](https://gitee.com/openeuler/release-management/issues/IB5AK4) | 版本引入ACPO包  |   √    | √    | √ |           |         |
|[IAJSGA](https://gitee.com/openeuler/release-management/issues/IAJSGA)| 内核TCP/IP协议栈支持CAQM拥塞 |   √    | √    |      |           |         |
|[IB4E8P](https://gitee.com/openeuler/release-management/issues/IB4E8P?from=project-issue) | blk-io-hierarchy 特性  |   √    | √    |       |           |         |
|[IB742K](https://gitee.com/openeuler/release-management/issues/IB742K?from=project-issue) | 支持virtCCA_KAE特性  |   √    |    |       |           |         |




## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                                          | 策略                                                         | Arm  | X86  | RISC-V | LoongArch | PowerPC |
| ----------------------------------------------------- | ------------------------------------------------------------ | ---- | ---- | ------ | --------- | ------- |
| 支持DDE桌面                                           | 继承已有测试能力，关注DDE桌面系统的安装和基本功能            | √    | √    | √      |           |         |
| 支持UKUI桌面                                          | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           | √    | √    | √      |           |         |
| 支持Kiran桌面                                         | 增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 | √    | √    | √      |           |         |
| 支持南向兼容性                                        | 继承已有测试能力，关注板卡和整机适配的兼容性测试             | √    | √    | √      |           |         |
| 支持北向兼容性                                        | 继承已有测试能力，验证openEuler版本上各类开源软件的的构建安装正常 | √    | √    | √     |           |         |
| 安装部署                                              | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 | √    | √    | √     |           |         |
| 内核                                              | 继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 | √    | √    | √     |           |         |
| 容器(isula/docker/安全容器/系统容器/镜像)             | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 | √    | √    | √      |           |         |
| 虚拟化                                                | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 | √    | √    | ×      |           |         |
| 支持A-Tune                                            | 继承已有测试能力，本次无新增合入，重点关注继承功能验证，如服务/配置检查等。 | √    | √    | ×     |           |         |
| 支持secPaver                                           | 继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    | √    | √    | ×      |           |         |
| 支持secGear                                           | 继承已有测试能力，关注secGear特性的功能完整性，重点关注上次新增合入远程证明框架的功能完整性和准确性。               | √    | √    | ×      |           |         |
| 支持eggo                                              | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 | √    | √    | ×      |           |         |
| 支持kubeOS                                            | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 | √    | √    | ×      |           |         |
| 支持etmem内存分级扩展                                 | 继承已有测试能力，重点验证特性的基本功能和稳定性             | √    | √    | ×      |           |         |
| 支持用户态协议栈gazelle                               | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能      | √    | √    | √     |           |         |
| 支持国密算法                                          | 继承已有测试能力，验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 | √    | √    | √     |           |         |
| 支持pod带宽管理oncn-bwm                               | 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 | √    | √    | ×      |           |         |
| 支持isuald                             | 继承已有测试能力，重点验证isulad长稳场景 | √    | √    | √     |||
| 支持A-OPS                             | 继承已有测试能力，重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景| √    | √    | ×      |||
| 支持系统运维套件x-diagnosis                           | 继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能 | √    | √    | √     |           ||
| 支持自动化热升级组件nvwa                              | 继承已有测试能力，覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 | √    |      | ×      |           |         |
| 支持DPU直连聚合特性dpu-utilities                                   | 继承已有测试能力，验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 | √    | √    | ×      |           |         |
| 支持系统热修复组件syscare                             | 继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力 | √    | √    | √      |           |         |
| iSula容器镜像构建工具isula-build                      | 继承已有测试能力，验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 | √    | √    | √      |           |         |
| 支持进程完整性防护特性                                | 继承已有测试能力，验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 | √    | √    | ×      |           |         |
| 支持入侵检测框架secDetector                           | 继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 | √    | √    | √     |           |         |
| isocut镜像裁剪易用性提升                              | 继承已有测试能力，验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 | √    | √    | ×      | √         |         |
| 支持devmaster组件                                     | 继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景 | √    | √    | ×      |           |         |
| 支持TPCM特性                                          | 继承已有测试用例，验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 | √    |      | ×      |           |         |
| 支持sysMaster组件                                     | 继承已有测试能力，验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景 | √    | √    | √      |           |         |
| 支持sysmonitor特性                                    | 继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景 | √    | √    | √     |           |         |
| 混合部署rubik                                         | 继承已有测试能力，覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化 | √    | √    | ×      |           |         |
| pod带宽管理                              |继承已有测试能力，验证使能/网卡Qos功能，设置cgroup优先级、在线水线、离线带宽等功能，使能网卡QOS功能后，在线业务可实时抢占离线业务带宽，以及功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等。 | √    | √    | ×      |||
| 国密                              |继承已有测试能力，验证SSH协议栈、TLCP协议栈、内核模块签名、安全启动、文件完整性保护、用户身份鉴别、磁盘加密、算法库等模块支持国密算法。 | √    | √    | ×      |||
| DIM                              |继承已有测试能力，验证dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等，用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量，以及度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量。 | √    | √    | √     |||
| 支持IMA自定义证书                             | 继承已有测试能力，验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式。| √    | √    | ×      |||
| 支持IMA virtCCA                             |继承已有测试能力，验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等； | √    | √    | ×      |||
| 安全启动                            | 继承已有测试能力，验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等；| √    | √    | ×      |||
| Kmesh                              | 继承已有测试能力，验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等。| √    | √    | ×      |||
| openEuler安全配置规范框架设计及核心内容构建                             |继承已有测试能力，验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性 | √    | √    | ×      |||
| oemaker                              |继承已有测试能力，在构建工程中保证oemaker功能正常 | √    | √    | √     |||
| openssl                              |继承已有测试能力，验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上 | √    | √    | ×      |||
| sysCentry                             |继承已有测试用例，重点关注sysCentry服务和基本命令正常，巡检项和巡检结果正常 | √    | √    | ×      |||
| 编译器(gcc/jdk)                                       | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   | √    | √    | √      |           |         |
| 支持HA软件                                            | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 | √    | √    | ×      |           |         |
| 支持KubeSphere                                        | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力 | √    | √    | ×      |           |         |
| 支持openstack Train 和 Wallaby                        | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能 | √    | √    | ×      |           |         |
| 支持智能运维助手                                     | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性 | √    | √    | ×      |           |         |
| 支持k3s                                               | 继承已有测试能力，验证k3s软件的部署测试过程                  | √    | √    | ×      |           |         |
| 支持pkgship                                           | 继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能 | √    | √    | ×      |           |         |
| Kunpeng加速引擎                                       | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 | √    | √    | ×      |           |         |
| migration-tools增加图形化迁移openeuler功能            | 继承已有测试能力，验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 | √    | √    | ×      |           |         |
| 发布Nestos-kubernetes-deployer                        | 继承已有测试能力，覆盖在NestOS上部署，升级和维护kubernetes集群功能正常 | √    | √    | ×      |           |         |
| 支持NestOS                                            | 继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 | √    | √    | ×      |           |         |
| 发布PilotGo及其插件特性新版本                         | 继承已有测试能力，验证PilotGo支持 topo 图的展示和智能调优能力 | √    | √    | √     |           |         |
| 社区签名体系建立                                      | 继承已有测试能力，验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性。 | √    | √    | √     |           |         |
| 智能问答在线服务                                      | 继承已有测试能力，验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 | √    | √    | ×      |           |         |
| 增加 AO.space 项目发布                                | 继承已有测试能力，通过软件包和容器镜像验证aospace系统管理程序和服务组件为个人数据提供基础网络访问、安全防护等 | √    | √    | ×      |           |         |
| ZGCLab 发布内核安全增强补丁                           | 继承已有测试能力，针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 | √    |      | ×      |           |         |
| oeAware 支持本地网络加速                                         |   继承已有测试能力，验证使能oeAware支持本地网络加速能力(SMC-D)，提升redis/nginx本地回环网络性能  | √    | √    | ×      |           |         |
| 支持RISC-V                                            | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性 | √    | √    | √      |           |         |
|  LLVM平行宇宙计划 RISC-V Preview 版本                      | 继承已有测试能力，验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动 | x    | x    | √      |           |         |
| 为 RISC-V 架构引入 Penglai TEE 支持                   | 继承已有测试能力，验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 | ×    | ×    | ×     |           |         |
| 支持embedded                                          | 继承已有测试能力，验证openEuler embedded的构建镜像和完成嵌入式应用开发能力 | √    | √    | ×      |           |         |



## 专项测试策略

### 安全测试

[openEuler 24.03 LTS SP1版本安全测试策略]()

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

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                                               | **指标值**              | **说明**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 与基线数据差异小于5%以内可接受 |
| OS场景化性能   | 通过业界性能测试工具，覆盖数据库(mysql)、大数据(Spark、Hive、Hbase)等场景性能测试 |参考版本相应指标基线 | 与基线数据差异小于5%以内可接受 |

### 兼容性测试

#### 南向兼容性

整机

| **机型** | **CPU**  |
|--------------|---------------|
| Taishan200   | kunpeng 920 |
| 2288H V5   | cascade |

板卡

| **板卡类型**   | **测试主体**   | **chipModel**     | **boardModel**      | **aarch64架构测试** | **x86_64架构测试** |
| ----------  | -------------- | ------------------ | ------------------ | ------------ | ------------ |
| RAID                | sig-Compatibility |        SAS3908           | 9560-8i            | √         | √         |
|              |                 | SAS3516              | SP460C-M         |    √    | √         |
|              |                 | 	SAS-3 3108              | SR430C-M            | ×         |  √         |
|              |                 |  SAS3008             | SR130            | √         | √         |
|              |                 |  SAS3408              | SR150-M            | √         | √         |
|              |                 |  SAS3508             | SR450C-M            | √         | √         |
|              |                 |         SAS3408            | 9440-8i           | √         | √         |
|              |                 |    Aries           | 3S580/3S585            | √         | √         |
|              |                 |    Aries           | 3S520/3S530/3S540            | √         | √         |
|              |                 |    B80121           | SP686C            | √         | √         |
|              |                 |    PM8204           | PMC3152            | √         | √         |
| FC         | sig-Compatibility |                |                    |                    |              |
|              |            |ISP2532            | QLE2560            | √         | √         |
|              |                 |      ISP2722         | QLE2690/QLE2692/QLE2740/QLE2742            | √         | √         |
|              |                 |      ISP2812            | QLE2770/QLE2772/QLE2870/QLE2872           | √         | √         |
|              |                 |     LPe31000/LPe32000            | LPe31002-M6            | √         | √         |
| GPU           | sig-Compatibility |                |                    |                    |              |
|              |                   | GV100GL          | Tesla V100       | √         | √         |
|              |                   | TU104GL          | Tesla T4       | √         | √         |
|              |                   | GA100          | Tesla A100       | √         | √         |
| SSD           | sig-Compatibility |                |                    |                    |              |
|              |                   | Hi1812E V100          | ES3600C V5-3200GB       | √         | √         |
| IB      | sig-Compatibility |                |                            |
|              |                 |         ConnectX-6              | MCX653105A-EFAT         | √         | √         |
|              |                 |         ConnectX-5              | SP350         | √         | √         |
| NIC        | sig-Compatibility |                |                    |                    |              |
|              |                 |   Hi1822        | SP580           | √         | √        |
|              |                 |    Hi1822（Hi1823）              | SP680             | √         | √         |
|              |                 |    BCM57414                 | BCM57414           | √         | √         |
|              |                 |     E810-XXV                 | E810-XXV-2            | √         | √         |
|              |                 |       XL710              | XL710-Q2/XL710-Q1      | √         | √        |
|              |                 |     82599ES              | SP310      | √         | √         |
|              |                 |       I350            | I350-F2              | √         | √       |
|              |                 |      ConnectX-5            | SP382               | √         | √         |
|              |                 |      ConnectX-4 LX            | SP380               | √         | √         |
|              |                 |      RP1000            | RP1000P2SFP              | √         | √         |
|              |                 |      RP2000            | RP2000P2SFP               | √         | √         |
|              |                 |      WX1860A2            | SF200T              | √         | √         |
|              |                 |      WX1860AL2            | SF200HT               | √         | √         |
|              |                 |      WX1860A4            | SF400T               | √         | √         |
|              |                 |      WX1860AL4            | SF400HT              | √         | √         |
|              |                 |      M16100            | N1045XS              | √         | √         |
|              |                 |      M18105            | S1055AS 2*25G               | √         | √         |
|              |                 |      Gemini            | 3S910/3S920/3S930               | √         | √         |
|              |                 |      N10            | N10G-X4-QC              | √         | √         |
|              |                 |      N10            | N10G-X2-DC               | √         | √         |
|              |                 |      N500           | N500L-AM4C-QD               | √         | √         |

RISC-V 架构本次南向兼容性测试只做整机适配的测试，整机信息如下：

| **机型** | **CPU**    |
| -------- | ---------- |
| 算能     | 算丰SG2042 |



#### 虚拟化兼容性


| HostOS     | GuestOS (虚拟机)        | x86_64    |  aarch64 | 
| ---------- | ----------------------- | ------- | -------- | 
| openEuler 24.03 LTS SP1  | Centos 6 | √ |  |         
| openEuler 24.03 LTS SP1  | Centos 7 | √| √ |               
| openEuler 24.03 LTS SP1  | Centos 8 | √ | √ |                 
| openEuler 24.03 LTS SP1  | Windows Server 2016 | √  |  |         
| openEuler 24.03 LTS SP1  | Windows Server 2019 | √  |  |         

### 软件包管理专项测试

* 软件版本变更检查：检查前序版本的代码变动是否在当前版本继承，保证代码不漏合。
* 多动态库检查：检查软件是否存在多个版本动态库（存在编译自依赖软件包升级方式不规范）
* 软件包变更检查：对升级到24.03 LTS SP1 版本存在新增、删除、变更的软件包通过x2工具扫描出来，对存在变更的软件包修改测试策略（变更测试用例）

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**                  | **覆盖策略**                                                 | **中英文测试策略** | Arm  | X86  | RISC-V | LoongArch | PowerPC |
| ----------------------------- | ------------------------------------------------------------ | ------------------ | ---- | ---- | ------ | --------- | ------- |
| DDE安装指南                   | 安装步骤的准确性及DDE桌面系统是否能成功安装启动              | 英文描述的准确性   | √    | √    | √      |           |         |
| UKUI安装指南                  | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动             | 英文描述的准确性   | √    | √    | √      |           |         |
| KIRAN安装指南                 | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动            | 英文描述的准确性   | √    | √    | √      |           |         |
| 树莓派安装指导                | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   | √    | √    | ×      |           |         |
| 安装指南                      | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| 管理员指南                    | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| 安全加固指南                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| 虚拟化用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| StratoVirt用户指南            | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| 容器用户指南                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| A-Tune用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| oeAware用户指南               | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| 应用开发指南                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| 工具集用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| HA的安装部署                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| HA的使用实例                  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| OpenStack安装指导             | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| A-ops用户指南                 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| Gazelle用户指南               | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| openEuler Embedded用户指南    | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| UniProton用户指南             | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| GCC for openEuler用户指南     | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | √      |           |         |
| NestOS用户指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |
| EulerCopilot 智能问答用户指南 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | √    | √    | ×      |           |         |


# 测试执行策略

openEuler 24.03 LTS SP1版本按照社区release-manager团队既定的版本计划，共有6轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取1+1+2+1+1的测试方式，即1轮测试提前介入alpha版本，1轮基本功能保障的beta版本，2轮全量+增量的覆盖测试，保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归测试，视情况再预留1轮回归测试。

### 测试计划

openEuler 24.03 LTS SP1版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stage Name                    | Deadline for PR | Begin Time | End Time  | Days | Note                                     |
| ----------------------------- | --------------- | ---------- | --------- | ---- | ---------------------------------------- |
| Collect key features          |        -        | 2024/9/1   | 2024/10/31 | 61 | 版本需求收集                              |
| Change Review 1               |        -        | 2024/10/8  | 2024/10/18 | 11 | Review 软件包变更（升级/退役/淘汰）SP版本尽可能保持版本不变  |
| Herited features              |        -        | 2024/10/8  | 2024/11/1  | 25 | 继承特性合入（Branch前完成合入） |
| Develop                       |        -        | 2024/10/8  | 2024/11/28 | 58 | 新特性开发，合入24.03 LTS Next   |
| Kernel freezing               |        -        | 2024/11/1  | 2024/11/8  | 8  | 内核冻结 |
| Branch 24.03 LTS SP1          |        -        | 2024/11/1  | 2024/11/7  | 10 | 24.03 LTS Next 拉取 24.03 LTS SP1 分支 |
| Build & Alpha                 |        -        | 2024/11/8  | 2024/11/14 | 7  | 新开发特性合入，Alpha版本发布    |
| Test round 1                  |    2024/11/13   | 2024/11/15 | 2024/11/21 | 7  | 24.03 LTS SP1 模块测试           |
| Change Review 2               |        -        | 2024/11/22 | 2024/11/24 | 3  | 发起软件包淘汰评审               |
| Test round 2 (Beta Version)   |    2024/11/20   | 2024/11/22 | 2024/11/28 | 7  | 24.03 LTS SP1 Beta版本发布       |
| Test round 3                  |    2024/11/27   | 2024/11/29 | 2024/12/5  | 7  | 全量验证(全量SIT)                |
| Change Review 3               |        -        | 2024/12/3  | 2024/12/5  | 3  | 分支启动冻结，只允许bug fix      |
| Test round 4                  |    2024/12/4    | 2024/12/6  | 2024/12/12 | 7  | 分支冻结，只允许bug fix          |
| Test round 5                  |    2024/12/11   | 2024/12/13 | 2024/12/19 | 7  | 回归测试                         |
| Test round 6 (预留)           |    2024/12/18   | 2024/12/20 | 2024/12/26 | 7  | 回归测试                         |
| Release Review                |        -        | 2024/12/19 | 2024/12/20 | 2  | 版本发布决策/ Go or No Go        |
| Release preparation           |        -        | 2024/12/27 | 2024/12/28 | 2  | 发布前准备阶段，发布件系统梳理    |
| Release                       |        -        | 2024/12/30 | 2024/12/31 | 2  | 社区Release评审通过正式发布       |


### 测试基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 24.03-LTS-SP1 alpha | 冒烟测试         |                                |
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
| openEuler 24.03-LTS-SP1 RC1   | 冒烟测试         |                                |
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
| openEuler 24.03-LTS-SP1 RC2 | 冒烟测试         |                                |
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
| openEuler 24.03-LTS-SP1 RC3 | 冒烟测试         |                                |
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
| openEuler 24.03-LTS-SP1 RC4 | 冒烟测试         |                                |
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
| openEuler 24.03-LTS-SP1 RC5     | 冒烟测试         |                                |
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
| openEuler 24.03-LTS-SP1 RC6     |    冒烟测试   |                    |
|                             | docker_img测试       |                       |
|                             | 安全专项         | 发布件SBOM文件检查                   |
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
![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2024/12/24 | 1.0.0    | 初稿 | linqian0322 |
| 2024/12/24 | 1.0.1 | add RISC-V | jean9823 |
| 2024/12/25 | 1.0.2   | 刷新测试报告 | linqian0322 |




关键词：

openEuler  DDE iSulad RISC-V utshell utsudo A-Ops etmem KubeOS

摘要：

文本主要描述openEuler 24.03 LTS SP1版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 24.03 LTS SP1版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 24.03 LTS SP1版本是基于6.6内核的增强扩展版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 24.03 LTS-Next分支拉出，发布范围相较24.03 LTS版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP1/release-change.yaml)
2.  修复bug和cve


## 2.1 版本测试计划
openEuler 24.03 LTS SP1版本按照社区release-manager团队的计划，共规划6轮测试，详细的版本信息和测试时间如下表：

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


## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920(支持1.70以上的bios版本)        | OS集成测试     |
| RH2288H V3            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| 算能            | 算丰SG2042 | OS集成测试     |

## 2.3 需求清单

openEuler 24.03 LTS SP1版本交付需求列表如下，详情见[openEuler-24.03-LTS-SP1 release plan](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md)：


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


## 2.4 测试活动分工
 本次版本继承测试活动分工如下：

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
|12|支持secGear                                           | sig-confidential-computing   | sig-QA | 关注secGear特性的功能完整性，包括远程证明基线与策略导入，查询，创建、加解密、边界检查、生成随机数、打印、销毁等特性正常运行                                |
|13|发布eggo                                              | sig-CloudNative  | sig-QA  | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
|14|支持kubeOS                                            | sig-CloudNative  | sig-QA | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
|15| 支持etmem                               | Storage   | sig-QA  | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
|16| 支持用户态协议栈gazelle                               | sig-high-performance-network | sig-QA | 关注gazelle高性能用户态协议栈功能，包括支持ceph,支持DWS，支持单网卡negligible，支持苏移krpc，一键脚本部署等继承功能                           |
|17| 支持国密算法                                          | sig-security-facility| sig-QA  | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
|18| 支持pod带宽管理oncn-bwm                               | sig-high-performance-network | sig-QAk | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
|19| iSulad                                 | sig-iSulad   | sig-QA  |  覆盖继承功能cgroup v2,热升级，健康检查，本地卷，容器生命周期管理，镜像管理，资源管理等，重点验证isulad长稳场景                 |
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
|57| 支持GreatSQL                               | sig-RaspberryPi  | sig-RaspberryPi  | 验证GreatSQL源码编译、RPM安装、二进制包安装、主要功能及性能、稳定性 |
|58| ZGCLab 发布内核安全增强补丁                           | sig-kernel   | sig-kernel   | 针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 |
|59| oeAware 支持本地网络加速|  sig-A-Tune  |  sig-QA  | 验证使能oeAware支持本地网络加速能力(SMC-D)，提升redis/nginx本地回环网络性能 |
|60| 支持RISC-V                                            | sig-RISC-V | sig-RISC-V  | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
|61|为 RISC-V 架构引入 Penglai TEE 支持                   | sig-RISC-V | sig-RISC-V | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 |
|62| LLVM平行宇宙计划 RISC-V Preview 版本 | sig-RISC-V | sig-RISC-V |验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动 |
|63| 支持embedded版本 | sig-embedded | sig-embedded | 继承已有测试能力，验证openEuler embedded的构建镜像和完成嵌入式应用开发能力  |
  
本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试


# 3 版本概要测试结论

   openEuler 24.03 LTS SP1版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 2轮继承特性和新增特性合入测试 + 2轮全量测试 + 2轮回归测试（版本发布验收测试）；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项。测试也提前介入，覆盖冒烟测试、安装部署等基础测试项，部分测试内容较多的专项测试也相应提前；第2、3轮重点聚焦在已合入的新需求测试和继承特性验证; 第3、4轮全量测试开展版本交付的所有特性和各类专项测试；第5、6轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试以及验证问题的修复；最后一轮还包括版本发布验收测试，是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

   openEuler 24.03 LTS SP1版本共发现问题 506 个，有效问题 496 个，无效问题 10 个，遗留问题 3 个，风险可控，版本整体质量良好。


# 4 版本详细测试结论

openEuler 24.03 LTS SP1版本详细测试内容包括：

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
| 4 | 支持南向兼容性  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，关注板卡和整机适配的兼容性测试    |
| 5 | 支持北向兼容性  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证openEuler版本上各类开源软件的的构建安装正常    |
| 6 | 安装部署  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署   |
| 7 | 内核  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内   |
| 8 | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证   |
| 9 | 虚拟化 | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能   |
| 10 | 支持A-Tune  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，本次无新增合入，重点关注继承功能验证，如服务/配置检查等   |
| 11 | 支持secPaver  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，关注secPave特性的基本功能和服务的稳定性   |
| 12 | 支持secGear  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证secGear特性的功能完整性，包括远程证明基线与策略导入，查询，创建、加解密、边界检查、生成随机数、打印、销毁等特性正常运行   |
| 13 | 支持eggo  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性   |
| 14 | 支持kubeOS | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力  |
| 15 | 支持etmem内存分级扩展  | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，重点验证特性的基本功能和稳定性    |
| 16 | 支持用户态协议栈gazelle | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证gazelle高性能用户态协议栈功能，包括支持ceph,支持DWS，支持单网卡negligible，支持苏移krpc，一键脚本部署等继承功能 |
| 17 | 支持国密算法  | <font color=green>█</font> | <font color=blue><font color=green>█</font></font> |     |     |  继承已有测试能力，验证SSH协议栈、TLCP协议栈、内核模块签名、安全启动、文件完整性保护、用户身份鉴别、磁盘加密、算法库等模块支持国密算法。   |
| 18 | 支持pod带宽管理oncn-bwm  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证使能/网卡Qos功能，设置cgroup优先级、在线水线、离线带宽等功能，使能网卡QOS功能后，在线业务可实时抢占离线业务带宽，以及功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等。  |
| 19 | 支持isuald  | <font color=green>█</font> | <font color=green>█</font> |     |     | 继承已有测试能力，覆盖继承功能cgroup v2,热升级，健康检查，本地卷，容器生命周期管理，镜像管理，资源管理等，重点验证isulad长稳场景  |
| 20 | 支持A-OPS | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景  |
| 21 | 支持系统运维套件x-diagnosis  | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能   |
| 22 | 支持自动化热升级组件nvwa | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等   |
| 23 | 支持DPU直连聚合特性dpu-utilities  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源   |
| 24 | 支持系统热修复组件syscare | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力   |
| 25 | iSula容器镜像构建工具isula-build  | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能   |
| 26 | 支持进程完整性防护特性DIM | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等，用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量，以及度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量   |
| 27 | 支持入侵检测框架secDetector  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等   |
| 28 | isocut镜像裁剪易用性提升 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包   |
| 29 | 支持devmaster组件 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证devmaster的安装部署、进程配置、客户端工具等使用场景   |
| 30 | 支持TPCM特性  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试用例，验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等   |
| 31 | 支持sysMaster                          | <font color=green>█</font> | <font color=blue>▲</font> |     |     |  继承已有测试能力，验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景   |
| 32 | 支持sysmonitor特性  | <font color=green>█</font> | <font color=blue>▲</font> |     |     |  继承已有测试能力，验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景   |
| 33 | 混合部署rubik  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化   |
| 34 | 支持IMA自定义证书 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式  |
| 35 | 支持IMA virtCCA  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等   |
| 36 | 安全启动  | <font color=green>█</font> | <font color=green></font> |     |     |   继承已有测试能力，验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等  |
| 37 | Kmesh | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等   |
| 38 | openEuler安全配置规范框架设计及核心内容构建   | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性    |
| 39 | oemaker | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，在构建工程中保证oemaker功能正常   |
| 40 | openssl | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上    |
| 41 | sysCentry | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试用例，重点关注sysCentry服务和基本命令正常，巡检项和巡检结果正常   |
| 42 | 编译器(gcc/jdk) | <font color=green>█</font> | <font color=green>█</font> |     |     |   继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证  |
| 43 | 支持HA软件 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性    |
| 44 | 支持KubeSphere | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力  |
| 45 | 支持OpenStack Train和Wallaby  | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能    |
| 46 | 支持智能运维助手  | <font color=green>█</font> | <font color=green></font> |     |     | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性     |
| 47 | 支持k3s| <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证k3s软件的部署功能正常     |
| 48 | 支持pkgship | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能   |
| 49 | Kunpeng加速引擎 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试   |
| 50 | migration-tools增加图形化迁移openeuler功能 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统   |
| 51 | 发布Nestos-kubernetes-deployer | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，覆盖在NestOS上部署，升级和维护kubernetes集群功能正常   |
| 52 | 支持NestOS | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证   |
| 53 | 发布PilotGo及其插件特性新版本 | <font color=green>█</font> | <font color=green>█</font> |     |     |  继承已有测试能力，验证PilotGo支持 topo 图的展示和智能调优能力   |
| 54 | 社区签名体系建立  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性   |
| 55 | 智能问答在线服务 | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力   |
| 56 | 增加AO.space 项目发布 | <font color=red>●（测试报告未提交，1227反馈测试不通过，不满足发布要求）</font> | <font color=green></font> |     |     |  继承已有测试能力，通过软件包和容器镜像验证aospace系统管理程序和服务组件为个人数据提供基础网络访问、安全防护等   |
| 57 | 支持GreatSQL | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证GreatSQL源码编译、RPM安装、二进制包安装、主要功能及性能、稳定性   |
| 58 | ZGCLab发布内核安全增强补丁| <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试   |
| 59 | oeAware 支持本地网络加速  | <font color=green>█</font> | <font color=green></font> |     |     |  继承已有测试能力，验证使能oeAware支持本地网络加速能力(SMC-D)，提升redis/nginx本地回环网络性能   |
| 60 | 支持RISC-V | <font color=green> </font> | <font color=green>█</font> |     |     | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性     |
| 61 | LLVM平行宇宙计划 RISC-V Preview 版本  | <font color=green>  </font> | <font color=green>预计下周完成测试</font> |     |     |   继承已有测试能力，验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动  |
| 62 | 为RISC-V架构引入Penglai TEE 支持  | <font color=green>   </font> | <font color=green>█</font> |     |     |   继承已有测试能力，验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等  |
| 63 | 支持embedded版本 | <font color=green> █  </font> | <font color=green></font> |     |     |   继承已有测试能力，验证openEuler embedded的构建镜像和完成嵌入式应用开发能力  |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价


对新需求进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **aarch64/x86_64质量评估**    |  **risc-v质量评估**    |   **loongarch质量评估**    |  **powerpc质量评估**    | **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | ---------------- | ---------------- | ---------------- | -------------- | -------------------------- | -------- |
|  1 | [wine5.5升级到wine9.17，不需要linux32依赖库情况下支持win32程序](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | Wine是在操作系统上运行Windows应用的兼容层，wine特性测试主要覆盖了基本功能测试、兼容性测试和稳定性测试，未发现问题，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  2 | [Add compatibility patches for Zhaoxin processors](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 针对Zhaoxin处理器进行Zhaoxin OLK-6.6补丁测试，共执行12个测试用例，主要覆盖功能测试，未发现问题，特性质量良好 |  |  | <font color=green>█</font> |  | | | |
|  3 | [virtCCA机密虚机特性合入](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 机密虚机场景主要覆盖了功能、性能、可靠性、兼容性、资料和长稳测试，共执行用例397个，未发现问题，整体特性质量良好 |  |  | <font color=green>█</font> | | | | |
|  4 | [Add Intel QAT packages suppor](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 对intel-qatlib, intel-qatzip, intel-qatengine(包含intel-ipp-crypto-mb和intel-ipsec-mb)软件包的功能测试和性能测试，共执行25个用例，测试结果符合预期，未发现问题，特性质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  5 | [增加YouQu自动化测试平台支持](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共三轮测试执行用例10个，主要覆盖功能测试，包括软件包安装、卸载，未发现问题，特性质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  6 | [增加migration-tools支持](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共三轮测试执行用例14个，主要覆盖功能测试，包括软件包安装、卸载，未发现问题，特性质量良好 |  |  | <font color=green>█</font> | | | | |
|  7 | [增加 utsudo 支持](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共三轮测试执行用例40个，主要覆盖功能测试，包括软件包安装、卸载，未发现问题，特性质量良好 |  |  | <font color=green>█</font> | <font color=green>█</font> | | | |
|  8 | [增加 utshell支持](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共三轮测试执行用例62个，主要覆盖功能测试，包括软件包安装、卸载，发现问题问题3个，无遗留问题，特性质量良好 |  |  | <font color=green>█</font> | <font color=green>█</font> | | | |
|  9 | [增加DDE支持](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | DDE特性共执行用例232，主要覆盖了基础组件、预装应用核心功能、新增特性基础功能以及基本UI测试，共发现问题4个，全部闭环无遗留问题 |  |  | <font color=green>█</font> | <font color=green>█</font> | | | |
|  10 | [海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 针对海光第三代安全虚拟化技术，共计执行41个测试用例，主要功能测试、可靠性测试，测试过程中发现2个问题，已经有对应修复的patch，整体质量良好。 |  |  | <font color=green>█</font> |  ||||
|  11 | [集成openGauss 6.0.0 LTS企业版](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共进行1轮测试，执行了11个用例。主要覆盖功能测试，对数据库系统工具、SQL功能、数据库升级、兼容B库等内容进行了验证。发现2个问题，无遗留问题，整体特性质量良好 |  |  | <font color=green>█</font> | | | | |
|  12 | [LLVM多版本实现](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共进行两轮测试，执行特性包构建，全量版本验证以及目标应用（Rust）构建，主要测试内容包括LLVM多版本包引入对于全量版本构建没有影响、LLVM多版本包能够正常工作和使用，包括了功能测试和可靠性测试，共发现3个问题，已全部解决，无遗留问题，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  13 | [支持树莓派](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) |  对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性测试，测试结果良好，支持上述功能的正常使用。 |  |  | <font color=green>█</font> | | | | |
|  14 | [新增密码套件openHiTLS](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 对openHiTLS功能特性进行测试, 包括密码算法、密码协议、证书功能，共执行两轮测试4k+用例，未发现问题，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  15 | [AI流水线oeDeloy 提升kubeflow部署效率](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 验证oeDeloy工具实现kubeflow分钟级部署，主要覆盖功能测试、性能测试、兼容性和资料测试，共发现9个问题，全部闭环无遗留问题 |  |  | <font color=green>█</font> | ||||
|  16 | [iSula支持NRI插件式扩展（继承）](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) |验证继承用例8个，重点覆盖插件启动后正常运行，以及配置plugin相关参数后，插件运行|  |  | <font color=green>█</font> | | | | |
|  17 | [epkg新型软件包及包管理器功能增强](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 针对epkg包构建、包管理两大特性，共执行三轮测试共计80个用例，主要覆盖了功能测试和兼容性测试，发现问题已解决，回归通过（部分问题待回归测试），无遗留风险，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  18 | [oeAware采集、调优插件等功能增强](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 对oeAware特性共进行两轮测试共计执行47个测试用例，主要覆盖了功能测试、性能与异常场景测试，发现问题均已修复并回归通过，无风险，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  19 | [Gazelle特性增强](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共执行265个用例，覆盖新增和继承的功能测试、性能测试，稳定性测试，新增功能主要覆盖单机，一主一备，一主两备的客户端本地登录和非本机登录，覆盖主备场景的主备切换以及多次主备切换压测；性能测试主要覆盖一主一备（相对内核提升13.7%）和一主一备uwal网络场景（相对内核提升7.7%）的tpcc测试,符合性能提升目标5%的要求；共发现8个issue，当前均已解决 |  |  | <font color=green>█</font> |  | | | |
|  20 | [syscare热补丁特性增强（继承）](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | qtfs特性无更新，继承用例共2个执行通过；syscare特性测试，共计执行33个用例，覆盖62个测试点，主要包括syscare build以及syscare管理功能，包括此次新增的补丁顺序保存和恢复功能，检查补丁制作和管理功能正常，包括接口正向，负向的功能测试、以及可靠性测试，并发测试，长稳测试，资料测试，安全测试。测试过程未发现问题，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  21 | [secGear功能优化（继承）](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 继承已有用例50+，覆盖了包括远程证明基线与策略导入，查询，创建、加解密、边界检查、生成随机数、打印、销毁等secGear特性。无遗留风险，整体质量良好 |  |  | <font color=green>█</font> |  | | | |
|  22 | [微服务性能问题分钟级定界/定位（TCP，IO，调度等）继承）](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 继承已有用例4个，因无可测试环境，本版本仅测试gala-anteater服务可正常拉起，环境配置正常 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  23 | [容器干扰检测，分钟级完成业务干扰源（CPU/IO）识别与干扰源发现（继承）](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 继承已有用例9个，重点验证容器间CPU/IO干扰场景，top3干扰源检测准确率，探针与容器启动，以及cpu,io，mem指标可正常收集，无遗留问题，整体质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  24 | [DevStation 开发者工作站支持(继承) ](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 验证开发者工作站的基本功能及兼容性，包括自研安装部署组件、支持图形化编程环境，支持安装x2openEuler工具、支持虚拟化等测试内容，共执行用例119个，发现问题18个，经ccb评审遗留1个问题落下个版本需求，风险可控 |  |  | <font color=blue>▲</font> | <font color=green></font> | | | |
|  25 | [AI集群慢节点快速发现 Add Fail-slow Detection](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共计执行6个用例，主要覆盖了功能测试和可靠性测试，通过经过7*24的长稳测试，发现问题已解决，回归通过，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  26 | [KubeOS支持集群参数统一配置、镜像定制化和静态完整性保护](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共执行43个用例，覆盖功能测试、集群参数配置测试、镜像制作测试；功能测试重点验证普通虚拟机镜像、pxe物理机/虚拟机镜像、开启dm_verity+安全启动的虚拟机镜像的安装以及升级磁盘/容器镜像的升级/回退/配置，admin容器镜像的部署，执行通过；集群参数测试重点验证新增三个参数升级/回退/配置修改，执行通过；镜像制作测试重点验证制作各类镜像，镜像制作参数可对应生效，执行通过；共发现问题7个，当前已解决2个，无遗留风险 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  27 | [rubik在离线混部调度协同增强](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共计执行6个用例，主要覆盖了参数测试、功能测试和可靠性测试，发现问题已解决，回归通过，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  28 | [提供GCC-14的多版本编译工具链](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 验证GCC-14多版本编译工具链，共计执行100w+用例，主要覆盖基本功能测试和版本切换测试，未发现问题，整体质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  39 | [AI4C编译选项调优和AI编译优化提升典型应用性能](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 针对AI辅助编译优化需求和AI4Compiler框架搭建需求，主要覆盖了功能测试和性能测试，功能用例执行通过，性能达成指标提升应用Doris TPC-H性能5% |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  30 | [RPM国密签名支持](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共执行6个用例，覆盖功能测试和可靠性测试，新增执行6个用例，覆盖gpg支持生成国密/国际算法公私钥测试；覆盖gpg支持使用国密/国际算法进行数据加解密测试；覆盖rpm支持导入国密/国际算法公钥测试，覆盖使用国密/国际算法对rpm签名与验签测试；覆盖rpm sm3宏未开启时导入公钥、签名验签，重复签名，签名删除后验签，公私钥不匹配等异常场景测试。未发现问题，无遗留风险 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  31 | [IMA度量通过异构可信根框架使能TPM/virtCCA信任根](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共执行7个用例，覆盖功能测试和可靠性测试，覆盖对ima_rot启动参数的正常值、异常值、重复配置测试；覆盖机器支持tpm可信根时，指定ima_rot分别tpm、virtcca、aaa时，ima度量日志扩展测试；覆盖机器支持virtcca可信根时，指定ima_rot分别tpm、virtcca、aaa时，ima度量日志扩展测试；覆盖机器无可信根时，添加ima_rot启动参数，系统可启动成功，IMA度量功能测试；覆盖不同可信根场景下，IMA扩展日志出现违规摘要时，系统无异常测试。共发现问题1个，当前已解决，无遗留风险 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  32 | [IMA完整性保护增强，支持对解释器运行的脚本类应用程序使能完整性保护机制](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共执行6个用例，覆盖execveat系统调用接口新增的参数AT_CHECK使用测试；覆盖新增启动参数exec_check.bash=0/1/异常值，exec_check.java=0/1/异常值等测试；覆盖bash解释器支持shell脚本的可执行权限检查测试；覆盖java解释器支持class和jar文件的可执行权限检查测试；覆盖IMA摘要列表度量和评估针对bash脚本、java文件的完整性保护测试。未发现问题，无遗留风险 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  33 | [鲲鹏KAE加速器驱动安装包合入](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 验证KAE特性的加解密和压缩解压缩，执行用例71个，主要覆盖功能测试和性能测试，功能测试正常，性能测试指标达成，未发现问题，整体特性质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  34 | [Add OpenVINO packages native support](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 主要针对完整集成OpenVINO框架和运行环境进行测试，共执行10个用例，覆盖了软件包功能测试和性能测试，测试结果符合预期，未发现问题，整体特性质量良好 |  |  | <font color=green>█(x86)</font> | <font color=green></font> | | | |
|  35 | [Add oneAPI low level native support](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 验证了Intel oneAPI底层依赖包和运行态软件包测试完成了oneAPI对于sample code的编译运行，大模型基于oneAPI加速框架的正确支持，共执行14个用例，覆盖了软件包的功能测试和性能测试，测试结果符合预期，未发现问题，整体质量良好 |  |  | <font color=green>█(x86)</font> | <font color=green></font> | | | |
|  36 | [版本引入ACPO包](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 主要测试内容包括使能ACPO并构建编译器、使用提供的ACPO源代码进行模型训练以及使用训练好的模型进行推理并使用perf统计执行时间，包括了功能测试、性能测试和可靠性测试，未发现问题，整体质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  37 | [内核TCP/IP协议栈支持CAQM拥塞](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共进行两轮测试执行4个测试套测试用例1k+, 主要覆盖功能测试、性能测试、可靠性测试，未发现问题，整体特性质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  38 | [支持virtCCA_KAE特性](https://gitee.com/openeuler/release-management/edit/master/openEuler-24.03-LTS-SP1/release-plan.md) | 共进行4轮测试，执行了192个用例，主要覆盖功能、性能以及可靠性测试，发现4个问题，无遗留问题，整体特性质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |



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
| R5350 G6   | EPYC 9454（genoa） | pass  |
| R4900 G6   | Intel Xeon 8592+ 64-core（emr 五代至强） | pass  |
| 算能     | 算丰SG2042 | pass  |

板卡

| **板卡类型**   | **测试主体**   | **chipModel**     | **boardModel**      | **aarch64架构测试结果** | **x86_64架构测试结果** | **risc-v架构测试结果** | **loongarch架构测试结果** | **powerpc架构测试结果** | 
| ----------  | -------------- | ------------------ | ------------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| RAID                | sig-Compatibility |        SAS3908           | 9560-8i            |    pass      |     pass     |
|   |  | SAS3516       | SP460C-M     | pass    |  pass  |
|   |  | SAS-3 3108    | SR430C-M     | 不支持   |   pass     |
|   |  | SAS3008       | SR130        | pass    |  pass  |
|   |  | SAS3408       | SR150-M      | pass    |  pass  |
|   |  | SAS3508       | SR450C-M     | pass    |  pass  |
|   |  | SAS3408       | 9440-8i      | pass    |  pass  |
|   |  | Aries         | 3S580/3S585  |   pass      |  pass      |
|   |  | Aries         | 3S520/3S530/3S540      |     pass   |   pass |     
|   |  | B80121        | SP686C       | pass    |  pass        |
|   |  | PM8204        | PMC3152      | pass    |  pass       |
| FC         | sig-Compatibility |         |          |                    |              |
|   |  | ISP2532       | QLE2560      |   pass    |    pass      |
|   |  | ISP2722       | QLE2690/QLE2692/QLE2740/QLE2742        |    pass     |   pass   |
|   |  | ISP2812       | QLE2770/QLE2772/QLE2870/QLE2872           |     pass     |    pass      |
|   |  | LPe31000/LPe32000   | LPe31002-M6   |   pass  |  pass  |
| GPU        | sig-Compatibility |     |                    |                    |              |
|   |  | GV100GL       | Tesla V100   |   pass     |    pass      |
|   |  | TU104GL       | Tesla T4     |   pass     |    pass      |
|   |  | GA100         | Tesla A100   |   pass     |    pass      |
| SSD           | sig-Compatibility |                |                    |                   |         |
|   |  | Hi1812E V100  | ES3600C V5-3200GB     |    pass      |    pass     |
| IB      | sig-Compatibility |                |                            |
|   |  | ConnectX-6    | MCX653105A-EFAT       |    pass      |    pass     |
|   |  | ConnectX-5    | SP350                 |    pass      |    pass     |
| NIC        | sig-Compatibility |       |     |              |             |
|   |  | Hi1822            | SP580             |    pass      |    pass     |
|   |  | Hi1822（Hi1823）  | SP680             |     pass     |     pass    |    
|   |  | BCM57414          | BCM57414          |    pass     |     fail     |
|   |  | E810-XXV          | E810-XXV-2        |    pass     |     pass     |
|   |  | SP332             | SP332 |  pass | pass |
|   |  | 82599ES           | SP310             |    pass     |     pass     |
|   |  | I350              | I350-F2           |    pass     |     pass     |
|   |  | ConnectX-6 LX     | MCX631102AN-ADAT  | pass|  pass |
|   |  | ConnectX-6 DX     | MCX623106AN-CDAT  | pass|fail|
|   |  | ConnectX-5        | SP382             |    pass     |     pass     |
|   |  | ConnectX-4 LX     | SP380             |    pass     |     pass     |
|   |  | RP1000            | RP1000P2SFP       |    pass   |   pass           |
|   |  | RP2000            | RP2000P2SFP       |    pass         |    pass      |
|   |  | WX1860A2          | SF200T            |    pass         |    pass       |
|   |  | WX1860AL2         | SF200HT           |   pass         |    pass       |
|   |  | WX1860A4          | SF400T            |    pass        |   pass       |
|   |  | WX1860AL4         | SF400HT           |    pass         |    pass       |
|   |  | M16100            | N1045XS           |   pass        |    pass       |
|   |  | M18105            | S1055AS 2*25G     |    pass         |    pass       |
|   |  | Gemini            | 3S910/3S920/3S930 |    pass         |    pass       |
|   |  | N10               | N10G-X4-QC        |    pass         |    pass       |
|   |  | N10               | N10G-X2-DC        |    pass         |    pass       |
|   |  | N500              | N500L-AM4C-QD     |    pass         |    pass       |





### 4.2.2 虚机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 |                                   
| ---------- | ----------------------- | ------- | -------- | 
| openEuler 24.03 LTS SP1 | Centos 6 | x86_64 | PASS |         
| openEuler 24.03 LTS SP1 | Centos 7 | aarch64 | PASS |         
| openEuler 24.03 LTS SP1 | Centos 7 | x86_64  | PASS |         
| openEuler 24.03 LTS SP1 | Centos 8 | aarch64 | PASS |         
| openEuler 24.03 LTS SP1 | Centos 8 | x86_64  | PASS | 
| openEuler 24.03 LTS SP1  | Windows Server 2016 | x86_64  | PASS |  
| openEuler 24.03 LTS SP1  | Windows Server 2019 | x86_64  | PASS |         

RISC-V 虚机兼容性测试预计本周完成

## 4.3   专项测试结论

### 4.3.1 安全测试

整体安全测试覆盖：

1、病毒扫描：对于产品提供的镜像中的aarch64架构与x86_64架构rpm软件包，使用majun平台病毒扫描工具进行在线扫描分析，扫描结果中未出现病毒报警，无风险。

2、开源漏洞评估：对于产品提供的标准镜像中的aarch64架构与x86_64架构中的baseos范围内rpm软件包，使用majun平台的漏洞视图进行漏洞评估，对于识别出的CVE进行分析，总共感知漏洞6165个，待办中的漏洞901个，经过分析评估，无风险857个，为本次版本分支24.03-LTS-SP1不受影响或此分支已修复漏洞，低风险44个，为7分以下的CVE漏洞，风险可控，后续持续跟踪解决。

3、安全编译选项扫描：对于产品提供的标准镜像中的aarch64架构与x86_64架构中的rpm软件包，使用majun平台二进制扫描工具扫描安全编译选项，对于baseos软件包范围内的扫描结果未实行必选安全编译选项的项进行确认(包括rpath、pie、strip)，所有问题均已修复或评估，无风险。

4、安全测试基线用例测试：对于产品提供的标准镜像，通过openscap用例测试，对于镜像中的初始部署、安全访问、运行与服务、日志审计等方面进行测试，对于测试结果进行分析，其中所有问题均已评估，无风险。

5、开源片段引用扫描：目前对于openeler社区孵化的baseos范围内的57个软件包仓库，使用majun平台的开源片段扫描工具扫描，对于扫描结果中识别出的片段引用进行分析，所有问题均已修复或评估，无风险。

6、开源合规license检查：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，验证了46193个rpm软件包，共有483个rpm软件包的license不在openEuler合规license准入列表中，其中，已经审阅并评审修复通过483个rpm软件包的license。

7、签名和完整性校验：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，使用shell命令对48558个rpm软件包进行了签名和完整性校验，所有rpm包均有签名。对于产品提供的镜像中的riscv64架构中的所有rpm软件包，使用shell命令对20767个rpm软件包进行了签名和完整性校验，所有rpm包均有签名。

8、SBOM校验：对于产品提供的aarch64架构、x86_64架构，2种架构的iso镜像均具有SBOM文件及SBOM文件签名。

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
| DDE安装指南 | 安装步骤的准确性及DDE桌面系统是否能成功安装启动  | 英文描述的准确性   | pass   |    |       |           |       
| UKUI安装指南 | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动| 英文描述的准确性   | pass   |     |       |           |         
| KIRAN安装指南 | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动 | 英文描述的准确性   | pass   |     |       |           |                
| 树莓派安装指导 | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   | pass    |   |      |           |         
| 安装指南  | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    |    |    |           |         
| 管理员指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass    |     |     |           |         
| 安全加固指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    |    |      |           |         
| 虚拟化用户指南   | 文档描述与版本的行为是否一致  | 英文描述的准确性   | pass    |    |      |           |         
| StratoVirt用户指南  | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass  |   |     |           |         
| 容器用户指南   | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   |    |      |           |         
| A-Tune用户指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   |    |     |           |         
| oeAware用户指南   | 文档描述与版本的行为是否一致  | 英文描述的准确性   | pass   |     |      |           |         
| 应用开发指南  | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   |    |     |           |         
| 工具集用户指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   |    |      |           |         
| HA的安装部署 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | pass    |    |    |           |         
| HA的使用实例  | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   | pass    |     |       |           |         
| K8S安装指导| 文档描述与版本的行为是否一致| 英文描述的准确性   | pass    |     |       |           |         
| OpenStack安装指导| 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    |     |    |           |         
| A-ops用户指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   |    |     |           |         
| Gazelle用户指南 | 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   |    |      |           |         
| openEuler Embedded用户指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass    |    |     |           |         
| UniProton用户指南| 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass   |   |   |           |         
| GCC for openEuler用户指南| 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   |     |     |           |         
| NestOS用户指南| 文档描述与版本的行为是否一致 | 英文描述的准确性   | pass    |    |   |           |         
| EulerCopilot 智能问答用户指南 | 文档描述与版本的行为是否一致| 英文描述的准确性   | pass   |    |    |           |         

# 5   问题单统计

openEuler 24.03-LTS-SP1版本共发现问题506个，有效问题496个，其中遗留问题 3 个，详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注        |
| --------------------------- | -------- | ------------ | ------------ | ------------ | -------------------------- |
| openEuler 24.03 LTS SP1  dailybuild |  14  |    14   |  0  |   0  | 每日构建   |
| openEuler 24.03 LTS SP1  alpha      | 199  |  199   |  0  |   0    | Alpha轮次   |
| openEuler 24.03 LTS SP1  RC1        | 137   |  136   | 1  |  0     | Beta轮次  |
| openEuler 24.03 LTS SP1  RC2        | 55    |    50   | 6   |   0    | 特性合入 |
| openEuler 24.03 LTS SP1  RC3        | 41   |  39  |  2  |  0   | 全量集成  |
| openEuler 24.03 LTS SP1  RC4        | 48   |  48    |  0  |   0    | 全量集成    |
| openEuler 24.03 LTS SP1  RC5        | 12   |   11    | 1  |  0   | 回归测试 |
| openEuler 24.03 LTS SP1  RC6        |  0  |  0    |  0 |   0   | 回归测试(版本验收测试) |

# 6 版本测试过程评估

#### 6.1 问题单分析

本次版本测试各迭代从Alpha到RC6，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求。Alpha属于开发自验证轮次，测试提前介入，软件包构建失败问题14个。RC1特性转测轮次开始，迭代轮次共发现Aops、oeaware、IMA、DIM、编译器等继承特性和新增需求问题100+，均定位解决并通过测试验收，有效防护特性质量; 当前社区版本有效issue共计497个，新增issue总体趋势下降, 符合质量预期，风险可控。

1. dailybuild 为保障baseOS范围内软件包正常发布，14个都是构建失败问题
2. alpha为正式转测版本，问题数量较多，主要为特性测试问题（85个）涉及使能gazelle调优、慢IO检测需求；软件包降级问题（101个）；以及少量构建问题
3. rc1构建失败问题54个，保障epol范围内软件包正常发布；降级问题69个，update版本更新未同步在研
4. rc2-rc3大量特性转测，主要是特性验收发现的问题，继承特性如oeaware(接口变更影响部分黑盒功能和显示)、aops等,；新增需求如安全配置、可信根；以及包管理、单包等通用测试发现问题
5. rc4仍有部分新增特性转测，少量问题发现，如kubeOS; 部分安全问题，如license合规问题
6. rc5 11个问题，3个构建失败问题，门禁/依赖软件包有变更; 3个软件包升级发现新问题，其余为测试执行安排和定位原因rc5才提交的问题


- 典型问题：
1. 软件包构建失败问题突出，整个版本发现构建失败问题85个，各轮次问题数量为 14-5-54-5-1-2-3 。集中在alpha-RC2轮次, RC3开始收敛，在dailybuild轮次主要为保障正式轮次baseOS范围内软件包的构建成功；alpha和RC1轮次分别主要覆盖everything和epol仓库范围内的软件包。构建失败原因有几类：1）24.03-LTS版本已修复的构建问题未及时同步到NEXT分支而引入到24.03 LTS SP1版本；2）一些依赖软件包更新导致的构建失败 3） 构建网络出现问题，实验室的网络策略更改导致无法访问外部源 4） 新引入的软件包确实存在构建问题。

2. 软件包降级问题突出，整个版本发现版本降级问题174个，集中在alpha-RC1轮次，alpha到RC2阶段分别有101-69-4个问题。 原因大致分为俩类：1）alpha版本的问题基本是上个版本软件包已更新但未合入NEXT分支 2）rc1的问题基本是24.03 LTS update版本更新了不少软件包，补丁未合入24.03-LTS-SP1分支。

- 改进点：
1. 以上两个问题都涉及流程规范改进，软件包更新的分支合入需要规范，后续组织专题讨论，是否基础设施有相应功能可以实现（规范改进）
2. 特性oeaware、aops问题还是有不少，oeaware自动化率100%，因接口变更导致的黑盒问题基本可以通过自动化用例防护；aops自动化率较低，还有提升空间（测试改进）
3. 开发自验阶段需要规范，gazelle调优、慢IO检测两个需求由于自验证不够充分导致流出到测试的问题较多（开发改进） 


#### 6.2 OS集成测试迭代版本基线

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



# 7   附件

## 遗留问题列表

|序号|问题单号|问题简述|问题级别|影响分析|规避措施|
| ---- | ---- | ------------- | ----| ------ | ----| 
| 1 |IBA13Y | raspberrypi4-64镜像测试用例oe_test_nfs-utils_test_001失败 |  不重要 | 影响x86镜像上mica特性的使用，不影响其他特性，且x86的mica使用的范围小，影响范围可控 | NA | 
| 2 |IBACHW | qemu-aarch64-mcs-ros镜像名称错误，并且micad启动失败 |  不重要 | 影响qemu镜像上mica特性的使用，不影响其他特性，且qemu镜像只是参考镜像，使用的范围小，影响可控 | NA | 
| 3 |IBANAZ | x86-64-hmi-mcs-ros-rt镜像mica启动失败 |  不重要 | 影响x86镜像上mica特性的使用，不影响其他特性，且x86的mica使用的范围小，影响范围可控 | NA | 



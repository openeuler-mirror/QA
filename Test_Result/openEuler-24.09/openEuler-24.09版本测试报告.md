![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2024/09/24 | 1.0.0    | 初稿，基于RC6 | linqian0322 |



关键词：

openEuler  DDE iSulad RISC-V utshell utsudo A-Ops etmem KubeOS

摘要：

文本主要描述openEuler 24.09版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 24.09 版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 24.09 版本是基于6.6内核的创新版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler master分支拉出，发布范围相较24.03 LTS版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-change.yaml)
2.  软件包范围变化
24.09: baseos 1191 everything 4887 epol 1549
24.03 LTS: baseos  1192 everything 4883 epol 1276



## 2.1 版本测试计划
openEuler 24.09 版本按照社区release-manager团队的计划，共规划7轮测试，详细的版本信息和测试时间如下表：

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
| Test round 6         | 2024/9/20  | 2024/9/25 | 6    | 回归测试
| Test round 7         | 2024/9/26  | 2024/9/28 | 3    | 回归测试 
| Release Review       | 2024/9/20  | 2024/9/22 | 3    | 版本发布决策/ Go or No Go            |
| Release preparation  | 2024/9/23  | 2024/9/28 | 6    | 发布前准备阶段，发布件系统梳理       |
| Release              | 2024/9/29  | 2024/9/30 | 2    | 社区Release评审通过正式发布          |



## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920(支持1.70以上的bios版本)        | OS集成测试     |
| RH2288H V3            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |

## 2.3 需求清单

openEuler 24.09 版本交付需求列表如下，详情见[openEuler-24.09 release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md)：


| no   | feature | status | sig  | owner |
| :--- | :------ | :----- | :--- | :---- |
|[I9UYO9](https://gitee.com/openeuler/release-management/issues/I9UYO9)| virtCCA机密虚机特性合入 | Discussion | SIG-Kernel/SIG-Virt | [@luoyukai](https://gitee.com/luoyukai) |
|[IAFDNQ](https://gitee.com/openeuler/release-management/issues/IAFDNQ)| 支持树莓派 | Discussion | SIG-SBC | [@woqidaideshi](https://gitee.com/woqidaideshi/) |
|[IADBJG](https://gitee.com/openeuler/release-management/issues/IADBJG)| 继承特性：发布Nestos-kubernetes-deployer | Discussion | SIG-CN | [@weihuanhuan_ky](https://gitee.com/weihuanhuan_ky) |
|[IAHMJ1](https://gitee.com/openeuler/release-management/issues/IAHMJ1)| 新增基于《openEuler 安全配置基线》检测工具 | Discussion | SIG-security-facility | [@chaomingmeng](https://gitee.com/chaomingmeng) |
|[IAJVVH](https://gitee.com/openeuler/release-management/issues/IAJVVH)|增加 utshell 项目发布|Discussion|sig-memsafety|[@wangmengc](https://gitee.com/wangmengc/)|EPOL|utshell|
|[IAJQIB](https://gitee.com/openeuler/release-management/issues/IAJQIB)|增加 utsudo 项目发布|Discussion|sig-memsafety|[@trackers-love](https://gitee.com/trackers-love/)|EPOL|utsudo|
|[IAMSTO](https://gitee.com/openeuler/release-management/issues/IAMSTO?from=project-issue)| epkg新型软件包的OS镜像构建 | Discussion | cicd-sig | [@duan_pj](https://gitee.com/duan_pj) |
|[IAMSQP](https://gitee.com/openeuler/release-management/issues/IAMSQP?from=project-issue)| DevStation 开发者工作站支持 | Discussion | desktop sig | [@superninesun](https://gitee.com/superninesun) |
|[IAMLWI](https://gitee.com/openeuler/release-management/issues/IAMLWI?from=project-issue)| 微服务性能问题分钟级定界/定位（TCP，IO，调度等） | Discussion | A-OPS sig | [@yangyongguang](https://gitee.com/yangyongguang) |
|[IAMLGE](https://gitee.com/openeuler/release-management/issues/IAMLGE?from=project-issue)| Aops支持智能运维助手 | Discussion | sig-ops/ sig-AI | [@solarhu](https://gitee.com/solarhu) |
|[IAMLAK](https://gitee.com/openeuler/release-management/issues/IAMLAK?from=project-issue)| 容器干扰检测，分钟级完成业务干扰源（CPU/IO）识别与干扰源发现 | Discussion | sig-ops| [@wo_cow](https://gitee.com/wo_cow) |
|[IAML7Y](https://gitee.com/openeuler/release-management/issues/IAML7Y?from=project-issue)| 构建远程证明统一框架，支持部署远程证明服务 | Discussion | sig-confidential-computing| [@houmingyong](https://gitee.com/houmingyong) |
|[IAML6V](https://gitee.com/openeuler/release-management/issues/IAML6V?from=project-issue)| IMA摘要列表支持三方PKI证书导入 | Discussion | sig-security-facility| [@HuaxinLuGitee](https://gitee.com/HuaxinLuGitee) |
|[IAML3W](https://gitee.com/openeuler/release-management/issues/IAML3W?from=project-issue)| KubeOS支持串、并行多种升级策略、状态更新等声明式API | Discussion | SIG-CloudNative-KubeOS| [@liyuanr](https://gitee.com/liyuanr) |
|[IAMKXU](https://gitee.com/openeuler/release-management/issues/IAMKXU?from=project-issue)| etmem内存扩展，实现虚机内存超分 | Discussion | storage sig| [@liubo254](https://gitee.com/liubo254) |
|[IAMKUJ](https://gitee.com/openeuler/release-management/issues/IAMKUJ?from=project-issue)| 构建双内核（5.10+6.6内核），完成基本功能验证 | Discussion | QA Sig | [@duan_pj](https://gitee.com/duan_pj) |
|[IAMKQL](https://gitee.com/openeuler/release-management/issues/IAMKQL?from=project-issue)| oeAware 支持本地网络加速 | Discussion | A-Tune sig | [@Lostwayzxc](https://gitee.com/Lostwayzxc) |
|[IAMKHS](https://gitee.com/openeuler/release-management/issues/IAMKHS?from=project-issue)| iSula支持NRI插件式扩展 | Discussion | sig-iSulad | [@xuxuepeng](https://gitee.com/xuxuepeng) |
|[IAMKB1](https://gitee.com/openeuler/release-management/issues/IAMKB1?from=project-issue)| 支持GCC 14多版本使能多样算力新特性 | Discussion | sig-Compiler | [@zhaoshujian](https://gitee.com/zhaoshujian) |
|[IAMK8J](https://gitee.com/openeuler/release-management/issues/IAMK8J?from=project-issue)| secGear功能优化 | Discussion | sig-confidential-computing | [@houmingyong](https://gitee.com/houmingyong) |
|[IAMK2Q](https://gitee.com/openeuler/release-management/issues/IAMK2Q?from=project-issue)| syscare特性增强：用户态热补丁支持栈检测 | Discussion | sig-ops | [@bb-cat](https://gitee.com/bb-cat) |
|[IAMJYQ](https://gitee.com/openeuler/release-management/issues/IAMJYQ?from=project-issue)| syscare特性增强：用户态热补丁支持容器化制作 | Discussion | sig-ops | [@luanjianhai](https://gitee.com/luanjianhai) |
|[IADN2N](https://gitee.com/openeuler/release-management/issues/IADN2N?from=project-issue)| 支持embedded版本 | Discussion | sig-embedded | [@fanglinxu](https://gitee.com/fanglinxu) |
|[IAOLZ3](https://gitee.com/openeuler/release-management/issues/IAOLZ3?from=project-issue)|  增加pandoc 项目发布 | Discussion | sig-haskell | [@lrzlin](https://gitee.com/lrzlin) |
|[IAPEKI](https://gitee.com/ncti-gba-ide/release-management/issues/IAPEKI?from=project-issue)|  增加国创OS开发工具 | Discussion | sig-ide | [@ncti-gba-ide](https://gitee.com/ncti-gba-ide) |
|[IAT24U](https://gitee.com/openeuler/release-management/issues/IAT24U?from=project-issue)|  为 RISC-V 架构引入 Penglai TEE 支持 | Discussion | sig-RISC-V | [ @Jingwiw ](https://gitee.com/Jingwiw) |



## 2.4 测试活动分工
 本次版本继承测试活动分工如下：

| **需求**                                              | **开发主体**                 | **测试主体**                 | **测试分层策略**                                             |
| ----------------------------------------------------- | ---------------------------- | ---------------------------- | ------------------------------------------------------------ |
| 支持UKUI桌面                                          | sig-UKUI                     | sig-UKUI                     | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
| 支持DDE桌面                                           | sig-DDE                      | sig-DDE                      | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持Kiran桌面                                         | sig-KIRAN-DESKTOP            | sig-KIRAN-DESKTOP            | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
| 支持Cinnamon桌面                                      | sig-cinnamon                 | sig-cinnamon                 | 验证Cinnamon桌面系统在openEuler版本上的可安装和基本功能      |
| 支持RISC-V                                            | sig-RISC-V                   | sig-RISC-V                   | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
| 内核                                                  | Kernel                       | Kernel                       | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像)             | sig-CloudNative              | sig-CloudNative              | 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化                                                | Virt                         | Virt                         | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能       |
| 编译器(gcc/jdk)                                       | Compiler                     | sig-QA                       | 基于开源测试套对gcc和jdk相关功能进行验证                     |
| 支持HA软件                                            | sig-Ha                       | sig-Ha                       | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持KubeSphere                                        | sig-K8sDistro                | sig-K8sDistro                | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 支持A-Tune                                            | A-Tune                       | A-Tune                       | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 支持secPave                                           | sig-security-facility        | sig-QA                       | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
| 支持secGear                                           | sig-confidential-computing   | sig-QA                       | 关注secGear特性的功能完整性                                  |
| 发布eggo                                              | sig-CloudNative              | sig-CloudNative              | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
| 支持kubeOS                                            | sig-CloudNative              | sig-CloudNative              | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
| 支持NestOS                                            | sig-CloudNative              | sig-CloudNative              | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 支持etmem内存分级扩展                                 | Storage                      | sig-QA                       | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
| 支持定制裁剪工具(inageTailor和oemaker)                | sig-OS-Builder               | sig-QA                       | 验证可定制化的能力，包括裁剪工具的基本命令功能，并对异常参数进行覆盖；另外对裁剪出来的镜像进行安装部署及基本验证，保障裁剪工具的E2E能力完整性 |
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
| 支持kubernetes                                        | sig-CloudNative              | sig-CloudNative              | 验证K8S在openEuler上的安装部署以及提供的对容器的管理能力     |
| 安装部署                                              | sig-OS-Builder               | sig-QA                       | 验证覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
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
| 发布PilotGo及其插件特性新版本                         | sig-ops                      | sig-QA                       | 验证PilotGo支持 topo 图的展示和智能调优能力                  |
| 社区签名体系建立                                      | sig-security-facility        | sig-security-facility        | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
| 智能问答在线服务                                      | sig-A-Tune                   | sig-QA                       | 验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 |
| 支持国密特性                                          | sig-security-facility        | sig-security-facility        | 验证openEuler社区国密生态，关注文件完整性保护、内核模块校验、磁盘加密、ssh协议栈等支持国密算法 |
| 增加 AO.space 项目发布                                | sig-RaspberryPi              | sig-RaspberryPi              | 通过软件包和容器镜像验证aospace系统管理程序和服务组件为个人数据提供基础网络访问、安全防护等 |
| 支持GreatSQL                                          | sig-DB                       | sig-DB                       | 验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库 |
| ZGCLab 发布内核安全增强补丁                           | sig-kernel                   | sig-kernel                   | 针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 |

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试



# 3 版本概要测试结论

   openEuler 24.09 版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 1轮重点特性测试 + 2轮全量测试 + 2轮回归测试 + 1轮版本发布验收测试；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项。测试也提前介入，覆盖冒烟测试、安装部署等基础测试项；第2轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证; 第3、4轮全量测试开展版本交付的所有特性和各类专项测试；第5、6轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；第7轮版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

   openEuler 24.09 版本共发现问题 269 个，有效问题 261 个，无效问题 8 个，遗留问题 4 个(详见遗留问题章节)，风险可控，版本整体质量良好。



# 4 版本详细测试结论

openEuler 24.09 版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括安全专项、性能测试、可靠性测试、资料测试；

5、对版本新增特性进行功能、可靠性等专项测试，新增特性均满足发布要求，测试较充分，质量良好；



## 4.1   软件范围变化分析结论

### 4.1.1 整体软件范围变化分析

经比较，openEuler-24.09 对比openEuler-22.03-LTS-SP4存在5项版本号降级，但存在42项release号降级的软件，47个降级问题均已提单跟踪解决并验收通过。

## 4.2   特性测试结论

### 4.2.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                     | **aarch64/x86_64质量评估**  |**risc-v质量评估**  |   **loongarch质量评估**    |  **powerpc质量评估**    | 备注                                                         |
| ---- | ----------------------- | :-------: | :--------: | :--------: | :-------: | ------------------------------------------------------------ |
| 1    | 内核                                      | <font color=green>█</font> | <font color=green></font> |||直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 2    | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | <font color=green></font> |||继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 3    | 虚拟化(qemu/stratovirt)                   | <font color=green>█</font> | ||| 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 4    | 编译器(gcc/jdk)                           | <font color=green>█</font> | <font color=green></font> |||继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   |
| 5    | 支持DDE桌面                               | <font color=green>█</font> | <font color=green></font> ||| 继承已有测试能力，关注DDE桌面系统的安装和基本功能            |
| 6    | 支持UKUI桌面                              | <font color=green>█</font> | <font color=green></font> ||| 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           |
| 7    | 支持Kiran桌面                             | <font color=green>█</font> | <font color=green></font> |||增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 |
| 8   | 支持树莓派                                | <font color=green>█</font> |  |||继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     |
| 9   | 支持HA软件                                | <font color=green>█</font> |  |||继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 |
| 10   | 支持KubeSphere                            | <font color=green>█</font> |  |||继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力 |
| 11   | 支持A-Tune                                | <font color=green>█</font> |  |||继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 12   | 支持secPave                               | <font color=green>█</font> |  |||继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    |
| 13   | 支持secGear                               | <font color=green>█</font> |  |||继承已有测试能力，关注secGear特性的功能完整性                |
| 14   | 支持eggo                                  | <font color=green>█</font> | ||| 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 |
| 15   | 支持kubeOS                                | <font color=green>█</font> |  |||继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 |
| 16   | 支持etmem内存分级扩展                     | <font color=green>█</font> | ||| 继承已有测试能力，重点验证特性的基本功能和稳定性             |
| 17   | 支持定制裁剪工具套件(oemaker/imageTailor) | <font color=green>█</font> |  |||继承已有测试能力，验证可定制化的能力                         |
| 18   | 支持虚拟化热补丁libcareplus               | <font color=green>█</font> | ||| 继承已有测试能力，重点关注libcareplus提供Qemu热补丁能力      |
| 19   | 支持用户态协议栈gazelle                   | <font color=green>█</font> |  |||继承已有测试能力，重点关注gazelle高性能用户态协议栈功能      |
| 20   | 支持容器场景在离线混合部署rubik           | <font color=green>█</font> | ||| 继承已有测试能力，结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 21   | 支持智能运维A-ops                         | <font color=green>█</font> | ||| 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性 |
| 22   | 支持国密算法                              | <font color=green>█</font> | ||| 继承已有测试能力，验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
| 23   | 支持k3s                                   | <font color=green>█</font> | ||| 继承已有测试能力，验证k3s软件的部署测试过程                  |
| 24   | 支持KubeEdge                              | <font color=green>█</font> |  |||继承已有测试能力，验证KubeEdge的部署测试过程                 |
| 25   | 支持pkgship                               | <font color=green>█</font> |  |||继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能 |
| 26   | 支持mindspore                             | <font color=green>█</font> |  |||继承已有测试能力，针对openCV、opencl-clhpp、onednn、Sentencepiece4个模块，复用开源测试能力覆盖安装、接口测试、功能测试，重点关注对mindspore提供能力的稳定性 |
| 27   | 支持pod带宽管理oncn-bwm                   | <font color=green>█</font> | ||| 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
| 28   | 支持kubernetes                            | <font color=green>█</font> | |||继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 29   | 安装部署                                  | <font color=green>█</font> |<font color=blue></font>||| 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| 30   | 备份还原功能支持                          | <font color=green>█</font> | ||| 验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常 |           |
| 31   | openEuler docker容器支持sysMaster管理sshd服务| <font color=green>█</font>  | |||继承已有测试能力，验证sysmaster管理sshd服务，在docker容器中的基本功能|
| 32   | iSulad支持K8S 1.24 /1.25版本 |<font color=green>█</font>|   ||| 继承已有测试能力，验证k8s的基础部署功能以及可靠性   |
| 33   | Rubik混部支持精细化资源QoS感知和控制 | <font color=green>█</font> |   |||继承已有测试能力，验证rubik支持精细化资源感知和控制的基础功能                 |
| 34   | 支持 sysmonitor 特性 |<font color=green>█</font> |   ||| 继承已有测试能力，验证sysmonitro继承需求的可靠性和基础功能                |
| 35   | 安全配置规范框架设计及核心内容构建|<font color=green>█</font>|  |||  继承已有测试能力，验证安全配置规范框架设计及核心内容构建        |
| 36   | gala-gopher新增性能火焰图、线程级性能Profiling特性 |<font color=green>█</font> |  |||继承已有测试能力，验证gala-gopher新增性能火焰图、线程级性能Profiling特性          |
| 37   | 支持DPU直连聚合特性|<font color=green>█</font>| |||继承已有测试能力，验证DPU直连聚合特性基本功能，安全以及可靠性|
| 38   | 支持系统热修复组件syscare|<font color=green>█</font>| <font color=green></font> |||继承已有测试能力，验证系统热修复组件syscare的功能，并发，长稳，以及安全|
| 39   | 支持入侵检测框架secDetector|<font color=green>█</font>| |||继承已有测试能力，验证入侵检测框架secDetector基本功能，安全，可靠性等方面|
| 40   | vCPU热插                             | <font color=green>█</font> |  |||对虚拟机支持vCPU热插能力进行功能/可靠性/稳定性和场景测试，共执行用例93条，覆盖基本功能、并发压力场景下的反复热插、长时间的生命周期操作；用例全部执行通过，特性质量良好 |
| 41   | nvwa 内核热升级             | <font color=green>█</font>       |  |||继承已有测试能力，重点验证基本功能，以及特性启动/重启后的功能及状态 |
| 42   | iSula容器镜像构建工具isula-build | <font color=green>█</font> | |||继承版本已有测试能力，关注基本功能完整性 |
| 43   | 支持进程完整性防护特性 | <font color=green>█</font> | |||验证配置DIM度量策略，度量用户态进程，度量任一模块，度量内核等功能； |
| 44   | 支持devmaster组件 | <font color=green>█</font> | |||依据测试要求，对devmaster特性进行接口测试、功能测试、组合场景测试 |
| 45   | 支持TPCM特性  | <font color=green>█</font> |  |||TPCM需求，共1轮测试，设计场景3个，共有用例11个。覆盖基本功能|
| 46   | 支持sysMaster组件 | <font color=green>█</font> | <font color=green></font> |||继承已有测试能力，验证入ysmaster的安装部署、基本功能、配置项进行测试 |
| 47   | isulad支持oci runtime并且切换默认runtime为runc | <font color=green>█</font> | <font color=green></font> ||| 继承已有测试能力，覆盖功能，可靠性。|

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.2.2   新需求评价


对新需求进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **aarch64/x86_64质量评估**    |  **risc-v质量评估**    |   **loongarch质量评估**    |  **powerpc质量评估**    | **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | ---------------- | ---------------- | ---------------- | -------------- | -------------------------- | -------- |
|  1 | [virtCCA机密虚机特性合入](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 针对机密虚机场景整体进行了功能、性能、可靠性、兼容性、资料和长稳测试，共执行用例214个，包括机密虚拟的基本功能测试以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试；完成了功能、兼容性、可靠性、长稳测试、以及资料测试，用例通过7*24的长稳测试。该版本共发现问题0个，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  2 | [支持树莓派](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | openEuler 24.09 树莓派镜像版本测试完成了功能测试，测试范围包括镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成了硬件兼容性测试，包括树莓派 4B 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的兼容性验证。未发现问题，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  3 | [继承特性：发布Nestos-kubernetes-deployer](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | NKD 在 openEuler-2409 版本测试阶段完成了功能测试，包括基础设施 & Kubernetes 1.29 版本集群的部署、扩展与销毁。整体核心功能稳定正常；完成了 aarch64 架构 （Kunpeng 920）和 x86_64 架构（Intel）的兼容性测试；完成了可靠性测试，可长时间稳定运行。未发现问题，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  4 | [新增基于《openEuler 安全配置基线》检测工具](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | SecureGuardian在openEuler24.09 版本上的测试表现正常，共计201个测试用例。涵盖了功能、安全、性能、系统兼容性等，未发现问题，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  5 | [增加 utshell 项目发布](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | utshell，共计执行5轮测试，功能正常，可正常执行shell基础命令，未发现问题，功能质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  6 | [增加 utsudo 项目发布](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | utsudo，共计执行5轮测试，功能正常，可正常执行sudo基础命令，未发现问题，功能质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  7 | [epkg新型软件包的OS镜像构建](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 待刷新 |  |  | <font color=blue>▲</font> | | | | |
|  8 | [DevStation 开发者工作站支持](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 待刷新 |  |  | <font color=blue>▲</font> | <font color=green></font> | | | |
|  9 | [微服务性能问题分钟级定界/定位（TCP，IO，调度等）](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共执行5个用例，经过2轮测试，主要覆盖在k8s集群环境上故障注入和定位定界的功能测试，可靠性测试。共发现2个功能问题，已解决并回归通过，无遗留问题 |  |  | <font color=green>█</font> | | | | |
|  10 | [Aops支持智能运维助手](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共执行16个用例，验证通过集成到Aops里的 问答系统使用问答方式进行cve扫描和配置溯源，发现问题9个，预计rc7全部解决并回归通过。 |  |  | <font color=blue>▲</font> | <font color=green></font> | | | |
|  11 | [容器干扰检测，分钟级完成业务干扰源（CPU/IO）识别与干扰源发现](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共执行6个用例，经过2轮测试，主要覆盖在容器场景下的干扰检测功能测试和可靠性测试，测试通过未发现新增问题 |  |  | <font color=green>█</font> | <font color=green></font> ||||
|  12 | [构建远程证明统一框架，支持部署远程证明服务](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共执行了7个用例，经过2轮测试，主要覆盖在鲲鹏和virtCCA机器上分别验证“获取/校验远程证明报告和身份令牌”的功能，共发现1个功能问题，已解决并回归通过，无遗留问题 |  |  | <font color=green>█</font> | | | | NKD 24.03 LTS 版本需等待 NestOS 24.03 LTS 版本发布后再进行测试|
|  13 | [IMA摘要列表支持三方PKI证书导入](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共计执行5个用例，主要覆盖了功能测试、可靠性测试和资料测试，发现1个问题已解决，回归通过，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  14 | [KubeOS支持串、并行多种升级策略、状态更新等声明式API](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共计执行40个用例（33个继承用例+7个新增用例），主要覆盖了继承用例测试、新增功能和参数测试，发现2个问题已解决，回归通过，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  15 | [etmem内存扩展，实现虚机内存超分](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共计执行用例2个，主要覆盖了功能测试，用例全部执行通过，未发现问题，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  16 | [iSula支持NRI插件式扩展](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共计执行用例8个，主要覆盖了功能测试和可靠性测试，通过7*24的长稳测试，失败用例0个，新增8个用例全部通过，发现问题已解决，回归通过，无遗留风险，整体质量良好。 |  |  | <font color=green>█</font> | ||||
|  17 | [支持GCC 14多版本使能多样算力新特性](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共执行100w+用例，经过4轮测试，主要覆盖基础功能测试，共发现3个问题，1个问题经评估已挂起 |  |  | <font color=green>█</font> | | | | |
|  18 | [secGear功能优化](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 新增用例10个，继承用例31个，共执行用例41个，覆盖功能测试、可靠性测试，发现2个问题，均已解决并回归通过，无遗留问题，整体质量良好 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  19 | [syscare特性增强：用户态热补丁支持容器化制作、支持栈检测](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 共执行了30个用例，经过2轮测试，主要覆盖syscare软件制作和管理热补丁的功能，共发现4个问题，其中3个功能问题，1个资料问题，均已解决并回归通过，无遗留问题，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  21 | [支持embedded版本](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 见embedded测试报告 |  |  | <font color=green>█</font> | <font color=green></font> | | | |
|  22 | [增加pandoc 项目发布](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 评估 openEuler 24.09 测试镜像中的 ghc-pandoc 和 pandoc-cli 软件包，共计执行 17 个用例，主要覆盖了安装测试和功能测试，发现问题已解决，回归通过，无遗留风险，整体质量良好 |  |  | <font color=green>█</font> | | | | |
|  23 | [增加国创OS开发工具](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 待刷新 |  |  | <font color=green></font> | <font color=green></font> | | | |
|  24 | [为 RISC-V 架构引入 Penglai TEE 支持](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.09/release-plan.md) | 对蓬莱提供的7个 demo 示例进行了编译运行测试，全部可以按照预期方式运行，测试通过，未发现问题，整体质量良好 |  |  | <font color=green>█</font> | | | | |



<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好



## 4.3   专项测试结论

### 4.3.1 安全测试

整体安全测试覆盖：

1、病毒扫描：对于产品提供的镜像中的aarch64架构与x86_64架构rpm软件包，使用majun平台病毒扫描工具进行在线扫描分析，扫描结果中未出现病毒报警，无风险。

2、安全编译选项扫描：对于产品提供的标准镜像中的aarch64架构与x86_64架构中的rpm软件包，使用majun平台二进制扫描工具扫描安全编译选项，对于baseos软件包范围内的扫描结果未实行必选安全编译选项的项进行确认(包括rpath、pie、strip)，所有问题均已修复或评估，无风险。

3、开源片段引用扫描：目前对于openeler社区孵化的baseos范围内的57个软件包仓库，使用majun平台的开源片段扫描工具扫描，对于扫描结果中识别出的片段引用进行分析，所有问题均已修复或评估，无风险。

4、开源合规license检查：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，验证了48558个rpm软件包，共有11806个rpm软件包的license不在openEuler合规license准入列表中，其中，已经审阅并评审通过11428个rpm软件包的license，剩下378个rpm软件包的license由于涉及到的license数量较多，评审时间跨度长，暂时遗留，已根据社区处理策略创建issue进行跟踪

5、签名和完整性校验：对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，使用shell命令对48558个rpm软件包进行了签名和完整性校验，所有rpm包均有签名。

6、SBOM校验：对于产品提供的aarch64架构、x86_64架构，2种架构的iso镜像均具有SBOM文件及SBOM文件签名。

整体OS安全测试较充分，主要问题均已解决，回归测试正常，整体质量良好，风险可控，详细测试内容见安全专项测试报告。

### 4.3.2 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                                                    |
| ------------ | ------------------------------------------------------------ | ----------------------------------------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | RC3 7x24h(通过)<br />RC5 7*24h(通过) |

### 4.4.3 性能测试

| **指标大项** | **指标小项**                                                 | **指标值**                        | **测试结论**     |
| ------------ | ------------------------------------------------------------ | --------------------------------- | ---------------- |
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考24.03 LTS版本相应指标基线 | 比较前一版本性能无劣化，波动在正常范围内 |


# 5   问题单统计

openEuler 24.09 版本共发现问题 269 个，有效问题 261 个，其中遗留问题 4 个。详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注        |
| --------------------------- | -------- | ------------ | ------------ | ------------ | -------------------------- |
| openEuler 24.09 ailybuild | 19    | 16      | 3   | 0      | 每日构建   |
| openEuler 24.09 alpha      | 114   | 114     | 0   | 0      | Alpha轮次   |
| openEuler 24.09 RC1        | 44   | 42     | 2  | 0      | Beta轮次  |
| openEuler 24.09 RC2        | 26    | 25      | 1   | 0      | 全量集成 |
| openEuler 24.09 RC3        | 26   | 26     | 0   |  0     | 全量集成  |
| openEuler 24.09 RC4        | 19    | 18      | 1   | 3      | 回归测试    |
| openEuler 24.09 RC5        | 18    |  17     | 1   | 1      | 回归测试 |
| openEuler 24.09 RC6        | 3    |  3     | 0   | 0      | 回归测试 |
| openEuler 24.09 RC7        | 0    |  0     | 0   | 0      | 回归测试(版本验收测试) |

# 6 版本测试过程评估

#### 6.1 问题单分析

本次版本测试各迭代从Alpha到RC7，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求。Alpha属于开发自验证轮次，测试提前介入，软件包构建失败问题59个，软件包降级问题43个;RC1特性转测轮次开始，迭代轮次共发现Aops、编译器等特性问题60+，均定位解决并通过测试验收，有效防护特性质量; 当前社区版本有效issue共计261，新增issue总体趋势下降，符合质量预期；其中待解决issue 6个（随RC7版本全量回归）。问题修复率97.7%，版本整体质量良好，没有问题溢出的风险。

- 典型问题：
1. 软件包构建失败问题突出，整个版本发现构建失败问题107个，集中在alpha-RC2轮次, RC3才开始收敛，因为master构建工程的问题没有及时修复导致引入到24.09版本
2. 软件包降级问题突出，整个版本发现版本降级问题47个，集中在alpha轮次，相较630版本（150个）有所下降，软件包相比SP4版本降级问题主要是由于软件包更新未合入master分支导致



#### 6.2 OS集成测试迭代版本基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 24.09 alpha | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 安全专项部分测试项启动（firewalld、自研加固、加固指南）      |                       |
|                             | 操作系统默认参数对比       |                       |
|                             | 安装部署部分测试项启动       |                       |
|                             | 软件包升降级变化分析       |                       |
|                             | 指南类测试       |                       |
|                             | 内核基本功能测试       |                       |
| openEuler 24.09 RC1   | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理                      |
|                             |                  | source包自编译                 |
|                             | 安全专项         |                        |
|                             |                  | 端口扫描                       |
|                             |                  | 安全编译选项扫描               |
|                             |                  | 自研加固        |
|                             |                  | 安全加固指南测试-secure_guide  |
|                             | 性能专项         | 基础性能测试                   |
|                             | 安装部署         | 标准镜像                       |
|                             |                  | everything镜像                 |
|                             |                  | 网络镜像                       |
|                             |                  | stratovirt镜像                 |
|                             | 单包命令         | everything全量测试             |
|                             | 单包服务         | everything全量测试             |
|                             | 系统集成         | 管理员指南测试                 |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                       |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 编译器专项       | gcc测试                        |
| openEuler 24.09 RC2 | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理                      |
|                             |                  | source包自编译                 |
|                             | 安全专项         | 敏感词扫描                     |
|                             |                  | 安全编译选项扫描                     |
|                             |                  | 病毒扫描                   |
|                             | 重启专项专项     | 冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             | 系统集成         |    应用开发测试              |
|                             | 版本变化专项     | 软件范围变化测试               |
|                             | 安装部署         | 标准镜像                       |
|                             | 单包命令         | everything全量测试             |
|                             | 单包服务         | everything全量测试             |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 编译器专项       | gcc测试                        |
|                             | openjdk测试               |                     |
| openEuler 24.09 RC3 | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理（增量变动部分）      |
|                             |                  | source包自编译（增量变动部分） |
|                             | 文件系统专项     |                                |
|                             | 网络系统专项     |                                |
|                             | 安全专项         | 病毒扫描                    |
|                             |                  | 安全编译选项扫描         |
|                             |                  | 安全加固指南测试-secure_guide  |
|                             |                  | 自研加固测试               |
|                             | 性能专项         | 基础性能测试                   |
|                             | 安装部署         | 标准镜像                       |
|                             |                  | everything镜像                 |
|                             |                  | 网络镜像                       |
|                             |                  | stratovirt镜像                 |
|                             | 单包命令         | everything增量变动测试         |
|                             | 单包服务         | everything增量变动测试         |
|                             | 系统集成         | 管理员指南测试                 |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 长稳测试                  |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 多动态库检查专项 |                                |
|                             | 编译器专项       | gcc测试                        |
|                             | openjdk测试                |                     |
| openEuler 24.09 RC4 | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理（增量变动部分）      |
|                             |                  | source包自编译（增量变动部分） |
|                             | 重启专项专项     | 冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             | 安全专项         | 安全编译选项扫描               |
|                             |                  | 病毒扫描                       |
|                             |                  | 端口扫描                       |
|                             |                  | 安全加固指南测试               |
|                             |                  | 自研加固测试               |
|                             | 性能专项         | 基础性能测试                   |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 安装部署         | 标准镜像                       |
|                             | 单包命令         | everything增量变动测试         |
|                             | 单包服务         | everything增量变动测试         |
|                             | 系统集成         | 应用开发测试                 |
|                             | 内核专项         | 性能测试                   |
|                             | 编译器专项       | gcc测试                        |
| openEuler 24.09 RC5     | 冒烟测试         |                                |
|                             | docker_img测试       |                       |
|                             | 包管理专项       | rpm包管理（增量变动部分）      |
|                             |                  | source包自编译（增量变动部分） |
|                             | 单包命令         | everything增量变动测试         |
|                             | 单包服务         | everything增量变动测试         |
|                             | 内核专项         | 长稳测试                   |
|                             | 安全专项         | 开源License检查                   |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 编译器专项       | gcc测试                        |
| openEuler 24.09 RC6     |    冒烟测试   |                    |
|                             | docker_img测试       |                       |
| openEuler 24.09 RC7     |    版本发布件测试   |                    |


# 6   附件

## 遗留问题列表

| 序号 | 问题单号    | 问题简述    | 问题级别 | 影响分析   | 规避措施       | 历史发现场景     |
| ---- | ------------------------------------------------------------ | ----------------------------------------------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | [IAQEYH](https://e.gitee.com/open_euler/issues/table?issue=IAQEYH) | [24.09 RC4][deja]执行deja测试套modules.exp相关用例报错 | 主要     | 分析是调用gcc-14动态库libstdc++.so时，实际是调用系统库/usr/lib64/libstdc++.so.6 和libstdc++_nonshared.a这个多版本静态库，根据测试2的静态链接库调用构建成功说明是libstdc++_nonshared.a库中相关符号与开源不一致导致。分析全量deja测试结果，仅新增此问题，且此场景是在使用C++20以上特性-fmodule-header才会触发，应用范围较小，建议使用-static规避此问题 | 添加编译选项：runtest --tool g++ modules.exp=iostream-1* --tool_opts=-static可执行通过| |
| 2    | [IAS2H7](https://e.gitee.com/open_euler/issues/table?issue=IAS2H7) | 【24.09 RC5】【arm/x86】gsettings-desktop-schemas安装的org.gnome.system.locale带有废弃路径 | 次要 | 该问题经评审为非问题，但是需要在资料体现后更改问题单状态| | https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas/-/issues/27 |
| 3    | [IARW9Q](https://e.gitee.com/open_euler/issues/table?issue=IARW9Q) | 打印设置应用无法打开 | 次要 |打印设置应用存在问题，对系统总体应用的使用无影响，system-conf-printer得升级版本适配高版本python以及python3-cups；考虑2409已处于待发布阶段，升包比较困难。后续内部出版本时升级 | 有两种临时规避手段:1.给定环境变量后，能加载到cupshelper后再跑应用2.做软链接 |  |
| 4    | [IAQKNB](https://e.gitee.com/open_euler/issues/table?issue=IAQKNB) | 【openEuler 24.09 rc4】DDE指定操作无法删除新增管理员| 不重要     | 该问题只在特定情况下触发，单个用例不通过，影响性较小 |  |  |




# 致谢
非常感谢以下sig在openEuler 24.09 版本测试中做出的贡献,以下排名不分先后
infra-sig的各位贡献者
@wangchong1995924 @small_leek @yaolonggang @dongjie110 @cxl78320 @raomingbo @shdluan @wu_zhende @weijihui @liu-yinsi @duan_pj @wangLin0_0 @georgecao @zhongjun2 @gzbang @liuqi469227928 @wanghaosq @dakang_siji @liuyanglinun @Tom_zx @haml @qinsheng99_code
<br>
RM-sig的各位贡献者
@solarhu @chenyaqiang @paul-huang
<br>
QA-sig的各位贡献者
@zjl_long @ga_beng_cui @hanson-fang @erin_dan @丁娇 @wenjun @suhang @zhanglu626 @ssttkx @zhangpanting @wangxiaoya @MDS_ZHR @banzhuanxiaodoubi @guojuanjuan @yanglijin @clay @oh_thats_great @wangting112 @lijiaming666 @liwencheng6769 @luluyuan @lutianxiong @chenshijuan3 @laputa0 @lcqtesting @xiuyuekuang @ganqx @woqidaideshi @yjt-dli @disnight @chenshijuan3 @wangpeng_uniontech @fu-shanqing @saarloos
<br>
以及所有参与24.09 但未统计到的所有开发者
(如有遗漏可随时联系 @disnight email:fjc837005411@outlook.com 反馈)
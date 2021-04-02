![openEuler ico](../../images/openEuler.png)

版权所有 © 2021  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节 | 修改描述   |
| ---------- | -------- | -------- | ---------- |
| 2021/03/23 | 1.1.0    | 初始     | charlie_li |
| 2021/03/26 | 1.1.1    | 修复OpenStack名称 | charlie_li|
| 2021/03/30 | 1.1.2 | 添加修改遗留问题描述 | charlie_li |

关键词：

 openEuler  raspberrypi  UKUI  DDE  HA  iSula  A-Tune  kvm qemu  docker OpenStack Kubernetes xfce 内核热升级 StratoVirt 内存分级扩展 secGear  

摘要：

 文本主要描述openEuler 21.03版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：  

| 缩略语      | 英文全名                             | 中文解释       |
| ----------- | ------------------------------------ | -------------- |
| OS          | Operating system                     | 操作系统       |
| iSula       | iSula                                | 轻量级容器引擎 |
| Docker      | Docker                               | Docker容器引擎 |
| DDE         | Deepin Desktop Environment           | 深度桌面环境   |
| raspberrypi | raspberrypi                          | 树莓派         |
| HA          | high availability                    | 高可靠性       |
| CVE         | Common Vulnerabilities and Exposures | 通用漏洞批露   |

***
\***

# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 21.03版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，对版本问题单进行整体的说明。

# 2   测试版本说明

openEuler 21.03版本作为2021年首个创新版本，发布范围主要如下：

1.  内核版本升级到5.10
2.  新增组件OpenStack/xfce/Kubernetes
3.  竞争力特性：StratoVirt轻量级虚拟化功能增强和优化/内存分级扩展/内核热升级/secGear机密计算安全应用开发套件
4.  删除python2
5.  补齐/优化社区软件包生态
6.  修复bug和cve

openEuler 21.03版本按照社区release-manager团队的计划，共规划4轮测试，详细的版本信息和测试时间如下表：

| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| openEuler 21.03 RC1 | 2021-02-24   | 2021-03-02   |
| openEuler 21.03 RC2 | 2021-03-05   | 2021-03-11   |
| openEuler 21.03 RC3 | 2021-03-15   | 2021-03-19   |
| openEuler 21.03 RC4 | 2021-03-21   | 2021-03-21   |

测试的硬件环境如下：

| 硬件型号                     | 硬件配置信息                                                 | 备注                     |
| ---------------------------- | ------------------------------------------------------------ | ------------------------ |
| TaiShan 200 2280 均衡型      | HiSilicon Kunpeng 920<br/>32G*4 2933MHz<br/>LSI SAS3508<br/>TM210 | ARM服务器                |
| RH2288H V5                   | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz <br />32*4 2400MHz <br />LSI SAS3508 <br />X722 | X86服务器                |
| Huawei RH2288H V3            | Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz                    | kubernetes 1.20.2（x86） |
| Huawei TaiShan 2280          | Cortex-A72 128U512G                                          | kubernetes 1.20.2（arm） |
| TaiShan 200 2280             | Kunpeng 920<br />48 Core@2.6GHz*2<br />256GB DDR4 RAM        | ARM服务器                |
| DF723长城擎天服务器<br />    | CPU型号：FT2000+<br />CPU核数：64<br />内存：64G<br />硬盘容量：240G | ARM服务器                |
| 联想启天台式机<br/>M425-N000 | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz<br/>CPU内核总数：6<br/>内存容量：16G | X86服务器                |
| 树莓派4B卡                   | CPU:Cortex-A72 * 4 内存：8GB 存储设备：SanDisk Ultra 16GB micro SD | 默认测试环境             |
| 树莓派3B+卡                  | CPU:Cortex-A53 * 4 内存：1GB 存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境       |
| 树莓派3B卡                   | CPU:Cortex-A53 * 4 内存：1GB 存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境       |
| 支持树莓派的7寸屏            | HDMI接口，1024*600分辨率电容屏                               |                          |


 openEuler 21.03版本交付需求列表如下：

详见：<https://gitee.com/openeuler/release-management/blob/master/openEuler-21.03/release-plan.md>

| 序号 | **需求**                                                     | **状态** | **sig组**                  | **责任人**                                                   |
| :--: | ------------------------------------------------------------ | -------- | -------------------------- | ------------------------------------------------------------ |
|  1   | [openEuler 21.03 support OpenStack](https://gitee.com/openeuler/release-management/issues/I25Y6B?from=project-issue) | Accepted | sig-openstack              | [@joec88](https://gitee.com/joec88) [@liksh](https://gitee.com/liksh) |
|  2   | [openEuler 21.03 support virtualization live migration pro](https://gitee.com/openeuler/release-management/issues/I25ZB1?from=project-issue) | Accepted | sig-virt                   | [@alexchen](https://gitee.com/zhendongchen)                  |
|  3   | [openEuler 21.03 support StratoVirt function enhancement](https://gitee.com/openeuler/release-management/issues/I25ZH0?from=project-issue) | Accepted | sig-virt                   | [@alexchen](https://gitee.com/zhendongchen)                  |
|  4   | [openEuler 21.03 support Risc-v virt live migration](https://gitee.com/openeuler/release-management/issues/I25ZF1?from=project-issue) | Accepted | sig-virt                   | [@alexchen](https://gitee.com/zhendongchen)                  |
|  5   | [openEuler 21.03 support DDE](https://gitee.com/openeuler/release-management/issues/I27TT4?from=project-issue) | Accepted | sig-DDE                    | [@panchenbo](https://gitee.com/panchenbo)                    |
|  6   | [openEuler 21.03 kernel update to version 5.10](https://gitee.com/openeuler/release-management/issues/I27YGU?from=project-issue) | Accepted | sig-kernel                 | [@XieXiuQi](https://gitee.com/xiexiuqi)                      |
|  7   | [openEuler 21.03 remove python 2 from release](https://gitee.com/openeuler/release-management/issues/I29EV9?from=project-issue) | Accepted | sig-python-modules         | [@yaqiangchen](https://gitee.com/yaqiangchen)                |
|  8   | [openEuler 21.03 support xfce 4.14](https://gitee.com/openeuler/release-management/issues/I29LTB?from=project-issue) | Accepted | xfce                       | [@dillon_chen](https://gitee.com/dillon_chen)                |
|  9   | [openEuler 21.03 support 内存分级扩展](https://gitee.com/openeuler/release-management/issues/I2C2NY?from=project-issue) | Accepted | memig                      | [@liuzhiqiang26](https://gitee.com/liuzhiqiang26)            |
|  10  | [openEuler 21.03 support 内核热升级](https://gitee.com/openeuler/release-management/issues/I2B057?from=project-issue) | Accepted | sig-ops                    | [@EulerOSWander](https://gitee.com/EulerOSWander)            |
|  11  | [openEuler 21.03 support secGear](https://gitee.com/openeuler/release-management/issues/I2B0KY?from=project-issue) | Accepted | sig-confidential-computing | [@chenmaodong](https://gitee.com/chenmaodong)                |
|  12  | [openEuler 21.03 support RaspberryPi](https://gitee.com/openeuler/release-management/issues/I2CVE3) | Accepted | sig-RaspberryPi            | [@woqidaideshi](https://gitee.com/woqidaideshi)              |
|  13  | [openEuler 21.03 support UKUI](https://gitee.com/openeuler/release-management/issues/I2E61C) | Accepted | sig-UKUI                   | [@dou33](https://gitee.com/dou33)                            |
|  14  | [openEuler 21.03 support HA](https://gitee.com/openeuler/release-management/issues/I2E5R3?from=project-issue) | Accepted | sig-HA                     | [@yangzhao_kl](https://gitee.com/yangzhao_kl)                |
|  15  | [openEuler 21.03 support StratoVirt microvm image](https://gitee.com/openeuler/release-management/issues/I2P83D?from=project-issue) | Accepted | sig-virt                   | [@alexchen](https://gitee.com/zhendongchen)                  |
|  16  | [openEuler 21.03 support Kubernetes](https://gitee.com/openeuler/release-management/issues/I2CMA0?from=project-issue) | Accepted | sig-cloudnative            | [@jingxiaolu](https://gitee.com/jingxiaolu)                  |
|  17  | [openEuler 21.03 update SPDK](https://gitee.com/openeuler/release-management/issues/I35A62) | Accepted | Storage                    | [@liuzhiqiang](https://gitee.com/liuzhiqiang26)              |
|  18  | [openEuler 21.03 update some software](https://gitee.com/openeuler/release-management/issues/I35BTA) | Accepted | release-management         | [@chenyaqiang](https://gitee.com/yaqiangchen)                |
|  19  | [openEuler 21.03 slim container base image](https://gitee.com/openeuler/release-management/issues/I35D25) | Accepted | sig-cloudnative            | [@jingxiaolu](https://gitee.com/jingxiaolu)                  |



本次创新版本测试活动分工如下：

| **需求**                                   | **开发主体**               | **测试主体**    | **测试策略**                                                 |
| :----------------------------------------- | -------------------------- | --------------- | ------------------------------------------------------------ |
| 支持树莓派发布件                           | sig-RaspberryPi            | sig-RaspberryPi | 树莓派sig组对树莓派发布件进行安装、系统信息查询、用户管理功能、软件管理功能、进程管理、网络管理等基本功能；开展硬件兼容性测试包括3B、3B+、4B开发板；完成稳定性相关测试 |
| 支持UKUI3.0桌面                            | sig-UKUI                   | sig-UKUI        | UKUIsig组验证UKUI桌面系统在openEuler系统上的安装部署、核心功能测试、重要组件的测试和系统插件测试，终端关注基本功能和稳定性 |
| 支持HA软件                                 | sig-HA                     | sig-HA          | HAsig组验证HA软件的安装部署和基本功能，重点关注软件服务的可靠性(资源异常、网络异常等) |
| 支持DDE桌面                                | sig-DDE                    | sig-DDE         | DDEsig组验证DDE在openEuler系统上的安装部署、基础组件与预装应用核心功能测试和UI测试 |
| 支持OpenStack V版本                        | sig-openstack              | sig-openstack   | openstack sig组重点验证nova\placement\neutron\cinder\glance\keystone\ironic等模块的安装部署、基本功能(虚机/裸机、卷、网络等资源管理)；覆盖API测试、功能测试和集成测试；另外关注组件的长稳测试 |
| 支持xfce 4.14桌面                          | sig-xfce                   | sig-xfce        | xfcesig组验证xfce在openEuler系统上的安装部署、重要组件和系统插件的基本功能和稳定性 |
| 支持热迁移/StratoVirt增强/Risc-v架构热迁移 | sig-virt                   | sig-QA          | QAsig组对StratoVirt组件TLS多通道热迁移和脏页率查询两个特性开展接口、功能、可靠性和性能的测试；支持热迁移发布范围的基本功能和稳定性及性能指标；对内存弹性(balloon)、内存大页支持、iothread、ioqos覆盖功能、可靠性、安全及性能测试 |
| 内核升级到5.10                             | sig-kernel                 | sig-QA          | QAsig组验证5.10内核的基本功能、稳定性、性能等指标            |
| 移除python2                                | sig-python-modules         | sig-QA          | QAsig组验证python2是否移除干净及其他原有对python2有依赖关系的包是否能在移除后的安装和功能完整性 |
| 支持内存分级扩展                          | sig-Storage                | sig-QA          | QAsig组验证etmem特性的基本功能、可靠性、性能及稳定性测试     |
| 支持内核热升级                             | sig-ops                    | sig-QA          | QAsig组验证内核热替换功能的完整性，保证能够快速启动内核和程序的迁移实现 |
| 支持secGear安全机密计算安全应用开发套件    | sig-confidential-computing | sig-QA          | QAsig组验证在X86场景下开发套件的接口、基本功能、可靠性和稳定性 |
| 发布StratoVirt microvm_image               | sig-virt                   | sig-QA          | QAsig组针对此发布件进行镜像的检查和镜像的使用验证，保证镜像启动虚机的基本功能可用性和虚机启动及底噪性能指标 |
| 集成 kubernetes及最简部署的依赖组件        | sig-CloudNative            | sig-QA          | QAsig组验证K8S组件在openEuler版本上的安装部署、基本功能一致性 |
| 容器基础镜像大小优化                       | sig-CloudNative            | sig-QA          | QAsig组验证发布容器基础镜像规格是否符合，容器镜像启动容器后的满足用户基本可用，能够通过配置repo安装所需软件 |
| 版本其它继承需求及整体继承验证             |                            | sig-QA          | QAsig组按照继承策略对继承需求进行质量保障和系统整体集成能力  |

# 3   版本概要测试结论

openEuler 21.03版本整体测试按照release-manager团队的计划，共完成了两轮全量测试+一轮回归+一轮版本发布验收测试；其中第一轮全量测试聚焦在新特性和系统重要组件的基本功能验证，旨在识别发现阻塞性问题，并开展了安全扫描、性能摸底测试；第二轮对版本发布特性进行全量测试，覆盖新特性和继承特性所有功能，按照版本策略开展各类专项测试，包括安全fuzz测试、可靠性和稳定性及特性性能测试；第三轮回归测试重点对问题单以及问题单较集中模块/组件进行重点覆盖，除验证问题的修复程度还开展相应的组件自动化功能覆盖测试，并且开展文档资料测试和安全漏洞扫描；最后一轮验收测试主要进行问题单回归和文档资料测试及交付件的病毒扫描。

openEuler 21.03创新版本按照既定的测试策略和测试计划完成所有规划测试任务。本版本社区搜集需求23个，实际交付19个，交付率82.6%，4个需求因赶不上版本节奏，release-manager团队按照社区规范绝收，所有交付需求均已完成验证。版本测试共发现问题266个，遗留问题6个(详见遗留问题章节)，其他问题均已修复，回归测试通过，版本整体质量较好。

# 4   版本详细测试结论

openEuler 21.03版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器的全量功能验证，组件和特性质量较好；

2、完成新增特性的测试验证，对应组件质量较好；对继承特性采用继承策略完成验证，特性质量较好；

2、新增软件包通过软件包专项完成了软件包的安装卸载、编译、命令行、服务检查等测试，软件包生态补齐测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试； 

## 4.1   特性测试结论

### 4.1.1   继承特性评价

| 序号 | 组件/特性名称                        |          质量评估          | 备注                                                         |
| ---- | :----------------------------------- | :------------------------: | :----------------------------------------------------------- |
| 1    | 内核                                 | <font color=green>█</font> | 继承内核已有测试能力，通过开源测试套LTP对内核基本功能完成测试；通过开源测试套syzkaller进行fuzz测试；发现问题均已修复，内核整体质量良好 |
| 2    | 容器(isula/docker/安全容器/系统容器) | <font color=green>█</font> | 覆盖容器领域iSula和docker引擎，安全容器、系统容器、普通容器的全量功能测试；容器领域相关特性整体质量良好 |
| 3    | 编译器(gcc/jdk)                      | <font color=green>█</font> | 对gcc/jdk组件使用开源功能测试套deja和jtreg开展功能全量测试，组件整体质量良好 |
| 4    | vCPU热插                             | <font color=green>█</font> | 虚拟机支持vCPU热插，特性用例全量测试，质量良好               |
| 5    | vMEM热插                             | <font color=green>█</font> | 虚拟机支持vMEM热插，特性用例全量测试，质量良好               |
| 6    | vmtop                                | <font color=green>█</font> | VMTop当前仅支持aarch64，特性用例全量测试，质量良好           |
| 7    | vCPU支持Custom                       | <font color=green>█</font> | 虚拟机vCPU支持Custom，特性用例全量测试，质量良好             |
| 8    | 虚拟机安全启动                       | <font color=green>█</font> | 虚拟机支持安全启动，特性用例全量测试，质量良好               |
| 10   | A-Tune                               | <font color=green>█</font> | 操作系统性能调优引擎，特性功能用例全量测试，重点验证调优框架的功能，质量良好 |
| 11   | lm_sensors                           | <font color=green>█</font> | 监控CPU、主板温度的小工具，在Taishan 2280、RH2288V5等硬件上验证功能，质量良好 |
| 12   | UKUI桌面                             | <font color=green>█</font> | 经过两轮全量测试，覆盖整体核心功能、重要组件和系统插件测试，整体桌面质量良好 |
| 13   | 树莓派                               | <font color=green>█</font> | 完成功能测试，覆盖镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成硬件兼容性测试，包括树莓派3B、3B+、4B开发板的USB接口、HDMI接口、以太网接口、Wi-Fi、蓝牙的兼容性验证；完成稳定性测试，包括reboot100次自动化测试；整体质量良好 |
| 14   | 安装部署                             | <font color=green>█</font> | 覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署；安装部署功能质量良好 |
| 15   | DDE桌面                              | <font color=green>█</font> | 共执行两轮测试，共执行用例240条，主要覆盖了基础组件跟预装应用核心功能以及基本UI测试。整体核心功能基本可满足使用。 |
| 16   | 支持高可用HA                         | <font color=blue>▲</font>  | 共执行三轮测试，执行测试用例87条，主要覆盖HA的基本能力；在各类资源异常失效情况下的切换能力；日志收集功能及网络故障异常场景下的HA功能，通过长时间测试，稳定性良好，特性基本可用。 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

| 序号 | 特性名称                            | 约束依赖说明                                                 | 遗留问题单          |          质量评估          | 备注                                                         |
| :--: | ----------------------------------- | :----------------------------------------------------------- | ------------------- | :------------------------: | ------------------------------------------------------------ |
|  1   | 软件包生态补齐                      | <center>NA</center>                                          | <center>NA</center> | <font color=green>█</font> | 对软件包开展管理(安装/卸载/编译)及命令/服务/软件包加固测试(fuzz/场景)，质量良好 |
|  2   | 支持OpenStack                       | <center>NA</center>                                          | <center>NA</center> | <font color=blue>▲</font>  | 使用开源继承测试套Tempest共执行用例1141个，主要覆盖了API测试和功能测试，并开展7*24的长稳测试，整体功能基本可用。注：OpenStack V版中明确废弃的功能和接口不在测试范围 |
|  3   | 虚拟化热迁移加强                    | 支持同型号CPU间迁移                                          | <center>NA</center> | <font color=green>█</font> | 对qemu热迁移特性覆盖接口测试、可靠性测试、性能测试，共计用例58个，质量良好 |
|  4   | StratoVirt增强                      | 内存弹性约束：内核镜像需支持balloon特性，当前仅支持host与guest端页面大小相同的场景。<br />ioqos约束：限速范围[0, 1000000]，暂不支持热插，只能限制平均iops，无法限制突发流量。<br />iothread约束：总的io线程数量不超过8个，暂不支持热插。<br />内存大页：仅支持在stratovirt启动时在命令行中配置，仅支持静态大页，配置的内存规格不能大于配置的host大页总大小。 | <center>NA</center> | <font color=green>█</font> | stratovirt新增特性，内存弹性共20个用例，ioqos共10个用例，iothread共24个用例，内存大页共61个用例，多平支持共2个用例。覆盖功能测试、可靠性测试、安全测试和性能测试；整体质量良好 |
|  5   | 移除python2                         | <center>NA</center>                                          | <center>NA</center> | <font color=green>█</font> | 检查版本交付件中python2相关移除情况，验证移除python2后其他软件包的管理操作(安装/卸载/编译) |
|  6   | 支持xfce桌面                        | <center>NA</center>                                          | <center>NA</center> | <font color=green>█</font> | 共经过两轮测试，执行103个测试项，整体核心功能(重要组件和系统插件)稳定正常，整体质量良好 |
|  7   | 内存分级扩展                           | 客户端和服务端需要在同一个服务器上部署，不支持跨服务器通信的场景<br />仅支持扫描进程名小于或等于15个字符长度的目标进程 | <center>NA</center> | <font color=green>█</font> | 共计执行90个用例，覆盖范围包括特性的功能、可靠性，安全和性能；整体质量良好 |
|  8   | 内核热升级                      | nvwa需要关闭selinux <br />当前支持arm架构                    | <center>NA</center> | <font color=green>█</font> | 共计执行用例49个，主要覆盖了基本功能测试、可靠性测试、安全测试以及压力测试；整体功能基本可用 |
|  9   | 支持secGear                         | 当前支持x86，依赖对应的sgx硬件平台环境和sgx SDK<br />暂不支持两步签名 | <center>NA</center> | <font color=green>█</font> | 共计执行100个用例，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试；质量良好 |
|  10  | 集成 kubernetes及最简部署的依赖组件 | <center>NA</center>                                          | <center>NA</center> | <font color=blue>▲</font>  | 共执行311个用例，主要覆盖了功能一致性测试，架构x86和arm均测试通过；整体功能基本可用 |
|  11  | 容器基础镜像大小优化                | <center>NA</center>                                          | <center>NA</center> | <font color=green>█</font> | 验证容器镜像裁剪后大小规格<300M;容器镜像可作为基础镜像的能力；质量良好 |
|  12  | StratoVirt的microvm_image发布       | StratoVirt轻量虚拟化场景下使用的镜像，支持aarch64和x86两个架构，仅作用户体验，不建议直接商用 | <center>NA</center> | <font color=blue>▲</font>  | 共执行50个用例，主要覆盖虚拟机镜像基本能力；镜像基本可用     |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   南向兼容性

openEuler操作系统南向兼容性完成两款整机服务器的验证，详细信息见下表：

| 硬件型号              | 硬件详细信息                                                                                          |
| --------------------- | ----------------------------------------------------------------------------------------------------- |
| TaiShan200 2280服务器 | CPU型号：HiSilicon Kunpeng 920<br />CPU核数：128<br />内存：32G*8<br />网卡：Hi1822                   |
| RH2288H V5服务器      | CPU型号：Intel(R) Xeon(R) Gold 6266C CPU@3.00GHZ<br />CPU核数：44<br />内存：12*32G<br />网卡：Hi1822 |

树莓派系统南向兼容性完成三款树莓派硬件的验证，详细信息见下表:

| 硬件型号    | 硬件详细信息                                                 |
| ----------- | ------------------------------------------------------------ |
| 树莓派4B卡  | CPU:Cortex-A72 *<br /> 4 内存：8GB <br />存储设备：SanDisk Ultra 16GB micro SD |
| 树莓派3B+卡 | CPU:Cortex-A53 * 4 <br />内存：1GB <br />存储设备：SanDisk Ultra 16GB micro SD |
| 树莓派3B卡  | CPU:Cortex-A53 * 4<br />内存：1GB <br />存储设备：SanDisk Ultra 16GB micro SD |

### 4.2.3   北向兼容性

北向兼容性当前openEuler21.03创新版本经过验证的软件见下表：

| 软件名称  | 软件版本信息 |
| --------- | ------------ |
| unixbench | 5.1.3        |
| lmbench   | 3            |
| mysql     | 8.0.17       |
| netperf   | 2.7.0        |
| spark     | 2.3.0        |

## 4.3   专项测试结论

### 安全测试

整体安全测试覆盖：

1、linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/安全编译选项/交付件病毒扫描

3、白盒安全测试主要通过fuzz测试实现对接口参数类和内存管理类进行覆盖；通过部署kasan版本的内核，进行syzkaller测试；对重点软件包开展oss-fuzz测试；

4、针对安全加固指南中的加固项，进行全量测试。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                 |
| ------------ | ------------------------------------------------------------ | ------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7*24小时 |
| 特性长稳测试 | 对特性交付相关功能进行并发、压力、反复、异常测试，过程中关注功能运行及内存以及cpu使用率等情况 | 特性可靠性及稳定性较好   |

### 性能测试 

| **指标大项 ** | **指标小项**                                                 | **指标值**              | 测试结论                                   |
| ------------- | ------------------------------------------------------------ | ----------------------- | ------------------------------------------ |
| OS基础性能    | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考LTS版本相应指标基线 | 5.10内核版本系统与4.19内核基础性能基本持平 |
| 特性相关性能  | 内存分级扩展特性在MySQL场景下，内存节省达到50%，性能下降不超过15%<br />虚拟机热迁移速度较单通道迁移提升20% | 参考特性相应性能指标    | 性能规格满足需求指标要求                   |


# 5   问题单统计

openEuler 21.03版本共发现问题单266个，有效问题253个，其中修复问题单247个，回归均通过，另外转需求问题单2个，遗留问题单6个。详细分布见下表:

| 测试阶段            | 问题单数 |
| ------------------- | -------- |
| openEuler 21.03 RC1 | 157      |
| openEuler 21.03 RC2 | 77       |
| openEuler 21.03 RC3 | 28       |
| openEuler 21.03 RC4 | 4        |

整体看版本问题单收敛趋势明显。

# 6   附件

## 遗留问题列表

| 序号 | 问题单号                                                     | 问题简述                                                     | 问题级别 | 影响分析                                                     | 规避措施                                                     |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | [I39AN0](https://gitee.com/open_euler/dashboard/issues?id=I39AN0) | arm物理机出现内核报错ACPI CPPC: Failed to find PCC channel for subspace 0 | 次要     | 根因：BIOS上报的pcc共享内存属性为loader data,该地址是不允许os request的，需要BIOS上报正确的属性<br />影响：arm 64 cpu调频失败 | 协调推动BIOS解决                                             |
| 2    | [I39MQQ](https://gitee.com/open_euler/dashboard/issues?id=I39MQQ) | 字符界面login处使用上下方向键后导致输入异常，无法正常进行用户登录 | 次要     | 根因：上游社区修复bug引入，当前上游社区无更好解决方案<br />影响：持续跟踪上游社区，用户侧非功能问题，无意中误操作该方式，直接回车重新输入即可，影响较小 | 在login的时候避免使用键盘上下键操作                          |
| 3    | [I3A8YY](https://gitee.com/open_euler/dashboard/issues?id=I3A8YY) | nfs-blkmap服务停止状态failed                                 | 次要     | 根因：nfs-blkmap服务为blkmapd-pNFS块布局映射守护程序的守护服务，该服务目前存在启动后缺少/var/lib/nfs/rpc_pipefs/nfs/blocklayout，上游社区同步存在<br />影响：不影响nfs-utils基本功能，影响较小 | 持续跟踪上游社区解决情况                                     |
| 4    | [I3AB65](https://gitee.com/open_euler/dashboard/issues?id=I3AB65) | SCAP Security guide 不支持对opss（通用操作系统保护配置文件）的检查 | 主要     | 根因：openEuler版本中带有openSACP，使用openSCAP进行扫描时，发现智能使用其他OS厂商的基线库，缺失openEuler对应基线库<br />影响：此功能用例进行安全配置检查和后续审核的自动化，涵盖每个安全规则配置文件的HTML指南，不影响openSCAP的功能使用 | 后续版本增加openEuler配置基线库                              |
| 5    | [I3A52C](https://gitee.com/open_euler/dashboard/issues?id=I3A52C) | 【21.03】samba服务启动失败                                   | 次要     | 根因：samba代码对于SIGTERM的处理，执行结果返回127，实际systemctl stop操作已经生效，samba服务被结束，但显示为fail，上游社区同步存在<br />影响：不影响功能 | 持续跟踪上游社区解决情况                                     |
| 6    | [I3EAS1]( https://gitee.com/open_euler/dashboard/issues?id=I3EAS1) | [21.03]arm/x86 的megaraid卡类型物理机上echo c > /proc/sysrq-trigger后kdump无法生成vmcore | 主要     | 根因：第二内核启动过程中会触发设备复位(reset_devices)操作，但设备复位操作后MegaRAID控制器或磁盘状态故障，导致访问MegaRAID卡下挂的磁盘报错(vmcore文件需要写入这些磁盘保存)；<br/>影响：带有该MegaRAID卡的机器上kdump触发启动第二内核过程中一直报磁盘访问错误，导致第二个内核启动过程中生成vmcore失败； | 1.linux上游社区主线版本同样有问题，持续跟踪上游社区解决情况；<br />2.在物理机/etc/sysconfig/kdump文件中将第二内核启动默认参数中的reset_devices去掉，可以成功生成vmcore，即可规避该问题； |

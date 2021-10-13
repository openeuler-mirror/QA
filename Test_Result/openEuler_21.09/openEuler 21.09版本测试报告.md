![openEuler ico](../../images/openEuler.png)

版权所有 © 2021  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节 | 修改描述   |
| ---------- | -------- | -------- | ---------- |
| 2021/09/28 | 1.1.0    | 初始     | charlie_li |

关键词：

 openEuler  raspberrypi  UKUI  DDE  HA  iSula  A-Tune  kvm qemu  docker openStack Kubernetes xfce 内核热升级 StratoVirt etmem secGear openResty KubeSphere pkgship eggo kubeOS secPave

摘要：

 文本主要描述openEuler 21.09版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析及需求交付情况对版本整体质量进行评估和总结。

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

本文主要描述openEuler 21.09版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，对版本问题单进行整体的说明。

# 2   测试版本说明

openEuler 21.09版本是欧拉全新发布后的第一个社区版本，实现了全场景支持，发布范围主要如下：

1.  内核版本为5.10，GCC升级到10.3.0
2.  支持KubeSphere 3.1.0/OpenStack Wallaby版本/支持specPave/支持eggo/发布kubeOS/内存分级扩展增强/支持OpenResty 1.19.3.1/StratoVirt2.0支持最小集/支持架构感知、配置溯源、智能定位/支持兆芯处理器和飞腾处理器
3.  DDE版本升级/DDE新增支持画板、音乐和影院应用；UKUI新增中文输入法和多媒体支持
4.  发布openEuler 嵌入式镜像和边缘协同框架（kubeedge）
5.  修复bug和cve

openEuler 21.09版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| openEuler 21.09 RC1 | 2021-08-16   | 2021-08-27   |
| openEuler 21.09 RC2 | 2021-08-30   | 2021-09-03   |
| openEuler 21.09 RC3 | 2021-09-06   | 2021-09-10   |
| openEuler 21.09 RC4 | 2021-09-13   | 2021-09-15   |
| openEuler 21.09 RC5 | 2021-09-22   | 2021-09-26   |

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


 openEuler 21.09版本交付需求列表如下：

详见：<https://gitee.com/openeuler/release-management/blob/master/openEuler-21.09/release-plan.md>

| 序号 | **需求**                                                     | **状态** | **sig组**                  | **责任人**                                                   |
| :--: | ------------------------------------------------------------ | -------- | -------------------------- | ------------------------------------------------------------ |
|  1   | [【openEuler 21.09】GCC升级到10.3.0版本](https://gitee.com/openeuler/release-management/issues/I3U85C) | Accepted | Compiler                   | [@Haijian.Zhang](https://gitee.com/open_euler/dashboard/members/haijianzhang) ,[@eastb233](https://gitee.com/open_euler/dashboard/members/eastb233) |
|  2   | [【openEuler 21.09】openEuler 21.09 支持 KubeSphere 3.1.0](https://gitee.com/openeuler/release-management/issues/I3VFAU) | Accepted | SIG-KubeSphere             | [@Feynman](https://gitee.com/feynmanzhou) ,[@Calvin](https://gitee.com/calvinyu), [@Joey](https://gitee.com/imjoey) |
|  3   | [【openEuler 21.09】openEuler 21.09 支持 OpenStack Wallaby]() | Accepted | SIG-OpenStack              | [@joec88](https://gitee.com/joec88) [@huangtianhua](https://gitee.com/huangtianhua) @xiyuanwang [@zh-f](https://gitee.com/zh-f) [@liksh](https://gitee.com/liksh) [@zhangy1317](https://gitee.com/zhangy1317) |
|  4   | [【openEuler 21.09】交付secPaver](https://gitee.com/openeuler/release-management/issues/I41F6S) | Accepted | SIG-Security_facility      | [@HuaxinLuGitee](https://gitee.com/HuaxinLuGitee)            |
|  5   | [【openEuler 21.09】eggo：一键式、轻量化、可配置集群部署](https://gitee.com/openeuler/release-management/issues/I41F61) | Accepted | SIG-CloudNative            | [@jingwoo](https://gitee.com/jingwoo)                        |
|  6   | [【openEuler 21.09】kubOS：运行内存消耗<150M,重启时间<15s](https://gitee.com/openeuler/release-management/issues/I41F5Z) | Accepted | SIG-CloudNative            | [@radeon92](https://gitee.com/radeon92)                      |
|  7   | [【openEuler 21.09】内存分级扩展框架增强，新增用户态swap及策略框架，性能降低<15%](https://gitee.com/openeuler/release-management/issues/I41F5A) | Accepted | SIG-Storage                | [@whoisxxx](https://gitee.com/whoisxxx)                      |
|  8   | [【openEuler 21.09】 openEuler 21.09 支持 OpenResty 1.19.3.1](https://gitee.com/openeuler/release-management/issues/I427HO) | Accepted | SIG-OpenResty              | [@Joey](https://gitee.com/imjoey) [@fukiki](https://gitee.com/fukiki) [@fuchangjie](https://gitee.com/fu_changjie) [@Jacean](https://gitee.com/Jacean) |
|  9   | [【openEuler 21.09】openEuler 21.09 支持树莓派](https://gitee.com/open_euler/dashboard?issue_id=I3VBFP) | Accepted | RaspberryPi                | @jianminw                                                    |
|  10  | [【openEuler 21.09】openEuler 21.09 支持UKUI](https://gitee.com/open_euler/dashboard?issue_id=I3VCTS) | Accepted | sig_UKUI                   | @dou33                                                       |
|  11  | [【openEuler 21.09】openEuler 21.09 支持XFCE](https://gitee.com/open_euler/dashboard?issue_id=I3VCZG) | Accepted | sig-xfce                   | @dillon_chen                                                 |
|  12  | [【openEuler 21.09】openEuler 21.09 支持HA](https://gitee.com/open_euler/dashboard?issue_id=I3VD4H) | Accepted | sig-HA                     | @yangzhao_kl                                                 |
|  13  | [【openEuler 21.09】openEuler DDE版本升级](https://gitee.com/open_euler/dashboard?issue_id=I3VE7L) | Accepted | sig-DDE                    | @panchenbo                                                   |
|  14  | [【openEuler 21.09】openEuler 21.09 DDE支持画板，音乐和影院应用](https://gitee.com/open_euler/dashboard?issue_id=I3VE7A) | Accepted | sig-DDE                    | @panchenbo                                                   |
|  15  | 【openEuler 21.09】Stratovirt 2.0支持最小集                  | Accepted | sig-virt                   | @cellfaint                                                   |
|  16  | 【openEuler 21.09】openEuler 21.09 支持XFCE                  | Accepted | xfce                       | @dillon_chen                                                 |
|  17  | 【openEuler 21.09】 支持飞腾FT2500双路服务器                 | Accepted | kernel                     | @xiexiuqi                                                    |
|  18  | 【openEuler-21.09】支持兆芯处理器平台                        | Accepted | kernel                     | @xiexiuqi                                                    |
|  19  | [openEuler-21.09] 21.09继承secGear                           | Accepted | sig-confidential-computing | @chenmaodong                                                 |
|  20  | [openEuler-21.09] 21.09继承轻量虚拟化StratoVirt              | Accepted | sig-virt                   | @cellfaint                                                   |
|  21  | [openEuler-21.09] 21.09继承容器(docker/isula)等特性          | Accepted | isulad                     | @lifeng2221dd1                                               |
|  22  | 【openEuler-21.09】arm64: Add config switch and kernel parameter for CPU0 hotplug | Accepted | kernel                     | @xiexiuqi                                                    |
|  23  | 【openEuler-21.09】 add options to tuning the prefetch prolicy for HIP08 | Accepted | kernel                     | @xiexiuqi                                                    |
|  24  | 【openEuler-21.09】introduce qos scheduler for co-location   | Accepted | kernel                     | @xiexiuqi                                                    |
|  25  | 【openEuler-21.09】memcg: enable memcg oom-kill for __GFP_NOFAIL | Accepted | kernel                     | @xiexiuqi                                                    |
|  26  | [openEuler-21.09] stnp 加速 clear_page                       | Accepted | kernel                     | @xiexiuqi                                                    |
|  27  | 【openEuler-21.09】memcg: enable memcg oom-kill for __GFP_NOFAIL | Accepted | kernel                     | @xiexiuqi                                                    |
|  28  | [openEuler-21.09] 21.09继承secGear、虚拟化、容器等特性       | Accepted |                            |                                                              |
|  29  | 【openEuler-21.09】openEuler支持嵌入式镜像                   | Accepted | sig-embedded               |                                                              |
|  30  | 【openEuler-21.09】openEuler支持边缘协同框架（kubeedge）     | Accepted | sig-edge                   |                                                              |



本次创新版本测试活动分工如下：

| **需求**                                                 | **开发主体**          | **测试主体**    | **测试策略**                                                 |
| :------------------------------------------------------- | --------------------- | --------------- | ------------------------------------------------------------ |
| 支持树莓派发布件                                         | sig-RaspberryPi       | sig-RaspberryPi | 树莓派sig组对树莓派发布件进行安装、系统信息查询、用户管理功能、软件管理功能、进程管理、网络管理等基本功能；开展硬件兼容性测试包括3B、3B+、4B开发板；完成稳定性相关测试 |
| 支持UKUI3.0桌面                                          | sig-UKUI              | sig-UKUI        | UKUIsig组验证UKUI桌面系统在openEuler系统上的安装部署、核心功能测试、重要组件的测试和系统插件测试，终端关注基本功能和稳定性 |
| 支持HA软件                                               | sig-HA                | sig-HA          | HAsig组验证HA软件的安装部署和基本功能，重点关注软件服务的可靠性(资源异常、网络异常等) |
| 支持DDE桌面                                              | sig-DDE               | sig-DDE         | DDEsig组验证DDE在openEuler系统上的安装部署、基础组件与预装应用核心功能测试和UI测试 |
| 支持openStack W版本                                      | sig-openstack         | sig-openstack   | openstack sig组重点验证nova\neutron\cinder\glance\keystone\ironic\glance\Trove\swift\kolla等模块的安装部署、基本功能(虚机/裸机、卷、网络等资源管理)；覆盖API测试、功能测试和集成测试；另外关注组件的长稳测试 |
| 支持xfce 4.14桌面                                        | sig-xfce              | sig-xfce        | xfcesig组验证xfce在openEuler系统上的安装部署、重要组件和系统插件的基本功能和稳定性 |
| 支持KubeSphere                                           | sig-KubeSphere        | sig-KubeSphere  | KubeSphere sig组验证安装部署以及对容器应用的基本运维功能     |
| 支持secPave                                              | sig-Security_facility | sig-QA          | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
| 支持eggo                                                 | sig-CloudNative       | sig-CloudNative | 验证eggo在openEuler上的安装部署以及提供的部署K8S集群的能力   |
| 支持kubeOS                                               | sig-CloudNative       | sig-QA          | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 |
| etmem内存分级扩展框架增强                                | sig-Storage           | sig-QA          | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
| 支持OpenResty 1.19.3.1                                   | sig-OpenResty         | sig-OpenResty   | 验证openResty平台在openEuler版本上的可安装性和基本功能       |
| 支持兆芯处理器                                           | sig-kernel            | sig-QA          | 验证openEuler版本在兆芯处理器上的可安装和可使用性            |
| 支持飞腾FT2500双路服务器                                 | sig-kernel            | sig-QA          | 验证openEuler版本在FT2500处理器上的可安装和可使用性          |
| 支持isulad shimV2对接K8S                                 | sig-CloudNative       | sig-CloudNative | 验证使用shimV2方式时，isular容器引擎对容器尤其安全容器场景下的基本管理功能 |
| 版本其它继承需求及整体继承验证                           |                       | sig-QA          | QAsig组按照继承策略对继承需求进行质量保障和系统整体集成能力  |
| 【openEuler-21.09】openEuler支持嵌入式镜像               | sig-embedded          | sig-embedded    | 验证嵌入式版本的轻量化、安全加固及容器功能                   |
| 【openEuler-21.09】openEuler支持边缘协同框架（kubeedge） | sig-edge              | sig-edge        | 验证kubeedge框架提供的云和边缘侧安装部署、元数据同步能力     |

# 3   版本概要测试结论

openEuler 21.09版本整体测试按照release-manager团队的计划，共完成了三轮全量测试+一轮回归+一轮版本发布验收测试；其中第一轮全量测试聚焦在新特性和系统重要组件的基本功能验证，旨在识别发现阻塞性问题，并开展了安全扫描、性能摸底测试；第二轮对版本发布特性进行全量测试，覆盖新特性和继承特性所有功能，按照版本策略开展各类专项测试，包括安全fuzz测试、可靠性和稳定性及特性性能测试；第三轮对补充特性开展全量测试，重点覆盖基本功能；回归测试重点对问题单以及问题单较集中模块/组件进行重点覆盖，除验证问题的修复程度还开展相应的组件自动化功能覆盖测试，并且开展文档资料测试和安全漏洞扫描；最后一轮验收测试主要进行问题单回归和文档资料测试及交付件的病毒扫描。

openEuler 21.09创新版本按照既定的测试策略和测试计划完成所有规划测试任务。本版本社区搜集需求30个，实际交付30个，交付率100%，所有交付需求均已完成验证。版本测试共发现问题233个，遗留问题4个(详见遗留问题章节)，4个问题转需求其他问题均已修复，回归测试通过，版本整体质量较好。

# 4   版本详细测试结论

openEuler 21.09版本详细测试内容包括：

 1、完成重要组件包括内核、容器、虚拟化、编译器的全量功能验证; 对新增需求完成基本功能、稳定性等测试；对继承特性采用继承策略；版本整体交付组件和特性质量较好；

2、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成功能无风险；

3、专项测试包括性能专项、安全专项、可靠性测试；整体风险可控

## 4.1   特性测试结论

### 4.1.1   继承特性评价

| 序号 | 组件/特性名称                             | 质量评估                   | 备注                                                         |
| ---- | :---------------------------------------- | :------------------------- | :----------------------------------------------------------- |
| 1    | 内核                                      | <font color=green>█</font> | 继承内核已有测试能力，通过使用开源测试套LTP和mmtest对内核开展基本功能进行测试；并利用syzkaller开源测试套进行fuzz测试；通过构建系统压力，反复长时间随机执行LTP基本系统调用，对内核开展7*24小时的稳定性测试，整体用例执行通过；内核整体质量良好 |
| 2    | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | 覆盖容器领域iSula和docker引擎的基本能力，针对安全容器、系统容器、普通容器和容器镜像进行功能/可靠性/稳定性测试，共执行用例742个，用例执行全部通过，整体质量良好 |
| 3    | 编译器(gcc/jdk)                           | <font color=green>█</font> | 对gcc/jdk组件使用开源功能测试套deja和jtreg开展功能全量测试，组件整体质量良好 |
| 4    | 虚拟化                                    | <font color=green>█</font> | 继承虚拟化已有测试能力，基于Avocado-VT开源测试套完成对qemu/StratoVirt的功能/可靠性验证，共执行用例7K+，组件整体质量良好 |
| 5    | A-Tune                                    | <font color=green>█</font> | A-Tune作为操作系统性能调优引擎，完成特性查询负载类型、分析负载类型并自优化、自调优以及模型训练输入数据集的训练等功能用例全量测试，并从高压力负载和长时间运行两个方面对A-Tune功能进行验证，共计执行用例123个，特性整体质量良好 |
| 6    | 安装部署                                  | <font color=green>█</font> | 覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署；安装部署功能质量良好 |
| 7    | 支持高可用HA                              | <font color=green>█</font> | 共执行三轮测试，执行测试用例87条，主要覆盖HA的基本能力；在各类资源异常失效情况下的切换能力；日志收集功能及网络故障异常场景下的HA功能，通过长时间测试，稳定性良好，特性基本可用。 |
| 8    | 集成xfce 4.14                             | <font color=green>█</font> | 共经过两轮测试，执行103个测试项，整体核心功能(重要组件和系统插件)稳定正常，整体质量良好 |
| 9    | 集成Kubernetes                            | <font color=green>█</font> | 共执行311个用例，主要覆盖了功能一致性测试，架构x86和arm均测试通过；整体功能基本可用<br/>后续建议：增加对Kubernetes各组件的底噪消耗和稳定性测试 |
| 10   | 支持secGear                               | <font color=blue>▲</font>  | 共计执行100个用例，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试；质量良好约束：依赖BIOS版本 |
| 11   | 支持内存分级扩展                          | <font color=green>█</font> | 共计执行90个用例，覆盖范围包括特性的功能、可靠性，安全和性能；整体质量良好<br/>约束：<br />1、客户端和服务端需要在同一个服务器上部署，不支持跨服务器通信的场景<br/>2、仅支持扫描进程名小于或等于15个字符长度的目标进程 |
| 12   | 支持内核热升级                            | <font color=green>█</font> | 共计执行用例49个，主要覆盖了基本功能测试、可靠性测试、安全测试以及压力测试；整体功能基本可用 |
| 13   | 支持树莓派                                | <font color=green>█</font> | 对树莓派镜像进行安装、基本功能、管理工具、硬件兼容性和稳定性测试；共执行用例85条，整体质量良好 |
| 14   | 支持UKUI                                  | <font color=green>█</font> | 共执行两轮测试，覆盖UKUI桌面的核心功能、重要组件及系统插件的测试，共计执行用例78条，整体质量良好 |
| 15   | 支持DDE                                   | <font color=green>█</font> | 共执行两轮测试，共执行用例260条，主要覆盖了基础组件跟预装应用核心功能以及基本UI测试。整体核心功能基本可满足使用。 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

| 序号 | 特性名称                                                 | 测试覆盖情况                                                 | 约束依赖说明                                                 | 遗留问题单 |          质量评估          | 备注                                                     |
| :--: | -------------------------------------------------------- | ------------------------------------------------------------ | :----------------------------------------------------------- | ---------- | :------------------------: | -------------------------------------------------------- |
|  1   | 支持secPave                                              | 共执行用例41条，覆盖接口、功能、异常配置                     | 1、当前支持SELinux策略生成，支持的规则范围为文件、capability和网络socket<br />2、仅支持基于openEuler SELinux的targeted策略，不支持minimum和mls策略<br />3、只允许以root权限使用secPave | NA         | <font color=green>█</font> | 建议开发环境和生成环境保持一致，否则影响策略的生效<br /> |
|  2   | etmem内存分级扩展框架增强                                | 共计执行8个用例，覆盖范围包括memRouter和uswap特性的基本功能、可靠性，安全 | 1、客户端和服务端需要在同一个服务器上部署，不支持跨服务器通信的场景<br />2、不能同时使用系统原生的userfaultfd特性以及userswap | NA         | <font color=green>█</font> |                                                          |
|  3   | 支持isulad shimV2对接K8S                                 | 针对shim v2各API对应的功能进行全面的测试，包括功能测试40个，可靠性测试5个以及1个安全测试 | NA                                                           | NA         | <font color=green>█</font> | stats、attach、update三个接口与shim V1保持一致，暂不支持 |
|  4   | 发布eggo                                                 | 对eggo提供的对K8S集群的部署、销毁、节点加入及删除功能进行全量测试，执行用例18条 | 部署集群的节点间网络必须是互通的                             | NA         | <font color=blue>▲</font>  |                                                          |
|  5   | 支持kubeOS                                               | 共执行用例14条，覆盖KubeOS特性提供的镜像制作及对K8S集群节点的升级能力，组件底噪满足性能指标要求 | OS镜像制作前提：<br />1、镜像制作环境已安装qemu-img，bc，parted，tar，yum，docker<br />2、镜像制作使用root权限<br />3、制作工具的rpm包源为openEuler的全量（everything）ISO<br />4、制作之前需要先将当前机器上的selinux关闭或者设为允许模式<br />5、使用默认rpmlist进行容器OS镜像制作出来的镜像默认和制作工具保存在相同路径，该分区至少有25G的剩余空间<br />6、镜像制作时不支持用户自定义配置挂载文件<br />容器OS升级为双区升级，不支持更多分区数量 | NA         | <font color=green>█</font> |                                                          |
|  6   | 支持OpenResty                                            | 重点覆盖OpenResty提供的web服务能力，共执行用例3条，覆盖安装，运行及登录验证 | NA                                                           | NA         | <font color=green>█</font> |                                                          |
|  7   | 支持KubeSphere 3.1.0                                     | 共计执行用例13条，覆盖安装部署、扩缩容、对K8S集群的删除及管理功能 | NA                                                           | NA         | <font color=blue>▲</font>  | ARM平台暂不支持KubeSphere的完整安装                      |
|  8   | DDE新增支持画板，音乐和影院应用                          | 执行用例106条，覆盖画板、音乐和影院三个特性的核心功能及基本UI操作 | NA                                                           | NA         | <font color=green>█</font> |                                                          |
|  9   | UKUI新增中文输入法和多媒体支持                           | 共执行用例5条，完成对中文输入法和多媒体支持的功能验证        | NA                                                           | NA         | <font color=green>█</font> |                                                          |
|  10  | 支持OpenStack Wallaby版本                                | 覆盖Keystone、Glance、Nova、Placement、Neutron、Cinder、Ironic、Trove、Swift、Kolla、Horizon等项目的功能和整体的继承，共执行用例1151条 | NA                                                           | NA         | <font color=blue>▲</font>  |                                                          |
|  11  | 支持应用拓扑感知、配置溯源服务                           | 应用拓扑感知执行用例16条，配置溯源执行用例20条，覆盖基本功能、可靠性和安全 | NA                                                           | 1          | <font color=blue>▲</font>  |                                                          |
|  12  | 支持智能定位服务                                         | 异常检测执行用例34条，故障诊断执行用例52条，覆盖基本功能、可靠性和安全 | NA                                                           | 1          | <font color=blue>▲</font>  |                                                          |
|  13  | 提供智能运维web前端                                      | 共执行用例85条，覆盖智能运维整体web页面基本功能、可靠性和安全 | NA                                                           | NA         | <font color=blue>▲</font>  |                                                          |
|  14  | 支持StratoVirt 2.0                                       | 覆盖cVFIO、标准启动、快速启动、串口重定向及对接libvirt管理功能测试、可靠性测试，共执行用例38条 | NA                                                           | NA         | <font color=green>█</font> | 当前支持最小集，支持虚拟机的创建、销毁、挂起和恢复       |
|  15  | 支持兆芯处理器平台                                       | 覆盖21.09版本在兆芯处理器(KH-30000/KH-20000)平台上的安装部署、登录、重启、基本用户操作 | NA                                                           | NA         | <font color=blue>▲</font>  | 待开展进一步的兼容性测试并上openEuler兼容性列表          |
|  16  | 支持飞腾FT2500双路服务器                                 | 覆盖21.09版本在飞腾S2500处理器平台上的安装部署、登录、重启、基本用户操作 | NA                                                           | NA         | <font color=blue>▲</font>  | 待开展进一步的兼容性测试并上openEuler兼容性列表          |
|  17  | 【openEuler-21.09】openEuler支持嵌入式镜像               | 覆盖轻量化测试、安全加固测试和容器功能测试。执行用例73条     | NA                                                           | NA         | <font color=blue>▲</font>  | 当前支持ARM32和ARM                                       |
|  18  | 【openEuler-21.09】openEuler支持边缘协同框架（kubeedge） | 覆盖框架基本功能、可靠性和安全，共执行用例34条               | NA                                                           | NA         | <font color=blue>▲</font>  |                                                          |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.3   专项测试结论

### 安全测试

整体安全测试覆盖：

1、linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试

2、通过工具进行CVE漏洞/端口矩阵/安全编译选项/交付件病毒扫描

3、白盒安全测试主要通过fuzz测试实现对接口参数类和内存管理类进行覆盖；对内核进行syzkaller测试；对重点软件包开展oss-fuzz测试；

4、针对安全加固指南中的加固项，进行全量测试。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                 |
| ------------ | ------------------------------------------------------------ | ------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7*24小时 |
| 特性长稳测试 | 对特性交付相关功能进行并发、压力、反复、异常测试，过程中关注功能运行及内存以及cpu使用率等情况 | 特性可靠性较好           |

### 性能测试 

| **指标大项 ** | **指标小项**                                                 | **指标值**                                                   | 测试结论                                            |
| ------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | --------------------------------------------------- |
| OS基础性能    | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考21.03版本相应指标基线                                    | 相较21.03版本略有提升                               |
| 特性相关性能  | 1、KubeOS特性组件运行底噪和OS重启时间<br />2、嵌入式镜像轻量化 | 1、底噪小于100M，重启时间约10s<br />2、镜像体积<5M，空载时，底噪<15M，启动时间<5s | 1、85M,9S-10S<br />2、体积3M-4M，启动时间1s，底噪6M |


# 5   问题单统计

openEuler 21.09版本共发现问题单233个，有效问题218个，其中修复问题单210个，回归均通过，另外转需求问题单4个，遗留问题单4个。详细分布见下表:

| 测试阶段            | 问题单数 |
| ------------------- | -------- |
| openEuler 21.09 RC1 | 86       |
| openEuler 21.09 RC2 | 53       |
| openEuler 21.09 RC3 | 45       |
| openEuler 21.09 RC4 | 31       |
| openEuler 21.09 RC5 | 18       |

整体看版本问题单收敛趋势明显。

# 6   附件

## 遗留问题列表

| 序号 | 问题单号                                                     | 问题简述                                                     | 问题级别 | 影响分析                                                     | 规避措施                                     |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------- | ------------------------------------------------------------ | -------------------------------------------- |
| 1    | [I473E6](https://e.gitee.com/open_euler/issues/list?is%5Bsearch%5D=madvis&is%5Bissue_type_id%5D=-1&issue=I473E6) | 【openEuler 21.09】【x86】ltp执行madvise06用例概率性失败     | 次要     | 根因：该用例主要是测试madvise的WILLNEED功能，也就是内存预取功能。测试访问100M内存，失败情况下有10页的内存未被预取，触发pagefault。定位到原因是迁核导致部分cache被释放。<br />影响：不影响功能正常使用，只对预取的正确率有一定影响（较小），缺页后会触发系统重新加载。<br />1.用例本身设计就允许两个页因为意外情况被释放，当前失败主要是超过了两个页的阈值。所有版本均有这个问题，主线5.10该用例也是失败，老的版本强制迁核也会有概率性失败，只不过概率在10%左右。<br />2. cache丢失的页数目很少，小于1%，影响有限。 | 保持现状，跟踪上有社区解决情况               |
| 2    | [I4ARFN](https://e.gitee.com/open_euler/issues/list?is%5Bsearch%5D=21.09%28glibc-2.34%29%E7%9B%B8%E5%AF%B921.03&is%5Bissue_type_id%5D=-1&issue=I4ARFN) | 21.09(glibc-2.34)相对21.03(glibc-2.31)Unixbench Dhrystone_2_using_register_variables子项性能下降，初步判断为glibc版本不同导致 | 次要     | 根因：openEuler 21.09版本部分软件包版本选型升级，glibc切换2.34，gcc切换到10.3，unixbench测试套有性能波动。<br />影响：<br />总体性能测试总分无明显变化，unixbench想能测试子项中高精度浮点数项性能劣化40%，其他项有提升 | issue持续跟踪                                |
| 3    | [I4BY62](https://e.gitee.com/open_euler/issues/list?is%5Bsearch%5D=%E5%BC%82%E5%B8%B8%E6%A3%80%E6%B5%8B%E8%A7%84%E5%88%99%E8%BE%83%E5%A4%9A%E7%9A%84%E6%83%85%E5%86%B5%E4%B8%8B%EF%BC%8C%E6%97%B6%E5%B8%B8%E4%BC%9A%E9%80%A0%E6%88%90es%E6%95%B0%E6%8D%AE%E5%BA%93%E5%B4%A9%E6%BA%83%E7%9A%84%E7%8E%B0%E8%B1%A1&is%5Bissue_type_id%5D=-1&issue=c) | 【21.09-RC5】智能运维Aops，异常检测规则较多的情况下，内存不足，造成ES数据库OOM退出 | 次要     | 根因：测试环境内存偏少，ES内存不足，OOM导致进程退出。<br />影响：影响A-ops处理峰值信息的规格，需要重启ES恢复。最新版本已调整日志级别，减少日志打印，当前规格下问题已不复现，本问题单跟踪ES内存限制方案 | 调整日志级别，减少打印并定期清理测试环境内存 |
| 4    | [I479XH](https://e.gitee.com/open_euler/issues/list?is%5Bsearch%5D=%E9%85%8D%E7%BD%AE%E6%BA%AF%E6%BA%90%EF%BC%9AdeleteDomain%E6%8E%A5%E5%8F%A3%E5%B9%B6%E5%8F%91%EF%BC%8C%E6%89%A7%E8%A1%8C%E5%A4%B1%E8%B4%A5&is%5Bissue_type_id%5D=-1&issue=I479XH) | 配置溯源：deleteDomain接口并发，执行失败                     | 次要     | 根因：当前1.0版本仅支持穿行接口调用，权限并发场景下会出现接口调用返回失败；并发调用已乃如2.0版本规划中实现。<br />影响：<br />同一台管理节点上前台UI并发调用该接口时(ms级)，返回失败，真是业务场景难出发，不影响业务操作 | NA                                           |

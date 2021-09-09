![openEuler ico](../../images/openEuler.png)

版权所有 © 2021 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期      | 修订版本 | CR号 | 修改  章节 | 修改描述 | 作者                                                         |
| --------- | -------- | ---- | ---------- | -------- | ------------------------------------------------------------ |
| 2021-7-27 | 1.1.0    |      |            | 初稿     | charlie_li/lutianxiong/lemon-higgins/rigorous/speacher/dou33/panchenbo/the-moon-is-blue/zhang__3125 |
|           |          |      |            |          |                                                              |


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

openEuler  创新版本 测试策略

Abstract 摘要：

本文是openEuler 21.09版本的整体测试策略，用于指导该版本测试活动开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释    |
| ------ | ------------------------------------ | ----------- |
| OS     | Operation System                     | 操作系统    |
| CVE    | Common Vulnerabilities and Exposures | CVE安全补丁 |
|        |                                      |             |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 21.09版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 21.09版本是社区规划的创新版本，目的是快速发布一些新的竞争力特性，并在实际使用中进行特性催熟。本次发布重点包括：

1.  内核版本为5.10，GCC升级到10.3.0
2.  支持KubeSphere 3.1.0/OpenStack Wallaby版本/支持specPave/支持eggo/发布kubeOS/内存分级扩展增强，新增用户态swap和策略框架/支持OpenResty 1.19.3.1/stratovirt2.0轻量虚机/自动运维/支持兆芯处理器和FT2500
3.  补齐/优化社区软件包生态
4.  DDE版本升级/DDE支持画板、截图、音乐和影院应用
5.  修复bug和cve

## 需求范围

openEuler 21.09 版本交付需求列表如下：

详见：<https://gitee.com/openeuler/release-management/blob/master/openEuler-21.09/release-plan.md>

| **no** | **feature**                                                  | **status** | **sig**                    | **owner**                                                    |
| ------ | ------------------------------------------------------------ | ---------- | -------------------------- | ------------------------------------------------------------ |
| 1      | [【openEuler 21.09】GCC升级到10.3.0版本](https://gitee.com/openeuler/release-management/issues/I3U85C) | Developing | Compiler                   | [@Haijian.Zhang](https://gitee.com/open_euler/dashboard/members/haijianzhang) ,[@eastb233](https://gitee.com/open_euler/dashboard/members/eastb233) |
| 2      | [【openEuler 21.09】openEuler 21.09 支持 KubeSphere 3.1.0](https://gitee.com/openeuler/release-management/issues/I3VFAU) | Developing | SIG-KubeSphere             | [@Feynman](https://gitee.com/feynmanzhou) ,[@Calvin](https://gitee.com/calvinyu), [@Joey](https://gitee.com/imjoey) |
| 3      | [【openEuler 21.09】openEuler 21.09 支持 OpenStack Wallaby]() | Developing | SIG-OpenStack              | [@joec88](https://gitee.com/joec88) [@huangtianhua](https://gitee.com/huangtianhua) @xiyuanwang [@zh-f](https://gitee.com/zh-f) [@liksh](https://gitee.com/liksh) [@zhangy1317](https://gitee.com/zhangy1317) |
| 4      | [【openEuler 21.09】交付secPaver](https://gitee.com/openeuler/release-management/issues/I41F6S) | Developing | SIG-Security_facility      | [@HuaxinLuGitee](https://gitee.com/HuaxinLuGitee)            |
| 5      | [【openEuler 21.09】eggo：一键式、轻量化、可配置集群部署](https://gitee.com/openeuler/release-management/issues/I41F61) | Developing | SIG-CloudNative            | [@jingwoo](https://gitee.com/jingwoo)                        |
| 6      | [【openEuler 21.09】kubOS：运行内存消耗<150M,重启时间<15s](https://gitee.com/openeuler/release-management/issues/I41F5Z) | Developing | SIG-CloudNative            | [@radeon92](https://gitee.com/radeon92)                      |
| 7      | [【openEuler 21.09】内存分级扩展框架增强，新增用户态swap及策略框架，性能降低<15%](https://gitee.com/openeuler/release-management/issues/I41F5A) | Developing | SIG-Storage                | [@whoisxxx](https://gitee.com/whoisxxx)                      |
| 8      | [【openEuler 21.09】 openEuler 21.09 支持 OpenResty 1.19.3.1](https://gitee.com/openeuler/release-management/issues/I427HO) | Developing | SIG-OpenResty              | [@Joey](https://gitee.com/imjoey) [@fukiki](https://gitee.com/fukiki) [@fuchangjie](https://gitee.com/fu_changjie) [@Jacean](https://gitee.com/Jacean) |
| 9      | [【openEuler 21.09】openEuler 21.09 支持树莓派](https://gitee.com/open_euler/dashboard?issue_id=I3VBFP) | Developing | RaspberryPi                | @jianminw                                                    |
| 10     | [【openEuler 21.09】openEuler 21.09 支持UKUI](https://gitee.com/open_euler/dashboard?issue_id=I3VCTS) | Developing | sig_UKUI                   | @dou33                                                       |
| 11     | [【openEuler 21.09】openEuler 21.09 支持GNOME-3.38](https://gitee.com/open_euler/dashboard?issue_id=I3VCZ3) | Developing | sig-gnome                  | @dwl301                                                      |
| 12     | [【openEuler 21.09】openEuler 21.09 支持XFCE](https://gitee.com/open_euler/dashboard?issue_id=I3VCZG) | Developing | sig-xfce                   | @dillon_chen                                                 |
| 13     | [【openEuler 21.09】openEuler 21.09 支持HA](https://gitee.com/open_euler/dashboard?issue_id=I3VD4H) | Developing | sig-HA                     | @yangzhao_kl                                                 |
| 14     | [【openEuler 21.09】openEuler DDE版本升级](https://gitee.com/open_euler/dashboard?issue_id=I3VE7L) | Developing | sig-DDE                    | @panchenbo                                                   |
| 15     | [【openEuler 21.09】openEuler 21.09 DDE支持画板，截图，音乐和影院应用](https://gitee.com/open_euler/dashboard?issue_id=I3VE7A) | Developing | sig-DDE                    | @panchenbo                                                   |
| 16     | 【openEuler 21.09】Stratovirt 2.0支持最小集                  | Developing | sig-virt                   | @cellfaint                                                   |
| 17     | 【openEuler 21.09】openEuler 21.09 支持XFCE                  | Developing | xfce                       | @dillon_chen                                                 |
| 18     | 【openEuler 21.09】 支持飞腾FT2500双路服务器                 | Developing | kernel                     | @xiexiuqi                                                    |
| 19     | 【openEuler-21.09】支持兆芯处理器平台                        | Developing | kernel                     | @xiexiuqi                                                    |
| 20     | [openEuler-21.09] 21.09继承secGear                           | Developing | sig-confidential-computing | @chenmaodong                                                 |
| 21     | [openEuler-21.09] 21.09继承虚拟化                            | Developing | sig-virt                   | @cellfaint                                                   |
| 22     | [openEuler-21.09] 21.09继承容器等特性                        | Developing | isulad                     | @lifeng2221dd1                                               |
| 23     | 【openEuler-21.09】arm64: Add config switch and kernel parameter for CPU0 hotplug | Developing | kernel                     | @xiexiuqi                                                    |
| 24     | 【openEuler-21.09】 add options to tuning the prefetch prolicy for HIP08 | Developing | kernel                     | @xiexiuqi                                                    |
| 25     | 【openEuler-21.09】introduce qos scheduler for co-location   | Developing | kernel                     | @xiexiuqi                                                    |
| 26     | 【openEuler-21.09】memcg: enable memcg oom-kill for __GFP_NOFAIL | Developing | kernel                     | @xiexiuqi                                                    |
| 27     | [openEuler-21.09] stnp 加速 clear_page                       | Developing | kernel                     | @xiexiuqi                                                    |
| 28     | 【openEuler-21.09】memcg: enable memcg oom-kill for __GFP_NOFAIL | Developing | kernel                     | @xiexiuqi                                                    |

# 风险

无

# 测试分层策略

本次SP版本的具体测试分层策略如下：

| **需求**                  | **开发主体**          | **测试主体**    | **测试分层策略**                                             |
| ------------------------- | --------------------- | --------------- | ------------------------------------------------------------ |
| 支持树莓派发布件          | sig-RaspberryPi       | sig-RaspberryPi | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试       |
| 支持UKUI桌面              | sig-UKUI              | sig-UKUI        | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
| 支持HA软件                | sig-Ha                | sig-Ha          | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持DDE桌面               | sig-DDE               | sig-DDE         | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持KubeSphere            | sig-KubeSphere        | sig-KubeSphere  | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 支持OpenStack Wallaby     | sig-OpenStack         | sig-OpenStack   | 重点验证openstack W版本发布主要组件的安装部署、基本功能      |
| 支持secPave               | sig-Security_facility | sig-QA          | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
| 发布eggo                  | sig-CloudNative       | sig-CloudNative | 验证eggo在openEuler上的安装部署以及提供的部署K8S集群的能力   |
| 支持kubeOS                | sig-CloudNative       | sig-QA          | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 |
| 支持OpenResty 1.19.3.1    | sig-OpenResty         | sig-OpenResty   | 验证openResty平台在openEuler版本上的可安装性和基本功能       |
| etmem内存分级扩展框架增强 | sig-Storage           | sig-QA          | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
| 支持isulad shimV2对接K8S  | sig-CloudNative       | sig-CloudNative | 验证使用shimV2方式时，isular容器引擎对容器尤其安全容器场景下的基本管理功能 |
| 支持XFCE                  | sig-xfce              | sig-xfce        | 验证xfce桌面系统在openEuler版本上的可安装和基本功能          |
| 支持GNOME-3.38            | sig-gnome             | sig-gnome       | 验证gnome桌面系统在openEuler版本上的可安装和基本功能         |
| 支持兆芯处理器            | sig-kernel            | sig-QA          | 验证openEuler版本在兆芯处理器上的可安装和可使用性            |
| 支持飞腾FT2500双路服务器  | sig-kernel            | sig-QA          | 验证openEuler版本在FT2500处理器上的可安装和可使用性          |

# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*                         | *重点*                                             | *设计思路*                                                   | *备注* |
| ------ | --------------------------------- | -------------------------------------------------- | ------------------------------------------------------------ | ------ |
| 1      | 支持secPave                       | secpave工具的基本能力及服务的稳定性                | 验证secPave提供的策略生成/查询/删除/安装/卸载/导入/导出的能力，覆盖selinux策略文件；关注服务端各个功能模块在并发、压力场景下的稳定性 |        |
| 2      | etmem内存分级扩展框架增强         | 新增部分memroute和uswap的基本能力                  | 验证新发布模块memRouter内存策略框架的基本功能和稳定性；验证用户态页面切换技术userswap的内存迁移能力；最终从整体上验证etmen的多级内存管理基本能力、可靠性和性能指标要求 |        |
| 3      | 支持isulad shimV2对接K8S          | isula容器引擎提供的对容器的管理能力                | 验证使用shimV2方式时，isula容器引擎对容器尤其安全容器场景下的基本管理功能，过程中检查相应进程的运行情况 |        |
| 4      | 发布eggo                          | eggo的可安装性和对K8S集群的管理能力                | 验证eggo提供的部署K8S集群的能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性； |        |
| 5      | 支持kubeOS                        | 镜像制作工具及双区升级的功能按整形                 | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |        |
| 6      | 支持OpenResty                     | OpenResty的可安装性和集成库在nginx的高性能响应能力 | 验证OpenResty平台在openEuler上的安装部署，并利用提供的库和模块，基于nginx进行相应web应用和服务的高并发和高性能相应验证 |        |
| 7      | 支持KubeSphere                    | KubeSphere的可安装性和对容器的运维能力             | 通过kubeSphere验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力 |        |
| 8      | DDE支持画板，截图，音乐和影院应用 | 新增应用在DDE上的功能                              | 安装DDE桌面后，原有桌面组件功能不受影响，新增组件可以正常安装，并且相应组件的基本功能可以正常提供；另外关注新增应用尤其影月和影院在系统压力下的稳定性 |        |
| 9      | 支持GNOME-3.38                    | gnome桌面系统的可安装性和常用菜单功能              | 验证gnome桌面在openEuler上的安装部署，包括安装和卸载；功能上关注桌面的切换以及发布菜单功能选项对应的基本能力； |        |

## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                              | 策略                                                         |
| ----------------------------------------- | ------------------------------------------------------------ |
| 内核                                      | 直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与21.03版本基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化                                    | 继承已有测试能力，重点关注5.10内核下虚拟化组件qemu和stratovirt轻量化的基本功能；另外对stratovirt轻量化已提供能力的完整性 |
| 编译器(gcc/jdk)                           | 继承已有测试能力，本次发布在jdk原有2个版本基础上新增一个最新版本发布件，因此需要基于开源测试套对gcc和jdk相关功能进行验证 |
| 安装部署                                  | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| Kunpeng加速引擎                           | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 |
| A-Tune                                    | 继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 支持xfce                                  | 集成已有测试能力，重点关注xfce桌面的可安装性和提供组件的能力 |
| 支持UKUI                                  | 继承已有测试能力，关注桌面系统的安装和桌面应用的功能性       |
| 树莓派                                    | 继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     |
| secGear支持                               | 继承已有测试能力，关注secGear特性的功能完整性                |

## 专项测试策略

### 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。整体安全测试需要覆盖：

1.  linux系统安全配置/权限管理等

2.  特性涉及到的安全需求验证

3.  CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

4.  白盒安全测试

| 安全扫描类     | CVE扫描/敏感信息/编译选项 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项需要针对新开源特性进行； |
| :------------- | ------------------------- | ------------------------------------------------------------ |
| 安全配置管理类 | Linux安全规范             | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试 |
| 白盒安全测试类 | Fuzz测试                  | Fuzz测试是能发现接口参数类问题和内存相关问题的有效方法，所以需要针对操作系统重点软件包开展fuzz；对内核进行syzkaller的测试；对重点软件包开展oss-fuzz测试； |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 长稳类型     | 具体长稳执行策略                                             |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| 特性长稳     | 特性级的可靠性，需结合特性涉及和使用的资源类型，如进程、服务、文件、CPU/内存/IO/网络等；通过模拟各类资源异常/竞争/压力故障场景，并发/反复的进行特性提供的基本功能操作 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。openEuler 21.09版本是集成5.10内核的创新版本，所以在操作系统基本benchmark各类指标上需要和21.03版本保持一致，性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                 | **指标值**              | **说明**                                |
| ------------ | ------------------------------------------------------------ | ----------------------- | --------------------------------------- |
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考LTS版本相应指标基线 | 与21.03版本基线数据差异小于5%以内可接受 |

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**       | **覆盖策略**                                                 | **中英文测试策略** |
| ------------------ | ------------------------------------------------------------ | ------------------ |
| DDE安装指南        | 安装步骤的准确性及DDE桌面系统是否能成功安装启动              | 英文描述的准确性   |
| UKUI安装指南       | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动             | 英文描述的准确性   |
| 树莓派安装指导     | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   |
| 安装指南           | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 管理员指南         | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 安全加固指南       | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 虚拟化用户指南     | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| StratoVirt用户指南 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 容器用户指南       | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| A-Tune用户指南     | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 应用开发指南       | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 工具集用户指南     | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 智能运维           | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |

# 测试执行策略

openEuler 21.09版本按照社区release-manger团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本的5轮测试采取4+1的测试方式，即4轮全量+1轮回归的策略。

### 测试计划

openEuler 21.09版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stange name     | Begin time | End time   |
| :-------------- | :--------- | :--------- |
| Develop         | 2021-06-04 | 2021-08-13 |
| Kernel freezing | 2021-07-19 | 2021-07-23 |
| Build           | 2021-07-26 | 2021-07-30 |
| Test round 1    | 2021-08-16 | 2021-08-27 |
| Test round 2    | 2021-08-30 | 2021-09-03 |
| Test round 3    | 2021-09-06 | 2021-09-10 |
| Test round 4    | 2021-09-13 | 2021-09-15 |
| Test round 5    | 2021-09-16 | 2021-09-17 |
| release         | 2021-09-30 | 2021-09-30 |

### 测试重点

测试阶段1：

1.  重点关注继承特性/新特性的基本功能

2.  交付重要组件(内核、虚拟化、容器、编译器等)的功能完整性

3.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整性

4.  通过软件包管理测试，对版本发布软件的可安装可编译进行整体保证

5.  专项情况如下：

    性能：保证版本的性能满足发布基线标准，不能低于21.03版本性能指标

    可靠性：保证版本的长时间稳定运行，建议运行时长7\*24

    安全测试：进行安全CVE漏洞、安全编译选项，已有的fuzz测试


测试阶段2：

1.  继承特性/新特性的全量验证

2.  通过自动化覆盖重要组件的功能

3.  系统集成的正确性和完整性

4.  软件包管理测试

5.  专项：

    可靠性、fuzz测试、文档测试

测试阶段3：

1.  继承特性/新特性的全量自动化验证

2.  重要组件的完整性

3.  系统集成验证

4.  软件包管理测试

5.  专项：

    性能、安全扫描、可靠性

测试阶段4：

1、通过自动化进行特性/组件的功能保证

2、问题单全量回归

3、软件包管理测试

4、专项：

文档测试、性能、可靠性

测试阶段5：

1、问题单全量回归

2、发布见的病毒扫描

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

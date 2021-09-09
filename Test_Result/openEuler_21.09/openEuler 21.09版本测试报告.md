![openEuler ico](../../images/openEuler.png)

版权所有 © 2021  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节 | 修改描述   |
| ---------- | -------- | -------- | ---------- |
| 2021/09/19 | 1.1.0    | 初始     | charlie_li |

关键词：

 openEuler  raspberrypi  UKUI  DDE  HA  iSula  A-Tune  kvm qemu  docker openStack Kubernetes xfce 内核热升级 StratoVirt etmem secGear  

摘要：

 文本主要描述openEuler 21.09版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

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

openEuler 21.09版本作为2021年发布的第二个创新版本，发布范围主要如下：

1.  内核版本为5.10，GCC升级到10.3.0
2.  支持KubeSphere 3.1.0/OpenStack Wallaby版本/支持specPave/支持eggo/发布kubeOS/内存分级扩展增强，新增用户态swap和策略框架/支持OpenResty 1.19.3.1/stratovirt2.0轻量虚机/自动运维/支持兆芯处理器和FT2500
3.  补齐/优化社区软件包生态
4.  DDE版本升级/DDE支持画板、截图、音乐和影院应用
5.  修复bug和cve

openEuler 21.09版本按照社区release-manager团队的计划，共规划4轮测试，详细的版本信息和测试时间如下表：

| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| openEuler 21.09 RC1 | 2021-08-16   | 2021-08-27   |
| openEuler 21.09 RC2 | 2021-08-30   | 2021-09-03   |
| openEuler 21.09 RC3 | 2021-09-06   | 2021-09-10   |
| openEuler 21.09 RC4 | 2021-09-13   | 2021-09-15   |
| openEuler 21.09 RC5 | 2021-09-16   | 2021-09-17   |

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

| 序号 | **需求**                                                     | **状态**   | **sig组**                  | **责任人**                                                   |
| :--: | ------------------------------------------------------------ | ---------- | -------------------------- | ------------------------------------------------------------ |
|  1   | [【openEuler 21.09】GCC升级到10.3.0版本](https://gitee.com/openeuler/release-management/issues/I3U85C) | Developing | Compiler                   | [@Haijian.Zhang](https://gitee.com/open_euler/dashboard/members/haijianzhang) ,[@eastb233](https://gitee.com/open_euler/dashboard/members/eastb233) |
|  2   | [【openEuler 21.09】openEuler 21.09 支持 KubeSphere 3.1.0](https://gitee.com/openeuler/release-management/issues/I3VFAU) | Developing | SIG-KubeSphere             | [@Feynman](https://gitee.com/feynmanzhou) ,[@Calvin](https://gitee.com/calvinyu), [@Joey](https://gitee.com/imjoey) |
|  3   | [【openEuler 21.09】openEuler 21.09 支持 OpenStack Wallaby]() | Developing | SIG-OpenStack              | [@joec88](https://gitee.com/joec88) [@huangtianhua](https://gitee.com/huangtianhua) @xiyuanwang [@zh-f](https://gitee.com/zh-f) [@liksh](https://gitee.com/liksh) [@zhangy1317](https://gitee.com/zhangy1317) |
|  4   | [【openEuler 21.09】交付secPaver](https://gitee.com/openeuler/release-management/issues/I41F6S) | Developing | SIG-Security_facility      | [@HuaxinLuGitee](https://gitee.com/HuaxinLuGitee)            |
|  5   | [【openEuler 21.09】eggo：一键式、轻量化、可配置集群部署](https://gitee.com/openeuler/release-management/issues/I41F61) | Developing | SIG-CloudNative            | [@jingwoo](https://gitee.com/jingwoo)                        |
|  6   | [【openEuler 21.09】kubOS：运行内存消耗<150M,重启时间<15s](https://gitee.com/openeuler/release-management/issues/I41F5Z) | Developing | SIG-CloudNative            | [@radeon92](https://gitee.com/radeon92)                      |
|  7   | [【openEuler 21.09】内存分级扩展框架增强，新增用户态swap及策略框架，性能降低<15%](https://gitee.com/openeuler/release-management/issues/I41F5A) | Developing | SIG-Storage                | [@whoisxxx](https://gitee.com/whoisxxx)                      |
|  8   | [【openEuler 21.09】 openEuler 21.09 支持 OpenResty 1.19.3.1](https://gitee.com/openeuler/release-management/issues/I427HO) | Developing | SIG-OpenResty              | [@Joey](https://gitee.com/imjoey) [@fukiki](https://gitee.com/fukiki) [@fuchangjie](https://gitee.com/fu_changjie) [@Jacean](https://gitee.com/Jacean) |
|  9   | [【openEuler 21.09】openEuler 21.09 支持树莓派](https://gitee.com/open_euler/dashboard?issue_id=I3VBFP) | Developing | RaspberryPi                | @jianminw                                                    |
|  10  | [【openEuler 21.09】openEuler 21.09 支持UKUI](https://gitee.com/open_euler/dashboard?issue_id=I3VCTS) | Developing | sig_UKUI                   | @dou33                                                       |
|  11  | [【openEuler 21.09】openEuler 21.09 支持GNOME-3.38](https://gitee.com/open_euler/dashboard?issue_id=I3VCZ3) | Developing | sig-gnome                  | @dwl301                                                      |
|  12  | [【openEuler 21.09】openEuler 21.09 支持XFCE](https://gitee.com/open_euler/dashboard?issue_id=I3VCZG) | Developing | sig-xfce                   | @dillon_chen                                                 |
|  13  | [【openEuler 21.09】openEuler 21.09 支持HA](https://gitee.com/open_euler/dashboard?issue_id=I3VD4H) | Developing | sig-HA                     | @yangzhao_kl                                                 |
|  14  | [【openEuler 21.09】openEuler DDE版本升级](https://gitee.com/open_euler/dashboard?issue_id=I3VE7L) | Developing | sig-DDE                    | @panchenbo                                                   |
|  15  | [【openEuler 21.09】openEuler 21.09 DDE支持画板，截图，音乐和影院应用](https://gitee.com/open_euler/dashboard?issue_id=I3VE7A) | Developing | sig-DDE                    | @panchenbo                                                   |
|  16  | 【openEuler 21.09】Stratovirt 2.0支持最小集                  | Developing | sig-virt                   | @cellfaint                                                   |
|  17  | 【openEuler 21.09】openEuler 21.09 支持XFCE                  | Developing | xfce                       | @dillon_chen                                                 |
|  18  | 【openEuler 21.09】 支持飞腾FT2500双路服务器                 | Developing | kernel                     | @xiexiuqi                                                    |
|  19  | 【openEuler-21.09】支持兆芯处理器平台                        | Developing | kernel                     | @xiexiuqi                                                    |
|  20  | [openEuler-21.09] 21.09继承secGear                           | Developing | sig-confidential-computing | @chenmaodong                                                 |
|  21  | [openEuler-21.09] 21.09继承虚拟化                            | Developing | sig-virt                   | @cellfaint                                                   |
|  22  | [openEuler-21.09] 21.09继承容器等特性                        | Developing | isulad                     | @lifeng2221dd1                                               |
|  23  | 【openEuler-21.09】arm64: Add config switch and kernel parameter for CPU0 hotplug | Developing | kernel                     | @xiexiuqi                                                    |
|  24  | 【openEuler-21.09】 add options to tuning the prefetch prolicy for HIP08 | Developing | kernel                     | @xiexiuqi                                                    |
|  25  | 【openEuler-21.09】introduce qos scheduler for co-location   | Developing | kernel                     | @xiexiuqi                                                    |
|  26  | 【openEuler-21.09】memcg: enable memcg oom-kill for __GFP_NOFAIL | Developing | kernel                     | @xiexiuqi                                                    |
|  27  | [openEuler-21.09] stnp 加速 clear_page                       | Developing | kernel                     | @xiexiuqi                                                    |
|  28  | 【openEuler-21.09】memcg: enable memcg oom-kill for __GFP_NOFAIL | Developing | kernel                     | @xiexiuqi                                                    |



本次创新版本测试活动分工如下：

| **需求**                                   | **开发主体**               | **测试主体**    | **测试策略**                                                 |
| :----------------------------------------- | -------------------------- | --------------- | ------------------------------------------------------------ |
| 支持树莓派发布件                           | sig-RaspberryPi            | sig-RaspberryPi | 树莓派sig组对树莓派发布件进行安装、系统信息查询、用户管理功能、软件管理功能、进程管理、网络管理等基本功能；开展硬件兼容性测试包括3B、3B+、4B开发板；完成稳定性相关测试 |
| 支持UKUI3.0桌面                            | sig-UKUI                   | sig-UKUI        | UKUIsig组验证UKUI桌面系统在openEuler系统上的安装部署、核心功能测试、重要组件的测试和系统插件测试，终端关注基本功能和稳定性 |
| 支持HA软件                                 | sig-HA                     | sig-HA          | HAsig组验证HA软件的安装部署和基本功能，重点关注软件服务的可靠性(资源异常、网络异常等) |
| 支持DDE桌面                                | sig-DDE                    | sig-DDE         | DDEsig组验证DDE在openEuler系统上的安装部署、基础组件与预装应用核心功能测试和UI测试 |
| 支持openStack W版本                        | sig-openstack              | sig-openstack   | openstack sig组重点验证nova\neutron\cinder\glance\keystone\ironic等模块的安装部署、基本功能(虚机/裸机、卷、网络等资源管理)；覆盖API测试、功能测试和集成测试；另外关注组件的长稳测试 |
| 支持xfce 4.14桌面                          | sig-xfce                   | sig-xfce        | xfcesig组验证xfce在openEuler系统上的安装部署、重要组件和系统插件的基本功能和稳定性 |
| 支持热迁移/StratoVirt增强/Risc-v架构热迁移 | sig-virt                   | sig-QA          | QAsig组对StratoVirt组件TLS多通道热迁移和脏页率查询两个特性开展接口、功能、可靠性和性能的测试；支持热迁移发布范围的基本功能和稳定性及性能指标；对内存弹性(balloon)、内存大页支持、iothread、ioqos覆盖功能、可靠性、安全及性能测试 |
| 内核升级到5.10                             | sig-kernel                 | sig-QA          | QAsig组验证5.10内核的基本功能、稳定性、性能等指标            |
| 支持etmem内存扩展                          | sig-Storage                | sig-QA          | QAsig组验证etmem特性的基本功能、可靠性、性能及稳定性测试     |
| 支持内核热升级                             | sig-ops                    | sig-QA          | QAsig组验证内核热升级功能的完整性，保证能够快速启动内核和程序的迁移实现 |
| 支持secGear安全机密计算安全应用开发套件    | sig-confidential-computing | sig-QA          | QAsig组验证在X86场景下开发套件的接口、基本功能、可靠性和稳定性 |
| 发布StratoVirt microvm_image               | sig-virt                   | sig-QA          | QAsig组针对此发布件进行镜像的检查和镜像的使用验证，保证镜像启动虚机的基本功能可用性和虚机启动及底噪性能指标 |
| 集成 kubernetes及最简部署的依赖组件        | sig-CloudNative            | sig-QA          | QAsig组验证K8S组件在openEuler版本上的安装部署、基本功能一致性 |
| 容器基础镜像大小优化                       | sig-CloudNative            | sig-QA          | QAsig组验证发布容器基础镜像规格是否符合，容器镜像启动容器后的满足用户基本可用，能够通过配置repo安装所需软件 |
| 版本其它继承需求及整体继承验证             |                            | sig-QA          | QAsig组按照继承策略对继承需求进行质量保障和系统整体集成能力  |

# 3   版本概要测试结论



# 4   版本详细测试结论

openEuler 21.09版本详细测试内容包括：

 

## 4.1   特性测试结论

### 4.1.1   继承特性评价

| 序号 | 组件/特性名称 | 质量评估 | 备注 |
| ---- | :------------ | :------: | :--- |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |
|      |               |          |      |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

| 序号 | 特性名称 | 约束依赖说明 | 遗留问题单 | 质量评估 | 备注 |
| :--: | -------- | :----------- | ---------- | :------: | ---- |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |
|      |          |              |            |          |      |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.3   专项测试结论

### 安全测试



### 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                 |
| ------------ | ------------------------------------------------------------ | ------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7*24小时 |
| 特性长稳测试 | 对特性交付相关功能进行并发、压力、反复、异常测试，过程中关注功能运行及内存以及cpu使用率等情况 | 特性可靠性及稳定性较好   |

### 性能测试 

| **指标大项 ** | **指标小项**                                                 | **指标值**              | 测试结论 |
| ------------- | ------------------------------------------------------------ | ----------------------- | -------- |
| OS基础性能    | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考LTS版本相应指标基线 |          |
| 特性相关性能  |                                                              |                         |          |


# 5   问题单统计

openEuler 21.09版本共发现问题单个，有效问题个，其中修复问题单个，回归均通过，另外转需求问题单个，遗留问题单个。详细分布见下表:

| 测试阶段 | 问题单数 |
| -------- | -------- |
|          |          |
|          |          |
|          |          |
|          |          |
|          |          |

整体看版本问题单收敛趋势明显。

# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 |
| ---- | -------- | -------- | -------- | -------- | -------- |
|      |          |          |          |          |          |
|      |          |          |          |          |          |
|      |          |          |          |          |          |
|      |          |          |          |          |          |
|      |          |          |          |          |          |
|      |          |          |          |          |          |

![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ------------------ | ---------- |
| 2022/3/7 | 1.0.0    | 初始               | disnight |
| 2022/3/26 | 1.0.1    | 基于3/23QAsig例会于RC5版本测试结果，刷新测试报告 | disnight |

关键词：

openEuler LTS raspberrypi UKUI DDE xfce gnome kiran HA iSula A-Tune stratovirt kvm qemu docker openstack secpaver secgear

摘要：

文本主要描述openEuler 22.03-LTS版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语      | 英文全名                             | 中文解释       |
| ----------- | ------------------------------------ | -------------- |
| OS          | Operating system                     | 操作系统       |
| iSula       | iSula                                | 轻量级容器引擎 |
| Docker      | Docker                               | Docker容器引擎 |
| DDE         | Deepin Desktop Environment           | 深度桌面环境   |
| raspberrypi | raspberrypi                          | 树莓派         |
| HA          | high availability                    | 高可靠性       |
| LTS         | long time support                    | 长时间维护     |
| CVE         | Common Vulnerabilities and Exposures | 通用漏洞批露   |
| UCE         | uncorrected error                    | 不可纠正的错误 |

---


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.03 LTS版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 22.03 LTS版本是基于5.10内核22年全新的LTS基线版本，该版本基于openEuler 21.09分支拉出，同时回合master与其余LTS分支修改，发布范围相较20.03LTS 、20.03 LTS SP1、20.03 LTS SP2和20.03 LTS SP3版本主要变动：

1.  内核版本升级到5.10，默认PageSize由64K变更为4K(详情请见[TC决策-20211229](https://etherpad.openeuler.org/p/TC-meetings))
2.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS/%E7%89%88%E6%9C%AC%E5%8F%98%E6%9B%B4%E8%AF%B4%E6%98%8E.md)
3.  删除python2
4.  新增支持：openGauss/gazella/libcareplus/rubik/openStack Wallaby版本
5.  修复bug和cve

openEuler 22.03 LTS 版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称                 | 测试起始时间 | 测试结束时间 |
| ----------------------- | ------------ | ------------ |
| openEuler 22.03 LTS RC1 | 2022-02-16(延期2天) | 2022-02-22 |
| openEuler 22.03 LTS RC2 | 2022-02-25(延期3天) | 2022-03-01 |
| openEuler 22.03 LTS RC3 | 2022-03-05(延期5天) | 2022-03-10 |
| openEuler 22.03 LTS RC4 | 2022-03-12(延期5天) | 2022-03-17 |
| openEuler 22.03 LTS RC5 | 2022-03-25 | 2022-03-28 |

测试的硬件环境如下：

| 硬件型号 | 硬件配置信息 | 备注 |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920\*2  <br />32G*4 2933MHz<br />LSI SAS3508<br />TM210 | |
| RH2288H V5 | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz<br />32*4 2400MHz<br />LSI SAS3508<br />X722 | |
| 树莓派4B卡 | CPU:Cortex-A72 * 4 <br />内存：8GB <br />存储设备：SanDisk Ultra 16GB micro SD | 默认测试环境，数量1 |
| 树莓派3B+卡 | CPU:Cortex-A53 * 4<br />内存：1GB 存储设备<br />SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |
| 树莓派3B卡 | CPU:Cortex-A53 * 4 <br />内存：1GB <br />存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |
| 支持树莓派的7寸屏 | HDMI接口，1024*600分辨率电容屏 | 数量1 |
| thinkpad x1 carbon 2019 |  | 远程控制树莓派设备 |
| 长城擎天服务器<br>DF723 | CPU型号：FT2000+<br>CPU核数：64<br>内存：64G<br>硬盘容量：240G | |
| 联想启天台式机<br>M425-N000 | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz<br>CPU内核总数：6<br>内存容量：16G | |
| FT-2000+64核服务器 | CPU型号：FT-2000+<br />CPU核数：64<br />内存：镁光16G*32<br />网卡：I350 | |
| Phytium S2500/64C | CPU型号：S2500/64C <br />CPU核数：64<br />内存：16G*16 DDR4<br />网卡：I350 | |
| Supermicro AS-4124GS-TNR | CPU型号：AMD EPYC 7513 32-Core Processor<br />CPU核数：32<br />内存：32G*16 DDR4<br />网卡：I350 | |


openEuler 22.03-LTS版本交付需求列表如下：

详见：[release-plan.md](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS/release-plan.md)


|no|feature|status|sig|owner|release|
|:----|:---|:---|:--|:----|:--|
|[I4H9BC](https://gitee.com/openeuler/release-management/issues/I4H9BC)|新增支持RISC-V 镜像|Testing|RISC-V|[@xuzhou zhang](https://gitee.com/whoisxxx), [@xijing](https://gitee.com/xijing666)| sig独立发布 |
|[I4IM2L](https://gitee.com/openeuler/release-management/issues/I4IM2L)|GCC自动反馈优化相关软件包引入及优化效果增强|Testing|Compiler|[@ma-mingze](https://gitee.com/ma-mingze), [@Haijian.Zhang](https://gitee.com/haijianzhang), [@eastb233](https://gitee.com/eastb233)| 社区repo-OS |
|[I4N83C](https://gitee.com/openeuler/release-management/issues/I4N83C)|openGauss默认集成到openEuler操作系统中|Testing|DB|[@zhang_xubo](https://gitee.com/zhang_xubo), [@bzhaoop](https://gitee.com/bzhaoop)| 社区repo-OS |
|[I4O21W](https://gitee.com/openeuler/release-management/issues/I4O21W)|新增支持容器场景在离线混合部署|Testing|CloudNative|[@Vanient](https://gitee.com/Vanient)| 社区repo-Epol |
|[I4PM21](https://gitee.com/openeuler/release-management/issues/I4PM21)|StratoVirt安全容器支持直通设备热插拔|Testing|Virt|[@frankyj915](https://gitee.com/frankyj915), [@imxcc](https://gitee.com/imxcc)| 社区repo-OS |
|[I4PMNN](https://gitee.com/openeuler/release-management/issues/I4PMNN)|libcareplus提供Qemu热补丁能力|Testing|Virt|[@mdsc](https://gitee.com/mdsc), [@imxcc](https://gitee.com/imxcc)| 社区repo-OS |
|[I4PMYT](https://gitee.com/openeuler/release-management/issues/I4PMYT)|新增支持gazelle高性能用户态协议栈|Testing|sig-high-performance-network|[@wu-changsheng](https://gitee.com/wu-changsheng)| 社区repo-Everything |
|[I4QL70](https://gitee.com/openeuler/release-management/issues/I4QL70)|支持树莓派|Testing|RaspberryPi|[@woqidaideshi](https://gitee.com/woqidaideshi)| 社区repo-独立镜像 |
|[I4S8L8](https://gitee.com/openeuler/release-management/issues/I4S8L8)|支持GNOME|Testing|GNOME|[@weijin-deng](https://gitee.com/weijin-deng) [@dwl301](https://gitee.com/dwl301)| 社区repo-Epol |
|[I4S7C0](https://gitee.com/openeuler/release-management/issues/I4S7C0)|支持OpenStack Train/Wallaby版本|Testing|SIG-OpenStack| [@joec88](https://gitee.com/joec88) [@huangtianhua](https://gitee.com/huangtianhua) [@xiyuanwang](@https://gitee.com/xiyuanwang)  [@zh-f](https://gitee.com/zh-f)  [@liksh](https://gitee.com/liksh) [@zhangy1317](https://gitee.com/zhangy1317) | 社区repo-Epol |
|[I4RAOD](https://gitee.com/openeuler/release-management/issues/I4RAOD)|发布kiran-desktop 2.2版本|Testing|sig-KIRAN-DESKTOP|[@tangjie02](https://gitee.com/tangjie02)| 社区repo-Epol |
|[I4S8D3](https://gitee.com/openeuler/release-management/issues/I4S8D3)|支持xfce|Testing|xfce|[@zhang__3125](https://gitee.com/zhang__3125) [@dwl301](https://gitee.com/dwl301)| 社区repo-Epol |

> 当前社区release分为以下集中方式: 社区repo-OS/everything/Epol/独立镜像，oepkgs(软件所仓库)，sig独立发布(各sig自定义发布链接提供至release-sig)

本次版本测试活动分工如下：

| **需求** | **开发主体** | **测试主体** | **测试分层策略** |
| ------------------------------- | --------------------- | ----------------- | ------------------------------------------------------------ |
| 支持树莓派发布件 | sig-RaspberryPi | sig-RaspberryPi | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试 |
| 支持UKUI桌面 | sig-UKUI | sig-UKUI | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能 |
| 支持DDE桌面 | sig-DDE | sig-DDE | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持Kiran桌面 | sig-KIRAN-DESKTOP | sig-KIRAN-DESKTOP | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能 |
| 支持xfce桌面 | sig-xfce | sig-xfce | 验证xfce桌面系统在openEuler版本上的可安装和基本功能 |
| 支持GNOME桌面 | sig-gnome | sig-gnome | 验证gnome桌面系统在openEuler版本上的可安装和基本功能 |
| 支持HA软件 | sig-Ha | sig-Ha | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持OpenStack Train 和 Wallaby | sig-OpenStack | sig-OpenStack | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能 |
| 支持secPave | sig-Security_facility | sig-QA | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
| 支持secGear | sig-Security_facility | sig-QA | 继承已有测试能力，关注secGear特性的功能完整性 |
| 发布eggo | sig-CloudNative | sig-CloudNative | 验证eggo在openEuler上的安装部署以及提供的部署K8S集群的能力 |
| 新增容器OS支持 | sig-CloudNative | sig-CloudNative | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
| 支持OpenResty | sig-OpenResty | sig-OpenResty | 验证openResty平台在openEuler版本上的可安装性和基本功能 |
| 支持定制裁剪工具套件oemaker | sig-OS-Builder | sig-QA | 继承已有测试能力，验证可定制化的能力 |
| etmem内存分级扩展框架 | sig-Storage | sig-QA | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
| 新增芯片支持 | sig-kernel | sig-QA | 验证相关补丁使能情况，另外通过LTP、syzkaller、性能对内核进行保证，主要涉及如下芯片AMD(milan EPYC 7003)、飞腾(FT2000+、FT2500)、海光(71xx、72xx)、Intel(icelake、SPR)、申威(SW3231)、兆芯(KX-6640A)等 |
| 支持RISC-V | sig-RISC-V | sig-RISC-V | 验证openEuler版本在RISV-V处理器上的可安装和可使用性 |
| 版本其它需求 | sig-QA | sig-QA | 发布范围需求的质量保障和系统整体集成能力 |

# 3 版本概要测试结论

   openEuler 22.03 LTS 版本整体测试按照release-manager团队的计划，共完成了一轮重点特性测试+两轮全量测试+一轮回归测试+版本发布验收测试；其中第一轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫面及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；另外两轮全量测试开展版本交付的所有特性和各类专项测试；一轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

​    openEuler 22.03 LTS 版本共发现问题 360 个，有效问题 338 个，遗留问题 6 个(详见遗留问题章节)，其他问题均已修复，回归测试结果正常。版本整体质量较好。

# 4 版本详细测试结论

openEuler 22.03 LTS版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从创新版本回合特性包括容器OS、支持云原生集群部署eggo解决方案、内存分级扩展等特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚（该版本不涉及）、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试；

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
| 1 | 内核 | <font color=green>█</font> | 继承内核已有测试能力，通过使用开源测试套LTP和mmtest对内核开展基本功能进行测试；并通过构建地址消毒的内核版本利用syzkaller开源测试套进行fuzz测试；通过构建系统压力，反复长时间随机执行LTP基本系统调用，对内核开展7*24小时的稳定性测试，整体用例执行通过；内核整体质量良好 |
| 2 | [容器(isula/docker/安全容器/系统容器/镜像)](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%E7%89%88%E6%9C%ACisula-build%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 覆盖容器领域iSula和docker引擎的基本能力，针对安全容器、系统容器、普通容器和容器镜像进行功能/可靠性/稳定性测试，共执行用例742个，用例执行全部通过，整体质量良好 |
| 3 | [编译器(gcc/jdk)](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%E7%89%88%E6%9C%ACGCC%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 对gcc/jdk组件完成开源功能测试套supertest和开源fuzz测试套csmith\jfuzz的全量覆盖，另外使用SEPCjbb2015对jdk开展性能max-jOPS和critical-jOPS项的测试，编译器组件整体质量良好 |
| 4 | [虚拟化(qemu/stratovirt)](https://gitee.com/openeuler/QA/blob/501d1ea98ba63a666ef01ae89ca0a2e8bbd6492f/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%20LTS%E7%89%88%E6%9C%ACStratoVirt%E6%94%AF%E6%8C%81%E8%AE%BE%E5%A4%87%E7%83%AD%E6%8F%92%E6%8B%94%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 继承已有测试能力，覆盖虚拟化组件(qemu&stratovirt)的基本功能、可靠性、稳定性及场景测试，使用开源的测试套tp-libvirt和tp-qemu开展各类测试，整体质量良好 |
| 5 | [Kunpeng加速引擎]() | <font color=green>█</font> | 继承已有测试能力，完成加速器KAE的基本功能和性能指标验证，共计执行用例176个，全部执行通过，满足发布标准 |
| 6 | [A-Tune]() | <font color=green>█</font> | A-Tune作为操作系统性能调优引擎，完成特性查询负载类型、分析负载类型并自优化、自调优以及模型训练输入数据集的训练等功能用例全量测试，并从高压力负载和长时间运行两个方面对A-Tune功能进行验证，共计执行用例123个，特性整体质量良好 |
| 7 | [支持kubeOS](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%E7%89%88%E6%9C%ACKubeOS%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 继承已有测试能力，共执行用例14条，覆盖基本功能、测试配置测试、安全及性能测试，特性整体风险较小，质量良好 |
| 8 | [支持UKUI桌面](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler_22.03%E7%89%88%E6%9C%ACUKUI%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共执行两轮测试，覆盖UKUI桌面的核心功能、重要组件及系统插件的测试，共计执行用例62条，整体质量良好 |
| 9 | [支持DDE桌面](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共执行两轮测试，共执行用例240条，主要覆盖了基础组件跟预装应用核心功能以及基本UI测试。发现3个问题，已经回归通过，无遗留问题。整体核心功能基本可满足使用。 |
| 10 | [支持xfce桌面](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler-22.03%E7%89%88%E6%9C%ACxfce%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共经过两轮测试，执行103个测试项，整体核心功能(重要组件和系统插件)稳定正常，整体质量良好 |
| 11 | [支持gnome桌面](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03-LTS%E7%89%88%E6%9C%ACgnome%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共经过两轮测试，执行201个测试项，整体核心功能(重要组件和系统插件)稳定正常，整体质量良好 |
| 12 | [支持OpenStack Train版本](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler-22.03-LTS-OpenStack%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 覆盖T版本提供组件的API和功能测试，并通过tempest测试套完成集成验证和长稳测试；共计执行用例1161条 |
| 13 | [支持高可用pacemaker](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%20LTS%20%E7%89%88%E6%9C%ACHA%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共执行三轮测试，执行测试用例87条，主要覆盖HA的基本能力；在各类资源异常失效情况下的切换能力；日志收集功能及网络故障异常场景下的HA功能，通过长时间测试，稳定性良好，特性基本可用。 |
| 14 | [支持eggo](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%E7%89%88%E6%9C%ACeggo%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 执行测试用例18条，覆盖eggo提供的对K8S集群的部署、销毁、节点加入及删除的功能 |
| 15  | [树莓派](https://gitee.com/openeuler/QA/blob/f8b295281def2877e702aa9d256e17d1a9a47fae/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%20LTS%E6%A0%91%E8%8E%93%E6%B4%BE%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 对树莓派镜像进行安装、基本功能、管理工具、硬件兼容性和稳定性测试；共执行用例85条，整体质量良好 |
| 16 | [支持内存分级扩展]() | <font color=green>█</font> | 共计执行90个用例，覆盖范围包括特性的功能、可靠性，安全和性能；整体质量良好<br/>约束：1、客户端和服务端需要在同一个服务器上部署，不支持跨服务器通信的场景<br/>2、仅支持扫描进程名小于或等于15个字符长度的目标进程 |
| 17 | [集成secgear组件](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03_LTS%E7%89%88%E6%9C%ACsecGear%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共计执行100个用例，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试；质量良好 |
| 18 | [定制裁剪工具套件oemaker](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%E7%89%88%E6%9C%ACoemaker%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 覆盖裁剪工具的基本命令功能，并对异常参数进行覆盖；另外对裁剪出来的镜像进行安装部署及基本验证，保障裁剪工具的E2E能力完整性 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称** | **测试覆盖情况** | **约束依赖说明** | **遗留问题单** | **质量评估** | **备注<img width=50/>** |
| -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1 | 南向芯片厂商适配 | 共执行2轮测试，对AMD(milan EPYC 7003)、飞腾(FT2000+、FT2500)、海光(71xx、72xx)、Intel(icelake)、申威(SW3231)、兆芯(KX-6640A)等厂商，覆盖[整机兼容性测试](https://gitee.com/openeuler/oec-hardware)和[社区集成测试](https://gitee.com/openeuler/mugen)  | NA | NA | <font color=green>█</font>  | NA |
| 2 | [GCC自动反馈优化相关软件包引入及优化效果增强](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%E7%89%88%E6%9C%ACGCC%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共执行3轮测试，通过dejagnu、bstest、llvmcase、codedb等测试套覆盖基础功能，通过HPC应用范围软件编译验证自动反馈优化特性，保证编译器整体核心功能正常稳定 | NA | NA | <font color=green>▲</font>  | 后续除HPC场景的软件外，需关注其他场景软件编译自动反馈的性能与稳定性。测试过程中需要增加自动反馈优化性能相关测试 |
| 3 | [openGauss默认集成到openEuler操作系统中](https://gitee.com/openeuler/QA/blob/c28868290907a38e7fdf9dcedfb4ad01f279a565/Test_Result/openEuler_22.03_LTS/openGauss%203.0.0%20Release%E7%89%88%E6%9C%AC%E6%94%AF%E6%8C%81openGauss%E9%9B%86%E6%88%90%E5%88%B0openEuler.md) | 共执行4轮测试，共执行用例28423条，5个测试套覆盖基础功能中接入层，SQL层、存储层、管理和安全等维护的测试，其余从可靠性、性能、工具和兼容性四个维护覆盖生态测试 | NA | NA | <font color=green>█</font>  | NA |
| 4 | [新增支持容器场景在离线混合部署(rubik)](https://gitee.com/openeuler/QA/blob/d4d0336e92a0da0d5d0d3bc2b4e494e3cd04dee3/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%E7%89%88%E6%9C%AC%E6%B7%B7%E5%90%88%E9%83%A8%E7%BD%B2%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共执行2轮全量测试，测试覆盖接口、功能场景、可靠性和安全。重点结合容器场景验证了在线对离线业务的抢占，以及混部情况下的调度优先级测试。 | NA | NA | <font color=green>█</font> | 商用软件开源，继承测试能力，质量可控 |
| 5 | [StratoVirt安全容器支持直通设备热插拔](https://gitee.com/openeuler/QA/blob/501d1ea98ba63a666ef01ae89ca0a2e8bbd6492f/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%20LTS%E7%89%88%E6%9C%ACStratoVirt%E6%94%AF%E6%8C%81%E8%AE%BE%E5%A4%87%E7%83%AD%E6%8F%92%E6%8B%94%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共执行2轮全量测试，验证接口功能、可靠性。重点覆盖设备在压力背景下热插后能够正常使用，热拔后是否有残留，以及热插拔后的容器生命周期验证。 | NA | [I4XPUX](https://gitee.com/openeuler/stratovirt/issues/I4XPUX) | <font color=green>█</font> | 商用软件开源，继承测试能力，质量可控 |
| 6 | [libcareplus提供Qemu热补丁能力](https://gitee.com/openeuler/QA/blob/46baeec0bf3f920d0bcfa8af80c6c54f859fdad0/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%20LTS%E7%89%88%E6%9C%AClibcareplus%E6%94%AF%E6%8C%81qemu%E7%83%AD%E8%A1%A5%E4%B8%81%E8%83%BD%E5%8A%9B%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共执行2轮全量测试，验证了热补丁框架升级、回退功能，以及升级、回退后的虚拟机生命周期，同时验证了连续升级回退、故障中断等可靠性场景。 | NA | [I4Z6PM](https://gitee.com/openeuler/libcareplus/issues/I4Z6PM) | <font color=blue>▲</font> | 商用软件开源，继承测试能力，质量可控 |
| 7 | [新增支持gazelle高性能用户态协议栈](https://gitee.com/openeuler/QA/blob/03eb41de1d4b8a5d8eacbbb67b84b3cd0b1c4f35/Test_Result/openEuler_22.03_LTS/openEuler%2022.03%E7%89%88%E6%9C%ACgazelle%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A) | 共执行了2轮全量测试，覆盖了gazella安装部署、命令行接口和配置文件接口测试，重点测试转发业务流和性能规格场景，并结合网络发包仪打流和故障进行长稳验证。 | NA | NA | <font color=blue>▲</font> | 继承了商用测试能力，待众测后观察 |
| 8 | [支持OpenStack Wallaby版本](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler-22.03-LTS-OpenStack%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 覆盖W版本提供组件的API和功能测试，并通过tempest测试套完成集成验证和长稳测试；共计执行用例1161条 | NA | NA | <font color=green>█</font> | 当前社区openStack sig整体流程完善，但开发周期和测试周期较赶 |
| 9 | [支持kiran桌面](https://gitee.com/openeuler/QA/blob/48f30ebfa49477bcc2ba55f3d7e9f82e61416d5b/Test_Result/openEuler_22.03_LTS/%20openEuler%2022.03%20LTS%E7%89%88%E6%9C%ACKiranUI%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共进行了3轮测试，执行了66条测试用例，覆盖了系统面板、控制中心、基础组件、文件管理器caja和通知区域的功能测试，同时从系统性能和稳定性方面进行了测试 | NA | NA | <font color=green>█</font> | NA |


<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler 22.03-LTS作为5.10内核的第一个LTS版本，不涉及升级兼容性测试，后续SP版本会对应进行开展。

### 4.2.2   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成42张板卡的测试，完成兼容性测试的硬件信息详见链接：[兼容性清单](https://www.openeuler.org/zh/compatibility/)

下表列出版本集成验证中涉及的硬件整机信息：

| 硬件型号 | 硬件详细信息 |
| --------------------- |------------------------------------------------------------------------------------ |
| TaiShan200 2280服务器 | CPU型号：Kunpeng 920<br />CPU核数：128<br />内存：32G*8<br />网卡：Hi1822 |
| RH2288H V5服务器 | CPU型号：Intel(R) Xeon(R) Gold 6266C CPU@3.00GHZ<br />CPU核数：44<br />内存：12*32G<br />网卡：Hi1822 |
| 树莓派4B卡 | CPU:Cortex-A72 * 4 <br />内存：8GB <br />存储设备：SanDisk Ultra 16GB micro SD |
| 树莓派3B+卡 | CPU:Cortex-A53 * 4<br />内存：1GB 存储设备<br />SanDisk Ultra 16GB micro SD |
| 树莓派3B卡 | CPU:Cortex-A53 * 4 <br />内存：1GB <br />存储设备：SanDisk Ultra 16GB micro SD |
| 长城擎天服务器<br>DF723 | CPU型号：FT2000+<br>CPU核数：64<br>内存：64G<br>硬盘容量：240G |
| 联想启天台式机<br>M425-N000 | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz<br>CPU内核总数：6<br>内存容量：16G |
| FT-2000+64核服务器 | CPU型号：FT-2000+<br />CPU核数：64<br />内存：镁光16G*32<br />网卡：I350 |
| Phytium S2500/64C | CPU型号：S2500/64C <br />CPU核数：64<br />内存：16G*16 DDR4<br />网卡：I350 |
| Supermicro AS-4124GS-TNR | CPU型号：AMD EPYC 7513 32-Core Processor<br />CPU核数：32<br />内存：32G*16 DDR4<br />网卡：I350 |

### 4.2.3   北向兼容性

北向兼容性整体测试按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。从archlinux当前已完成部分见下表：

| 软件名称  | 软件版本信息 |
| --------- | ------------ |
| sysbench  | 0.4.8        |
| unixbench | 5.1.3        |
| lmbench   | 3-alpha1     |
| nginx     | 1.14.2       |
| netperf   | 2.7.0        |
| hackbench | 1.0          |

[虚拟机兼容性](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS/openEuler22.03_LTS_RC3%E7%89%88%E6%9C%AC%E8%99%9A%E6%8B%9F%E5%8C%96%E5%85%BC%E5%AE%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)(openEuler虚机镜像在其他发行版os的兼容性)

| OS版本  | 架构 |  虚拟化组件版本 |
| ------ | ---- | ------------ |
| CentOS 7.9 | aarch64 | qemu 1.5.3<br>libvirt 4.5.0<br> virt-manager 1.5.0|
| CentOS 7.9 | x86_64 | qemu 1.5.3<br>libvirt 4.5.0<br> virt-manager 1.5.0|
| CentOS 8 | aarch64 | qemu 2.12.0<br>libvirt 4.5.0<br> virt-manager 2.0.0|
| CentOS 8 | x86_64 | qemu 2.12.0<br>libvirt 4.5.0<br> virt-manager 2.0.0|
| fedora 32 | x86_64 | qemu 4.2.0<br>libvirt 6.1.0<br> virt-manager 2.2.1|
| fedora 35 | x86_64 | qemu 6.1.0<br>libvirt 7.6.0<br> virt-manager 3.2.0|

以上fedora arm版本因默认未包含测试用arm物理机网卡驱动，故测试结果不在报告中体现

## 4.3   专项测试结论

### 安全测试

整体安全测试覆盖：

1、Linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/编译选项扫描/交付件病毒扫描

3、白盒安全测试主要通过fuzz测试实现对接口参数类和内存管理类进行覆盖；通过部署kasan版本的内核，进行syzkaller测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对编译器组件行fuzz测试；

4、针对安全加固指南中的加固项，进行全量测试。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------------------------------------------------------------------------------ | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7*24小时   |
| 虚拟化长稳 | 结合Qemu ASAN地址消毒、Avocado-vt对新增特性开展长期测试 | 虚拟化组件稳定运行7*24小时 |

> 当前操作系统长稳，采用的是RC4的结论。根据测试策略与版本管理，从RC4启冻结版本分支，仅bugfix和cve可合入。当前分析RC4后kernel代码合入，与kernel-sig达成一致，2203 LTS版本整体版本长稳结论可复用RC4结论，详细修改与分析见[I4YNB6](https://gitee.com/openeuler/QA/issues/I4YNB6)
### 性能测试

| **指标大项** | **指标小项** | **指标值** | **测试结论** |
| ------------- | ------------------------------------------------------------ | --------------------------------- | -------------------- |
| OS基础性能 | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考20.03 LTS SP3版本相应指标基线 | 相比SP3版本基本持平(64k页场景) |
| 数据库性能(gazella) | 该用户态网络协议栈主要通过数据库的场景评估性能提升 | 数据库性能提升10% | 性能规格满足需求指标要求 |

# 5   问题单统计

openEuler 22.03-LTS版本共发现问题 360 个，有效问题 338 个，其中修复问题单 314 个，回归均通过。详细分布见下表:

| 测试阶段 | 问题总数 | 有效问题单数 | 无效问题单数 |
| ----------------------- | -------- | ----------- | ---------- |
| openEuler 22.03 LTS RC1 | 115 | 107 | 8 |
| openEuler 22.03 LTS RC2 | 129 | 120 | 9 |
| openEuler 22.03 LTS RC3 | 74 | 73 | 1 |
| openEuler 22.03 LTS RC4 | 33 | 30 | 3 |
| openEuler 22.03 LTS RC5 | 9 | 8 | 1 |

1. 本次版本涉及大批量的软件重新选型升级，Epol范围的软件包、rubygem系列的软件包的升级整改直至round2才合入社区纳入测试。故大批量特性round2才开启测试，round2相比round1问题单呈增长趋势
2. openStack W/gazella特性/Desktop特性于round3才合入版本测试，round4问题其问题单占80%(24/30);以上新增特性均为Epol范围，为用户态软件对整体基础os测试结论影响可控
3. 可靠性专项：长稳持续进行(混合压力测试)，未发现问题;文件系统、网络系统等os基础子故障注入专项测试于round3开展，网络专项发现问题，于round4均已闭环

整体看核心镜像范围内软件问题单收敛趋势明显。在版本发布过程中，需要联合release-sig强管控特性的合入周期，

# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| ---- | ------- | -------- | -------- | ------- | -------- | --------- | 
| 1 | [I4ULSE](https://gitee.com/src-openeuler/podman/issues/I4ULSE) | podman执行create命令使用blkio-weight参数报错 | 次要 | 因内核对该参数的设置从4.19至5.10由blkio.weight变更为blkio.bfq.weight,故podman设置blkio.weight参数失败(容器与宿主机磁盘访问时间片配比的参数),对容器运行时功能无影响 | podman新版本已配合最新kernel保证该参数可用，但涉及涉及容器的基础库runc等，和container sig共同于630前完成升级并以update形式发布 | 2203 LTS新增 |
| 2 | [I4WPBY](https://gitee.com/src-openeuler/nfs-utils/issues/I4WPBY) | nfs-blkmap服务停止后显示状态failed | 提示 | 两个问题：1. 服务停止时free已释放地址(已修复);2. 服务的正常退出返回码为1，导致systemd识别其状态为failed;当前遗留2,对该服务功能无影响 | 版本遗留,跟踪上游社区修改 | [I4K3EI](https://gitee.com/src-openeuler/nfs-utils/issues/I4K3EI) 2003 LTS SP3已知问题，补丁未同步 |
| 3 | [I4WPWR](https://gitee.com/src-openeuler/samba/issues/I4WPWR) | samba.service服务执行stop操作之后状态为failed | 次要 | systemctl stop的操作结果是生效，samba服务对信号SIGTERM的返回值是127，systemd处理其未failed | 版本遗留,跟踪上游社区修改 | [I3A52C](https://gitee.com/src-openeuler/samba/issues/I3A52C) 2103遗留问题|
| 4 | [I4WPME](https://gitee.com/src-openeuler/freeipmi/issues/I4WPME) | ipmidetectd.service执行stop操作之后状态为failed | 次要 | 原因同问题3 | 版本遗留,跟踪上游社区修改 | [I45FUP](https://gitee.com/src-openeuler/freeipmi/issues/I45FUP) 2003 LTS SP2遗留问题|
| 5 | [I4VDY7](https://gitee.com/src-openeuler/fence-virt/issues/I4VDY7) | fence_virtd.service服务stop失败，状态为failed | 次要 | 通过规避方式（systemctl start libvirtd.service）服务可以stop成功 | 版本遗留,跟踪上游社区修改 | [I4NFA9](https://gitee.com/src-openeuler/fence-virt/issues/I4NFA9), 2003 LTS SP3遗留问题|
| 6 | [I4X0TU](https://gitee.com/src-openeuler/dde-control-center/issues/I4X0TU) | 图标主题不能正常显示 | 次要 | 通过把 .cache/deepin/dde-api/theme_thumb删除掉，在执行 rsvg-convert 这个命令，图标主题可以正常显示。如果没有rsvg-convert该命令，安装librsv2-tools软件即可 | 版本遗留,跟踪上游社区修改 | 2203 LTS新增|



# 致谢
非常感谢以下开发者在openEuler 22.03 LTS版本测试中做出的贡献,以下排名不分先后
[xxx](xxxx)
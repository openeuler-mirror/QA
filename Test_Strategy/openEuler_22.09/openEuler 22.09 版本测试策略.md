![openEuler ico](../../images/openEuler.png)

版权所有 © 2022 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期       | 修订版本 | 修改  章节       | 修改描述               | 作者       |
| ---------- | -------- | ---------------- | ---------------------- | ---------- |
| 2022-7-26  | 1.0.0    |                  | 初稿                   | disnight |


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

openEuler 创新版本 测试策略

Abstract 摘要：

本文是openEuler 22.09 版本的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.09 版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 22.09 版本是基于5.10内核22年全新的LTS基线版本，该版本基于master分支拉出，发布范围相较20.03LTS 、20.03 LTS SP1、20.03 LTS SP2和20.03 LTS SP3版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](待release提供)
2.  新增支持：openEuler workstation镜像；openEuler统一构建系统；aops新增特性上线；编译器插件框架；支持openStack Y版本；联通opensd工具开源；新增桌面环境cinnamon；新增支持鲲鹏性能调优调测生态；rubik新增pod带宽管理特性；新增支持K3S边缘解决方案；新增智能多流技术，延长ssd磁盘寿命；国密算法适配
3.  修复bug和cve

## 需求范围

openEuler 22.09版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.09/release-plan.md)如下：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|[I5BIHV](https://gitee.com/openeuler/release-management/issues/I5BIHV)|支持OpenStack Yoga版本，并且引入Helm组件|Developing|SIG-OpenStack|[@joec88](https://gitee.com/joec88) [@huangtianhua](https://gitee.com/huangtianhua) [@xiyuanwang](@https://gitee.com/xiyuanwang)  [@zh-f](https://gitee.com/zh-f)  [@liksh](https://gitee.com/liksh) [@zhangy1317](https://gitee.com/zhangy1317)|     |     |
|[I5BIM9](https://gitee.com/openeuler/release-management/issues/I5BIM9)|正式发布联通开源的OpenStack部署工具opensd，支持OpenStack基本部署|Developing|SIG-OpenStack|[@joec88](https://gitee.com/joec88) [@huangtianhua](https://gitee.com/huangtianhua) [@xiyuanwang](@https://gitee.com/xiyuanwang)  [@zh-f](https://gitee.com/zh-f)  [@liksh](https://gitee.com/liksh) [@zhangy1317](https://gitee.com/zhangy1317)|     |     |
|[I5ASLE](https://gitee.com/openeuler/release-management/issues/I5ASLE?from=project-issue)|发布kiran-desktop 2.3版本|Developing|sig-KIRAN-DESKTOP|[@tangjie02](https://gitee.com/tangjie02)|EPOL|kiran-cpanel-xxx,kiran-control-panel,kiran-qt5-integration,kiran-widgets-qt5|
|[I5BJ7W](https://gitee.com/openeuler/release-management/issues/I5BJ7W)|支持树莓派|Developing|sig-RaspberryPi|[@woqidaideshi](https://gitee.com/woqidaideshi)|EPOL|raspberrypi-kernel,raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom|
|[I5BL1G](https://gitee.com/openeuler/release-management/issues/I5BL1G)|支持 RK3399|Developing|sig-RaspberryPi|[@woqidaideshi](https://gitee.com/woqidaideshi) [@tideao](https://gitee.com/tideao)|     |     |
|[I5BMO2](https://gitee.com/openeuler/release-management/issues/I5BMO2)|DDE组件更新支持服务器场景优化|Developing|sig-DDE|[@weidongkl](https://gitee.com/weidongkl) [@panchenbo](https://gitee.com/panchenbo)|EPOL| |
|[I59IY0](https://gitee.com/openeuler/release-management/issues/I59IY0)|Cinnamon桌面环境|Developing|sig-cinnamon|[@dwl301](https://gitee.com/dwl301) [@zhang__3125](https://gitee.com/zhang__3125)|EPOL| cinnamon,caribou,cinnamon-control-center,cinnamon-screensaver,cinnamon-menu,cjs,cinnamon-mozjs78,cinnamon-session,cinnamon-settings-daemon,cinnamon-themes,cinnamon-desktop,cinnamon-translations,xapps,nemo,tint2,python-tinycss2,python-pam,python-xapp,perl-XML-Dumper,python-plum-py,inxi,mintlocale,mint-y-icons,muffin,mint-x-icons |
|[I5BMNH](https://gitee.com/openeuler/release-management/issues/I5BMNH)|新增软件更新工具支持|Developing|sig-DDE|[@weidongkl](https://gitee.com/weidongkl) [@panchenbo](https://gitee.com/panchenbo)|EPOL|deepin-upgrade-tool|
|[I5BMMP](https://gitee.com/openeuler/release-management/issues/I5BMMP)|新增备份还原功能支持|Developing|sig-Migration|[@blueblue](https://gitee.com/blublue)|EPOL|ubackup|
|[I545LZ](https://gitee.com/openeuler/release-management/issues/I545LZ)|openEuler 22.09和22.03 SP1支持鲲鹏底软IO能力（存储、usb、SPI、Pcie、IIC、CXL、GPU和GPIO等）|Developing||[@kongzizaixian](https://gitee.com/kongzizaixian)|iso||
|[I545LT](https://gitee.com/openeuler/release-management/issues/I545LT)|openEuler 22.09和22.03 SP1支持鲲鹏性能调优和调测调优（Rasdaemon、Ras、etm、perf、wayca-SC、Mem-kind、HCCS、Hikptool等）|Developing||[@kongzizaixian](https://gitee.com/kongzizaixian)|iso||
|[I545LP](https://gitee.com/openeuler/release-management/issues/I545LP)|openEuler 22.09和22.03 SP1支持鲲鹏高速网络功能（DPDK、UB、RDMA-core、ROH、Roce、NIC等）|Developing||[@kongzizaixian](https://gitee.com/kongzizaixian)|iso||
|[I545LH](https://gitee.com/openeuler/release-management/issues/I545LH)|openEuler 22.09和22.03 SP1支持鲲鹏加速器功能（UADK、UADK_engine、starS、SDMA、ACC等）|Developing||[@kongzizaixian](https://gitee.com/kongzizaixian)|iso||
|[I545M5](https://gitee.com/openeuler/release-management/issues/I545M5)|openEuler 22.09和22.03 SP1 测试工具能力（pktgen）|Developing||[@kongzizaixian](https://gitee.com/kongzizaixian)|EPOL||
|[I59BQI](https://gitee.com/openeuler/release-management/issues/I59BQI)|【openEuler 22.09】openEuler 22.09 支持 pod带宽管理特性|Developing||[@wo_cow](https://gitee.com/wo_cow)|iso||
|[I5BM96](https://gitee.com/openeuler/release-management/issues/I5BM96)|[openEuler 22.09]StratoVirt 2.0支持标准虚拟化|Developing|||iso||
|[I5BMD4](https://gitee.com/openeuler/release-management/issues/I5BMD4)|[openEuler 22.09]集成k3s边缘解决方案|Developing|||EPOL||
|[I5BMFH](https://gitee.com/openeuler/release-management/issues/I5BMFH)|[openEuler 22.09]智能多流技术，延长ssd磁盘寿命|Developing|||iso||
|[I5BMGZ](https://gitee.com/openeuler/release-management/issues/I5BMGZ)|[openEuler 22.09]国密算法适配|Developing|||iso||
|[I5BMI3](https://gitee.com/openeuler/release-management/issues/I5BMI3)|[openEuler 22.09]libstorage高性能用户态IO|Developing|||iso||
|[I5H6DI](https://gitee.com/openeuler/release-management/issues/I5H6DI)|增强embedded版本分布式软总线及混合部署能力|Discussion|sig-yocto|[@linzichang](https://gitee.com/linzichang) [@beiling.xie](https://gitee.com/beilingxie) [@zhengjunling](https://gitee.com/junling_zheng) [@ilisimin](https://gitee.com/open_euler/dashboard/members/ilisimin) [@任慰](https://gitee.com/open_euler/dashboard/members/vonhust)|embedded|yocto-meta-openeuler,dsoftbus_standard, yocto-embedded-tools, OpenAMP|




# 风险

| 问题类型 | 问题描述 | 问题等级 | 应对措施 | 责任人 | 状态 |
| -------- | -------- | -------- | -------- | ------ | ---- |
|          |          |          |          |        |      |

# 测试分层策略

本次创新版本的具体测试分层策略如下：

| **需求**                        | **开发主体**          | **测试主体**      | **测试分层策略**                                             |
| ------------------------------- | --------------------- | ----------------- | ------------------------------------------------------------ |
| 支持树莓派发布件 | sig-RaspberryPi | sig-RaspberryPi | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试 |
| 支持UKUI桌面 | sig-UKUI | sig-UKUI | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能 |
| 支持HA软件 | sig-Ha | sig-Ha | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持DDE桌面 | sig-DDE | sig-DDE | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标、重点验证软件更新工具和备份还原功能 |
| 支持Kiran桌面 | sig-KIRAN-DESKTOP | sig-KIRAN-DESKTOP | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能 |
| 支持xfce桌面 | sig-xfce | sig-xfce | 验证xfce桌面系统在openEuler版本上的可安装和基本功能 |
| 支持GNOME桌面 | sig-gnome | sig-gnome | 验证gnome桌面系统在openEuler版本上的可安装和基本功能 |
| 支持Cinnamon桌面 | sig-cinnamon | sig-cinnamon | 验证Cinnamon桌面系统在openEuler版本上的可安装和基本功能 |
| 支持KubeSphere | sig-KubeSphere | sig-KubeSphere | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力 |
| 支持OpenStack Yoga | sig-OpenStack | sig-OpenStack | 重点验证openstack Y版本发布主要组件的安装部署、基本功能 |
| 支持OpenStack部署工具opensd | sig-OpenStack | sig-OpenStack | 重点验证opensd和openstack Y版本配套的部署能力 |
| 支持secPave | sig-Security_facility | sig-QA | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
| 支持secGear | sig-Security_facility | sig-QA | 继承已有测试能力，关注secGear特性的功能完整性 |
| 发布eggo | sig-CloudNative | sig-CloudNative | 验证eggo在openEuler上的安装部署以及提供的部署K8S集群的能力 |
| 新增容器OS支持 | sig-CloudNative | sig-CloudNative | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
| 新增NestOS | sig-CloudNative | sig-CloudNative | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 支持OpenResty | sig-OpenResty | sig-OpenResty | 验证openResty平台在openEuler版本上的可安装性和基本功能 |
| etmem内存分级扩展框架 | sig-Storage | sig-QA | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
| 南向兼容性支持 | sig-kernel | sig-Compatibility-Infra | 验证openEuler对应架构的发布镜像在各类架构服务器上的兼容性（包含树莓派等嵌入式开发板场景） |
| 支持定制裁剪工具套件oemaker | sig-OS-Builder | sig-QA | 继承已有测试能力，验证可定制化的能力 |
| 支持鲲鹏的各项能力 | 待补充 | 待补充 | 验证鲲鹏上支持的底软IO能力、 性能调优和调测调优、高速网络功能、加速器工程、测试工具能力的交付完整性和基本功能 |
| 支持openEuler embedded镜像 | sig-yocto | sig-yocto | 详见embedded的测试策略 |




# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*                    | *重点*                                                       | *设计思路*                                                   | *备注* |
| ------ | ---------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------ |

> 由各sig补充


## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                              | 策略                                                         |
| ----------------------------------------- | ------------------------------------------------------------ |
| 内核                                      | 直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化                                    | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 编译器(gcc/jdk)                           | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证，验证自动反馈优化的功能与性能提升效果   |
| 安装部署                                  | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| Kunpeng加速引擎                           | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 |
| A-Tune                                    | 继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| DDE                                       | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           |
| UKUI                                      | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           |
| xfce                                      | 继承已有测试能力，重点关注xfce桌面的可安装性和提供组件的能力 |
| 树莓派                                    | 继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     |
| 内存分级扩展                              | 继承已有测试能力，重点验证特性的基本功能和稳定性             |
| 支持kubernetes                            | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 支持kubeOS                                | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 |
| 支持eggo                                  | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 |
| 支持HA                                    | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 |
| 支持Kiran桌面                             | 增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 |
| 支持openstack Train 和 Wallaby            | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能 |
| 支持定制裁剪工具套件oemaker               | 继承已有测试能力，验证可定制化的能力                         |
| 支持secGear                               | 继承已有测试能力，关注secGear特性的功能完整性                |
| 支持secPave                               | 继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    |
| 支持openGauss                             | 覆盖基础功能中接入层，SQL层、存储层、管理和安全等维护的测试，其余从可靠性、性能、工具和兼容性四个维护覆盖生态测试 |
| 支持在离线混合部署rubik                    | 覆盖接口、功能场景、可靠性和安全。重点结合容器场景验证了在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 支持gazella高性能用户态协议栈              | 覆盖了gazella安装部署、命令行接口和配置文件接口测试，重点测试转发业务流和性能规格场景，并结合网络发包仪打流和故障进行长稳验证 |
| libcareplus支持Qemu热补丁能力             | 验证热补丁框架升级、回退功能，以及升级、回退后的虚拟机生命周期，以及连续升级回退、故障中断等可靠性场景 |

## 专项测试策略

### 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。整体安全测试需要覆盖：

1.  linux系统安全配置/权限管理等

2.  特性涉及到的安全需求验证

3.  CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

4.  安全测试

| 测试类         | 描述                      | 具体测试内容                                                 |
| :------------- | ------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | CVE扫描/敏感信息/编译选项 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全配置管理类 | Linux安全规范             | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试 |
| 安全测试类 | Fuzz测试                  | Fuzz测试是能发现接口参数类问题和内存相关问题的有效方法，所以需要针对操作系统重点软件包开展fuzz；通过部署kasan版本的内核，进行syzkaller的测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对对编译器组件进行fuzz测试；虚拟化组件qemu的asan版本开展fuzz测试； |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 测试类性     | 具体测试内容                                                 |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| 特性长稳     | 特性级的可靠性，需结合特性涉及和使用的资源类型，如进程、服务、文件、CPU/内存/IO/网络等；通过模拟各类资源异常/竞争/压力故障场景，并发/反复的进行特性提供的基本功能操作 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。openEuler SP版本是LTS版本的补丁版本，所以在操作系统基本benchmark各类指标上需要和LTS版本保持一致，性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                                               | **指标值**              | **说明**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考LTS版本相应指标基线 | 与LTS基线数据差异小于5%以内可接受 |

### 兼容性测试(创新版本不涉及)

南向兼容性测试分板卡测试和整机适配测试两个部分。

板卡兼容性交付清单如下：

| **板卡类型**  | **覆盖范围**  | **测试主体** | **chipVendor** |**boardModel**  | **chipModel** |
|--|--|--|--|--|--|
| | | | | |

整机适配兼容性测试交付清单如下：

| **服务器**  | **CPU型号**  | **测试主体** | **测试计划** |
|--|--|--|--|
| | | | |


### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**       | **覆盖策略**                                                           | **中英文测试策略** |
|--------------------|------------------------------------------------------------------------|--------------------|
| DDE安装指南        | 安装步骤的准确性及DDE桌面系统是否能成功安装启动                        | 英文描述的准确性   |
| UKUI安装指南       | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动                       | 英文描述的准确性   |
| KIRAN安装指南 | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动 | 英文描述的准确性 |
| XFCE安装指南 | 安装步骤的准确性及XFCE桌面系统是否能成功安装启动 | 英文描述的准确性 |
| GNOME安装指南 | 安装步骤的准确性及GNOME桌面系统是否能成功安装启动 | 英文描述的准确性 |
| Cinnamon安装指南 | 安装步骤的准确性及Cinnamon桌面系统是否能成功安装启动 | 英文描述的准确性 |
| 树莓派安装指导     | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   |
| 安装指南           | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 管理员指南         | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 安全加固指南       | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 虚拟化用户指南     | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| StratoVirt用户指南 | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 容器用户指南       | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| A-Tune用户指南     | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 应用开发指南       | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| 工具集用户指南     | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |

### RPM软件包spec文件测试

#### 多动态库排查

多动态库软件包排查主要是对版本交付的RPM软件包中含有多个版本的动态库，造成这个问题的主要原因是spec文件编写不规范，故此，对版本交付的RPM软件包对应的spec文件进行测试，主要是排查spec文件编写的正确性，在排查时有两点要求：

1.  软件包编译不依赖自身

2.  打包仅包含编译新生成的文件，不包含系统环境文件

# 测试执行策略

openEuler 22.09版本按照社区release-manger团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取1+3+1的测试方式，即1轮基本功能保障发布beta版本可以提供给外部开发者，3轮全量保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归。

### 测试计划

openEuler 22.09 版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。已发布[ALpha版本](http://121.36.84.172/dailybuild/openEuler-22.09/openeuler-2022-07-25-10-43-26/)供适配开发使用

| Stange name   | Begin time | End time   | Days | Note                          | Status |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
| Alpha测试    | 2022/7/25 | 2022/8/1  | 7 | 开发者版本测试 | 已完成 |
| Test round 1（计划） | 2022/8/1  | 2022/8/7  | 7 | Beta版本测试（延期7天） | 进行中 |
| Test round 1（实际） | 2022/8/8  | 2022/8/15 | 7 | Beta版本测试（延期7天） | 进行中 |
| 变更检查阶段4 | 2022/8/8  | 2022/8/8  | 1 | 版本分支发起软件包淘汰（持续编译/构建失败）评审 | 待开展 |
| Final冻结    | 2022/8/9  | 2022/8/9  | 1 | Release版本基线冻结，启动全量编译构建| 待开展 |
| Test round 2 | 2022/8/11 | 2022/8/17 | 7 | 版本全量集成测试 | 待开展 |
| 变更检查阶段5 | 2022/8/18 | 2022/8/22 | 4 | 版本分支代码冻结：受限合入，原则上仅允许bug fix | 待开展 |
| Test round 3 | 2022/8/23 | 2022/8/29 | 7 | 版本分支代码冻结：管控合入，原则上只允许bug fix   | 待开展 |
| Test round 4 | 2022/9/2  | 2022/9/8  | 7 | 回归测试      | 待开展 |
| Test round 5 | 2022/9/12 | 2022/9/18 | 7 | 回归测试 (9.20~9.29预留buffer) | 待开展 |
| Release      | 2022/9/30 | 2022/9/30 | 1 | 社区Release版本发布评审| 待开展 |

### 测试重点

测试阶段1：

1.  继承特性/新特性的基本功能

2.  交付重要组件(内核、虚拟化、容器、编译器等)的功能完整性

3.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整性

4.  通过软件包管理测试，对LTS版本发布软件的可安装进行整体保证

5.  专项情况如下：

    性能：保证版本的性能满足发布基线标准，不能低于LTS版本性能指标

    安全测试：进行安全CVE漏洞、安全编译选项、敏感信息扫描

    南向兼容性验证

测试阶段2：

1.  继承特性/新特性的全量验证

2.  通过自动化覆盖重要组件的功能

3.  系统集成的正确性和完整性

4.  软件包管理测试

5.  专项：

    可靠性：保证版本的长时间稳定运行，建议运行时长7\*24
    
    软件包fuzz测试
    
    兼容性测试：南向硬件测试+北向软件测试

测试阶段3：

1.  继承特性/新特性的自动化全量验证

2.  系统集成验证

3.  软件包管理测试

4.  专项：性能、可靠性、文档测试、南北向兼容性测试、RPM软件包spec文件测试

5.  问题单回归

测试阶段4：

1.  交付特性/组件的全量测试

2.  问题单回归

3.  软件包管理测试

4.  系统集成验证

5.  专项：安全CVE扫描、可靠性、性能、文档测试、南北向兼容性测试

测试阶段5：

1.  交付特性/组件的自动化全量测试

2.  系统集成自动化测试项执行

3.  问题单全量回归

4.  专项：交付件病毒扫描、文档测试

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

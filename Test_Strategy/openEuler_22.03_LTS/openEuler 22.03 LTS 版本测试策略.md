![openEuler ico](../../images/openEuler.png)

版权所有 © 2022 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期       | 修订版本 | 修改  章节       | 修改描述               | 作者       |
| ---------- | -------- | ---------------- | ---------------------- | ---------- |
| 2022-1-24  | 1.1.0    |                  | 初稿                   | disnight |


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

openEuler LTS 测试策略

Abstract 摘要：

本文是openEuler 22.03 LTS 版本的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.03 LTS 版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 22.03 LTS版本是基于5.10内核22年全新的LTS基线版本，该版本基于openEuler 21.09分支拉出，同时回合master与其余LTS分支修改，发布范围相较20.03LTS 、20.03 LTS SP1、20.03 LTS SP2和20.03 LTS SP3版本主要变动：

1.  内核版本升级到5.10
2.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS/%E7%89%88%E6%9C%AC%E5%8F%98%E6%9B%B4%E8%AF%B4%E6%98%8E.md)
3.  删除python2
4.  新增支持：openGauss/gazella
5.  修复bug和cve

## 需求范围

openEuler 22.03 LTS版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS/release-plan.md)如下：

| **no** | **feature**                                                  | **status** | **sig**                 | **owner**                                      |
| ------ | ------------------------------------------------------------ | ---------- | ----------------------- | ---------------------------------------------- |
|[I4H9BC](https://gitee.com/openeuler/release-management/issues/I4H9BC)|新增支持RISC-V 镜像|Discussion|RISC-V|[@xuzhou zhang](https://gitee.com/whoisxxx), [@xijing](https://gitee.com/xijing666)|
|[I4IM2L](https://gitee.com/openeuler/release-management/issues/I4IM2L)|GCC自动反馈优化相关软件包引入及优化效果增强|Discussion|Compiler|[@ma-mingze](https://gitee.com/ma-mingze), [@Haijian.Zhang](https://gitee.com/haijianzhang), [@eastb233](https://gitee.com/eastb233)|
|[I4N83C](https://gitee.com/openeuler/release-management/issues/I4N83C)|openGauss默认集成到openEuler操作系统中|Discussion|DB|[@zhang_xubo](https://gitee.com/zhang_xubo), [@bzhaoop](https://gitee.com/bzhaoop)|
|[I4O21W](https://gitee.com/openeuler/release-management/issues/I4O21W)|新增支持容器场景在离线混合部署|Developing|CloudNative|[@Vanient](https://gitee.com/Vanient)|
|[I4PM21](https://gitee.com/openeuler/release-management/issues/I4PM21)|StratoVirt安全容器支持直通设备热插拔|Developing|Virt|[@frankyj915](https://gitee.com/frankyj915), [@imxcc](https://gitee.com/imxcc)|
|[I4PMNN](https://gitee.com/openeuler/release-management/issues/I4PMNN)|libcareplus提供Qemu热补丁能力|Developing|Virt|[@mdsc](https://gitee.com/mdsc), [@imxcc](https://gitee.com/imxcc)|
|[I4PLVR](https://gitee.com/openeuler/release-management/issues/I4PLVR)|IO智能多流|Developing|Kernel|[@hongrongxuan](https://gitee.com/barbo)|
|[I4PMYT](https://gitee.com/openeuler/release-management/issues/I4PMYT)|新增支持gazelle高性能用户态协议栈|Developing|sig-high-performance-network|[@wu-changsheng](https://gitee.com/wu-changsheng)|
|[I4QL70](https://gitee.com/openeuler/release-management/issues/I4QL70)|支持树莓派|Developing|RaspberryPi|[@woqidaideshi](https://gitee.com/woqidaideshi)|
|[I4RAOD](https://gitee.com/openeuler/release-management/issues/I4RAOD)|发布kiran-desktop 2.2版本|Developing|sig-KIRAN-DESKTOP|[@tangjie02](https://gitee.com/tangjie02)|



# 风险

| 问题类型 | 问题描述 | 问题等级 | 应对措施 | 责任人 | 状态 |
| -------- | -------- | -------- | -------- | ------ | ---- |
|          |          |          |          |        |      |

# 测试分层策略

本次LTS版本的具体测试分层策略如下：

| **需求**                        | **开发主体**          | **测试主体**      | **测试分层策略**                                             |
| ------------------------------- | --------------------- | ----------------- | ------------------------------------------------------------ |
| 支持树莓派发布件          | sig-RaspberryPi       | sig-RaspberryPi | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试       |
| 支持UKUI桌面              | sig-UKUI              | sig-UKUI        | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
| 支持HA软件                | sig-Ha                | sig-Ha          | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持DDE桌面               | sig-DDE               | sig-DDE         | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持Kiran桌面                   | sig-KIRAN-DESKTOP     | sig-KIRAN-DESKTOP | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
| 支持xfce桌面                    | sig-xfce              | sig-xfce          | 验证xfce桌面系统在openEuler版本上的可安装和基本功能          |
| 支持GNOME                 | sig-gnome             | sig-gnome       | 验证gnome桌面系统在openEuler版本上的可安装和基本功能         |
| 支持KubeSphere            | sig-KubeSphere        | sig-KubeSphere  | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 支持OpenStack Train 和 Wallaby      | sig-OpenStack         | sig-OpenStack   | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能      |
| 支持secPave               | sig-Security_facility | sig-QA          | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
| 支持secGear | sig-Security_facility | sig-QA | 继承已有测试能力，关注secGear特性的功能完整性 |
| 发布eggo                  | sig-CloudNative       | sig-CloudNative | 验证eggo在openEuler上的安装部署以及提供的部署K8S集群的能力   |
| 新增容器OS支持                  | sig-CloudNative       | sig-CloudNative   | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
| 支持OpenResty             | sig-OpenResty         | sig-OpenResty   | 验证openResty平台在openEuler版本上的可安装性和基本功能       |
| etmem内存分级扩展框架      | sig-Storage           | sig-QA          | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
| 支持intel ice lake              | sig-kernel            | sig-QA            | 验证相关补丁使能情况，另外通过LTP、syzkaller、性能对内核进行保证 |
| 支持兆芯处理器            | sig-kernel            | sig-QA          | 验证openEuler版本在兆芯处理器上的可安装和可使用性            |
| 支持飞腾FT2500双路服务器  | sig-kernel            | sig-QA          | 验证openEuler版本在FT2500处理器上的可安装和可使用性          |
| 支持RISC-V | sig-RISC-V | sig-RISC-V | 验证openEuler版本在RISV-V处理器上的可安装和可使用性 |
| 支持定制裁剪工具套件oemaker | sig-OS-Builder | sig-QA | 继承已有测试能力，验证可定制化的能力 |



# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*                    | *重点*                                                       | *设计思路*                                                   | *备注* |
| ------ | ---------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------ |
| 1 | GCC自动反馈优化相关软件包引入及优化效果增强 | 验证GCC新增反馈优化部分基本能力 | 验证该特性在各大应用(hpc应用等)编译的基础能力，能够正常运行且性能无明显下降 | |
| 2 | openGauss默认集成到openEuler操作系统中 | db/QA合作补充 | db/QA合作补充 | |
| 3 | 新增支持容器场景在离线混合部署 | CloudNative/QA合作补充 | CloudNative/QA合作补充 | |
| 4 | StratoVirt安全容器支持直通设备热插拔 | Virt/QA合作补充 | Virt/QA合作补充 | |
| 5 | libcareplus提供Qemu热补丁能力 | Virt/QA合作补充 | Virt/QA合作补充 | |
| 6 | 新增支持gazelle高性能用户态协议栈 | high-performance-network/QA合作补充 | high-performance-network/QA合作补充 | |


## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                              | 策略                                                         |
| ----------------------------------------- | ------------------------------------------------------------ |
| 内核                                      | 直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化                                    | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 编译器(gcc/jdk)                           | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   |
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

## 专项测试策略

### 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。整体安全测试需要覆盖：

1.  linux系统安全配置/权限管理等

2.  特性涉及到的安全需求验证

3.  CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

4.  白盒安全测试

| 测试类         | 描述                      | 具体测试内容                                                 |
| :------------- | ------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | CVE扫描/敏感信息/编译选项 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全配置管理类 | Linux安全规范             | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试 |
| 白盒安全测试类 | Fuzz测试                  | Fuzz测试是能发现接口参数类问题和内存相关问题的有效方法，所以需要针对操作系统重点软件包开展fuzz；通过部署kasan版本的内核，进行syzkaller的测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对对编译器组件进行fuzz测试；虚拟化组件qemu的asan版本开展fuzz测试； |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 测试类性     | 具体测试内容                                                 |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| 虚拟化长稳   | 通过部署qemu的地址消毒版本，通过长时间随机交互的方式，反复、并发操作各类特性的功能；建议稳定性测试时长7\*24 |
| 特性长稳     | 特性级的可靠性，需结合特性涉及和使用的资源类型，如进程、服务、文件、CPU/内存/IO/网络等；通过模拟各类资源异常/竞争/压力故障场景，并发/反复的进行特性提供的基本功能操作 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。openEuler SP版本是LTS版本的补丁版本，所以在操作系统基本benchmark各类指标上需要和LTS版本保持一致，性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                                               | **指标值**              | **说明**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考LTS版本相应指标基线 | 与LTS基线数据差异小于5%以内可接受 |

### 兼容性测试

*compatibility/QA合作补充*

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**       | **覆盖策略**                                                           | **中英文测试策略** |
|--------------------|------------------------------------------------------------------------|--------------------|
| DDE安装指南        | 安装步骤的准确性及DDE桌面系统是否能成功安装启动                        | 英文描述的准确性   |
| UKUI安装指南       | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动                       | 英文描述的准确性   |
| KIRAN安装指南 | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动 | 英文描述的准确性 |
| XFCE安装指南 | 安装步骤的准确性及XFCE桌面系统是否能成功安装启动 | 英文描述的准确性 |
| GNOME安装指南 | 安装步骤的准确性及GNOME桌面系统是否能成功安装启动 | 英文描述的准确性 |
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

# 测试执行策略

openEuler 22.03 LTS版本按照社区release-manger团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取1+3+1的测试方式，即1轮基本功能保障发布beta版本可以提供给外部开发者，3轮全量保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归。

### 测试计划

openEuler 22.03LTS 版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。已发布[尝鲜版本](http://121.36.84.172/dailybuild/openEuler-22.03-LTS-Next/test_openeuler-2022-01-18-14-52-11/)供适配开发使用

| Stange name   | Begin time | End time   | Days | Note                          |
| :------------ | :--------- | :--------- | ---- | ----------------------------- |
| Branch        | 2022/1/24  | 2022/1/24  | 1    | 从22.03 LTS-Next拉22.03 LTS版本分支(已延期) |
| Build & Alpha | 2022/1/25  | 2022/1/31 | 5    | 版本DailyBuild & 开发自验证   |
| Test round 1  | 2022/2/14 | 2022/2/18 | 5    | 版本启动测试                  |
| Test round 2  | 2022/2/22  | 2022/2/26  | 5    |                               |
| Test round 3  | 2022/2/28 | 2022/3/4 | 5    |                               |
| Test round 4  | 2022/3/7 | 2022/3/11 | 5    |                               |
| Test round 5  | 2022/3/15 | 2022/3/17 | 3    |                               |

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
4.  专项：性能、可靠性、文档测试、南北向兼容性测试
5.  问题单回归

测试阶段4：

   1.交付特性/组件的全量测试

   2.问题单回归

   3.软件包管理测试

   4.系统集成验证

   5.专项：安全CVE扫描、可靠性、性能、文档测试、南北向兼容性测试

测试阶段5：

   1.交付特性/组件的自动化全量测试

   2.系统集成自动化测试项执行

   3.问题单全量回归

   4.专项：交付件病毒扫描、文档测试

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

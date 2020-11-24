![openEuler ico](../../images/openEuler.png)

版权所有 © 2020 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期      | 修订版本 | CR号 | 修改  章节 | 修改描述 | 作者                                                         |
| --------- | -------- | ---- | ---------- | -------- | ------------------------------------------------------------ |
| 2020-11-9 | 1.1.0    |      |            | 初稿     | charlie_li/kuhnchen18/lutianxiong/lemon-higgins/rigorous/speacher/dou33/panchenbo |
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

openEuler LTS SP 测试策略

Abstract 摘要：

本文是openEuler 20.03LTS SP版本的整体测试策略，用于指导该版本测试活动开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释    |
|--------|--------------------------------------|-------------|
| LTS    | Long time support                    | 长时间维护  |
| OS     | Operation System                     | 操作系统    |
| CVE    | Common Vulnerabilities and Exposures | CVE安全补丁 |
|        |                                      |             |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 20.03LTS SP1版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 20.03LTS
SP1版本是20.03LTS的补丁版本，发布范围相较20.03LTS版本主要变动：

1.  回合openEuler 20.09版本中部分特性

2.  增加UKUI/DDE桌面系统和树莓派交付件

3.  补齐/优化社区软件包生态

4.  修复bug和cve。

## 需求范围

openEuler 20.03LTS SP1版本交付需求列表如下：

详见：<https://gitee.com/openeuler/release-management/blob/master/openEuler-20.03-LTS-SP1/release-plan.md>

|        |                                                                                                                                              |            |                        |                                                                               |
|--------|----------------------------------------------------------------------------------------------------------------------------------------------|------------|------------------------|-------------------------------------------------------------------------------|
| **no** | **feature**                                                                                                                                  | **status** | **sig**                | **owner**                                                                     |
| 1      | [openEuler 20.03 LTS SP1支持高可用pacemaker](https://gitee.com/openeuler/release-management/issues/I23GH2?from=project-issue)                | developing | sig-HA                 | yangzhao_kl                                                                   |
| 2      | [openEuler 20.03 LTS SP1支持openGauss版本](https://gitee.com/openeuler/release-management/issues/I23GGW?from=project-issue)                  | discussion |                        |                                                                               |
| 3      | [openEuler 20.03 LTS SP1支持1822 HBA卡驱动](https://gitee.com/openeuler/release-management/issues/I23GGR?from=project-issue)                 | discussion |                        |                                                                               |
| 4      | [openEuler 20.03 LTS SP1支持华为多路径](https://gitee.com/openeuler/release-management/issues/I23GGO?from=project-issue)                     | developing |                        |                                                                               |
| 5      | [openEuler 20.03 LTS SP1支持openStack](https://gitee.com/openeuler/release-management/issues/I23GGJ?from=project-issue)                      | discussion | sig-python-modules     | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 6      | [openEuler 20.03 LTS SP1支持金融领域软件包](https://gitee.com/openeuler/release-management/issues/I23GG1?from=project-issue)                 | developing | DB                     | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 7      | [openEuler 20.03 LTS SP1支持大数据管理组件Ambari的依赖组件](https://gitee.com/openeuler/release-management/issues/I23GFY?from=project-issue) | developing | sig-release-management | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 8      | [openEuler 20.03 LTS SP1新增DDE组件](https://gitee.com/openeuler/release-management/issues/I23GFR?from=project-issue)                        | developing | sig-DDE                | [\@panchenbo](https://gitee.com/panchenbo)                                    |
| 9      | [openEuler 20.03-LTS版本新增criu组件](https://gitee.com/openeuler/release-management/issues/I23GFP?from=project-issue)                       | developing |                        |                                                                               |
| 10     | [openEuler 20.03 LTS SP1支持libxml，hyperscan](https://gitee.com/openeuler/release-management/issues/I23GFL?from=project-issue)              | developing | Desktop                | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 11     | [openEuler 20.03 LTS SP1同时支持openjdk多个版本](https://gitee.com/openeuler/release-management/issues/I23GFC?from=project-issue)            | developing |                        |                                                                               |
| 12     | [openEuler 20.03 SP1 虚拟化支持内存，cpu热添加](https://gitee.com/openeuler/release-management/issues/I23GF7?from=project-issue)             | developing | Virt                   | [\@alexchen](https://gitee.com/zhendongchen)                                  |
| 13     | [openEuler 20.03 SP1 “支持vmtop”](https://gitee.com/openeuler/release-management/issues/I23GF2?from=project-issue)                           | developing | Virt                   | [\@alexchen](https://gitee.com/zhendongchen)                                  |
| 14     | [openEuler 20.03 LTS SP1虚拟化支持安全启动](https://gitee.com/openeuler/release-management/issues/I23GEY?from=project-issue)                 | developing | Virt                   | [\@alexchen](https://gitee.com/zhendongchen)                                  |
| 15     | [openEuler 20.03 LTS SP1虚拟化支持custom模式](https://gitee.com/openeuler/release-management/issues/I23GEU?from=project-issue)               | developing | Virt                   | [\@alexchen](https://gitee.com/zhendongchen)                                  |
| 16     | [openEuler 20.03 LTS SP1回合20.09 Atune](https://gitee.com/openeuler/release-management/issues/I23GEM?from=project-issue)                    | developing |                        |                                                                               |
| 17     | [openEuler 20.03 LTS SP1补充SONY使用的依赖包](https://gitee.com/openeuler/release-management/issues/I23GEG?from=project-issue)               | developing |                        |                                                                               |
| 18     | [openEuler 20.03 LTS SP1补齐pts安装依赖](https://gitee.com/openeuler/release-management/issues/I23GEC?from=project-issue)                    | developing |                        |                                                                               |
| 19     | [openEuler 20.03 LTS SP1回合20.09 iSular新版本特性](https://gitee.com/openeuler/release-management/issues/I23GE8?from=project-issue)         | developing |                        |                                                                               |
| 20     | [openEuler 20.03 LTS SP1开源openEuler-rpm-config宏](https://gitee.com/openeuler/release-management/issues/I23GDZ?from=project-issue)         | developing | Base-service           | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 21     | [openEuler 20.03 LTS SP1支持abrt组件](https://gitee.com/openeuler/release-management/issues/I23GDU?from=project-issue)                       | developing | Application            | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 22     | [openEuler 20.03 LTS SP1支持osinfo](https://gitee.com/openeuler/release-management/issues/I23GDP?from=project-issue)                         | developing | Base-service           | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 23     | [microcode_ctl需要回合支持x86](https://gitee.com/openeuler/release-management/issues/I1RFVK?from=project-issue)                              | developing |                        |                                                                               |
| 24     | [openEuler 20.03 LTS SP1新增 raspberrypi 版本](https://gitee.com/openeuler/release-management/issues/I1RMC1?from=project-issue)              | developing | RaspberryPi            | [\@woqidaideshi](https://gitee.com/woqidaideshi)                              |
| 25     | [openEuler 20.03 LTS SP1新增UKUI组件](https://gitee.com/openeuler/release-management/issues/I1R54N?from=project-issue)                       | developing | sig_UKUI               | [\@dou33](https://gitee.com/dou33)                                            |
| 26     | [openEuler 20.03 LTS SP1新增netinstall组件](https://gitee.com/openeuler/release-management/issues/I1Y26A?from=project-issue)                 | developing | sig-OS-Builder         | [\@t_feng](https://gitee.com/t_feng)                                          |
| 27     | [openEuler20.03 LTS SP1版本支持飞腾 arm64架构CPU](https://gitee.com/openeuler/release-management/issues/I1RXGT?from=project-issue)           | developing |                        |                                                                               |
| 28     | [openEuler 20.03-LTS版本升级新增bcc的软件包](https://gitee.com/openeuler/release-management/issues/I1O7RM?from=project-issue)                | developing |                        |                                                                               |
| 29     | [openEuler 20.03 LTS SP1申请新增maildrop和proftpd软件包](https://gitee.com/openeuler/release-management/issues/I1TWXG?from=project-issue)    | developing |                        |                                                                               |
| 30     | [openEuler 20.03 LTS SP1内核开启config_acpi_nfit内核选项](https://gitee.com/openeuler/release-management/issues/I26KWQ?from=project-issue)   | developing |                        |                                                                               |

# 风险

| 问题类型       | 问题描述                           | 问题等级 | 应对措施 | 责任人  | 状态    |
| -------------- | ---------------------------------- | -------- | -------- | ------- | ------- |
| 软件包生态管理 | 升级或者替代软件识别及合入版本策略 | 高       |          | solarhu | Opening |
| 性能指标       | 操作系统基本benchmark性能指标明确  | 高       |          | solarhu | Opening |

# 测试分层策略

本次SP版本的具体测试分层策略如下：

| **需求**         | **开发主体**    | **测试主体**    | **测试分层策略**                                                   |
|------------------|-----------------|-----------------|--------------------------------------------------------------------|
| 支持树莓派发布件 | sig-RaspberryPi | sig-RaspberryPi | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试             |
| 支持UKUI桌面     | sig-UKUI        | sig-UKUI        | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能                |
| 支持HA软件       | sig-Ha          | sig-Ha          | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持DDE桌面      | sig-DDE         | sig-DDE         | 验证DDE在openEuler版本上的功能及其他性能指标                       |
| 版本其它需求     | 华为            | 华为            | 发布范围需求的质量保障和系统整体集成能力                           |
| 支持openGauss    | openGauss       | openGauss       | 由openGauss团队基于openEuler版本进行验证                           |
| 支持华为多路劲   | 华为            | 华为            | 由华为相关团队基于openEuler版本进行验证                            |

# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*      | *重点*                                                                            | *设计思路*                                 | *备注* |
|--------|----------------|-----------------------------------------------------------------------------------|--------------------------------------------|--------|
| 1      | 软件包生态补齐 | 软件包的管理(安装/卸载/升级/降级) 软件包涉及命令/服务 软件包加固测试(fuzz/场景等) | 根据包优先级划分，按照对应测试策略进行覆盖 |        |
| 2      | DDE            | 桌面系统的安装 桌面系统的基本功能                                                 |                                            |        |
| 3      | HA             | HA软件的安装和基本功能 HA的可靠性及性能底噪                                       |                                            |        |

## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                              | 策略                                                                                                                                                                                                                                        |
|-------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 内核                                      | 直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证            |
| 虚拟化                                    | 继承已有测试能力，重点关注回合09版本虚拟化新特性后，新版本上虚拟化相关组件的基本功能                                                                                                                                                        |
| 编译器(gcc/jdk)                           | 继承已有测试能力，本次发布在jdk原有2个版本基础上新增一个最新版本发布件，因此需要基于开源测试套对gcc和jdk相关功能进行验证                                                                                                                    |
| 安装部署                                  | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署                                                                                                                             |
| Kunpeng加速引擎                           | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试                                                                                                                                 |
| A-Tune                                    | 继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注                                                                         |
| lm-sensor                                 | 继承已有测试能力，关注sensors/sensord服务的状态，验证sensors是否能正常查询CPU core额温度并于BMC结果进行对比                                                                                                                                 |
| UKUI                                      | 继承09版本已有测试能力，关注桌面系统的安装和基本功能                                                                                                                                                                                        |
| 树莓派                                    | 继承09版本已有测试能力，关注树莓派系统的安装、基本功能及兼容性                                                                                                                                                                              |

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
| 白盒安全测试类 | Fuzz测试                  | Fuzz测试是能发现接口参数类问题和内存相关问题的有效方法，所以需要针对操作系统重点软件包开展fuzz；通过部署kasan版本的内核，进行syzkaller的测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对对编译器组件进行fuzz测试；虚拟化组件qemu的asan版本开展fuzz测试； |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| ------------ | ------------------------------------------------------------ |
| 虚拟化长稳   | 通过部署qemu的地址消毒版本，通过长时间随机交互的方式，反复、并发操作各类特性的功能；建议稳定性测试时长7\*24 |
| 特性长稳     | 特性级的可靠性，需结合特性涉及和使用的资源类型，如进程、服务、文件、CPU/内存/IO/网络等；通过模拟各类资源异常/竞争/压力故障场景，并发/反复的进行特性提供的基本功能操作 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。openEuler SP版本是LTS版本的补丁版本，所以在操作系统基本benchmark各类指标上需要和LTS版本保持一致，性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                                               | **指标值**              | **说明**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考LTS版本相应指标基线 | 与LTS基线数据差异小于5%以内可接受 |

### 兼容性测试

openEuler社区发行版本支持LTS升级到对应的SP版，所以在软件包升级兼容性方面的策略如下：

​        openEuler 20.03LTS发布的所有可以安装的包，可以通过配置SP版本发布的repo地址，升级到本次SP版本发布的新的软件包(除新补充的包外)

本次发布SP版本在南北向兼容性方面具体测试策略如下：

| 需求分类       | 测试范围                                                     | 测试方法                                                     |
| -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 南向兼容性测试 | 1.整机包括：taishan 200 2280 、fusionserver 2288H V5、飞腾 FT-2000。<br />2.板卡包括:3408/3508 raid卡、  1822 nic 、1822 fc 卡、 mellanox CX5 网卡。备注：其余整机和板卡会持续进行测试。 | 1.针对整机进行system、memory、cpufreq、watchdog、acpi等10几个方面开展测试，<br />2.1822/mellanox使用openEuler的inbox驱动，其它驱动通过源码编译，基于典型配置优先规划。 |
| 北向兼容性测试 | 1.软件兼容：sysbench、unixbench、lmbench3、mysql、ngnix、netpert、hackbench<br />2. 包构建测试：(1 archlinux官网获取到的pkgbuild在openeuler操作系统自动构建打包测试(2 南向适配表中涉及的65款开源软件的包构建测试（其余230款开源软件将持续进行包构建测试） | 1.  unixbench,lmench3等性能测试工具在compass-ci平台上通过提交job的方式在执行机上对不同版本os进行性能测试。<br />2.  通过git clone获取官网上的pkgbuild文件，针对不同版本openeuler操作系统进行自动化构建打包测试，目前已成功构建出3950个包。 |

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**       | **覆盖策略**                                                           | **中英文测试策略** |
|--------------------|------------------------------------------------------------------------|--------------------|
| DDE安装指南        | 安装步骤的准确性及DDE桌面系统是否能成功安装启动                        | 英文描述的准确性   |
| UKUI安装指南       | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动                       | 英文描述的准确性   |
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

openEuler 20.03 LTS SP1版本按照社区release-manger团队既定的版本计划，共有4轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本的4轮测试采取3+1的测试方式，即3轮全量+1轮回归的策略。

### 测试计划

openEuler 20.03LTS SP1版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stange name  | Begin time | End time   |
| :----------- | :--------- | :--------- |
| Develop      | 2020-10-12 | 2020-11-7  |
| Comptibility | 2020-11-8  | 2020-11-18 |
| Buil         | 2020-11-19 | 2020-11-21 |
| Test round 1 | 2020-11-23 | 2020-11-28 |
| Test round 2 | 2020-11-30 | 2020-12-5  |
| Test round 3 | 2020-12-7  | 2020-12-12 |
| Test round 4 | 2020-12-14 | 2020-12-19 |
| release      | 2020-12-21 | 2020-12-22 |

### 测试重点

测试阶段1：

1.  重点关注继承特性/新特性的基本功能

2.  交付重要组件(内核、虚拟化、容器、编译器等)的功能完整性

3.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整

4.  通过软件包管理测试，对SP版本发布软件的可安装可升级性进行整体保证

5.  专项情况如下：

    性能：保证版本的性能满足发布基线标准，不能低于LTS版本性能指标

    可靠性：保证版本的长时间稳定运行，建议运行时长7\*24

    安全测试：进行安全CVE漏洞、安全编译选项、敏感信息扫描，已有的fuzz测试

    兼容性测试：通过软件包差异对比测试，保证SP版本和LTS版本发布包的前向兼容

测试阶段2：

1.  继承特性/新特性的全量验证

2.  通过自动化覆盖重要组件的功能

3.  系统集成的正确性和完整性

4.  软件包管理测试

5.  专项：

    可靠性、fuzz测试、兼容性测试、文档测试

测试阶段3：

1.  集成特性/新特性的全量验证

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

交付件病毒扫描、文档测试、性能、可靠性

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

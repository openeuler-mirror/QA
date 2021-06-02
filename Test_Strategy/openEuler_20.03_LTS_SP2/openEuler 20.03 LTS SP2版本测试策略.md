![openEuler ico](../../images/openEuler.png)

版权所有 © 2021 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期       | 修订版本 | CR号 | 修改  章节 | 修改描述 | 作者                                                         |
| ---------- | -------- | ---- | ---------- | -------- | ------------------------------------------------------------ |
| 2021-04-26 | 1.1.0    |      |            | 初稿     | charlie_li/lutianxiong/lemon-higgins/rigorous/dou33/panchenbo/SupMario/ |
| 2021-06-02 | 1.1.1    |      |需求章节    | 删除未合入的需求     |charlie_li                                                   |


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

本文是openEuler 20.03LTS SP2版本的整体测试策略，用于指导该版本测试活动开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释    |
| ------ | ------------------------------------ | ----------- |
| LTS    | Long time support                    | 长时间维护  |
| OS     | Operation System                     | 操作系统    |
| CVE    | Common Vulnerabilities and Exposures | CVE安全补丁 |
|        |                                      |             |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 20.03 LTS SP2版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 20.03 LTS SP2版本是20.03 LTS的补丁版本，发布范围相较20.03 LTS 和20.03 LTS SP1版本主要变动：

1. 修复bug和cve。
2. 特性回合:内核热升级/内存分级扩展/secGear组件/支持OpenStack R版本/支持xfce 4.14/支持K8S 1.18
3. 补齐/优化社区软件包生态
4. 新增特性:IO_URING全栈使能/CPU核故障在线隔离/内存UCE故障降级/虚拟化可靠性和可维护性增强/虚拟化热迁移pro/stratovirt轻量化虚拟化平台/虚拟机热迁移支持TLS

## 需求范围

openEuler 20.03 LTS SP2版本交付需求列表如下：

详见：<https://gitee.com/openeuler/release-management/blob/master/openEuler-20.03-LTS-SP2/release-plan.md>

|        |                                                              |            |                            |                                                  |
| ------ | ------------------------------------------------------------ | ---------- | -------------------------- | ------------------------------------------------ |
| **no** | **feature**                                                  | **status** | **sig**                    | **owner**                                        |             |
| 1     | [【openEuler 20.03 LTS SP2】【虚拟化】回合openEuler 21.03，vmtop支持x86](https://gitee.com/openeuler/release-management/issues/I3NLWF?from=project-issue) | Discussion |                            |                                                  |
| 2      | [openEuler 20.03-LTS-SP2支持内存分级扩展特性](https://gitee.com/openeuler/release-management/issues/I2C2NI?from=project-issue) | Developing | storage                    | [liuzhiqiang26](https://gitee.com/liuzhiqiang26) |
| 3      | [openEuler 20.03-LTS-SP2版本集成secgear组件](https://gitee.com/openeuler/release-management/issues/I3JE3U?from=project-issue) | Developing | sig-confidential-computing | [chenmaodong](https://gitee.com/chenmaodong)     |
| 4      | openEuler 20.03 LTS SP2 support OpenStack Rocky              | discussion | sig-openstack              | @joec88 @liksh @xiyuanwang @huangtianhua         |
| 5      | [openEuler 20.03 LTS SP2支持osinfo软件包](https://gitee.com/openeuler/release-management/issues/I3N30H?from=project-issue) | Developing |                            |                                                  |
| 6      | [openEuler 20.03 LTS SP2开源openEuler-rpm-config宏定义文件](https://gitee.com/openeuler/release-management/issues/I3N30J?from=project-issue) | Developing | Base-service               |                                                  |
| 7      | [openEuler 20.03 LTS SP2 支持 compat-openssl10、libzip等](https://gitee.com/openeuler/release-management/issues/I3N30L?from=project-issue) | Developing |                            |                                                  |
| 8      | [openEuler 20.03 LTS SP2 支持libwbxml、hyperscan](https://gitee.com/openeuler/release-management/issues/I3N30N?from=project-issue) | Developing | Desktop                    |                                                  |
| 9      | [openEuler 20.03 LTS SP2支持microcode_ctl](https://gitee.com/openeuler/release-management/issues/I3N30S?from=project-issue) | Developing |                            |                                                  |
| 10     | [openEuler 20.03 LTS SP2支持bcc软件包](https://gitee.com/openeuler/release-management/issues/I3N30Q?from=project-issue) | Developing |                            |                                                  |
| 11     | [openEuler 20.03 LTS SP2支持树莓派](https://gitee.com/openeuler/release-management/issues/I3N30P?from=project-issue) | Developing |                            |                                                  |
| 12     | [openEuler 20.03 LTS SP2支持1822 HBA卡](https://gitee.com/openeuler/release-management/issues/I3N30V?from=project-issue) | Developing |                            |                                                  |
| 13     | [openEuler 20.03 LTS SP2支持飞腾2000+/64](https://gitee.com/openeuler/release-management/issues/I3N30W?from=project-issue) | Developing |                            |                                                  |
| 14     | [openEuler 20.03 LTS SP2支持maildrop和proftpd](https://gitee.com/openeuler/release-management/issues/I3N30X?from=project-issue) | Developing | Application                |                                                  |
| 15     | [openEuler 20.03 LTS SP2支持 iSulad 2.0](https://gitee.com/openeuler/release-management/issues/I3N312?from=project-issue) | Developing |                            |                                                  |
| 16     | [openEuler 20.03 LTS SP2 A-tune 2.0](https://gitee.com/openeuler/release-management/issues/I3N314?from=project-issue) | Developing |                            |                                                  |
| 17     | [openEuler 20.03 LTS SP2 支持网络安装](https://gitee.com/openeuler/release-management/issues/I3N315?from=project-issue) | Developing | sig-OS-Builder             |                                                  |
| 18     | [openEuler 20.03 LTS SP2 支持 criu组件](https://gitee.com/openeuler/release-management/issues/I3N319?from=project-issue) | Developing |                            |                                                  |
| 19     | [openEuler 20.03 LTS SP2支持config_acpi_nfit](https://gitee.com/openeuler/release-management/issues/I3N31B?from=project-issue) | Developing |                            |                                                  |
| 20     | [openEuler 20.03 LTS SP2 虚拟化增强](https://gitee.com/openeuler/release-management/issues/I3N31E?from=project-issue) | Developing | virt                       | [@KuhnChen](https://gitee.com/KuhnChen)          |
| 21     | [openEuler 20.03 LTS SP2 支持 UKUI桌面](https://gitee.com/openeuler/release-management/issues/I3N31F?from=project-issue) | Developing | sig_UKUI                   | [@dou33](https://gitee.com/dou33)                |
| 22     | [openEuler 20.03 LTS SP2 支持DDE桌面](https://gitee.com/openeuler/release-management/issues/I3N31J?from=project-issue) | Developing | sig-DDE                    | [@panchenbo](https://gitee.com/panchenbo)        |
| 23     | [openEuler 20.03 LTS SP2 编译器支持openjdk](https://gitee.com/openeuler/release-management/issues/I3N31M?from=project-issue) | Developing |                            |                                                  |
| 24     | [openEuler 20.03 LTS SP2支持HA](https://gitee.com/openeuler/release-management/issues/I3N31O?from=project-issue) | Developing | sig-HA                     | [@yangzhao_kl](https://gitee.com/yangzhao_kl)    |
| 25     | [openEuler 20.03 LTS SP2 加速库版本同步](https://gitee.com/openeuler/release-management/issues/I3N31Q?from=project-issue) | Developing |                            |                                                  |
| 26     | [openEuler 20.03 LTS SP2支持金融领域软件包](https://gitee.com/openeuler/release-management/issues/I3N311?from=project-issue) | Developing |                            |                                                  |
| 27     | [openEuler 20.03 LTS SP2支持kmod功能](https://gitee.com/openeuler/release-management/issues/I3N30C?from=project-issue) | Developing |                            |                                                  |
| 28     | [openEuler 20.03 LTS SP2 CPU核故障在线隔离解决方案](https://gitee.com/openeuler/release-management/issues/I3N36L?from=project-issue) | Developing |                            |                                                  |
| 29     | [openEuler 20.03 LTS SP2 支持多应用版本构建和发布](https://gitee.com/openeuler/release-management/issues/I3N36K?from=project-issue) | Developing |                            |                                                  |
| 30     | [openEuler 20.03 LTS SP2 内存UCE故障降级，用户数据保持一致，业务可持续运行](https://gitee.com/openeuler/release-management/issues/I3N36H?from=project-issue) | Developing |                            |                                                  |
| 31     | [openEuler 20.03 LTS SP2 故障预测框架](https://gitee.com/openeuler/release-management/issues/I3N36F?from=project-issue) | Developing |                            |                                                  |
| 32     | [openEuler 20.03 LTS SP2 IO_URING全栈使能](https://gitee.com/openeuler/release-management/issues/I3N36C?from=project-issue) | Developing |                            |                                                  |
| 33     | [openEuler 20.03 LTS SP2 Qemu：虚拟化可靠性和可维护性增强](https://gitee.com/openeuler/release-management/issues/I3N369?from=project-issue) | Developing | sig-virt                   | [@KuhnChen](https://gitee.com/KuhnChen)          |
| 34     | [openEuler 20.03 LTS SP2 Qemu：热迁移pro，提升热迁移性能+安全](https://gitee.com/openeuler/release-management/issues/I3N368?from=project-issue) | Developing | sig-virt                   | [@KuhnChen](https://gitee.com/KuhnChen)          |
| 35     | [openEuler 20.03 LTS SP2支持StratoVirt：下一代轻量化虚拟化平台](https://gitee.com/openeuler/release-management/issues/I3N364?from=project-issue) | Developing | sig-virt                   | [@KuhnChen](https://gitee.com/KuhnChen)          |
| 36     | [【openEuler 20.03 LTS SP2】继承xfce 4.14](https://gitee.com/openeuler/release-management/issues/I3NC3I?from=project-issue) | Discussion | xfce                       | [@dillon_chen](https://gitee.com/dillon_chen)    |
| 37     | [【openEuler 20.03 LTS SP2】继承Kubernetes 1.18](https://gitee.com/openeuler/release-management/issues/I3NC5H?from=project-issue) | Discussion | sig-cloudnative            | [@jingxiaolu](https://gitee.com/jingxiaolu)      |
| 38     | [【openEuler 20.03 LTS SP2】继承门禁检查功能](https://gitee.com/openeuler/release-management/issues/I3O08F?from=project-issue) | Discussion |                            |                                                  |
| 39     | [openEuler 20.03-LTS-SP2 集成 kubernetes 及其依赖组件](https://gitee.com/openeuler/release-management/issues/I2BHF4?from=project-issue) | Discussion |                            |                                                  |
| 40     | [openEuler 20.03-LTS-SP2 arm虚拟机支持NMI watchdog](https://gitee.com/openeuler/release-management/issues/I2B4WL?from=project-issue) | Discussion |                            |                                                  |
| 41     | [openEuler 20.03-LTS-SP2 集成 coredns 及其依赖组件](https://gitee.com/openeuler/release-management/issues/I3MXLJ?from=project-issue) | Discussion |                            |                                                  |
| 42     | [【openEuler 20.03 LTS SP2】虚拟机热迁移支持TLS](https://gitee.com/openeuler/release-management/issues/I3IE57?from=project-issue) | Discussion |                            |                                                  |
| 43     | [【kernel-4.19】openEuler kernel nvme 驱动增强](https://gitee.com/openeuler/release-management/issues/I1WGZE?from=project-issue) | Discussion |                            |                                                  |
| 44     | [openEuler 20.03-LTS-SP2 集成 etcd 及其依赖组件](https://gitee.com/openeuler/release-management/issues/I3MXGJ?from=project-issue) | Discussion |                            |                                                  |


# 风险

| 问题类型         | 问题描述                 | 问题等级 | 应对措施 | 责任人    | 状态    |
| ---------------- | ------------------------ | -------- | -------- | --------- | ------- |
| 软件包生态管理   | 升级和补齐软件包范围确定 | 高       |          | solarhu   | opening |
| 版本发布资料范围 | 版本发布资料范围待明确   | 中       |          | qiaominna | opening |

# 测试分层策略

本次SP版本的具体测试分层策略如下：

| **需求**            | **开发主体**               | **测试主体**               | **测试分层策略**                                             |
| ------------------- | -------------------------- | -------------------------- | ------------------------------------------------------------ |
| 支持树莓派发布件    | sig-RaspberryPi            | sig-RaspberryPi            | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试       |
| 支持UKUI桌面        | sig-UKUI                   | sig-UKUI                   | 验证UKUI桌面系统在openEuler版本上的可安装、基本功能和稳定性  |
| 支持DDE桌面         | sig-DDE                    | sig-DDE                    | 验证DDE在openEuler版本上的可安装、基本功能及DDE桌面的底噪    |
| 支持XFCE桌面        | sig-xfce                   | sig-xfce                   | 验证xfce在openEuler版本上的可安装、基本功能和稳定性          |
| 支持HA软件          | sig-Ha                     | sig-Ha                     | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持openStack Rocky | sig-openstack              | sig-openstack              | 验证openStack R版本发布组件的安装部署和基本功能，重点关注各个组件的可靠性和性能规格等指标 |
| 支持Kubernetes      | sig-cloudnative            | sig-cloudnative            | 验证Kubernetes软件的安装和基本功能，重点关注服务的可靠性和性能等指标 |
| 集成secgear组件     | sig-confidential-computing | sig-confidential-computing | 验证secgear组件的安装和软件的基本功能                        |
| 版本其它需求        |                            | sig-QA                     | 版本发布范围内其他需求的质量保障和操作系统的整体集成能力     |

# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*                                         | *重点*                                                                            | *设计思路*                                 | *备注* |
| ------ | ------------------------------------------------- | --------------------------------------------------------------------------------- | ------------------------------------------ | ------ |
| 1      | 软件包生态补齐                                    | 软件包的管理(安装/卸载/升级/降级) 软件包涉及命令/服务 软件包加固测试(fuzz/场景等) | 根据包优先级划分，按照对应测试策略进行覆盖 |        |
| 2      | 内存分级扩展特性                                  | 重点关注特性的基本功能和稳定性 |验证特性提供命令接口的功能完整性，进行并发压力测试和长稳测试||
| 3      | 集成secgear组件                                   |验证开发套件提供的生命周期、签名工具和代码生成工具的基本功能和可靠性，稳定性|验证开发套件基本功能，通过反复的测试验证||
| 4      | OpenStack Rocky                                   |重点验证R版本需要发布的各个模块的基本功能和稳定性|从系统集成角度验证openStack发布各个模块的基本功能和稳定性和性能规格||
| 5      | CPU核故障在线隔离解决方案                         |验证CPU核在发生故障时，隔离功能的有效性|结合多进程大并发，绑核，0核CPU操作等场景开展功能测试和稳定性测试||
| 6      | 多应用版本构建和发布                              |验证集成到构建工程中的多版本支持的能力，及构建出来包的可安装可卸载能力|通过构建工程验证多版本支持的能力功能完整性及结果的可用性||
| 7      | 内存UCE故障降级，用户数据保持一致，业务可持续运行 |验证内存UCE故障发生时，故障降级的功能，结合OpenGauss业务进行业务连续性的保证|通过触发各类内存UCE故障，覆盖故障降级的正确性，并结合openGauss业务进行故障降级发生时对业务无影响的验证||
| 8    | IO_URING全栈使能                                  |验证特性合入后性能上的提升|基于实际的应用场景，需要应用软件比如mysql/nginx等性能测试带来的性能提升效果||
| 9    | xfce                                              |验证xfce桌面系统的安装部署、基本功能和稳定性|从系统集成角度验证xfce桌面系统的基本功能，覆盖桌面系统提供的各类选项；验证系统在各类压力、异常系统下的稳定性||
| 10    | Kubernetes                                        |验证K8S组件的可安装和基本功能及可靠性|验证K8S组件在操作系统上的集成能力，重点关注基础功能及对应的可靠性和性能||
| 1   | 集成 coredns 及其依赖组件                         |配合K8S组件，重点验证集群DNS的能力|通过接口和功能测试，对coreDNS特性进行验证||

## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件                              | 策略                                                         |
| ----------------------------------------- | ------------------------------------------------------------ |
| 内核                                      | 直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内；syzkaller进行fuzz测试 |
| 容器(isula/docker/安全容器/系统容器/镜像) | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化                                    | 继承已有测试能力，重点关注回合20.09和21.03版本虚拟化新特性后，新版本上虚拟化组件(qemu/stratovirt)相关的基本功能和各类性能指标及安全fuzz测试 |
| 编译器(gcc/jdk)                           | 继承已有测试能力，本次发布在jdk原有2个版本基础上新增一个最新版本发布件，因此需要基于开源测试套对gcc和jdk相关功能进行验证 |
| 安装部署                                  | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| Kunpeng加速引擎                           | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 |
| A-Tune                                    | 继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 支持UKUI桌面                              | 继承已有测试能力，关注桌面系统的安装和基本功能，另外关注桌面在系统压力场景下的稳定性 |
| 支持DDE桌面                               | 继承已有测试能力，关注桌面系统的安装和基本功能，另外关注桌面在系统压力场景下的稳定性 |
| 树莓派                                    | 继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     |
| 支持飞腾2000+/64                          | 继承已有测试能力，通过兼容性和系统集成测试保证OS在飞腾2000+上的功能 |
| 支持1822 HBA卡驱动                        | 继承已有测试能力，覆盖三类FC卡形态在只读 只写 混合读写情况下的功能；开展异常测试和故障注入及压力等可靠性测试 |

## 专项测试策略

### 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。整体安全测试需要覆盖：

1.  linux系统安全配置/权限管理等

2.  特性涉及到的安全需求验证

3.  CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

4.  白盒安全测试

| **测试大项**   | **测试小项**              | **具体测试策略**                                             |
| :------------- | ------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | CVE扫描/敏感信息/编译选项 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项需要针对新开源特性进行； |
| 安全配置管理类 | Linux安全规范             | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试 |
| 白盒安全测试类 | Fuzz测试                  | Fuzz测试是能发现接口参数类问题和内存相关问题的有效方法，所以需要针对操作系统重点软件包开展fuzz；通过部署kasan版本的内核，进行syzkaller的测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对对编译器组件进行fuzz测试；虚拟化组件qemu的asan版本开展fuzz测试； |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的可靠性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| **测试项**   | **测试策略**                                                 |
| ------------ | ------------------------------------------------------------ |
| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| 虚拟化长稳   | 通过部署qemu的地址消毒版本，结合长时间随机交互的方式，反复、并发操作各类特性的功能；建议稳定性测试时长7\*24 |
| 特性长稳     | 特性级的可靠性，需结合特性涉及和使用的资源类型，如进程、服务、文件、CPU/内存/IO/网络等；通过模拟各类资源异常/竞争/压力故障场景，并发/反复的进行特性提供的基本功能操作 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。openEuler SP版本是LTS版本的补丁版本，所以在操作系统基本benchmark各类指标上需要和LTS版本保持一致，性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                 | **指标值**                                                   | **说明**                              |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------- |
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统(结合IO_URING)、网络子系统。 | 参考LTS SP1版本相应指标基线                                  | 与LTS SP1基线数据差异小于5%以内可接受 |
| 虚拟化性能   | 评估CPU计算能力、MEM访问能力、中断虚拟化性能、磁盘IO等虚拟化基线性能测试项<br />StratoVirt内存底噪和启动性能<br />Qemu的热迁移在TLS多通道场景下，提升30% | 参考LTS SP1版本相应指标基线<br />内存底噪<5M,启动速度<50ms<br />热迁移性能提升30% | 与LTS SP1基线数据差异小于5%以内可接受 |

### 兼容性测试

#### 软件包升级兼容性测试

openEuler社区发行版本支持LTS升级到对应的SP版，所以在软件包升级兼容性方面的策略如下：

 1、openEuler 20.03LTS发布的所有可以安装的包，通过配置SP2版本发布的repo地址，升级到本次SP2版本发布的新版本的软件包(除新补充的包外)
​ 2、openEuler 20.03LTS SP1发布的所有可以安装的包，通过配置SP2版本发布的repo地址，升级到本次SP2版本发布的新的软件包(除新补充的包外)
 3、openEuler 20.03LTS版本发布的所有可以安装的包，通过配置相应的repo地址，选取部分包升级到SP1版本，再升级到SP2版本
​ 4、openEuler 20.03LTS发布的所有可以安装的包，通过配置相应的repo地址，升级到SP1版本，再升级到SP2版本

#### 南北向生态兼容性测试

本次发布SP版本在南北向兼容性方面具体测试策略如下：

| 需求分类       | 测试范围                                                     | 测试方法                                                     |
| -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 南向兼容性测试 | 1.整机包括：taishan 200 2280/RH2288 V5/RH2488H V6/FT-2000<br />2.板卡包括:10个raid卡/20个网卡/7个FC卡/3个IB卡。<br />备注：整机和板卡的兼容性会持续进行测试<br />树莓派支持3B/3B+/4B三款硬件的部署 | 1.针对整机进行system、memory、cpufreq、watchdog、acpi等10几个方面开展测试，<br />2.针对外设设备有针对网卡 FC卡 GPU Raid卡使用已有测试套件开展相应兼容性测试 |
| 北向兼容性测试 | 包构建测试：(1 archlinux官网获取到的pkgbuild在openeuler操作系统自动构建打包测试(2 南向适配表中涉及的5000+开源软件包的构建测试 | 通过git clone获取官网上的pkgbuild文件，针对不同版本openeuler操作系统进行自动化构建打包测试 |

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**            | **覆盖策略**                                                 | **中英文测试策略** |
| ----------------------- | ------------------------------------------------------------ | ------------------ |
| DDE安装指南             | 安装步骤的准确性及DDE桌面系统是否能成功安装启动              | 英文描述的准确性   |
| UKUI安装指南            | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动             | 英文描述的准确性   |
| Xfce安装指南            | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 树莓派安装指导          | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   |
| 安装指南                | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 管理员指南              | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 安全加固指南            | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 虚拟化用户指南          | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| StratoVirt用户指南      | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 容器用户指南            | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| A-Tune用户指南          | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| 应用开发指南            | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| OpenStack-Rocky安装指南 | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |
| K8S安装指导             | 文档描述与版本的行为是否一致                                 | 英文描述的准确性   |

# 测试执行策略

openEuler 20.03 LTS SP2版本按照社区release-manger团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本的5轮测试采取3+2的测试方式，即3轮全量+2轮回归的策略。

### 测试计划

openEuler 20.03LTS SP2版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stage name          | Begin time | End time   |
| :------------------ | :--------- | :--------- |
| key feature collect | 2021-03-16 | 2021-03-31 |
| Develop             | 2021-03-16 | 2021-04-26 |
| Kernel freezing     | 2021-04-16 | 2021-04-16 |
| Build               | 2021-04-26 | 2021-04-30 |
| Test round 1        | 2021-05-6  | 2021-05-12 |
| Test round 2        | 2021-05-17 | 2021-05-21 |
| Test round 3        | 2021-05-24 | 2021-05-31 |
| Test round 4        | 2021-06-03 | 2021-06-07 |
| Test round 5        | 2021-06-09 | 2021-06-11 |
| release             | 2021-06-28 | 2021-06-30 |

### 测试重点

测试阶段1：

1.  重点关注新特性的基本功能和部分继承特性的自动化覆盖功能

2.  交付重要组件(内核、虚拟化、容器、编译器)和树莓派的功能完整性

3.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整

4.  通过软件包管理测试，对SP版本发布软件的可安装可升级性进行整体保证

5.  专项情况如下：

    安装部署

    性能：进行操作系统基础性能的摸底，保证版本的性能满足发布基线标准，不能低于LTS版本性能指标
    
    安全测试：进行安全CVE漏洞、安全编译选项、敏感信息扫描


测试阶段2：

1.  继承特性+新特性的全量验证

2.  新增软件包的专项测试

3.  系统集成的正确性和完整性

4. UKUI/DDE/xfce/K8S/OpenStack等特性

5. 专项：

   可靠性、fuzz测试

测试阶段3：

1.  所有交付特性的全量测试

2.  问题单回归

3.  新增软件包的专项专项测试

4.  专项：

    文档测试、性能、可靠性、安全（新增软件包）、兼容性(OS+树莓派)

测试阶段4：

1.  重点关注继承特性/新特性的基本功能(根据问题单+特性的功能优先级/重要性)，UKUI/DDE/Xfce/OpenStack/HA

2.  交付重要组件(内核、虚拟化、容器、编译器等)的功能完整性

3.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整

4.  通过软件包管理测试，对SP版本发布软件的可安装可升级性进行整体保证

5.  专项情况如下：

    可靠性、fuzz测试、兼容性测试、文档测试、扩展测试

测试阶段5(AOD测试)：

1.  通过自动化进行发布前的验收测试

2.  问题单全量回归

3.  软件包管理测试(SP2版本发布软件包可安装性)

4. 专项：

   交付件病毒扫描、文档测试

### 入口标准

1.  所有需求均按照社区运作方式进入版本
2.  上个阶段无block问题遗留
3.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

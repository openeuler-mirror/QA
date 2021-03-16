![openEuler ico](../../images/openEuler.png)

版权所有 © 2021 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期       | 修订版本 | CR号 | 修改  章节 | 修改描述 | 作者                                                         |
| ---------- | -------- | ---- | ---------- | -------- | ------------------------------------------------------------ |
| 2021-01-25 | 1.1.0    |      |            | 初稿     | charlie_li/kuhnchen18/lutianxiong/lemon-higgins/rigorous/speacher/dou33/panchenbo/the-moon-is-blue/zhang__3125 |
| 2021-03-03 | 1.1.1    |      | 修改交付需求范围      |          |charlie_li                                                          |


目 录

1 概述 

>   1.1 版本背景 

>   1.2 需求范围 

2 风险 

3 测试分层策略 

4 测试分析设计策略 

>   4.1 新增feature测试设计策略 

>   4.2 继承feature测试设计策略 

>   4.3 专项测试策略 

5 测试执行策略 

6 附件 

**Keywords 关键词**：

openEuler  创新版本  测试策略

Abstract 摘要：

本文是openEuler 21.03创新版本的整体测试策略，用于指导该版本测试活动开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释    |
| ------ | ------------------------------------ | ----------- |
| OS     | Operation System                     | 操作系统    |
| CVE    | Common Vulnerabilities and Exposures | CVE安全补丁 |
|        |                                      |             |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 21.03创新版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体策略覆盖新需求、继承需求的测试分析和测试执行，明确各个测试周期的策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 21.03是openEuler社区规划的创新版本，目的是合入一些新的竞争力特性，本次发布重点包括：

1.  内核版本升级到5.10
2.  新增支持openStack/xfce/GNOME/ROS
3.  竞争力特性：StratoVirt轻量级虚拟化功能增强和优化/memig/vender信息替换/内核热升级/secGear机密计算安全应用开发套件
4.  删除python2
5.  补齐/优化社区软件包生态
6.  修复bug和cve

## 需求范围

openEuler 21.03创新版本具体交付需求列表如下：

详见：<https://gitee.com/openeuler/release-management/blob/master/openEuler-21.03/release-plan.md>

| **no** | **feature**                                                  | **status** | **sig**                    | **owner**                                                    |
| ------ | ------------------------------------------------------------ | ---------- | -------------------------- | ------------------------------------------------------------ |
| 1      | [openEuler 21.03 support openStack](https://gitee.com/openeuler/release-management/issues/I25Y6B?from=project-issue) | testing | sig-openstack              | [@joec88](https://gitee.com/joec88) [@liksh](https://gitee.com/liksh) |
| 2      | [openEuler 21.03 support virtualization live migration pro](https://gitee.com/openeuler/release-management/issues/I25ZB1?from=project-issue) | testing | sig-virt                   | [@alexchen](https://gitee.com/alexchen)                      |
| 3      | [openEuler 21.03 support StratoVirt function enhancement](https://gitee.com/openeuler/release-management/issues/I25ZH0?from=project-issue) | testing | sig-virt                   | [@alexchen](https://gitee.com/alexchen)                      |
| 4      | [openEuler 21.03 support Risc-v virt live migration](https://gitee.com/openeuler/release-management/issues/I25ZF1?from=project-issue) | testing | sig-virt                   | [@alexchen](https://gitee.com/alexchen)                      |
| 5      | [openEuler 21.03 support DDE](https://gitee.com/openeuler/release-management/issues/I27TT4?from=project-issue) | developing | sig-DDE                    | [@panchenbo](https://gitee.com/panchenbo)                    |
| 6      | [openEuler 21.03 kernel update to version 5.10](https://gitee.com/openeuler/release-management/issues/I27YGU?from=project-issue) | testing | sig-kernel                 | [@XieXiuQi](https://gitee.com/xiexiuqi)                      |
| 7      | [openEuler 21.03 remove python 2 from release](https://gitee.com/openeuler/release-management/issues/I29EV9?from=project-issue) | testing | sig-python-modules         | [@yaqiangchen](https://gitee.com/yaqiangchen)                |
| 8      | [openEuler 21.03 support xfce 4.14](https://gitee.com/openeuler/release-management/issues/I29LTB?from=project-issue) | developing | xfce                       | [@dillon_chen](https://gitee.com/dillon_chen)                |
| 9      | [openEuler 21.03 support GNOME 3.38.1](https://gitee.com/openeuler/release-management/issues/I29LTT?from=project-issue) | reject | GNOME                      | [@dillon_chen](https://gitee.com/dillon_chen)                |
| 10     | [openEuler 21.03 Increase the dependency library of ROS-base](https://gitee.com/openeuler/release-management/issues/I2D19V?from=project-issue) | reject | sig-ROS                    | [@anchuanxu](https://gitee.com/anchuanxu)                    |
| 11     | [openEuler 21.03 support memig](https://gitee.com/openeuler/release-management/issues/I2C2NY?from=project-issue) | testing | memig                      | [@liuzhiqiang26](https://gitee.com/liuzhiqiang26)            |
| 12     | [openEuler 21.03 support replace vender info](https://gitee.com/openeuler/release-management/issues/I2C2JJ?from=project-issue) | testing | Builder                    | [@t.feng](https://gitee.com/t.feng)                          |
| 13     | [openEuler 21.03 support nvwa](https://gitee.com/openeuler/release-management/issues/I2B057?from=project-issue) | testing | sig-ops                    | [@EulerOSWander](https://gitee.com/EulerOSWander)            |
| 14     | [openEuler 21.03 support secGear](https://gitee.com/openeuler/release-management/issues/I2B0KY?from=project-issue) | testing | sig-confidential-computing | [@chenmaodong](https://gitee.com/chenmaodong)                |
| 15     | [openEuler 21.03 support RaspberryPi](https://gitee.com/openeuler/release-management/issues/I2CVE3) | developing | sig-RaspberryPi            | [@woqidaideshi](https://gitee.com/woqidaideshi)              |
| 16     | [openEuler 21.03 support UKUI](https://gitee.com/openeuler/release-management/issues/I2E61C) | developing | sig-UKUI                   | [@dou33](https://gitee.com/dou33)                            |
| 17     | [openEuler 21.03 support HA](https://gitee.com/openeuler/release-management/issues/I2E5R3?from=project-issue) | developing | sig-HA                     | [@yangzhao_kl](https://gitee.com/yangzhao_kl)                |
| 18     | [openEuler 21.03 support StratoVirt microvm image](https://gitee.com/openeuler/release-management/issues/I2P83D?from=project-issue) | testing | sig-virt                   | [@alexchen](https://gitee.com/zhendongchen)                  |
| 19     | [openEuler 21.03 support Kubernetes](https://gitee.com/openeuler/release-management/issues/I2CMA0?from=project-issue) | testing | sig-cloudnative            | [@jingxiaolu](https://gitee.com/jingxiaolu)                  |
| 20     | [openEuler 21.03 support KubeSphere](https://gitee.com/openeuler/release-management/issues/I34L4L) | reject | sig-kubesphere             | [@feynmanzhou](https://gitee.com/feynmanzhou)                |
| 21     | [openEuler 21.03 update SPDK](https://gitee.com/openeuler/release-management/issues/I35A62) | testing | Storage                    | [@liuzhiqiang](https://gitee.com/liuzhiqiang26)              |
| 22     | [openEuler 21.03 update some software](https://gitee.com/openeuler/release-management/issues/I35BTA) | testing | release-management         | [@chenyaqiang](https://gitee.com/yaqiangchen)                |
| 23     | [openEuler 21.03 slim container base image](https://gitee.com/openeuler/release-management/issues/I35D25) | testing | sig-cloudnative            | [@jingxiaolu](https://gitee.com/jingxiaolu)                  |

# 风险

| 问题类型       | 问题描述                         | 问题等级 | 应对措施 | 责任人  | 状态    |
| -------------- | -------------------------------- | -------- | -------- | ------- | ------- |
| 软件包生态管理 | 版本发布的软件包范围待明确 | 高       |          | solarhu | Opening |

# 测试分层策略

本次创新版本的具体测试分层策略如下：

| **需求**                                   | **开发主体**               | **测试主体**    | **测试分层策略**                                             |
| :----------------------------------------- | -------------------------- | --------------- | ------------------------------------------------------------ |
| 支持树莓派发布件                           | sig-RaspberryPi            | sig-RaspberryPi | 树莓派sig组对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试 |
| 支持UKUI桌面                               | sig-UKUI                   | sig-UKUI        | UKUIsig组验证UKUI桌面系统在openEuler上的可安装、基本功能和稳定性 |
| 支持HA软件                                 | sig-HA                     | sig-HA          | HAsig组验证HA软件的安装和基本功能，重点关注软件服务的可靠性和性能等指标 |
| 支持DDE桌面                                | sig-DDE                    | sig-DDE         | DDEsig组验证DDE在openEuler版本上的功能及其他性能指标         |
| 支持openStack                              | sig-openstack              | sig-openstack   | openstacksig组重点验证nova\neutron\cinder\glance\keystone\ironic等模块的安装部署、基本功能及各类性能规格指标 |
| 支持xfce 4.14桌面                          | sig-xfce                   | sig-xfce        | xfcesig组验证xfce桌面系统的安装部署、基本功能和稳定性        |
| 支持热迁移/StratoVirt增强/Risc-v架构热迁移 | sig-virt                   | sig-QA          | QAsig组对虚拟化组件发布范围的基本功能和稳定性及性能指标      |
| 内核升级到5.10                             | sig-kernel                 | sig-QA          | QAsig组验证5.10内核版本的基本功能、稳定性、性能等指标        |
| 移除python2                                | sig-python-modules         | sig-QA          | QAsig组验证python2是否移除干净及其他对python2有依赖包的安装和功能 |
| 支持memig                                  | sig-Storage                | sig-QA          | QAsig组验证memig特性的功能                                   |
| 支持全量vender信息替换                     | sig-builder                | sig-QA          | QAsig组验证替换工具的功能完整性                              |
| 支持nvwa                                   | sig-ops                    | sig-QA          | QAsig组验证内核热替换的功能和性能指标                        |
| 支持secGear                                | sig-confidential-computing | sig-QA          | QAsig组验证开发套件的基本功能                                |
| 版本发布件中增加StratoVirt的microvm_image  | sig-virt                   | sig-QA          | QAsig组针对此发布件进行镜像的检查和镜像的使用验证，保证镜像启动虚机的基本功能可用性 |
| 集成 kubernetes及最简部署的依赖组件        | sig-CloudNative            | sig-QA          | QAsig组验证K8S组件在openEuler版本上的可安装、可使用等基本功能 |
| 容器基础镜像大小优化                       | sig-CloudNative            | sig-QA          | QAsig组验证发布容器基础镜像规格是否符合，容器镜像启动容器后的基本功能 |
| 版本其它继承需求及整体继承验证             |                            | sig-QA          | QAsig组发布范围需求的质量保障和系统整体集成能力              |

# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*                                 | *重点*                                                       | *设计思路*                                                   | *备注* |
| ------ | ----------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------ |
| 1      | 软件包生态补齐                            | 软件包的管理(安装/卸载/升级/降级) 软件包涉及命令/服务 软件包加固测试(fuzz/场景等) | 根据包优先级划分，按照对应测试策略进行覆盖                   |        |
| 2      | 支持openStack                             | 重点验证nova\neutron\cinder\glance\keystone\ironic等模块的基本功能 | 从系统集成角度验证openStack发布各个模块的功能和稳定性        |        |
| 3      | 虚拟化热迁移                              | 验证虚拟化热迁移的基本功能、安全使能、性能                   | 功能上保证热迁移的基本能力；安全上验证tls multifd使能后的能力；验证迁移性能指标满足迁移市场缩短20%目标 |        |
| 4      | StratoVirt增强                            | StratoVirt组件基本功能和性能                                 | 对StratoVirt组件进行功能增强后的基本功能验证，保证功能完整性；对性能进行测试满足性能指标 |        |
| 6      | 内核升级到5.10                            | 继承已有测试能力，重点关注内核功能的完整性；并对5.10新版本内核进行基础性能摸底 | 采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证 |        |
| 7      | 移除python2                               | 验证python2相关软件包移除的正确性及带来的                    | 通过软件包的全量安装验证python2移除后是否有影响；根按照软件包测试策略，验证软件包的命令、服务。 |        |
| 8      | 支持xfce桌面                              | 验证xfce桌面系统的安装部署、基本功能和稳定性                 | 从系统集成角度验证xfce桌面系统的基本功能，覆盖桌面系统提供的各类选项；验证系统在各类压力、异常系统下的稳定性 |        |
| 10     | 支持memig                                 | 重点关注特性的基本功能和稳定性                               | 验证特性提供命令接口的功能完整性，进行并发压力测试和长稳测试 |        |
| 11     | 支持全量vender替换                        | 验证发布镜像全量安装后，涉及vender信息可用成功替换           |                                                              |        |
| 12     | 支持nvwa                                  | 验证内核热替换功能、稳定性和热替换对业务中断影响的性能指标   | 通过连续反复替换验证功能的稳定性；通过实际业务部署检查对业务带来的中断影响满足指标要求 |        |
| 13     | 支持secGear                               | 验证开发套件提供的生命周期、签名工具和代码生成工具的基本功能和可靠性，稳定性 | 验证开发套件基本功能，通过反复的测试验证                     |        |
| 14     | 集成 kubernetes及最简部署的依赖组件       | 验证K8S组件的可安装和基本功能                                | 验证K8S组件在操作系统上的集成能力                            |        |
| 16     | 容器基础镜像大小优化                      | 验证容器镜像的大小规格和功能完整性                           | 验证容器镜像的大小规格和以此镜像启动容器的基本可用性         |        |
| 17     | 版本发布件中增加StratoVirt的microvm_image | 通过arm和X86双架构的镜像验证镜像的完整性和可用性             | 验证发布的虚拟机镜像规格和以镜像启动虚机的能力               |        |

## 继承feature测试设计策略

从openEuler已发布版本继承的功能特性的测试策略如下：

| Feature/组件                              | 策略                                                         |
| ----------------------------------------- | ------------------------------------------------------------ |
| 容器(isula/docker/安全容器/系统容器/镜像) | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化                                    | 继承已有测试能力，重点关注回合09版本虚拟化新特性后，新版本上虚拟化相关组件的基本功能 |
| 编译器(gcc/jdk)                           | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   |
| 安装部署                                  | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| A-Tune                                    | 继承已有测试能力，重点关注A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| lm-sensor                                 | 继承已有测试能力，关注sensors/sensord服务的状态，验证sensors是否能正常查询CPU core额温度并于BMC结果进行对比 |
| UKUI                                      | 继承20.09版本已有测试能力，关注桌面系统的安装和基本功能      |
| 树莓派                                    | 继承20.09版本已有测试能力，关注树莓派系统的安装、基本功能及兼容性 |
| DDE桌面                                   | 继承20.03 LTS SP1版本已有测试能力，关注桌面系统的安装和基础功能及稳定性 |
| HA                                        | 继承20.03 LTS SP1版本已有测试能力，关注HA软件的功能和可靠性  |
| Vmtop                                     | 继承20.09版本已有测试能力，关注工具的功能完整性              |
| ARM支持虚拟CPU/内存热插                   | 继承20.09版本已有测试能力，关注热插功能和稳定性              |
| 支持PMU nmi watchdog                      | 继承20.09版本已有测试能力，关注基本功能完整性                |
| KVM支持custom                             | 继承20.09版本已有测试能力，关注基本功能完整性                |
| 支持双层调用                              | 继承20.09版本已有测试能力，关注基本功能完整性                |
| 支持HPRE直通                              | 继承20.09版本已有测试能力，关注基本功能完整性                |
| 支持Smartpolling                          | 继承20.09版本已有测试能力，关注基本功能完整性                |
| 支持虚拟机安全启动                        | 继承20.09版本已有测试能力，关注基本功能完整性                |
| 支持虚拟机可信启动                        | 继承20.09版本已有测试能力，关注基本功能完整性                |
| 支持可信计算IMA                           | 继承20.09版本已有测试能力，关注基本功能完整性                |
| 支持isula-build                           | 继承20.09版本已有测试能力，关注基本功能完整性                |
| 软件包管理工具                            | 继承20.09版本已有测试能力，关注基本功能完整性                |

## 专项测试策略

### 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。整体安全测试需要覆盖：

1.  linux系统安全配置/权限管理等

2.  特性涉及到的安全需求验证

3.  CVE漏洞/敏感信息/安全编译选项/端口矩阵/交付件病毒扫描

4.  白盒安全测试

| 安全扫描类     | CVE扫描/敏感信息/编译选项 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项需要针对新开源特性进行； |
| :------------- | ------------------------- | ------------------------------------------------------------ |
| 安全配置管理类 | Linux安全规范             | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试 |
| 白盒安全测试类 | Fuzz测试                  | Fuzz测试是能发现接口参数类问题和内存相关问题的有效方法，所以需要针对操作系统重点软件包开展fuzz；通过部署kasan版本的内核，进行syzkaller的测试；对重点软件包开展oss-fuzz测试；虚拟化组件qemu的asan版本开展fuzz测试； |

### 可靠性测试

可靠性是版本测试中需重点考虑的测试活动，具体是指在各类资源异常/抢占竞争/压力/故障等背景下，通过功能的并发、反复操作进行长时间的测试；过程中通过监控系统资源、进程运行等状态，及时发现系统/特性隐藏的问题。

可靠性的测试建议从关键特性、重要组件、新增特性的可靠性指标和系统级的稳定性进行分析和设计，已保证特性和系统在各类异常、故障及压力背景下的持续提供服务的能力。

| 操作系统长稳 | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7\*24 |
| ------------ | ------------------------------------------------------------ |
| 虚拟化长稳   | 通过部署qemu的地址消毒版本，通过长时间随机交互的方式，反复、并发操作各类特性的功能；建议稳定性测试时长7\*24 |
| 特性长稳     | 特性级的可靠性，需结合特性涉及和使用的资源类型，如进程、服务、文件、CPU/内存/IO/网络等；通过模拟各类资源异常/竞争/压力故障场景，并发/反复的进行特性提供的基本功能操作 |

### 性能测试

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。openEuler 21.03版本因为内核版本升级到5.10版本，所以需要对操作系统基本benchmark各类指标基线进行重新摸底和评估；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项**     | **指标小项**                                                 | **指标值**              | **说明** |
| ---------------- | ------------------------------------------------------------ | ----------------------- | -------- |
| OS基础性能       | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、文件子系统、网络子系统。 | 对5.10内核版本进行性能摸底 |          |
| 虚拟化热迁移性能 | KVM+QEMU热迁移时长缩短20%                                    | 缩短20%                 |          |

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述的清晰性和正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

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
| XFCE安装指南       | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| HA安装指南         | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| HA的使用实例       | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| K8S安装指导        | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| OpenStack安装指导  | 文档描述与版本的行为是否一致                                           | 英文描述的准确性   |
| OpenStack-victoria安装指导   |文档描述与版本的行为是否一致                                           | 英文描述的准确性   |


# 测试执行策略

openEuler 21.03创新版本按照社区release-manger团队既定的版本计划，共有4轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本的4轮测试采取3+1的测试方式，即3轮全量+1轮回归的策略。

### 测试计划

openEuler 21.03创新版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

| Stange name          | Begin time | End time   |
| :------------------- | :--------- | :--------- |
| Kernel update 5.10   | 2020-10-20 | 2020-10-30 |
| Key feature collect  | 2020-10-10 | 2020-12-15 |
| Kernel freezing      | 2020-12-21 | 2020-12-30 |
| Key feature freezing | 2021-1-22  | 2021-1-22  |
| Build branch         | 2021-2-1   | 2022-2-22  |
| Test round 1         | 2021-2-24  | 2021-3-2   |
| Test round 2         | 2021-3-5   | 2021-3-11  |
| Test round 3         | 2021-3-15  | 2021-3-19  |
| Test round 4         | 2021-3-20  | 2021-3-20  |
| Release              | 2021-3-25  | 2021-3-26  |

### 测试重点

测试阶段1：

1.  重点关注继承特性/新特性的基本功能

2.  重要交付组件(内核、虚拟化、容器、编译器等)的功能完整性测试

3.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整

4.  通过软件包管理测试，对版本发布的软件包进行可安装性和可编译保证

5.  专项情况如下：

    安装部署测试：覆盖各类交付件的安装方式

    性能：对操作系统的基础性能进行摸底测试

    压力稳定性测试：保证系统的长时间稳定运行，建议测试时长7\*24

    安全测试：进行安全CVE漏洞，fuzz测试
    

测试阶段2：

1.  继承特性/新特性的全量验证

2.  重要组件全量测试

3.  操作系统集成测试

4.  软件包管理测试

5.  专项：

    可靠性、fuzz测试、文档测试、端口矩阵扫描、安全编译选项扫描、敏感信息扫描

    兼容性测试：树莓派版本基于3B、3B+、4B硬件兼容性测试

6.  问题单回归


测试阶段3：

1.  继承特性/新特性的全量验证

2.  重要组件的全量测试

3.  操作系统集成测试

4.  软件包管理测试

5.  专项：

    安全漏洞扫描、可靠性、文档测试

6.  问题单回归


测试阶段4：

1、通过自动化进行版本交付特性/组件的功能保证

2、问题单全量回归验证

3、系统集成中自动化测试

4、专项：

   交付件病毒扫描、文档测试

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕
2.  发布范围内的特性/需求100%交付
3.  需求涉及性能基线满足规划目标
4.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

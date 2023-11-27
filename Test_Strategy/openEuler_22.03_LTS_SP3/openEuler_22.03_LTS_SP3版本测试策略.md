![openEuler ico](../../images/openEuler.png)

版权所有 © 2023 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期       | 修订版本 | 修改  章节       | 修改描述               | 作者       |
| ---------- | -------- | ---------------- | ---------------------- | ---------- |
| 2023-10-24  | 1.0.0    |                  | 初稿                   | 范佳臣@disnight |
| 2023-11-21  | 1.0.1    |                  | 修改版　　　       　　　 | 刘婧婧@ga_beng_cui |


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

本文是openEuler 22.03 LTS SP3版本的整体测试策略，用于指导该版本后续测试活动的开展

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.03 LTS SP3版本的总体测试策略，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。整体测试策略覆盖新需求、继承需求的测试分析和执行，明确各个测试周期的测试策略及出入口标准，指导后续测试活动。

## 版本背景

openEuler 22.03 LTS SP3 是基于5.10内核22.03-LTS的增强扩展版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 22.03 LTS-Next分支拉出，发布范围相较22.03 LTS版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明]()
2.  支持Lustre server软件包
3.  eNFS特性合入
4.  DDE组件更新支持服务器场景优化
5.  FangTian视窗引擎特性合入
6.  masstree特性合入
7.  sysMaster支持虚机场景
8.  支持树莓派
9.  增加migration-tools项目发布
10. 增加utshell项目发布
11. 增加utsudo项目发布
12. 增加i3相关软件包发布
13. 支持入侵检测框架secDetector

## 需求范围

openEuler 22.03 LTS SP3版本交付[需求列表](hhttps://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP3/release-plan.md)如下：

| no   | feature                                                      | status  | sig                          | owner                                                   | 发布方式 | 涉及软件包列表                                               |
| :--- | :----------------------------------------------------------- | :------ | :--------------------------- | :------------------------------------------------------ | :------- | :----------------------------------------------------------- |
| 1    |[支持Lustre server软件包](https://gitee.com/openeuler/release-management/issues/I80F3Y) | Discussion | sig-SDS | [@xin3liang](https://gitee.com/xin3liang) | EPOL | lustre, lustre-release, e2fsprogs |
| 2    | [eNFS特性合入](https://gitee.com/openeuler/release-management/issues/I83JRC) | Discussion | sig-kernel | [@mingqian218472](https://gitee.com/mingqian218472) | ISO | nfs,sunrpc |
| 3    | [DDE组件更新支持服务器场景优化](https://gitee.com/openeuler/release-management/issues/I82A5V) | Discussion | sig-DDE | [@leeffo](https://gitee.com/leeffo) | EPOL | |
| 4    | [FangTian视窗引擎特性合入](https://gitee.com/openeuler/release-management/issues/I84H9S) | Discussion | sig-FangTian | [@BruceXuXu](https://gitee.com/BruceXuXu) | EPOL | |
| 5    | [masstree特性合入](https://gitee.com/openeuler/release-management/issues/I876AA) | Discussion | sig-DB | [@zhengshaoyu](https://gitee.com/zhengshaoyu) | ISO | masstree |
| 6    | [sysMaster支持虚机场景](https://gitee.com/openeuler/release-management/issues/I8AU51) | Discussion | dev-utils | [@openeuler-basic](https://gitee.com/openeuler-basic) | ISO | sysmaster |
| 7    | [支持树莓派](https://gitee.com/openeuler/release-management/issues/I8BKM5) | Discussion | sig-RaspberryPi | [@woqidaideshi](https://gitee.com/woqidaideshi) | EPOL | raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom |
| 8    |[增加 migration-tools 项目发布](https://gitee.com/openeuler/release-management/issues/I8CWV4)|Discussion|sig-migration-tools|[@xingwei-liu](https://gitee.com/xingwei-liu/)|EPOL|migration-tools|
| 9    |[增加 utshell 项目发布](https://gitee.com/openeuler/release-management/issues/I8299Y)|Discussion|sig-memsafety|[@tong2357](https://gitee.com/tong2357/)|EPOL|utshell|
| 10    |[增加 utsudo 项目发布](https://gitee.com/openeuler/release-management/issues/I8DZVE)|Discussion|sig-memsafety|[@ut-wanglujun](https://gitee.com/ut-wanglujun/)|EPOL|utsudo|
| 11    |[增加i3相关软件包发布](https://gitee.com/openeuler/release-management/issues/I8ERGA) |Discussion|sig-infrastructure|[@mywaaagh_admin](https://gitee.com/mywaaagh_admin/)|EPOL|i3,i3status,perl-AnyEvent-I3,perl-AnyEvent,xcb-util-xrm,xcompmgr,perl-IO-Pipely,dmenu|
| 12    |[支持入侵检测框架](https://gitee.com/openeuler/release-management/issues/I8GQJE)|Discussion|sig-security-facility|[@zcfsite](https://gitee.com/zcfsite/)|ISO|secDetector|


# 风险

| 问题类型 | 问题描述 | 问题等级 | 应对措施 | 责任人 | 状态 |
| -------- | -------- | -------- | -------- | ------ | ---- |
|          |          |          |          |        |      |

# 测试分层策略(*基于继承特性策略刷新*)

本次LTS SP3版本的具体测试分层策略如下：

| **需求**         | **开发主体** | **测试主体** | **测试分层策略**         |
| --------------- | ----------- | ---------- | ----------------------- |
| 支持UKUI桌面     | sig-UKUI  | sig-UKUI  | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能 |
| 支持DDE桌面      | sig-DDE   | sig-DDE   | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持xfce桌面     | xfce  | xfce  | 验证xfce桌面系统在openEuler版本上的可安装和基本功能 |
| 支持GNOME桌面    | GNOME | GNOME | 验证gnome桌面系统在openEuler版本上的可安装和基本功能|
| 支持Kiran桌面    | sig-KIRAN-DESKTOP | sig-KIRAN-DESKTOP | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能 |
| 支持Cinnamon桌面 | sig-cinnamon | sig-cinnamon | 验证Cinnamon桌面系统在openEuler版本上的可安装和基本功能 |
| 支持南向兼容性    | sig-Compatibility-Infra | sig-QA | 验证openEuler版本在不同处理器上的可安装和可使用性，覆盖整机兼容性测试和社区集成测试 |
| 支持北向兼容性    | sig-Compatibility-Infra | sig-QA |  |
| 支持树莓派发布件  | sig-RaspberryPi | sig-RaspberryPi | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试 |
| 支持RISC-V      | sig-RISC-V | sig-RISC-V | 验证openEuler版本在RISV-V处理器上的可安装和可使用性 |
| 内核            | Kernel | Kernel | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | sig-CloudNative | sig-CloudNative | 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化           | Virt | Virt | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 编译器(gcc/jdk)  | Compiler | sig-QA | 基于开源测试套对gcc和jdk相关功能进行验证 |
| 支持HA软件       | sig-Ha | sig-Ha | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持KubeSphere  | sig-K8sDistro | sig-K8sDistro | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力  |
| 支持OpenStack Train 和 Wallaby | sig-OpenStack | sig-OpenStack | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能 |
| 支持A-Tune      | A-Tune | A-Tune | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 支持secPave     | sig-security-facility | sig-QA | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
| 支持secGear     | sig-confidential-computing | sig-QA | 关注secGear特性的功能完整性 |
| 发布eggo        | sig-CloudNative | sig-CloudNative | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
| 支持kubeOS      | sig-CloudNative | sig-CloudNative | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
| 支持NestOS      | sig-CloudNative | sig-CloudNative | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 支持OpenResty   | sig-OpenResty   | sig-OpenResty   | 验证openResty平台在openEuler版本上的可安装性和基本功能 |
| 支持etmem内存分级扩展 | Storage | sig-QA | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
| 支持定制裁剪工具(inageTailor和oemaker) | sig-OS-Builder | sig-QA | 验证可定制化的能力，包括裁剪工具的基本命令功能，并对异常参数进行覆盖；另外对裁剪出来的镜像进行安装部署及基本验证，保障裁剪工具的E2E能力完整性 |
| 支持openGauss   | DB | DB | 验证openGauss数据库基础功能中接入层、SQL层、存储层、管理和安全等，另外从可靠性、性能、工具和兼容性四个维度覆盖生态测试 |
| 支持虚拟化热补丁libcareplus | Virt | Virt | 关注libcareplus提供Qemu热补丁能力 |
| 支持用户态协议栈gazelle     | sig-high-performance-network | sig-high-performance-network |关注gazelle高性能用户态协议栈功能  |
| 支持容器场景在离线混合部署rubik | sig-CloudNative | sig-CloudNative | 结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 支持智能运维A-ops | sig-ops | sig-QA | 关注智能定位（异常检测、故障诊断）功能、可靠性 |
| 支持libstorage针对NVME的IO栈hsak | Storage | Storage | 验证libstorage针对NVMe SSD存储介质提供高带宽低时延的IO软件栈，提升IO的读写性能；同时提供nvme磁盘状态管理以及查询功能，监测nvme磁盘的健康状态 |
| 支持国密算法      | sig-security-facility | sig-security-facility | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
| 支持k3s          | sig-K8sDistro | sig-K8sDistro | 验证k3s软件的部署测试过程 |
| 支持IO智能多流astream | Kernel | sig-QA | 验证通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命 |
| 支持pkgship      | sig-EasyLife | sig-QA | 验证软件包依赖查询、生命周期管理、补丁查询等功能 |
| 支持鲲鹏安全库     | sig-security-facility | sig-QA | 验证对鲲鹏安全库下的支持平台远程证明及TEE远程证明特性进行接口、功能测试 |
| 支持mindspore     | ai | ai |  |
| 支持pod带宽管理oncn-bwm | sig-high-performance-network | sig-high-performance-network | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试  |
| 支持基于分布式软总线扩展生态互联互通 | sig-embedded | sig-embedded | 验证openEuler和openHarmony设备进行设备认证，互通互联特性 |
| 支持混合关键部署技术扩展 | sig-embedded | sig-embedded | 验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 支持硬实时系统    | sig-embedded | sig-embedded | 验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 |
| 支持kubernetes  | sig-CloudNative | sig-CloudNative | 验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 安装部署         | sig-OS-Builder | sig-OS-Builder | 验证覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| Kunpeng加速引擎 | sig-AccLib | sig-AccLib | 验证对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加速器KAE的基本功能和性能测试 |
| 支持Lustre server软件包 | sig-SDS | sig-SDS | |
| eNFS特性合入 | sig-kernel | sig-kernel ||
| FangTian视窗引擎特性合入 | sig-FangTian | sig-FangTian| |
| masstree特性合入 | sig-DB | sig-DB ||
| sysMaster支持虚机场景 | dev-utils | dev-utils ||
| 增加 migration-tools 项目发布|sig-migration-tools|sig-migration-tools||
| 增加 utshell 项目发布|sig-memsafety|sig-memsafety||
| 增加 utsudo 项目发布|sig-memsafety|sig-memsafety||
| 增加i3相关软件包发布 |sig-infrastructure|sig-infrastructure||
| 支持入侵检测框架secDetector |sig-security-facility|sig-security-facility||


# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*             | *测试设计策略* | *测试重点* |
| ----- | ---------------------- | --------------- | ------ |
| [I80F3Y](https://gitee.com/openeuler/release-management/issues/I80F3Y) | 支持Lustre server软件包 |  |
| [I83JRC](https://gitee.com/openeuler/release-management/issues/I83JRC) | eNFS特性合入 | |
| [I82A5V](https://gitee.com/openeuler/release-management/issues/I82A5V) | DDE组件更新支持服务器场景优化 | |
| [I84H9S](https://gitee.com/openeuler/release-management/issues/I84H9S) | FangTian视窗引擎特性合入 | |
| [I876AA](https://gitee.com/openeuler/release-management/issues/I876AA) | masstree特性合入 | |
| [I8AU51](https://gitee.com/openeuler/release-management/issues/I8AU51) | sysMaster支持虚机场景||
| [I8BKM5](https://gitee.com/openeuler/release-management/issues/I8BKM5) | 支持树莓派 | |
|[I8CWV4](https://gitee.com/openeuler/release-management/issues/I8CWV4)|增加 migration-tools 项目发布||
|[I8299Y](https://gitee.com/openeuler/release-management/issues/I8299Y)|增加 utshell 项目发布||
|[I8DZVE](https://gitee.com/openeuler/release-management/issues/I8DZVE)|增加 utsudo 项目发布||
|[I8ERGA](https://gitee.com/openeuler/release-management/issues/I8ERGA)|增加i3相关软件包发布 ||
|[I8GQJE](https://gitee.com/openeuler/release-management/issues/I8GQJE)|支持入侵检测框架secDetector ||


## 继承feature/组件测试设计策略

从老版本继承的功能特性的测试策略如下：

| Feature/组件 |  策略                           |
| ----------- | ------------------------------- |
| 内核         | 直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化           | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 编译器(gcc/jdk)  | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   |
| 支持DDE桌面      | 继承已有测试能力，关注DDE桌面系统的安装和基本功能           |
| 支持UKUI桌面     | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           |
| 支持xfce桌面     | 继承已有测试能力，重点关注xfce桌面的可安装性和提供组件的能力 |
| 支持gnome桌面    | 继承已有测试能力，关注gnome桌面系统的安装和基本功能           |
| 支持Kiran桌面    | 增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 |
| 支持Cinnamon桌面 | 继承已有测试能力，关注Cinnamon桌面系统的安装和基本功能       |
| 支持南向兼容性    | 继承已有测试能力，关注板卡和整机适配的兼容性测试 |
| 支持北向兼容性    | 继承已有测试能力 |
| 支持树莓派       | 继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     |
| 支持RISC-V      | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性 |
| 支持HA软件      | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 |
| 支持KubeSphere  | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 支持openstack Train 和 Wallaby  | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能 |
| 支持A-Tune      | 继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 支持secPave     | 继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    |
| 支持secGear     | 继承已有测试能力，关注secGear特性的功能完整性          |
| 支持eggo        | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 |
| 支持kubeOS      | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 |
| 支持NestOS      | 继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 支持OpenResty   | 继承已有测试能力，关注openResty平台在openEuler版本上的可安装性和基本功能   |
| 支持etmem内存分级扩展 | 继承已有测试能力，重点验证特性的基本功能和稳定性   |
| 支持定制裁剪工具套件(oemaker/imageTailor) | 继承已有测试能力，验证可定制化的能力   |
| 支持openGauss   | 继承已有测试能力，关注openGauss数据库的功能、性能和可靠性   |
| 支持虚拟化热补丁libcareplus | 继承已有测试能力，重点关注libcareplus提供Qemu热补丁能力  |
| 支持用户态协议栈gazelle     | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能  |
| 支持容器场景在离线混合部署rubik | 继承已有测试能力，结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 支持智能运维A-ops | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性 |
| 支持libstorage针对NVME的IO栈hsak | 继承已有测试能力，验证libstorage针对NVMe SSD存储介质提供高带宽低时延的IO软件栈，提升IO的读写性能；同时提供nvme磁盘状态管理以及查询功能，监测nvme磁盘的健康状态 | 
| 支持国密算法      | 继承已有测试能力，验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 | 
| 支持k3s          | 继承已有测试能力，验证k3s软件的部署测试过程 | 
| 支持IO智能多流astream | 继承已有测试能力，验证通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命 | 
| 支持pkgship      | 继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能 | 
| 支持鲲鹏加速库     | 继承已有测试能力，验证对鲲鹏安全库下的支持平台远程证明及TEE远程证明特性进行接口、功能测试 | 
| 支持mindspore     | 继承已有测试能力 | 
| 支持pod带宽管理oncn-bwm | 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 | 
| 支持基于分布式软总线扩展生态互联互通 | 继承已有测试能力，验证openEuler和openHarmony设备进行设备认证，互通互联特性 | 
| 支持混合关键部署技术扩展  | 继承已有测试能力，验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS | 
| 支持硬实时系统    | 继承已有测试能力，验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 | 
| 支持kubernetes  | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 安装部署         | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| Kunpeng加速引擎 | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 |



## 专项测试策略

### 安全测试

[openEuler 22.03 LTS SP3安全测试策略]()

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

性能测试是针对交付件的具体性能指标，利用工具进行各类性能指标的测试。性能数据波动需小于5%；特性类的性能，需要按照各个特性既定的指标，进行时间效率、资源消耗底噪等方面的测试验证，保证指标项与既定目标的一致。

| **指标大项** | **指标小项**                                                                               | **指标值**              | **说明**                          |
|--------------|--------------------------------------------------------------------------------------------|-------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 与基线数据差异小于5%以内可接受 |

### 兼容性测试

#### 南向兼容性

南向兼容性测试分板卡测试和整机适配测试两个部分。

此版本的板卡兼容性适配测试，适配的板卡类型有RAID/FC/GPU/SSD/IB/NIC/六种，在aarch64/x86_64架构上进行适配，主要使用社区硬件兼容性测试工具oec-hardware集成compass-ci进行自动化测试，适配完成后将在社区发布此版本的板卡兼容性清单。

板卡兼容性交付清单如下：
| **板卡类型** | **覆盖范围** | **测试主体** | **chipVendor** |**boardModel** | **chipModel** | **测试计划** |
|--|--|--|--|--|--|--|
| RAID | 适配7张 | sig-Compatibility | | | | |
| | | | Avago |	9560-8i | SAS3908 | 2023.11. |
| | | | Avago |	SP460C-M | SAS3516 | 2023.11. |
| | | | Avago |	SR150-M	 | SAS3408 | 2023.11. |
| | | | Avago |	SP150IT-M |	SAS3408 | 2023.11. |
| | | | Avago |	SR430C-M |	SAS-3 3108 | 2023.11. |
| | | | Avago |	SR130 |	SAS3008 | 2023.11. |
| | | | Avago |	SR130-M | SAS3008 | 2023.11. |
| FC | 适配4张 | sig-Compatibility | | | | |
| | | | Marvell/Qlogic | QLE2560 | ISP2532 | 2023.11. |
| | | | Emulex | LPe31002-M6 | LPe31000/LPe32000 | 2023.11. |
| | | | Emulex | LPe32002-M2 | LPe31000/LPe32000 | 2023.11. |
| | | | Emulex | LPE16002B-M6 | LPe15000/LPe16000 | 2023.11. |
| GPU | 适配4张 | sig-Compatibility | | | | |
| | | | NVIDIA | Tesla T4 |	TU104GL | 2023.11. |
| | | | NVIDIA | Tesla V100 | GV100GL | 2023.11. |
| | | | NVIDIA | Tesla A100 | GA100 | 2023.11. |
| | | | AMD | Radeon Pro WX 5100 | Ellesmere| 2023.11. |
| SSD | 适配1张 | sig-Compatibility | | | | |
| | | | Huawei | ES3600C V5-3200GB | Hi1812E V100 | 2023.11. |
| IB | 适配3张 | sig-Compatibility | | | | |
| | | | Mellanox | SP351 | ConnectX-5 | 2023.11. |
| | | | Mellanox | SP350 | ConnectX-5 | 2023.11. |
| | | | Mellanox | MCX653105A-EFAT | ConnectX-6 | 2023.11. |
| NIC | 适配NIC板卡14张 | sig-Compatibility | | | | |
| | | | Mellanox | SP382 | ConnectX-5 | 2023.11. |
| | | | Mellanox | SP380 | ConnectX-4 Lx | 2023.11. |
| | | | Mellanox | MCX4121A-XCAT |	ConnectX-4 Lx | 2023.11. |
| | | | Mellanox | MCX4121A-ACUT |	ConnectX-4 Lx | 2023.11. |
| | | | Intel |	SP310 |	82599ES | 2023.11. |
| | | | Intel |	SP210 |	I350 | 2023.11. |
| | | | Intel |	Intel I350 | I350 | 2023.11. |
| | | | Intel |	I350-F2 | I350 | 2023.11. |
| | | | Intel |	XL710-Q2 | XL710 | 2023.11. |
| | | | Huawei | SP580 | Hi1822 | 2023.11. |
| | | | Huawei | SP582 | Hi1822 | 2023.11. |
| | | | Huawei | SP570 | Hi1822 | 2023.11. |
| | | | Huawei | SP670 | Hi1823 | 2023.11. |
| | | | Huawei | SP680 | Hi1823 | 2023.11. |

此版本的整机兼容性适配测试主要使用社区开源硬件兼容性测试工具oec-hardware，从整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性等方面进行适配，适配完成后将在社区发布此版本的整机兼容性清单。

整机适配兼容性测试交付清单如下：

| **整机厂商** | **整机型号** | **CPU型号** | **测试主体** | **测试计划** |
|--|--|--|--|--|
| 华为 | 泰山200 | 鲲鹏920 | sig-Compatibility | 2023.11. |
| | 青松服务器 | FT S2500 | sig-Compatibility | 2023.11. |
| 超聚变 | 2288H V5 | Intel cascade | sig-Compatibility | 2023.11. |
| | 2288H V6 | Intel SPR | sig-Compatibility | 2023.11. |
| 中科可控 | R6230HA | Hygon 2号 | sig-Compatibility | 2023.11. |
|  | X7840H0 | Hygon 3号 | sig-Compatibility | 2023.11. |
| AMD | Supermicro AS-4124GS-TNR | AMD Milan | sig-Compatibility | 2023.11. |
| 飞腾 | 公版 | FT2000+ | sig-Compatibility |2023.11. |
| | 公版 | FT S2500 | sig-Compatibility | 2023.11. |
| 兆芯 | ThinkSystem SR658Z | KH-30000 | sig-Compatibility | 2023.11. |

#### 北向兼容性

#### 虚拟化兼容性

虚拟化兼容性(即openEuler本版本的虚拟机能否在其余OS host)
* 常用桌面虚拟化软件对openEuler的支持
* 常用linux发行版对openEuler虚机镜像的支持
* openEuler对常见linux发行版虚机镜像的支持

### 软件包管理专项测试

软件包(openEuler中特指RPM包)测试，基于历史20.03至今发现的质量问题总结。
* 软件版本变更检查：检查前序版本的代码变动是否在当前版本继承，保证代码不漏合。
* 多动态库检查：检查软件是否存在多个版本动态库（存在编译自依赖软件包升级方式不规范）

### 资料测试

资料测试主要是对版本交付的资料进行测试，重点是保证各个资料描述说明的清晰性和功能的正确性，另外openEuler作为一个开源社区，除提供中文的资料还有英文文档也需要重点测试。资料交付清单如下：

| **手册名称**       | **覆盖策略**                                | **中英文测试策略** |
|------------------|--------------------------------------------|------------------|
| DDE安装指南       | 安装步骤的准确性及DDE桌面系统是否能成功安装启动    | 英文描述的准确性   |
| UKUI安装指南      | 安装步骤的准确性及UKUI桌面系统是否能成功安装启动   | 英文描述的准确性   |
| KIRAN安装指南     | 安装步骤的准确性及Kiran桌面系统是否能成功安装启动  | 英文描述的准确性   |
| XFCE安装指南      | 安装步骤的准确性及XFCE桌面系统是否能成功安装启动   | 英文描述的准确性   |
| GNOME安装指南     | 安装步骤的准确性及GNOME桌面系统是否能成功安装启动  | 英文描述的准确性   |
| 树莓派安装指导     | 树莓派镜像的安装方式及安装指导的准确性及树莓派镜像是否可以成功安装启动 | 英文描述的准确性   |
| 安装指南          | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 管理员指南         | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 安全加固指南       | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 虚拟化用户指南     | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| StratoVirt用户指南 | 文档描述与版本的行为是否一致                   | 英文描述的准确性   |
| 容器用户指南       | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 应用开发指南       | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |
| 工具集用户指南     | 文档描述与版本的行为是否一致                    | 英文描述的准确性   |

# 测试执行策略

openEuler 22.03 LTS SP3 版本按照社区release-manager团队既定的版本计划，共有5轮测试，按照社区研发模式，所有的需求都在拉分支前已完成合入，因此版本测试采取1+3+1的测试方式，即1轮基本功能保障发布beta版本可以提供给外部开发者，3轮全量保障本次版本发布所有特性(新增&继承)以及系统其他dfx能力，1轮回归。

### 测试计划

openEuler 22.03 LTS SP3 版本按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试活动。

|Stage name|Begin time|End time|Days|Note|
|:----------|:---------|:-------|:---------|:-------|
| Collect key features | 2023/9/7  | 2023/10/15 | 37   | 版本需求收集 |
| 变更检查阶段1          | 2023/10/8  | 2023/11/8  | 30   | Review软件包变更（升级/退役/淘汰）  |
| 变更检查阶段2          | 2023/10/16 | 2023/10/16 | 1    | Review基础设施相关变更   |
| Develop              | 2023/10/8  | 2023/11/8  | 30   | 这个时间段内完成开发，合入22.03  LTS-Next  |
| Kernel freezing      | 2023/11/3  | 2023/11/8  | 6    | 内核冻结    |
| LTS-Next mass rebuild| 2023/11/9  | 2023/11/10 | 2    | 22.03-LTS Next分支大规模编译构建    |
| 变更检查阶段3          | 2023/11/11 | 2023/11/12 | 3    | 22.03-LTS Next分支发起软件包淘汰（持续编译/构建失败）评审        |
| Branch               | 2023/11/13 | 2023/11/15 | 3    | 从22.03 LTS-Next拉SP3版本分支        |
| Build & Alpha        | 2023/11/16 | 2023/11/22 | 7    | 22.03-LTS SP3版本DailyBuild  & 开发自验证    |
| Test round 1         | 2023/11/23 | 2023/11/29 | 7    | 22.03-LTS SP3版本启动集成测试  |
| 变更检查阶段4          | 2023/11/30 | 2023/11/30 | 1    | 22.03-LTS SP3版本分支发起软件包淘汰（持续编译/构建失败）评审      | 
| Beta Version release | 2023/12/1  | 2023/12/2  | 2    | 22.03-LTS SP3 Beta版本发布   |
| Test round 2         | 2023/12/2  | 2023/12/8  | 7    | 全量SIT验证   |
| 变更检查阶段5          | 2023/12/9  | 2023/12/9  | 1    | 22.03-LTS SP3版本分支代码冻结：受限合入，原则上仅允许bug fix     | 
| Test round 3         | 2023/12/9  | 2023/12/15 | 7    | 全量SIT验证，版本分支代码冻结：管控合入，原则上只允许bug fix      |
| Test round 4         | 2023/12/16 | 2023/12/22 | 7    | 回归测试   |
| Test round 5         | 2023/12/23 | 2023/12/29 | 7    | 回归测试   |
| Release              | 2023/12/30 | 2023/12/30 | 1    | 社区Release版本发布评审 |




### 测试重点

测试阶段1：

1.  继承特性/新特性的基本功能

2.  交付重要组件(内核、虚拟化、容器、编译器等)的功能完整性

3.  系统集成方面保证多组件多模块集成的正确性和整体系统的完整性

4.  通过软件包管理测试，对LTS SP3版本发布软件的可安装、卸载、升级、回退进行整体保证

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

1. 交付特性/组件的全量测试

2. 问题单回归

3. 软件包管理测试

4. 系统集成验证

5. 专项：安全CVE扫描、可靠性、性能、文档测试、南北向兼容性测试

测试阶段5：

1. 交付特性/组件的自动化全量测试

2. 系统集成自动化测试项执行

3. 问题单全量回归

4. 专项：交付件病毒扫描、文档测试

### 入口标准

1.  上个阶段无block问题遗留

2.  转测版本的冒烟无阻塞性问题

### 出口标准

1.  策略规划的测试活动涉及测试用例100%执行完毕

2.  发布特性/新需求/性能基线等满足版本规划目标

3.  版本无block问题遗留，其它严重问题要有相应规避措施或说明

# 附件

无

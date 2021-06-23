![openEuler ico](../../images/openEuler.png)

版权所有 © 2021  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节 | 修改描述   |
| ---------- | -------- | -------- | ---------- |
| 2021/06/17 | 1.1.0    | 初始     | charlie_li |

关键词：

openEuler  LTS  SP2  raspberrypi  UKUI  DDE xfce  HA  iSula  A-Tune stratovirt kvm qemu  docker

摘要：

文本主要描述openEuler 20.03 LTS SP2版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

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
| CE          | corrected error                      | 可纠正的错误   |

---

\***

# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 20.03 LTS SP2版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 20.03 LTS SP2版本是20.03 LTS的补丁版本，发布范围相较20.03 LTS和20.03 LTS SP1版本主要变动如下：

1. 回合openEuler 21.03创新版本中部分特性：

   内存分级扩展/secGear组件/支持xfce 4.14/支持K8S 1.18/虚拟化可靠性核可维护性增强/虚拟化热迁移pro/stratovirt轻量化虚拟化平台/虚拟机热迁移支持TLS

2. 新增特性：

   IO_URING全栈使能/CPU核故障在线隔离/内存UCE故障降级/构建工程多版本支持/支持OpenStack R版本/支持网络安装/vmtopX86支持

3. 补齐/优化社区软件包生态

4. 修复bug和cve

openEuler 20.03 LTS SP2版本按照社区release-manager团队的计划，共规划5轮测试，实际执行6论测试，详细的版本信息和测试时间如下表：

| 版本名称                                                     | 测试起始时间 | 测试结束时间 |
| ------------------------------------------------------------ | ------------ | ------------ |
| openEuler 20.03 LTS SP2 RC1                                  | 2021-05-08   | 2021-05-13   |
| openEuler 20.03 LTS SP2 RC2                                  | 2021-05-18   | 2021-05-24   |
| [openEuler 20.03 LTS SP2 RC2树莓派测试镜像](http://121.36.84.172/dailybuild/openEuler-20.03-LTS-SP2/test_openeuler-2021-05-17-12-45-16/raspi_img/openEuler-20.03-LTS-SP2-raspi-aarch64.img.xz) | 2021-05-18   | 2021-05-24   |
| openEuler 20.03 LTS SP2 RC3                                  | 2021-05-28   | 2021-06-04   |
| openEuler 20.03 LTS SP2 RC4                                  | 2021-06-05   | 2021-06-08   |
| [openEuler 20.03 LTS SP2 RC5树莓派测试镜像](http://121.36.84.172/dailybuild/openEuler-20.03-LTS-SP2/test_openeuler-2021-06-08-19-27-31/raspi_img/openEuler-20.03-LTS-SP2-raspi-aarch64.img.xz) | 2021-06-09   | 2021-06-16   |
| openEuler 20.03 LTS SP2 RC5                                  | 2021-06-09   | 2021-06-16   |
| openEuler 20.03 LTS SP2 RC6                                  | 2021-06-19   | 2021-06-20   |

测试的硬件环境如下：

| 硬件型号                            | 硬件配置信息                                                                          | 备注                      |
| ----------------------------------- | ------------------------------------------------------------------------------------- | ------------------------- |
| TaiShan 200 2280均衡型              | HiSilicon Kunpeng 920<br />32G*4 2933MHz<br />LSI SAS3508<br />TM210                  |                           |
| RH2288H V5                          | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz<br />32*4 2400MHz<br />LSI SAS3508<br />X722 |                           |
| 树莓派4B卡                          | CPU:Cortex-A72 * 4 <br />内存：8GB <br />存储设备：SanDisk Ultra 16GB micro SD        | 默认测试环境，数量1       |
| 树莓派3B+卡                         | CPU:Cortex-A53 * 4<br />内存：1GB 存储设备<br />SanDisk Ultra 16GB micro SD           | 硬件兼容性测试环境，数量1 |
| 树莓派3B卡                          | CPU:Cortex-A53 * 4 <br />内存：1GB <br />存储设备：SanDisk Ultra 16GB micro SD        | 硬件兼容性测试环境，数量1 |
| 支持树莓派的7寸屏                   | HDMI接口，1024*600分辨率电容屏                                                        | 数量1                     |
| thinkpad x1 carbon 2019             |                                                                                       | 远程控制树莓派设备        |
| RG-AP740-I(C)室内802.11ac无线接入点 |                                                                                       | 无线网环境                |
| 1Gbps交换机                         |                                                                                       | 有线网环境                |
| 长城擎天服务器<br>DF723             | CPU型号：FT2000+<br>CPU核数：64<br>内存：64G<br>硬盘容量：240G                        |                           |
| 联想启天台式机<br>M425-N000         | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz<br>CPU内核总数：6<br>内存容量：16G  |                           |
| FT-2000+64核服务器                  | CPU型号：FT-2000+<br />CPU核数：64<br />内存：镁光16G*32<br />网卡：I350              |                           |

openEuler 20.03 LTS SP2版本交付需求列表如下：

详见：[https://gitee.com/openeuler/release-management/blob/master/openEuler-20.03-LTS-SP2/release-plan.md](https://gitee.com/openeuler/release-management/blob/master/openEuler-20.03-LTS-SP2/release-plan.md)

| **no** | **feature**                                                  | **status** | **sig**                    | **owner**                                        |
| ------ | ------------------------------------------------------------ | ---------- | -------------------------- | ------------------------------------------------ |
| 1      | [【openEuler 20.03 LTS SP2】【虚拟化】回合openEuler 21.03，vmtop支持x86](https://gitee.com/openeuler/release-management/issues/I3NLWF?from=project-issue) | Accepted   | virt                       | @alexchen                                        |
| 2      | [openEuler 20.03-LTS-SP2支持内存分级扩展特性](https://gitee.com/openeuler/release-management/issues/I2C2NI?from=project-issue) | Accepted   | storage                    | [liuzhiqiang26](https://gitee.com/liuzhiqiang26) |
| 3      | [openEuler 20.03-LTS-SP2版本集成secgear组件](https://gitee.com/openeuler/release-management/issues/I3JE3U?from=project-issue) | Accepted   | sig-confidential-computing | [chenmaodong](https://gitee.com/chenmaodong)     |
| 4      | openEuler 20.03 LTS SP2 support OpenStack Rocky              | Accepted   | sig-openstack              | @joec88 @liksh @xiyuanwang @huangtianhua         |
| 5      | [openEuler 20.03 LTS SP2支持osinfo软件包](https://gitee.com/openeuler/release-management/issues/I3N30H?from=project-issue) | Accepted   | packaging                  | @solarhu                                         |
| 6      | [openEuler 20.03 LTS SP2开源openEuler-rpm-config宏定义文件](https://gitee.com/openeuler/release-management/issues/I3N30J?from=project-issue) | Accepted   | Base-service               | @overweight                                      |
| 7      | [openEuler 20.03 LTS SP2 支持 compat-openssl10、libzip等](https://gitee.com/openeuler/release-management/issues/I3N30L?from=project-issue) | Accepted   | packaging                  | @solarhu                                         |
| 8      | [openEuler 20.03 LTS SP2 支持libwbxml、hyperscan](https://gitee.com/openeuler/release-management/issues/I3N30N?from=project-issue) | Accepted   | Desktop                    | @small_leek                                      |
| 9      | [openEuler 20.03 LTS SP2支持microcode_ctl](https://gitee.com/openeuler/release-management/issues/I3N30S?from=project-issue) | Accepted   | packaging                  | @solarhu                                         |
| 10     | [openEuler 20.03 LTS SP2支持bcc软件包](https://gitee.com/openeuler/release-management/issues/I3N30Q?from=project-issue) | Accepted   | packaging                  | @solarhu                                         |
| 11     | [openEuler 20.03 LTS SP2支持树莓派](https://gitee.com/openeuler/release-management/issues/I3N30P?from=project-issue) | Accepted   | RaspberryPi                | @jianminw                                        |
| 12     | [openEuler 20.03 LTS SP2支持1822 HBA卡](https://gitee.com/openeuler/release-management/issues/I3N30V?from=project-issue) | Accepted   | kernel                     | @xiexiuqi                                        |
| 13     | [openEuler 20.03 LTS SP2支持飞腾2000+/64](https://gitee.com/openeuler/release-management/issues/I3N30W?from=project-issue) | Accepted   | kernel                     | @xiexiuqi                                        |
| 14     | [openEuler 20.03 LTS SP2支持maildrop和proftpd](https://gitee.com/openeuler/release-management/issues/I3N30X?from=project-issue) | Accepted   | Application                | @solarhu                                         |
| 15     | [openEuler 20.03 LTS SP2支持 iSulad 2.0](https://gitee.com/openeuler/release-management/issues/I3N312?from=project-issue) | Accepted   | isulad                     | @lifeng2221dd1                                   |
| 16     | [openEuler 20.03 LTS SP2 A-tune 2.0](https://gitee.com/openeuler/release-management/issues/I3N314?from=project-issue) | Accepted   | A-Tune                     | @xiezhipeng1                                     |
| 17     | [openEuler 20.03 LTS SP2 支持网络安装](https://gitee.com/openeuler/release-management/issues/I3N315?from=project-issue) | Accepted   | sig-OS-Builder             | @t_feng                                          |
| 18     | [openEuler 20.03 LTS SP2 支持 criu组件](https://gitee.com/openeuler/release-management/issues/I3N319?from=project-issue) | Accepted   | ops                        | @luanjianhai                                     |
| 19     | [openEuler 20.03 LTS SP2支持config_acpi_nfit](https://gitee.com/openeuler/release-management/issues/I3N31B?from=project-issue) | Accepted   | kernel                     | @xiexiuqi                                        |
| 20     | [openEuler 20.03 LTS SP2 虚拟化增强](https://gitee.com/openeuler/release-management/issues/I3N31E?from=project-issue) | Accepted   | virt                       | [@KuhnChen](https://gitee.com/KuhnChen)          |
| 21     | [openEuler 20.03 LTS SP2 支持 UKUI桌面](https://gitee.com/openeuler/release-management/issues/I3N31F?from=project-issue) | Accepted   | sig_UKUI                   | [@dou33](https://gitee.com/dou33)                |
| 22     | [openEuler 20.03 LTS SP2 支持DDE桌面](https://gitee.com/openeuler/release-management/issues/I3N31J?from=project-issue) | Accepted   | sig-DDE                    | [@panchenbo](https://gitee.com/panchenbo)        |
| 23     | [openEuler 20.03 LTS SP2 编译器支持openjdk](https://gitee.com/openeuler/release-management/issues/I3N31M?from=project-issue) | Accepted   | compiler                   | @jdkboy                                          |
| 24     | [openEuler 20.03 LTS SP2支持HA](https://gitee.com/openeuler/release-management/issues/I3N31O?from=project-issue) | Accepted   | sig-HA                     | [@yangzhao_kl](https://gitee.com/yangzhao_kl)    |
| 25     | [openEuler 20.03 LTS SP2 加速库版本同步](https://gitee.com/openeuler/release-management/issues/I3N31Q?from=project-issue) | Accepted   | kae                        | @wuliaokanke                                     |
| 26     | [openEuler 20.03 LTS SP2支持金融领域软件包](https://gitee.com/openeuler/release-management/issues/I3N311?from=project-issue) | Accepted   | packaging                  | @solarhu                                         |
| 27     | [openEuler 20.03 LTS SP2支持kmod功能](https://gitee.com/openeuler/release-management/issues/I3N30C?from=project-issue) | Accepted   | packaging                  | @solarhu                                         |
| 28     | [openEuler 20.03 LTS SP2 CPU核故障在线隔离解决方案](https://gitee.com/openeuler/release-management/issues/I3N36L?from=project-issue) | Accepted   | kernel                     | @xiexiuqi                                        |
| 29     | [openEuler 20.03 LTS SP2 支持多应用版本构建和发布](https://gitee.com/openeuler/release-management/issues/I3N36K?from=project-issue) | Accepted   | Gatekeeper                 | @solarhu                                         |
| 30     | [openEuler 20.03 LTS SP2 内存UCE故障降级，用户数据保持一致，业务可持续运行](https://gitee.com/openeuler/release-management/issues/I3N36H?from=project-issue) | Accepted   | kernel                     | @xiexiuqi                                        |
| 31     | [openEuler 20.03 LTS SP2 故障预测框架](https://gitee.com/openeuler/release-management/issues/I3N36F?from=project-issue) | Accepted   | kernel                     | @xiexiuqi                                        |
| 32     | [openEuler 20.03 LTS SP2 IO_URING全栈使能](https://gitee.com/openeuler/release-management/issues/I3N36C?from=project-issue) | Accepted   | kernel                     | @xiexiuqi                                        |
| 33     | [openEuler 20.03 LTS SP2 Qemu：虚拟化可靠性和可维护性增强](https://gitee.com/openeuler/release-management/issues/I3N369?from=project-issue) | Accepted   | sig-virt                   | [@KuhnChen](https://gitee.com/KuhnChen)          |
| 34     | [openEuler 20.03 LTS SP2 Qemu：热迁移pro，提升热迁移性能+安全](https://gitee.com/openeuler/release-management/issues/I3N368?from=project-issue) | Accepted   | sig-virt                   | [@KuhnChen](https://gitee.com/KuhnChen)          |
| 35     | [openEuler 20.03 LTS SP2支持StratoVirt：下一代轻量化虚拟化平台](https://gitee.com/openeuler/release-management/issues/I3N364?from=project-issue) | Accepted   | sig-virt                   | [@KuhnChen](https://gitee.com/KuhnChen)          |
| 36     | [【openEuler 20.03 LTS SP2】继承xfce 4.14](https://gitee.com/openeuler/release-management/issues/I3NC3I?from=project-issue) | Accepted   | xfce                       | [@dillon_chen](https://gitee.com/dillon_chen)    |
| 37     | [【openEuler 20.03 LTS SP2】继承Kubernetes 1.18](https://gitee.com/openeuler/release-management/issues/I3NC5H?from=project-issue) | Accepted   | sig-cloudnative            | [@jingxiaolu](https://gitee.com/jingxiaolu)      |
| 38     | [【openEuler 20.03 LTS SP2】继承门禁检查功能](https://gitee.com/openeuler/release-management/issues/I3O08F?from=project-issue) | Accepted   | Gatekeeper                 | @solarhu                                         |
| 39     | [openEuler 20.03-LTS-SP2 集成 kubernetes 及其依赖组件](https://gitee.com/openeuler/release-management/issues/I2BHF4?from=project-issue) | Accepted   | sig-cloudnative            | [@jingxiaolu](https://gitee.com/jingxiaolu)      |
| 40     | [openEuler 20.03-LTS-SP2 arm虚拟机支持NMI watchdog](https://gitee.com/openeuler/release-management/issues/I2B4WL?from=project-issue) | Accepted   | virt                       | @alexchen                                        |
| 41     | [openEuler 20.03-LTS-SP2 集成 coredns 及其依赖组件](https://gitee.com/openeuler/release-management/issues/I3MXLJ?from=project-issue) | Accepted   | sig-cloudnative            | [@jingxiaolu](https://gitee.com/jingxiaolu)      |
| 42     | [【openEuler 20.03 LTS SP2】虚拟机热迁移支持TLS](https://gitee.com/openeuler/release-management/issues/I3IE57?from=project-issue) | Accepted   | virt                       | @alexchen                                        |
| 43     | [【kernel-4.19】openEuler kernel nvme 驱动增强](https://gitee.com/openeuler/release-management/issues/I1WGZE?from=project-issue) | Accepted   | kernel                     | @xiexiuqi                                        |
| 44     | [openEuler 20.03-LTS-SP2 集成 etcd 及其依赖组件](https://gitee.com/openeuler/release-management/issues/I3MXGJ?from=project-issue) | Accepted   | sig-cloudnative            | [@jingxiaolu](https://gitee.com/jingxiaolu)      |

本次SP2版本测试活动分工如下：

| **需求**                | **开发主体**    | **测试主体**                       | **测试策略**                                                 |
| ----------------------- | --------------- | ---------------------------------- | ------------------------------------------------------------ |
| 支持树莓派发布件        | sig-RaspberryPi | sig-RaspberryPi                    | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试       |
| 支持UKUI桌面            | sig-UKUI        | sig-UKUI                           | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
| 支持HA软件              | sig-Ha          | sig-Ha                             | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持DDE桌面             | sig-DDE         | sig-DDE                            | 验证DDE在openEuler版本上的核心功能及基本UI操作               |
| 支持XFCE桌面            | sig-xfce        | sig-xfce                           | 验证XFCE桌面重要系统组件和插件的功能                         |
| 支持openstack Rocky版本 | sig-openstack   | sig-openstack                      | 验证openstack各个组件的基本功能                              |
| 支持加速库              | sig-Kae         | sig-kae                            | 验证硬件加速库的基本功能和性能                               |
| 版本其它需求            | sig-QA          | sig-QA                             | 发布范围需求的质量保障和系统整体集成能力                     |
| 支持飞腾arm64架构CPU    | NA              | sig-Compatibility-Infra</br>sig-QA | 通过执行硬件兼容性测试套对飞腾FT2000+进行兼容性测试<br />系统重要组件和特性在飞腾FT2000+上的集成验证 |

# 3   版本概要测试结论

   openEuler 20.03 LTS SP2版本整体测试按照release-manager团队的计划，共完成了三轮全量测试+一轮重点特性自动化+两轮回归+版本发布验收测试；其中第一轮全量测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫面及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；另外两轮全量测试开展版本交付的所有特性和各类专项测试；一轮重点特性自动化测试重点时基于问题单较多模块进行重点覆盖和扩展测试，验证问题的修复和影响程度；版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。SP2版本按照测试策略完成了全量功能验证和专项测试(性能、可靠性、兼容性、安全)，所有测试任务均按计划完成。本版本计划交付需求44个，实际交付44个，交付率100%，所有发布需求均验证通过。

​    openEuler 20.03 LTS SP2版本共发现问题193个，有效问题186个，遗留问题3个(详见遗留问题章节)，其他问题均已修复，回归测试结果正常。版本整体质量较好。

# 4   版本详细测试结论

SP2版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从openEuler 21.03版本回合特性包括虚拟化CPU/MEM热插、VMtop支持、虚拟机安全启动、虚拟机支持VCPU custom、stratovirt轻量虚拟化平台等特性的全量功能验证，组件和特性质量较好；

2、新增软件包通过软件包专项完成了软件包的安装卸载、编译、命令行、服务检查等测试，软件包生态补齐测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试；

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                             |        特性质量评估        | 备注                                                                                                                   |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
| 1    | 内核                                      | <font color=green>█</font> | 继承内核已有测试能力，通过使用开源测试套LTP和mmtest对内核开展基本功能进行测试；并通过构建地址消毒的内核版本利用syzkaller开源测试套进行fuzz测试；通过构建系统压力，反复长时间随机执行LTP基本系统调用，对内核开展7*24小时的稳定性测试，整体用例执行通过；内核整体质量良好 |
| 2    | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | 覆盖容器领域iSula和docker引擎的基本能力，针对安全容器、系统容器、普通容器和容器镜像进行功能/可靠性/稳定性测试，共执行用例742个，用例执行全部通过，整体质量良好 |
| 3    | 编译器(gcc/jdk)                           | <font color=green>█</font> | 对gcc/jdk组件完成开源功能测试套supertest和开源fuzz测试套csmith\jfuzz的全量覆盖，另外使用SEPCjbb2015对jdk开展性能max-jOPS和critical-jOPS项的测试，性能指标和SP1版本持平，编译器组件整体质量良好 |
| 4    | 支持vCPU热插                          | <font color=green>█</font> | 对虚拟机支持vCPU热插能力进行功能/可靠性/稳定性和场景测试，共执行用例93条，覆盖基本功能、并发压力场景下的反复热插、长时间的生命周期操作；用例全部执行通过，特性质量良好 |
| 5    | 支持vMEM热插                                | <font color=green>█</font> | 对虚拟机支持vMEM热插能力进行功能/可靠性/稳定性和场景测试，共执行用例78条，覆盖基本功能、并发压力场景下的反复热插、长时间的生命周期操作；用例全部执行通过，特性质量良好    |
| 6    | aarch64场景支持vmtop           | <font color=green>█</font> | 对vmtop功能覆盖单/多虚机场景下的基本查询功能的验证；另外在并发和hostOS大压力场景下，测试vmtop的运行和执行采集的验证；共执行用例6条，特性整体质量良好 |
| 7    | vCPU支持Custom模式                          | <font color=green>█</font> | 对虚拟机vCPU支持Custom模式功能进行cpu feature的使能/去使能/不下发等操作验证，验证虚机配置cpu custom后，各类基本生命周期操作的完整性和cpu热插/绑核等操作；可靠性上开展各类参数配置检查和反复并发以及CPU长时间的压力测试；特性用例全部执行通过，整体质量良好 |
| 8    | 虚拟机安全启动                            | <font color=green>█</font> | 对此特性开展功能、可靠性、稳定性测试、文档资料等测试，覆盖安全启动正常功能、安全启动与非安全启动的交替启动、长时间并发反复的生命周期操作；特性用例全部执行通过，质量良好 |
| 9    | Kunpeng加速引擎                           | <font color=green>█</font> | 继承已有测试能力，完成加速器KAE的基本功能和性能指标验证，共计执行用例176个，全部执行通过，满足发布标准                                |
| 10   | A-Tune                                    | <font color=green>█</font> | A-Tune作为操作系统性能调优引擎，完成特性查询负载类型、分析负载类型并自优化、自调优以及模型训练输入数据集的训练等功能用例全量测试，并从高压力负载和长时间运行两个方面对A-Tune功能进行验证，共计执行用例123个，特性整体质量良好 |
| 11 | 支持1822 HBA卡 | <font color=green>█</font> | 由于内核层面能够保证KABI的前向兼容，所以继承SP1版本测试结论：覆盖三种FC卡形态(SP527\SP520\SP525)的基本功能，覆盖只读、只写、混合读写业务(512B-4M);进行业务异常测试、故障注入、压力等可靠性测试，16G GC标卡2.0性能达标，质量良好 |
| 12   | 支持UKUI桌面                              | <font color=green>█</font> | 共执行两轮测试，覆盖UKUI桌面的核心功能、重要组件及系统插件的测试，共计执行用例62条，整体质量良好                                                                |
| 13 | 支持DDE桌面 | <font color=green>█</font> | 共执行两轮测试，共执行用例240条，主要覆盖了基础组件跟预装应用核心功能以及基本UI测试。发现3个问题，已经回归通过，无遗留问题。整体核心功能基本可满足使用。 |
| 14 | 支持高可用pacemaker | <font color=green>█</font> | 共执行三轮测试，执行测试用例87条，主要覆盖HA的基本能力；在各类资源异常失效情况下的切换能力；日志收集功能及网络故障异常场景下的HA功能，通过长时间测试，稳定性良好，特性基本可用。 |
| 15 | 支持criu组件 | <font color=green>█</font> | 集成开源组件criu，作为内核热升级的提前预置，主要验证checkpoint/restore等功能能正常使用，质量良好 |
| 13   | 树莓派支持                              | <font color=green>█</font> | 对树莓派镜像进行安装、基本功能、管理工具、硬件兼容性和稳定性测试；共执行用例85条，整体质量良好                                                                 |
| 14   | 安装部署                                  | <font color=green>█</font> | 覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署；安装部署功能质量良好    |
|  | 支持飞腾2000+/64 | <font color=green>█</font> | 由于内核层面能够保证KABI的前向兼容，所以继承SP1版本测试结论；另外对SP2版本发布的重要组件：容器、虚拟化和系统集成测试在飞腾服务器上执行验证通过，无问题；质量良好 |
| 16 | 支持内存分级扩展 | <font color=green>█</font> | 共计执行90个用例，覆盖范围包括特性的功能、可靠性，安全和性能；整体质量良好<br/>约束：1、客户端和服务端需要在同一个服务器上部署，不支持跨服务器通信的场景<br/>2、仅支持扫描进程名小于或等于15个字符长度的目标进程 |
| 17 | 集成secgear组件 | <font color=blue>▲</font> | 共计执行100个用例，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试；质量良好</br>约束：依赖BIOS版本 |
| 18 | 虚拟化热迁移及其他加强 | <font color=green>█</font> | 对qemu热迁移特性覆盖接口测试、可靠性测试、性能测试，共计用例58个，质量良好<br/>说明：支持同型号CPU间迁移 |
| 19 | 支持StratoVirt：下一代轻量化虚拟化平台 | <font color=green>█</font> | stratovirt新增特性，内存弹性共20个用例，ioqos共10个用例，iothread共24个用例，内存大页共61个用例，多平台支持2个用例。覆盖功能测试、可靠性测试、安全测试和性能测试；整体质量良好<br/>内存弹性约束：内核镜像需支持balloon特性，当前仅支持host与guest端页面大小相同的场景。<br/>ioqos约束：限速范围[0, 1000000]，暂不支持热插，只能限制平均iops，无法限制突发流量。<br/>iothread约束：总的io线程数量不超过8个，暂不支持热插。<br/>内存大页：仅支持在stratovirt启动时在命令行中配置，仅支持静态大页，配置的内存规格不能大于配置的host大页总大小。 |
| 20 | 集成xfce 4.14 | <font color=green>█</font> | 共经过两轮测试，执行103个测试项，整体核心功能(重要组件和系统插件)稳定正常，整体质量良好 |
| 21 | 集成Kubernetes 1.18及其相关依赖组件 | <font color=blue>▲</font> | 共执行311个用例，主要覆盖了功能一致性测试，架构x86和arm均测试通过；整体功能基本可用<br/>后续建议：增加对Kubernetes各组件的底噪消耗和稳定性测试 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称**                                         | **测试覆盖情况**                                             | **约束依赖说明** | **遗留问题单** | **质量评估**               | **备注<img width=50/>**                                      |
| -------- | ---------------------------------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1        | 软件包生态补齐                                       | 对新增软件包开展管理(安装/卸载/编译)及命令/服务，另外对L1和L2的软件包开展加固测试(fuzz/场景)，质量良好 | NA               | NA             | <font color=green>█</font> |                                                              |
| 2        | 支持OpenStack Rocky版本                              | 共计执行Tempest用例1197个，主要覆盖了API测试和功能测试，Skip用例101个（全是openStack Rocky版中已废弃的功能或接口，如KeystoneV1、Cinder V1等），其他1096个用例全部通过，发现问题已解决，整体质量良好。 | NA               | NA             | <font color=blue>▲</font>  | 后续建议增加对openstack各个组件底噪消耗的基线验证以及相应的稳定性测试 |
| 3        | 支持网络安装                                         | 共执行四轮测试，共执行用例216用例，主要覆盖了物理机和虚拟机，场景覆盖了所有常用安装按键及其组合，质量良好 | NA               | NA             | <font color=green>█</font> |                                                              |
| 4        | CPU核故障在线隔离解决方案/内存UCE故障降级/内存页隔离 | 共执行3轮测试，共执行用例108条，覆盖了基础功能、性能、可靠测试，整体质量良好 | NA               | NA             | <font color=green>█</font> |                                                              |
| 5        | 支持多应用版本构建和发布                             | 完成2轮测试，覆盖工程对软件多版本构建和发布的基本能力验证，并完成软件包发布后的安装验证，整体质量良好 | NA               | NA             | <font color=green>█</font> |                                                              |
| 6        | x86场景vmtop支持                                     | 共执行2轮测试，执行用例6个，覆盖单/多虚机场景下的基本功能；另外在并发和hostOS大压力场景下，测试vmtop的运行和执行情况；整体质量良好 | NA               | NA             | <font color=green>█</font> |                                                              |




<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler 20.03 LTS SP2作为 openEuler 20.03 LTS版本的补丁版本，支持从LTS和LTS SP1版本升级到对应的SP2，完成如下场景的升级验证

1、从LTS直接升级到SP2版本

2、从LTS SP1直接升级到SP2版本

3、从LTS的月度update维护升级到SP2版本

4、从LTS SP1的月度update维护升级到SP2版本

5、升级后系统的重启

上述场景下，软件包升级后的功能验证、服务检查等测试；SP2版本新增软件包通过对软件直接进行安装来进行；整体升级兼容性功能正常。

### 4.2.2   南向兼容性

南向兼容性当前继承20.03 LTS SP1的测试结论，详细信息见链接：openeuler.org/zh/compatibility;

下表列出版本集成验证中涉及的硬件信息：

| 硬件型号              | 硬件详细信息                                                                                          |
| --------------------- | ----------------------------------------------------------------------------------------------------- |
| FT-2000+64核服务器    | CPU型号：FT-2000+<br />CPU核数：64<br />内存：镁光16G 2666MHZ*32<br />网卡：I350                      |
| TaiShan200 2280服务器 | CPU型号：HiSilicon Kunpeng 920<br />CPU核数：128<br />内存：32G*8<br />网卡：Hi1822                   |
| RH2288H V5服务器      | CPU型号：Intel(R) Xeon(R) Gold 6266C CPU@3.00GHZ<br />CPU核数：44<br />内存：12*32G<br />网卡：Hi1822 |

### 4.2.3   北向兼容性

北向兼容性整体测试按照release-manager团队的规划，SP2版本发布后会进行持续的兼容性测试，当前已完成部分见下表：

| 软件名称  | 软件版本信息 |
| --------- | ------------ |
| sysbench  | 0.4.8        |
| unixbench | 5.1.3        |
| lmbench   | 3-alpha1     |
| MySQL     | 8.0.17       |
| nginx     | 1.14.2       |
| netperf   | 2.7.0        |
| hackbench | 1.0          |
| spark     | 2.3.0        |

## 4.3   专项测试结论

### 安全测试

整体安全测试覆盖：

1、Linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

3、白盒安全测试主要通过fuzz测试实现对接口参数类和内存管理类进行覆盖；通过部署kasan版本的内核，进行syzkaller测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对编译器组件行fuzz测试

4、针对安全加固指南中的加固项，进行全量测试。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型     | 测试内容                                                                               | 测试结论                   |
| ------------ | -------------------------------------------------------------------------------------- | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7*24小时   |
| 虚拟化长稳   | 结合Qemu ASAN地址消毒、Avocado-vt对新增特性开展长期测试                                | 虚拟化组件稳定运行7*24小时 |

### 性能测试

| **指标大项 ** | **指标小项**                                                 | **指标值**                   | 测试结论                 |
| ------------- | ------------------------------------------------------------ | ---------------------------- | ------------------------ |
| OS基础性能    | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考LTS和SP1版本相应指标基线 | 相比SP1版本有2%提升      |
| 虚拟化性能    | 主要对比openEuler 20.03 LTS版本评估CPU计算能力、MEM访问能力、中断虚拟化性能、磁盘IO等虚拟化基线性能测试项 | 参考LTS和SP1版本相应指标基线 | 基本持平                 |
| 特性性能      | 内存分级扩展特性在MySQL场景下，内存节省达到50%，性能下降不超过15%<br/>虚拟机热迁移速度较单通道迁移提升20%<br/>stratovirt极简配置下内存底噪<5M,启动速度<50ms | 参考特性相应性能指标         | 性能规格满足需求指标要求 |

# 5   问题单统计

给出版本问题单的分布或分类统计及问题单走势分析。

openEuler 20.03 LTS SP2版本共发现问题单193个，有效问题186个，其中修复问题单183个，回归均通过。详细分布见下表:

| 测试阶段                    | 问题单数 |
| --------------------------- | -------- |
| openEuler 20.03 LTS SP2 RC1 | 76       |
| openEuler 20.03 LTS SP2 RC2 | 61       |
| openEuler 20.03 LTS SP2 RC3 | 30       |
| openEuler 20.03 LTS SP2 RC4 | 14       |
| openEuler 20.03 LTS SP2 RC5 | 5        |

整体看版本问题单收敛趋势明显。

# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 |
| ---- | -------- | -------- | -------- | -------- | -------- |
| 1    | I3RA9K | 【20.03-LTS-SP2】arm物理机message日志出现错误：usbhid: probe of 1-1.1:1.1 failed with error -32 |  主要   | 根因：暂未定位出来<br/>影响：从当前分析情况看，即使出现描述错误，usb设备功能也是正常的，并且该问题偶现，影响较小 | 版本问题遗留  |
| 2    | I3QYSQ | 【20.03-LTS-SP2】[x86\arm]nfs-blkmap启动后报错“Can't open PID file”，关闭后状态变成failed |  次要  | 根因：nfs-blkmap服务为blkmapd-pNFS块布局映射守护程序的守护服务，该服务目前存在启动后缺少/var/lib/nfs/rpc_pipefs/nfs/blocklayout，上游社区同步存在<br/>影响：不影响nfs-utils基本功能，影响较小 | 版本问题遗留，同时跟踪上游社区解决情况 |
| 3    | I3UNYX | 【20.03-LTS-SP2】【arm/x86】booth-arbitrator.service、booth@.service服务启动失败 | 此要 | 根因：booth功能用于扩展pacemaker对于跨地域集群的支持。</br>booth@.service服务运行在HA集群当中，连接到在其他集群运行的booth守护进程并交换连接细节。</br>booth-arbitrator服务在两个booth实例之间的通讯中断时，提供额外的仲裁实例来就决策（例如跨站点的资源故障转移）达成共识。影响：不支持跨地域的HA集群功能。 | 版本问题遗留 |

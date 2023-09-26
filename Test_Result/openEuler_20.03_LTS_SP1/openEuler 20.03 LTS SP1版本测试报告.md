![openEuler ico](../../images/openEuler.png)

版权所有 © 2020  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节 | 修改描述   |
| ---------- | -------- | -------- | ---------- |
| 2020/12/22 | 1.1.0    | 初始     | charlie_li |

关键词：

 openEuler  LTS  SP1  raspberrypi  UKUI  DDE  HA  iSula  A-Tune  kvm qemu  docker

摘要：

 文本主要描述openEuler 20.03LTS SP1版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

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

***
\***

# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 20.03LTS SP1版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，对版本问题单进行整体的说明。

# 2   测试版本说明

openEuler 20.03LTS SP1版本是20.03LTS的补丁版本，发布范围相较20.03LTS版本主要变动如下：

1.  回合openEuler 20.09版本中部分特性；

2.  增加UKUI/DDE桌面系统和树莓派交付件；

3.  补齐/优化社区软件包生态；

4.  修复bug和cve；

openEuler 20.03 LTS SP1版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称                                                     | 测试起始时间 | 测试结束时间 |
| ------------------------------------------------------------ | ------------ | ------------ |
| openEuler 20.03 LTS SP1 RC1                                  | 2020-11-23   | 2020-11-28   |
| openEuler 20.03 LTS SP1 RC2                                  | 2020-12-01   | 2020-12-06   |
| [openEuler 20.03 LTS SP1 RC2树莓派测试镜像](http://117.78.1.88:82/dailybuilds/openeuler/openEuler-20.03-LTS-SP1/openeuler_2020-11-30-01-07-43/raspi_img/aarch64/openEuler-20.03-LTS-SP1-raspi-aarch64.img.xz) | 2020-12-01   | 2020-12-05   |
| openEuler 20.03 LTS SP1 RC3                                  | 2020-12-07   | 2020-12-13   |
| openEuler 20.03 LTS SP1 RC4                                  | 2020-12-14   | 2020-12-17   |
| [openEuler 20.03 LTS SP1 RC4树莓派测试镜像](http://117.78.1.88:82/dailybuilds/openeuler/openEuler-20.03-LTS-SP1/openeuler_2020-12-14-11-40-05/raspi_img/aarch64/openEuler-20.03-LTS-SP1-raspi-aarch64.img.xz) | 2020-12-16   | 2020-12-19   |
| openEuler 20.03 LTS SP1 RC5                                  | 2020-12-19   | 2020-12-22   |

测试的硬件环境如下：

| 硬件型号                            | 硬件配置信息                                                 | 备注                      |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------- |
| TaiShan 200 2280均衡型              | HiSilicon Kunpeng 920<br />32G*4 2933MHz<br />LSI SAS3508<br />TM210 |                           |
| RH2288H V5                          | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz<br />32*4 2400MHz<br />LSI SAS3508<br />X722 |                           |
| 树莓派4B卡                          | CPU:Cortex-A72 * 4 <br />内存：8GB <br />存储设备：SanDisk Ultra 16GB micro SD | 默认测试环境，数量1       |
| 树莓派3B+卡                         | CPU:Cortex-A53 * 4<br />内存：1GB 存储设备<br />SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |
| 树莓派3B卡                          | CPU:Cortex-A53 * 4 <br />内存：1GB <br />存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |
| 支持树莓派的7寸屏                   | HDMI接口，1024*600分辨率电容屏                               | 数量1                     |
| thinkpad x1 carbon 2019             |                                                              | 远程控制树莓派设备        |
| RG-AP740-I(C)室内802.11ac无线接入点 |                                                              | 无线网环境                |
| 1Gbps交换机                         |                                                              | 有线网环境                |
| 长城擎天服务器<br>DF723             | CPU型号：FT2000+<br>CPU核数：64<br>内存：64G<br>硬盘容量：240G |                           |
| 联想启天台式机<br>M425-N000         | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz<br>CPU内核总数：6<br>内存容量：16G |                           |
| FT-2000+64核服务器                  | CPU型号：FT-2000+<br />CPU核数：64<br />内存：镁光16G*32<br />网卡：I350 |                           |

 openEuler 20.03LTS SP1版本交付需求列表如下：

详见：<https://gitee.com/openeuler/release-management/blob/master/openEuler-20.03-LTS-SP1/release-plan.md>

| 序号 | **需求**                                                     | **状态** | **sig组**              | **责任人**                                                   |
| ---- | ------------------------------------------------------------ | -------- | ---------------------- | ------------------------------------------------------------ |
| 1    | [openEuler 20.03 LTS SP1支持高可用pacemaker](https://gitee.com/openeuler/release-management/issues/I23GH2?from=project-issue) | Accepted | sig-HA                 | yangzhao_kl                                                  |
| 2    | [openEuler 20.03 LTS SP1支持openGauss版本](https://gitee.com/openeuler/release-management/issues/I23GGW?from=project-issue) | Accepted |                        |                                                              |
| 3    | [openEuler 20.03 LTS SP1支持1822 HBA卡驱动](https://gitee.com/openeuler/release-management/issues/I23GGR?from=project-issue) | Accepted |                        |                                                              |
| 4    | [openEuler 20.03 LTS SP1支持华为多路径](https://gitee.com/openeuler/release-management/issues/I23GGO?from=project-issue) | Accepted |                        |                                                              |
| 5    | [openEuler 20.03 LTS SP1支持openStack](https://gitee.com/openeuler/release-management/issues/I23GGJ?from=project-issue) | Accepted | sig-python-modules     | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 6    | [openEuler 20.03 LTS SP1支持金融领域软件包](https://gitee.com/openeuler/release-management/issues/I23GG1?from=project-issue) | Accepted | DB                     | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 7    | [openEuler 20.03 LTS SP1支持大数据管理组件Ambari的依赖组件](https://gitee.com/openeuler/release-management/issues/I23GFY?from=project-issue) | Accepted | sig-release-management | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 8    | [openEuler 20.03 LTS SP1新增DDE组件](https://gitee.com/openeuler/release-management/issues/I23GFR?from=project-issue) | Accepted | sig-DDE                | [\@panchenbo](https://gitee.com/panchenbo)                   |
| 9    | [openEuler 20.03-LTS版本新增criu组件](https://gitee.com/openeuler/release-management/issues/I23GFP?from=project-issue) | Accepted |                        |                                                              |
| 10   | [openEuler 20.03 LTS SP1支持libxml，hyperscan](https://gitee.com/openeuler/release-management/issues/I23GFL?from=project-issue) | Accepted | Desktop                | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 11   | [openEuler 20.03 LTS SP1同时支持openjdk多个版本](https://gitee.com/openeuler/release-management/issues/I23GFC?from=project-issue) | Accepted |                        |                                                              |
| 12   | [openEuler 20.03 SP1 虚拟化支持内存，cpu热添加](https://gitee.com/openeuler/release-management/issues/I23GF7?from=project-issue) | Accepted | Virt                   | [\@alexchen](https://gitee.com/zhendongchen)                 |
| 13   | [openEuler 20.03 SP1 “支持vmtop”](https://gitee.com/openeuler/release-management/issues/I23GF2?from=project-issue) | Accepted | Virt                   | [\@alexchen](https://gitee.com/zhendongchen)                 |
| 14   | [openEuler 20.03 LTS SP1虚拟化支持安全启动](https://gitee.com/openeuler/release-management/issues/I23GEY?from=project-issue) | Accepted | Virt                   | [\@alexchen](https://gitee.com/zhendongchen)                 |
| 15   | [openEuler 20.03 LTS SP1虚拟化支持custom模式](https://gitee.com/openeuler/release-management/issues/I23GEU?from=project-issue) | Accepted | Virt                   | [\@alexchen](https://gitee.com/zhendongchen)                 |
| 16   | [openEuler 20.03 LTS SP1回合20.09 Atune](https://gitee.com/openeuler/release-management/issues/I23GEM?from=project-issue) | Accepted |                        |                                                              |
| 17   | [openEuler 20.03 LTS SP1补充SONY使用的依赖包](https://gitee.com/openeuler/release-management/issues/I23GEG?from=project-issue) | Accepted |                        |                                                              |
| 18   | [openEuler 20.03 LTS SP1补齐pts安装依赖](https://gitee.com/openeuler/release-management/issues/I23GEC?from=project-issue) | Accepted |                        |                                                              |
| 19   | [openEuler 20.03 LTS SP1回合20.09 iSular新版本特性](https://gitee.com/openeuler/release-management/issues/I23GE8?from=project-issue) | Accepted |                        |                                                              |
| 20   | [openEuler 20.03 LTS SP1开源openEuler-rpm-config宏](https://gitee.com/openeuler/release-management/issues/I23GDZ?from=project-issue) | Accepted | Base-service           | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 21   | [openEuler 20.03 LTS SP1支持abrt组件](https://gitee.com/openeuler/release-management/issues/I23GDU?from=project-issue) | Accepted | Application            | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 22   | [openEuler 20.03 LTS SP1支持osinfo](https://gitee.com/openeuler/release-management/issues/I23GDP?from=project-issue) | Accepted | Base-service           | [\@small_leek](https://gitee.com/small_leek) [\@hht8](https://gitee.com/hht8) |
| 23   | [microcode_ctl需要回合支持x86](https://gitee.com/openeuler/release-management/issues/I1RFVK?from=project-issue) | Accepted |                        |                                                              |
| 24   | [openEuler 20.03 LTS SP1新增 raspberrypi 版本](https://gitee.com/openeuler/release-management/issues/I1RMC1?from=project-issue) | Accepted | RaspberryPi            | [\@woqidaideshi](https://gitee.com/woqidaideshi)             |
| 25   | [openEuler 20.03 LTS SP1新增UKUI组件](https://gitee.com/openeuler/release-management/issues/I1R54N?from=project-issue) | Accepted | sig_UKUI               | [\@dou33](https://gitee.com/dou33)                           |
| 26   | [openEuler 20.03 LTS SP1新增netinstall组件](https://gitee.com/openeuler/release-management/issues/I1Y26A?from=project-issue) | Accepted | sig-OS-Builder         | [\@t_feng](https://gitee.com/t_feng)                         |
| 27   | [openEuler20.03 LTS SP1版本支持飞腾 arm64架构CPU](https://gitee.com/openeuler/release-management/issues/I1RXGT?from=project-issue) | Accepted |                        |                                                              |
| 28   | [openEuler 20.03-LTS版本升级新增bcc的软件包](https://gitee.com/openeuler/release-management/issues/I1O7RM?from=project-issue) | Accepted |                        |                                                              |
| 29   | [openEuler 20.03 LTS SP1申请新增maildrop和proftpd软件包](https://gitee.com/openeuler/release-management/issues/I1TWXG?from=project-issue) | Accepted |                        |                                                              |
| 30   | [openEuler 20.03 LTS SP1内核开启config_acpi_nfit内核选项](https://gitee.com/openeuler/release-management/issues/I26KWQ?from=project-issue) | Accepted |                        |                                                              |

本次SP版本测试活动分工如下：

| **需求**             | **开发主体**    | **测试主体**            | **测试策略**                                                 |
| -------------------- | --------------- | ----------------------- | ------------------------------------------------------------ |
| 支持树莓派发布件     | sig-RaspberryPi | sig-RaspberryPi         | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试       |
| 支持UKUI桌面         | sig-UKUI        | sig-UKUI                | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
| 支持HA软件           | sig-Ha          | sig-Ha                  | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持DDE桌面          | sig-DDE         | sig-DDE                 | 验证DDE在openEuler版本上的核心功能及基本UI操作               |
| 版本其它需求         | 华为            | 华为                    | 发布范围需求的质量保障和系统整体集成能力                     |
| 支持openGauss        | openGauss       | openGauss               | 由openGauss团队基于openEuler版本进行验证                     |
| 支持华为多路径       | 华为            | 华为                    | 由华为相关团队基于openEuler版本进行验证                      |
| 支持飞腾arm64架构CPU | NA              | sig-Compatibility-Infra | 通过执行硬件兼容性测试套对飞腾FT2000+进行兼容性测试<br />系统重要组件和特性在飞腾FT2000+上的集成验证 |

# 3   版本概要测试结论

openEuler 20.03 LTS SP1版本整体测试按照release-manager团队的计划，共完成了两轮全量测试+两轮回归+一轮版本发布验收测试；其中第一轮全量测试聚焦在系统整体的基本功能集成验证，旨在识别阻塞性问题；第二轮全量测试开展版本规划新需求和各类专项测试；两轮回归重点对问题单和问题单较多模块进行重点覆盖，验证问题的修复程度。SP1版本按照测试策略完成了全量功能验证和专项测试(性能、兼容性、安全、长稳)，所有测试任务均按计划完成。本版本计划交付需求30个，实际交付30个，交付率100%，所有发布需求均验证通过。

openEuler 20.03 LTS SP1版本共发现问题197个，遗留问题6个(详见遗留问题章节)，其他问题均已修复，回归测试结果正常。版本整体质量较好。

# 4   版本详细测试结论

SP1版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器、加速器和从openEuler 20.09版本回合特性包括虚拟化CPU/MEM热插、VMtop、虚拟机安全启动、虚拟机支持VCPU custom、libcareplus特性的全量功能验证，组件和特性质量较好；

2、新增软件包通过软件包专项完成了软件包的安装卸载、编译、命令行、服务检查等测试，软件包生态补齐测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试； 

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称 | 特性质量评估 | 备注     |
| ---- | -------- | :------------------------: | -------- |
| 1    | 内核 | <font color=green>█</font> | 继承内核已有测试能力，通过使用开源测试套LTP和mmtest对内核基本功能进行测试，通过syzkaller进行fuzz测试，内核整体质量良好 |
| 2    | 容器(iSula/Docker/安全容器/系统容器/镜像) | <font color=green>█</font> | 覆盖容器领域iSula和Docker引擎，安全容器、系统容器、普通容器和容器镜像的全量功能测试，整体质量良好 |
| 3    | 编译器(gcc/jdk) | <font color=green>█</font> |对gcc/jdk组件完成开源功能测试套supertest和开源fuzz测试套csmith\jfuzz的全量覆盖，组件整体质量良好|
| 4    | vCPU热插  | <font color=green>█</font> | 虚拟机支持vCPU热插，特性用例全量测试，质量良好|
| 5    | vMEM热插  | <font color=green>█</font> | 虚拟机支持vMEM热插，特性用例全量测试，质量良好 |
| 6    | vmtop     | <font color=green>█</font> | VMTop当前仅支持aarch64，特性用例全量测试，质量良好 |
| 7    | vCPU支持Custom | <font color=green>█</font> | 虚拟机vCPU支持Custom，特性用例全量测试，质量良好 |
| 8    | 虚拟机安全启动 | <font color=green>█</font>  | 虚拟机支持安全启动，特性用例全量测试，质量良好 |
| 9 | Kunpeng加速引擎 | <font color=green>█</font> | 继承已有测试能力，加速器KAE的基本功能和性能指标满足发布标准 |
| 10 | A-Tune | <font color=green>█</font> | 操作系统性能调优引擎，特性功能用例全量测试，重点验证调优框架的功能，质量良好 |
| 11 | lm_sensors | <font color=green>█</font> | 监控CPU、主板温度的小工具，在Taishan 2280、RH2288V5、飞腾等硬件上验证功能，质量良好 |
| 12 | UKUI | <font color=green>█</font> | 经过两轮全量测试，覆盖整体核心功能、重要组件和系统插件测试，质量良好 |
| 13 | 树莓派版本 | <font color=green>█</font> | 完成功能测试，覆盖镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成硬件兼容性测试，包括树莓派3B、3B+、4B开发板的USB接口、HDMI接口、以太网接口、Wi-Fi、蓝牙的兼容性验证；完成稳定性测试，包括reboot100次自动化测试；整体质量良好 |
| 14 | 安装部署 | <font color=green>█</font> | 覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署；安装部署功能质量良好 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| 序号 | 特性名称             | 约束依赖说明                                          | 遗留问题单          |        特性质量评估        | 备注                                                         |
| :--: | -------------------- | ----------------------------------------------------- | ------------------- | :------------------------: | ------------------------------------------------------------ |
|  1   | DDE                  | <center>NA</center>                                   | <center>NA</center> | <font color=green>█</font> | 共执行两轮测试，共执行用例240条，主要覆盖了基础组件跟预装应用核心功能以及基本UI测试。发现3个问题，已经回归通过，无遗留问题。整体核心功能基本可满足使用。 |
|  2   | 支持高可用pacemaker  | <center>NA</center>                                   | <center>NA</center> | <font color=blue>▲</font>  | 共执行三轮测试，执行测试用例87条，主要覆盖HA的基本能力；在各类资源异常失效情况下的切换能力；日志收集功能及网络故障异常场景下的HA功能，通过长时间测试，稳定性良好，特性基本可用。 |
|  3   | 支持组件libcareplus  | 仅交付X86架构                                         | <center>NA</center> | <font color=blue>▲</font>  | 针对此特性完成基本功能测试，从整体测试情况来看，该特性基本可用 |
|  4   | 支持openStack        | 仅提供安装指南文档                                    | <center>NA</center> | <font color=green>█</font> | 文档资料与版本提供能力行为一致                               |
|  5   | 支持k8s              | 仅提供安装指南文档                                    | <center>NA</center> | <font color=green>█</font> | 文档资料与版本提供能力行为一致                               |
|  6   | 支持spring           | 仅提供安装指南文档                                    | <center>NA</center> | <font color=green>█</font> | 文档资料与版本提供能力行为一致                               |
|  7   | 软件包生态补齐       | <center>NA</center>                                   | <center>NA</center> | <font color=green>█</font> | 针对补齐的软件包进行安装卸载管理操作、软件包提供的命令及服务功能验证 |
|      | isula-transform      | <center>NA</center>                                   | <center>NA</center> | <font color=green>█</font> | 将docker容器转换成isula容器的工具，重点验证了工具功能和可靠性，功能主要验证全部正常和异常参数，可靠性主要关注容器的状态和容器守护进程相关的故障，组件验证充分，质量良好 |
|      | 新增criu组件         | 仅支持用户进程                                        | <center>NA</center> | <font color=green>█</font> | 新集成的开源组件，主要验证checkpoint/restore等功能能正常使用，质量良好 |
|  9   | 支持openGauss版本    | <center>NA</center>                                   | <center>NA</center> | <font color=blue>▲</font>  | 完成openGauss 1.0.1在SP1版本 arm架构下的适配，覆盖(单节点/集群)安装卸载，基本功能测试，基本可用；X86架构下未进行测试 |
|  10  | 支持1822 HBA卡驱动   | <center>NA</center>                                   | <center>NA</center> | <font color=green>█</font> | 覆盖三种FC卡形态(SP527\SP520\SP525)的基本功能，覆盖只读、只写、混合读写业务(512B-4M);进行业务异常测试、故障注入、压力等可靠性测试，16G GC标卡2.0性能达标，质量良好 |
|  11  | 支持华为多路径       | 多路径系统img文件需要通过修改grub进行账号和密码的设置 | <center>NA</center> | <font color=blue>▲</font>  | 覆盖X86架构下多路径local和san boot两种方式的安装和卸载，IO负载均衡策略及IO异常场景下的业务验证，覆盖文件系统(ext2/ext3/ext4/xfs)创建和挂载，基本可用；通过评估X86和ARM架构的实现，arm可继承X86版本的结论 |
|  13  | 支持飞腾arm64架构CPU | 飞腾服务器不支持查修你cpufreq和ipmi操作               | <center>NA</center> | <font color=green>█</font> | 通过兼容性测试套完成SP1版本在飞腾服务器上的测试；版本重要组件：容器、虚拟化和系统集成测试在飞腾服务器上执行验证；质量良好 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler 20.03 LTS SP1作为 openEuler 20.03 LTS版本的补丁版本，支持从LTS升级到对应的SP1，完成如下场景的升级验证

1、从LTS直接升级到SP1版本；

2、从LTS的月度update维护升级到SP1版本；

3、升级后系统的重启；

上述场景下，软件包升级后的功能验证、服务检查等测试；SP1版本新增软件包通过对软件直接进行安装来进行；整体升级兼容性功能正常。

### 4.2.2   南向兼容性

南向兼容性当前已经完成三款整机服务器的验证，其他整机和板卡会在SP1版本发布后持续进行测试，详细信息见下表：

| 硬件型号              | 硬件详细信息                                                 |
| --------------------- | ------------------------------------------------------------ |
| FT-2000+64核服务器    | CPU型号：FT-2000+<br />CPU核数：64<br />内存：镁光16G 2666MHZ*32<br />网卡：I350 |
| TaiShan200 2280服务器 | CPU型号：HiSilicon Kunpeng 920<br />CPU核数：128<br />内存：32G*8<br />网卡：Hi1822 |
| RH2288H V5服务器      | CPU型号：Intel(R) Xeon(R) Gold 6266C CPU@3.00GHZ<br />CPU核数：44<br />内存：12*32G<br />网卡：Hi1822 |

### 4.2.3   北向兼容性

北向兼容性整体测试按照release-manager团队的规划，SP1版本发布后会进行持续的兼容性测试，当前已完成部分见下表：

| 软件名称  | 软件版本信息 |
| --------- | ------------ |
| sysbench  | 0.4.8        |
| unixbench | 5.1.3        |
| lmbench   | 3-alpha1     |
| mysql     | 8.0.17       |
| nginx     | 1.14.2       |
| netperf   | 2.7.0        |
| hackbench | 1.0          |
| spark     | 2.3.0        |

## 4.3   专项测试结论

### 安全测试

整体安全测试覆盖：

1、linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/交付件病毒扫描

3、白盒安全测试主要通过fuzz测试实现对接口参数类和内存管理类进行覆盖；通过部署kasan版本的内核，进行syzkaller测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对编译器组件行fuzz测试

4、针对安全加固指南中的加固项，进行全量测试。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                   |
| ------------ | ------------------------------------------------------------ | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7*24小时   |
| 虚拟化长稳   | 结合Qemu ASAN地址消毒、Avocado-vt对新增特性开展长期测试      | 虚拟化组件稳定运行7*24小时 |

### 性能测试

| **指标大项 ** | **指标小项**                                                 | **指标值**              | 测试结论                                                     |
| ------------- | ------------------------------------------------------------ | ----------------------- | ------------------------------------------------------------ |
| OS基础性能    | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考LTS版本相应指标基线 | 除netperf外，其他指标持平；netperf因修复网上问题，需要增加内存屏障。<br />UDP小包场景性能下降15% |
| 虚拟化性能    | 主要对比openEuler 20.03 LTS版本评估CPU计算能力、MEM访问能力、中断虚拟化性能、磁盘IO等虚拟化基线性能测试项 | 参考LTS版本相应指标基线 | 基本持平                                                     |
| 应用场景性能  | 基于MySQL、nginx、spark三个应用场景进行性能测试              | 参考LTS版本相应指标基线 | 优于openEuler 20.03 LTS版本                                  |


# 5   问题单统计

给出版本问题单的分布或分类统计及问题单走势分析。 

openEuler 20.03 LTS SP1版本共发现问题单197个，有效问题194个，其中修复问题单188个，回归均通过。详细分布见下表:

| 测试阶段                    | 问题单数 |
| --------------------------- | -------- |
| openEuler 20.03 LTS SP1 RC1 | 85       |
| openEuler 20.03 LTS SP1 RC2 | 62       |
| openEuler 20.03 LTS SP1 RC3 | 31       |
| openEuler 20.03 LTS SP1 RC4 | 13       |
| openEuler 20.03 LTS SP1 RC5 | 5        |

整体看版本问题单收敛趋势明显。

# 6   附件

## 遗留问题列表

| 序号 | 问题单号                                                     | 问题简述                                                     | 问题级别 | 影响分析                                                     | 规避措施                                              |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------- | ------------------------------------------------------------ | ----------------------------------------------------- |
| 1    | [I26ZLO](https://gitee.com/open_euler/dashboard/issues?id=I26ZLO) | 【20.03-SP1】安装成功后，点击reboot，系统会重启偶现卡死      | 主要     | 复位过程存在卡死可能，问题仅出现一次，专项攻关未重现         | 逻辑安装配置硬件狗；虚拟机配置NMI狗。挂死时硬件狗复位 |
| 2    | [I29P84](https://gitee.com/open_euler/dashboard/issues?id=I29P84) | 【20.03-LTS-SP1】必现，安装系统到已经装过系统盘上,报错创建逻辑卷失败（和修改磁盘选择相关） | 次要     | 仅在图形安装阶段出现，不影响系统运行。先选择一块磁盘准备安装，而后选择“取消”该磁盘操作，然后选择新磁盘再进行自定义分区，此场景下anaconda无法正确识别新选磁盘信息，导致安装失败 | 重新安装直接选择要安装的磁盘                          |
| 3    | [I28N07](https://gitee.com/open_euler/dashboard/issues?id=I28N07) | 设置磁盘只读后，重新读取分区表，只读参数不生效               | 次要     | 通过blockdev设置只读无法生效。社区所有版本均存在此问题，社区正在讨论解决方案。对其他功能无影响 | 无                                                    |
| 4    | [I27TNT](https://gitee.com/open_euler/dashboard/issues?id=I27TNT) | infinite loop in fa_minus()                                  | 次要     | 被测试对象为内部接口，augeas用户配置文件编辑工具，单次使用居多，不存在后台常驻的场景。对整体稳定性影响可控 | 无                                                    |
| 5    | [I28XL7](https://gitee.com/open_euler/dashboard/issues?id=I28XL7) | 【20.03-SP1】x86/arm 物理机安装成功后，dmesg报错ib_srpt MAD registration failed for i40iw0-1 | 次要     | 网卡功能正常不受影响。Intel目前没有商业渠道，正在尝试通过社区咨询报错原因 | 无                                                    |
| 6    | [I29TET](https://gitee.com/open_euler/dashboard/issues?id=I29TET) | 【fuzz】runtime error                                        | 次要     | 对OS主题流程没有影响。libRaw未RAW文件库，在dcraw process中注入异常数据，导致整形溢出。社区以及有对应issue，开放人员明确表示不修复，持续跟踪社区进展 | 无                                                    |

 
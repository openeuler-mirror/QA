![openEuler ico](../../images/openEuler.png)

版权所有 © 2021  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ------------------ | ---------- |
| 2021/12/15 | 1.1.0    | 初始               | charlie_li |
| 2021/12/22 | 1.1.1    | 按照PR评审建议修改 | charlie_li |

关键词：

openEuler  LTS  SP3  raspberrypi  UKUI  DDE xfce kiran  HA  iSula  A-Tune stratovirt kvm qemu  docker openstack

摘要：

文本主要描述openEuler 20.03-LTS-SP3版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

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

\***

# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 20.03-LTS-SP3版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 20.03-LTS-SP3版本是20.03-LTS的补丁版本，发布范围相较20.03-LTS、20.03-LTS-SP1和20.03-LTS-SP2版本主要变动如下：

1. 回合openEuler创新版本中部分特性：

   容器OS、支持云原生集群部署eggo解决方案、内存分级扩展

2. 新增特性：

   支持kiran桌面环境/内存UCE故障增强/支持OpenStack T版本/支持openstack kolla/定制裁剪工具套件oemaker

4. 修复bug和cve

openEuler 20.03-LTS-SP3版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称                    | 测试起始时间 | 测试结束时间 |
| --------------------------- | ------------ | ------------ |
| openEuler 20.03 LTS SP3 RC1 | 2021-11-25   | 2021-11-30   |
| openEuler 20.03 LTS SP3 RC2 | 2021-12-2    | 2021-12-8    |
| openEuler 20.03 LTS SP3 RC3 | 2021-12-10   | 2021-12-15   |
| openEuler 20.03 LTS SP3 RC4 | 2021-12-17   | 2021-12-23   |
| openEuler 20.03 LTS SP3 RC5 | 2021-12-25   | 2021-12-27   |

测试的硬件环境如下：

| 硬件型号                            | 硬件配置信息                                                 | 备注                      |
| ----------------------------------- | ------------------------------------------------------------ | ------------------------- |
| TaiShan 200 2280均衡型              | Kunpeng 920-4826\*2  <br />32G*4 2933MHz<br />LSI SAS3508<br />TM210 |                           |
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

openEuler 20.03-LTS-SP3版本交付需求列表如下：

详见：[https://gitee.com/openeuler/release-management/blob/master/openEuler-20.03-LTS-SP3/release-plan.md](https://gitee.com/openeuler/release-management/blob/master/openEuler-20.03-LTS-SP3/release-plan.md)

| **no** | **feature**                                                  | **status** | **sig**                 | **owner**                                      |
| ------ | ------------------------------------------------------------ | ---------- | ----------------------- | ---------------------------------------------- |
| 1      | openEuler 20.03 LTS SP3 OpenStack Kolla supports openEuler OS | Accepted   | sig-openstack           | xiyuanwang                                     |
| 2      | openEuler 20.03 LTS SP3 支持Kiran桌面环境                    | Accepted   | sig-KIRAN-DESKTOP       | [tangjie02](https://gitee.com/tangjie02)       |
| 3      | openEuler 20.03 LTS SP3 Supports OpenStack Train             | Accepted   | sig-openstack           | [huangtianhua](https://gitee.com/huangtianhua) |
| 4      | openEuler 20.03-LTS SP3 新增容器OS支持                       | Accepted   | sig-CloudNative         | [liyuanrong](https://gitee.com/li-yuanrong)    |
| 5      | openEuler 20.03-LTS SP3 新增轻量级安全容器支持               | Accepted   | sig-CloudNative         | wujing                                         |
| 6      | [openEuler 20.03 LTS SP3 eggo支持k8s在X86和ARM64双平面部署](https://e.gitee.com/open_euler/issues/list?issue=I4G9ZJ) | Accepted   | sig-CloudNative         | [liuhao](https://gitee.com/duguhaotian)        |
| 7      | openEuler 20.03-LTS SP3 新增内存分级扩展                     | Accepted   | Storage                 | [louhongxiang](https://gitee.com/louhongxiang) |
| 8      | [openEuler 20.03-LTS SP3 新增定制裁剪工具套件oemaker](https://e.gitee.com/open_euler/issues/list?issue=I4GA13) | Accepted   | sig-OS-Builder          | zhuchunyi                                      |
| 9      | [openEuler 20.03 LTS SP3 内核特性增强](https://e.gitee.com/open_euler/issues/list?issue=I4GAUL) | Accepted   | sig-kernel              | [gatieme](https://gitee.com/gatieme)           |
| 10     | [openEuler 20.03 LTS SP3 官网上线北向兼容性清单](https://e.gitee.com/open_euler/issues/list?issue=I4GATR) | Accepted   | sig-Compatibility-Infra | [lovelijunyi](https://gitee.com/lovelijunyi)   |
| 11     | [openEuler 20.03 LTS SP3 支持intel ice lake](https://e.gitee.com/open_euler/issues/list?issue=I4GASF) | Accepted   | sig-kernel              | [gatieme](https://gitee.com/gatieme)           |
| 12     | [openEuler 20.03 LTS SP3 支持树莓派](https://gitee.com/openeuler/release-management/issues/I4HRUR) | Accepted   | sig-RaspberryPi         | [woqidaideshi](https://gitee.com/woqidaideshi) |
| 13     | openEuler 20.03-LTS SP3 智能调优A-tune扩展增强               | Accepted   | A-Tune                  | [hanxinke](https://gitee.com/hanxinke)         |

本次SP3版本测试活动分工如下：

| **需求**                     | **开发主体**      | **测试主体**      | **测试策略**                                                 |
| ---------------------------- | ----------------- | ----------------- | ------------------------------------------------------------ |
| 支持树莓派发布件             | sig-RaspberryPi   | sig-RaspberryPi   | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试       |
| 支持UKUI桌面                 | sig-UKUI          | sig-UKUI          | 验证UKUI桌面系统在openEuler版本上的可安装和桌面各类应用的基本功能 |
| 支持HA软件                   | sig-Ha            | sig-Ha            | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持DDE桌面                  | sig-DDE           | sig-DDE           | 验证DDE在openEuler版本上的核心功能及基本UI操作               |
| 支持XFCE桌面                 | sig-xfce          | sig-xfce          | 验证XFCE桌面重要系统组件和插件的功能完整性                   |
| 支持openstack Train版本      | sig-openstack     | sig-openstack     | 验证openstack各个组件的基本功能                              |
| openstack kolla支持openEuler | sig-openstack     | sig-openstack     | 验证openstack(R&Q)版本上kolla组件在openEuler版本上的可安装、及其对其他组件的镜像制作及部署openstack集群的能力 |
| 支持加速库                   | sig-Kae           | sig-kae           | 验证硬件加速库的基本功能和性能指标                           |
| 支持Kiran桌面环境            | sig-KIRAN-DESKTOP | sig-KIRAN-DESKTOP | 验证kiran桌面在openEuler版本上的可安装，桌面主要应用插件的功能及操作完整性 |
| 版本其它需求                 | sig-QA            | sig-QA            | 发布范围需求的质量保障和系统整体集成能力                     |

# 3   版本概要测试结论

   openEuler 20.03 LTS SP3版本整体测试按照release-manager团队的计划，共完成了一轮重点特性测试+两轮全量测试+一轮回归测试+版本发布验收测试；其中第一轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫面及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；另外两轮全量测试开展版本交付的所有特性和各类专项测试；一轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。SP3版本按照测试策略完成了全量功能验证和专项测试(性能、可靠性、兼容性、安全)，所有测试任务均按计划完成。本版本计划交付需求48个，实际交付48个，交付率100%，所有发布需求均验证通过。

​    openEuler 20.03 LTS SP3版本共发现问题137个，有效问题127个，遗留问题2个(详见遗留问题章节)，其他问题均已修复，回归测试结果正常。版本整体质量较好。

# 4   版本详细测试结论

SP3版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从创新版本回合特性包括容器OS、支持云原生集群部署eggo解决方案、内存分级扩展等特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试；

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                             |        特性质量评估        | 备注                                                                                                                   |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
| 1    | 内核                                      | <font color=green>█</font> | 继承内核已有测试能力，通过使用开源测试套LTP和mmtest对内核开展基本功能进行测试；并通过构建地址消毒的内核版本利用syzkaller开源测试套进行fuzz测试；通过构建系统压力，反复长时间随机执行LTP基本系统调用，对内核开展7*24小时的稳定性测试，整体用例执行通过；内核整体质量良好 |
| 2    | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | 覆盖容器领域iSula和docker引擎的基本能力，针对安全容器、系统容器、普通容器和容器镜像进行功能/可靠性/稳定性测试，共执行用例742个，用例执行全部通过，整体质量良好 |
| 3    | 编译器(gcc/jdk)                           | <font color=green>█</font> | 对gcc/jdk组件完成开源功能测试套supertest和开源fuzz测试套csmith\jfuzz的全量覆盖，另外使用SEPCjbb2015对jdk开展性能max-jOPS和critical-jOPS项的测试，性能指标和前面发布SP版本持平，编译器组件整体质量良好 |
| 4 | 虚拟化(qemu/stratovirt) | <font color=green>█</font> | 继承已有测试能力，覆盖虚拟化组件(qemu&stratovirt)的基本功能、可靠性、稳定性及场景测试，使用开源的测试套tp-libvirt和tp-qemu开展各类测试，整体质量良好 |
| 5   | Kunpeng加速引擎                           | <font color=green>█</font> | 继承已有测试能力，完成加速器KAE的基本功能和性能指标验证，共计执行用例176个，全部执行通过，满足发布标准                                |
| 6  | A-Tune                                    | <font color=green>█</font> | A-Tune作为操作系统性能调优引擎，完成特性查询负载类型、分析负载类型并自优化、自调优以及模型训练输入数据集的训练等功能用例全量测试，并从高压力负载和长时间运行两个方面对A-Tune功能进行验证，共计执行用例123个，特性整体质量良好 |
| 7 | 支持kubeOS | <font color=green>█</font> | 继承已有测试能力，共执行用例14条，覆盖基本功能、测试配置测试、安全及性能测试，特性整体风险较小，质量良好 |
| 8  | 支持UKUI桌面                              | <font color=green>█</font> | 共执行两轮测试，覆盖UKUI桌面的核心功能、重要组件及系统插件的测试，共计执行用例62条，整体质量良好                                                                |
| 9 | 支持DDE桌面 | <font color=green>█</font> | 共执行两轮测试，共执行用例240条，主要覆盖了基础组件跟预装应用核心功能以及基本UI测试。发现3个问题，已经回归通过，无遗留问题。整体核心功能基本可满足使用。 |
| 10 | 支持高可用pacemaker | <font color=green>█</font> | 共执行三轮测试，执行测试用例87条，主要覆盖HA的基本能力；在各类资源异常失效情况下的切换能力；日志收集功能及网络故障异常场景下的HA功能，通过长时间测试，稳定性良好，特性基本可用。 |
| 11 | 支持eggo | <font color=green>█</font> | 执行测试用例18条，覆盖eggo提供的对K8S集群的部署、销毁、节点加入及删除的功能 |
| 12  | 树莓派                              | <font color=green>█</font> | 对树莓派镜像进行安装、基本功能、管理工具、硬件兼容性和稳定性测试；共执行用例85条，整体质量良好                                                                 |
| 13 | 支持内存分级扩展 | <font color=green>█</font> | 共计执行90个用例，覆盖范围包括特性的功能、可靠性，安全和性能；整体质量良好<br/>约束：1、客户端和服务端需要在同一个服务器上部署，不支持跨服务器通信的场景<br/>2、仅支持扫描进程名小于或等于15个字符长度的目标进程 |
| 14 | 集成secgear组件 | <font color=green>█</font> | 共计执行100个用例，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试；质量良好 |
| 15 | 支持xfce桌面 | <font color=green>█</font> | 共经过两轮测试，执行103个测试项，整体核心功能(重要组件和系统插件)稳定正常，整体质量良好 |
| 16 | 集成Kubernetes 1.18及其相关依赖组件 | <font color=blue>▲</font> | 共执行311个用例，主要覆盖了功能一致性测试，架构x86和arm均测试通过；整体功能基本可用<br/>后续建议：增加对Kubernetes各组件的底噪消耗和稳定性测试 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称**                 | **测试覆盖情况**                                             | **约束依赖说明** | **遗留问题单** | **质量评估**               | **备注<img width=50/>**                                      |
| -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1        | 支持Kiran桌面                | 覆盖kiran桌面在SP3版本上的安装卸载；并重点覆盖桌面提供的重要组件、核心能力及插件的测试，共执行用例60条 | NA               | NA             | <font color=blue>▲</font>  | 后续建议关注下桌面的底噪性能                                 |
| 2        | 支持OpenStack Train版本      | 覆盖T版本提供组件的API和功能测试，并通过tempest测试套完成集成验证和长稳测试；共计执行用例1064条 | NA               | NA             | <font color=blue>▲</font>  | cyborg组件在T版本上可安装使能，但部分功能不可用问题跟踪上游社区进展情况；<br />后续关注组件的性能测试 |
| 3        | openstack Kolla支持openEuler | 覆盖kolla组件提供的制作镜像和部署R版本和Q版本集群的能力，另外对R版本和Q版本分别执行用例1096和1109条，覆盖接口和基本功能 | NA               | NA             | <font color=green>█</font> | R版本和Q版本中明确废弃的功能接口不在本次覆盖范围             |
| 4        | 定制裁剪工具套件oemaker      | 覆盖裁剪工具的基本命令功能，并对异常参数进行覆盖；另外对裁剪出来的镜像进行安装部署及基本验证，保障裁剪工具的E2E能力完整性 | NA               | NA             | <font color=green>█</font> |                                                              |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler 20.03-LTS-SP3作为 openEuler 20.03-LTS版本的补丁版本，支持从LTS\ LTS SP1\LTS SP2版本升级到对应的SP3，完成如下场景的升级验证

1、从LTS直接升级到SP3版本

2、从LTS SP1直接升级到SP3版本

3、从LTS SP2直接升级到SP3版本

4、从LTS的月度update维护升级到SP3版本

5、从LTS SP1的月度update维护升级到SP3版本

6、从LTS SP2的月度update维护升级到SP3版本

7、升级后系统的重启

上述场景下，软件包升级后的功能验证、服务检查等测试；新增软件包通过对软件直接进行安装来进行；整体升级兼容性功能正常。

### 4.2.2   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，SP3版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成53类芯片，170张板块的测试，完成兼容性测试的硬件信息详见链接：openeuler.org/zh/compatibility;

下表列出版本集成验证中涉及的硬件整机信息：

| 硬件型号              | 硬件详细信息                                                                                          |
| --------------------- | ----------------------------------------------------------------------------------------------------- |
| FT-2000+64核服务器    | CPU型号：FT-2000+<br />CPU核数：64<br />内存：镁光16G 2666MHZ*32<br />网卡：I350                      |
| TaiShan200 2280服务器 | CPU型号：HiSilicon Kunpeng 920<br />CPU核数：128<br />内存：32G*8<br />网卡：Hi1822                   |
| RH2288H V5服务器      | CPU型号：Intel(R) Xeon(R) Gold 6266C CPU@3.00GHZ<br />CPU核数：44<br />内存：12*32G<br />网卡：Hi1822 |

### 4.2.3   北向兼容性

北向兼容性整体测试按照release-manager团队的规划，SP3版本发布后会进行持续的兼容性测试。从archlinux当前已完成部分见下表：

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

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/编译选项扫描/交付件病毒扫描

3、白盒安全测试主要通过fuzz测试实现对接口参数类和内存管理类进行覆盖；通过部署kasan版本的内核，进行syzkaller测试；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对编译器组件行fuzz测试；

4、针对安全加固指南中的加固项，进行全量测试。

整体OS安全测试较充分，风险可控。

### 可靠性测试

| 测试类型     | 测试内容                                                                               | 测试结论                   |
| ------------ | -------------------------------------------------------------------------------------- | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7*24小时   |
| 虚拟化长稳   | 结合Qemu ASAN地址消毒、Avocado-vt对新增特性开展长期测试                                | 虚拟化组件稳定运行7*24小时 |

### 性能测试

| **指标大项 ** | **指标小项**                                                 | **指标值**                        | 测试结论                 |
| ------------- | ------------------------------------------------------------ | --------------------------------- | ------------------------ |
| OS基础性能    | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考LTS、SP1及SP2版本相应指标基线 | 相比SP2版本有1%提升      |
| 虚拟化性能    | 主要评估CPU计算能力、MEM访问能力、中断虚拟化性能、磁盘IO等虚拟化基线性能测试项 | 参考LTS、SP1及SP2版本相应指标基线 | 基本持平                 |
| 特性性能      | 内存分级扩展特性在MySQL场景下，内存节省达到50%，性能下降不超过15%<br/>虚拟机热迁移速度较单通道迁移提升20%<br/>stratovirt极简配置下内存底噪<5M,启动速度<50ms | 参考特性相应性能指标              | 性能规格满足需求指标要求 |

# 5   问题单统计

openEuler 20.03-LTS-SP3版本共发现问题单137个，有效问题127个，其中修复问题单125个，回归均通过。详细分布见下表:

| 测试阶段                    | 问题单数 |
| --------------------------- | -------- |
| openEuler 20.03 LTS SP2 RC1 | 73       |
| openEuler 20.03 LTS SP2 RC2 | 37       |
| openEuler 20.03 LTS SP2 RC3 | 20       |
| openEuler 20.03 LTS SP2 RC4 | 6        |
| openEuler 20.03 LTS SP2 RC5 | 1        |

整体看版本问题单收敛趋势明显。

# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述                                                     | 问题级别 | 影响分析                                                     | 规避措施 |
| ---- | -------- | ------------------------------------------------------------ | -------- | ------------------------------------------------------------ | -------- |
| 1    | I4JWN5   | **【20.03 SP3】【arm/x86 物理机】选择中文安装未完全生效，有一部分英文一部分中文的情况** | 次要     | 根因：<br />低版本未提供对英文的翻译支持<br />影响：<br />不影响具体功能，只在安装图形界面网络选项配置界面汉化显示不友好 | 版本遗留 |
| 2    | I4JLFHI  | **【openEuler 20.03 SP3 Test round 2 】【x86/arm】【日历】节日信息显示异常** | 次要     | 影响：<br />日历显示上的问题，不影响其他功能，影响可控       | 版本遗留 |

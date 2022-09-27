![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ------------------ | ---------- |
| 2022/9/5 | 1.0.0    | 初始, 基于RC1/2/3   | disnight |
| 2022/9/14| 1.0.1    | 修改模板部分2209问题 | disnight |
| 2022/9/16 | 1.1.0 | 基于RC4的测试情况进行分析 | disnight |
| 2022/9/27 | 1.2.0 | 基于RC5的测试情况进行分析 | zjl_long |

关键词：

openEuler raspberrypi UKUI DDE xfce gnome kiran Cinnamon HA iSula A-Tune stratovirt kvm qemu docker openstack secpaver secgear aops

摘要：

文本主要描述openEuler 22.09 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.09版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 22.09版本是22年首个创新版本，承载了一年内社区孵化的各项新特性，该版本基于master分支拉出，发布范围相较21.09和22.03 LTS版本主要变动：

1. 软件包选型升级
2. 新增软件：OpenStack Yoga及其部属攻击opensd，Cinnamon桌面，备份还原功能，支持pod带宽管理，磁盘智能多流，新增机密计算switchless特性
3. 修复bug和cve

openEuler 22.09 版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称                 | 测试起始时间 | 测试结束时间 | 备注 |
| ----------------------- | ------------ | ------------ | --- | 
| openEuler 22.09 RC1(计划) | 2022-08-01 | 2022-08-07 | |
| openEuler 22.09 RC1(实际) | 2022-08-08(延期7天) | 2022-08-14 | |
| openEuler 22.09 RC2(计划) | 2022-08-11 | 2022-08-17 | |
| openEuler 22.09 RC2(实际) | 2022-08-18(延期7天) | 2022-08-25 | |
| openEuler 22.09 RC3(计划) | 2022-08-23 | 2022-08-29 | |
| openEuler 22.09 RC3(实际) | 2022-08-30(延期7天) | 2022-09-05 | |
| openEuler 22.09 RC4(计划) | 2022-09-02 | 2022-09-08 | |
| openEuler 22.09 RC4(实际) | 2022-09-08(延期6天) | 2022-09-14 | |
| openEuler 22.09 RC5(计划) | 2022-09-12 | 2022-09-18 | |
| openEuler 22.09 RC5(实际) | 2022-09-19(延期7天) | 2022-09-23 | |

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

> 当前社区release分为以下几种方式: 社区repo-OS/everything/Epol/独立镜像，oepkgs(软件所仓库)，sig独立发布(各sig自定义发布链接提供至release-sig)

本次版本测试活动分工如下：

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

# 3 版本概要测试结论

   openEuler 22.09 版本整体测试按照release-manager团队的计划，共完成了一轮重点特性测试+三轮全量测试+一轮回归测试+版本发布验收测试；其中第一轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫描及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；另外三轮全量测试开展版本交付的所有特性和各类专项测试；一轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

​   openEuler 22.09 版本共发现问题 467 个，有效问题 430 个，已取消问题 37 个。遗留问题 7 个(详见遗留问题章节)，其他问题均已修复，回归测试结果正常。版本整体质量较好。

# 4 版本详细测试结论

openEuler 22.09 版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚（该版本不涉及）、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试；

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
| 1 | 内核 | <font color=green>█</font> | 继承内核已有测试能力，通过使用开源测试套LTP和mmtest对内核开展基本功能进行测试；并通过构建地址消毒的内核版本利用syzkaller开源测试套进行fuzz测试；通过构建系统压力，反复长时间随机执行LTP基本系统调用，对内核开展7*24小时的稳定性测试，整体用例执行通过；内核整体质量良好 |
| 2 | 容器(isula/docker/安全容器/系统容器/镜像） | <font color=green>█</font> | 覆盖容器领域iSula和docker引擎的基本能力，针对安全容器、系统容器、普通容器和容器镜像进行功能/可靠性/稳定性测试，共执行用例742个，用例执行全部通过，整体质量良好 |
| 3 | [编译器(gcc/jdk)](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACGCC%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 对gcc/jdk组件完成开源功能测试套supertest和开源fuzz测试套csmith\jfuzz的全量覆盖，另外使用SEPCjbb2015对jdk开展性能max-jOPS和critical-jOPS项的测试，编译器组件整体质量良好 |
| 4 | [虚拟化(qemu/stratovirt)](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACStratoVirt%202.0%E6%94%AF%E6%8C%81%E4%BA%91%E5%9C%BA%E6%99%AF%E6%A0%87%E5%87%86%E8%99%9A%E6%8B%9F%E5%8C%96%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 继承已有测试能力，覆盖虚拟化组件(qemu&stratovirt)的基本功能、可靠性、稳定性及场景测试，使用开源的测试套tp-libvirt和tp-qemu开展各类测试，整体质量良好 |
| 5 | Kunpeng加速引擎 | <font color=green>█</font> | 继承已有测试能力，完成加速器KAE的基本功能和性能指标验证，共计执行用例176个，全部执行通过，满足发布标准 |
| 6 | [A-Tune](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACA-Tune%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | A-Tune作为操作系统性能调优引擎，完成特性查询负载类型、分析负载类型并自优化、自调优以及模型训练输入数据集的训练等功能用例全量测试，并从高压力负载和长时间运行两个方面对A-Tune功能进行验证，共计执行用例123个，特性整体质量良好 |
| 7 | [支持kubeOS](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACKubeOS%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A%E6%A8%A1%E6%9D%BF.md) | <font color=green>█</font> | 继承已有测试能力，共执行用例14条，覆盖基本功能、测试配置测试、安全及性能测试，特性整体风险较小，质量良好 |
| 8 | [支持UKUI桌面](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler-22.09%E7%89%88%E6%9C%ACUKUI%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共执行两轮测试，覆盖UKUI桌面的核心功能、重要组件及系统插件的测试，共计执行用例62条，整体质量良好 |
| 9 | [支持DDE桌面](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共执行两轮测试，共执行用例240条，主要覆盖了基础组件跟预装应用核心功能以及基本UI测试。发现3个问题，已经回归通过，无遗留问题。整体核心功能基本可满足使用。 |
| 10 | [支持xfce桌面](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler-22.09%E7%89%88%E6%9C%ACxfce%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共经过两轮测试，执行103个测试项，整体核心功能(重要组件和系统插件)稳定正常，整体质量良好 |
| 11 | [支持gnome桌面](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler-22.09%E7%89%88%E6%9C%ACgnome%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共经过两轮测试，执行201个测试项，整体核心功能(重要组件和系统插件)稳定正常，整体质量良好 |
| 12 | [支持OpenStack Train版本](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/%20openEuler%2022.09%E7%89%88%E6%9C%ACOpenStack%20Yoga%20+%20OpenSD%20+%20%E8%99%9A%E6%8B%9F%E6%9C%BA%E9%AB%98%E4%BD%8E%E4%BC%98%E5%85%88%E7%BA%A7%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 覆盖T版本提供组件的API和功能测试，并通过tempest测试套完成集成验证和长稳测试；共计执行用例1161条 |
| 13 | [支持高可用pacemaker](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACHA%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共执行三轮测试，执行测试用例87条，主要覆盖HA的基本能力；在各类资源异常失效情况下的切换能力；日志收集功能及网络故障异常场景下的HA功能，通过长时间测试，稳定性良好，特性基本可用。 |
| 14 | 支持eggo | <font color=green>█</font> | 执行测试用例18条，覆盖eggo提供的对K8S集群的部署、销毁、节点加入及删除的功能 |
| 15  | [树莓派](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%AC%E6%A0%91%E8%8E%93%E6%B4%BE%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A) | <font color=green>█</font> | 对树莓派镜像进行安装、基本功能、管理工具、硬件兼容性和稳定性测试；共执行用例85条，整体质量良好 |
| 16 | 支持内存分级扩展 | <font color=green>█</font> | 共计执行90个用例，覆盖范围包括特性的功能、可靠性，安全和性能；整体质量良好<br/>约束：1、客户端和服务端需要在同一个服务器上部署，不支持跨服务器通信的场景<br/>2、仅支持扫描进程名小于或等于15个字符长度的目标进程 |
| 17 | [集成secgear组件](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACsecGear%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 共计执行100个用例，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试；质量良好 |
| 18 | 定制裁剪工具套件oemaker | <font color=green>█</font> | 覆盖裁剪工具的基本命令功能，并对异常参数进行覆盖；另外对裁剪出来的镜像进行安装部署及基本验证，保障裁剪工具的E2E能力完整性 |
| 19 | 南向芯片厂商适配 | <font color=green>█</font> |  对AMD(milan EPYC 7003)、飞腾(FT2000+、FT2500)、海光(71xx、72xx)、Intel(icelake)、申威(SW3231)、兆芯(KX-6640A)等厂商，覆盖[整机兼容性测试](https://gitee.com/openeuler/oec-hardware)和[社区集成测试](https://gitee.com/openeuler/mugen) |
| 20 | [GCC自动反馈优化相关软件包引入及优化效果增强](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACGCC%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 通过dejagnu、bstest、llvmcase、codedb等测试套覆盖基础功能，通过HPC应用范围软件编译验证自动反馈优化特性，保证编译器整体核心功能正常稳定 |
| 21 | openGauss默认集成到openEuler操作系统中 | <font color=green>█</font> | 共执行用例28423条，5个测试套覆盖基础功能中接入层，SQL层、存储层、管理和安全等维护的测试，其余从可靠性、性能、工具和兼容性四个维护覆盖生态测试 |
| 22 | [新增支持容器场景在离线混合部署(rubik)](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACskylark%E8%99%9A%E6%8B%9F%E6%9C%BA%E6%B7%B7%E5%90%88%E9%83%A8%E7%BD%B2%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 测试覆盖接口、功能场景、可靠性和安全。重点结合容器场景验证了在线对离线业务的抢占，以及混部情况下的调度优先级测试。 |
| 23 | StratoVirt安全容器支持直通设备热插拔 | <font color=green>█</font> | 验证接口功能、可靠性。重点覆盖设备在压力背景下热插后能够正常使用，热拔后是否有残留，以及热插拔后的容器生命周期验证。 | 
| 24 | libcareplus提供Qemu热补丁能力 | <font color=green>█</font> | 验证了热补丁框架升级、回退功能，以及升级、回退后的虚拟机生命周期，同时验证了连续升级回退、故障中断等可靠性场景。 |
| 25 | 新增支持gazelle高性能用户态协议栈 | <font color=green>█</font> | 共执行了2轮全量测试，覆盖了gazella安装部署、命令行接口和配置文件接口测试，重点测试转发业务流和性能规格场景，并结合网络发包仪打流和故障进行长稳验证。 |
| 26 | [支持OpenStack Wallaby版本](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/%20openEuler%2022.09%E7%89%88%E6%9C%ACOpenStack%20Yoga%20+%20OpenSD%20+%20%E8%99%9A%E6%8B%9F%E6%9C%BA%E9%AB%98%E4%BD%8E%E4%BC%98%E5%85%88%E7%BA%A7%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 覆盖W版本提供组件的API和功能测试，并通过tempest测试套完成集成验证和长稳测试；共计执行用例1161条 |
| 27 | [支持kiran桌面](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler-22.09%E7%89%88%E6%9C%ACKiran%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 执行了66条测试用例，覆盖了系统面板、控制中心、基础组件、文件管理器caja和通知区域的功能测试，同时从系统性能和稳定性方面进行了测试 |
| 28 | [支持embedded版本](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | <font color=green>█</font> | 复用了服务器OS的测试策略，并增加上嵌入式场景单独特性测试覆盖。 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称** | **测试覆盖情况** | **约束依赖说明** | **遗留问题单** | **质量评估** | **备注<img width=50/>** |
| -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1 |[支持OpenStack Yoga版本，并且引入Helm组件](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/%20openEuler%2022.09%E7%89%88%E6%9C%ACOpenStack%20Yoga%20+%20OpenSD%20+%20%E8%99%9A%E6%8B%9F%E6%9C%BA%E9%AB%98%E4%BD%8E%E4%BC%98%E5%85%88%E7%BA%A7%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| ```OpenStack Yoga``` 版本，共计执行 ```Tempest``` 用例 ```1452``` 个，主要覆盖了 ```API``` 测试和功能测试，通过 ```7*24``` 的长稳测试，```Skip``` 用例 ```95``` 个（ ```OpenStack Yoga``` 版中已废弃的功能或接口，如Keystone V1、Cinder V1等），失败用例 ```0``` 个（FLAT网络未实际联通及存在一些超时问题），其他 ```1357``` 个用例通过，发现问题已解决，回归通过，无遗留风险，整体质量良好。 | NA | NA | NA | <font color=green>█</font> | NA |
| 2 |[正式发布联通开源的OpenStack部署工具opensd，支持OpenStack基本部署](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/%20openEuler%2022.09%E7%89%88%E6%9C%ACOpenStack%20Yoga%20+%20OpenSD%20+%20%E8%99%9A%E6%8B%9F%E6%9C%BA%E9%AB%98%E4%BD%8E%E4%BC%98%E5%85%88%E7%BA%A7%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| ```opensd```支持```Yoga```版本```mariadb、rabbitmq、memcached、ceph_client、keystone、glance、cinder、placement、nova、neutron```共10个项目的部署，发现问题已解决，回归通过，无遗留风险。 | NA | NA | NA | <font color=green>█</font> | NA |
| 3 |[发布kiran-desktop 2.3版本](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler-22.09%E7%89%88%E6%9C%ACKiran%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| Kiran2.3特性测试，共执行了85 个测试用例，主要覆盖了系统面板、开始菜单、桌面图标及功能、控制中心、基础组件、文件管理器、所有应用测试、同时进行了性能测试和LTP7*24小时的稳定性测试。经测试发现的问题都已解决，回归通过，无遗留风险，整体质量良好 | NA | NA | NA | <font color=green>█</font> | NA |
| 4 |[支持树莓派](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%AC%E6%A0%91%E8%8E%93%E6%B4%BE%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A)| 树莓派镜像版本测试完成了功能测试，测试范围包括镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成了硬件兼容性测试，包括树莓派 3B、3B+、4B 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的兼容性验证。以上测试内容均未发现问题。 | NA | NA | NA | <font color=green>█</font> | NA |
| 5 |[DDE组件更新支持服务器场景优化](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| DDE 特性总共进行三轮轮测试，合计执行用例420条，主要覆盖了基础组件、预装应用核心功能、新增特性基础功能以及基本UI测试。整体核心功能基本可满足使用。一些比较偏的功能点跟易用性并未关注。 | NA | NA | NA | <font color=green>█</font> | NA |
| 6 |[Cinnamon桌面环境](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler-22.09%E7%89%88%E6%9C%ACCinnamon%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 软件总体评估，Cinnamon 5.2 在openEuler-22.09 版本，共经过两轮完全测试，执行53个测试项，整体核心功能稳定正常；重要组件测试中，共执行了52个测试项，第三轮测试中全部通过，第四轮测试中全部通过。1个选测因无该功能硬件阻塞未测试。 | NA | NA | NA | <font color=green>█</font> | NA |
| 7 |[新增软件更新工具支持](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| DDE 特性总共进行三轮轮测试，合计执行用例420条，主要覆盖了基础组件、预装应用核心功能、新增特性基础功能以及基本UI测试。整体核心功能基本可满足使用。一些比较偏的功能点跟易用性并未关注。 | NA | NA | NA | <font color=green>█</font> | NA |
| 8 |[新增备份还原功能支持](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| DDE 特性总共进行三轮轮测试，合计执行用例420条，主要覆盖了基础组件、预装应用核心功能、新增特性基础功能以及基本UI测试。整体核心功能基本可满足使用。一些比较偏的功能点跟易用性并未关注。 | NA | NA | NA | <font color=green>█</font> | NA |
| 9 |[【openEuler 22.09】openEuler 22.09 支持 pod带宽管理特性](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACpod%E5%B8%A6%E5%AE%BD%E7%AE%A1%E7%90%86%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| pod带宽管理，共计执行46个用例，主要覆盖了：1、命令行接口测试，包括使能/网卡Qos功能，设置cgroup优先级、在线水线、离线带宽，带宽管理信息查询，在离线业务的实时带宽检测等；2、带宽管理功能场景测试，包括普通网口、bond、vlan、bridge等多种类型网卡Qos功能测试，覆盖用户使用场景pod内的带宽抢占功能测试；3、命令行并发测试，异常流程、网卡故障以及ebpf程序篡改等故障注入测试；4、功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试。 综上，整体质量良好。 | NA | NA | NA | <font color=green>█</font> | NA |
| 10 |[[openEuler 22.09]StratoVirt 2.0支持标准虚拟化](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%ACskylark%E8%99%9A%E6%8B%9F%E6%9C%BA%E6%B7%B7%E5%90%88%E9%83%A8%E7%BD%B2%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 共执行3轮测试，测试范围主要包括基础场景、特性交互、文档检视等，累计执行用例106条，覆盖了libvirt支持stratovirt驱动、vhost-user-net、guest numa/vcpu拓扑呈现等标准虚拟化场景相关特性的基础能力，累计发现7个问题，整体质量良好。 | NA | NA | NA | <font color=green>█</font> | NA |
| 11 |[[openEuler 22.09]集成k3s边缘解决方案](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%AC%20k3s%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 使用openEuler 22.09 版本rc4 iso进行装机并下载k3s进行部署，成功在server和agent端部署，服务端可纳管agent节点。 | NA | NA | NA | <font color=green>█</font> | NA |
| 12 |[[openEuler 22.09]智能多流技术，延长ssd磁盘寿命](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler-22.09%E7%89%88%E6%9C%ACIO%E6%99%BA%E8%83%BD%E5%A4%9A%E6%B5%81%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 在当前mysql场景下进行实测，通过使用astream工具，NVMe SSD磁盘在长稳运行后期稳定保持12%的WA下降幅度，即性能较前提升12% | NA | NA | NA | <font color=green>█</font> | NA |
| 13 |[[openEuler 22.09]国密算法适配](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/%20openssl%E6%94%AF%E6%8C%81%E5%95%86%E5%AF%86%E6%96%87%E4%BB%B6%E5%AE%8C%E6%95%B4%E6%80%A7%E4%BF%9D%E6%8A%A4%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| openssl支持商密文件完整性保护，共计执行40个用例，主要覆盖了：1、原生IMA度量模式、评估模式（hash）、评估模式（签名）支持商密算法，实现文件完整性保护测试；2、IMA摘要列表评估模式、IMA摘要列表度量模式支持商密算法，实现文件内容与扩展属性的完整性保护测试；gen_digest_lists命令支持生成SM3摘要列表测试，以及手动/自动导入/删除摘要列表测试；evmctl save命令功能测试；运行度量测试、受保护文件的攻击篡改测试；自定义IMA策略导入及生效测试；各种内核策略模式和内核参数组合测试；3、轻量级入侵检测AIDE支持商密算法，检测被保护文件变化测试。综上，整体质量良好。 <br><br> KTLS及国密软件栈支持特性，共计执行17个用例，另外手动验证自动签名，手动签名，模块加载校验，从生成证书配置文件，签名私钥，签名请求以及证书，通过内核编译选项中配置使用SM3算法进行内核模块签名，以及调用sign_file对指定内核模块进行签名，在内核启动参数中添加module.sig_enforce，开启内核模块强制签名校验这些方式，主要覆盖了接口测试、功能测试，安全测试，发现问题已解决，回归通过，无遗留风险，整体质量良好。<br><br> 国密磁盘加密特性，主要覆盖了功能测试，包括测试使用SM3、SM4算法对磁盘进行加密的场景与测试安全擦除加密磁盘的场景，使用国密算法加密磁盘后进行IO操作、接口合法性测试，以及向加密磁盘下发IO命令时进行拔盘操作的故障注入。<br><br> openssl支持商密TLCP协议特性，共计执行3个用例，主要覆盖了功能测试，暂未发现问题，回归通过，无遗留风险，整体质量良好。 | NA | NA | NA | <font color=green>█</font> | NA |
| 14 |[[openEuler 22.09]libstorage高性能用户态IO](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%2022.09%E7%89%88%E6%9C%AChsak%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| HSAK特性，共执行120个测试用例，覆盖特性的基本功能、可靠性测试。无遗留风险，整体质量良好。 | NA | NA | NA | <font color=green>█</font> | NA |
| 15 |[增强embedded版本分布式软总线及混合部署能力](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.09/openEuler%202209%20embedded%E7%89%88%E6%9C%AC%E5%85%B3%E9%94%AE%E6%B7%B7%E5%90%88%E9%83%A8%E7%BD%B2%E5%A2%9E%E5%BC%BA%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| embedded版本关键混合部署增强特性实现了基于soc内实时和非实时多平面混合部署，openEuler Embedded作为主设备启动后，从核启动拉起zephyr实时系统，完成了基础的Linux端与Client OS的消息通信，以及通过Linux shell命令行访问Client OS，共计执行2个用例，主要覆盖了接口测试、功能测试，整体质量良好。 <br><br> embedded版本分布式软总线增强特性实现多个设备之间的通信，通过群组管理的方式让设备与设备之间实现认证和连通，并继承了330的软总线需求，在标准以太网和无线局域网两种连接方式下，是实现了多设备之间的发现、连接和数据传输，设备互通互联，设备之间可以正常通信，验证了认证模块和IPC模块支持多client的有效性，共计执行3个用例，主要覆盖了接口测试、功能测试，整体质量良好。<br><br>  embedded版本支持硬实时特性实现了硬实时特性要求，在适配硬件后编译成功可烧写到开发板中，适配RhealStone性能测试编译成功并在开发板中执行测试，测试结果上下文切换时延2us，中断时延1us。 | NA | NA | NA | <font color=green>█</font> | NA |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

创新版本不存在前序版本，不涉及前向兼容性

### 4.2.2   南向兼容性

创新版本南向兼容性暂不进行测试

### 4.2.3   北向兼容性

创新版本北向兼容性暂不进行测试

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
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7*24小时 |


### 性能测试

| **指标大项** | **指标小项** | **指标值** | **测试结论** |
| ------------- | ------------------------------------------------------------ | --------------------------------- | -------------------- |
| OS基础性能 | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考22.03 LTS版本相应指标基线 | 比较前一版本持平 |

# 5   问题单统计

openEuler 22.09 版本共发现问题 467 个，有效问题 423 个，其中修复问题单 403 个，回归均通过。详细分布见下表:

| 测试阶段 | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 |
| ----------------------- | -------- | ----------- | ---------- | -------- |
| openEuler 22.09 Alphal | 148 | 127 | 21 | 1 |
| openEuler 22.09 RC1 | 131 | 123 | 8 | 1 |
| openEuler 22.09 RC2 | 86 | 86 | 0 | 1 |
| openEuler 22.09 RC3 | 53 | 47 | 6 | 3 |
| openEuler 22.09 RC4 | 38 | 37 | 1 | 0 |
| openEuler 22.09 RC5 | 11 | 10 | 1 | 1 |

1. 为推动众测，在社区测试流程中增加Aplha测试阶段，发现127个问题，提前了问题拦截。
2. 关注构建偶现问题，占总问题数30%+。用例设计问题，环境问题比例较为平均。当前工程无法支持提供调试环境，也导致部分正向分析不足，待改进。
3. RC4仍发现部分新增功能问题，分析如下：
   * [I5QTLG](https://gitee.com/src-openeuler/trafficserver/issues/I5QTLG?from=project-issue)：因RC3问题[I5OV2X](https://gitee.com/src-openeuler/trafficserver/issues/I5OV2X?from=project-issue)解决后，方案及自验设计不完整，引入新问题
   * [I5QUWR](https://gitee.com/src-openeuler/openstack-plugin/issues/I5QUWR?from=project-issue):因工程未完整构建Epol，导致RC4发布的部分openstack包未更新发布，最新版本已解决问题
   * [I5QTFH](https://gitee.com/src-openeuler/strongswan/issues/I5QTFH?from=project-issue): 因RC3问题[I5PQZQ](https://gitee.com/src-openeuler/strongswan/issues/I5PQZQ?from=project-issue)引入sqlite后引入问题
   * [I5QU72](https://gitee.com/src-openeuler/obs-server/issues/I5QU72?from=project-issue): 因mariadb问题被阻塞，RC4才发现后续问题
   * aops新增特性相关issue
   * 社区构建问题
   * 上版本遗留问题
4. 测试过程中发现的一些质量问题：
   * gcc12导致镜像构建阻塞： gcc12作为多版本以内，依赖未做到和gcc隔离，导致依赖错误，
   * gcc导致kernel编译失败：
   * 问题整改引入新问题：
   * 工程问题：二进制包根据单包引入，未考虑源码包整体(python-nni-help)；Epol发布时未进行全量重编

# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| ---- | ------- | -------- | -------- | ------- | -------- | --------- | 


# 致谢
非常感谢以下开发者在openEuler 22.09 版本测试中做出的贡献,以下排名不分先后
[xxx](xxxx)
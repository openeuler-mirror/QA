![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ------------------ | ---------- |
| 2022/9/5 | 1.0.0    | 初始, 基于RC1/2/3   | disnight |

关键词：

openEuler raspberrypi UKUI DDE xfce gnome kiran Cinnamon HA iSula A-Tune stratovirt kvm qemu docker openstack secpaver secgear

摘要：

文本主要描述openEuler 22.09 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.09版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 22.09版本是22年收个创新版本，承载了一年内社区孵化的各项新特性，该版本基于master分支拉出，发布范围相较21.09和22.03 LTS版本主要变动：

1.  内核版本升级到5.10，默认PageSize由64K变更为4K(详情请见[TC决策-20211229](https://etherpad.openeuler.org/p/TC-meetings))
2.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS/%E7%89%88%E6%9C%AC%E5%8F%98%E6%9B%B4%E8%AF%B4%E6%98%8E.md)
3.  新增支持：openGauss/gazella/libcareplus/rubik/openStack Wallaby版本
5.  修复bug和cve

openEuler 22.09 版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称                 | 测试起始时间 | 测试结束时间 | 备注 |
| ----------------------- | ------------ | ------------ | --- | 
| openEuler 22.09 RC1(计划) | 2022-08-01 | 2022-08-07 | |
| openEuler 22.09 RC1(实际) | 2022-08-08(延期7天) | 2022-08-14 | |
| openEuler 22.09 RC2(计划) | 2022-08-11 | 2022-08-17 | |
| openEuler 22.09 RC2(实际) | 2022-08-18(延期7天) | 2022-08-17 | |
| openEuler 22.09 RC3(计划) | 2022-08-23 | 2022-08-29 | |
| openEuler 22.09 RC3(实际) | 2022-08-30(延期7天) | 2022-09-05 | |
| openEuler 22.09 RC4(计划) | 2022-09-02 | 2022-09-08 | |
| openEuler 22.09 RC4(实际) | todo | todo | |
| openEuler 22.09 RC5(计划) | 2022-09-12 | 2022-09-18 | |
| openEuler 22.09 RC5(实际) | todo | todo |

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

openEuler 22.09版本交付需求列表如下：

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

   待补充

# 4 版本详细测试结论

   待补充

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| ---- | ----------------------------------------- | :-------------------------: | ---------------------------------------------------------------------------------------------------------------------- |
|||||

待补充
<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称** | **测试覆盖情况** | **约束依赖说明** | **遗留问题单** | **质量评估** | **备注<img width=50/>** |
| -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | ------------------------------------------------------------ |
| 1 |[支持OpenStack Yoga版本，并且引入Helm组件](https://gitee.com/openeuler/release-management/issues/I5BIHV)| | | | | |
| 2 |[正式发布联通开源的OpenStack部署工具opensd，支持OpenStack基本部署](https://gitee.com/openeuler/release-management/issues/I5BIM9)| | | | | |
| 3 |[发布kiran-desktop 2.3版本](https://gitee.com/openeuler/release-management/issues/I5ASLE?from=project-issue)| | | | | |
| 4 |[支持树莓派](https://gitee.com/openeuler/release-management/issues/I5BJ7W)| | | | | |
| 5 |[DDE组件更新支持服务器场景优化](https://gitee.com/openeuler/release-management/issues/I5BMO2)| | | | | |
| 6 |[Cinnamon桌面环境](https://gitee.com/openeuler/release-management/issues/I59IY0)| | | | | |
| 7 |[新增软件更新工具支持](https://gitee.com/openeuler/release-management/issues/I5BMNH)| | | | | |
| 8 |[新增备份还原功能支持](https://gitee.com/openeuler/release-management/issues/I5BMMP)| | | | | |
| 9 |[openEuler 22.09和22.03 SP1支持鲲鹏底软IO能力（存储、usb、SPI、Pcie、IIC、CXL、GPU和GPIO等）](https://gitee.com/openeuler/release-management/issues/I545LZ)| | | | | |
| 10 |[openEuler 22.09和22.03 SP1支持鲲鹏性能调优和调测调优（Rasdaemon、Ras、etm、perf、wayca-SC、Mem-kind、HCCS、Hikptool等）](https://gitee.com/openeuler/release-management/issues/I545LT)| | | | | |
| 11 |[openEuler 22.09和22.03 SP1支持鲲鹏高速网络功能（DPDK、UB、RDMA-core、ROH、Roce、NIC等）](https://gitee.com/openeuler/release-management/issues/I545LP)| | | | | |
| 12 |[openEuler 22.09和22.03 SP1支持鲲鹏加速器功能（UADK、UADK_engine、starS、SDMA、ACC等）](https://gitee.com/openeuler/release-management/issues/I545LH)| | | | | |
| 13 |[openEuler 22.09和22.03 SP1 测试工具能力（pktgen）](https://gitee.com/openeuler/release-management/issues/I545M5)| | | | | |
| 14 |[【openEuler 22.09】openEuler 22.09 支持 pod带宽管理特性](https://gitee.com/openeuler/release-management/issues/I59BQI)| | | | | |
| 15 |[[openEuler 22.09]StratoVirt 2.0支持标准虚拟化](https://gitee.com/openeuler/release-management/issues/I5BM96)| | | | | |
| 16 |[[openEuler 22.09]集成k3s边缘解决方案](https://gitee.com/openeuler/release-management/issues/I5BMD4)| | | | | |
| 17 |[[openEuler 22.09]智能多流技术，延长ssd磁盘寿命](https://gitee.com/openeuler/release-management/issues/I5BMFH)| | | | | |
| 18 |[[openEuler 22.09]国密算法适配](https://gitee.com/openeuler/release-management/issues/I5BMGZ)| | | | | |
| 19 |[[openEuler 22.09]libstorage高性能用户态IO](https://gitee.com/openeuler/release-management/issues/I5BMI3)| | | | | |
| 20 |[增强embedded版本分布式软总线及混合部署能力](https://gitee.com/openeuler/release-management/issues/I5H6DI)| | | | | |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler 22.09 作为创新版本，不会做

### 4.2.2   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成42张板卡的测试(该数目仅为测试数量，实际兼容性认证通过数量见社区[兼容性清单](https://www.openeuler.org/zh/compatibility/))

下表列出版本集成验证中涉及的硬件整机信息：

| 硬件型号 | 硬件详细信息 |
| --------------------- |------------------------------------------------------------------------------------ |
| TaiShan200 2280服务器 | CPU型号：Kunpeng 920<br />CPU核数：128<br />内存：32G*8<br />网卡：Hi1822 |
| RH2288H V5服务器| CPU型号：Intel(R) Xeon(R) Gold 6266C CPU@3.00GHZ<br />CPU核数：44<br />内存：12*32G<br />网卡：Hi1822 |
| 树莓派4B卡 | CPU:Cortex-A72 * 4 <br />内存：8GB <br />存储设备：SanDisk Ultra 16GB micro SD |
| 树莓派3B+卡 | CPU:Cortex-A53 * 4<br />内存：1GB 存储设备<br />SanDisk Ultra 16GB micro SD |
| 树莓派3B卡 | CPU:Cortex-A53 * 4 <br />内存：1GB <br />存储设备：SanDisk Ultra 16GB micro SD |
| 长城擎天服务器<br>DF723 | CPU型号：FT2000+<br>CPU核数：64<br>内存：64G<br>硬盘容量：240G |
| 联想启天台式机<br>M425-N000 | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz<br>CPU内核总数：6<br>内存容量：16G |
| FT-2000+64核服务器 | CPU型号：FT-2000+<br />CPU核数：64<br />内存：镁光16G*32<br />网卡：I350 |
| Phytium S2500/64C | CPU型号：S2500/64C <br />CPU核数：64<br />内存：16G*16 DDR4<br />网卡：I350 |
| Supermicro AS-4124GS-TNR | CPU型号：AMD EPYC 7513 32-Core Processor<br />CPU核数：32<br />内存：32G*16 DDR4<br />网卡：I350 |

### 4.2.3   北向兼容性

创新版本北向兼容性暂不考虑进行测试

## 4.3   专项测试结论

### 安全测试

待补充

### 可靠性测试

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------------------------------------------------------------------------------ | -------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； |    |
| 虚拟化长稳 | 结合Qemu ASAN地址消毒、Avocado-vt对新增特性开展长期测试 |  |


### 性能测试

| **指标大项** | **指标小项** | **指标值** | **测试结论** |
| ------------- | ------------------------------------------------------------ | --------------------------------- | -------------------- |
| OS基础性能 | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考22.03 LTS版本相应指标基线 | 比较前一版本持平 |

> 该版本未规划基础性能以外的性能需求

# 5   问题单统计

待补充

# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| ---- | ------- | -------- | -------- | ------- | -------- | --------- | 
|      |         |         |         |          |         |             |


# 致谢
非常感谢以下开发者在openEuler 22.09 版本测试中做出的贡献,以下排名不分先后
[xxx](xxxx)
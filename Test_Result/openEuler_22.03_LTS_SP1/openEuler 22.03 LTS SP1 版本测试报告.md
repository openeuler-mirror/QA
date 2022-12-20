![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节           | 修改描述   |
| ---------- | -------- | ----------------- | -------- |
| 2022/12/15 | 1.0.0    | 初稿, 基于RC1/2/3   | zjl_long |
| 2022/12/20 | 1.1.0    | 基于RC4最新测试情况，刷新报告 | zjl_long |
| 2022/12/21 | 1.2.0    | 补充测试质量分析结论 | disnight |


关键词：

openEuler raspberrypi UKUI DDE xfce gnome kiran HA iSula A-Tune stratovirt kvm qemu docker openstack secpaver secgear aops

摘要：

文本主要描述openEuler 22.03 LTS SP1 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语  | 英文全名                              | 中文解释       |
| ------ | ------------------------------------ | ------------ |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露  |
| DDE    | Deepin Desktop Environment           | 深度桌面环境    |
| vDPA   |  virtio data path acceleration       | virtio 数据路径加速 |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.03 LTS SP1 版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 22.03 LTS SP1 是基于5.10内核22.03-LTS的补丁版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 22.03 LTS-Next分支拉出，发布范围相较22.03 LTS版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP1/openEuler-22.03-LTS-SP1%20%E5%8D%87%E7%BA%A7%E9%80%89%E5%9E%8B.md)
2.  新增支持：DDE组件更新/ROS和ROS2基础版/树莓派/intel SPR/兼容HG2号和3号/openstack Train版本/KubeOS支持一体机/基于A-ops现有CVE管理能力扩展/降低secGear在空载下的CPU占用率/HybridSched虚拟机在离线混部/实时非实时系统混合部署支持树莓派/分布式软总线生态互通互联/embedded版本/generic vDPA Device/Tensorflow中Intel AMX/openEuler WSL package/Gazelle支持ceph client和rpc框架、更新kiran-desktop 到2.4版本
3.  修复bug和cve

## 2.1 版本测试计划
openEuler 22.03 LTS SP1 版本按照社区release-manager团队的计划，共规划5轮测试，详细的版本信息和测试时间如下表：

| 版本名称                 | 测试起始时间 | 测试结束时间 | 备注 |
| ----------------------- | ------------ | ------------ | --- | 
| openEuler 22.03 LTS SP1 RC1 | 2022/11/23 | 2022/11/29 | |     
| openEuler 22.03 LTS SP1 RC2 | 2022/12/2  | 2022/12/8 | |
| openEuler 22.03 LTS SP1 RC3(计划) | 2022/12/9  | 2022/12/15 | |
| openEuler 22.03 LTS SP1 RC3(实际) | 2022/12/10  | 2022/12/15 | |
| openEuler 22.03 LTS SP1 RC4 | 2022/12/16 | 2022/12/22 |  |
| openEuler 22.03 LTS SP1 RC5 | 2022/12/23 | 2022/12/29 |  |
| openEuler 22.03 LTS SP1 Release | 2022/12/30 | 2022/12/30 | |

## 2.2 测试硬件信息
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

## 2.3 需求清单

openEuler 22.03 LTS SP1版本交付[需求列表](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP1/release-plan.md)如下：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|[I5RDEG](https://gitee.com/openeuler/release-management/issues/I5RDEG) | DDE组件更新支持服务器场景优化 | Accepted | sig-DDE | [@weidongkl](https://gitee.com/weidongkl) [@panchenbo](https://gitee.com/panchenbo) | EPOL |     |
|[I5RDGW](https://gitee.com/openeuler/release-management/issues/I5RDGW)|新增软件更新工具支持|Accepted|sig-DDE|[@weidongkl](https://gitee.com/weidongkl) [@panchenbo](https://gitee.com/panchenbo)|EPOL|deepin-upgrade-tool|
|[I5RDJS](https://gitee.com/openeuler/release-management/issues/I5RDJS)|新增备份还原功能支持|Accepted|sig-Migration|[@blueblue](https://gitee.com/blublue)|EPOL|ubackup|
|[I5T3MB](https://gitee.com/openeuler/release-management/issues/I5T3MB)|新增ROS基础版和ROS2基础版|Accepted|sig-ROS|[@anchuanxu](https://gitee.com/anchuanxu) [@xiao_yun_wang](https://gitee.com/xiao_yun_wang) [@wuwei_plct](https://gitee.com/wuwei_plct)|EPOL|ros_comm ros_base|
|[I5TT8E](https://gitee.com/openeuler/release-management/issues/I5TT8E)|发布kiran-desktop 2.4版本|Accepted|sig-KIRAN-DESKTOP|[@tangjie02](https://gitee.com/tangjie02)|EPOL|kiran-control-panel,kiran-cc-daemon,kiran-qt5-integration,kiran-session-manager,kiran-log|
|[I5U6JV](https://gitee.com/openeuler/release-management/issues/I5U6JV)|支持树莓派|Accepted|sig-RaspberryPi|[@woqidaideshi](https://gitee.com/woqidaideshi)|EPOL|raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom|
|[I5Y11K](https://gitee.com/openeuler/release-management/issues/I5Y11K)|openEuler 22.03 LTS SP 南向兼容：支持intel SPR|Accepted|sig-Compatibility-Infra||ISO|kernel,gcc|
|[I5Y16U](https://gitee.com/openeuler/release-management/issues/I5Y16U)|兼容HG2号和3号|Accepted|sig-Compatibility-Infra||ISO||
|[I5Y18K](https://gitee.com/openeuler/release-management/issues/I5Y18K)|支持openstack Train版本|Accepted|sig-openstack||EPOL||
|[I5Y1CR](https://gitee.com/openeuler/release-management/issues/I5Y1CR)|KubeOS支持一体机|Accepted|Kernel||EPOL||
|[I5Y1DS](https://gitee.com/openeuler/release-management/issues/I5Y1DS)|基于A-ops现有CVE管理能力扩展|Accepted|sig-ops||EPOL||
|[I5Y1HK](https://gitee.com/openeuler/release-management/issues/I5Y1HK)|降低secGear在空载下的CPU占用率|Accepted|Kernel||ISO||
|[I5Y1I8](https://gitee.com/openeuler/release-management/issues/I5Y1I8)|HybridSched虚拟机在离线混部|Accepted|Virt||EPOL||
|[I5Y1J1](https://gitee.com/openeuler/release-management/issues/I5Y1J1)|实时非实时系统混合部署支持树莓派|Accepted|sig-embedded||embedded||
|[I5Y1K3](https://gitee.com/openeuler/release-management/issues/I5Y1K3)|分布式软总线生态互通互联|Accepted|sig-Edge||EPOL||
|[I5YL35](https://gitee.com/openeuler/release-management/issues/I5YL35)|支持embedded版本|Accepted|sig-embedded||embedded||
|[I605QY](https://gitee.com/openeuler/release-management/issues/I605QY)|支持generic vDPA Device|Accepted|sig-Kernel,sig-Virt||ISO|kernel,qemu|
|[I609I2](https://gitee.com/openeuler/release-management/issues/I609I2)|Tensorflow中Intel AMX支持|Accepted|ai|[@Jincheng](https://gitee.com/wisespreading) [@yefeng](https://gitee.com/YeFeng_24) [@Sinever](https://gitee.com/Sinever)|EPOL|python3-tensorflow,python3-absl-py,flatbuffers,python3-flatbuffers,python3-keras, libclang, python3-tensorflow-estimator, python3-tensorboard|
|[I61CMT](https://gitee.com/openeuler/release-management/issues/I61CMT)|openEuler WSL package支持|Accepted|sig-Infrastructure|[@mywaaagh_admin](https://gitee.com/mywaaagh_admin)|Microsoft Store appx bundle||
|[I61DRR](https://gitee.com/openeuler/release-management/issues/I61DRR)|Gazelle支持ceph client和rpc框架|Accepted|sig-high-performance-network|[@wu-changsheng](https://gitee.com/wu-changsheng)|oepkgs|Gazelle,dpdk,lwip|

> 当前社区release分为以下几种方式: 社区repo-OS/everything/Epol/独立镜像，oepkgs(软件所仓库)，sig独立发布(各sig自定义发布链接提供至release-sig)

## 2.4 测试活动分工
本次版本测试活动分工如下：

| **需求**         | **开发主体** | **测试主体** | **测试分层策略**         |
| --------------- | ----------- | ---------- | ----------------------- |
| 支持UKUI桌面     | sig-UKUI  | sig-UKUI  | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能 |
| 支持DDE桌面      | sig-DDE   | sig-DDE   | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持xfce桌面     | xfce  | xfce  | 验证xfce桌面系统在openEuler版本上的可安装和基本功能 |
| 支持GNOME桌面    | GNOME | GNOME | 验证gnome桌面系统在openEuler版本上的可安装和基本功能|
| 支持Kiran桌面    | sig-KIRAN-DESKTOP | sig-KIRAN-DESKTOP | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能 |
| 支持南向兼容性    | sig-Compatibility-Infra | sig-QA | 验证openEuler版本在不同处理器上的可安装和可使用性，覆盖整机兼容性测试和社区集成测试 |
| 支持北向兼容性    | sig-Compatibility-Infra | sig-QA | 验证软件所仓库的软件包在openEuler的适用性 |
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
| 支持定制裁剪工具(imageTailor和oemaker) | sig-OS-Builder | sig-QA | 验证可定制化的能力，包括裁剪工具的基本命令功能，并对异常参数进行覆盖；另外对裁剪出来的镜像进行安装部署及基本验证，保障裁剪工具的E2E能力完整性 |
| 支持openGauss   | DB | DB | 验证openGauss数据库基础功能中接入层、SQL层、存储层、管理和安全等，另外从可靠性、性能、工具和兼容性四个维度覆盖生态测试 |
| 支持虚拟化热补丁libcareplus | Virt | Virt | 关注libcareplus提供Qemu热补丁能力 |
| 支持用户态协议栈gazelle     | sig-high-performance-network | sig-high-performance-network |关注gazelle高性能用户态协议栈功能  |
| 支持容器场景在离线混合部署rubik | sig-CloudNative | sig-CloudNative | 结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 支持智能运维A-ops | sig-ops | sig-QA | 关注智能定位（异常检测、故障诊断）功能、可靠性 |
| 支持国密算法      | sig-security-facility | sig-security-facility | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 | 
| 支持k3s          | sig-K8sDistro | sig-K8sDistro | 验证k3s软件的部署测试过程 | 
| 支持IO智能多流astream | Kernel | sig-QA | 验证通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命 | 
| 支持pkgship      | sig-EasyLife | sig-QA | 验证软件包依赖查询、生命周期管理、补丁查询等功能 | 
| 支持鲲鹏安全库     | sig-security-facility | sig-QA | 验证对鲲鹏安全库下的支持平台远程证明及TEE远程证明特性进行接口、功能测试 | 
| 支持mindspore     | ai | ai | 继承已有测试能力，针对openCV、opencl-clhpp、onednn、Sentencepiece4个模块，复用开源测试能力覆盖安装、接口测试、功能测试，重点关注对mindspore提供能力的稳定性 |
| 支持pod带宽管理oncn-bwm | sig-high-performance-network | sig-high-performance-network | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试  | 
| 支持基于分布式软总线扩展生态互联互通 | sig-embedded | sig-embedded | 验证openEuler和openHarmony设备进行设备认证，互通互联特性 | 
| 支持混合关键部署技术扩展 | sig-embedded | sig-embedded | 验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 支持硬实时系统    | sig-embedded | sig-embedded | 验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 | 
| 支持kubernetes  | sig-CloudNative | sig-CloudNative | 验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 安装部署         | sig-OS-Builder | sig-OS-Builder | 验证覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| Kunpeng加速引擎 | sig-AccLib | sig-AccLib | 验证对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加速器KAE的基本功能和性能测试 |
| 新增备份还原功能支持       | sig-Migration | sig-Migration | 验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常  |
| 新增ROS基础版和ROS2基础版  | sig-ROS | sig-ROS | 验证ROS1 Noetic 版的ROS_COMM的RPM 和 ROS2 Foxy 版的ROS_BASE的RPM的安装和卸载功能 |
| openEuler 22.03 LTS SP 南向兼容：支持intel SPR | sig-Compatibility-Infra | sig-Compatibility-Infra | 使用社区开源硬件兼容性测试工具oec-hardware，验证整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性 |
| 兼容HG2号和3号 | sig-Compatibility-Infra | sig-Compatibility-Infra | 使用社区开源硬件兼容性测试工具oec-hardware，验证整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性 |
| 支持openstack Train版本 | sig-openstack | sig-openstack | 验证在版本中提供OpenStack Train、OpenStack Wallaby 版本的 RPM 安装包，方便用户快速部署OpenStack |
| KubeOS支持一体机 | Kernel | Kernel | 验证KubeOS支持kubernetes和容器运行，OS整体升级，可通过k8s operator控制升级的流程 |
| 基于A-ops现有CVE管理能力扩展 | sig-ops | sig-QA | 验证openEuler社区对于已发现但未修复的CVE管理能力，包括CVEs管理、主机列表、任务管理三个部分 |
| 降低secGear在空载下的CPU占用率 | Kernel | Kernel | 验证secGear增加wakeup模式，若enclave以wakeup模式启动，且当前没有任务，则此时无工作线程，只有调度线程；当有任务时，才会唤醒工作线程 |
| HybridSched虚拟机在离线混部 | Virt | Virt | 测试覆盖接口、功能场景、可靠性和安全。重点结合容器场景验证了在线对离线业务的抢占，以及混部情况下的调度优先级测试。 |
| 实时非实时系统混合部署支持树莓派 | sig-embedded | sig-embedded | 测试混合关键部署技术开放接口api，测试整体串口/SHELL服务，混合部署生命周期管理以及在树莓派上的混合部署 |
| 分布式软总线生态互通互联 | sig-Edge | sig-embedded | 测试分布式软总线开放接口api，重点关注认证模块，验证与openHarmony的互相识别和通信 |
| 支持embedded版本 | sig-embedded | sig-embedded | 详见嵌入式版本测试报告 |
| 支持generic vDPA Device | sig-Kernel,sig-Virt | sig-Kernel,sig-Virt | 验证内核可以创建和删除/dev/vhost-vdpa-X字符设备，qemu可以正常使用该字符设备 |
| Tensorflow中Intel AMX支持 | ai | ai | AMX特性涉及到软件包oneDNN和Tensorflow集成。复用oneDNN开源测试用例，覆盖AMX对数据类型BF16和INT8的测试。 通过Tensorflow中运行混合精度MNIST模型的AMX集成测试用例，完成功能覆盖。 |
| openEuler WSL package支持 | sig-Infrastructure | sig-Infrastructure | 验证appxbundle文件可以上传到微软商店通过微软的审核，社区发布更新版本也能触发商店版本更新 |
| Gazelle支持ceph client和rpc框架 | sig-high-performance-network | sig-high-performance-network | 覆盖了gazella安装部署、命令行接口和配置文件接口测试，重点测试转发业务流和性能规格场景，并结合网络发包仪打流和故障进行长稳验证。 |

# 3 版本概要测试结论

   openEuler 22.03 LTS SP1 版本整体测试按照release-manager团队的计划，1轮重点特性测试 + 2轮全量测试 + 1轮回归测试 + 1轮版本发布验收测试；第1轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫描及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；另外2轮全量测试开展版本交付的所有特性和各类专项测试；1轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

​   openEuler 22.03 LTS SP1 版本共发现问题 688 个，有效问题 678 个，无效问题 10 个。遗留问题 2 个(详见遗留问题章节)。版本整体质量良好。

# 4 版本详细测试结论

openEuler 22.03 LTS SP1 版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试、资料测试；

## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 内核  | <font color=green>█</font>   | 直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 2 | 容器(isula/docker/安全容器/系统容器/镜像)  | <font color=green>█</font> | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 3 | 虚拟化(qemu/stratovirt)  | <font color=green>█</font>   | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 4 | 编译器(gcc/jdk)  | <font color=green>█</font>   | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   |
| 5 | [支持DDE桌面](https://gitee.com/openeuler/QA/blob/b1a6ac432b3d6366bc4d86f16ca59de99998bd89/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>      | 继承已有测试能力，关注DDE桌面系统的安装和基本功能           |
| 6 | [支持UKUI桌面](https://gitee.com/openeuler/QA/blob/a00ce7176295e3fa4333759295f147809a178a23/Test_Result/openEuler_22.03_LTS_SP1/openEuler_22.03%20SP1%E7%89%88%E6%9C%ACUKUI%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>     | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           |
| 7 | 支持xfce桌面  | <font color=green>█</font>     | 继承已有测试能力，重点关注xfce桌面的可安装性和提供组件的能力 |
| 8 | 支持gnome桌面  | <font color=green>█</font>    | 继承已有测试能力，关注gnome桌面系统的安装和基本功能           |
| 9 | 支持Kiran桌面  | <font color=green>█</font>    | 增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 |
| 10 | 支持南向兼容性  | <font color=green>█</font>    | 继承已有测试能力，关注板卡和整机适配的兼容性测试 |
| 11 | 支持北向兼容性  | <font color=green>█</font>    | 继承已有测试能力，关注软件所仓库对已正式release版本的北向软件的功能验证 |
| 12 | 支持树莓派  | <font color=green>█</font>       | 继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     |
| 13 | 支持RISC-V  | <font color=green>█</font>      | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性(因构建效率原因，RISC-V版本会在openEuler版本正式release后开启构建与测试) |
| 14 | [支持HA软件](https://gitee.com/openeuler/QA/blob/cefe10ae3350d6af46408df4035eda650b6d95c9/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACHA%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>      | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 |
| 15 | 支持KubeSphere  | <font color=green>█</font>  | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 16 | [支持openstack Train 和 Wallaby](https://gitee.com/openeuler/QA/blob/e9b0dd4e1006adb14d3e391911a4a5e7d069d48b/Test_Result/openEuler_22.03_LTS_SP1/%20openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACOpenStack%20Train%20Wallaby%E7%89%88%E6%9C%AC%E6%94%AF%E6%8C%81%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>  | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能 |
| 17 | 支持A-Tune | <font color=green>█</font>      | 继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 18 | 支持secPave  | <font color=green>█</font>     | 继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    |
| 19 | [支持secGear](https://gitee.com/openeuler/QA/blob/e0cae1b2a99fe93de91e4ea05b3e4100c44c4ce9/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACsecGear%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>     | 继承已有测试能力，关注secGear特性的功能完整性          |
| 20 | 支持eggo | <font color=green>█</font>        | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 |
| 21 | [支持kubeOS](https://gitee.com/openeuler/QA/blob/9e9f50a7c011b9b46d1a53cfcaf860d33362cdb9/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACKubeOS%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>      | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 |
| 22 | [支持NestOS](https://gitee.com/openeuler/QA/blob/810f8235412b9f06527fa50c23666e830b7087ab/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03%20LTS%20SP1%E7%89%88%E6%9C%ACNestOS%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>      | 继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 23 | 支持OpenResty  | <font color=green>█</font>   | 继承已有测试能力，关注openResty平台在openEuler版本上的可安装性和基本功能   |
| 24 | 支持etmem内存分级扩展 | <font color=green>█</font> | 继承已有测试能力，重点验证特性的基本功能和稳定性   |
| 25 | 支持定制裁剪工具套件(oemaker/imageTailor) | <font color=green>█</font> | 继承已有测试能力，验证可定制化的能力   |
| 26 | 支持openGauss  | <font color=green>█</font>   | 继承已有测试能力，关注openGauss数据库的功能、性能和可靠性   |
| 27 | 支持虚拟化热补丁libcareplus  | <font color=green>█</font> | 继承已有测试能力，重点关注libcareplus提供Qemu热补丁能力  |
| 28 | 支持用户态协议栈gazelle  | <font color=green>█</font>     | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能  |
| 29 | 支持容器场景在离线混合部署rubik | <font color=green>█</font> | 继承已有测试能力，结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 30 | [支持智能运维A-ops](https://gitee.com/openeuler/QA/blob/179df4fd65894b972767c618e5f042a27ed01cfc/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03-LTS-SP1%E7%89%88%E6%9C%ACAops%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font> | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性 |
| 31 | [支持国密算法](https://gitee.com/openeuler/QA/blob/3db9789ed2c7782229b8b0c309da72aebc57c8b8/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%AC%E6%94%AF%E6%8C%81%E5%9B%BD%E5%AF%86%E5%AE%89%E5%85%A8%E5%90%AF%E5%8A%A8%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>      | 继承已有测试能力，验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 | 
| 32 | 支持k3s | <font color=green>█</font>          | 继承已有测试能力，验证k3s软件的部署测试过程 | 
| 33 | 支持IO智能多流astream  | <font color=green>█</font> | 继承已有测试能力，验证通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命 | 
| 34 | [支持pkgship](https://gitee.com/openeuler/QA/blob/66f7a677d5b9771024864a6b78fa58a7f5c5d74c/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACpkgship%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>      | 继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能 | 
| 35 | 支持鲲鹏加速库  | <font color=green>█</font>     | 继承已有测试能力，验证对鲲鹏安全库下的支持平台远程证明及TEE远程证明特性进行接口、功能测试 | 
| 36 | 支持mindspore  | <font color=green>█</font>     | 继承已有测试能力，针对openCV、opencl-clhpp、onednn、Sentencepiece4个模块，复用开源测试能力覆盖安装、接口测试、功能测试，重点关注对mindspore提供能力的稳定性 | 
| 37 | 支持pod带宽管理oncn-bwm | <font color=green>█</font> | 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 | 
| 38 | 支持基于分布式软总线扩展生态互联互通 | <font color=green>█</font> | 继承已有测试能力，验证openEuler和openHarmony设备进行设备认证，互通互联特性 | 
| 39 | [支持混合关键部署技术扩展](https://gitee.com/openeuler/QA/blob/fc1598123974a0998de81a2a129e9888e9bc6d50/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font>  | 继承已有测试能力，验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS | 
| 40 | [支持硬实时系统](https://gitee.com/openeuler/QA/blob/fc1598123974a0998de81a2a129e9888e9bc6d50/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | <font color=green>█</font> | 继承已有测试能力，验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 | 
| 41 | 支持kubernetes | <font color=green>█</font>  | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 42 | 安装部署 | <font color=green>█</font>         | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| 43 | Kunpeng加速引擎 | <font color=green>█</font> | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 |


<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称** | **测试覆盖情况** | **约束依赖说明** | **遗留问题单** | **质量评估** | **备注<img width=50/>** |
| -------- | ----------- | ------------- | -------------- | ------------ | ----------- | ------------ |
| 1 | [DDE组件更新支持服务器场景优化](https://gitee.com/openeuler/QA/blob/b1a6ac432b3d6366bc4d86f16ca59de99998bd89/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)  | 验证dde桌面支持能力,可安装和基本功能及其他性能指标 | NA | NA | <font color=green>█</font> | NA |
| 2 | [新增软件更新工具支持](https://gitee.com/openeuler/QA/blob/b1a6ac432b3d6366bc4d86f16ca59de99998bd89/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)          | 验证dde桌面支持能力,可安装和基本功能及其他性能指标 | NA | NA | <font color=green>█</font> | NA |
| 3 | [新增备份还原功能支持](https://gitee.com/openeuler/QA/blob/b1a6ac432b3d6366bc4d86f16ca59de99998bd89/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)          | 验证dde桌面支持能力,基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常 | NA | NA | <font color=green>█</font> | NA |
| 4 | [新增ROS基础版和ROS2基础版](https://gitee.com/openeuler/QA/blob/39ef850a08126f969d5c9b266e47a29ea8af73b4/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%AC%20ROS%20%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)     | 验证ROS机器人软件开发套件在openEuler版本的适配性，安装、卸载和功能 | NA | NA | <font color=green>█</font> | NA |
| 5 | [发布kiran-desktop 2.4版本](https://gitee.com/openeuler/QA/blob/00c22ed008e5e6e229ab8690739de7d96f41d04d/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%AC%20Kiran%E7%89%B9%E6%80%A7%E5%B0%8F%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)   | 验证kiran桌面支持能力,可安装和基本功能及其他性能指标 | NA | NA | <font color=green>█</font> | NA |
| 6 | [支持树莓派](https://gitee.com/openeuler/QA/blob/7fe7d4bbe308936a51f4051c18bf9a87ab217101/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%AC%E6%A0%91%E8%8E%93%E6%B4%BE%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 对树莓派发布件的测试,从安装、基本功能、兼容性及稳定性层面考虑 | NA | NA | <font color=green>█</font> | NA |
| 7 | [openEuler 22.03 LTS SP 南向兼容：支持intel SPR]() | 使用社区开源硬件兼容性测试工具oec-hardware，验证整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性 | NA | NA | <font color=green>█</font> | NA |
| 8 | [兼容HG2号和3号](https://gitee.com/openeuler/openEuler-portal/blob/d2607ea1bcf05ea31caa9c392641cacba92edd2a/data/compatibility/compat_server_zh.json) | 使用社区开源硬件兼容性测试工具oec-hardware，验证整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性 | NA | NA | <font color=green>█</font> | NA |
| 9 | [支持openstack Train版本](https://gitee.com/openeuler/QA/blob/e9b0dd4e1006adb14d3e391911a4a5e7d069d48b/Test_Result/openEuler_22.03_LTS_SP1/%20openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACOpenStack%20Train%20Wallaby%E7%89%88%E6%9C%AC%E6%94%AF%E6%8C%81%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 验证在版本中提供OpenStack Train、OpenStack Wallaby 版本的 RPM 安装包，方便用户快速部署OpenStack  | NA | NA | <font color=green>█</font> | NA |
| 10 | [KubeOS支持一体机](https://gitee.com/openeuler/QA/blob/9e9f50a7c011b9b46d1a53cfcaf860d33362cdb9/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACKubeOS%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 验证KubeOS支持kubernetes和容器运行，OS整体升级，可通过k8s operator控制升级的流程 | NA | NA | <font color=green>█</font> | NA |
| 11 | [基于A-ops现有CVE管理能力扩展](https://gitee.com/openeuler/QA/blob/7223e4418667cea171b2627a7a21aeec4f686d18/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03-LTS-SP1%E7%89%88%E6%9C%ACAops%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 验证openEuler社区对于已发现但未修复的CVE管理能力，包括CVEs管理、主机列表、任务管理三个部分  | NA | NA | <font color=green>█</font> | NA |
| 12 | [降低secGear在空载下的CPU占用率](https://gitee.com/openeuler/QA/blob/9e9f50a7c011b9b46d1a53cfcaf860d33362cdb9/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACsecGear%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 验证secGear增加wakeup模式，若enclave以wakeup模式启动，且当前没有任务，则此时无工作线程，只有调度线程；当有任务时，才会唤醒工作线程  | NA | NA | <font color=green>█</font> | NA |
| 13 | [HybridSched虚拟机在离线混部](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACskylark%E8%99%9A%E6%8B%9F%E6%9C%BA%E6%B7%B7%E5%90%88%E9%83%A8%E7%BD%B2%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 测试覆盖接口、功能场景、可靠性和安全。重点结合容器场景验证了在线对离线业务的抢占，以及混部情况下的调度优先级测试 | NA | NA | <font color=green>█</font> | NA |
| 14 | [实时非实时系统混合部署支持树莓派](https://gitee.com/openeuler/QA/blob/fc1598123974a0998de81a2a129e9888e9bc6d50/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) |  测试整体串口/SHELL服务，混合部署生命周期管理以及在树莓派上的混合部署 | NA | NA | <font color=green>█</font> | NA |
| 15 | [分布式软总线生态互通互联](https://gitee.com/openeuler/QA/blob/fc1598123974a0998de81a2a129e9888e9bc6d50/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 关注认证模块，验证与openHarmony的互相识别和通信  | NA | NA | <font color=green>█</font> | NA |
| 16 | [支持embedded版本](https://gitee.com/openeuler/QA/blob/fc1598123974a0998de81a2a129e9888e9bc6d50/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) |  详见嵌入式版本测试报告 | NA | NA | <font color=green>█</font> | NA |
| 17 | [支持generic vDPA Device](https://gitee.com/openeuler/QA/blob/4c2e3ef19a01dccf704ff702092129e12c899156/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACgeneric%20vDPA%20device%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 验证内核可以创建和删除/dev/vhost-vdpa-X字符设备，qemu可以正常使用该字符设备  | NA | NA | <font color=green>█</font> | NA |
| 18 | [Tensorflow中Intel AMX支持](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACAMX%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | AMX特性涉及到软件包oneDNN和Tensorflow集成。复用oneDNN开源测试用例，覆盖AMX对数据类型BF16和INT8的测试。 通过Tensorflow中运行混合精度MNIST模型的AMX集成测试用例，完成功能覆盖。 | NA | NA | <font color=green>█</font> | NA |
| 19 | [openEuler WSL package支持](https://gitee.com/openeuler/QA/blob/ff83ae85b7cc90581464eafc50e75532d417bde2/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACwsl%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 在微软商店可以正常安装、卸载所有架构和所有LTS版本的openEuler WSL 应用，这些应用能正常启动并通过基本的功能测试 | NA | NA | <font color=green>█</font> | NA |
| 20 | [Gazelle支持ceph client和rpc框架](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP1/openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACgazelle%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 覆盖了gazella安装部署、命令行接口和配置文件接口测试，重点测试转发业务流和性能规格场景，并结合网络发包仪打流和故障进行长稳验证。 | NA | NA | <font color=green>█</font> | NA |


<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1   升级兼容性

openEuler 22.03-LTS-SP1 作为 openEuler 22.03-LTS 版本的补丁版本，支持从LTS版本升级到对应的SP1，完成如下场景的升级验证：

1、从22.03 LTS升级到22.03 LTS SP1版本

2、从22.03 LTS的月度update维护版本升级到22.03 LTS SP1版本

3、升级后系统的重启

4、从22.03 LTS SP1版本降级至22.03 LTS版本

上述场景下，软件包升降机后的功能验证、服务检查等测试；新增软件包通过对软件直接进行安装来进行；整体升级兼容性功能正常。

### 4.2.2   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成52张板卡的测试(该数目仅为测试数量，实际兼容性认证通过数量见社区[兼容性清单](https://www.openeuler.org/zh/compatibility/))

此版本的板卡兼容性适配测试，适配的板卡类型有RAID/FC/GPU/SSD/IB/NIC/六种，在aarch64/x86_64架构上进行适配，主要使用社区硬件兼容性测试工具oec-hardware集成compass-ci进行自动化测试，适配完成后将在社区发布此版本的板卡兼容性清单。

下表列出版本集成验证中涉及的硬件板卡信息：

| **板卡类型** | **覆盖范围** | **测试主体** | **chipVendor** |**boardModel** | **chipModel** | **测试结果** | 
|--|--|--|--|--|--|--|
| RAID | 适配7张 | sig-Compatibility | | | | |
| | | | Avago |	9560-8i | SAS3908 | PASS |
| | | | Avago |	SP460C-M | SAS3516 | PASS |
| | | | Avago |	SR150-M	 | SAS3408 | PASS |
| | | | Avago |	SP150IT-M |	SAS3408 | PASS |
| | | | Avago |	SR430C-M |	SAS-3 3108 | PASS |
| | | | Avago |	SR130 |	SAS3008 | PASS |
| | | | Avago |	SR130-M | SAS3008 | PASS |
| FC | 适配4张 | sig-Compatibility | | |
| | | | Marvell/Qlogic | QLE2560 | ISP2532 | PASS |
| | | | Emulex | LPe31002-M6 | LPe31000/LPe32000 | PASS |
| | | | Emulex | LPe32002-M2 | LPe31000/LPe32000 | PASS |
| | | | Emulex | LPE16002B-M6 | LPe15000/LPe16000 | PASS |
| GPU | 适配3张 | sig-Compatibility | | | | |
| | | | NVIDIA | Tesla T4 |	TU104GL | PASS |
| | | | NVIDIA | Tesla V100 | GV100GL | PASS |
| | | | NVIDIA | Tesla A100 | GA100 | PASS |
| SSD | 适配1张 | sig-Compatibility | | | |
| | | | Huawei | ES3600C V5-3200GB | Hi1812E V100 | PASS |
| IB | 适配3张 | sig-Compatibility | | | |
| | | | Mellanox | SP351 | ConnectX-5 | PASS |
| | | | Mellanox | SP350 | ConnectX-5 | PASS |
| | | | Mellanox | MCX653105A-EFAT | ConnectX-6 | PASS |
| NIC | 适配NIC板卡11张 | sig-Compatibility | | | |
| | | | Mellanox | SP382 | ConnectX-5 | PASS |
| | | | Mellanox | SP380 | ConnectX-4 Lx | PASS |
| | | | Mellanox | MCX4121A-XCAT |	ConnectX-4 Lx | PASS |
| | | | Mellanox | MCX4121A-ACUT |	ConnectX-4 Lx | PASS |
| | | | Intel |	SP310 |	82599ES | PASS |
| | | | Intel |	SP210 |	I350 | PASS |
| | | | Intel |	Intel I350 | I350 | PASS |
| | | | Intel |	I350-F2 | I350 | PASS |
| | | | Intel |	XL710-Q2 | XL710 | PASS with risk(x86下 速率未达标，基础功能可用;arm下全达标) |
| | | | Huawei | SP580 | Hi1822 | PASS |
| | | | Huawei | SP570 | Hi1822 | PASS |

此版本的整机兼容性适配测试主要使用社区开源硬件兼容性测试工具oec-hardware，从整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性等方面进行适配，适配完成后将在社区发布此版本的整机兼容性清单。

整机适配兼容性测试交付清单如下：

| **整机厂商** | **整机型号** | **CPU型号** | **测试主体** | **测试结果** |
|--|--|--|--|--|
| 华为 | 泰山200 | 鲲鹏920 | sig-Compatibility | PASS |
| | 青松服务器 | FT S2500 | sig-Compatibility | PASS | 
| 超聚变 | 2288H V5 | Intel cascade | sig-Compatibility | PASS |
| | 2288H V7 | Intel SPR | sig-Compatibility | PASS |
| 中科可控 | R6230HA | Hygon 2号 | sig-Compatibility | PASS | 
|  | X7840H0 | Hygon 3号 | sig-Compatibility | PASS(基于kabi不变的原则继承2203LTS结论) | 
| AMD | Supermicro AS-4124GS-TNR | AMD Milan | sig-Compatibility | PASS |
| 飞腾 | 公版 | FT2000+ | sig-Compatibility | PASS(基于kabi不变的原则继承2203LTS结论) |
| | 公版 | FT S2500 | sig-Compatibility | PASS |
| 兆芯 | ThinkSystem SR658Z | KH-30000 | sig-Compatibility | PASS(基于kabi不变的原则继承2203LTS结论) |

整机兼容性清单以sig-Compatibility-Infra提供为主，社区各sig测试过程中使用的机器因未进行oec-hardware测试(进入社区兼容性清单质量要求)，故无法直接进行兼容性清单不在此描述。

### 4.2.3   北向兼容性

北向兼容性整体测试按照sig-Compatibility-Infra团队的规划，版本发布后会进行持续的兼容性测试：<br>
当前版本oepkgs支持软件包数量：22237个(基于22.03 LTS北向兼容软件);16026(基于20.03 LTS SP1北向兼容软件);15404(基于20.03 LTS SP3北向兼容软件)<br>
合计oepkgs北向兼容软件数量：26327(版本号去重)<br>
合计兼容软件数量：30569（26327 oepkgs支持 + 4242 社区官方支持）<br>
软件所仓库软件包查询地址 https://search.oepkgs.net/search<br>

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
| ---------- | ------------------------------------------------------------------------ | -------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 操作系统稳定运行7\*24小时(RC4自12/16启动长稳测试,已完成未发现问题;RC5自12/24启动长稳测试会持续跟踪7\*24小时) |

### 性能测试

| **指标大项** | **指标小项** | **指标值** | **测试结论** |
| ----------- | ---------- | --------- | ----------- |
| OS基础性能 | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考22.03 LTS版本相应指标基线 | 比较前一版本持平 |

# 5   问题单统计

openEuler 22.03 LTS SP1 版本共发现问题 688 个，有效问题 678 个，其中遗留问题 2 个。详细分布见下表:

| 测试阶段 | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注 |
| ------ | ------- | ---------- | ---------- | ---------- | --- |
| openEuler 22.03 LTS SP1 dailybuild | 13 | 13 | 0 | 0 | ALPHA DT轮次 |
| openEuler 22.03 LTS SP1 RC1 | 196 | 191 | 5 | 2 |  |
| openEuler 22.03 LTS SP1 RC2 | 386 | 383 | 3 | 0 | 全量集成 |
| openEuler 22.03 LTS SP1 RC3 | 86 | 84 | 2 | 0 | 全量集成 |
| openEuler 22.03 LTS SP1 RC4 | 7 | 7 | 0 | 0 | 回归测试 |
| openEuler 22.03 LTS SP1 RC5 | 0 | 0 | 0 | 0 | 版本发布验收测试(回归测试) |

1. 本版本基于单点问题补充的专项测试活动（RC2）：
   * 代码同步专项排查：部分软件22.03-LTS分支的最新pr，没有同步至22.03-LTS-SP1 和 22.03-LTS-Next 分支，导致22.03-LTS-SP1的软件版本比22.03-LTS版本低，此类issue共计164个；
   * 安全编译选项排查：不满足[安全编译选项](https://gitee.com/openeuler/security-committee/blob/master/guide/SecureCompile(C&C++).md)，此类issue单124个。该专项活动持续进行，本版本开始将正式以issue的形式在社区跟踪落地。
2. RC4问题分析：共计发现7个问题，5个功能问题归属热补丁工具syscase(EPOL)，1个功能问题归属用户态协议栈gazelle(everything),1个资料问题归属运维工具集合x-diagnose(EPOL)。因syscare和x-diagnose为工具属性，gazelle的问题仅涉及入参阈值的修改。故认为RC5回归以上问题后不会对整体OS的功能、性能、可靠性产生影响，即RC4的以上结论可作为版本release质量参考。syscare整体测试策略规划为5轮，rc5进行问题单收敛和回归。

# 6   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- | 
| 1 | [I63TPY](https://gitee.com/src-openeuler/openmpi/issues/I63TPY?from=project-issue) | 【openEuler-22.03-LTS-SP1】ompi-clean -v -d参数执行报错 | 主要 | 该包为NestOS使用软件包，使用范围较为局限，默认为 NestOS 中的“core”用户启用，对服务器版本影响较小(继承2209遗留结论) | 暂无 | [I5PQ3O](https://gitee.com/src-openeuler/openmpi/issues/I5PQ3O):【openEuler-22.09-RC3】ompi-clean -v -d参数执行报错?from=project-issue |
| 2 | [I639FO](https://gitee.com/src-openeuler/cloud-init/issues/I639FO?from=project-issue) | 【22.03 LTS SP1 RC1】【arm/x86 】cloud-init-hotplugd.socket服务启动失败，必须关闭selinux才能启动成功 | 主要 | cloud-init 21.3版本(2021年11月发布)开始引入的服务。与cloud-init-hotplugd.socket配对，实现热插拔功能。并行调研华为云、fedora社区，确认未启用该功能，此组件仍在持续迭代，不成熟影响可控。 | 关闭selinux后功能可用 | 社区已知问题：https://bugs.launchpad.net/cloud-init/+bug/1936229 |


# 致谢
非常感谢以下sig在openEuler 22.03 LTS SP1 版本测试中做出的贡献,以下排名不分先后
infra-sig的各位贡献者
@wangchong1995924 @small_leek @yaolonggang @dongjie110 @cxl78320 @raomingbo @shdluan @wu_zhende @weijihui @liu-yinsi @duan_pj @wangLin0_0 @georgecao @zhongjun2 @gzbang @liuqi469227928 @wanghaosq @dakang_siji @liuyanglinun @Tom_zx @haml @qinsheng99_code
<br>
RM-sig的各位贡献者
@solarhu @chenyaqiang @paul-huang
<br>
QA-sig的各位贡献者
@zjl_long @ga_beng_cui @hanson-fang @erin_dan @丁娇 @wenjun @suhang @zhanglu626 @ssttkx @zhangpanting @wangxiaoya @hukun66 @MDS_ZHR @banzhuanxiaodoubi @mazenggang3 @clerk_duan
@yanglijin @clay @oh_thats_great @wangting112 @lijiaming666 @liwencheng6769 @luluyuan @lutianxiong @chenshijuan3 @laputa0 @lcqtesting @xiuyuekuang @ganqx
@woqidaideshi @yjt-dli @disnight @chenshijuan3 @wangpeng_uniontech @fu-shanqing @saarloos @ding-jiao
<br>
以及所有参与22.03 LTS SP1但未统计到的所有开发者
(如有遗漏可随时联系 @disnight email:fjc837005411@outlook.com 反馈)


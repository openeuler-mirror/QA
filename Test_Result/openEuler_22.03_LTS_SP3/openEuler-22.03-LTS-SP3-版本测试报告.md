![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2023/12/18 | 1.0.0    | 初稿, 基于RC1/2/3 | ga_beng_cui |
| 2023/12/24 | 1.0.1    | 刷新测试结论  　　　| disnight |
| 2023/12/26 | 1.0.2    | 刷新兼容性测试结论  | ga_beng_cui |


关键词：

openEuler raspberrypi DDE Lustre-Client sysMaster ROS2-humble OpenStack kunpengsecl secGear embedded oemaker gazelle iSulad A-Ops nosva NestOS N1045XS 

摘要：

文本主要描述openEuler 22.03 LTS SP3 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.03 LTS SP3 版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 22.03 LTS SP3 是基于5.10内核22.03-LTS-SP2的补丁增强版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 22.03 LTS-Next分支拉出，发布范围相较22.03 LTS版本主要变动：

1. 软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP3/openEuler-22.03-LTS-SP3%20%E5%8D%87%E7%BA%A7%E9%80%89%E5%9E%8B.md)
2. 修复bug和cve
3. DDE组件、SecGear、oemaker、gazelle、NestOS、Rubik、AOps、iSulad等特性增强
4. 新增Lustrte Client、ROS2-humble、kiran-desktop2.5、sysmonitor等软件
5. 新增星云智联板卡N1045XS网卡驱动

## 2.1 版本测试计划
openEuler 22.03 LTS SP3 版本按照社区release-manager团队的计划，共规划6轮测试，详细的版本信息和测试时间如下表：

| 版本名称     | 测试起始时间 | 测试结束时间   | 备注                                                         |
| ------------ | ------------ | -------------- | ------------------------------------------------------------ |
| Build & Alpha          | 2023/11/16 | 2023/11/22 | 7    | 开发自验证 |
| Test round 1           | 2023/11/23 | 2023/11/29 | 7    | 22.03-LTS SP3版本启动集成测试   |
| Beta Version release   | 2023/12/1  | 2023/12/2  | 2    | 22.03-LTS SP3 Beta版本发布     |
| Test round 2           | 2023/12/2  | 2023/12/8  | 7    | 全量SIT验证    |
| Test round 3           | 2023/12/9  | 2023/12/15 | 7    | 全量SIT验证    |
| Test round 4           | 2023/12/16 | 2023/12/22 | 7    | 回归测试     |
| Test round 5           | 2023/12/23 | 2023/12/29 | 7    | 回归测试    |
| Release                | 2023/12/30 | 2023/12/30 | 1    | 社区Release版本发布评审    |

## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920                              | OS集成测试     |
| RH2288H V5            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| 树莓派 4B              | BCM2711                                  | 嵌入式版本测试 |
| STM32F407ZGT6开发板    | CPU:STM32F407ZG(168MHz)                  | 嵌入式版本测试 |
| 超聚变 2288H V3        | Intel cascade                            | 南向兼容性测试 |

## 2.3 需求清单

openEuler 22.03 LTS SP3版本交付需求列表如下，详情见[openEuler-22.03-LTS-SP3 release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP3/release-plan.md)：

| no   | feature                                                      | status   | sig                          | owner                                                        | 发布方式         | 备注                                        |
| ---- | ------------------------------------------------------------ | -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | ------------------------------------------- |
| | [I80F3Y](https://gitee.com/openeuler/release-management/issues/I80F3Y) | 支持Lustre server软件包 | Accepted | sig-SDS | [@xin3liang](https://gitee.com/xin3liang) | EPOL | lustre, lustre-release, e2fsprogs |
| | [I83JRC](https://gitee.com/openeuler/release-management/issues/I83JRC) | eNFS特性合入 | Rejected | sig-kernel | [@mingqian218472](https://gitee.com/mingqian218472) | ISO | nfs,sunrpc |
| | [I82A5V](https://gitee.com/openeuler/release-management/issues/I82A5V) | DDE组件更新支持服务器场景优化 | Accepted | sig-DDE | [@leeffo](https://gitee.com/leeffo) | EPOL | |
| | [I84H9S](https://gitee.com/openeuler/release-management/issues/I84H9S) | FangTian视窗引擎特性合入 | Accepted | sig-FangTian | [@BruceXuXu](https://gitee.com/BruceXuXu) | EPOL | |
| | [I8AU51](https://gitee.com/openeuler/release-management/issues/I8AU51) | sysMaster支持虚机场景 | Accepted | dev-utils | [@openeuler-basic](https://gitee.com/openeuler-basic) | ISO | sysmaster |
| | [I8BKM5](https://gitee.com/openeuler/release-management/issues/I8BKM5) | 支持树莓派 | Accepted | sig-RaspberryPi | [@woqidaideshi](https://gitee.com/woqidaideshi) | EPOL | raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom |
| | [I8CWV4](https://gitee.com/openeuler/release-management/issues/I8CWV4)|增加 migration-tools 项目发布|Accepted|sig-migration-tools|[@xingwei-liu](https://gitee.com/xingwei-liu/)|EPOL|migration-tools|
| | [I8299Y](https://gitee.com/openeuler/release-management/issues/I8299Y)|增加 utshell 项目发布|Accepted|sig-memsafety|[@tong2357](https://gitee.com/tong2357/)|EPOL|utshell|
| | [I8DZVE](https://gitee.com/openeuler/release-management/issues/I8DZVE)|增加 utsudo 项目发布|Accepted|sig-memsafety|[@ut-wanglujun](https://gitee.com/ut-wanglujun/)|EPOL|utsudo|
| | [I8ERGA](https://gitee.com/openeuler/release-management/issues/I8ERGA)|增加i3相关软件包发布 |Accepted|sig-infrastructure|[@mywaaagh_admin](https://gitee.com/mywaaagh_admin/)|EPOL|i3,i3status,perl-AnyEvent-I3,perl-AnyEvent,xcb-util-xrm,xcompmgr,perl-IO-Pipely,dmenu|
| | [I8GQJE](https://gitee.com/openeuler/release-management/issues/I8GQJE)|支持入侵检测框架secDetector |Accepted|sig-security-facility|[@zcfsite](https://gitee.com/zcfsite/)|ISO|secDetector|
| | [I8I572](https://gitee.com/openeuler/release-management/issues/I8I572)|支持embedded版本|Accepted|sig-embedded||
| | [I8JQ3J](https://gitee.com/openeuler/release-management/issues/I8JQ3J)|NestOS For-Virt/For-Container多版本支持|Accepted|sig-CloudNative,sig-K8sDistro| [@ccdxx](https://gitee.com/ccdxx/) | EPOL |afterburn,bootupd,console-login-helper-messages,ignition.nestos-installer,zincati,nestos-kernel,openeuler-release-nestos-for-container,openeuler-release-nestos-for-virt|
| | [I8LBX0](https://gitee.com/openeuler/release-management/issues/I8LBX0?from=project-issue)|gazelle支持vlan收发|Accepted|sig-high-performance-network|@kircher(https://gitee.com/ut-wanglujun/)|EPOL|gazelle|
| | [I8LBW8](https://gitee.com/openeuler/release-management/issues/I8LBW8?from=project-issue)|gazelle支持网卡自愈|Accepted|sig-high-performance-network|@kircher(https://gitee.com/ut-wanglujun/)|EPOL|gazelle|
| | [I8LBW6](https://gitee.com/openeuler/release-management/issues/I8LBW6?from=project-issue)|gazelle支持netperf标准测试工具|Accepted|sig-high-performance-network|@kircher(https://gitee.com/ut-wanglujun/)|EPOL|gazelle|
| | [I8LBW5](https://gitee.com/openeuler/release-management/issues/I8LBW5?from=project-issue)|gazelle支持ipv6协议栈基本功能|Accepted|sig-high-performance-network|@kircher(https://gitee.com/ut-wanglujun/)|EPOL|gazelle|
| | [I8LBW4](https://gitee.com/openeuler/release-management/issues/I8LBW4?from=project-issue)|gazelle支持bond6模式|Accepted|sig-high-performance-network|@kircher(https://gitee.com/ut-wanglujun/)|EPOL|gazelle|
| | [I8LBV7](https://gitee.com/openeuler/release-management/issues/I8LBV7?from=project-issue)|grub2支持国密度量内核并上报度量信息|Accepted|sig-OS-Builder||EPOL|grub2|
| | [I8LBU8](https://gitee.com/openeuler/release-management/issues/I8LBU8?from=project-issue)|shim支持国密度量grub2并上报度量信息|Accepted|sig-Base-service||EPOL|shim|
| | [I8LBSO](https://gitee.com/openeuler/release-management/issues/I8LBSO?from=project-issue)|布式软总线功能增强，易用性提升|Accepted|sig-distributed-middleware||EPOL|dsoftbus_standard|
| | [I8LBR7](https://gitee.com/openeuler/release-management/issues/I8LBR7?from=project-issue)|分布式软总线容器适配，支持跨节点跨容器通信|Accepted|sig-distributed-middleware||EPOL|dsoftbus_standard|
| | [I8LBQS](https://gitee.com/openeuler/release-management/issues/I8LBQS?from=project-issue)|iSulad支持oci runtime并且切换默认runtime为runc|Accepted|sig-iSulad||EPOL|iSulad|
| | [I8LBQJ](https://gitee.com/openeuler/release-management/issues/I8LBQJ?from=project-issue)|syscare组件支持容器化热补丁制作场景|Accepted|sig-ops||EPOL|syscare|
| | [I8LBQE](https://gitee.com/openeuler/release-management/issues/I8LBQE?from=project-issue)|增加进程完整性防护特性|Accepted|sig-security-facility||EPOL|dim,dim-tools|
| | [I8M0CB](https://gitee.com/openeuler/release-management/issues/I8M0CB?from=project-issue)|AOPS功能增强，支持任务粒度回退|Accepted|sig-ops|[@zhu-yuncheng](https://gitee.com/zhu-yuncheng/)|EPOL|aops-ceres，aops-apollo，aops-hermes，aops-zeus，aops-vulcanus|
| | [I8M02Y](https://gitee.com/openeuler/release-management/issues/I8M02Y?from=project-issue)|DPU直连聚合：虚拟机、容器管理面DPU卸载，业务无感知|Accepted|sig-DPU |[@minknov](https://gitee.com/minknov/)|EPOL|dpu-utilities|
| | [I8M02S](https://gitee.com/openeuler/release-management/issues/I8M02S?from=project-issue)|支持内核态vDPA框架实现网卡直通虚机可热迁移|Accepted|sig-Virt|[@JiaboFeng](https://gitee.com/JiaboFeng/)|EPOL|libvirt,qemu,kernel|
| | [I87J40](https://gitee.com/openeuler/release-management/issues/I87J40?from=project-issue)|支持safeguard软件包|Accepted|sig-ebpf|[@tongyx633](https://gitee.com/tongyx633/)|EPOL|safeguard|
| | [I8166Y](https://gitee.com/openeuler/release-management/issues/I8166Y?from=project-issue)|libtpms支持sm3算法|Rejected|sig-security-facility|[@zhujianwei001](https://gitee.com/zhujianwei001/)|EPOL|libtpms|
| | [I8GWHE](https://gitee.com/openeuler/release-management/issues/I8GWHE?from=project-issue)|增加安全启动签名|Accepted|sig-security-facility|[@huangzq6](https://gitee.com/huangzq6/)|EPOL|shim,grub2,kernel|
| | [I8M798](https://gitee.com/openeuler/release-management/issues/I8M798?from=project-issue)|负载算力协同|Accepted|sig-kernel|[@sereinInOpenEuler](https://gitee.com/sereinInOpenEuler/)|EPOL|kernel|

> 当前社区release分为以下几种方式: 标准 ISO/everything ISO/EPOL/独立镜像/ 独立发布
>
> 独立发布：不随openEuler版本发布，交付件不在repo.openeuler.org发布
> 独立镜像：随openEuler版本发布，交付件为非ISO、RPM的其余形式镜像

## 2.4 测试活动分工
 本次版本继承测试活动分工如下：

| **需求**                                  | **开发主体**                 | **测试主体**                 | **测试分层策略**                                             |
| ----------------------------------------- | ---------------------------- | ---------------------------- | ------------------------------------------------------------ |
| 支持UKUI桌面                              | sig-UKUI                     | sig-UKUI                     | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
| 支持DDE桌面                               | sig-DDE                      | sig-DDE                      | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
| 支持xfce桌面                              | xfce                         | xfce                         | 验证xfce桌面系统在openEuler版本上的可安装和基本功能          |
| 支持GNOME桌面                             | GNOME                        | GNOME                        | 验证gnome桌面系统在openEuler版本上的可安装和基本功能         |
| 支持Kiran桌面                             | sig-KIRAN-DESKTOP            | sig-KIRAN-DESKTOP            | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
| 支持南向兼容性                            | sig-Compatibility-Infra      | sig-QA                       | 验证openEuler版本在不同处理器上的可安装和可使用性，覆盖整机兼容性测试和社区集成测试 |
| 支持树莓派发布件                          | sig-RaspberryPi              | sig-RaspberryPi              | 对树莓派发布件进行安装、基本功能、兼容性及稳定性的测试       |
| 内核                                      | Kernel                       | Kernel                       | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 容器(isula/docker/安全容器/系统容器/镜像) | sig-CloudNative              | sig-CloudNative              | 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 虚拟化                                    | Virt                         | Virt                         | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能       |
| 编译器(gcc/jdk)                           | Compiler                     | sig-QA                       | 基于开源测试套对gcc和jdk相关功能进行验证                     |
| 支持HA软件                                | sig-Ha                       | sig-Ha                       | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
| 支持KubeSphere                            | sig-K8sDistro                | sig-K8sDistro                | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
| 支持OpenStack Train 和 Wallaby            | sig-OpenStack                | sig-OpenStack                | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能   |
| 支持A-Tune                                | A-Tune                       | A-Tune                       | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 支持secPave                               | sig-security-facility        | sig-QA                       | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
| 支持secGear                               | sig-confidential-computing   | sig-QA                       | 关注secGear特性的功能完整性                                  |
| 发布eggo                                  | sig-CloudNative              | sig-CloudNative              | 验证eggo在openEuler上的安装部署以及对K8S集群的部署、销毁、节点加入及删除的能力 |
| 支持kubeOS                                | sig-CloudNative              | sig-CloudNative              | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
| 支持NestOS                                | sig-CloudNative              | sig-CloudNative              | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 支持etmem内存分级扩展                     | Storage                      | sig-QA                       | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
| 支持定制裁剪工具(inageTailor和oemaker)    | sig-OS-Builder               | sig-QA                       | 验证可定制化的能力，包括裁剪工具的基本命令功能，并对异常参数进行覆盖；另外对裁剪出来的镜像进行安装部署及基本验证，保障裁剪工具的E2E能力完整性 |
| 支持虚拟化热补丁libcareplus               | Virt                         | Virt                         | 关注libcareplus提供Qemu热补丁能力                            |
| 支持用户态协议栈gazelle                   | sig-high-performance-network | sig-high-performance-network | 关注gazelle高性能用户态协议栈功能                            |
| 支持容器场景在离线混合部署rubik           | sig-CloudNative              | sig-CloudNative              | 结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 支持智能运维A-ops                         | sig-ops                      | sig-QA                       | 关注智能定位（异常检测、故障诊断）功能、可靠性               |
| 支持libstorage针对NVME的IO栈hsak          | Storage                      | Storage                      | 验证libstorage针对NVMe SSD存储介质提供高带宽低时延的IO软件栈，提升IO的读写性能；同时提供nvme磁盘状态管理以及查询功能，监测nvme磁盘的健康状态 |
| 支持国密算法                              | sig-security-facility        | sig-security-facility        | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
| 支持k3s                                   | sig-K8sDistro                | sig-K8sDistro                | 验证k3s软件的部署测试过程                                    |
| 支持KubeEdge                              | sig-edge                     | sig-edge                     | 验证KubeEdge的部署测试过程                                   |
| 支持pkgship                               | sig-EasyLife                 | sig-QA                       | 验证软件包依赖查询、生命周期管理、补丁查询等功能             |
| 支持mindspore                             | ai                           | ai                           | 验证mindspore相关软件包单包功能                              |
| 支持pod带宽管理oncn-bwm                   | sig-high-performance-network | sig-high-performance-network | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
| 支持基于分布式软总线扩展生态互联互通      | sig-embedded                 | sig-embedded                 | 验证openEuler和openHarmony设备进行设备认证，互通互联特性     |
| 支持混合关键部署技术扩展                  | sig-embedded                 | sig-embedded                 | 验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 支持硬实时系统                            | sig-embedded                 | sig-embedded                 | 验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力     |
| 支持kubernetes                            | sig-CloudNative              | sig-CloudNative              | 验证K8S在openEuler上的安装部署以及提供的对容器的管理能力     |
| 安装部署                                  | sig-OS-Builder               | sig-OS-Builder               | 验证覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| Kunpeng加速引擎                           | sig-AccLib                   | sig-AccLib                   | 验证对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加速器KAE的基本功能和性能测试 |
| 备份还原功能支持                          | sig-Migration                | sig-Migration                | 验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常 |
| ROS基础版和ROS2基础版                     | sig-ROS                      | sig-ROS                      | 验证ROS-COMM和ROS-BASE的安装卸载与基础功能正常               |

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试



# 3 版本概要测试结论

   openEuler 22.03 LTS SP3 版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 1轮重点特性测试 + 2轮全量测试 + 1轮回归测试 + 1轮版本发布验收测试；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项；第2轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫描及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；第3、4轮全量测试开展版本交付的所有特性和各类专项测试；第5轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；第6轮版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

   openEuler 22.03 LTS SP3 版本共发现问题 392 个，有效问题 371 个，无效问题 21 个。遗留问题 3 个(详见遗留问题章节)。版本整体质量良好。



# 4 版本详细测试结论

openEuler 22.03 LTS SP3 版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试、资料测试；

5、对版本新增特性进行功能、可靠性等专项测试，新增特性均满足发布要求，测试较充分，质量良好；



## 4.1   软件范围变化分析结论

### 4.1.1 标准ISO范围软件变化分析

经比较，openEuler-22.03-LTS-SP3 BaseOS相较openEuler-22.03-LTS-SP2 BaseOS范围没有变更。

详情可参考[openEuler-22.03-LTS-SP3-normal_aarch64.xml](https://gitee.com/src-openeuler/oemaker/blob/openEuler-22.03-LTS-SP3/normal_aarch64.xml)与[openEuler-22.03-LTS-SP3-normal_x86_64.xml](https://gitee.com/src-openeuler/oemaker/blob/openEuler-22.03-LTS-SP3/normal_x86_64.xml)

### 4.1.2 整体软件范围变化分析

经比较，openEuler-22.03-LTS-SP3对比openEuler-22.03-LTS-SP2存在13项版本号降级，但存在74项release号降级的软件，经定位系SP2 update版本同步升级时开发者处理流程不规范导致，此87项软件均已提单跟踪，除pytorch和sentencepiece外，其他均于RC4完成闭环。
issue链接：
https://gitee.com/src-openeuler/pytorch/issues/I8JEVL?from=project-issue
https://gitee.com/src-openeuler/sentencepiece/issues/I8I5C3?from=project-issue
迭代测试过程中，全量测试环节openEuler-22.03-LTS-SP3 RC3到RC4不存在软件版本降级，同时也不存在release降级。



## 4.2   特性测试结论

### 4.2.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                             |        特性质量评估        | 备注                                                         |
| ---- | ----------------------------------------- | :------------------------: | ------------------------------------------------------------ |
| 1    | 内核                                      | <font color=green>█</font> | 直接继承已有测试能力，重点关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
| 2    | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | 继承已有测试能力，重点关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
| 3    | 虚拟化(qemu/stratovirt)                   | <font color=green>█</font> | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能 |
| 4    | 编译器(gcc/jdk)                           | <font color=green>█</font> | 继承已有测试能力，基于开源测试套对gcc和jdk相关功能进行验证   |
| 5    | 支持DDE桌面                               | <font color=green>█</font> | 继承已有测试能力，关注DDE桌面系统的安装和基本功能            |
| 6    | 支持UKUI桌面                              | <font color=green>█</font> | 继承已有测试能力，关注UKUI桌面系统的安装和基本功能           |
| 7    | 支持xfce桌面                              | <font color=green>█</font> | 继承已有测试能力，重点关注xfce桌面的可安装性和提供组件的能力 |
| 8    | 支持gnome桌面                             | <font color=green>█</font> | 继承已有测试能力，关注gnome桌面系统的安装和基本功能          |
| 9    | 支持Kiran桌面                             | <font color=green>█</font> | 增强特性新增测试，其余继承已有测试能力，关注kiran桌面系统的安装和基本功能 |
| 10   | 支持南向兼容性                            | <font color=green>█</font> | 继承已有测试能力，关注板卡和整机适配的兼容性测试             |
| 11   | 支持北向兼容性                            | <font color=green>█</font> | 继承已有测试能力，关注软件所仓库对已正式release版本的北向软件的功能验证 |
| 12   | 支持树莓派                                | <font color=green>█</font> | 继承已有测试能力，关注树莓派系统的安装、基本功能及兼容性     |
| 13   | 支持HA软件                                | <font color=green>█</font> | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 |
| 14   | 支持KubeSphere                            | <font color=green>█</font> | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力 |
| 15   | 支持openstack Train 和 Wallaby            | <font color=green>█</font> | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能 |
| 16   | 支持A-Tune                                | <font color=green>█</font> | 继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 17   | 支持secPave                               | <font color=green>█</font> | 继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    |
| 18   | 支持secGear                               | <font color=green>█</font> | 继承已有测试能力，关注secGear特性的功能完整性                |
| 19   | 支持eggo                                  | <font color=green>█</font> | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 |
| 20   | 支持kubeOS                                | <font color=green>█</font> | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 |
| 21   | 支持NestOS                                | <font color=green>█</font> | 继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 22   | 支持etmem内存分级扩展                     | <font color=green>█</font> | 继承已有测试能力，重点验证特性的基本功能和稳定性             |
| 23   | 支持定制裁剪工具套件(oemaker/imageTailor) | <font color=green>█</font> | 继承已有测试能力，验证可定制化的能力                         |
| 24   | 支持虚拟化热补丁libcareplus               | <font color=green>█</font> | 继承已有测试能力，重点关注libcareplus提供Qemu热补丁能力      |
| 25   | 支持用户态协议栈gazelle                   | <font color=green>█</font> | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能      |
| 26   | 支持容器场景在离线混合部署rubik           | <font color=green>█</font> | 继承已有测试能力，结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 27   | 支持智能运维A-ops                         | <font color=green>█</font> | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性 |
| 28   | 支持国密算法                              | <font color=green>█</font> | 继承已有测试能力，验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
| 29   | 支持k3s                                   | <font color=green>█</font> | 继承已有测试能力，验证k3s软件的部署测试过程                  |
| 30   | 支持KubeEdge                              | <font color=green>█</font> | 继承已有测试能力，验证KubeEdge的部署测试过程                 |
| 31   | 支持pkgship                               | <font color=green>█</font> | 继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能 |
| 32   | 支持mindspore                             | <font color=green>█</font> | 继承已有测试能力，针对openCV、opencl-clhpp、onednn、Sentencepiece4个模块，复用开源测试能力覆盖安装、接口测试、功能测试，重点关注对mindspore提供能力的稳定性 |
| 33   | 支持pod带宽管理oncn-bwm                   | <font color=green>█</font> | 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
| 34   | 支持基于分布式软总线扩展生态互联互通      | <font color=green>█</font> | 继承已有测试能力，验证openEuler和openHarmony设备进行设备认证，互通互联特性 |
| 35   | 支持混合关键部署技术扩展                  | <font color=green>█</font> | 继承已有测试能力，验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 36   | 支持硬实时系统                            | <font color=green>█</font> | 继承已有测试能力，验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 |
| 37   | 支持kubernetes                            | <font color=green>█</font> | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 38   | 安装部署                                  | <font color=green>█</font> | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| 39   | Kunpeng加速引擎                           | <font color=green>█</font> | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 |
| 40   | 备份还原功能支持                          | <font color=green>█</font> | 验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常 |
| 41   | 支持ROS基础版和ROS2基础版42               | <font color=green>█</font> | 验证ROS-COMM和ROS-BASE的安装卸载与基础功能正常               |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.2.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **质量评估**    | **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | -------- |
|  1 | [支持Lustre server软件包](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler-22.03-LTS-SP3_Lustre-server_test-report.md) | Lustre server特性，执行基本功能sanity test suite共计大概900 tests，经过CI RPM包安装测试，本地单机自测，及本地集群4轮sanity全集测试，回归测试，发现问题已经解决，回归通过，无遗留风险。 |  |  | <font color=green>█</font> | |
|  2 | [eNFS特性合入]() | 未提供测试报告，拒绝 |  |  | <font color=red>●</font> |  |
|  3 | [DDE组件更新支持服务器场景优化](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03_LTS_SP3%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | DDE 特性全量测试一轮，合计执行用例450条，主要覆盖了基础组件、预装应用核心功能、新增特性基础功能以及基本UI测试。<br>发现问题4个，回归通过0个，遗留问题4个。<br>整体核心功能基本可满足使用。一些比较偏的功能点跟易用性并未关注。 |  |  | <font color=blue>▲</font> | |
|  4 | [FangTian视窗引擎特性合入](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler_%2022.03_LTS_SP3%20fangtian%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) |共4轮测试，设计11个场景，共有29个用例，整体核心功能稳定正常。共计46个ISSUE，当前未解决问题ISSUE1个，特性ISSUE3个，无风险，整体质量良好。 |  |  | <font color=green>█</font>  |  |
|  5 | [sysMaster支持虚机场景](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler_%2022.03_LTS_SP3%20sysMaster%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | sysmaster在openEuler 22.03-LTS-SP3测试虚拟机场景，执行19个测试用例，主要覆盖基本功能测试、接口测试、可靠性测试、安全测试，发现问题已解决，回归通过，无遗留风险，整体核心功能正常；devmaster在虚拟机场景上运行，执行103个测试用例，主要覆盖基本功能测试、接口测试、可靠性测试、安全测试，发现问题已解决，回归通过，无遗留风险，整体核心功能正常。 |  |  | <font color=green>█</font> |  |
|  6 | [支持树莓派](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03_LTS_SP3%20%E6%A0%91%E8%8E%93%E6%B4%BE%E9%95%9C%E5%83%8F%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | openEuler_22.03_LTS_SP3 树莓派镜像版本测试完成了功能测试，测试范围包括镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成了硬件兼容性测试，包括树莓派 3B、3B+、4B 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的兼容性验证。其中：系统安装 11 项用例、基本功能及配置 25 项用例、管理工具 53 项用例、硬件兼容性 36 项用例、开发环境验证 18 项用例、稳定性 1 项用例，合计 144 项用例。 |  |  | <font color=green>█</font> |  |
|  7 | [增加 migration-tools 项目发布](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03_LTS_SP3%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 见DDE测试报告 |  |  | <font color=blue>▲</font> |  |
|  8 | [增加 utshell 项目发布](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03_LTS_SP3%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 见DDE测试报告 |  |  | <font color=blue>▲</font>  |  |
|  9 | [增加 utsudo 项目发布](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03_LTS_SP3%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 见DDE测试报告 |  |  | <font color=blue>▲</font> |  |
| 10 | [增加i3相关软件包发布](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler_22.03_LTS_SP3%20i3%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | i3 window manager特性，共计执行4个场景用例，108个接口测试用例，主要覆盖了安装，卸载，基本功能测试，扩展功能测试，用例全部通过，整体质量较好。 |  |  | <font color=green>█</font>  |  |
| 11 | [支持入侵检测框架secDetector](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/secDetector%E5%85%A5%E4%BE%B5%E6%A3%80%E6%B5%8B%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 测试secdetector入侵检测特性，共计新增25个用例，所覆盖整场景表现符合预期，攻击行为无漏报，整体质量良好。 |  |  | <font color=green>█</font>  |  |
| 12 | [支持embedded版本](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler-22.03-LTS-SP3%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 22.03 LTS SP2 embedded版本详细测试内容包括：<br>1.完成基础OS质量保障，包括内核、系统调用、glibc以及基础软件包的功能测试，测试功能正常，问题已跟踪闭环；<br>2.对关键特性，如软实时能力、分布式软总线、硬实时posix接口、meta-ros能力，x86设备支持等进行了专项测试，关键特性符合要求，测试功能正常，问题已跟踪闭环；<br>3.其他专项测试包括安全专项、兼容性测试以及可靠性测试，完成各项专项测试，测试正常，问题已跟踪闭环；<br>4.软实时能力、基础软件包支持等22.03 LTS、22.03 LTS SP1、22.03 LTS SP3继承需求也进行了测试，测试功能正常，问题已跟踪闭环； |  |  | <font color=green>█</font> |  |
| 13 | [NestOS For-Virt/For-Container多版本支持](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03%20LTS%20SP3%2020231231%E7%89%88%E6%9C%ACNestOS%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | NestOS 22.03 LTS SP3.20231231 版本整体测试按照计划共完成了一轮重点特性测试+一轮专项测试+一轮应用场景测试+一轮回归测试；其中第一轮重点特性测试聚焦在ignition自定义配置、nestos-installer安装、容器引擎、zincati自动升级、rpm-ostree原子化更新+双根文件分区的特性验证、NKD功能测试、PilotGo功能测试、x2NestOS功能测试、Rubik在离线混部功能测试、新增内核特性测试；>一轮专项测试开展版本交付的各类专项测试；一轮应用场景测试进行K8S的安装部署并验证各组件和服务正常工作；一轮性能测试；一轮回归测试重点覆盖特性测试，验证问题的修复程度。 NestOS 22.03 LTS SP3.20231231 版本共发现问题 1 个，有效问题 1 个，0个遗留问题，1个问题已修复，回归测试结果正常，版本整体质量较好。 |  |  | <font color=green>█</font> |  |
| 14 | [gazelle支持vlan收发](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03-LTS-SP3%E7%89%88%E6%9C%AC%E5%85%B1%E7%BA%BF%E7%A8%8B%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 执行新增特性用例22个，继承用例98个，覆盖特性的基本功能测试、可靠性测试、性能测试、长稳测试，发现9个有效问题。 |  |  | <font color=green>█</font> |  |
| 15 | [gazelle支持网卡自愈](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03-LTS-SP3%E7%89%88%E6%9C%AC%E5%85%B1%E7%BA%BF%E7%A8%8B%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 同需求“gazelle支持vlan收发” |  |  | <font color=green>█</font> |  |
| 16 | [gazelle支持netperf标准测试工具](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler-22.03-LTS-SP3%E7%89%88%E6%9C%ACgazelle%20redis%E8%B4%A8%E9%87%8F%E5%8A%A0%E5%9B%BA%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | gazelle redis质量加固特性，共计执行140个用例，主要覆盖了功能测试测试、可靠性测试、性能测试，通过经过7*24的长稳测试，发现12个issue |  |  | <font color=blue>▲</font> |  |
| 17 | [gazelle支持ipv6协议栈基本功能](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03-LTS-SP3%E7%89%88%E6%9C%AC%E5%85%B1%E7%BA%BF%E7%A8%8B%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 同需求“gazelle支持vlan收发” |  |  | <font color=green>█</font> |  |
| 18 | [gazelle支持bond6模式](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03-LTS-SP3%E7%89%88%E6%9C%AC%E5%85%B1%E7%BA%BF%E7%A8%8B%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 同需求“gazelle支持vlan收发” |  |  | <font color=green>█</font> |  |
| 19 | [grub2支持国密度量内核并上报度量信息](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler_22.03_LTS_SP3%20TPCM%E9%9C%80%E6%B1%82%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | TPCM需求，共1轮测试，设计场景3个，共有用例11个。覆盖基本功能。 无issue，特性质量良好。 |  |  | <font color=green>█</font> |  |
| 20 | [shim支持国密度量grub2并上报度量信息](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler_22.03_LTS_SP3%20TPCM%E9%9C%80%E6%B1%82%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | TPCM需求，共1轮测试，设计场景3个，共有用例11个。覆盖基本功能。 无issue，特性质量良好。 |  |  | <font color=green>█</font> |  |
| 21 | [分布式软总线功能增强，易用性提升](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler-22.03-LTS-SP3%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 见embeded版本测试报告 |  |  | <font color=green>█</font>  |  |
| 22 | [分布式软总线容器适配，支持跨节点跨容器通信](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler-22.03-LTS-SP3%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 见embeded版本测试报告 |  |  | <font color=green>█</font> |  |
| 23 | [iSulad支持oci runtime并且切换默认runtime为runc](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler_22.03_LTS_SP3%20iSulad%E6%94%AF%E6%8C%81oci%20runtime%E5%B9%B6%E4%B8%94%E5%88%87%E6%8D%A2%E9%BB%98%E8%AE%A4runtime%E4%B8%BArunc%20%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共2轮测试，设计场景5个，共有用例17个，继承用例执行2753个。覆盖功能，可靠性。 发现4个issue，已全部解决合入，特性质量良好。 |  |  | <font color=green>█</font> |  |
| 24 | [syscare组件支持容器化热补丁制作场景](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03_LTS_SP3%20syscare%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | syscare特性测试，共计执行31个用例，覆盖60个测试点，主要包括syscare build以及syscare管理功能，包括接口正向，负向的功能测试、以及可靠性测试，并发测试，长稳测试，资料测试，安全测试。测试过程共发现问题12个，当前遗留8个问题。 |  |  | <font color=blue>▲</font> |  |
| 25 | [增加进程完整性防护特性](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/%E5%A2%9E%E5%8A%A0%E8%BF%9B%E7%A8%8B%E5%AE%8C%E6%95%B4%E6%80%A7%E9%98%B2%E6%8A%A4%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 增加进程完整性防护，共计执行50个用例，主要覆盖了： 1、覆盖dim_core、dim_monitor模块的对外接口以及启动参数的正常值、异常值、边界值等测试； 2、覆盖dim_tools工具针对用户态程序、ko、内核代码生成静态基线测试； 3、覆盖用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量测试； 4、覆盖度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量测试； 5、覆盖dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等； 6、覆盖全量安装环境下，针对所有用户态程序、ko、内核代码段的动态基线创建及度量测试； 7、覆盖策略文件、静态基线文件、度量日志最大值测试； 8、覆盖dim_core、dim_monitor模块对外接口的并发测试，以及基线创建与卸载模块的并发测试； 9、覆盖反复进行dim_core、dim_monitor动态基线创建、动态度量测试。 |  |  | <font color=green>█</font> |  |
| 26 | [AOPS功能增强，支持任务粒度回退](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler%2022.03-LTS-SP3%E7%89%88%E6%9C%ACAops%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 在继承现有功能的基础上，本次新增两大特性，其中包括：客户端支持内核升级和回退、服务端支持内核升级可回退;五轮测试共计执行945个用例，覆盖特性的接口、基本功能和web页面测试。 |  |  | <font color=green>█</font> |  |
| 27 | [DPU直连聚合：虚拟机、容器管理面DPU卸载，业务无感知](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/DPU%E7%9B%B4%E8%BF%9E%E8%81%9A%E5%90%88%EF%BC%9A%E8%99%9A%E6%9C%BA%E3%80%81%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86%E9%9D%A2DPU%E5%8D%B8%E8%BD%BD%E6%96%B0%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共3轮测试，设计场景7个，共有用例17个，覆盖功能，安全，可靠性测试。 经验证，共提了5个issue，当前遗留0个issue，均已验证关闭，特性质量良好，整体基础功能部分较为稳定。 |  |  | <font color=green>█</font> |  |
| 28 | [支持内核态vDPA框架实现网卡直通虚机可热迁移](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler_22.03_LTS_SP3%E7%89%88%E6%9C%AC%E6%99%BA%E8%83%BD%E7%BD%91%E5%8D%A1%E5%86%85%E6%A0%B8%E6%80%81vDPA%E8%AE%BE%E5%A4%87%E6%94%AF%E6%8C%81%E7%83%AD%E8%BF%81%E7%A7%BB%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 共计执行用例22个，主要覆盖了功能测试、性能测试。测试过程通过功能测试，发现1个主要问题，3个次要问题，现已解决，回归测试通过，整体质量良好 |  |  | <font color=green>█</font> |  |
| 29 | [支持safeguard软件包](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler-22.03-LTS-SP3-%E7%89%88%E6%9C%ACsafeguard%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 针对safeguard特性，，共计执行54个测试用例，主要覆盖了功能测试、接口测试、发现问题均已修复并回归通过，无风险，整体质量良好。 经过了测试，发现4个问题，均回归通过，整体质量良好。 |  |  | <font color=green>█</font> |  |
| 30 | [libtpms支持sm3算法]() | 未提供测试报告，拒绝 |  |  | <font color=red>●</font> |  |
| 31 | [增加安全启动签名](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP3/openEuler-22.03-LTS-SP3%20%E6%94%AF%E6%8C%81%E7%AD%BE%E5%90%8D%E8%AF%81%E4%B9%A6%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 证书导入BIOS db证书库、dbx证书库，及sbat防回滚的安全启动功能测试，结果符合要求;证书导入BIOS db证书库后在系统启动过程中重启测试，结果符合要求;证书导入后开启或关闭安全启动的系统时间对比，结果符合要求 |  |  | <font color=green>█</font> |  |
| 32 | [负载算力协同](待刷新) | 待刷新 |  |  |  |  |


<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好



## 4.3   兼容性测试结论

### 4.3.1   升级兼容性

openEuler 22.03-LTS-SP3 作为 openEuler 22.03-LTS SP2版本的增强扩展版本，支持从LTS SP2版本升级到对应的LTS SP3，完成如下场景的升级验证：

1、从22.03 LTS SP2到22.03 LTS SP3版本的升降级

2、升降级后系统的重启

上述场景下，软件包升降机后的功能验证、服务检查等测试；新增软件包通过对软件直接进行安装来进行；整体升级兼容性功能正常。

### 4.3.2   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成41张板卡的测试(该数目仅为测试数量，实际兼容性认证通过数量见社区[兼容性清单](https://www.openeuler.org/zh/compatibility/))

此版本的板卡兼容性适配测试，适配的板卡类型有（待刷新）种，在aarch64/x86_64架构上进行适配，主要使用社区硬件兼容性测试工具oec-hardware集成compass-ci进行自动化测试，适配完成后将在社区发布此版本的板卡兼容性清单。

下表列出版本集成验证中涉及的硬件板卡信息：

| **板卡类型** | **覆盖范围**    | **测试主体**      | **chipVendor** | **boardModel**     | **chipModel**      | **测试结果** |
| ------------ | --------------- | ----------------- | -------------- | ------------------ | ------------------ | ------------ |
| RAID         | 适配7张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Avago          | 9560-8i            | SAS3908            | PASS         |
|              |                 |                   | Broadcom          | SP460C-M           | SAS3516            | PASS         |
|              |                 |                   | Avago          | SR150-M            | SAS3408            | PASS         |
|              |                 |                   | Avago          | SR430C-M           | SAS-3 3108         | PASS         |
|              |                 |                   | Avago          | SR450C-M           | SAS3508         | PASS         |
|              |                 |                   | Avago          | SR130              | SAS3008            | PASS         |
|              |                 |                   | PMC          | PMC3152           | PM8204            | PASS         |
| FC           | 适配11张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Emulex         | LPe36002-M64       | LPe35000/LPe36000  | PASS         |
|              |                 |                   | Qlogic         | QLE2560            | ISP2532            | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2690          | ISP2722            | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2692            | ISP2722            | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2740            | ISP2722            | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2742            | ISP2722            | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2870            | ISP2812            | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2872            | ISP2812            | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2770            | ISP2812            | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2772            | ISP2812            | PASS         |
|              |                 |                   | Emulex         | LPe31002-M6        | LPe31000/LPe32000  | PASS         |
| GPU          | 适配3张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | NVIDIA         | Tesla T4           | TU104GL            | PASS         |
|              |                 |                   | NVIDIA         | Tesla V100         | GV100GL            | PASS         |
|              |                 |                   | NVIDIA         | Tesla A100         | GA100              | PASS         |
| SSD          | 适配1张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Huawei         | ES3600C V5-3200GB  | ES3000       | PASS         |
| IB           | 适配2张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Mellanox       | SP350              | ConnectX-5         | PASS         |
|              |                 |                   | Mellanox       | MCX653105A-EFAT    | ConnectX-6         | PASS         |
| NIC          | 适配NIC板卡17张 | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Intel          | E810-XXV-2        |E810-XXV           | PASS         |
|              |                 |                   | Huawei         | SP580              | Hi1822             | PASS         |
|              |                 |                   | Mellanox       | SP382              | ConnectX-5         | PASS         |
|              |                 |                   | Mellanox       | SP380              | ConnectX-4 Lx      | PASS         |
|              |                 |                   | Intel          | I350-F2            | I350               | PASS         |
|              |                 |                   | Intel          | SP310            | 82599ES               | PASS         |
|              |                 |                   | Intel          | XL710-Q1            | XL710               | PASS         |
|              |                 |                   | Huawei          | SP680            | Hi1822               | PASS         |
|              |                 |                   | Ramaxel          | 3S910            | Gemini               | PASS         |
|              |                 |                   | Ramaxel          | 3S580            | Aires               | PASS         |
|              |                 |                   | Netswift       | RP1000      | RP1000      | PASS         |
|              |                 |                   | Netswift       | RP2000      | RP2000      | PASS         |
|              |                 |                   | Netswift          | SF200HT         | SF200HT              | PASS         |
|              |                 |                   | Netswift       | SF200T             | SF200T | PASS         |
|              |                 |                   | Netswift        | SF400HT            | SF 400HT               | PASS         |
|              |                 |                   | Netswift          | SF 400T         | SF400T               | PASS         |
|              |                 |                   | Yunsilicon      | metaConnect-50      | metaConnect               | PASS         |

此版本的整机兼容性适配测试主要使用社区开源硬件兼容性测试工具oec-hardware，从整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性等方面进行适配，适配完成后将在社区发布此版本的整机兼容性清单。

整机适配兼容性测试交付清单如下：

| **整机厂商** | **整机型号**             | **CPU型号**   | **测试主体**      | **测试结果** |
| ------------ | ------------------------ | ------------- | ----------------- | ------------ |
| 华为          | 泰山200                  | 鲲鹏920       | sig-Compatibility | PASS         |
|              | S920X20                  | 鲲鹏920B     | sig-Compatibility | PASS         |
| 中科可控      | Suma R6240HA             | Hygon3     | sig-Compatibility | PASS         |
| AMD          | AS-4124GS-TNR            | AMD EPYC 7513     | sig-Compatibility | PASS     |
| 超聚变        | 2288H V5                 | Intel cascade | sig-Compatibility | PASS         |
| 飞腾         | Phytium S5000C Server    | S5000C       | sig-Compatibility | PASS         |
| 新华三        | R4950G6                 | AMD eypc4      | sig-Compatibility | PASS         |
| 兆芯         | ThinkSystem SR658Z       | KH-30000      | sig-Compatibility | PASS         |

整机兼容性清单以sig-Compatibility-Infra提供为主，社区各sig测试过程中使用的机器因未进行oec-hardware测试(进入社区兼容性清单质量要求)，故无法直接进行兼容性清单不在此描述。

### 4.3.3   虚拟机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 | 备注                                   |
| ---------- | ----------------------- | ------- | -------- | -------------------------------------- |
| openEuler 22.03 LTS SP3  | Centos 6 | x86_64 | PASS |         |
| openEuler 22.03 LTS SP3  | Centos 7 | aarch64 | PASS |         |
| openEuler 22.03 LTS SP3  | Centos 7 | x86_64  | PASS |         |
| openEuler 22.03 LTS SP3  | Centos 8 | aarch64 | PASS |         |
| openEuler 22.03 LTS SP3  | Centos 8 | x86_64  | PASS |         |
| openEuler 22.03 LTS SP3  | Windows Server 2016 | aarch64 | PASS |         |
| openEuler 22.03 LTS SP3  | Windows Server 2016 | x86_64  | PASS |         |
| openEuler 22.03 LTS SP3  | Windows Server 2019 | aarch64 | PASS |         |
| openEuler 22.03 LTS SP3  | Windows Server 2019 | x86_64  | PASS |         |



## 4.4   专项测试结论

### 4.4.1 安全测试

整体安全测试覆盖：

1、Linux系统安全配置管理类主要包括：服务管理、账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等进行全量测试

2、通过工具进行CVE漏洞/敏感信息/端口矩阵/编译选项扫描/交付件病毒扫描

3、白盒安全测试主要通过fuzz测试实现对接口参数类和内存管理类进行覆盖；对重点软件包开展oss-fuzz测试；利用开源测试工具csmith/javafuzzer/jfuzz对编译器组件行fuzz测试；

4、针对安全加固指南中的加固项，进行全量测试。

整体OS安全测试较充分，风险可控。

### 4.4.2 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                                                    |
| ------------ | ------------------------------------------------------------ | ----------------------------------------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | RC2 7x24h(通过)<br />RC4 7x24h(通过)<br />RC5 7*24h(进行中) |

### 4.4.3 性能测试

| **指标大项** | **指标小项**                                                 | **指标值**                        | **测试结论**     |
| ------------ | ------------------------------------------------------------ | --------------------------------- | ---------------- |
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考22.03 LTS SP2版本相应指标基线 | 比较前一版本持平 |



# 5   问题单统计

openEuler 22.03 LTS SP3 版本共发现问题 392 个，有效问题 371 个，其中遗留问题 3 个。详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注        |
| --------------------------- | -------- | ------------ | ------------ | ------------ | -------------------------- |
| openEuler 22.03 LTS SP3 dailybuild | 56    | 55      | 1   | 1      | 每日构建   |
| openEuler 22.03 LTS SP3 alpha      | 28    | 25      | 3   | 1      | Alpha轮次   |
| openEuler 22.03 LTS SP3 RC1        | 119   | 112     | 5   | 1      | Beta轮次  |
| openEuler 22.03 LTS SP3 RC2        | 62    | 55      | 7   | 0      | 全量集成 |
| openEuler 22.03 LTS SP3 RC3        | 70    | 65      | 5   | 0      | 全量集成  |
| openEuler 22.03 LTS SP3 RC4        | 28    | 28      | 0   | 0      | 回归测试    |
| openEuler 22.03 LTS SP3 RC5        |  0    |  0      | 0   | 0      | 版本发布验收测试(回归测试) |



# 6 版本测试过程评估

#### 6.1 问题单分析

除去开发自验轮次，本次版本测试各迭代有效问题数量呈收敛趋势，没有问题溢出的风险。其中第一轮迭代中的112个有效问题中，有1项严重问题，75项主要问题，均已修复，全部完成回归；第二轮迭代中共62个有效问题，其中13项主要问题，均已修复。

- 关键问题类型：软件版本/release号相较openEuler-22.03-LTS-SP2最新update较低

  此类问题约有87项，大多数因社区开发者在master分支进行升级后，直接将patch同步到22.03-LTS-SP2分支，而非先同步到openEuler-22.03-LTS-Next上再同步SP2导致，为流程规范问题。

#### 6.2 OS集成测试迭代版本基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 22.03 LTS SP3 alpha | 冒烟测试         |                                |
| openEuler 22.03 LTS SP3 RC1 | 冒烟测试         |                                |
|                             | 包管理专项       | rpm包管理                      |
|                             |                  | source包自编译                 |
|                             | 重启专项专项     | 冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             | 文件系统专项     |                                |
|                             | 网络系统专项     |                                |
|                             | 安全专项         | 漏洞扫描                       |
|                             |                  | 敏感词扫描                     |
|                             |                  | 病毒扫描                       |
|                             |                  | 端口扫描                       |
|                             |                  | 安全编译选项扫描               |
|                             |                  | 安全组件测试-firewalld         |
|                             |                  | 安全加固指南测试-secure_guide  |
|                             |                  | 社区安全加固测试               |
|                             | 性能专项         | 基础性能测试                   |
|                             | 安装部署         | 标准镜像                       |
|                             |                  | everything镜像                 |
|                             |                  | 网络镜像                       |
|                             |                  | stratovirt镜像                 |
|                             | 单包命令         | everything全量测试             |
|                             | 单包服务         | everything全量测试             |
|                             | 系统集成         | 管理员指南测试                 |
|                             |                  | 应用开发测试                   |
|                             |                  | httpd场景测试                  |
|                             |                  | nginx场景测试                  |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                       |
|                             |                  | 长稳测试                       |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 编译器专项       | gcc测试                        |
| openEuler 22.03 LTS SP3 RC2 | 冒烟测试         |                                |
|                             | 包管理专项       | rpm包管理                      |
|                             |                  | source包自编译                 |
|                             | 文件系统专项     |                                |
|                             | 安全专项         | 敏感词扫描                     |
|                             |                  | 病毒扫描                       |
|                             |                  | oss-fuzz测试                   |
|                             | 性能专项         | 基础性能测试                   |
|                             | 版本变化专项     | 软件范围变化测试               |
|                             | 安装部署         | 标准镜像                       |
|                             | 单包命令         | everything全量测试             |
|                             | 单包服务         | everything全量测试             |
|                             | 系统集成         | 管理员指南测试                 |
|                             |                  | 应用开发测试                   |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 编译器专项       | gcc测试                        |
|                             |                  | openjdk测试                    |
| openEuler 22.03 LTS SP3 RC3 | 冒烟测试         |                                |
|                             | 包管理专项       | rpm包管理（增量变动部分）      |
|                             |                  | source包自编译（增量变动部分） |
|                             | 文件系统专项     |                                |
|                             | 网络系统专项     |                                |
|                             | 安全专项         | oss-fuzz测试                   |
|                             |                  | 安全组件测试-firewalld         |
|                             |                  | 安全加固指南测试-secure_guide  |
|                             |                  | 社区安全加固测试               |
|                             | 性能专项         | 基础性能测试                   |
|                             | 安装部署         | 标准镜像                       |
|                             |                  | everything镜像                 |
|                             |                  | 网络镜像                       |
|                             |                  | stratovirt镜像                 |
|                             | 单包命令         | everything增量变动测试         |
|                             | 单包服务         | everything增量变动测试         |
|                             | 系统集成         | 管理员指南测试                 |
|                             |                  | 应用开发测试                   |
|                             |                  | httpd场景测试                  |
|                             |                  | nginx场景测试                  |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 多动态库检查专项 |                                |
|                             | 编译器专项       | gcc测试                        |
|                             |                  | openjdk测试                    |
| openEuler 22.03 LTS SP3 RC4 | 冒烟测试         |                                |
|                             | 包管理专项       | rpm包管理（增量变动部分）      |
|                             |                  | source包自编译（增量变动部分） |
|                             | 重启专项专项     | 冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             | 安全专项         | 安全编译选项扫描               |
|                             |                  | 病毒扫描                       |
|                             |                  | 端口扫描                       |
|                             |                  | 安全加固指南测试               |
|                             |                  | 社区安全加固测试               |
|                             |                  | oss-fuzz测试                   |
|                             | 性能专项         | 基础性能测试                   |
|                             | OS兼容性专项     | 虚拟机兼容性测试               |
|                             |                  | 容器兼容性测试                 |
|                             | 版本变化检查专项 | 软件范围变化测试               |
|                             | 安装部署         | 标准镜像                       |
|                             | 单包命令         | everything增量变动测试         |
|                             | 单包服务         | everything增量变动测试         |
|                             | 系统集成         | 管理员指南测试                 |
|                             |                  | 应用开发测试                   |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             | 编译器专项       | gcc测试                        |
|                             |                  | openjdk测试                    |
| openEuler 22.03 LTS SP3 RC5 | 版本发布验收     | 版本发布验收                   |

# 6   附件

## 遗留问题列表

| 序号 | 问题单号    | 问题简述    | 问题级别 | 影响分析   | 规避措施       | 历史发现场景     |
| ---- | ------------------------------------------------------------ | ----------------------------------------------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | [I8JEVL](https://gitee.com/src-openeuler/pytorch/issues/I8JEVL?from=project-issue) | 【[22.03-LTS-SP3]pytorch在22.03-LTS-SP3中相比22.03-LTS-SP2版本降级 | 主要  | 属于AI sig，版本预期包含的软件包，版本降级，需解决，风险低，无人维护 | 安装成功，待评估是否遗留 | |
| 2    | [I8I5C3](https://gitee.com/src-openeuler/sentencepiece/issues/I8I5C3?from=project-issue) | 22.03-SP3-alpha】sentencepiece包在22.03-LTS-SP3中相比22.03-LTS-SP2版本降级 | 主要  | 属于AI sig，版本预期包含的软件包，版本降级，需解决，风险低，无人维护 | 安装成功，待评估是否遗留 | |
| 3    | [I8QXIA](https://gitee.com/src-openeuler/opencv/issues/I8QXIA?from=project-issue) | 【[EulerMaker] opencv build problem in openEuler-22.03-LTS-SP3:epol | 不重要     | 属于AI sig，构建过程测试用例执行失败，需解决，风险低，无人维护 | 规避check阶段可构建成功 | |



# 致谢
非常感谢以下sig在openEuler 22.03 LTS SP2 版本测试中做出的贡献,以下排名不分先后
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
以及所有参与22.03 LTS SP3但未统计到的所有开发者
(如有遗漏可随时联系 @disnight email:fjc837005411@outlook.com 反馈)
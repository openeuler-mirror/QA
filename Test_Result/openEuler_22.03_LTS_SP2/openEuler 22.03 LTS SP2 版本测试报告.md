![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2023/06/15 | 1.0.0    | 初稿, 基于RC1/2/3 | Ethan-Zhang |


关键词：

openEuler raspberrypi DDE Lustre-Client sysMaster ROS2-humble OpenStack kunpengsecl secGear embedded oemaker gazelle iSulad A-Ops nosva NestOS N1045XS 

摘要：

文本主要描述openEuler 22.03 LTS SP2 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.03 LTS SP2 版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 22.03 LTS SP2 是基于5.10内核22.03-LTS-SP1的补丁增强版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 22.03 LTS-Next分支拉出，发布范围相较22.03 LTS版本主要变动：

1. 软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP2/openEuler-22.03-LTS-SP2%20%E5%8D%87%E7%BA%A7%E9%80%89%E5%9E%8B.md)
2. 修复bug和cve
3. DDE组件、SecGear、oemaker、gazelle、NestOS、Rubik、AOps、iSulad等特性增强
4. 新增Lustrte Client、ROS2-humble、kiran-desktop2.5、sysmonitor等软件
5. 新增星云智联板卡N1045XS网卡驱动

## 2.1 版本测试计划
openEuler 22.03 LTS SP2 版本按照社区release-manager团队的计划，共规划6轮测试，详细的版本信息和测试时间如下表：

| 版本名称     | 测试起始时间 | 测试结束时间   | 备注                                                         |
| ------------ | ------------ | -------------- | ------------------------------------------------------------ |
| Test round 1 | 2023-05-17   | 2023-05-23     | 开发自验证                                                   |
| Test round 2 | 2023-05-24   | 2023-06-02     | 22.03-LTS SP2 Beta版本发布                                   |
| Test round 3 | 2023-06-03   | **2023-06-15** | 全量SIT验证（**延期6天**，原因详见**6.2章节**）              |
| Test round 4 | 2023-06-15   | 2023-06-21     | 全量SIT验证，版本分支代码冻结：管控合入，原则上只允许bug fix |
| Test round 5 | 2023-06-25   | 2023-06-27     | 回归测试                                                     |
| Test round 6 | 2023-06-28   | 2023-06-30     | 回归测试                                                     |
| release      | 2023-06-30   | 2023-06-30     | 社区Release版本发布评审                                      |

## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920                              | OS集成测试     |
| RH2288H V5             | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| 树莓派 4B              | BCM2711                                  | 嵌入式版本测试 |
| STM32F407ZGT6开发板    | CPU:STM32F407ZG(168MHz)                  | 嵌入式版本测试 |
| 超聚变 2288H V3        | Intel cascade                            | 南向兼容性测试 |

## 2.3 需求清单

openEuler 22.03 LTS SP2版本交付需求列表如下，详情见[openEuler-22.03-LTS-SP2 release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP2/release-plan.md)：

| no   | feature                                                      | status   | sig                          | owner                                                        | 发布方式         | 备注                                        |
| ---- | ------------------------------------------------------------ | -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | ------------------------------------------- |
| 1    | [DDE组件更新](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Accepted | sig-DDE                      | [@HelloWorld_lvcongqing](https://gitee.com/HelloWorld_lvcongqing/) | EPOL             |                                             |
| 2    | [支持Lubstre client软件包](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Accepted | sig-SDS                      | [@xin3liang](https://gitee.com/xin3liang)                    | EPOL             |                                             |
| 3    | [支持树莓派](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Accepted | sig-RaspberryPi              | [@woqidaideshi](https://gitee.com/woqidaideshi/)             | EPOL             | 为继承需求，于新版本做适配                  |
| 4    | [openEuler docker容器支持sysMaster管理sshd服务](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Accepted | dev-utils                    | [@overweight](https://gitee.com/overweight/)                 | Everything ISO   |                                             |
| 5    | [支持ROS2-humble基础版](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Accepted | dev-utils                    | [@overweight](https://gitee.com/overweight/)                 | EPOL             |                                             |
| 6    | [支持OpenStack Train、Wallaby多版本](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Accepted | dev-utils                    | [@overweight](https://gitee.com/overweight/)                 | EPOL             |                                             |
| 7    | [内核支持容器资源可见性功能](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Rejected | sig-kernel                   | [@wenzhiwei11](https://gitee.com/wenzhiwei11/)               | 标准 ISO         |                                             |
| 8    | [内核新增UKFEF功能](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Rejected | sig-kernel                   | [@wenzhiwei11](https://gitee.com/wenzhiwei11/)               | 标准 ISO         |                                             |
| 9    | [内核支持Group identity功能](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Rejected | sig-kernel                   | [@wenzhiwei11](https://gitee.com/wenzhiwei11/)               | 标准 ISO         |                                             |
| 10   | [新增kunpengsecl软件包支持平台和TEE远程证明](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Accepted | sig-security-facility        | [@gwei3](https://gitee.com/gwei3/)                           | EPOL             |                                             |
| 11   | [secGear特性增强](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Accepted | sig-confidential-computing   | [@houmingyong](https://gitee.com/houmingyong/)               | EPOL             |                                             |
| 12   | [支持embedded版本](https://gitee.com/openeuler/QA/blob/master/Test_Strategy/openEuler_22.03_LTS_SP2/openEuler_22.03_LTS_SP2版本测试策略.md) | Accepted | sig-embedded                 |                                                              | 独立镜像         | 为继承需求，相关新增需求于embeded版本跟踪   |
| 13   | [新增通用编译环境制作能力](https://gitee.com/openeuler/release-management/issues/I71TYY) | Accepted | sig-OS-Builder               | [@chen-huihan](https://gitee.com/chen-huihan/)               | EPOL             |                                             |
| 14   | [支持qcow2格式镜像制作](https://gitee.com/openeuler/release-management/issues/I71TEN) | Accepted | sig-Gatekeeper               | [@chen-huihan](https://gitee.com/chen-huihan/)               | EPOL             |                                             |
| 15   | [oemaker特性增强](https://gitee.com/openeuler/release-management/issues/I71TS7) | Accepted | sig-OS-Builder               | [@zhuchunyi](https://gitee.com/zhuchunyi/)                   | EPOL             |                                             |
| 16   | [回合bwm特性，支持面向容器的网络带宽调度策略](https://gitee.com/openeuler/release-management/issues/I71V5A) | Accepted | sig-high-performance-network | [@kwb0523](https://gitee.com/kwb0523/)                       | Everything   ISO |                                             |
| 17   | [开发流水线打通构建/compass-ci/测试radiaTest 3大服务](https://gitee.com/openeuler/release-management/issues/I72C4A) | Accepted | sig-QA                       | [@disnight](https://gitee.com/disnight/)                     | 独立发布         | 不处于openEuler自身软件范围，为社区工程能力 |
| 18   | [发布kiran-desktop 2.5版本](https://gitee.com/openeuler/release-management/issues/I729JF) | Accepted | sig-KIRAN-DESKTOP            | [@tangjie02](https://gitee.com/tangjie02/)                   | EPOL             |                                             |
| 19   | [iSulad支持K8S 1.24 /1.25版本](https://gitee.com/openeuler/release-management/issues/I727Q4) | Accepted | iSulad                       |                                                              | EPOL             |                                             |
| 20   | [CICD支持：实现热补丁流水线发布，用户可以通过补丁服务制作补丁](https://gitee.com/openeuler/release-management/issues/I727OZ) | Accepted | sig-ops                      | [@solarhu](https://gitee.com/solarhu/)                       | 独立发布         | 不处于openEuler自身软件范围，为社区工程能力 |
| 21   | [热补丁服务：热补丁流水线/管理框架，支持热补丁发布](https://gitee.com/openeuler/release-management/issues/I727OP) | Accepted | sig-ops                      | [@solarhu](https://gitee.com/solarhu/)                       | EPOL             |                                             |
| 22   | [Rubik混部支持精细化资源QoS感知和控制](https://gitee.com/openeuler/release-management/issues/I727NW) | Accepted | sig-CloudNative              | [@jing-rui](https://gitee.com/jing-rui/)                     | EPOL             |                                             |
| 23   | [支持 sysmonitor 特性](https://gitee.com/openeuler/release-management/issues/I727H4) | Accepted | sig-ops                      | [@cp3yeye](https://gitee.com/cp3yeye/)                       | EPOL             |                                             |
| 24   | [Gazelle新增支持UDP协议](https://gitee.com/openeuler/release-management/issues/I727E2) | Accepted | sig-high-performance-network | [@kircher](https://gitee.com/kircher/)                       | EPOL             |                                             |
| 25   | [安全配置规范框架设计及核心内容构建](https://gitee.com/openeuler/release-management/issues/I727A5) | Accepted | sig-ops                      | [@yunjia_w](https://gitee.com/yunjia_w/)                     | 标准 ISO         |                                             |
| 26   | [gala-gopher新增性能火焰图、线程级性能Profiling特性](https://gitee.com/openeuler/release-management/issues/I6YYUC) | Rejected | sig-ops                      | [@Vchanger](https://gitee.com/Vchanger/)                     | EPOL             |                                             |
| 27   | [5.10内核hisi_sec2 hisi_hpre hisi_zip模块支持nosva特性](https://gitee.com/openeuler/release-management/issues/I6YBPV) | Rejected | Kernel                       | [@realzhongkeyi](https://gitee.com/realzhongkeyi/)           | 标准 ISO         |                                             |
| 28   | [新增NestOS K8S部署方案](https://gitee.com/openeuler/release-management/issues/I6UAMM) | Accepted | SIG-K8s-Distro               | [@duyiwei7w](https://gitee.com/duyiwei7w/)                   | EPOL             |                                             |
| 29   | [Kernel新增星云智联板卡N1045XS网卡驱动](https://gitee.com/openeuler/release-management/issues/I6PXNE) | Accepted | Kernel                       | [@nebula_matrix](https://gitee.com/nebula_matrix/)           | 标准 ISO         |                                             |

> 当前社区release分为以下几种方式: 标准 ISO/everything ISO/Epol/独立镜像/ 独立发布
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
| 支持RISC-V                                | sig-RISC-V                   | sig-RISC-V                   | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
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

   openEuler 22.03 LTS SP2 版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 1轮重点特性测试 + 2轮全量测试 + 1轮回归测试 + 1轮版本发布验收测试；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项；第2轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫描及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；第3、4轮全量测试开展版本交付的所有特性和各类专项测试；第5轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；第6轮版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

   openEuler 22.03 LTS SP2 版本共发现问题 251 个，有效问题 208 个，无效问题 43 个。遗留问题 1 个(详见遗留问题章节)。版本整体质量良好。



# 4 版本详细测试结论

openEuler 22.03 LTS SP2 版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试、资料测试；

5、对版本新增特性进行功能、可靠性等专项测试，新增特性均满足发布要求，测试较充分，质量良好；



## 4.1   软件范围变化分析结论

### 4.1.1 标准ISO范围软件变化分析

经比较，openEuler-22.03-LTS-SP2 BaseOS相较openEuler-22.03-LTS-SP1 BaseOS范围没有变更。

详情可参考[openEuler-22.03-LTS-SP2-normal_aarch64.xml](https://gitee.com/src-openeuler/oemaker/blob/openEuler-22.03-LTS-SP2/normal_aarch64.xml)与[openEuler-22.03-LTS-SP2-normal_x86_64.xml](https://gitee.com/src-openeuler/oemaker/blob/openEuler-22.03-LTS-SP2/normal_x86_64.xml)

### 4.1.2 整体软件范围变化分析

经比较，openEuler-22.03-LTS-SP2对比openEuler-22.03-LTS-SP1不存在版本号降级，但存在41项release号降级的软件，经定位系SP1 update版本同步升级时开发者处理流程不规范导致，此41项软件均已提单跟踪，于RC2完成闭环。

迭代测试过程中，全量测试环节openEuler-22.03-LTS-SP2 RC3到RC4不存在软件版本降级，同时也不存在release降级。唯二剔除的软件包bash-reloc与ncurses-relocation为bash与你curses主包基于安全编译选项问题单进行的修复结果，系统已稳定。



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
| 13   | 支持RISC-V                                | <font color=green>█</font> | 继承已有测试能力，关注openEuler版本在RISV-V处理器上的可安装和可使用性(因构建效率原因，RISC-V版本会在openEuler版本正式release后开启构建与测试) |
| 14   | 支持HA软件                                | <font color=green>█</font> | 继承已有测试能力，重点关注HA软件的安装部署、基本功能和可靠性 |
| 15   | 支持KubeSphere                            | <font color=green>█</font> | 继承已有测试能力，关注kubeSphere的安装部署和针对容器应用的基本自动化运维能力 |
| 16   | 支持openstack Train 和 Wallaby            | <font color=green>█</font> | 继承已有测试能力，验证T和W版本的安装部署及各个组件提供的基本功能 |
| 17   | 支持A-Tune                                | <font color=green>█</font> | 继承已有测试能力，重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
| 18   | 支持secPave                               | <font color=green>█</font> | 继承已有测试能力，关注secPave特性的基本功能和服务的稳定性    |
| 19   | 支持secGear                               | <font color=green>█</font> | 继承已有测试能力，关注secGear特性的功能完整性                |
| 20   | 支持eggo                                  | <font color=green>█</font> | 继承已有测试能力，重点关注针对不同linux发行版和混合架构硬件场景下离线和在线两种部署方式，另外需关注节点加入集群以及集群的拆除功能完整性 |
| 21   | 支持kubeOS                                | <font color=green>█</font> | 继承已有测试能力，重点验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力 |
| 22   | 支持NestOS                                | <font color=green>█</font> | 继承已有测试能力，关注NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
| 23   | 支持etmem内存分级扩展                     | <font color=green>█</font> | 继承已有测试能力，重点验证特性的基本功能和稳定性             |
| 24   | 支持定制裁剪工具套件(oemaker/imageTailor) | <font color=green>█</font> | 继承已有测试能力，验证可定制化的能力                         |
| 25   | 支持虚拟化热补丁libcareplus               | <font color=green>█</font> | 继承已有测试能力，重点关注libcareplus提供Qemu热补丁能力      |
| 26   | 支持用户态协议栈gazelle                   | <font color=green>█</font> | 继承已有测试能力，重点关注gazelle高性能用户态协议栈功能      |
| 27   | 支持容器场景在离线混合部署rubik           | <font color=green>█</font> | 继承已有测试能力，结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
| 28   | 支持智能运维A-ops                         | <font color=green>█</font> | 继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性 |
| 29   | 支持国密算法                              | <font color=green>█</font> | 继承已有测试能力，验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
| 30   | 支持k3s                                   | <font color=green>█</font> | 继承已有测试能力，验证k3s软件的部署测试过程                  |
| 31   | 支持KubeEdge                              | <font color=green>█</font> | 继承已有测试能力，验证KubeEdge的部署测试过程                 |
| 32   | 支持pkgship                               | <font color=green>█</font> | 继承已有测试能力，关注软件包依赖查询、生命周期管理、补丁查询等功能 |
| 33   | 支持mindspore                             | <font color=green>█</font> | 继承已有测试能力，针对openCV、opencl-clhpp、onednn、Sentencepiece4个模块，复用开源测试能力覆盖安装、接口测试、功能测试，重点关注对mindspore提供能力的稳定性 |
| 34   | 支持pod带宽管理oncn-bwm                   | <font color=green>█</font> | 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
| 35   | 支持基于分布式软总线扩展生态互联互通      | <font color=green>█</font> | 继承已有测试能力，验证openEuler和openHarmony设备进行设备认证，互通互联特性 |
| 36   | 支持混合关键部署技术扩展                  | <font color=green>█</font> | 继承已有测试能力，验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 37   | 支持硬实时系统                            | <font color=green>█</font> | 继承已有测试能力，验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 |
| 38   | 支持kubernetes                            | <font color=green>█</font> | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 39   | 安装部署                                  | <font color=green>█</font> | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| 40   | Kunpeng加速引擎                           | <font color=green>█</font> | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 |
| 41   | 备份还原功能支持                          | <font color=green>█</font> | 验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常 |
| 42   | 支持ROS基础版和ROS2基础版42               | <font color=green>█</font> | 验证ROS-COMM和ROS-BASE的安装卸载与基础功能正常               |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.2.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称**                                                 | **测试覆盖情况**                                             | **约束依赖说明** | **遗留问题单** | **质量评估**               | **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | -------- |
| 1        | [DDE组件更新](https://gitee.com/openeuler/QA/blob/c97a86a326e9c97d9bc000d0d75a6c9774dd54c2/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%E7%89%88%E6%9C%ACDDE%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 安装测试，桌面、启动器、控制中心、以及子应用的功能测试       | NA               | NA             | <font color=green>█</font> |          |
| 2        | [支持Lubstre client软件包](https://gitee.com/openeuler/QA/blob/03543cf64914f1514cefee405f6598f90e2035a8/Test_Result/openEuler_22.03_LTS_SP2/openEuler-22.03-LTS-SP2%E7%89%88%E6%9C%ACLustre-client%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 基本功能（包括文件系统挂载，卸载，文件和目录的增删改查等功能）集成测试 | NA               | NA             | <font color=green>█</font> |          |
| 3        | [支持树莓派](https://gitee.com/openeuler/QA/blob/60df0c61c5ec2699a659a6eda193736588fd6c77/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%20%E6%A0%91%E8%8E%93%E6%B4%BE%E9%95%9C%E5%83%8F%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 覆盖硬件兼容性测试，安装测试，基本功能测试，以及管理工具测试 | NA               | NA             | <font color=green>█</font> |          |
| 4        | [openEuler docker容器支持sysMaster管理sshd服务](https://gitee.com/openeuler/QA/blob/aefdb764746fcc57b3a1789a5da057b2c1ce5e27/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%E7%89%88%E6%9C%AC%E5%AE%B9%E5%99%A8%E4%B8%AD%E6%94%AF%E6%8C%81%E9%80%9A%E8%BF%87sysMaster%E7%AE%A1%E7%90%86sshd%E6%9C%8D%E5%8A%A1%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | sysmaster在容器中可管理sshd服务                              | NA               | NA             | <font color=green>█</font> |          |
| 5        | [支持ROS2-humble基础版](https://gitee.com/openeuler/QA/blob/85f036c77c447d552414eea569cf9d93f8b075e7/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%E7%89%88%E6%9C%ACROS%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | ROS2-humble组件正常安装，以及 rostopic、rosservice、rosmsg等指令功能正常 | NA               | NA             | <font color=green>█</font> |          |
| 6        | [支持OpenStack Train、Wallaby多版本](https://gitee.com/openeuler/QA/blob/8c86ce72bdfb6ccd734a1044b6253079ca4bd97d/Test_Result/openEuler_22.03_LTS_SP2/%20openEuler%2022.03_LTS_SP1%E7%89%88%E6%9C%ACOpenStack%20Train%20Wallaby%E7%89%88%E6%9C%AC%E6%94%AF%E6%8C%81%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | OpenStack Train/Wallaby功能正常                              | NA               | NA             | <font color=green>█</font> |          |
| 7        | 内核支持容器资源可见性功能                                   | 不涉及                                                       | NA               | NA             |                            |          |
| 8        | 内核新增UKFEF功能                                            | 不涉及                                                       | NA               | NA             |                            |          |
| 9        | 内核支持Group identity功能                                   | 不涉及                                                       | NA               | NA             |                            |          |
| 10       | [新增kunpengsecl软件包支持平台和TEE远程证明](https://gitee.com/openeuler/QA/blob/e9db0307fa5093bbe67ee4020ebeebeec583caf2/Test_Result/openEuler_22.03_LTS_SP2/openEuler%20TEE%E8%BF%9C%E7%A8%8B%E8%AF%81%E6%98%8E%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 基于RAC测试模式和libqca的simulator的虚拟场景测试，以及基于RAC正常模式物理环境测试，以及接口和功能测试。 | NA               | NA             | <font color=green>█</font> |          |
| 11       | [secGear特性增强](https://gitee.com/openeuler/QA/blob/bc0593fd020e754c989f32cb4ef1a8e93bd0bbd5/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%E7%89%88%E6%9C%ACsecGear%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | secGear已有功能，secGear在arm平台下的远程证明和安全通道支持身份认证功能 | NA               | NA             | <font color=green>█</font> |          |
| 12       | [支持embedded版本](https://gitee.com/openeuler/QA/blob/775e86081c2430916371177fbef1bfa80468761b/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%20embedded%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 新增/继承特性验证，以及安全/可靠性/性能/兼容性/资料等专项    | NA               | NA             | <font color=green>█</font> |          |
| 13       | [回合bwm特性，支持面向容器的网络带宽调度策略]()              | 容器场景下带宽的分配和流量监控功能                           | NA               | NA             | <font color=green>█</font> |          |
| 14       | 开发流水线打通构建/compass-ci/测试radiaTest 3大服务          | 不涉及                                                       | NA               | NA             |                            |          |
| 15       | [发布kiran-desktop 2.5版本](https://gitee.com/openeuler/QA/blob/ce6c59211fc0b21dad3ff6257cd26b2e21fddc70/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%E7%89%88%E6%9C%AC%20Kiran%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 新增功能测试、基本桌面功能测试、稳定性测试、可靠性测试       | NA               | NA             | <font color=green>█</font> |          |
| 16       | [iSulad支持K8S 1.24 /1.25版本](https://gitee.com/openeuler/QA/blob/83ae13b583ff60462b73d9b03bfff1bf9c28fc68/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%20isulad%E6%94%AF%E6%8C%81%20CRI%20API%201.25%E7%89%88%E6%9C%AC%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 升级前后的监控性，新增接口的功能以及变更接口的功能均可正常执行，k8s下功能正常 | NA               | NA             | <font color=green>█</font> |          |
| 17       | CICD支持：实现热补丁流水线发布，用户可以通过补丁服务制作补丁 | 不涉及                                                       | NA               | NA             |                            |          |
| 18       | [热补丁服务：热补丁流水线/管理框架，支持热补丁发布](https://gitee.com/openeuler/QA/blob/9302a8929244feed3005a40671bdd385b1ba4239/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03-LTS-SP2%E7%89%88%E6%9C%ACAops%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 覆盖系统缺陷巡检和告警通知、系统缺陷支持热补丁修复、单机支持使用dnf管理热补丁、热补丁回退接口、功能、以及web测试 | NA               | NA             | <font color=green>█</font> |          |
| 19       | [Rubik混部支持精细化资源QoS感知和控制](https://gitee.com/openeuler/QA/blob/a5bfcb3f5752a7a61f371d0a93dce27d709c946e/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%E7%89%88%E6%9C%ACRubik%E6%B7%B7%E9%83%A8%E6%94%AF%E6%8C%81%E7%B2%BE%E7%BB%86%E5%8C%96%E8%B5%84%E6%BA%90QoS%E6%84%9F%E7%9F%A5%E5%92%8C%E6%8E%A7%E5%88%B6%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 内存异步回收功能正常；QuotaTurbo支持对CPU资源动态放宽功能正常；可根据PSI配置，实现告警和应用驱逐，保证继承功能不变，混部场景长稳可靠运行 | NA               | NA             | <font color=green>█</font> |          |
| 20       | [支持 sysmonitor 特性](https://gitee.com/openeuler/QA/blob/35d9f18e757ca208fc768e6c7da17ae39b5f0a3c/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%E7%89%88%E6%9C%AC%E6%94%AF%E6%8C%81%20sysmonitor%20%E7%89%B9%E6%80%A7%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 配置的监控项，在资源异常时能正常告警，整机运行时，部署sysmonitor特性，可以检测随机产生的故障，继承用例功能不变 | NA               | NA             | <font color=green>█</font> |          |
| 21       | [Gazelle新增支持UDP协议](https://gitee.com/openeuler/QA/blob/89d287ac567a1dcfb696829c7befeec7f96454a9/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%E7%89%88%E6%9C%ACgazelle%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | gazelle可以正常收发UDP数据包，支持单播/组播收发包，保证继承功能不变，特性长稳运行可靠 | NA               | NA             | <font color=green>█</font> |          |
| 22       | [安全配置规范框架设计及核心内容构建](https://gitee.com/openeuler/QA/blob/35d9f18e757ca208fc768e6c7da17ae39b5f0a3c/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03_LTS_SP2%E7%89%88%E6%9C%AC%E5%AE%89%E5%85%A8%E9%85%8D%E7%BD%AE%E8%A7%84%E8%8C%83%E6%A1%86%E6%9E%B6%E8%AE%BE%E8%AE%A1%E5%8F%8A%E6%A0%B8%E5%BF%83%E5%86%85%E5%AE%B9%E6%9E%84%E5%BB%BA%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 按照标准配置规范和检查工具，安全配置符合配置规范基线         | NA               | NA             | <font color=green>█</font> |          |
| 23       | gala-gopher新增性能火焰图、线程级性能Profiling特性           | 不涉及                                                       | NA               | NA             |                            |          |
| 24       | 5.10内核hisi_sec2 hisi_hpre hisi_zip模块支持nosva特性        | 不涉及                                                       | NA               | NA             |                            |          |
| 25       | [新增NestOS K8S部署方案](https://gitee.com/openeuler/QA/blob/6c2ff5ff258ebe705474df4285a3a2faaf39d032/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03%20LTS%20SP2%E7%89%88%E6%9C%ACNestOS%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 新增功能测试，以及安全/可靠性/性能/兼容性专项测试            | NA               | NA             | <font color=green>█</font> |          |
| 26       | [新增通用编译环境制作能力](https://gitee.com/openeuler/QA/blob/e15b7d3f55015b9305e872b16b6be2ed4558c4e1/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03-LTS-SP2%20oemaker%20%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 跟随社区构建工程能力使用与开发过程进行功能测试               | NA               | NA             | <font color=green>█</font> |          |
| 27       | [支持qcow2格式镜像制作](https://gitee.com/openeuler/QA/blob/e15b7d3f55015b9305e872b16b6be2ed4558c4e1/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03-LTS-SP2%20oemaker%20%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 跟随社区构建工程能力使用与开发过程进行功能测试               | NA               | NA             | <font color=green>█</font> |          |
| 28       | [oemaker特性增强](https://gitee.com/openeuler/QA/blob/e15b7d3f55015b9305e872b16b6be2ed4558c4e1/Test_Result/openEuler_22.03_LTS_SP2/openEuler%2022.03-LTS-SP2%20oemaker%20%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md) | 跟随社区构建工程能力使用与开发过程进行功能测试               | NA               | NA             | <font color=green>█</font> |          |
| 29       | [Kernel新增星云智联板卡N1045XS网卡驱动](https://gitee.com/openeuler/QA/pulls/482) | 通过oech获得兼容性认证                                       | NA               | NA             | <font color=green>█</font> |          |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好



## 4.3   兼容性测试结论

### 4.3.1   升级兼容性

openEuler 22.03-LTS-SP2 作为 openEuler 22.03-LTS SP1版本的增强扩展版本，支持从LTS SP1版本升级到对应的LTS SP2，完成如下场景的升级验证：

1、从22.03 LTS SP1到22.03 LTS SP2版本的升降级

2、从22.03 LTS的月度update维护版本到22.03 LTS SP2版本的升降级

3、升降级后系统的重启

上述场景下，软件包升降机后的功能验证、服务检查等测试；新增软件包通过对软件直接进行安装来进行；整体升级兼容性功能正常。

### 4.3.2   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成29张板卡的测试(该数目仅为测试数量，实际兼容性认证通过数量见社区[兼容性清单](https://www.openeuler.org/zh/compatibility/))

此版本的板卡兼容性适配测试，适配的板卡类型有RAID/FC/GPU/SSD/IB/NIC/六种，在aarch64/x86_64架构上进行适配，主要使用社区硬件兼容性测试工具oec-hardware集成compass-ci进行自动化测试，适配完成后将在社区发布此版本的板卡兼容性清单。

下表列出版本集成验证中涉及的硬件板卡信息：

| **板卡类型** | **覆盖范围**    | **测试主体**      | **chipVendor** | **boardModel**     | **chipModel**      | **测试结果** |
| ------------ | --------------- | ----------------- | -------------- | ------------------ | ------------------ | ------------ |
| RAID         | 适配7张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Huawei         | SP686C             | B80121(Hi1880)     | PASS         |
|              |                 |                   | Huawei         | SP186              | B80121(Hi1880)     | PASS         |
|              |                 |                   | Avago          | 9560-8i            | SAS3908            | PASS         |
|              |                 |                   | Avago          | SP460C-M           | SAS3516            | PASS         |
|              |                 |                   | Avago          | SR150-M            | SAS3408            | PASS         |
|              |                 |                   | Avago          | SP150IT-M          | SAS3408            | PASS         |
|              |                 |                   | Avago          | SR430C-M           | SAS-3 3108         | PASS         |
|              |                 |                   | Avago          | SR130              | SAS3008            | PASS         |
|              |                 |                   | Avago          | SR130-M            | SAS3008            | PASS         |
| FC           | 适配4张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Emulex         | LPe32002-M2        | LPe31000/LPe32000  | PASS         |
|              |                 |                   | Emulex         | LPE16002B-M6       | LPe15000/LPe16000  | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2560            | ISP2532            | PASS         |
|              |                 |                   | Emulex         | LPe31002-M6        | LPe31000/LPe32000  | PASS         |
| GPU          | 适配4张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | NVIDIA         | Tesla T4           | TU104GL            | PASS         |
|              |                 |                   | NVIDIA         | Tesla V100         | GV100GL            | PASS         |
|              |                 |                   | NVIDIA         | Tesla A100         | GA100              | PASS         |
|              |                 |                   | AMD            | Radeon Pro WX 5100 | Ellesmere          | PASS         |
| SSD          | 适配1张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Huawei         | ES3600C V5-3200GB  | Hi1812E V100       | PASS         |
| IB           | 适配3张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Mellanox       | SP351              | ConnectX-5         | PASS         |
|              |                 |                   | Mellanox       | SP350              | ConnectX-5         | PASS         |
|              |                 |                   | Mellanox       | MCX653105A-EFAT    | ConnectX-6         | PASS         |
| NIC          | 适配NIC板卡14张 | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Intel          | E810-XXV-2         | E810-XXV           | PASS         |
|              |                 |                   | Netswift       | SF200T             | WX1860A2(23AHF0A2) | PASS         |
|              |                 |                   | Intel          | SP210              | I350               | PASS         |
|              |                 |                   | Intel          | Intel I350         | I350               | PASS         |
|              |                 |                   | Intel          | I350-F2            | I350               | PASS         |
|              |                 |                   | Intel          | XL710-Q2           | XL710              | PASS         |
|              |                 |                   | Huawei         | SP580              | Hi1822             | PASS         |
|              |                 |                   | Mellanox       | SP382              | ConnectX-5         | PASS         |
|              |                 |                   | Mellanox       | SP380              | ConnectX-4 Lx      | PASS         |
|              |                 |                   | Mellanox       | MCX4121A-XCAT      | ConnectX-4 Lx      | PASS         |
|              |                 |                   | Mellanox       | MCX4121A-ACUT      | ConnectX-4 Lx      | PASS         |

此版本的整机兼容性适配测试主要使用社区开源硬件兼容性测试工具oec-hardware，从整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性等方面进行适配，适配完成后将在社区发布此版本的整机兼容性清单。

整机适配兼容性测试交付清单如下：

| **整机厂商** | **整机型号**             | **CPU型号**   | **测试主体**      | **测试结果** |
| ------------ | ------------------------ | ------------- | ----------------- | ------------ |
| 华为         | 泰山200                  | 鲲鹏920       | sig-Compatibility | PASS         |
|              | 青松服务器               | FT S2500      | sig-Compatibility |              |
| 超聚变       | 2288H V3                 | Intel cascade | sig-Compatibility | PASS         |
|              | 2288H V5                 | Intel cascade | sig-Compatibility | PASS         |
|              | 2288H V6                 | Intel SPR     | sig-Compatibility |              |
| 中科可控     | R6230HA                  | Hygon 2号     | sig-Compatibility |              |
|              | X7840H0                  | Hygon 3号     | sig-Compatibility |              |
| AMD          | Supermicro AS-4124GS-TNR | AMD Milan     | sig-Compatibility |              |
| 飞腾         | 公版                     | FT2000+       | sig-Compatibility |              |
|              | 公版                     | FT S2500      | sig-Compatibility |              |
| 兆芯         | ThinkSystem SR658Z       | KH-30000      | sig-Compatibility |              |

整机兼容性清单以sig-Compatibility-Infra提供为主，社区各sig测试过程中使用的机器因未进行oec-hardware测试(进入社区兼容性清单质量要求)，故无法直接进行兼容性清单不在此描述。

### 4.3.3   虚拟机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 | 备注                                   |
| ---------- | ----------------------- | ------- | -------- | -------------------------------------- |
| Centos 7.9 | openEuler 22.03 LTS SP2 | aarch64 | PASS     |                                        |
| Centos 7.9 | openEuler 22.03 LTS SP2 | x86_64  | PASS     |                                        |
| Centos 8   | openEuler 22.03 LTS SP2 | aarch64 | PASS     |                                        |
| Centos 8   | openEuler 22.03 LTS SP2 | x86_64  | PASS     |                                        |
| Fedora 32  | openEuler 22.03 LTS SP2 | aarch64 | PASS     | 缺少1822网卡驱动hinic.ko，需要手动导入 |
| Fedora 32  | openEuler 22.03 LTS SP2 | x86_64  | PASS     |                                        |
| Fedora 35  | openEuler 22.03 LTS SP2 | aarch64 | PASS     | 缺少1822网卡驱动hinic.ko，需要手动导入 |
| Fedora 35  | openEuler 22.03 LTS SP2 | x86_64  | PASS     |                                        |



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
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考22.03 LTS SP1版本相应指标基线 | 比较前一版本持平 |



# 5   问题单统计

openEuler 22.03 LTS SP2 版本共发现问题 251 个，有效问题 208 个，其中遗留问题 1 个。详细分布见下表:

| 测试阶段                    | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注                       |
| --------------------------- | -------- | ------------ | ------------ | ------------ | -------------------------- |
| openEuler 22.03 LTS SP2 RC1 | 20       | 20           | 0            | 0            | Alpha轮次                  |
| openEuler 22.03 LTS SP2 RC2 | 159      | 128          | 30           | 1            | Beta轮次                   |
| openEuler 22.03 LTS SP2 RC3 | 38       | 32           | 6            | 0            | 全量集成                   |
| openEuler 22.03 LTS SP2 RC4 | 28       | 23           | 5            | 0            | 全量集成                   |
| openEuler 22.03 LTS SP2 RC5 | 6        | 5            | 1            | 0            | 回归测试                   |
| openEuler 22.03 LTS SP2 RC6 |          |              |              |              | 版本发布验收测试(回归测试) |



# 6 版本测试过程评估

#### 6.1 问题单分析

除去开发自验轮次，本次版本测试各迭代有效问题数量呈收敛趋势，没有问题溢出的风险。其中第二轮迭代中的132个有效问题中，有0项严重问题，65项主要问题，均已被修复，部分已完成回归；第三轮迭代中共32个有效问题，其中10项主要问题，均已被修复。

- 关键问题类型：软件版本/release号相较openEuler-22.03-LTS-SP1最新update较低

  此类问题约有41项，大多数因社区开发者在master分支进行升级后，直接将patch同步到22.03-LTS-SP1分支，而非先同步到open Euler-22.03-LTS-Next上再同步SP1导致，为流程规范问题。

#### 6.2 转测延期分析

本次版本测试中，第四轮迭代转测延期五天，原因有：

- 原定计划内，主要问题解决率不满足社区转测质量要求，转测要求一般情况下严重/主要问题100%解决
- 原定计划内，部分关键组件（内核、性能相关）代码合入时间较晚，第三轮迭代中存在6/15才合入的核心代码
- 原定计划内，部分问题修复方案不合理，导致版本构建阻塞（containers-common多版本问题修复方案产生的新问题）

#### 6.3 OS集成测试迭代版本基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 22.03 LTS SP2 RC1 | 冒烟测试         |                                |
| openEuler 22.03 LTS SP2 RC2 | 冒烟测试         |                                |
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
|                             | 编译器专项       | gcc测试                        |
| openEuler 22.03 LTS SP2 RC3 | 冒烟测试         |                                |
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
|                             | 编译器专项       | gcc测试                        |
|                             |                  | openjdk测试                    |
| openEuler 22.03 LTS SP2 RC4 | 冒烟测试         |                                |
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
|                             | 编译器专项       | gcc测试                        |
|                             |                  | openjdk测试                    |
| openEuler 22.03 LTS SP2 RC5 | 冒烟测试         |                                |
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
|                             | 多动态库检查专项 |                                |
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
| openEuler 22.03 LTS SP2 RC6 | 版本发布验收     | 版本发布验收                   |

# 6   附件

## 遗留问题列表

| 序号 | 问题单号                                                     | 问题简述                                                    | 问题级别 | 影响分析                                                     | 规避措施                                                     | 历史发现场景                                                 |
| ---- | ------------------------------------------------------------ | ----------------------------------------------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | [I79CLI](https://gitee.com/src-openeuler/mandoc/issues/I79CLI?from=project-issue) | 【22.03-LTS-SP2 round2】【arm/x86】mandoc安装过程有报错信息 | 次要     | mandoc版本的man无法直接通过man命令使用，不影响原有版本的man命令功能 | 暂无用户根据自己需要使用的man版本，通过alternative --config man命令指定man的来源 | [I63H93](https://gitee.com/src-openeuler/mandoc/issues/I63H93?from=project-issue) |


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
以及所有参与22.03 LTS SP2但未统计到的所有开发者
(如有遗漏可随时联系 @disnight email:fjc837005411@outlook.com 反馈)
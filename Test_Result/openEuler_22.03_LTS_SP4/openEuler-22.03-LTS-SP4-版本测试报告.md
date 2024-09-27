![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2024/06/24 | 1.0.0    | 初稿, 基于RC1/2/3/4 | ga_beng_cui |


关键词：

openEuler HAOC TEE virtCCA vDPA SM4-CE PowerAPI eagle gala-ragdoll sysSentry

摘要：

文本主要描述openEuler 22.03 LTS SP4 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 22.03 LTS SP4 版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 22.03 LTS SP4 是基于5.10内核22.03-LTS-SP3的补丁增强版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 22.03 LTS-Next分支拉出，发布范围相较22.03 LTS版本主要变动：

1. 版本变更说明，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP4/release-change.yaml)
2. 修复bug和cve
3. 新增远程证明TEE插件框架
4. 新增支持DPU场景磁盘方案，并支持配置了vDPA网卡和磁盘的虚机进行热迁移
5. 新增virtCCA机密虚机特性
6. 新增openSSL支持SM4-CE指令集
7. 新增PowerAPI功耗管理统一API
8. 新增eagle实现整机能耗管理
9. 新增gala-ragdoll支持实时监控文件变更信息
10. 新增支持sysSentry故障管理框架

## 2.1 版本测试计划
openEuler 22.03 LTS SP4 版本按照社区release-manager团队的计划，共规划6轮测试，详细的版本信息和测试时间如下表：

| 版本名称                | 测试起始时间 | 测试结束时间 |测试天数|备注           |
| ---------------------- | ---------- | ---------- | ---- |-----------------------------------| 
| Build & Alpha          | 2024/05/24 | 2024/05/30 | 7    | 开发自验证 |
| Test round 1           | 2024/05/24 | 2024/05/30 | 7    | 22.03-LTS SP4版本启动集成测试   |
| Beta Version release   | 2024/06/03 | 2024/06/05 | 2    | 22.03-LTS SP4 Beta版本发布     |
| Test round 2           | 2024/05/31 | 2024/06/05 | 7    | 全量SIT验证    |
| Test round 3           | 2024/06/08 | 2024/06/15 | 7    | 全量SIT验证    |
| Test round 4           | 2024/06/16 | 2024/06/23 | 7    | 回归测试     |
| Test round 5           | 2024/06/25 | 2024/06/27 | 3    | 回归测试    |
| Release                | 2024/06/28 | 2024/06/29 | 1    | 社区Release版本发布评审    |

## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920                              | OS集成测试     |
| RH2288H V5            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| 树莓派 4B              | BCM2711                                  | 嵌入式版本测试 |
| STM32F407ZGT6开发板    | CPU:STM32F407ZG(168MHz)                  | 嵌入式版本测试 |

## 2.3 需求清单

openEuler 22.03 LTS SP4版本交付需求列表如下，详情见[openEuler-22.03-LTS-SP4 release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP4/release-plan.md)：

| no   | feature                                                      | status   | sig                          | owner                                                        | 发布方式         | 备注                                        |
| ---- | ------------------------------------------------------------ | -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | ------------------------------------------- |
|[I9IHTX](https://gitee.com/openeuler/release-management/issues/I9IHTX)| 提交内核安全增强补丁 HAOC | Rejected | sig-kernel | [@amjac](https://gitee.com/amjac) ||
|[I9PTJ9](https://gitee.com/openeuler/release-management/issues/I9PTJ9?from=project-issue)| 机密计算远程证明服务：远程证明TEE插件框架 | Accepted | sig-confidential computing | [@houmingyong](https://gitee.com/houmingyong) |everything|
|[I9PUSQ](https://gitee.com/openeuler/release-management/issues/I9PUSQ?from=project-issue)| DPU场景vDPA新增支持磁盘，并支持配置vDPA网卡和磁盘的虚机热迁移 | Accepted | virt SIG | [@frankneo](https://gitee.com/frankneo) |everything|
|[I96OAX](https://gitee.com/openeuler/release-management/issues/I96OAX?from=project-issue)| virtCCA机密虚机特性合入 | Accepted | SIG-Kernel/SIG-Virt | [@luoyukai](https://gitee.com/luoyukai) |everything|
|[I9PSTH](https://gitee.com/openeuler/release-management/issues/I9PSTH?from=project-issue)| openSSL支持SM4-CE指令集，提升SM4运算速度 | Accepted | sig-security-facility | [@HuaxinLuGitee](https://gitee.com/HuaxinLuGitee) |everything|
|[I9TI38](https://gitee.com/openeuler/release-management/issues/I9TI38?from=project-issue)| PowerAPI功耗管理统一API | Accepted | sig-power-efficient | [@heppen](https://gitee.com/heppen) |everything|
|[I9THX9](https://gitee.com/openeuler/release-management/issues/I9THX9?from=project-issue)| eagle实现整机能耗管理 | Accepted | sig-power-efficient | [@heppen](https://gitee.com/heppen) |everything|
|[I9SSLS](https://gitee.com/openeuler/release-management/issues/I9SSLS?from=project-issue)| gala-ragdoll支持实时监控文件变更信息 | Accepted | sig-ops | [@zhangdaolong](https://gitee.com/zhangdaolong) |EPOL||
|[I9TNWE](https://gitee.com/openeuler/release-management/issues/I9TNWE?from=project-issue)| 支持sysSentry故障管理框架| Rejected | sig-Base-service | [@huangduirong](https://gitee.com/huangduirong) |||

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
|支持Lustre server软件包     |sig-SDS|sig-SDS|验证sanity基本功能测试套测试|
|sysMaster支持虚机场景       |dev-utils|dev-utils|验证基本功能测试、接口测试、可靠性测试、安全测试|
|增加i3相关软件包发布         |sig-infrastructure|sig-infrastructure|验证安装，卸载，基本功能测试，扩展功能测试|
|支持入侵检测框架secDetector|sig-security-facility|sig-security-facility|验证入侵检测框架secDetector基本功能，安全，可靠性等方面|
| 支持TPCM特性  | sig-Base-service |sig-Base-service | 覆盖基本功能|
| isulad支持oci runtime并且切换默认runtime为runc |sig-iSulad|sig-iSulad|覆盖功能，可靠性。|
|syscare组件支持容器化热补丁制作场景|sig-ops|sig-ops|验证syscare管理功能，包括接口正向，负向的功能测试、以及可靠性测试，并发测试，长稳测试，资料测试，安全测试。|
| 支持进程完整性防护特性 | sig-security-facility|sig-security-facility|验证配置DIM度量策略，度量用户态进程，度量任一模块，度量内核等功能； |
|支持DPU直连聚合特性|sig-DPU|sig-DPU|验证DPU直连聚合特性基本功能，安全以及可靠性|
|支持safeguard软件包|sig-ebpf|sig-ebpf|覆盖了功能测试、接口测试|
|增加安全启动签名|sig-security-facility|sig-security-facility|验证基本功能，可靠性等方面|

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试



# 3 版本概要测试结论

   openEuler 22.03 LTS SP4 版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 1轮重点特性测试 + 2轮全量测试 + 1轮回归测试 + 1轮版本发布验收测试；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项；第2轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫描及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；第3、4轮全量测试开展版本交付的所有特性和各类专项测试；第5轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；第6轮版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

   openEuler 22.03 LTS SP4 版本共发现问题 286 个，有效问题 278 个，其中遗留问题 0 个。版本整体质量良好。



# 4 版本详细测试结论

openEuler 22.03 LTS SP4 版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试、资料测试；

5、对版本新增特性进行功能、可靠性等专项测试，新增特性均满足发布要求，测试较充分，质量良好；



## 4.1   软件范围变化分析结论

### 4.1.1 标准ISO范围软件变化分析

经比较，openEuler-22.03-LTS-SP4 BaseOS相较openEuler-22.03-LTS-SP3 BaseOS范围没有变更。

详情可参考[openEuler-22.03-LTS-SP4-normal_aarch64.xml](https://gitee.com/src-openeuler/oemaker/blob/openEuler-22.03-LTS-SP4/normal_aarch64.xml)与[openEuler-22.03-LTS-SP4-normal_x86_64.xml](https://gitee.com/src-openeuler/oemaker/blob/openEuler-22.03-LTS-SP4/normal_x86_64.xml)

### 4.1.2 整体软件范围变化分析

经比较，openEuler-22.03-LTS-SP4对比openEuler-22.03-LTS-SP3软件包变化范围小。下列为具体数据:<br>
|OS版本|everything|baseos|epol(main)|epol(OpenStack/Train)|epol(OpenStack/Wallaby)|epol(lustre)|epol(NestOS)|
|-------------|----|---|---|---|---|-|-|
|22.03-LTS-SP4|4298|972|962|333|387|2||
|22.03-LTS-SP3|4288|976|970|333|387|2|10|
## 4.2   特性测试结论

### 4.2.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                             |        特性质量评估        | 备注                                                         |
| ---- | ----------------------------------------- | :------------------------: | ------------------------------------------------------------ |
| 1    | 内核                                      | <font color=green>█</font> | 执行用例5093条，继承内核已有测试能力，通过使用开源测试套LTP、mmtest、syzkaller开源测试套进行测试；通过构建系统压力，反复长时间随机执行LTP基本系统调用，对内核开展7*24小时的稳定性测试，整体用例执行通过；内核整体质量良好 |
| 2    | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | 执行用例742个，覆盖容器领域引擎的基本能力，进行功能/可靠性/稳定性测试，用例执行全部通过，整体质量良好证 |
| 3    | 虚拟化(qemu/stratovirt)                   | <font color=green>█</font> | 共计执行用例8000+条，继承已有测试能力，覆盖虚拟化组件(qemu&stratovirt)的基本功能、可靠性、稳定性及场景测试，使用开源的测试套tp-libvirt和tp-qemu开展各类测试，测试通过，整体质量良好 |
| 4    | 编译器(gcc/jdk)                           | <font color=green>█</font> | 共计执行测试用例80291条，对gcc/jdk组件完成开源功能测试套supertest和开源fuzz测试套csmith\jfuzz的全量覆盖，另外使用SEPCjbb2015对jdk开展性能max-jOPS和critical-jOPS项的测试，以及通过jterg框架对jdk进行功能测试，编译器组件整体质量良好|
| 5    | 支持DDE桌面                               | <font color=green>█</font> | 共执行用例240条，执行两轮测试，主要覆盖了基础组件跟预装应用核心功能以及基本UI测试，无遗留问题。整体核心功能质量可控。           |
| 6    | 支持UKUI桌面                              | <font color=green>█</font> | 共执行用例62条，执行两轮测试，覆盖UKUI桌面的核心功能、重要组件及系统插件的测试，整体质量良好         |
| 7    | 支持xfce桌面                             | <font color=red>●</font> |无人维护，共有用例103条 |
| 8    | 支持gnome桌面                            | <font color=red>●</font> |无人维护，共有用例53条 |
| 9    | 支持Kiran桌面                             | <font color=green>█</font> | 执行用例60条，覆盖kiran桌面在SP3版本上的安装卸载；并重点覆盖桌面提供的重要组件、核心能力及插件的测试 |
| 10   | 支持南向兼容性                            | <font color=green>█</font> | 继承已有测试能力，关注板卡和整机适配的兼容性测试             |
| 11   | 支持北向兼容性                            | <font color=green>█</font> | 继承已有测试能力，关注软件所仓库对已正式release版本的北向软件的功能验证 |
| 12   | 支持树莓派                                | <font color=green>█</font> | 共执行用例85条，对树莓派镜像进行安装、基本功能、管理工具、硬件兼容性和稳定性测试，整体质量良好|
| 13   | 支持HA软件                                | <font color=green>█</font> | 共计执行用例42条，主要覆盖功能测试，完成了5轮迭代验证，其中1轮基本功能，2轮全量，2轮回归，没有发现问题，整体质量良好 |
| 14   | 支持KubeSphere                            | <font color=green>█</font> | 继承已有用例13个，主要覆盖了在 openEuler 22.03_LTS_SP1 中通过 Kubekey 安装部署、扩缩容、删除 Kubernetes 及 KubeSphere 集群的功能测试 |
| 15   | 支持openstack Train 和 Wallaby            | <font color=green>█</font> | 共执行用例1161条，覆盖T版本提供组件的API和功能测试，并通过tempest测试套完成集成验证和长稳测试 |
| 16   | 支持A-Tune                                | <font color=green>█</font> | 共有用例123个，完成特性查询负载类型、分析负载类型并自优化、自调优以及模型训练输入数据集的训练等功能用例全量测试，并从高压力负载和长时间运行两个方面进行验证，测试通过，质量良好 |
| 17   | 支持secPave                               | <font color=green>█</font> | 继承已有测试用例共38，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试。质量良好   |
| 18   | 支持secGear                               | <font color=green>█</font> | 继承已有测试用例共102，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试；质量良好            |
| 19   | 支持eggo                                  | <font color=green>█</font> | 共执行329个用例，主要覆盖了功能一致性测试，架构x86和arm均测试通过；整体功能基本可用；覆盖eggo提供的对K8S集群的部署、销毁、节点加入及删除的功能，质量良好 |
| 20   | 支持kubeOS                                | <font color=green>█</font> | 共有73个用例，主要覆盖kbimg.sh裁剪脚本测试，包括物理机、虚拟机、容器镜像三种裁剪方式，覆盖功能测试、异常参数测试、可靠性测试、安全测试；os-agent升级测试，覆盖功能测试、异常配置测试，包括X86和ARM的虚拟机、物理机升级回退，包括disk方式和docker镜像方式的升级回退，包括http协议、https协议单/双向认证，包括跨内核版本升级回退。测试通过，特性质量良好 |
| 21   | 支持etmem内存分级扩展                     | <font color=green>█</font> | 共有用例90条，覆盖范围包括特性的功能、可靠性，安全和性能。测试通过，组件整体质量良好 |
| 22   | 支持定制裁剪工具套件(oemaker/imageTailor) | <font color=green>█</font> | 共执行用例18条，包含oemaker是否能正常裁剪换标iso镜像以及裁剪完后的镜像是否能正常启动，共执行一轮测试，整体测试无遗留问题，整体质量良好  |
| 23   | 支持虚拟化热补丁libcareplus               | <font color=green>█</font> | 共计执行测试用例120个，主要覆盖了基础功能及可靠性相关测试，经过测试验证，未发现问题，测试通过，整体质量良好    |
| 24   | 支持用户态协议栈gazelle                   | <font color=green>█</font> | 共有用例113条，主要覆盖了功能测试、接口测试、兼容性测试、可靠性测试以及长稳测试。   |
| 25   | 支持容器场景在离线混合部署rubik           | <font color=green>█</font> | 共有用例90条，主要覆盖了功能测试、接口测试、兼容性测试、可靠性测试以及长稳测试。 |
| 26   | 支持智能运维A-ops                         | <font color=green>█</font> | 执行1419条用例，3轮测试，对cve漏洞检测、kernel冷热补丁混合升级、kernel热补丁支持冷补丁收编等基本功能进行测试，共发现问题4个，均已闭环合入回归验证 |
| 27   | 支持国密算法                              | <font color=green>█</font> | 共有用例30个。覆盖功能，可靠性，未发现issue。特性质量良好。 |
| 28   | 支持k3s                                   | <font color=green>█</font> | 共有用例1个。覆盖基本功能，安装部署，未发现issue。特性质量良好。          |
| 29   | 支持KubeEdge                              | <font color=green>█</font> | 共有用例1个。覆盖基本功能，安装部署，未发现issue。特性质量良好。  |
| 30   | 支持pkgship                               | <font color=green>█</font> | 共执行193个用例，主要覆盖功能测试、压力负载测试、性能测试、可靠性测试以及安全测试，测试通过，整体质量良好。 |
| 31   | 支持mindspore                             | <font color=green>█</font> | 执行134个onednn自带的ut测试用例，主要覆盖了接口测试和功能测试，未发现问题，无遗留风险，整体质量良好|
| 32   | 支持pod带宽管理oncn-bwm                   | <font color=green>█</font> | 共1轮测试，设计场景1个，共有用例44个。覆盖功能，可靠性，长稳测试。发现0个issue，特性质量良好。 |
| 33   | 支持基于分布式软总线扩展生态互联互通      | <font color=green>█</font> | 继承已有测试能力，验证openEuler和openHarmony设备进行设备认证，互通互联特性 |
| 34   | 支持混合关键部署技术扩展                  | <font color=green>█</font> | 继承已有测试能力，验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 35   | 支持硬实时系统                            | <font color=green>█</font> | 继承已有测试能力，验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 |
| 36   | 支持kubernetes                            | <font color=green>█</font> | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 37   | 安装部署                                  | <font color=green>█</font> | 共计执行52个用例，共5轮测试，主要覆盖了版本交付中的标准，everything，netinst，虚拟镜像，stratovirt等镜像的安装部署测试 |
| 38   | Kunpeng加速引擎                           | <font color=green>█</font> | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 |
| 39   | 备份还原功能支持                          | <font color=green>█</font> | 继承已有测试能力，验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常 |
| 40   | 支持ROS基础版和ROS2基础版               | <font color=green>█</font> | 执行10个用例，主要覆盖了安装卸载测试和功能测试，通过4*2次的反复测试，发现安装编译问题已解决，回归通过，无遗留风险，整体质量良好。              |
| 41   | 支持Lustre server软件包     |<font color=green>█</font>|继执行基本功能sanity test suite共计大概900 tests，经过CI RPM包安装测试，本地单机自测，及本地集群4轮sanity全集测试，回归测试，发现问题已经解决，回归通过，无遗留风险。|
| 42   | sysMaster支持虚机场景       |<font color=green>█</font>|执行19个测试用例，主要覆盖基本功能测试、接口测试、可靠性测试、安全测试，发现问题已解决，回归通过，无遗留风险，整体核心功能正常；devmaster在虚拟机场景上运行，执行103个测试用例，主要覆盖基本功能测试、接口测试、可靠性测试、安全测试，发现问题已解决，回归通过，无遗留风险，整体核心功能正常。|
| 43   | 增加i3相关软件包发布|<font color=green>█</font>|共计执行4个场景用例，108个接口测试用例，主要覆盖了安装，卸载，基本功能测试，扩展功能测试，用例全部通过，整体质量较好。|
| 44   | 支持入侵检测框架secDetector|<font color=green>█</font>|共计25个用例，所覆盖整场景表现符合预期，攻击行为无漏报，整体质量良好。|
| 45   | 支持TPCM特性  | <font color=green>█</font> | 共1轮测试，设计场景3个，共有用例11个。覆盖基本功能。 无issue，特性质量良好。|
| 46   | isulad支持oci runtime并且切换默认runtime为runc |<font color=green>█</font>|共2轮测试，设计场景5个，共有用例17个，继承用例执行2753个。覆盖功能，可靠性。 |
| 47   | syscare组件支持容器化热补丁制作场景|<font color=green>█</font>|共计执行31个用例，覆盖60个测试点，主要包括syscare build以及syscare管理功能，包括接口正向，负向的功能测试、以及可靠性测试，并发测试，长稳测试，资料测试，安全测试。|
| 48   | 支持进程完整性防护特性 | <font color=green>█</font>|共计执行50个用例，主要覆盖了： 1、覆盖dim_core、dim_monitor模块的对外接口以及启动参数的正常值、异常值、边界值等测试； 2、覆盖dim_tools工具针对用户态程序、ko、内核代码生成静态基线测试； 3、覆盖用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量测试； 4、覆盖度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量测试； 5、覆盖dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等； 6、覆盖全量安装环境下，针对所有用户态程序、ko、内核代码段的动态基线创建及度量测试； 7、覆盖策略文件、静态基线文件、度量日志最大值测试； 8、覆盖dim_core、dim_monitor模块对外接口的并发测试，以及基线创建与卸载模块的并发测试； 9、覆盖反复进行dim_core、dim_monitor动态基线创建、动态度量测试。 |
| 49   | 支持DPU直连聚合特性|<font color=green>█</font>|共3轮测试，设计场景7个，共有用例17个，覆盖功能，安全，可靠性测试。|
| 50   | 支持safeguard软件包|<font color=green>█</font>|共计执行54个测试用例，主要覆盖了功能测试、接口测试，整体质量良好。|
| 51   | 增加安全启动签名|<font color=green>█</font>|继证书导入BIOS db证书库、dbx证书库，及sbat防回滚的安全启动功能测试，结果符合要求;证书导入BIOS db证书库后在系统启动过程中重启测试，结果符合要求;证书导入后开启或关闭安全启动的系统时间对比，结果符合要求|

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.2.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **质量评估**    | **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | -------- |
|  1  |[提交内核安全增强补丁 HAOC](待刷新)| 未合入 |  |  | <font color=red>●</font> | |
|  2  |[机密计算远程证明服务：远程证明TEE插件框架](待刷新)| 共执行175个用例，新增10个，主要覆盖了接口测试，功能测试，组合场景测试，可靠性测试，压力和稳定性测试。当前无遗留问题|  |  | <font color=green>█</font>  | |
|  3  |[DPU场景vDPA新增支持磁盘，并支持配置vDPA网卡和磁盘的虚机热迁移](待刷新)| 设备热插拔及vDPA虚拟机热迁移可靠性场景无异常，验收通过 |  |  | <font color=green>█</font> | |
|  4  |[virtCCA机密虚机特性合入](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP4/IMA%E5%BA%94%E7%94%A8%E5%BA%A6%E9%87%8F%E6%89%A9%E5%B1%95%E8%87%B3virtCCA%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A.md)| 共计执行10个用例，主要覆盖了接口测试，功能测试，组合场景测试，可靠性测试，压力和稳定性测试，发现1个问题，已解决，整体质量良好。|  |  | <font color=green>█</font> | |
|  5  |[openSSL支持SM4-CE指令集，提升SM4运算速度](待刷新)| 经过１轮测试，覆盖了性能测试，SM4运算速度实测提升了56倍，当前无遗留问题 |   |  | <font color=green>█</font> | |
|  6  |[PowerAPI功耗管理统一API](待刷新)| 共执行用例50个，主要覆盖功能测试，发现问题14个 |  |  | <font color=green>█</font> | |
|  7  |[eagle实现整机能耗管理](待刷新)| 共执行用例39个，主要覆盖功能测试，发现问题14个 |   |  | <font color=green>█</font> | |
|  8  |[gala-ragdoll支持实时监控文件变更信息](待刷新)| 在测试环境进行了2轮迭代测试，对于需求功能，接口方面进行了完整完善的测试流程验证，符合结项标准要求 |   |  | <font color=green>█</font>  | |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好



## 4.3   兼容性测试结论

### 4.3.1   升级兼容性

openEuler 22.03-LTS-SP4 作为 openEuler 22.03-LTS SP3版本的增强扩展版本，支持从LTS SP3版本升级到对应的LTS SP4，完成如下场景的升级验证：

1、从22.03 LTS SP3到22.03 LTS SP4版本的升降级

2、升降级后系统的重启

上述场景下，软件包升降机后的功能验证、服务检查等测试；新增软件包通过对软件直接进行安装来进行；整体升级兼容性功能正常。

### 4.3.2   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成34张板卡的测试(该数目仅为测试数量，实际兼容性认证通过数量见社区[兼容性清单](https://www.openeuler.org/zh/compatibility/))

此版本的板卡兼容性适配测试，适配的板卡类型有（5）种，在aarch64/x86_64架构上进行适配，主要使用社区硬件兼容性测试工具oec-hardware集成compass-ci进行自动化测试，适配完成后将在社区发布此版本的板卡兼容性清单。

下表列出版本集成验证中涉及的硬件板卡信息：

| **板卡类型** | **覆盖范围**    | **测试主体**      | **chipVendor** | **boardModel**     | **chipModel**      | **aarch64架构测试结果** | **x86_64架构测试结果** |
| ------------ | --------------- | ----------------- | -------------- | ------------------ | ------------------ | ------------ | ------------ |
| RAID         | 适配8张         | sig-Compatibility |                |                    |                    |              ||
|              |                 |                   | Broadcom          | SP460C-M           | SAS3516            | PASS         | PASS         |
|              |                 |                   | Avago          | SR430C-M               | SAS-3 3108         | 不兼容(arm服务器不支持3108芯片的raid)         | PASS         |
|              |                 |                   | Avago          | SR130              | SAS3008            | PASS         | PASS         |
|              |                 |                   | Avago          | SR150-M             | SAS3408            | PASS         | PASS         |
|              |                 |                   | Avago          | SR450C-M              | SAS3508            | PASS         | PASS         |
|              |                 |                   | Avago          | 9440-8i             | SAS3408            | PASS         | PASS         |
|              |                 |                   | sssraid          |      Aries            | 3S580/3S585            | PASS         | PASS         |
|              |                 |                   | PMC          | PMC3152           | PM8204            | PASS         | PASS         |
| FC           | 适配9张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Marvell         | QLE2690            | ISP2722            | PASS         | PASS         |
|              |                 |                   | Marvell         | QLE2692            | ISP2722            | PASS         | PASS         |
|              |                 |                   | Marvell         | QLE2740            | ISP2722            | PASS         | PASS         |
|              |                 |                   | Marvell         | QLE2742            | ISP2722            | PASS         | PASS         |
|              |                 |                   | Marvell         | QLE2770            | ISP2812            | PASS         | PASS         |
|              |                 |                   | Marvell         | QLE2772            | ISP2812            | PASS         | PASS         |
|              |                 |                   | Marvell         | QLE2870            | ISP2812            | PASS         | PASS         |
|              |                 |                   | Marvell         | QLE2872            | ISP2812            | PASS         | PASS         |
|              |                 |                   | Emulex         | LPe31002-M6          | LPe31000/LPe32000  | PASS         | PASS         |
| SSD          | 适配1张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Huawei         | ES3600C V5-3200GB          | Hi 1812E V100       | PASS         | PASS         |
| IB           | 适配1张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Mellanox       | SP350              | ConnectX-5         | PASS         | PASS         |
| NIC          | 适配NIC板卡15张 | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Intel          | E810-XXV-2        |E810-XXV           | PASS         | PASS         |
|              |                 |                   | Huawei         | SP580              | Hi1822             | PASS         | PASS         |
|              |                 |                   | Huawei         | SP680                 | Hi1822 (Hi 1823)            | PASS         | PASS         |
|              |                 |                   | broadcom         | BCM57414                 | BCM57414            | PASS         | PASS         |
|              |                 |                   | Mellanox       | SP380              | ConnectX-4 Lx      | PASS         | PASS         |
|              |                 |                   | Mellanox       | SP382              | ConnectX-5      | PASS         | PASS         |
|              |                 |                   | Intel          | I350-F2            | I350               | PASS         | PASS         |
|              |                 |                   | Intel          | SP310            | 82599ES               | PASS         | PASS         |
|              |                 |                   | Intel          | XL710-Q1            | XL710               | PASS         | failed(带宽不达标)        |
|              |                 |                   | Netswift       | RP1000P2SFP          | RP1000      | PASS         | PASS         |
|              |                 |                   | Netswift       | RP2000P2SFP          | RP2000      | PASS         | PASS         |
|              |                 |                   | Netswift          | SF200T         | WX1860A2              | PASS         | PASS         |
|              |                 |                   | Netswift       | SF200HT                  | WX1860AL2 | PASS         | PASS         |
|              |                 |                   | Netswift        | SF400T               | WX1860A4               | PASS         | PASS         |
|              |                 |                   | Netswift          | SF400HT         | WX1860AL4               | PASS         | PASS         |


此版本的整机兼容性适配测试主要使用社区开源硬件兼容性测试工具oec-hardware，从整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性等方面进行适配，适配完成后将在社区发布此版本的整机兼容性清单。

整机适配兼容性测试交付清单如下：

| **整机厂商** | **整机型号**             | **CPU型号**   | **测试主体**      | **测试结果** |
| ------------ | ------------------------ | ------------- | ----------------- | ------------ |
| 华为          | 泰山200                  | 鲲鹏920       | sig-Compatibility | 待刷新         |
| 超聚变        | 2288H V5                 | Intel cascade | sig-Compatibility | 待刷新         |


整机兼容性清单以sig-Compatibility-Infra提供为主，社区各sig测试过程中使用的机器因未进行oec-hardware测试(进入社区兼容性清单质量要求)，故无法直接进行兼容性清单不在此描述。

### 4.3.3   虚拟机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 | 备注                                   |
| ---------- | ----------------------- | ------- | -------- | -------------------------------------- |
| openEuler 22.03 LTS SP4  | Centos 6 | x86_64 | PASS |         |
| openEuler 22.03 LTS SP4  | Centos 7 | aarch64 | PASS |         |
| openEuler 22.03 LTS SP4  | Centos 7 | x86_64  | PASS |         |
| openEuler 22.03 LTS SP4  | Centos 8 | aarch64 | PASS |         |
| openEuler 22.03 LTS SP4  | Centos 8 | x86_64  | PASS |         |
| openEuler 22.03 LTS SP4  | Windows Server 2016 | x86_64  | PASS |         |
| openEuler 22.03 LTS SP4  | Windows Server 2019 | x86_64  | PASS |         |


## 4.4   专项测试结论

### 4.4.1 安全测试

openEuler作为社区开源版本，在系统整体安全上需要进行保证，以发现系统中存在的安全脆弱性与风险，为版本的安全提供切实的依据，推动产品完成安全问题整改，提高产品的安全。主要测试项目如下表所示：

| 测试类         | 描述                                                 | 具体测试内容                                                 |
| :------------- | ---------------------------------------------------- | ------------------------------------------------------------ |
| 安全扫描类     | 病毒/开源漏洞/安全编译选项/敏感信息/代码片段引用扫描 | 通过工具进行相应的扫描，扫描结果采用增量的方式进行分析；编译选项和敏感信息需要针对新开源特性及新增软件包进行； |
| 安全配置管理类 | Linux安全规范                                        | Linux安全规范包括：服务管理，账号密码管理、文件及用户权限管理、内核参数配置管理、日志管理等；需对openEuler版本进行上述安全配置测试； |
| 安全检查       | 开源合规license检查/签名和完整性校验/SBOM            | 检查软件包的license是否合规；对于发布件要求具备签名和完整性校验机制，如RPM需要具备GPG校验与签名；SBOM信息具备自动生成的能力，随软件发布件一起生成与发布 |
| 安全评估       | 通过openscap检测系统安全漏洞和合规性                 | 漏洞扫描：确定系统中的已知漏洞；合规性检查：验证系统配置是否符合特定的安全标准和政策 |

整体OS安全测试较充分，风险可控。

### 4.4.2 可靠性测试

| 测试类型     | 测试内容                                                     | 测试结论                                                    |
| ------------ | ------------------------------------------------------------ | ----------------------------------------------------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | 7x24h(通过)|

### 4.4.3 性能测试

| **指标大项** | **指标小项**                                                 | **指标值**                        | **测试结论**     |
| ------------ | ------------------------------------------------------------ | --------------------------------- | ---------------- |
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考22.03 LTS SP3版本相应指标基线 | 比较前一版本持平  |



# 5   问题单统计

openEuler 22.03 LTS SP4 版本共发现问题 286 个，有效问题 278 个，其中遗留问题 0 个。详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注        |
| --------------------------- | -------- | ------------ | ------------ | ------------ | -------------------------- |
| openEuler 22.03 LTS SP4 RC1        | 174   | 173     | 1   | 0      | Beta轮次  |
| openEuler 22.03 LTS SP4 RC2        | 58    | 55      | 3   | 0      | 全量集成 |
| openEuler 22.03 LTS SP4 RC3        | 28    | 25      | 3   | 0      | 全量集成  |
| openEuler 22.03 LTS SP4 RC4        | 26    | 27      | 1   | 0      | 回归测试    |
| openEuler 22.03 LTS SP4 RC5        |  0    |  0      | 0   | 0      | 版本发布验收测试(回归测试) |



# 6 版本测试过程评估

#### 6.1 问题单分析

本次版本测试各迭代有效问题数量呈收敛趋势，没有问题溢出的风险。其中第一轮迭代中的174个有效问题中，有18项主要问题，均已修复；第二轮迭代中共58个有效问题，其中1项严重问题，17项主要问题，均已修复。

- 关键问题类型：软件版本/release号相较openEuler-22.03-LTS-SP3最新update较低

  此类问题约有153项，存在51项版本号降级，存在102项release号降级的软件，大多数因社区开发者在master分支进行升级后，直接将patch同步到22.03-LTS-SP3分支，而非先同步到openEuler-22.03-LTS-Next上再同步SP3导致，为流程规范问题。

#### 6.2 OS集成测试迭代版本基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 22.03 LTS SP4 RC1 | 冒烟测试         |                                |
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
| openEuler 22.03 LTS SP4 RC2 | 冒烟测试         |                                |
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
| openEuler 22.03 LTS SP4 RC3 | 冒烟测试         |                                |
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
| openEuler 22.03 LTS SP4 RC4 | 冒烟测试         |                                |
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
| openEuler 22.03 LTS SP4 RC5 | 版本发布验收     | 版本发布验收                   |

# 6   附件

## 遗留问题列表

| 序号 | 问题单号    | 问题简述    | 问题级别 | 影响分析   | 规避措施       | 历史发现场景     |
| ---- | ------------------------------------------------------------ | ----------------------------------------------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    |暂无 |  |   |  | | |



# 致谢
非常感谢以下sig在openEuler 22.03 LTS SP4 版本测试中做出的贡献,以下排名不分先后
infra-sig的各位贡献者
@wangchong1995924 @small_leek @yaolonggang @dongjie110 @cxl78320 @raomingbo @shdluan @wu_zhende @weijihui @liu-yinsi @duan_pj @wangLin0_0 @georgecao @zhongjun2 @gzbang @liuqi469227928 @wanghaosq @dakang_siji @liuyanglinun @Tom_zx @haml @qinsheng99_code
<br>
RM-sig的各位贡献者
@solarhu @chenyaqiang @paul-huang
<br>
QA-sig的各位贡献者
@zjl_long @ga_beng_cui @hanson-fang @erin_dan @丁娇 @wenjun @suhang @zhanglu626 @ssttkx @zhangpanting  @MDS_ZHR @banzhuanxiaodoubi 
 @clay @oh_thats_great @wangting112 @lijiaming666 @liwencheng6769 @luluyuan @lutianxiong @chenshijuan3 @laputa0 @lcqtesting @xiuyuekuang @ganqx
@woqidaideshi @yjt-dli @disnight @chenshijuan3 @wangpeng_uniontech @fu-shanqing @saarloos @ding-jiao
<br>
以及所有参与22.03 LTS SP4但未统计到的所有开发者
(如有遗漏可随时联系 @disnight email:fjc837005411@outlook.com 反馈)
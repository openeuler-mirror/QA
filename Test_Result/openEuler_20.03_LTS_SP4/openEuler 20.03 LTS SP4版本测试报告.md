![openEuler ico](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | --------------- | ----------- |
| 2023/10/31 | 1.0.0    | 初稿                  | disnight    |
| 2023/11/22 | 1.1.0    | 基于alpha、RC1/2/3更新 | zjl_long |
| 2023/12/08 | 1.2.0    | 基于RC5更新               | ga_beng_cui |


关键词：

openEuler raspberrypi DDE OpenStack kunpengsecl secGear embedded oemaker gazelle iSulad A-Ops

摘要：

本文主要描述openEuler 20.03 LTS SP4 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 20.03 LTS SP4 版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 20.03 LTS SP4 是基于4.19内核20.03-LTS的补丁增强版本，面向服务器、云、边缘计算和嵌入式场景。该版本基于openEuler 20.03 LTS SP3分支拉出，发布范围相较20.03 LTS版本主要变动：

1. 软件版本选型升级，详情请见[版本变更说明]()
2. 修复bug和cve
3. 特性变更见feature list章节
4. 该版本主要基于社区收集到的对4.19版本延长生命周期的需求，主要面向质量加固增发该版本，后续考虑收编20.03 LTS所有相关版本。

## 2.1 版本测试计划
openEuler 20.03 LTS SP4 版本按照社区[release-manager团队的计划](https://gitee.com/openeuler/release-management/blob/master/openEuler-20.03-LTS-SP4/release-plan.md)，共规划6轮测试，详细的版本信息和测试时间如下表：

| 版本阶段计划          | 开始时间(计划) | 结束时间(计划) | 开始时间(实际) | 周期 | 备注                                      |
| -------------------- | ------------- | ------------- | ------------- | ---- | ----------------------------------------- |
| Collect key features | 2023/8/10     | 2023/9/10    | 2023/8/10      | 30   | 收集openEuler 20.03-LTS-SP4版本关键特性（各SIG自行录入release-plan）    |
| Develop              | 2023/8/10     | 2023/9/24    | 2023/8/10      | 45   | 特性完成开发和自验证，代码提交合入openEuler 20.03-LTS-SP4              |
| 内核冻结              | 2023/9/25     | 2023/9/30    | 2023/10/31    | 5    | 内核冻结，KABI接口基线化评审 |
| 分支全量Build         | 2023/10/8     | 2023/10/12   | 2023/10/16     | 5    | 拉取openEuler 20.03-LTS-SP4分支，完成分支全量构建 |
| Alpha                | 2023/10/14    | 2023/10/18   | 2023/10/25     | 5    | 发布Alpha版本，启动全版本功能冒烟测试                            |
| Test round 1（Beta）  | 2023/10/21    | 2023/10/25   |  2023/10/31  | 5    | 发布Beta版本，启动版本SIT测试                                |
| Test round 2         | 2023/10/28    | 2023/11/1     |  2023/11/7  | 7    | SIT测试，特性基线合入冻结，不再接纳功能性代码合入                                                      |
| Test round 3         | 2023/11/4     | 2023/11/8     |  2023/11/16  | 5    |   SIT测试                |
| Test round 4         | 2023/11/11    | 2023/11/15    |  2023/11/22  | 5    |   SIT测试                                                     |
| Test round 5         | 2023/11/18    | 2023/11/22    | 2023/11/30   | 5    |   发布release预览版本，版本缺陷回归验证                                                     |
| Release              | 2023/11/28    | 2023/11/28    |  2023/12/08   | 1    |   版本GO/NO GO发布评审                                               |

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

openEuler 20.03 LTS SP4版本交付需求列表如下，详情见[openEuler-20.03-LTS-SP4 release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-20.03-LTS-SP4/release-plan.md)：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|1|eNFS|Discussion|Kernel|闫海涛|ISO|nfs，sunrpc，eNfs|
|2|metalink|Discussion|Infrastructure|mywaaagh_admin|ISO|openEuler-repos|
|3|OpenStack Train|Discussion|OpenStack|郑挺|EPOL|OpenStack-SIG|
|4|DDE组件更新支持服务器场景优化|Discussion|sig-DDE|[@leeffo](https://gitee.com/leeffo)|EPOL||

> 当前社区release分为以下几种方式: 标准 ISO/everything ISO/Epol/独立镜像/独立发布
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
| 支持mindspore                             | ai                           | ai                           | 验证mindspore相关软件包单包功能                              |
| 支持pod带宽管理oncn-bwm                   | sig-high-performance-network | sig-high-performance-network | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
| 支持基于分布式软总线扩展生态互联互通      | sig-embedded                 | sig-embedded                 | 验证openEuler和openHarmony设备进行设备认证，互通互联特性     |
| 支持混合关键部署技术扩展                  | sig-embedded                 | sig-embedded                 | 验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 支持硬实时系统                            | sig-embedded                 | sig-embedded                 | 验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力     |
| 支持kubernetes                            | sig-CloudNative              | sig-CloudNative              | 验证K8S在openEuler上的安装部署以及提供的对容器的管理能力     |
| 安装部署                                  | sig-OS-Builder               | sig-OS-Builder               | 验证覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| Kunpeng加速引擎                           | sig-AccLib                   | sig-AccLib                   | 验证对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加速器KAE的基本功能和性能测试 |
| 备份还原功能支持                          | sig-Migration                | sig-Migration                | 验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常 |

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试



# 3 版本概要测试结论

   openEuler 20.03 LTS SP4 版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 1轮重点特性测试 + 2轮全量测试 + 1轮回归测试 + 1轮版本发布验收测试。  
   第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项；  
   第2轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫描及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；  
   第3、4轮全量测试开展版本交付的所有特性和各类专项测试；  
   第5轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；  
   第6轮版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

   openEuler 20.03 LTS SP4 共发现问题 270 个，有效问题 252 个，无效问题 18 个。遗留问题 2 个，版本整体质量良好。



# 4 版本详细测试结论

openEuler 20.03 LTS SP4 版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试、资料测试；

5、对版本新增特性进行功能、可靠性等专项测试，新增特性均满足发布要求，测试较充分，质量良好；



## 4.1   软件范围变化分析结论

### 4.1.1 标准ISO范围软件变化分析

经比较，openEuler-20.03-LTS-SP4 BaseOS相较openEuler-20.03-LTS-SP3 BaseOS范围变更如下：

详情可参考[openEuler-20.03-LTS-SP4-normal_aarch64.xml](https://gitee.com/src-openeuler/oemaker/blob/openEuler-20.03-LTS-SP4/normal_aarch64.xml)与[openEuler-20.03-LTS-SP4-normal_x86_64.xml](https://gitee.com/src-openeuler/oemaker/blob/openEuler-20.03-LTS-SP4/normal_x86_64.xml)

### 4.1.2 整体软件范围变化分析

经比较，openEuler-20.03-LTS-SP4 对比 openEuler-20.03-LTS-SP3 存在 8 项版本号降级，但存在 16 项release号降级的软件。经定位系SP3 update版本同步升级时开发者处理流程不规范导致，此 24 项软件均已提单跟踪，除dtkcommon（EPOL）外，其他软件包于RC3完成闭环。  
issue链接：https://gitee.com/src-openeuler/dtkcommon/issues/I8D3YK?from=project-issue

迭代测试过程中，全量测试环节openEuler-20.03-LTS-SP4 RC3不存在软件版本降级，同时也不存在release降级。


## 4.2   特性测试结论

### 4.2.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估。

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
| 29   | 支持mindspore                             | <font color=green>█</font> | 继承已有测试能力，针对openCV、opencl-clhpp、onednn、Sentencepiece4个模块，复用开源测试能力覆盖安装、接口测试、功能测试，重点关注对mindspore提供能力的稳定性 |
| 30   | 支持pod带宽管理oncn-bwm                   | <font color=green>█</font> | 继承已有测试能力，验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
| 31   | 支持基于分布式软总线扩展生态互联互通      | <font color=green>█</font> | 继承已有测试能力，验证openEuler和openHarmony设备进行设备认证，互通互联特性 |
| 32   | 支持混合关键部署技术扩展                  | <font color=green>█</font> | 继承已有测试能力，验证基于openAMP框架实现软实时（openEuler Embedded）与硬实时OS（zephyr）共同部署，一个核运行硬实时OS，其他核运行软实时OS |
| 33   | 支持硬实时系统                            | <font color=green>█</font> | 继承已有测试能力，验证硬实时级别的OS能力，支持硬中断管理、轻量级任务等能力 |
| 34   | 支持kubernetes                            | <font color=green>█</font> | 继承已有测试能力，重点验证K8S在openEuler上的安装部署以及提供的对容器的管理能力 |
| 35   | 安装部署                                  | <font color=green>█</font> | 继承已有测试能力，覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
| 36   | Kunpeng加速引擎                           | <font color=green>█</font> | 继承已有测试能力，重点对称加密算法SM4/AES、非对称算法RSA及秘钥协商算法DH进行加加速器KAE的基本功能和性能测试 |
| 37   | 备份还原功能支持                          | <font color=green>█</font> | 验证dde基础组件、预装应用核心功能、新增特性基础功能以及基本UI功能正常 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.2.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估，给出特性质量评估结论。

| 序号 |     特性名称       | 测试覆盖情况 | 遗留问题单 | 特性质量评估 | 备注 |
| --- | ----------------- | ---------- | -------- | :---------: | -- |
|  1  |    eNFS           | 待刷新  | NA |  |  | 
|  2  |    metalink       | 待刷新  | NA |  |  |
|  3  |  OpenStack Train  | 待刷新  | NA |  |  |
|  4  | DDE组件更新支持服务器场景优化 | 待刷新  | NA |  | |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好


## 4.3   兼容性测试结论

### 4.3.1   升级兼容性

openEuler 20.03-LTS-SP4 作为 openEuler 20.03-LTS SP3版本的增强扩展版本，支持从LTS SP3版本升级到对应的LTS SP4，完成如下场景的升级验证：

1、从20.03 LTS SP3到20.03 LTS SP4版本的升降级

2、从20.03 LTS的月度update维护版本到20.03 LTS SP4版本的升降级

3、升降级后系统的重启

上述场景下，软件包升降机后的功能验证、服务检查等测试；新增软件包通过对软件直接进行安装来进行；整体升级兼容性功能正常。

### 4.3.2   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成29张板卡的测试(该数目仅为测试数量，实际兼容性认证通过数量见社区[兼容性清单](https://www.openeuler.org/zh/compatibility/))

此版本的板卡兼容性适配测试，适配的板卡类型有RAID/FC/GPU/SSD/IB/NIC/六种，在aarch64/x86_64架构上进行适配，主要使用社区硬件兼容性测试工具oec-hardware集成compass-ci进行自动化测试，适配完成后将在社区发布此版本的板卡兼容性清单。

下表列出版本集成验证中涉及的硬件板卡信息：

| **板卡类型** | **覆盖范围**    | **测试主体**      | **chipVendor** | **boardModel**     | **chipModel**      | **测试结果** |
| ------------ | --------------- | ----------------- | -------------- | ------------------ | ------------------ | ------------ |
| RAID         | 适配7张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Avago          | 9560-8i            | SAS3908            | PASS         |
|              |                 |                   | Avago          | SP460C-M           | SAS3516            | PASS         |
|              |                 |                   | Avago          | SR150-M            | SAS3408            | PASS         |
|              |                 |                   | Avago          | SR430C-M           | SAS-3 3108         | PASS         |
|              |                 |                   | Avago          | SR450C-M           | SAS3508         | PASS         |
|              |                 |                   | Avago          | SR130              | SAS3008            | PASS         |
|              |                 |                   | Avago          | PMC3152           | PM8204            | PASS         |
| FC           | 适配11张         | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Emulex         | LPe36002-M64       | LPe35000/LPe36000  | PASS         |
|              |                 |                   | Marvell/Qlogic | QLE2560            | ISP2532            | PASS         |
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
| NIC          | 适配NIC板卡13张 | sig-Compatibility |                |                    |                    |              |
|              |                 |                   | Intel          | BCM957414A4142CC        |BCM57414           | PASS         |
|              |                 |                   | Intel          | E810-XXV-2        |E810-XXV           | PASS         |
|              |                 |                   | Huawei         | SP580              | Hi1822             | PASS         |
|              |                 |                   | Mellanox       | SP382              | ConnectX-5         | PASS         |
|              |                 |                   | Mellanox       | SP380              | ConnectX-4 Lx      | PASS         |
|              |                 |                   | Intel          | I350-F2            | I350               | PASS         |
|              |                 |                   | Intel          | SP310            | 82599ES               | PASS         |
|              |                 |                   | Netswift       | RP1000      | RP1000      | PASS         |
|              |                 |                   | Netswift       | RP2000      | RP2000      | PASS         |
|              |                 |                   | Netswift          | SF200HT         | SF200HT              | PASS         |
|              |                 |                   | Netswift       | SF200T             | SF200T | PASS         |
|              |                 |                   | Netswift          | SF 400HT              | SF 400HT               | PASS         |
|              |                 |                   | Netswift          | SF 400T         | SF400T               | PASS         |




此版本的整机兼容性适配测试主要使用社区开源硬件兼容性测试工具oec-hardware，从整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性等方面进行适配，适配完成后将在社区发布此版本的整机兼容性清单。

整机适配兼容性测试交付清单如下：

| **整机厂商** | **整机型号**             | **CPU型号**   | **测试主体**      | **测试结果** |
| ------------ | ------------------------ | ------------- | ----------------- | ------------ |
| 华为         | 泰山200                  | 鲲鹏920        | sig-Compatibility | PASS         |
| 超聚变       | 2288H V5                 | Intel cascade | sig-Compatibility | PASS         |
|              | 2288H V6                 | icelake      | sig-Compatibility | PASS         |
| AMD          | ERYC 3                   | cascade      | sig-Compatibility | PASS         |



整机兼容性清单以sig-Compatibility-Infra提供为主，社区各sig测试过程中使用的机器因未进行oec-hardware测试(进入社区兼容性清单质量要求)，故无法直接进行兼容性清单不在此描述。

### 4.3.3   虚拟机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 | 备注     |
| ---------- | ---------------------- | ------ | ------- | ------- |
| openEuler 20.03 LTS SP4  | Centos 6 | x86_64 | PASS |         |
| openEuler 20.03 LTS SP4  | Centos 7 | aarch64 | PASS |         |
| openEuler 20.03 LTS SP4  | Centos 7 | x86_64  | PASS |         |
| openEuler 20.03 LTS SP4  | Centos 8 | aarch64 | PASS |         |
| openEuler 20.03 LTS SP4  | Centos 8 | x86_64  | PASS |         |
| openEuler 20.03 LTS SP4  | Windows Server 2016 | aarch64 | PASS |         |
| openEuler 20.03 LTS SP4  | Windows Server 2016 | x86_64  | PASS |         |
| openEuler 20.03 LTS SP4  | Windows Server 2019 | aarch64 | PASS |         |
| openEuler 20.03 LTS SP4  | Windows Server 2019 | x86_64  | PASS |         |



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
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况 | RC2 7x24h(通过)<br />RC4 7x24h(待开展)<br />RC5 7*24h(待开展)  |

### 4.4.3 性能测试

| **指标大项** | **指标小项**                                                 | **指标值**                        | **测试结论**     |
| ------------ | ------------------------------------------------------------ | --------------------------------- | ---------------- |
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统 | 参考20.03 LTS SP3版本相应指标基线 | 较前一版本无下降 |



# 5   问题单统计

openEuler 20.03 LTS SP4 版本共发现问题 239 个，有效问题 226 个，其中遗留问题 0 个。详细分布见下表:

| 测试阶段                            | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注                       |
| --------------------------- | -------- | ------------ | ------------ | ------------ | -------------------------- |
| openEuler 20.03 LTS SP4 dailybuild |    105    |     102    |   3   |    0    |    |
| openEuler 20.03 LTS SP4 alpha      |    39     |     36     |   4   |    0    |    |
| openEuler 20.03 LTS SP4 RC1        |    80     |     73     |   5   |    2    | Beta版本 |
| openEuler 20.03 LTS SP4 RC2        |    16     |     14     |   2   |    0    | 重点特性测试 |
| openEuler 20.03 LTS SP4 RC3        |    24     |     21     |   3   |    0    | 全量集成 |
| openEuler 20.03 LTS SP4 RC4        |     6     |      5     |   1   |    0    | 全量集成 |
| openEuler 20.03 LTS SP4 RC5        |     0     |      0     |   0   |    0    | 回归测试 |
| openEuler 20.03 LTS SP4 RC6        |      0    |      0     |   0   |    0    | 版本发布验收测试(回归测试) |



# 6 版本测试过程评估

#### 6.1 问题单分析

本次版本测试除去开发自验轮次，各迭代有效问题数量整体呈收敛趋势，没有问题溢出的风险。其中第一轮迭代中的73个有效问题中，有1项严重问题，70项主要问题，均已被修复，部分已完成回归；第二轮迭代中共14个有效问题，其中8项主要问题，均已被修复;第三轮迭代中，因存在新特性合入，所以相较于第二轮问题单数量增多，除去新特性问题单，OS层面共10个有效问题，其中6项主要问题，均已被修复。

#### 6.2 OS集成测试迭代版本基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 20.03 LTS SP4 RC1 | 冒烟测试         |                                |
| openEuler 20.03 LTS SP4 RC2 | 冒烟测试         |                                |
|                             | 包管理专项       | rpm包管理                      |
|                             |                | source包自编译                 |
|                             | 重启专项专项     | 冷重启                         |
|                             |                | 热重启                         |
|                             |                | 高压重启                       |
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
| openEuler 20.03 LTS SP4 RC3 | 冒烟测试         |                                |
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
| openEuler 20.03 LTS SP4 RC4 | 冒烟测试         |                                |
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
| openEuler 20.03 LTS SP4 RC5 | 冒烟测试         |                                |
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
| openEuler 20.03 LTS SP4 RC6 | 版本发布验收     | 版本发布验收                   |

# 7   附件

## 遗留问题列表

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析  | 规避措施 | 历史发现场jing |
| ---- | ------------------------------------------------------------ | ----------------------------------------------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | [I8DBPV](https://gitee.com/src-openeuler/hadoop/issues/I8DBPV?from=project-issue) | 【20.03 LTS SP4 round1】【arm\x86】安装 nodejs-yarn和hadoop-yarn冲突 | 次要     | nodejs-yarn和hadoop-yarn bin目录下启动文件都命名为yarn，一起安装会冲突。暂无用户同时安装nodejs-yarn和hadoop-yarn，且不建议同时安装nodejs-yarn和hadoop-yarn，影响可控| 版本遗留 | 
| 2   | [I8D3YK](https://gitee.com/src-openeuler/dtkcommon/issues/I8D3YK?from=project-issue) | 【20.03-SP4-rc1】dtkcommon包在20.03-LTS-SP4-RC1中相比20.03-LTS-SP3&20.03-LTS-SP4-alpha版本降级   | 次要  | 20.03-LTS-SP3分支无此软件包，不影响20.03-LTS-SP3升级到20.03-LTS-SP4,影响可控| 版本遗留 | 


# 致谢
非常感谢以下sig在openEuler 20.03 LTS SP4 版本测试中做出的贡献,以下排名不分先后
infra-sig的各位贡献者
@wangchong1995924 @small_leek @yaolonggang @dongjie110 @cxl78320 @raomingbo @shdluan @wu_zhende @weijihui @liu-yinsi @duan_pj @wangLin0_0 @georgecao @zhongjun2 @gzbang @liuqi469227928 @wanghaosq @dakang_siji @liuyanglinun @Tom_zx @haml @qinsheng99_code<br>
RM-sig的各位贡献者
@solarhu @chenyaqiang @paul-huang<br>
QA-sig的各位贡献者
@zjl_long @ga_beng_cui @hanson-fang @erin_dan @丁娇 @wenjun @suhang @zhanglu626 @ssttkx @zhangpanting @hukun66 @banzhuanxiaodoubi
@yanglijin @clay @oh_thats_great @wangting112 @lijiaming666 @liwencheng6769 @luluyuan @lutianxiong @chenshijuan3 @laputa0 @lcqtesting @xiuyuekuang @ganqx
@woqidaideshi @yjt-dli @disnight @chenshijuan3 @wangpeng_uniontech @fu-shanqing @saarloos <br>
以及所有参与20.03 LTS SP4但未统计到的所有开发者
(如有遗漏可随时联系 @disnight email:fjc837005411@outlook.com 反馈)
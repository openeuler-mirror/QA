![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2024/05/13 | 1.0.0    | 初稿, 基于RC1/2/3/4 | ga_beng_cui |


关键词：

openEuler raspberrypi DDE iSulad RISC-V utshell utsudo A-Ops UKUI Gazelle kmesh-bwm sysmonitor 

摘要：

文本主要描述openEuler 24.03 LTS 版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 24.03 LTS 版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 24.03 LTS 版本是基于6.6内核2024年全新的LTS基线版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler master分支拉出，发布范围相较23.09版本主要变动：

1.  内核升级，由6.４升级至6.6
2. 软件版本选型，详情请见[全量软件包版本选型](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS/%E5%85%A8%E9%87%8F%E8%BD%AF%E4%BB%B6%E5%8C%85%E9%80%89%E5%9E%8B.md)
3. 修复bug和cve
4. iSulad新增特性支持
5. RISC-V架构新增能力支持
6. DDE组件、SecGear、gazelle、sysmonitor、NestOS、Rubik、AOps、migration-tool等特性增强


## 2.1 版本测试计划
openEuler 24.03 LTS 版本按照社区release-manager团队的计划，共规划6轮测试，详细的版本信息和测试时间如下表：

| 版本名称     | 测试起始时间 | 测试结束时间   | 备注                                                         |
| ------------ | ------------ | -------------- | ------------------------------------------------------------ |
| Build & Alpha          | 2024/03/21 | 2024/03/30 | 7    | 开发自验证 |
| Test round 1           | 2024/03/31 | 2024/04/08 | 9    | 24.03-LTS版本启动集成测试   |
| Beta Version release   | 2024/04/03 | 2024/04/09 | 7    | 24.03-LTS Beta版本发布     |
| Test round 2           | 2024/04/09 | 2024/04/15 | 7    | 全量SIT验证    |
| Test round 3           | 2024/04/16 | 2024/04/30 | 15   | 全量SIT验证    |
| Test round 4           | 2024/05/06 | 2024/05/12 | 7    | 回归测试 ,分支启动冻结，只允许bug fix   |
| Test round 5           | 2024/05/13 | 2024/05/19 | 7    | 回归测试 ,分支冻结，只允许bug fix   |
| Test round 6           | 2024/05/20 | 2024/05/22 | 3    | 回归测试    |
| Release                | 2024/05/21 | 2024/05/23 | 3    | 社区Release版本发布评审    |

## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920                              | OS集成测试     |
| RH2288H V3            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| 树莓派 4B              | BCM2711                                  | 嵌入式版本测试 |
| STM32F407ZGT6开发板    | CPU:STM32F407ZG(168MHz)                  | 嵌入式版本测试 |
| 超聚变 2288H V5        | Intel cascade                            | 南向兼容性测试 |

## 2.3 需求清单

openEuler 24.03 LTS版本交付需求列表如下，详情见[openEuler-24.03-LTS release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS/release-plan.md)：

| no   | feature                                                      | status   | sig                          | owner                                                        | 发布方式         | 备注                                        |
| ---- | ------------------------------------------------------------ | -------- | ---------------------------- | ------------------------------------------------------------ | ---------------- | ------------------------------------------- |
|[I8WG9C](https://gitee.com/openeuler/release-management/issues/I8WG9C) | 发布kiran-desktop 2.6版本 | Discussion | sig-KIRAN-DESKTOP | [@liubuguiii](https://gitee.com/liubuguiii) |
|[I8UU1C](https://gitee.com/openeuler/release-management/issues/I8UU1C)|iSulad支持CRI v1.29|Discussion|sig-iSulad|[@xuxuepeng](https://gitee.com/xuxuepeng)|
|[I8UUCX](https://gitee.com/openeuler/release-management/issues/I8UUCX)|iSulad支持CDI|Discussion|sig-iSulad|[@xuxuepeng](https://gitee.com/xuxuepeng)|
|[I8UVAY](https://gitee.com/openeuler/release-management/issues/I8UVAY)|iSulad支持NRI|Discussion|sig-iSulad|[@xuxuepeng](https://gitee.com/xuxuepeng)|
|[I8W6CJ](https://gitee.com/openeuler/release-management/issues/I8W6CJ)|iSulad支持cgroup v2|Discussion|sig-iSulad|[@xuxuepeng](https://gitee.com/xuxuepeng)|
|[I8Y48L](https://gitee.com/openeuler/release-management/issues/I8Y48L)|为 RISC-V 架构增加内核热补丁能力|Discussion|sig-RISC-V|[@laokz](https://gitee.com/laokz)|
|[I8Y3WV](https://gitee.com/openeuler/release-management/issues/I8Y3WV)|为 RISC-V 架构引入 Penglai TEE 支持|Discussion|sig-RISC-V|[@dongduResearcher](https://gitee.com/dongduResearcher)|
|[I8YAGF](https://gitee.com/openeuler/release-management/issues/I8YAGF)|wine5.5升级到wine9.0，不需要linux32依赖库情况下支持win32程序|Discussion|sig-compat-winapp|[@niko_yhc](https://gitee.com/niko_yhc)|
|[I8Y4I0](https://gitee.com/openeuler/release-management/issues/I8Y4I0)|支持树莓派|Discussion|sig-RaspberryPi|[@woqidaideshi](https://gitee.com/woqidaideshi/)|
|[I914GW](https://gitee.com/openeuler/release-management/issues/I914GW)|DDE支持|Discussion|sig-DDE|[@ut-layne-yang](https://gitee.com/ut-layne-yang)|
|[I8ZJBA](https://gitee.com/openeuler/release-management/issues/I8ZJBA)|migration-tools增加图形化迁移openeuler功能|Discussion|sig-Migration|[@xingwei-liu](https://gitee.com/xingwei-liu/)|
|[I8ZJFG](https://gitee.com/openeuler/release-management/issues/I8ZJFG)|增加 utshell 项目发布|Discussion|sig-memsafety|[@wangmengc](https://gitee.com/wangmengc/)|EPOL|utshell|
|[I8ZJGW](https://gitee.com/openeuler/release-management/issues/I8ZJGW)|增加 utsudo 项目发布|Discussion|sig-memsafety|[@ut-wanglujun](https://gitee.com/ut-wanglujun/)|EPOL|utsudo|
|[I94ET0](https://gitee.com/openeuler/release-management/issues/I94ET0)|发布Nestos-kubernetes-deployer |Discussion|sig-K8sDistro|[@duyiwei7w](https://gitee.com/duyiwei7w)|
|[I9780H](https://gitee.com/openeuler/release-management/issues/I9780H)| 支持vCPU热插拔 |Discussion|sig-kernel|[@JiaboFeng](https://gitee.com/JiaboFeng)|
|[I9780Y](https://gitee.com/openeuler/release-management/issues/I9780Y)| A-Ops gala提供网络L4层TCP主流指标观测能力 |Discussion|sig-ops|[@MrRlu](https://gitee.com/MrRlu)|
|[I97814](https://gitee.com/openeuler/release-management/issues/I97814)| A-Ops gala提供网络L7层RED指标观测能力 |Discussion|sig-ops |[@MrRlu](https://gitee.com/MrRlu)|
|[I97817](https://gitee.com/openeuler/release-management/issues/I97817)| A-Ops gala提供应用粒度的I/O、CPU、MEM资源占用观测能力|Discussion|sig-ops |[@MrRlu](https://gitee.com/MrRlu)|
|[I9781E](https://gitee.com/openeuler/release-management/issues/I9781E)| A-Ops gala支持可观测行为的动态变更 |Discussion|sig-ops |[@MrRlu](https://gitee.com/MrRlu)|
|[I9781K](https://gitee.com/openeuler/release-management/issues/I9781K)|内存潮汐调度：支持serverless容器热备份 |Discussion|sig-kernel |[@ stkid](https://gitee.com/stkid)|
|[I9782E](https://gitee.com/openeuler/release-management/issues/I9782E)| LLVM版本升级到17.0.6 |Discussion|sig-Compiler |[@ cf-zhao](https://gitee.com/cf-zhao)|
|[I9784H](https://gitee.com/openeuler/release-management/issues/I9784H)| 支持系统运维套件x-diagnosis |Discussion|sig-ops ||
|[ I9784N](https://gitee.com/openeuler/release-management/issues/I9784N)| 支持自动化热升级组件nvwa |Discussion|sig-ops ||
|[ I9785W](https://gitee.com/openeuler/release-management/issues/I9785W)| 支持DPU直连聚合特性 |Discussion|sig-DPU ||
|[ I9786D](https://gitee.com/openeuler/release-management/issues/I9786D)| 支持系统热修复组件syscare |Discussion|sig-ops ||
|[ I9786H](https://gitee.com/openeuler/release-management/issues/I9786H)| 支持内存分级扩展组件etmem |Discussion|sig-Storage|[@swf504](https://gitee.com/swf504)|
|[ I97878](https://gitee.com/openeuler/release-management/issues/I97878)| iSula容器镜像构建工具isula-build |Discussion|sig-iSulad||
|[ I9787D](https://gitee.com/openeuler/release-management/issues/I9787D)| 一键式、轻量化、可配置集群部署工具eggo |Discussion|sig-isulad ||
|[ I9787G](https://gitee.com/openeuler/release-management/issues/I9787G)| 支持容器引擎isulad |Discussion|sig-iSulad ||
|[ I9787L](https://gitee.com/openeuler/release-management/issues/I9787L)| 支持进程完整性防护特性 |Discussion|sig-security-facility |[@HuaxinLuGitee](https://gitee.com/HuaxinLuGitee)|
|[ I9787O](https://gitee.com/openeuler/release-management/issues/I9787O)| 支持入侵检测框架secDetector|Discussion|sig-security-facility |[@zcfsite](https://gitee.com/zcfsite)|
|[ I9787P](https://gitee.com/openeuler/release-management/issues/I9787P)| imageTailor支持树莓派镜像定制|Discussion|sig-OS-Builder |[@zhuchunyi](https://gitee.com/zhuchunyi)|
|[ I9787U](https://gitee.com/openeuler/release-management/issues/I9787U)| 支持secPaver特性 |Discussion|sig-security-facility |[@HuaxinLuGitee](https://gitee.com/HuaxinLuGitee)|
|[ I9788R](https://gitee.com/openeuler/release-management/issues/I9788R)| 支持机密计算安全应用开发组件 secGear |Discussion|sig-confidential-computing |[@houmingyong](https://gitee.com/houmingyong)|
|[ I9788S](https://gitee.com/openeuler/release-management/issues/I9788S)| 系统性能自优化组件A-Tune |Discussion|sig-A-Tune|[@ gaoruoshu](https://gitee.com/gaoruoshu)|
|[ I9788W](https://gitee.com/openeuler/release-management/issues/I9788W)| isocut镜像裁剪易用性提升 |Discussion|sig-OS-Builder |[@zhuchunyi](https://gitee.com/zhuchunyi)|
|[ I97890](https://gitee.com/openeuler/release-management/issues/I97890)| 支持devmaster组件 |Discussion|sig-dev-utils ||
|[ I9789Q](https://gitee.com/openeuler/release-management/issues/I9789Q)| 支持TPCM特性 |Discussion|sig-Base-service|[@t_feng](https://gitee.com/t_feng)|
|[ I9789U](https://gitee.com/openeuler/release-management/issues/I9789U)| 支持sysMaster组件 |Discussion|sig-dev-utils ||
|[ I9789V](https://gitee.com/openeuler/release-management/issues/I9789V)| 安全配置规范框架设计及核心内容构建 |Discussion|sig-security-facility||
|[ I9789Y](https://gitee.com/openeuler/release-management/issues/I9789Y)| A-OPS智能运维工具 |Discussion|sig-ops||
|[ I978A1](https://gitee.com/openeuler/release-management/issues/I978A1)| 支持sysmonitor特性 |Discussion|sig-ops|[@foreson](https://gitee.com/foreson)|
|[ I978A3](https://gitee.com/openeuler/release-management/issues/I978A3)| kmesh-bwm高性能网络带宽管理 |Discussion|sig-high-performance-network|[@yanan-rock](https://gitee.com/yanan-rock)|
|[ I978A5](https://gitee.com/openeuler/release-management/issues/I978A5)| Gazelle用户态协议栈 |Discussion|sig-high-performance-network |[@yanan-rock](https://gitee.com/yanan-rock)|
|[ I978A7](https://gitee.com/openeuler/release-management/issues/I978A7)| 混合部署rubik |Discussion|sig-CloudNative||
|[ I978AC](https://gitee.com/openeuler/release-management/issues/I978A1)| isulad支持oci runtime并且切换默认runtime为runc |Discussion|sig-iSulad ||
|[ I97DTY](https://gitee.com/openeuler/release-management/issues/I97DTY)| 支持embedded |Discussion|sig-embedded|[@fanglinxu](https://gitee.com/fanglinxu)|
|[I942Y9](https://gitee.com/openeuler/release-management/issues/I942Y9)|发布PilotGo及其插件特性新版本 |Discussion|sig-ops|[@yangzhao_kl](https://gitee.com/yangzhao_kl)|
|[I95KTM](https://gitee.com/openeuler/release-management/issues/I95KTM)|UKUI支持|Discussion|sig-UKUI|[@hua_yadong](https://gitee.com/hua_yadong)|
|[I98UXD](https://gitee.com/openeuler/release-management/issues/I98UXD)|支持ROS2-humble和ROS1-noetic基础版|Discussion|sig-ROS|[@davidhan008](https://gitee.com/davidhan008/)|
|[I985WB](https://gitee.com/openeuler/release-management/issues/I985WB) | 支持 OpenStack Wallaby、Antelope 多版本 | Discussion | sig-openstack | [@han-guangyu](https://gitee.com/han-guangyu) |
|[I97AX0](https://gitee.com/openeuler/release-management/issues/I97AX0)| 社区签名体系建立 |Discussion|sig-security-facility |[@HuaxinLuGitee](https://gitee.com/HuaxinLuGitee)|
|[I97D8Z](https://gitee.com/openeuler/release-management/issues/I97D8Z)| 智能问答在线服务 |Discussion| |[@fromhsc](https://gitee.com/fromhsc)|
|[I97IVO](https://gitee.com/openeuler/release-management/issues/I97IVO)| 支持国密特性 |Discussion|sig-security-facility |[@HuaxinLuGitee](https://gitee.com/HuaxinLuGitee)|
|[ I980D1](https://gitee.com/openeuler/release-management/issues/I980D1)| Gazelle支持UDP协议栈|Discussion|sig-high-performance-network |[@yanan-rock](https://gitee.com/yanan-rock)|
|[I8ZTS2](https://gitee.com/openeuler/release-management/issues/I8ZTS2)| 增加 AO.space 项目发布 |Discussion|sig-RaspberryPi  |[@jianminw](https://gitee.com/jianminw)|
|[I8XFUF](https://gitee.com/openeuler/release-management/issues/I8XFUF)| 合入GreatSQL 8.0.32-25及更高版本 |Discussion| |[@GreatSQL_admin](https://gitee.com/GreatSQL_admin)|
|[I8YUI2](https://gitee.com/openeuler/release-management/issues/I8YUI2)| 发布elastisearch-py 7.13.4版本 |Discussion| |[@lin-shoubao](https://gitee.com/lin-shoubao)|
|[I9B6RR](https://gitee.com/openeuler/release-management/issues/I9B6RR)| ZGCLab 发布内核安全增强补丁 | Discussion | sig-kernel | [@amjac](https://gitee.com/amjac) |

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
| 支持Lustre client软件包      | sig-SDS                                   |   sig-SDS                       |验证Lustre client 基础功能与可靠性 |
|openEuler docker容器支持sysMaster管理sshd服务| dev-utils                            |    dev-utils                     |验证sysmaster管理sshd服务，在docker容器中的基本功能|
|支持 OpenStack Wallaby、Train 多版本| sig-openstack                          |                      sig-openstack                 |验证openstack的wallaby和train版本软件包的安装卸载和功能|
|iSulad支持K8S 1.24 /1.25版本 | iSulad 　　　　　　　　　　　　　　　　　　| iSulad                       |   验证k8s的基础部署功能以及可靠性   |
|Rubik混部支持精细化资源QoS感知和控制 | sig-CloudNative　　　　　　　　　　　　　 | sig-CloudNative              |  验证rubik支持精细化资源感知和控制的基础功能                 |
|支持 sysmonitor 特性 | sig-ops　　　　　　　　　　　　　　　　　　　　　　　　　　|sig-ops                  |   验证sysmonitro继承需求的可靠性和基础功能                |
|Gazelle | sig-high-performance-network 　　　　　　　　　　　　　　　　　| sig-high-performance-network |  验证gaelle继承功能                   |
|安全配置规范框架设计及核心内容构建| sig-ops　　　　　　　　　　　　　　　　　　　　　　　　| sig-ops                      |   验证安全配置规范框架设计及核心内容构建        |
|gala-gopher新增性能火焰图、线程级性能Profiling特性 | sig-ops    　　　　　                  |  sig-ops    | 验证gala-gopher新增性能火焰图、线程级性能Profiling特性          |
|新增NestOS K8S部署方案 | SIG-K8s-Distro 　　　　　　　　　　　　　　　　　　　　　　　　　　| SIG-K8s-Distro              |验证在netos-installer安装，容器引擎等应用场景进行k8s部署|
|支持DPU直连聚合特性|sig-DPU|sig-DPU|验证DPU直连聚合特性基本功能，安全以及可靠性|
|支持系统热修复组件syscare|sig-ops|sig-ops|验证系统热修复组件syscare的功能，并发，长稳，以及安全|
|支持入侵检测框架secDetector|sig-security-facility|sig-security-facility|验证入侵检测框架secDetector基本功能，安全，可靠性等方面|

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试



# 3 版本概要测试结论

   openEuler 24.03 LTS 版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 1轮重点特性测试 + 2轮全量测试 + 1轮回归测试 + 1轮版本发布验收测试；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项；第2轮重点特性测试聚焦在新特性全量功能和继承特性自动化验证，另外开展安全CVE扫描及OS基础性能摸底和系统整体集成验证，旨在识别阻塞性问题；第3、4轮全量测试开展版本交付的所有特性和各类专项测试；第5轮回归测通过自动化测试重点覆盖问题单较多模块的覆盖和扩展测试，验证问题的修复和影响程度；第6轮版本发布验收测试是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。

   openEuler 24.03 LTS 版本共发现问题 642 个，有效问题 601 个，无效问题 40 个。遗留问题 1 个(详见遗留问题章节)。版本整体质量良好。



# 4 版本详细测试结论

openEuler 24.03 LTS 版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好；

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好；

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险；

4、专项测试包括性能专项、安全专项、兼容性测试、可靠性测试、资料测试；

5、对版本新增特性进行功能、可靠性等专项测试，新增特性均满足发布要求，测试较充分，质量良好；



## 4.1   软件范围变化分析结论

### 4.1.1 整体软件范围变化分析

经比较，openEuler-24.03-LTS对比openEuler-22.03-LTS-SP3存在4项版本号降级，但存在200项release号降级的软件，经定位系SP3 update版本同步升级时开发者处理流程不规范导致，此204项软件均已提单跟踪均于RC4完成闭环。
迭代测试过程中，全量测试环节openEuler-24.03-LTS RC3到RC4不存在软件版本降级，同时也不存在release降级。


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
| 42   | 支持Lustre client软件包      | <font color=green>█</font>    |继承已有测试能力，验证Lustre client 基础功能与可靠性 |
| 43   | openEuler docker容器支持sysMaster管理sshd服务| <font color=green>█</font>  |继承已有测试能力，验证sysmaster管理sshd服务，在docker容器中的基本功能|
| 44   | 支持 OpenStack Wallaby、Train 多版本| <font color=green>█</font>               |继承已有测试能力，验证openstack的wallaby和train版本软件包的安装卸载和功能|
| 45   | iSulad支持K8S 1.24 /1.25版本 |<font color=green>█</font>|   继承已有测试能力，验证k8s的基础部署功能以及可靠性   |
| 46   | Rubik混部支持精细化资源QoS感知和控制 | <font color=green>█</font> |  继承已有测试能力，验证rubik支持精细化资源感知和控制的基础功能                 |
| 47   | 支持 sysmonitor 特性 |<font color=green>█</font> |   继承已有测试能力，验证sysmonitro继承需求的可靠性和基础功能                |
| 48   | Gazelle |<font color=green>█</font>|  继承已有测试能力，验证gaelle继承功能                   |
| 49   | 安全配置规范框架设计及核心内容构建|<font color=green>█</font>|   继承已有测试能力，验证安全配置规范框架设计及核心内容构建        |
| 50   | gala-gopher新增性能火焰图、线程级性能Profiling特性 |<font color=green>█</font> | 继承已有测试能力，验证gala-gopher新增性能火焰图、线程级性能Profiling特性          |
| 51   | 新增NestOS K8S部署方案 |<font color=green>█</font> |继承已有测试能力，验证在netos-installer安装，容器引擎等应用场景进行k8s部署|
| 52   | 支持DPU直连聚合特性|<font color=green>█</font>|继承已有测试能力，验证DPU直连聚合特性基本功能，安全以及可靠性|
| 53   | 支持系统热修复组件syscare|<font color=green>█</font>|继承已有测试能力，验证系统热修复组件syscare的功能，并发，长稳，以及安全|
| 54   | 支持入侵检测框架secDetector|<font color=green>█</font>|继承已有测试能力，验证入侵检测框架secDetector基本功能，安全，可靠性等方面|

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.2.2   新需求评价

建议以表格的形式汇总新特性测试执行情况及遗留问题单情况的评估,给出特性质量评估结论。

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **质量评估**    | **备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | -------------- | -------------------------- | -------- |
|  1 | [发布kiran-desktop 2.6版本](待刷新) | 待刷新 |  |  | 待刷新 | |
|  2 | [iSulad支持CRI v1.29](待刷新) | 待刷新 |  |  | 待刷新 | |
|  3 | [iSulad支持CDI](待刷新) | 待刷新 |  |  | 待刷新 | |
|  4 | [iSulad支持NRI](待刷新) | 待刷新 |  |  | 待刷新 | |
|  5 | [iSulad支持cgroup v2](待刷新) | 待刷新 |  |  | 待刷新 | |
|  6 | [为 RISC-V 架构增加内核热补丁能力](待刷新) | 待刷新 |  |  | 待刷新 | |
|  7 | [为 RISC-V 架构引入 Penglai TEE 支持](待刷新) | 待刷新 |  |  | 待刷新 | |
|  8 | [wine5.5升级到wine9.0，不需要linux32依赖库情况下支持win32程序](待刷新) | 待刷新 |  |  | 待刷新 | |
|  9 | [支持树莓派](待刷新) | 待刷新 |  |  | 待刷新 | |
|  10 | [DDE支持](待刷新) | 待刷新 |  |  | 待刷新 | |
|  11 | [migration-tools增加图形化迁移openeuler功能](待刷新) | 待刷新 |  |  | 待刷新 | |
|  12 | [增加 utshell 项目发布](待刷新) | 待刷新 |  |  | 待刷新 | |
|  13 | [增加 utsudo 项目发布](待刷新) | 待刷新 |  |  | 待刷新 | |
|  14 | [发布Nestos-kubernetes-deployer](待刷新) | 待刷新 |  |  | 待刷新 | |
|  15 | [支持vCPU热插拔](待刷新) | 待刷新 |  |  | 待刷新 | |
|  16 | [A-Ops gala提供网络L4层TCP主流指标观测能力](待刷新) | 待刷新 |  |  | 待刷新 | |
|  17 | [A-Ops gala提供网络L7层RED指标观测能力](待刷新) | 待刷新 |  |  | 待刷新 | |
|  18 | [A-Ops gala提供应用粒度的I/O、CPU、MEM资源占用观测能力](待刷新) | 待刷新 |  |  | 待刷新 | |
|  19 | [A-Ops gala支持可观测行为的动态变更](待刷新) | 待刷新 |  |  | 待刷新 | |
|  20 | [内存潮汐调度：支持serverless容器热备份](待刷新) | 待刷新 |  |  | 待刷新 | |
|  21 | [LLVM版本升级到17.0.6](待刷新) | 待刷新 |  |  | 待刷新 | |
|  22 | [支持系统运维套件x-diagnosis](待刷新) | 待刷新 |  |  | 待刷新 | |
|  23 | [支持自动化热升级组件nvwa](待刷新) | 待刷新 |  |  | 待刷新 | |
|  24 | [支持DPU直连聚合特性](待刷新) | 待刷新 |  |  | 待刷新 | |
|  25 | [支持系统热修复组件syscare](待刷新) | 待刷新 |  |  | 待刷新 | |
|  26 | [支持内存分级扩展组件etmem](待刷新) | 待刷新 |  |  | 待刷新 | |
|  27 | [iSula容器镜像构建工具isula-build](待刷新) | 待刷新 |  |  | 待刷新 | |
|  28 | [一键式、轻量化、可配置集群部署工具eggo](待刷新) | 待刷新 |  |  | 待刷新 | |
|  29 | [支持容器引擎isulad](待刷新) | 待刷新 |  |  | 待刷新 | |
|  30 | [支持进程完整性防护特性](待刷新) | 待刷新 |  |  | 待刷新 | |
|  31 | [支持入侵检测框架secDetector](待刷新) | 待刷新 |  |  | 待刷新 | |
|  32 | [imageTailor支持树莓派镜像定制](待刷新) | 待刷新 |  |  | 待刷新 | |
|  33 | [支持secPaver特性](待刷新) | 待刷新 |  |  | 待刷新 | |
|  34 | [支持机密计算安全应用开发组件 secGear](待刷新) | 待刷新 |  |  | 待刷新 | |
|  35 | [系统性能自优化组件A-Tune](待刷新) | 待刷新 |  |  | 待刷新 | |
|  36 | [isocut镜像裁剪易用性提升 ](待刷新) | 待刷新 |  |  | 待刷新 | |
|  37 | [支持devmaster组件](待刷新) | 待刷新 |  |  | 待刷新 | |
|  38 | [支持TPCM特性](待刷新) | 待刷新 |  |  | 待刷新 | |
|  39 | [支持sysMaster组件](待刷新) | 待刷新 |  |  | 待刷新 | |
|  40 | [安全配置规范框架设计及核心内容构建](待刷新) | 待刷新 |  |  | 待刷新 | |
|  41 | [A-OPS智能运维工具](待刷新) | 待刷新 |  |  | 待刷新 | |
|  42 | [支持sysmonitor特性](待刷新) | 待刷新 |  |  | 待刷新 | |
|  43 | [kmesh-bwm高性能网络带宽管理](待刷新) | 待刷新 |  |  | 待刷新 | |
|  44 | [Gazelle用户态协议栈](待刷新) | 待刷新 |  |  | 待刷新 | |
|  45 | [混合部署rubik](待刷新) | 待刷新 |  |  | 待刷新 | |
|  46 | [isulad支持oci runtime并且切换默认runtime为runc](待刷新) | 待刷新 |  |  | 待刷新 | |
|  47 | [支持embedded](待刷新) | 待刷新 |  |  | 待刷新 | |
|  48 | [发布PilotGo及其插件特性新版本](待刷新) | 待刷新 |  |  | 待刷新 | |
|  49 | [UKUI支持](待刷新) | 待刷新 |  |  | 待刷新 | |
|  50 | [支持ROS2-humble和ROS1-noetic基础版](待刷新) | 待刷新 |  |  | 待刷新 | |
|  51 | [支持 OpenStack Wallaby、Antelope 多版本](待刷新) | 待刷新 |  |  | 待刷新 | |
|  52 | [社区签名体系建立](待刷新) | 待刷新 |  |  | 待刷新 | |
|  53 | [智能问答在线服务](待刷新) | 待刷新 |  |  | 待刷新 | |
|  54 | [支持国密特性](待刷新) | 待刷新 |  |  | 待刷新 | |
|  55 | [Gazelle支持UDP协议栈](待刷新) | 待刷新 |  |  | 待刷新 | |
|  56 | [增加 AO.space 项目发布](待刷新) | 待刷新 |  |  | 待刷新 | |
|  57 | [合入GreatSQL 8.0.32-25及更高版本](待刷新) | 待刷新 |  |  | 待刷新 | |
|  58 | [发布elastisearch-py 7.13.4版本](待刷新) | 待刷新 |  |  | 待刷新 | |
|  59 | [ZGCLab 发布内核安全增强补丁](待刷新) | 待刷新 |  |  | 待刷新 | |


<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好



## 4.3   兼容性测试结论

### 4.3.1   南向兼容性

南向兼容性继承已有的测试能力，按照release-manager团队的规划，版本发布后会进行持续的兼容性测试。通过兼容性测试套件完成(待刷新)张板卡的测试(该数目仅为测试数量，实际兼容性认证通过数量见社区[兼容性清单](https://www.openeuler.org/zh/compatibility/))

此版本的板卡兼容性适配测试，适配的板卡类型有（待刷新）种，在aarch64/x86_64架构上进行适配，主要使用社区硬件兼容性测试工具oec-hardware集成compass-ci进行自动化测试，适配完成后将在社区发布此版本的板卡兼容性清单。

下表列出版本集成验证中涉及的硬件板卡信息：

| **板卡类型** | **覆盖范围**    | **测试主体**      | **chipVendor** | **boardModel**     | **chipModel**      | **测试结果** |
| ------------ | --------------- | ----------------- | -------------- | ------------------ | ------------------ | ------------ |
| RAID | 适配7张  | sig-Compatibility | 待刷新 | | | |
| NIC  | 适配13张 | sig-Compatibility | 待刷新 | | | |
| FC   | 适配4张  | sig-Compatibility | 待刷新 | | | |
| GPU  | 适配3张  | sig-Compatibility | 待刷新 | | | |
| SSD  | 适配2张  | sig-Compatibility | 待刷新 | | | |
| IB   | 适配2张  | sig-Compatibility | 待刷新 | | | |



此版本的整机兼容性适配测试主要使用社区开源硬件兼容性测试工具oec-hardware，从整机的系统兼容性、CPU调频特性、kabi规范性、稳定性、硬件配置兼容性等方面进行适配，适配完成后将在社区发布此版本的整机兼容性清单。

整机适配兼容性测试交付清单如下：

| **整机厂商** | **整机型号**             | **CPU型号**   | **测试主体**      | **测试结果** |
| ------------ | ------------------------ | ------------- | ----------------- | ------------ |
| 华为 | 泰山200 | 鲲鹏920 | sig-Compatibility | PASS |
| 超聚变 | 2288H V5 | Intel cascade | sig-Compatibility |待刷新 |


整机兼容性清单以sig-Compatibility-Infra提供为主，社区各sig测试过程中使用的机器因未进行oec-hardware测试(进入社区兼容性清单质量要求)，故无法直接进行兼容性清单不在此描述。

### 4.3.3   虚拟机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 | 备注                                   |
| ---------- | ----------------------- | ------- | -------- | -------------------------------------- |
| openEuler 24.03 LTS  | Centos 6 | x86_64 | PASS |         |
| openEuler 24.03 LTS  | Centos 7 | aarch64 | PASS |         |
| openEuler 24.03 LTS  | Centos 7 | x86_64  | PASS |         |
| openEuler 24.03 LTS  | Centos 8 | aarch64 | PASS |         |
| openEuler 24.03 LTS  | Centos 8 | x86_64  | PASS |         |
| openEuler 24.03 LTS  | Windows Server 2016 | aarch64 | PASS |         |
| openEuler 24.03 LTS  | Windows Server 2016 | x86_64  | PASS |         |
| openEuler 24.03 LTS  | Windows Server 2019 | aarch64 | PASS |         |
| openEuler 24.03 LTS  | Windows Server 2019 | x86_64  | PASS |         |



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
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况； | RC3 7x24h(通过)<br />RC5 7*24h(进行中) |

### 4.4.3 性能测试

| **指标大项** | **指标小项**                                                 | **指标值**                        | **测试结论**     |
| ------------ | ------------------------------------------------------------ | --------------------------------- | ---------------- |
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考22.03 LTS SP3版本相应指标基线 | 比较前一版本持平 |



# 5   问题单统计

openEuler 24.03 LTS 版本共发现问题 642 个，有效问题 601 个，其中遗留问题 1 个。详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 备注        |
| --------------------------- | -------- | ------------ | ------------ | ------------ | -------------------------- |
| openEuler 24.03 LTS dailybuild | 19    | 18      | 1   | 0     | 每日构建   |
| openEuler 24.03 LTS alpha      | 290   | 281     | 9   |       | Alpha轮次   |
| openEuler 24.03 LTS RC1        | 147   | 134     | 13  |       | Beta轮次  |
| openEuler 24.03 LTS RC2        | 32    | 29      | 3   | 0      | 全量集成 |
| openEuler 24.03 LTS RC3        | 136   | 128     | 8   | 0      | 全量集成  |
| openEuler 24.03 LTS RC4        | 33    | 24      | 7   | 1      | 回归测试    |
| openEuler 24.03 LTS RC5        |  4    |  0      | 0   | 0      | 版本发布验收测试(回归测试) |


# 6 版本测试过程评估

#### 6.1 问题单分析

除去开发自验轮次，本次版本测试各迭代从RC1到RC6，除RC3因有新特性合入，问题单数量较多外，整体问题数量呈收敛趋势，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求，当前整体问题解决率达93.84%，闭环率达100%，版本整体质量良好，没有问题溢出的风险。其中第四轮迭代中共计发现33个问题，24个有效问题，18个问题需要在round5进行回归验证，剩6个问题待闭环；第五轮迭代中RC4修复的18个问题均完成验收，发现问题4个，需增加一轮rc6测试回归。

- 关键问题类型：软件版本/release号相较openEuler-22.03-LTS-SP3最新update较低

  此类问题约有205项，大多数因社区开发者在22.03-LTS-SP3分支进行升级后，将patch同步到22.03-LTS-Next分支后，未同步到master分支导致，为流程规范问题。

#### 6.2 OS集成测试迭代版本基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 24.03 LTS alpha | 冒烟测试         |                                |
| openEuler 24.03 LTS RC1   | 冒烟测试         |                                |
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
| openEuler 24.03 LTS RC2 | 冒烟测试         |                                |
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
| openEuler 24.03 LTS RC3 | 冒烟测试         |                                |
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
| openEuler 24.03 LTS RC4 | 冒烟测试         |                                |
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
| openEuler 24.03 LTS RC5     | 冒烟测试         |                                |
|                             | 包管理专项       | rpm包管理（增量变动部分）      |
|                             |                  | source包自编译（增量变动部分） |
|                             | 单包命令         | everything增量变动测试         |
|                             | 单包服务         | everything增量变动测试         |
| openEuler 24.03 LTS RC6     | 版本发布验收      | 版本发布验收                   |

# 6   附件

## 遗留问题列表

| 序号 | 问题单号    | 问题简述    | 问题级别 | 影响分析   | 规避措施       | 历史发现场景     |
| ---- | ------------------------------------------------------------ | ----------------------------------------------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | [I9NUDT](https://gitee.com/src-openeuler/gtk-doc/issues/I9NUDT?from=project-issue) | 【24.03-LTS-rc4】【x86/arm】gtk-doc源码包本地自编译失败，check阶段报错 | 次要     | 属于GNOME sig，编译过程测试用例执行失败，需解决，风险低，无人维护 | 规避check阶段可编译成功 | |



# 致谢
非常感谢以下sig在openEuler 24.03 LTS版本测试中做出的贡献,以下排名不分先后
infra-sig的各位贡献者
@wangchong1995924 @small_leek @yaolonggang @dongjie110 @cxl78320 @raomingbo @shdluan @wu_zhende @weijihui @liu-yinsi @duan_pj @wangLin0_0 @georgecao @zhongjun2 @gzbang @liuqi469227928 @wanghaosq @dakang_siji @liuyanglinun @Tom_zx @haml @qinsheng99_code
<br>
RM-sig的各位贡献者
@solarhu @chenyaqiang @paul-huang
<br>
QA-sig的各位贡献者
@zjl_long @ga_beng_cui @hanson-fang @erin_dan @丁娇 @wenjun @suhang @zhanglu626 @ssttkx @zhangpanting @wangxiaoya @hukun66 @MDS_ZHR @banzhuanxiaodoubi @mazenggang3 @clerk_duan @guojuanjuan @yanglijin @clay @oh_thats_great @wangting112 @lijiaming666 @liwencheng6769 @luluyuan @lutianxiong @chenshijuan3 @laputa0 @lcqtesting @xiuyuekuang @ganqx @woqidaideshi @yjt-dli @disnight @chenshijuan3 @wangpeng_uniontech @fu-shanqing @saarloos
<br>
以及所有参与24.03 LTS但未统计到的所有开发者
(如有遗漏可随时联系 @disnight email:fjc837005411@outlook.com 反馈)
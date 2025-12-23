![openEuler ico](../../images/openEuler.png)

版权所有 © 2025  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2025/12/8 | 1.0.0    | 初稿 | ga_beng_cui |
| 2025/12/23 | 1.0.1 | Add RISC-V | jean9823 |
| 2025/12/23 | 1.0.2 | Add Loongarch | tianyanhui |




摘要：

文本主要描述openEuler 24.03 LTS SP3版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 24.03 LTS SP3版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 24.03 LTS SP3版本是基于6.6内核的增强扩展版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 24.03 LTS-Next分支拉出，发布范围相较24.03 LTS版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP3/release-change.yaml)
2.  修复bug和cve


## 2.1 版本测试计划
openEuler 24.03 LTS SP3版本按照社区release-manager团队的计划，共规划9轮测试，详细的版本信息和测试时间如下表：

| Stage Name                  | Deadline for PR | Begin Time | End Time   | Days |     Notes                                        |
|-----------------------------|-----------------|------------|------------|------|-------------------------------------------       |
| Collect key features        | -               | 2025/9/1   | 2025/10/30 | 60   | 版本需求收集                                      |
| Change Review 1             | -               | 2025/10/1  | 2025/11/6  | 37   | Review 软件包变更（升级）SP版本尽可能保持版本不变   |
| Herited features            | -               | 2025/10/1  | 2025/10/29 | 29   | 继承特性合入（Branch前完成合入）                   |
| Develop                     | -               | 2025/10/1  | 2025/12/4  | 65   | 新特性开发，合入24.03 LTS Next                    |
| Kernel freezing             | -               | 2025/10/1  | 2025/11/5  | 36   | 内核冻结，KABI稳定                                |
| Next Build                  | -               | 2025/10/1  | 2025/10/16 | 16   | 启动新版本构建，新开发特性合入                      |
| Branch                      | -               | 2025/9/29  | 2025/10/14 | 16   | 24.03 LTS Next 拉取 24.03 LTS SP3 分支            |
| Alpha                       |                 | 2025/10/17 | 2025/10/23 | 7    | Alpha版本发布，24.03 LTS SP3开发者测试             |
| Test round 1                | 2025/10/22      | 2025/10/24 | 2025/10/30 | 7    | 24.03 LTS SP3模块测试                             |
| Test round 2                | 2025/10/29      | 2025/10/31 | 2025/11/6  | 7    | 24.03 LTS SP3 模块测试                            |
| Change Review 2             |                 | 2025/11/3  | 2025/11/6  | 4    | 发起软件包淘汰评审                                 |
| Test round 3 (Beta Version) | 2025/11/5       | 2025/11/7  | 2025/11/13 | 7    | 24.03 LTS SP3 Beta版本发布，24.03 LTS SP3 模块测试 |
| Test round 4                | 2025/11/12      | 2025/11/14 | 2025/11/20 | 7    | 24.03 LTS SP3 模块测试                            |
| Test round 5                | 2025/11/19      | 2025/11/21 | 2025/11/27 | 7    | 24.03 LTS SP3 模块测试                            |
| Test round 6                | 2025/11/26      | 2025/11/28 | 2025/12/4  | 7    | 24.03 LTS SP3 模块测试                            |
| Change Review 3             |                 | 2025/12/2  | 2025/12/4  | 3    | 确定软件包发布范围                                 |
| Test round 7                | 2025/12/3       | 2025/12/5  | 2025/12/11 | 7    | 全量验证(全量SIT)                                 |
| Test round 8                | 2025/12/10      | 2025/12/12 | 2025/12/18 | 7    | 回归测试，分支冻结，只允许bug fix                  |
| Test round 9                | 2025/12/17      | 2025/12/19 | 2025/12/25 | 7    | 回归测试                                          |
| Release Review              | -               | 2025/12/25 | 2025/12/26 | 2    | 版本发布决策/ Go or No Go                         |
| Release preparation         | -               | 2025/12/20 | 2025/12/29 | 10   | 发布前准备阶段，发布件系统梳理                      |
| Release                     | -               | 2025/12/30 | 2025/12/31 | 2    | 社区Release评审通过正式发布                        |  



## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号               | 硬件配置信息                             | 重点场景       |
| ---------------------- | ---------------------------------------- | -------------- |
| TaiShan 200 2280均衡型 | Kunpeng 920(支持1.70以上的bios版本)        | OS集成测试     |
| RH2288H V3            | Intel(R) Xeon(R) Gold 5118 CPU @ 2.30GHz | OS集成测试     |
| LS2C5LC2 V2.1           | 龙芯3C5000/3C5000L +7A2000  | OS集成测试   |    
| 3C/D6000            | 龙芯3C/D6000+7A2000 | OS集成测试   |    


## 2.3 需求清单

openEuler 24.03 LTS SP3版本交付需求列表如下，详情见[openEuler-24.03-LTS-SP3 release plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP3/release-plan.md#)：

|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|1|[isa-l库：CRC算法在RISC-V架构的优化](https://gitee.com/openeuler/release-management/issues/ICW20J?from=project-issue)|Accepted|dev-utils|@qtliu666|EPOL|isa-l|
|2|[snappy库：FindMatchLength支持RISC-V架构的优化](https://gitee.com/openeuler/release-management/issues/ICW4C5?from=project-issue)|Accepted|Base-service| @QingtaoLiu |ISO|snappy|
|3|[lz4库：提高riscv架构的压缩速度](https://gitee.com/openeuler/release-management/issues/ICWGMF?from=project-issue)|Testing|Base-service|@QingtaoLiu|EPOL|ISO|
|4|[openssl库：RISC-V架构的系列优化-SM2优化](https://gitee.com/openeuler/release-management/issues/ICW5SK?from=project-issue)|Testing|dev-utils|@QingtaoLiu|ISO|openssl|
|5|[virtcca: 支持virtCCA机密虚机热迁移](https://gitee.com/openeuler/release-management/issues/ID1Y44?from=project-issue)|Discussion|kernel,virt|@hjx_gitff|ISO|kernel,qemu|
|6|[golang: Backport RVA23 支持](https://gitee.com/openeuler/release-management/issues/ID2QHV?from=project-issue)|Testing|sig-golang|@HeliC829|OS|golang|
|7|[TSB-agent: 支持可信计算虚拟化vTPCM](https://gitee.com/openeuler/release-management/issues/ID3BZ8?from=project-issue)|Accepted|sig-security-facility|@cx22757|EPOL| virtrust-sh,libvirtrust,libvirtrustd |
|8|[openssl：Backport 主线 RISC-V 架构的 SHA-2 汇编优化](https://gitee.com/openeuler/release-management/issues/ID3WE6?from=project-issue)|Testing|dev-utils|@HeliC829|ISO|openssl|
|9|[URMA：URMA支持UB基础通信能力](https://gitee.com/openeuler/release-management/issues/ID3WJX?from=project-issue)|Developing|sig-UnifiedBus|@qianguoxin|ISO|liburma,libubagg,urma-tools,uvs|
|10|[UMS：UMS支持socket接口通信](https://gitee.com/openeuler/release-management/issues/ID3WK9?from=project-issue)|Developing|sig-UnifiedBus|@jillwu|ISO|ums,ums-tools|
|11|[DLock：支持基于UB的分布式锁](https://gitee.com/openeuler/release-management/issues/ID3WJY?from=project-issue)|Developing|sig-UnifiedBus|@jillwu|ISO|libdlock|
|12|[URPC：URPC支持UB](https://gitee.com/openeuler/release-management/issues/ID3WJO?from=project-issue)|Developing|sig-UnifiedBus|@nemeiju|ISO|liburpc|
|13|[UBTurbo: HAM支持确定性热迁移能力](https://gitee.com/openeuler/release-management/issues/ID42J5?from=project-issue)|Developing|sig-UnifiedBus|@leeCii|ISO|libham|
|14|[UBTurbo： SMAP支持内存冷热扫描和迁移能力](https://gitee.com/openeuler/release-management/issues/ID40VW?from=project-issue)|Developing|sig-UnifiedBus|@leeCii|ISO|libsmap|
|15|[UBTurbo：RMRS Agent支持内存迁移决策与执行](https://gitee.com/openeuler/release-management/issues/ID42GJ?from=project-issue)|Developing|sig-UnifiedBus|@meng_zhaohui|ISO|librmrs_ub_turbo_plugin|
|16|[UB Turbo： UBTurbo提供基础框架(配置读取、插件加载、日志管理、IPC通信等)能力](https://gitee.com/openeuler/release-management/issues/ID42G7?from=project-issue)|Developing|sig-UnifiedBus|@meng_zhaohui|ISO|ub_turbo,libubturbo_client|
|17|[UBS Engine: UBS Engine支持UB池化资源管理能力](https://gitee.com/openeuler/release-management/issues/ID4155?from=project-issue)|Developing|sig-UB-ServiceCore|@xuchenfengcleancode|ISO|libubse_client,ubse,ubsectl|
|18|[UBS Comm: HCOM支持UB通信能力](https://gitee.com/openeuler/release-management/issues/ID40GU?from=project-issue)|Developing|sig-UB-ServiceCore|@fanzhaonan|ISO|libhcom|
|19|[OBMM: 提供跨节点内存访问与一致性控制能力](https://gitee.com/openeuler/release-management/issues/ID45O2?from=project-issue)|Developing|sig-Long|@kazero00|ISO|kernel,libobmm|
|20|[sysSentry：支持UB故障劫持能力及超节点故障上报能力](https://gitee.com/openeuler/release-management/issues/ID45WQ?from=project-issue)|Developing|Base-service|@luckky7|ISO|kernel,sysSentry|
|21|[qemu：支持基于urma通道的内存热迁移](https://gitee.com/openeuler/release-management/issues/ID49H5)|Developing|Virt|@eillon|ISO|qemu,libvirt|
|22|[UBNative：灵衢虚拟化基础能力支持UBNative直通虚拟化](https://gitee.com/openeuler/release-management/issues/ID49MB)|Developing|Virt|@caojinhuahw|ISO|qemu,libvirt|
|23|[memlink：灵衢虚拟化基础能力支持memlink大规格虚拟机、内存回收](https://gitee.com/openeuler/release-management/issues/ID49LF)|Developing|sig-long|@leizongkun|ISO|memlink|
|24|[utpam：基于Rust开发的身份认证模块](https://gitee.com/openeuler/release-management/issues/ID4CRS)|Developing|sig-memsafety|@trackers-love|EPOL|utpam|
|25|[UB lib & tool：灵衢基础工具和库](https://gitee.com/openeuler/release-management/issues/ID4RQW)|Developing|sig-UnifiedBus|@yunshenglin|ISO|cdma,ummu,ubutils,ubctl|
|26|[openssl：Backport 主线 RISC-V 架构的 MD5 汇编优化](https://gitee.com/openeuler/release-management/issues/ID5TUY?from=project-issue)|Testing|dev-utils|@HeliC829|ISO|openssl|
|27|[支持树莓派](https://gitee.com/openeuler/release-management/issues/ID6218)|Developing|sig-SBC|@woqidaideshi|EPOL|raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom,raspberrypi-utils|
|28|[secScanner:操作系统安全加固组件](https://gitee.com/openeuler/release-management/issues/ID64P8?from=project-issue)|Testing|sig-security_facility|@wangweize_yewu|EPOL|secScanner|
|29|[VMAnalyzer:轻量级虚拟化性能监控组件](https://gitee.com/openeuler/release-management/issues/ID7RXR?from=project-issue)|Developing|sig-ops|@Xu Zheng|EPOL|VMAnalyzer|
|30|[慢IO/慢盘检测能力增强](https://gitee.com/openeuler/release-management/issues/ID96TK?from=project-issue) | Developing | sig-AccLib | [@guchenghua1992](https://gitee.com/guchenghua1992/) | Everything | krun |
|31|[CompassCI支持功能和性能自动化测试以及性能变化补丁识别定位](https://gitee.com/openeuler/release-management/issues/ID96UN?from=project-issue)  | Developing | sig-cicd | [@duan_pj](https://gitee.com/duan_pj/) | Everything | compass-ci |
|32|[oeDeploy支持AI Agent开发场景工具栈，支持CANN软件环境与昇腾驱动的快速部署](https://gitee.com/openeuler/release-management/issues/ID96VT?from=project-issue) | Developing | sig-ops | [@dingjiahuichina](https://gitee.com/dingjiahuichina/) | Everything | oeDeploy |
|33|[DevStation支持MCP开发工具链和增强AI助手Agent创建，提升开发者体验，使能CVE漏洞修复提效](https://gitee.com/openeuler/release-management/issues/ID96W0?from=project-issue)  | Developing | sig-intelligence | [@duan_pj](https://gitee.com/duan_pj/) | Everything | mcp-servers |
|34|[引入IOInflight QoS控制器，降低混部场景在线业务干扰率](https://gitee.com/openeuler/release-management/issues/ID96XG?from=project-issue)  | Developing | sig-kernel | [@yang-erkun](https://gitee.com/yang-erkun/) | BaseOS | kernel |
|35|[SPDK支持vq均衡多reactor功能，降低虚拟化开销](https://gitee.com/openeuler/release-management/issues/ID9CXA?from=project-issue) | Developing | sig-Storage | [@ShenYage](https://gitee.com/ShenYage/) | Everything | spdk |
|36|[openEuler Intelligence智能平台支持智能诊断、智能调优和数据治理流水线开放能力](https://gitee.com/openeuler/release-management/issues/ID9D2R?from=project-issue) | Developing | sig-intelligence | [@zxstty](https://gitee.com/zxstty/) | Everything | euler-copilot-rag, euler-copilot-witchaind-web|
|37|[sysHAX 支持支持7B 中小稠密模型推理算力填充](https://gitee.com/openeuler/release-management/issues/ID9DCD?from=project-issue)  | Developing | sig-intelligence | [@xiaocy1997](https://gitee.com/xiaocy1997/) | Everything | sysHAX |
|38|[ModelFS提升推理服务启动速度](https://gitee.com/openeuler/release-management/issues/ID9DEY?from=project-issue)  | Developing | sig-kernel | [@yubo-liu](https://gitee.com/yubo-liu/) | BaseOS | Kernel |
|39|[GMem异构融合内存提升异构资源利用率](https://gitee.com/openeuler/release-management/issues/ID9DH3?from=project-issue)  | Developing | sig-kernel | [@ni-cunshu](https://gitee.com/ni-cunshu/) | BaseOS | Kernel |
|40|[毕昇JDK21支持元数据压缩优化降低堆数据内存使用](https://gitee.com/openeuler/release-management/issues/ID9DLK?from=project-issue)  | Developing | Compiler SIG | [@xiejf2020](https://gitee.com/xiejf2020/) |  | openjdk-21 |
|41|[TF原生Embedding算子图优化提高推理性能](https://gitee.com/openeuler/release-management/issues/ID9DND?from=project-issue)  | Developing | Compiler SIG | [@li-yancheng](https://gitee.com/li-yancheng/) |  | ANNC |
|42|[毕昇JDK21版本 G1、PS支持堆内存扩缩容](https://gitee.com/openeuler/release-management/issues/ID9DPA?from=project-issue)  | Developing | Compiler SIG | [@xiejf2020](https://gitee.com/xiejf2020/) |  | openjdk-21 |
|43|[LLVM编译器提升数据库（MySQL）、压缩解压缩（lz4/zstd/xz）等性能](https://gitee.com/openeuler/release-management/issues/ID9DQQ?from=project-issue)  | Developing | Compiler SIG | [@eastb233](https://gitee.com/eastb233/) |  | llvm-project,llvm |
|44|[毕昇JDK21支持JIT warmup， 提升Java启动性能](https://gitee.com/openeuler/release-management/issues/ID9DRP?from=project-issue)  | Developing | Compiler SIG | [@xiejf2020](https://gitee.com/xiejf2020/) |  | openjdk-21 |
|45|[RISC-V 架构面向 RVA23 指令集扩展规范推出正式版本](https://gitee.com/openeuler/release-management/issues/IDBW00?from=project-issue)  | Developing | RISC-V SIG | [@jchzhou](https://gitee.com/jchzhou) | ISO | ISO |


## 2.4 测试活动分工
 本次版本继承测试活动分工如下：

| 序号   | 需求 | 开发主体 | 测试主体  | 测试分层策略 |
| :--- | :--- | :--- | :--- | :--- |
|1| 支持UKUI桌面    | sig-UKUI  | sig-UKUI | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能          |
|2| 支持DDE桌面                                           | sig-DDE | sig-DDE  | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标 |
|3| 支持Kiran桌面     | sig-KIRAN-DESKTOP  | sig-KIRAN-DESKTOP  | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能         |
|4| 安装部署                                              | sig-OS-Builder| sig-QA  | 验证覆盖裸机/虚机场景下，通过光盘/PXE等安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署 |
|5|内核                                                  | Kernel | Kernel | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内 |
|6|容器(isula/docker/安全容器/系统容器/镜像)             | sig-CloudNative | sig-CloudNative| 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证 |
|7| 虚拟化                                                | Virt| Virt  | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能       |
|8|系统性能自优化组件A-Tune                                            | A-Tune  | A-Tune | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注 |
|9| 支持secPaver                                           | sig-security-facility | sig-QA  | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性 |
|10|支持secGear                                           | sig-confidential-computing   | sig-QA | 关注secGear特性的功能完整性                                  |
|12|支持kubeOS                                            | sig-CloudNative  | sig-QA | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级 |
|13| 支持etmem                               | Storage   | sig-QA  | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力 |
|14| 支持用户态协议栈gazelle                               | sig-high-performance-network | sig-QA | 关注gazelle高性能用户态协议栈功能                            |
|15| 支持国密算法                                          | sig-security-facility| sig-QA  | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。 |
|16| 支持pod带宽管理oncn-bwm                               | sig-high-performance-network | sig-QAk | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试 |
|17| iSulad                                 | sig-iSulad   | sig-QA  |  覆盖继承功能，重点验证isulad长稳场景                 |
|18| 支持A-OPS                                 | sig-iSulad   | sig-QA  | 重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景                 |
|19| 支持系统运维套件x-diagnosis                           | sig-ops | sig-QA | 覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能  |
|20| 支持自动化热升级组件nvwa                              | sig-ops  | sig-QA    | 覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等 |
|21| 支持DPU直连聚合特性dpu-utilities                                   | sig-DPU | sig-DPU  | 验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源 |
|22| 支持系统热修复组件syscare                             | sig-ops | sig-QA | 验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力      |
|23| iSula容器镜像构建工具isula-build                      | sig-iSulad   | sig-QA  | 验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能 |
|24| 支持进程完整性防护特性DIM                                | sig-security-facility  | sig-security-facility  | 验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力 |
|25| 支持入侵检测框架secDetector                           | sig-security-facility | sig-security-facility  | 验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等 |
|26| isocut镜像裁剪                              | sig-OS-Builder| sig-OS-Builder | 验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包 |
|27| 支持devmaster组件                                     | sig-dev-utils  | sig-dev-utils  | 验证devmaster的安装部署、进程配置、客户端工具等使用场景      |
|28| 支持TPCM特性                                          | sig-Base-service | sig-Base-service   | 验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等 |
|29| 支持sysMaster组件                                     | sig-dev-utils   | sig-dev-utils    | 验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景 |
|30| 支持sysmonitor特性                                    | sig-ops  | sig-QA   | 验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景 |
|31| 支持容器场景在离线混合部署rubik                       | sig-CloudNative | sig-CloudNative | 结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试 |
|32| 支持IMA|   sig-security-facility  | sig-QA | 验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式 |
|33| 支持IMA virtCCA |  sig-security-facility  |  sig-QA  | 验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等  |
|34| 安全启动 |  sig-security-facility  |  sig-QA  | 验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等； |
|35| Kmesh |  sig-ebpf  | sig-QA   | 验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等 |
|36| openEuler安全配置规范框架设计及核心内容构建 |  sig-security-facility  |  sig-QA  | 验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性 |
|37| oemaker |  sig-OS-Builder  |  sig-QA  | 重点验证oemaker在构建工程中功能正常  |
|38| openssl |  sig-security-facility  |  sig-QA  | 验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上 |
|40| 编译器(gcc/jdk)                                       | Compiler  | sig-QA  | 基于开源测试套对gcc和jdk相关功能进行验证                     |
|41| 支持HA软件                                            | sig-Ha | sig-Ha  | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标 |
|42| 支持KubeSphere                                        | sig-K8sDistro | sig-K8sDistro | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力   |
|44| 支持智能运维助手                                     | sig-ops| sig-QA   | 关注智能定位（异常检测、故障诊断）功能、可靠性               |
|45| 支持k3s                                               | sig-K8sDistro| sig-K8sDistro | 验证k3s软件的部署测试过程                                    |
|46| migration-tools增加图形化迁移openeuler功能            | sig-Migration| sig-Migration  | 验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统 |
|47| 发布Nestos-kubernetes-deployer                        | sig-K8sDistro  | sig-K8sDistro  | 验证在NestOS上部署，升级和维护kubernetes集群功能正常         |    
|48| 支持NestOS                                            | sig-CloudNative | sig-CloudNative | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证 |
|49| 发布PilotGo及其插件特性新版本                         | sig-ops  | sig-QA  | 验证PilotGo支持 topo 图的展示和智能调优能力                  |
|50| 社区签名体系建立                                      | sig-security-facility  | sig-security-facility        | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性 |
|51| 智能问答在线服务                                      | sig-A-Tune  | sig-QA   | 验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力 |
|52| 支持GreatSQL                               | sig-DB    | sig-DB    | 验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库 |
|53| ZGCLab 发布内核安全增强补丁                           | sig-kernel   | sig-kernel   | 针对 OLK-6.6提交的内核安全增强补丁，重点关注HAOC特性相关的内核功能、性能测试 |
|54| 支持RISC-V                                            | sig-RISC-V | sig-RISC-V  | 验证openEuler版本在RISV-V处理器上的可安装和可使用性          |
|55|为 RISC-V 架构引入 Penglai TEE 支持                   | sig-RISC-V | sig-RISC-V | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等 |
|56| LLVM平行宇宙计划 RISC-V Preview 版本 | sig-RISC-V | sig-RISC-V |验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动 |
|57| Add compatibility patches for Zhaoxin processors    |  sig-kernel |  sig-kernel |  验证集成了Zhaoxin OLK-6.6补丁的内核镜像系统正常运行以及对应补丁的功能测试   |
|58| virtCCA机密虚机特性合入       | sig-kernel/sig-virt  | sig-kernel/sig-virt  |   继承已有测试能力，重点验证机密虚机的基本功能、安全、兼容性以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试  |
|59| 增加YouQu自动化测试平台支持    | sig-QA  | sig-QA  |  验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试    |   
|60| 增加 utsudo 支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utsudo基础命令使用正常   |   
|61| 增加 utshell支持              | sig-memsafety  | sig-memsafety  |  继承已有测试能力，验证utshell基础命令使用正常   |
|62| 海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核）    |  sig-kernel | sig-kernel  |  重点验证CSV3虚拟机的不同启动方式，覆盖功能、稳定性、兼容性测试  |
|63| 集成openGauss 6.0.0 LTS企业版       | sig=DB  | sig=DB  |  重点验证openGauss 6.0.0数据库系统工具、SQL功能、数据库升级、兼容B库模块等功能测试   |
|64| LLVM多版本实现                      | sig-Compiler  |  sig-Compiler |  继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。   |
|65| 新增密码套件openHiTLS               |  sig-security-facility |  sig-security-facility |  继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试    |
|68| 支持oeaware                |  sig-A-Tune | sig-QA  |  继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容  |
|70| AI集群慢节点快速发现 Add Fail-slow Detection      | sig-desktop   |  sig-desktop |  继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度   |
|71| RPM国密签名支持                             | sig-security-facility  | sig-security-facility  |  重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容   |
|72| 鲲鹏KAE加速器驱动安装包合入                  | sig-kernel  | sig-kernel  |  继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩   |
|73| Add Intel QAT packages support    | sig-Intel-Arch  | sig-Intel-Arch  |  继承已有测试能力，重点验证intel qat相关软件包的功能和性能    |
|74| Add OpenVINO packages native support  |  sig-Intel-Arch/sig-intelligence |  sig-Intel-Arch/sig-intelligence |  继承已有测试能力，验证OpenVINO框架上sample code编译运行成功和OpenVINO的推理功能   |
|75| Add oneAPI low level native support   | sig-Intel-Arch/sig-intelligenc  |  sig-Intel-Arch/sig-intelligenc |  继承已有测试能力，重点验证oneAPI对于sample code的编译运行，大模型基于oneAPI加速框架的正确支持以及相应软件包的功能测试   |
|76| 版本引入ACPO包    | sig-Compiler  |  sig-Compiler |  继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容   |
|77| 内核TCP/IP协议栈支持CAQM拥塞     |  sig-kernel |  sig-kernel |  继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能   |
|78| openEuler安全配置基线检测工具 |SIG-security-facility|SIG-security-facility|使用Linux系统安全检查工具secureguardian，通过执行一系列的安全检查脚本, 查看生成的安全报告，评估系统的安全性是否存在风险 |
|79| 支持树莓派 | SIG-SBC | SIG-SBC  | 继承已有测试能力，对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性等测试 |
|80| OVMF_CODE.fd支持CSV1/2/3开箱即用 |sig-edk2 |sig-edk2| 继承已有测试能力，主要包括功能测试，稳定性测试，压力测试| 
|81|OVMF.fd支持CSV1/2/3开箱即用 |sig-edk2 |sig-edk2| 继承已有测试能力，主要包括功能测试,稳定性测试|
|82|新的psp/ccp device id支持 |sig-kernel/sig-qemu |sig-kernel/sig-qemu | 继承已有测试能力，主要覆盖海光可信功能验证|
|83|可信功能内核驱动剥离sev依赖 | sig-kernel|sig-kernel|继承已有测试能力，主要覆盖海光可信功能验证 |
|84| vTKM 性能优化| sig-kernel|sig-kernel|继承已有测试能力，主要覆盖普通虚拟机和CSV虚拟机下的TKM功能验证，性能测试验证,内部密钥的SM2签名、SM2解密、SM4。 |
|85| 需要合入海光分支patch和memset的nt patch| sig-kernel|sig-kernel| 继承已有测试能力，主要覆盖功能测试和性能测试 |
|87| 基于通信算子的低开销高精度慢节点检测 |sig-ops|sig-ops| 继承已有测试能力，覆盖功能、长稳、资料测试，功能覆盖模型数据timeline图转化，数据采集开销验证，分组验证，慢节点分析验证|
|88| DevStation开发流程智能化增强| sig-intelligence |sig-intelligence |继承已有测试能力，测试mcp服务的下载、配置及应用，主要覆盖功能测试、性能测试和可靠性测试 |
|89| 支持超大虚机规格 |virt-sig|virt-sig| 继承已有测试能力，主要覆盖功能测试 |
|90| openEuler Copilot 支持多维度（时间）过滤分析和分权分域，推理高准确率开箱即用 |sig-intelligence |sig-intelligence | 继承已有测试能力，主要覆盖MCP server框架集成，数据集评估流水线，向量数据库切换openGauss，企业数据多用户管理空间等功能测试 |
|92| FUSE passthrough支持| sig-kernel|sig-kernel|继承已有测试能力，主要覆盖功能测试和性能测试 |
|93| oeDeploy工具易用性提升，部署能力增强|sig-ops |sig-ops  | 继承已有测试能力，主要覆盖oedp插件一键部署，MCP服务调用，自定义插件开发、多master的k8s集群部署等工程以及可靠性测试 |
|94| 基于eBPF等技术实现AI作业进程Stack Mergeing，支持典型内存故障定位|sig-ops |sig-ops | 继承已有测试能力，主要覆盖功能测试，功能覆盖模型内存timeline图转化、内存堆栈转化，可以在网页上正确显示火焰图和时间线 |
|95| 虚拟化场景支持vKAE直通设备热迁移 | virt-sig |virt-sig |继承已有测试能力，覆盖功能、性能、资料测试，功能覆盖vKAE直通虚拟机热迁移验证 |
|96| secGear支持机密虚机基于UEFI启动方式的报告生成及验证 | sig-confidential-computing| sig-confidential-computing| 继承已有测试能力，覆盖功能测试和可靠性测试 |
|97| 支持可信计算远程证明服务组件 | sig-security-facility|sig-security-facility|继承已有测试能力，涉及基础冒烟测试和ltp测试|
|98| 支持Kuasar机密容器镜像加解密| sig-confidential-computing/sig-Cloudnative|sig-confidential-computing/sig-Cloudnative|继承已有测试能力，覆盖功能、可靠性、资料测试。|
|99| 支持众核高密容器级资源隔离技术 |sig-kernel|sig-kernel| 继承已有测试能力，测试众核调度对计算密集型与IO密集型业务服务QPS的影响，在部署密度提升超过10%的情况下业务性能良好无劣化。 | 

本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试


# 3 版本概要测试结论

   openEuler 24.03 LTS SP3版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 5轮继承特性和新增特性合入测试 + 2轮全量测试 + 2轮回归测试（版本发布验收测试）；第1轮主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项， 前两轮主要覆盖冒烟测试、安装部署、单包等OS测试项; 第3轮新需求开始批量合入，重点聚焦在已合入的新需求测试和继承特性验证; 第6、7轮全量测试开展版本交付的所有特性和各类专项测试；第8、9轮重点覆盖问题单较多模块的覆盖和扩展测试以及验证问题的修复；最后一轮还包括版本发布验收测试，是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。


   openEuler 24.03 LTS SP3版本共发现问题 322 个，有效问题 314 个，无效问题 8 个，遗留问题 0 个，风险可控，版本整体质量良好。





# 4 版本详细测试结论

openEuler 24.03 LTS SP3版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好

3、系统集成测试覆盖系统配置、文件系统、服务和用户管理及网络、存储等多个方面，系统整体集成验证无风险

4、专项测试包括安全专项、性能测试、可靠性测试、兼容性性测试、资料测试

5、对版本新增特性进行测试，新增特性均满足发布要求，测试较充分，质量良好


## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号 | 组件/特性名称                     | **aarch64/x86_64质量评估**  |**risc-v rva20质量评估**  |**risc-v rva23质量评估**  |  **loongarch质量评估**  |备注         |                                                |
| ---- | ----------------------- | :-------: | :--------: | :--------:  | ------------------------------------------------------------ | :----------------------------------------------------------: | :----------------------------------------------------------: |
| 1 | 支持DDE桌面  | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font>| <font color=green>█</font>|      继承已有测试能力，关注DDE桌面系统的安装和基本功能    |
| 2 | 支持UKUI桌面  | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font>     | UKUI在openEuler 24.03-LTS-SP3测试镜像，共经过三轮测试，执行94个测试项，整体核心功能稳定正常。  |
| 3 | 支持Kiran桌面  | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font>|   共计执行20个用例，主要覆盖功能测试，满足了功能的通用指标要求，共发现1个有效缺陷，整体质量良好，测试通过。   |
| 4 | 安装部署  | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> |覆盖裸机/虚机场景下，通过光盘/USB/PXE三种安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署，共执行55个测试用例，无问题，整体质量良好   |
| 5 | 内核  | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font>|本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内   |
| 6 | 容器(isula/docker/安全容器/系统容器/镜像) | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font>|本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证   |
| 7 | 虚拟化 | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> |  <font color=green>█</font> | 继承已有测试能力，重点关注回合新特性后，新版本上虚拟化相关组件的基本功能   |
| 8 | 支持A-Tune  | <font color=green>█</font> | NA | NA | NA   |针对A-Tune特性及功能进行测试，共计执行10个测试用例，主要包含单节点全量功能测试功能测试、应用配置测试和集群调优测试，无skip用例，无失败用例，整体质量良好。 |
| 9 | 支持secPaver  | <font color=green>█</font> | NA | NA |   <font color=green>█</font>|secpaver特性，共计执行41个用例，其中继承用例36个，主要覆盖了功能测试、接口测试、异常配置测试、资料测试，遗留风险小，整体质量良好   |
| 10 | 支持secGear  | <font color=green>█</font> | NA | NA |  NA  | secGear特性，共计执行150个用例，新增19个，主要覆盖了接口测试、功能测试、组合场景测试、可靠性测试、压力和稳定性测试。   |
| 12 | 支持kubeOS | <font color=green>█</font> | NA | NA |NA |KubeOS特性，共计执行6个用例，主要覆盖了功能测试、异常配置测试、性能测试，遗留风险小，整体质量良好 |
| 13 | 支持etmem内存分级扩展  | <font color=green>█</font> | NA | NA |NA |内存分级扩展特性，共计执行90个用例，覆盖范围包括特性的功能、可靠性，安全和性能。上述功能在一定的约束限制下都能发挥其特性能力。|
| 14 | 支持用户态协议栈gazelle | <font color=green>█</font> | <font color=green>█</font>  | <font color=green>█</font> | NA |gazelle特性，共计执行113个用例，主要覆盖了功能测试、接口测试、性能测试、可靠性测试。重点关注udp单播和组播场景打流测试及长稳测试。|
| 15 | 支持国密算法  | <font color=green>█</font> | <font color=blue><font color=green>█</font></font>  | <font color=green>█</font> |NA  |共计执行17个用例，主要覆盖了接口测试、功能测试，安全测试，发现问题已解决，回归通过，无遗留风险，整体质量良好。   |
| 16 | 支持pod带宽管理oncn-bwm  | <font color=green>█</font> | NA | NA |  <font color=green>█</font> |pod带宽管理，共计执行46个用例，主要覆盖了：命令行接口测试，带宽管理功能场景测试，命令行并发测试，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试。 |
| 17 | 支持isuald  | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font>|覆盖继承功能cgroup v2,热升级，健康检查，本地卷，容器生命周期管理，镜像管理，资源管理等，重点验证isulad长稳场景  |
| 18 | 支持A-OPS | <font color=green>█</font> | NA | NA | NA  |覆盖特性的接口、功能、UI等测试项，发现问题已解决，回归通过，无遗留风险，整体质量良好。 | 
| 19 | 支持系统运维套件x-diagnosis  | <font color=green>█</font> | NA | NA |  NA |覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能  | 
| 20 | 支持自动化热升级组件nvwa | <font color=green>█</font> | NA | NA |  <font color=green>█</font> |主要覆盖了基本功能测试、可靠性测试、安全测试以及压力测试   |
| 21 | 支持DPU直连聚合特性dpu-utilities  | <font color=green>█</font> | NA | NA | NA |验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源  | 
| 22 | 支持系统热修复组件syscare | <font color=green>█</font> | <font color=green>█</font>   | <font color=green>█</font> |NA |验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力，重点关注新增合入栈检测，容器化能力   |
| 23 | iSula容器镜像构建工具isula-build  | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> | NA   |验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能   |
| 24 | 支持进程完整性防护特性DIM | <font color=green>█</font> | <font color=green>█</font>   | <font color=green>█</font> | NA |验证dim_core、dim_monitor模块各启动参数的功能测试，例如开启签名校验、配置度量算法、配置自动周期度量、配置度量调度时间等，用户态程序、ko、内核代码段在篡改前后的dim_core动态基线创建及度量，以及度量策略篡改前后dim_monitor对dim_core的代码段和关键数据的动态基线创建及度量  |
| 25 | 支持入侵检测框架secDetector  | <font color=green>█</font> | NA | NA | NA |验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等   |
| 26 | isocut镜像裁剪易用性提升 | <font color=green>█</font> | <font color=green>█</font>  | <font color=green>█</font> | NA |验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包   |
| 27 | 支持devmaster组件 | <font color=green>█</font> | <font color=green>█</font>   | <font color=green>█</font> |NA  |验证devmaster的安装部署、进程配置、客户端工具等使用场景   |
| 28 | 支持TPCM特性  | <font color=green>█</font> | NA | NA | NA |继承已有测试用例，验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等   |
| 29 | 支持sysMaster                          | <font color=green>█</font> | <font color=green>█</font>   | <font color=green>█</font> | NA |验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景   |
| 30 | 支持sysmonitor特性  | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> |  <font color=green>█</font> |验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景   |
| 31 | 混合部署rubik  | <font color=green>█</font> | NA | NA |  <font color=green>█</font> |覆盖rubik容器调度在业务混合部署的场景下，根据QoS分级，对资源进行合理调度，保障在线业务QoS基本无变化   |
| 32 | 支持IMA自定义证书 | <font color=green>█</font> | NA | NA | NA |验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式  |
| 33 | 支持IMA virtCCA  | <font color=green>█</font> | NA | NA | NA  |验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等   |
| 34 | 安全启动  | <font color=green>█</font> | NA | NA |  NA  |验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等  |
| 35 | Kmesh | <font color=green>█</font> | NA | NA | NA  |验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等   |
| 36 | openEuler安全配置规范框架设计及核心内容构建   | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> |验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性   ||
| 37 | oemaker | <font color=green>█</font> | <font color=green>█</font>   | <font color=green>█</font> | <font color=green>█</font>  |在构建工程中保证oemaker功能正常   |
| 38 | openssl | <font color=green>█</font> | <font color=green>█</font>   | <font color=green>█</font> | NA | 验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上    |
| 39 | 编译器(gcc/jdk) | <font color=green>█</font> | <font color=green>█</font>   | <font color=green>█</font> |   <font color=green>█</font>  |基于开源测试套对gcc和jdk相关功能进行验证  |
| 40 | 支持HA软件 | <font color=green>█</font> | <font color=green>█</font> | <font color=green>█</font> | NA |HA 的测试主要包括基本功能测试和可靠性测试。经过7*24小时的长时间稳定性测试，共完成了 12 个子模块的测试，总计执行了 26 个测试用例。测试内容涵盖了 21 个基本功能测试用例、4 个失效切换测试用例、1 个日志收集用例。整体来看，核心功能表现稳定。    |
| 41 | 支持KubeSphere | <font color=green>█</font> | NA | NA |  NA|共计执行 16 个用例，主要覆盖了在 openEuler-24.03-LTS-SP3 中通过 KubeKey 安装部署、扩容、证书更新、删除 Kubernetes、k3s 及 KubeSphere 集群的功能测试，x86 架构和 ARM64 架构均测试通过。 | 
| 43 | 支持智能运维助手  | <font color=green>█</font> | NA | NA |  NA|继承已有测试能力，关注智能定位（异常检测、故障诊断）功能、可靠性     |
| 44 | 支持k3s| <font color=green>█</font> | NA | NA |  NA|验证k3s软件的部署功能正常     |
| 45 | migration-tools增加图形化迁移openeuler功能 | <font color=green>█</font> | NA | NA |  <font color=green>█</font> |验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统   |
| 46 | 发布Nestos-kubernetes-deployer | <font color=green>█</font> | NA | NA |  NA|NKD 在 openEuler-24.03-LTS-SP3 版本测试阶段完成了功能测试，包括基础设施 & Kubernetes 1.29 版本集群的部署、扩展与销毁。整体核心功能稳定正常；完成了 aarch64 架构 （Kunpeng 920）和 x86_64 架构（Intel）的兼容性测试；完成了可靠性测试，可长时间稳定运行  |
| 47 | 发布PilotGo及其插件特性新版本 | <font color=green>█</font> | NA | NA |  NA|主要涵盖了功能测试、安全性测试和可靠性测试。通过3*24小时的长时间稳定性测试，顺利完成了 16 个子模块的测试，执行了总计 138 个测试用例。整体核心功能表现稳定，插件功能运行正常。   |
| 48 | 社区签名体系建立  | <font color=green>█</font> | NA | NA | NA |验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性   |
| 49 | 智能问答在线服务 | <font color=green>█</font> | NA | NA | NA |验证openEuler统一知识问答平台支持用户通过自然语言提问获取准确的答案，并具备多轮对话能力   |
| 50 | 支持GreatSQL | <font color=green>█</font> | <font color=green>█</font>   | NA |   <font color=green>█</font>|共执行 139 个测试项，主要涵盖了 GreatSQL 源码编译、RPM安装、二进制包安装、MGR增强、Binlog读取限速、Clone复制数据时自动最新节点、并行LOAD DATA、异步删除大表、非阻塞式DDL、NUMA亲和性优化、Oracle兼容、Clone备份加密、Clone增量备份、Clone压缩备份、审计、数据脱敏等主要功能特性等方面，主要功能均通过测试，无风险，整体核心功能稳定正常。   |
| 51 | ZGCLab发布内核安全增强补丁| <font color=green>█</font> | NA | NA | NA |基于 openEuler-24.03-LTS 版本的 HAOC 特性操作系统内核，针对其功能，特性和性能进行共计 5 项测试，整体质量良好。   |
| 52 | 支持RISC-V | NA | <font color=green>█</font>   | <font color=green>█</font> | NA |关注openEuler版本在RISV-V处理器上的可安装和可使用性     |
| 54 | 为RISC-V架构引入Penglai TEE 支持  | NA<font color=green>   </font> | <font color=green>█</font>   | NA |  NA  |验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等  |
| 55 | Add compatibility patches for Zhaoxin processors  | <font color=green> █  </font> | NA | NA | NA |验证集成了Zhaoxin OLK-6.6补丁的内核镜像系统正常运行以及对应补丁的功能测试   |
| 56 | 增加YouQu自动化测试平台支持  | <font color=green> █  </font> | <font color=green>█</font>   | <font color=green>█</font> | NA |验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试   |
| 57 | 增加 utsudo 支持  | <font color=green> █  </font> | <font color=green>█</font> | <font color=green>█</font> |NA |继承已有测试能力，验证utsudo基础命令使用正常   |
| 58 | 增加 utshell支持  | <font color=green> █  </font> | <font color=green>█</font> | <font color=green>█</font> | NA |继承已有测试能力，验证utshell基础命令使用正常   |
| 59 | 集成openGauss 6.0.0 LTS企业版 | <font color=green> █  </font> | <font color=green>█</font>   | NA | NA |重点验证openGauss 6.0.0数据库系统工具、SQL功能、数据库升级、兼容B库模块等功能测试 |
| 60 |  LLVM多版本实现   | <font color=green> █  </font> | <font color=green>█</font>   | <font color=green>█</font> | <font color=green>█</font>  |LLVM多版本继承特性，共计执行18个用例，主要覆盖了功能测试和兼容性测试，共进行一轮测试，测试包括: 特性包构建，全量版本验证以及目标应用（Rust）构建，主要测试内容包括LLVM多版本包引入对于全量版本构建没有影响、LLVM多个版本包能够正常工作和使用，未发现新增问题，遗留问题数0,整体质量良好。|
| 61 |  新增密码套件openHiTLS  | <font color=green>  █  </font> | NA | NA | NA |验证openHiTLS密码算法、密码协议和证书的功能测试,对openHiTLS主要进行功能测试，共执行4640个用例，用例通过率100%，测试过程中未发现问题，整体质量良好。|
| 64 | 支持oeaware   | <font color=green> █  </font> | NA | NA |NA|继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容  |
| 66 |  AI集群慢节点快速发现 Add Fail-slow Detection  | <font color=green> █  </font> | NA | NA | NA |重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度  |
| 67 | RPM国密签名支持  | <font color=green> █  </font> | <font color=green>█</font>   | <font color=green>█</font> | <font color=green>█</font> |重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容 |
| 68 | 鲲鹏KAE加速器驱动安装包合入   | <font color=green> █  </font> | NA | NA | NA |验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩  |
| 69 | Add Intel QAT packages support   | <font color=green> █  </font> | NA | NA | NA |Add Intel QAT packages support特性，共计执行84个用例，主要覆盖了加解密AES测试64个用例，RSA测试2用例，ECDSA测试1用例，压缩解压测试17用例，通过QAT cpa_sample_code工具测试，未发现问题，整体质量良好；|
| 70 | 版本引入ACPO包  | <font color=green> █  </font> | NA | NA | <font color=green>█</font> |重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容 ,共计执行5个用例，主要覆盖了功能测试,兼容性测试和DFX专项测试，未发现新增问题，遗留问题数0, 整体质量良好。|
| 71 |  内核TCP/IP协议栈支持CAQM拥塞  | <font color=green> █  </font> | NA | NA | NA |继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能 |
|78| openEuler安全配置基线检测工具 |<font color=green> █  </font> | <font color=green>█</font> | <font color=green>█</font> |   <font color=green>█</font>   |使用Linux系统安全检查工具secureguardian，通过执行一系列的安全检查脚本, 查看生成的安全报告，评估系统的安全性是否存在风险 |
|80| 海光CSV1/2/3支持 |<font color=green> █  </font> | NA | NA |NA  |本次24.03 SP3测试主要包括功能测试和兼容性测试，共计执行8项测试2186个用例，覆盖海光机密计算，可信计算，密码技术三类，其中密码技术类中兼容性测试存在问题，已提修复PR，无遗漏风险，整体质量良好。|
|87| 基于通信算子的低开销高精度慢节点检测 |<font color=green> █  </font> | NA | NA | NA |覆盖功能、长稳、资料测试，功能覆盖模型数据timeline图转化，数据采集开销验证，分组验证，慢节点分析验证|
|88| DevStation开发流程智能化增强|<font color=green> █  </font> | NA | NA |NA |测试mcp服务的下载、配置及应用，主要覆盖功能测试、性能测试和可靠性测试 |
|89| 支持超大虚机规格 |<font color=green> █  </font> | NA | NA | NA|继承已有测试能力，主要覆盖功能测试 |
|90| openEuler Copilot 支持多维度（时间）过滤分析和分权分域，推理高准确率开箱即用 |<font color=green> █  </font> | NA | NA | NA |继承已有测试能力，主要覆盖MCP server框架集成，数据集评估流水线，向量数据库切换openGauss，企业数据多用户管理空间等功能测试 |
|91| epkg新型软件包及包管理器功能增强|<font color=green> █  </font> | NA | NA | NA |继承已有测试能力，主要测试createrepo工具、加包工程使用x2epkg生成ubuntu及archlinux转化生成的repo仓、epkg包管理器支持基于reguire等字段进行安装 |
|92| FUSE passthrough支持| <font color=green> █  </font> | NA | NA | NA |继承已有测试能力，共计执行12个用例，主要覆盖了功能测试和性能测试，稳定性测试48H。未发现问题，整体质量良好，基础功能无质量风险，可以出口。|
|93| oeDeploy工具易用性提升，部署能力增强|<font color=green> █  </font> | NA | NA | NA |继承已有测试能力，主要覆盖oedp插件一键部署，MCP服务调用，自定义插件开发、多master的k8s集群部署等工程以及可靠性测试 |
|94| 基于eBPF等技术实现AI作业进程Stack Mergeing，支持典型内存故障定位|<font color=green> █  </font> | NA | NA |NA  |继承已有测试能力，主要覆盖功能测试，功能覆盖模型内存timeline图转化、内存堆栈转化，可以在网页上正确显示火焰图和时间线 |
|95| 虚拟化场景支持vKAE直通设备热迁移 | <font color=green> █  </font> | NA | NA |NA |继承已有测试能力，覆盖功能、性能、资料测试，功能覆盖vKAE直通虚拟机热迁移验证 |
|96| secGear支持机密虚机基于UEFI启动方式的报告生成及验证 | <font color=green> █  </font> | NA | NA | NA |验证codegen代码生成工具使用、enclave生命周期管理、signtool签名工具使用、switchless特性、本地证明特性及安全通道特性的测试 |
|97| 支持可信计算远程证明服务组件 | <font color=green> █  </font> | NA | NA |NA |覆盖AI扫描、安全编译选项、BAS扫描（c_spider、本地提权、文件权限最小化）、敏感信息扫描、安全配置审计、主机漏洞扫描、开放端口；白盒测试：安全功能规范、安全红线、白盒Fuzz；黑盒测试：安全功能规范、安全红线；功能测试：继承功能测试用例；可靠性：可靠性用例；资料：API接口文档；执行用例个数265个，发现问题9个，均已修复，整体质量良好|
|98| 支持Kuasar机密容器镜像加解密| <font color=green> █  </font> | NA | NA | NA|覆盖功能、可靠性、资料测试。覆盖了拉取加密镜像-解密-创建容器功能测试，执行5个继承用例覆盖机器容器的基本功能进行测试，包括生命周期，服务稳定性，并发测试等功能场景进行测试。 经测试未发现问题，无遗留风险，整体质量良好。|
|99| 支持众核高密容器级资源隔离技术 |<font color=green> █  </font> | NA | NA |  NA|测试机内存QoS控制、NUMA设备亲和，提升虚拟机隔离性，支撑众核高密部署密度提升100%，领先AMD 20%特性，共计执行6个用例，主要覆盖了功能测试、性能测试和资料测试，整体质量良好。 |



<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价


对新需求进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| **序号** | **特性名称**   | **测试覆盖情况**     | **约束依赖说明** | **遗留问题单** | **aarch64/x86_64质量评估**    |  **risc-v rva20质量评估**  | **risc-v rva23质量评估** | **loongarch 质量评估** |**备注** |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- | ---------------- | ---------------- | ----------------| ---------------- | -------------------------- | -------------------------- |
|1|[isa-l库：CRC算法在RISC-V架构的优化](https://gitee.com/openeuler/QA/pulls/1234/files)|  共计执行16个用例，主要覆盖了 ISA-L 加速库中 CRC，EC，RAID，IGZIP 这些功能测试发现问题已解决，回归通过，无遗留风险，整体质量良好。 | | |<font>NA</font> |<font>NA</font> | <font color=green>█</font> | NA ||
|2|[snappy库：FindMatchLength支持RISC-V架构的优化](https://gitee.com/openeuler/QA/pulls/1236)|  snappy优化查找特性，共计执行25个用例，主要覆盖了功能测试和性能测试，通过经过长稳测试，测试通过，无遗留风险，整体质量良好； | | |<font>NA</font> | <font>NA</font> | <font color=green>█</font> | NA | |
|3|[lz4库：提高riscv架构的压缩速度](https://gitee.com/openeuler/QA/pulls/1235)|  共执行用例8个，覆盖功能测试，性能测试，数据完整性测试，测试通过，无遗留风险，整体质量良好； | | |<font>NA</font> | <font>NA</font> | <font color=green>█</font> |  NA ||
|4|[openssl库：RISC-V架构的系列优化-SM2优化](https://gitee.com/openeuler/QA/pulls/1237)|  基础功能测试涵盖了openssl RPM构建，组件正确性验证测试共计2890个单元用例，目前所有功能测试均已通过，核心功能稳定正常。性能测试是通过openssl speed 命令对优化前后的AES-128-CBC、RSA2048算法、sm2特性进行加解密测试，测试结果符合预期，优化效果明显 | | |<font>NA</font> | <font>NA</font> | <font color=green>█</font> |  NA ||
|5|[virtcca: 支持virtCCA机密虚机热迁移](https://gitee.com/openeuler/QA/pulls/1277)| 覆盖功能测试，性能测试，可靠性测试，安全测试，资料测试，共执行用例30个，测试通过，无遗留风险，整体质量良好；  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|6|[golang: Backport RVA23 支持](https://gitee.com/openeuler/QA/pulls/1247)| 环境变量 `GORISCV64` 设置为 `rva20u64` `rva22u64` `rva23u64` 时，Golang 的编译测试和完整功能测试均可正常执行，且执行通过，共执行６个用例  | | |<font>NA</font> | <font>NA</font> | <font color=green>█</font> | NA | |
|7|[TSB-agent: 支持可信计算虚拟化vTPCM]()| 不在24.03-LTS-SP3版本发布，在走移除流程   | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|8|[openssl：Backport 主线 RISC-V 架构的 SHA-2 汇编优化](https://gitee.com/openeuler/QA/pulls/1250/files)| 环境变量 `OPENSSL_riscvcap` 设置为 `rv64gc_zbb`，强制启用 RISC-V 64 下的 Zbb 优化，执行 openssl 编译过程自带的 make test 测试，测试可以通过 | | |NA|<font color=green>█</font>  | <font color=green>█</font> | NA | |
|9|[URMA：URMA支持UB基础通信能力](https://gitee.com/openeuler/QA/pulls/1260)|  URMA支持UB-C基础通信能力和URMA支持UB-C多路径，共执行208个用例，开展了功能、API接口、基本可靠性测试等。主要覆盖URMA ctx、jetty等资源管理、TP创建&销毁、数据面通信、多路径能力、DFX等。当前发现问题已解决，回归通过，无遗留风险，整体质量良好。 | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> |NA | |
|10|[UMS：UMS支持socket接口通信](https://gitee.com/openeuler/QA/pulls/1249)| UMS支持socket接口通信。测试覆盖86条用例，涉及基本功能测试（ums建链、逃生通道、建链信息查询、配置项修改等）、基础可靠性测试、文档资料测试。发现问题1个。当前问题均已修复，无遗留问题。整体质量良好。  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> |NA | |
|11|[DLock：支持基于UB的分布式锁](https://gitee.com/openeuler/QA/pulls/1251)| 支持基于UB的分布式锁，共执行303个用例，开展了功能、API接口、基本可靠性测试等。主要覆盖DLock初始化反初始化、管理面分布式锁和分布式状态对象的创建和销毁、分布式锁数据面的同步、异步接口、batch接口、分布式状态对象数据面faa/cas接口以及从client恢复锁状态等。当前发现问题已解决，回归通过，无遗留风险，整体质量良好。| | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|12|[URPC：URPC支持UB](https://gitee.com/openeuler/QA/pulls/1239)| URPC支持UB特性，共执行257个用例，开展了功能、API接口、基本可靠性测试等。主要覆盖URPC channel和queue管理、UMQ创建&销毁、UMQ流控、多EID注册、数据面通信等。当前发现问题已解决，回归通过，无遗留风险，整体质量良好  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|13|[UBTurbo: HAM支持确定性热迁移能力](https://gitee.com/openeuler/QA/pulls/1264/files)| HAM特性，共计执行32个用例，主要覆盖了功能测试、可靠性测试、安全测试、资料测试，通过经过fuzz和7*24的长稳测试，测试执行率100%，测试通过率100%，发现问题已解决，回归通过，无遗留风险，整体质量良好。  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|14|[UBTurbo： SMAP支持内存冷热扫描和迁移能力](https://gitee.com/openeuler/QA/pulls/1267)| 版本内外侧全部交付需求的功能测试、可靠性测试、安全测试、资料测试。共涉及测试用例274，其中功能用例230个，可靠性用例43个，资料用例1个，测试执行率100%，测试通过率100%；该版本在各个阶段测试活动开展充分，在版本交付范围内无遗留问题  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|15|[UBTurbo：RMRS Agent支持内存迁移决策与执行](https://gitee.com/openeuler/QA/pulls/1279/files)| UBTurbo特性共计执行312个用例，主要覆盖了功能测试、可靠性测试、安全测试、资料测试、接口测试，一共发现2个一般问题，均已问题解决，验收通过，无遗留风险，整体质量良好；  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|16|[UB Turbo： UBTurbo提供基础框架(配置读取、插件加载、日志管理、IPC通信等)能力](https://gitee.com/openeuler/QA/pulls/1279/)| UBTurbo特性共计执行312个用例，主要覆盖了功能测试、可靠性测试、安全测试、资料测试、接口测试，一共发现2个一般问题，均已问题解决，验收通过，无遗留风险，整体质量良好；  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|17|[UBS Engine: UBS Engine支持UB池化资源管理能力](https://gitee.com/openeuler/QA/pulls/1257)|  UBS Engine在openEuler 24.03-LTS-SP3版本，进行了功能、安全、资料测试，共计执行102个测试用例，发现问题已解决，回归通过，无遗留风险，整体质量良好。 | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|18|[UBS Comm: HCOM支持UB通信能力](https://gitee.com/openeuler/QA/pulls/1229/files)| HCOM支持UB通信特性，共计执行840个用例，主要覆盖了接口，功能，可靠性和可服务性测试，发现3个一般问题，已回归通过，无遗留风险，整体质量良好  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|19|[OBMM: 提供跨节点内存访问与一致性控制能力](https://gitee.com/openeuler/QA/pulls/1258/files)| obmm特性总共进行1轮测试，共计执行10条，主要对新增的接口、功能场景进行了测试，发现1个问题，当前修改已合入；  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> |NA | |
|20|[sysSentry：支持UB故障劫持能力及超节点故障上报能力](https://atomgit.com/openeuler/QA/pull/1294)|sysSentry特性总共进行了1轮测试，共执行14条用例，主要对基本功能及接口和可靠性进行了测试，未发现问题   | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|21|[qemu：支持基于urma通道的内存热迁移](https://gitee.com/openeuler/QA/pulls/1248)| URMA内存热迁移特性，共计执行7个用例，主要覆盖了基本功能测试，整体质量良好  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|22|[UBNative：灵衢虚拟化基础能力支持UBNative直通虚拟化](https://gitee.com/openeuler/QA/pulls/1248)| memlink特性，共计执行8个用例，主要覆盖了基本功能测试，整体质量良好  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|23|[memlink：灵衢虚拟化基础能力支持memlink大规格虚拟机、内存回收](https://gitee.com/openeuler/QA/pulls/1248)| memlink特性，共计执行8个用例，主要覆盖了基本功能测试，整体质量良好  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|24|[utpam：基于Rust开发的身份认证模块]()| QA已评审通过，待上传测试报告  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> |NA | |
|25|[UB lib & tool：灵衢基础工具和库]()| 未评审  | | |  | <font>NA</font> | <font>NA</font> | NA ||
|26|[openssl：Backport 主线 RISC-V 架构的 MD5 汇编优化]()|代码pr未合入| | | <font>NA</font> | <font>NA</font> | <font>NA</font> | NA ||
|27|[支持树莓派](https://gitee.com/openeuler/QA/pulls/1274)|openEuler 24.03 LTS SP3 树莓派镜像版本测试完成了功能测试，测试范围包括镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成了硬件兼容性测试，包括树莓派 4B/5 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的兼容性验证。以上测试内容均未发现问题。| | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|28|[secScanner:操作系统安全加固组件](https://gitee.com/openeuler/QA/pulls/1276)|  secScanner特性，共计执行152个用例，主要覆盖了功能测试和安全测试，发现问题已解决，回归通过，无遗留风险，整体质量良好 | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|29|[VMAnalyzer:轻量级虚拟化性能监控组件](https://gitee.com/openeuler/QA/pulls/1268)| VMAnalyzer功能测试，共计执行57个用例，主要覆盖了虚拟机运行状况和性能采集检测、宿主机信息/虚拟化环境信息/虚机基本信息采集检测测试，发现问题已解决，回归通过，无遗留风险，整体质量良好。  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|30|[慢IO/慢盘检测能力增强](https://gitee.com/openeuler/QA/pulls/1230/files)| 共计执行用例16个，覆盖了功能测试、接口测试、异常测试以及资料测试，发现问题1个，整体开发代码量1.4k，发现问题1个，缺陷率为0.71/kloc，问题均已修复，无遗留问题，整体质量良好。  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|31|[CompassCI支持功能和性能自动化测试以及性能变化补丁识别定位]()| 未评审  | | |  | <font>NA</font> | <font>NA</font> | NA ||
|32|[oeDeploy支持AI Agent开发场景工具栈，支持CANN软件环境与昇腾驱动的快速部署](https://gitee.com/openeuler/QA/pulls/1240)| 共计执行114个用例，覆盖功能、可靠性、性能、安全、兼容性等测试。新增的三个oeDeploy未发现问题，关联特性共发现4个问题，均已修复，整体质量良好。  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|33|[DevStation支持MCP开发工具链和增强AI助手Agent创建，提升开发者体验，使能CVE漏洞修复提效](https://gitee.com/openeuler/QA/pulls/1272)|  MCP转换与测试工具特性，共计执行23个用例，主要覆盖功能和可靠性测试。共发现问题4个，均已解决，回归通过，整体质量良好。 | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|34|[引入IOInflight QoS控制器，降低混部场景在线业务干扰率]()| 未评审  | | |  | <font>NA</font> | <font>NA</font> | NA ||
|35|[SPDK支持vq均衡多reactor功能，降低虚拟化开销](https://gitee.com/openeuler/QA/pulls/1243)| openEuler SPDK支持vq均衡多reactor功能，虚拟化开销小于5%特性，共计执行1个用例，主要覆盖了功能测试和性能测试，整体质量良好  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|36|[openEuler Intelligence智能平台支持智能诊断、智能调优和数据治理流水线开放能力](https://gitee.com/openeuler/QA/pulls/1217,https://gitee.com/openeuler/QA/pulls/1233)| 智能诊断特性，共计执行7个用例，主要覆盖了功能测试和可靠性测试，通过100+故障注入的可靠性测试，无遗留风险，整体质量良好。智能调优特性，共计执行15个用例，主要覆盖了功能测试和性能测试，实现各应用智能调优5%以上目标，无遗留风险，整体质量良好。openEuler Intelligence知识库特性（数据流水线+ dify集成）共计执行121个测试用例，通过功能测试、性能测试、专项测试及兼容性验证，发现的11个问题均已修复并验收，无遗留风险，整体质量良好，满足商业集成及落地要求。  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|37|[sysHAX 支持支持7B 中小稠密模型推理算力填充](https://gitee.com/openeuler/QA/pulls/1245)|  据新增功能点共设计了23个测试样例进行测试；共发现5个问题，代码量4.6k，缺陷密度 1.08个/KLOC，质量风险良好 | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|38|[ModelFS提升推理服务启动速度]()| 未评审  | | | | <font>NA</font> | <font>NA</font> | NA ||
|39|[GMem异构融合内存提升异构资源利用率](https://gitee.com/openeuler/QA/pulls/1253/files)|  本特性共计执行用例56个，主要覆盖了功能测试和可靠性测试，失败用例0个，继承用例56个，用例全部通过， 发现问题已解决， 回归通过， 无遗留风险，整体质量良好。 | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|40|[毕昇JDK21支持元数据压缩优化降低堆数据内存使用](https://gitee.com/openeuler/QA/pulls/1281)| 共计执行97334个用例，主要覆盖了功能测试，通过经过fuzz和7*24的长稳测试，发现问题已解决，回归通过，无遗留风险，整体质量良好；  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> |NA | |
|41|[TF原生Embedding算子图优化提高推理性能](https://gitee.com/openeuler/QA/pulls/1244)| ANNC需求共包含4个特性，共计执行82个用例，主要覆盖了功能测试,性能测试和资料测试，发现问题1，已修复问题1，无遗留风险，整体质量良好。  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> |NA | |
|42|[毕昇JDK21版本 G1、PS支持堆内存扩缩容](https://gitee.com/openeuler/QA/pulls/1281)| 共计执行97334个用例，主要覆盖了功能测试，通过经过fuzz和7*24的长稳测试，发现问题已解决，回归通过，无遗留风险，整体质量良好；  | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|43|[LLVM编译器提升数据库（MySQL）、压缩解压缩（lz4/zstd/xz）等性能](https://gitee.com/openeuler/QA/pulls/1288/files)|共进行三轮测试, 共执行用例68个，前两轮测试执行包括: 特性包构建，全量版本验证及特性功能测试，主要测试内容包括新增特性后的版本包引入对于全量版本构建没有影响、新增特性涉及的包能够正常安装和使用, 第三轮测试包括功能测试、性能测试，共发现7个问题,以及4个环境问题/非问题，部分解决，遗留问题数0, 整体质量良好。   | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> |NA | |
|44|[毕昇JDK21支持JIT warmup， 提升Java启动性能](https://gitee.com/openeuler/QA/pulls/1281)|  共计执行97334个用例，主要覆盖了功能测试，通过经过fuzz和7*24的长稳测试，发现问题已解决，回归通过，无遗留风险，整体质量良好； | | | <font color=green>█</font> | <font>NA</font> | <font>NA</font> | NA ||
|45|[RISC-V 架构面向 RVA23 指令集扩展规范推出正式版本]()|   | | | <font>NA</font> | <font>NA</font> | <font>NA</font> | NA ||




<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1 南向兼容性

整机
| **CPU架构** | **CPU厂商**  | **CPU代号** | **整机厂商** | **测试结果**|
|--------------|---------------|-------|--------------|------------|
| x86   | intel |  cascade    |      超聚变    | pass|
| x86   | intel | GNR/SRF     |   H3C/超聚变   | |
| x86   | amd   |  turin      |   H3C/超聚变   |  |
| x86   | hygon | hygon4       | 中科可控     |    |
| x86   | zhaoxin | KH-50000   | zhaoxin   |  |
| aarch64   | huawei | kunpeng920 | huawei | pass |
| aarch64   | huawei | kunpeng920 7270z | huawei | pass|
| aarch64   | Phytium| s5000c |  Phytium |  |
| riscv64 | 算能sophgo | 算丰SG2042 | 算能sophgo | pass |
|loongarch| 龙芯|3C5000|龙芯|pass|
|loongarch| 龙芯|3C6000|龙芯|pass|
|loongarch| 龙芯|3D6000|龙芯|pass|
|loongarch| 龙芯|3A5000|龙芯|pass|
|loongarch| 龙芯|3A6000|龙芯|pass|

板卡

| **对应团队**   | **芯片型号**   | **板卡型号**     | **x86_64架构测试结果** | **aarch64架构测试结果** | 
| ----------  | -------------- | ------------------ | ------------------ | ------------ | 
|   huawei   |    Hi1822（Hi1823）      |   SP680      |    |    |
|            |    Hi1822                |   SP580      |  pass  |  pass  |
|            |    板载网卡               |         |  NA  |  pass  |
|            |    B80121                |   SP686C      |    |    |
|   marvell  |    ISP2812               |   QLE2770/QLE2772/QLE2870/QLE2872     |    |    |
|   microchip|    PM8204                |   PMC3152      |  pass  |  pass  |
|   nvidia   |    ConnectX-6 LX         |   MCX631102AN-ADAT      |  pass  |  pass  |
|            |    ConnectX-6 DX         |   MCX623106AN-CDAT      |  pass  |  pass  |
|            |    GA100                 |   Tesla A100      |  pass  |  failed  |
|   broadcom |    SAS3908               |    9560-8i     |  暂无环境  |  pass  |
|            |    BCM57508              |  P2100G      |    |    |
|            |    BCM57508              |  P2100G      |    |    |
|            |    LPe35000/LPe36000     |  LPE36002-M64       |    |    |
|            |    SAS3916               |  9560-16i   |    |    |
|   intel    |    I350                  |    I350-F2     |  pass  |  pass  |
|            |   82599ES                |   SP310      |  pass  |  pass  |
|            |   XL710                  |  XL710-QDA1/XL710-QDA2       |  已知问题  |  已知问题  |
|            |   E810-XXV               |   E810-XXV-2      |  pass  |  pass |
|   mucse    |   N10                    |   N10G-X4-QC      |    |    |
|   nebula-matrix |    M16100           | N1045XS    |    |    |
|   netswift |   WX1860A2               |  SF200T   |    |   |
|            |   WX1860A4               |  SF400T   |   |    |
|   sssnic   |   Gemini                 |  3S910/3S920/3S930  |    |   |
|            |   Aries                  |  3S585/3S5A5/3S590 |    |    |
|   中兴丁海  |    8049    　　　　　　　　 |  549c(E312)   |    |    |
|   北京纵存  |    型号未定，与厂商沟通中      | | | |
|   yunsilicon  |    型号未定，与厂商沟通中      | | | |
|   bzwx     |    型号未定，与厂商沟通中      | | | |



### 4.2.2 虚机兼容性

| HostOS     | GuestOS (虚拟机)        | 架构    | 测试结果 |
| ---------- | ----------------------- | ------- | -------- |
| openEuler 24.03 LTS SP3 | Centos 6 | x86_64 | PASS |
| openEuler 24.03 LTS SP3 | Centos 7 | aarch64 | PASS |
| openEuler 24.03 LTS SP3 | Centos 7 | x86_64  | PASS |
| openEuler 24.03 LTS SP3 | Centos 8 | aarch64 | PASS |
| openEuler 24.03 LTS SP3 | Centos 8 | x86_64  | PASS |
| openEuler 24.03 LTS SP3  | Windows Server 2016 | x86_64  | PASS |
| openEuler 24.03 LTS SP3  | Windows Server 2019 | x86_64  | PASS |
| openEuler 24.03 LTS SP3 RISC-V RVA20 | Ubuntu 24.04 | riscv64 | PASS |
| openEuler 24.03 LTS SP3 RISC-V RVA23 | Ubuntu 24.04 | riscv64 | PASS |
| openEuler 24.03 LTS SP3 Loongarch | opencloud9.4 | loongarch | PASS |
| openEuler 24.03 LTS SP3 Loongarch | anolis8.10 | loongarch | PASS |
| openEuler 24.03 LTS SP3 Loongarch | anolis 23.4 | loongarch | PASS |
| openEuler 24.03 LTS SP3 Loongarch | openeuler 24.03  | loongarch | PASS |
| openEuler 24.03 LTS SP3 Loongarch | openeuler 22.03  | loongarch | PASS |

## 4.3   专项测试结论

### 4.3.1 安全测试

24.03-LTS-SP3版本测试阶段完成了安全测试，包括病毒扫描、安全编译选项扫描、安全片段引用扫描、开源license合规检查、签名和完整性性校验、SBOM校验；测试发现的主要问题都得到了修正，回归测试结果正常。

1、病毒扫描：使用majun平台病毒扫描工具，对aarch64、x86_64架构的Everything(包含BaseOS)、EPOL所提供软件包进行病毒扫描。共计扫描52, 782个rpm包，未有病毒告警，无风险。

2、开源漏洞评估：漏洞感知详情（数据统计截至2025年11月30日），如下表。待分析漏洞中，超危漏洞6个，高危漏洞34个，正在联系相关sig进行修复，预计版本发布前完成漏洞修复。低分漏洞288个待分析，版本发布前，优先保障高分漏洞修复，低分漏洞能修尽修，未修复漏洞在update版本处理。

3、安全编译选项扫描：使用majun平台二进制扫描工具，对aarch64、x86_64架构的BaseOS所提供软件包进行安全编译选项（包括BIND_NOW、 NX、PIE、RELRO、SP、NO Rpath/Runpath、Strip）扫描。共计扫描5, 065个rpm包，总计问题数问题数99个（不同架构重复82个），所有问题均已评估或修复，无风险。

4、安全测试基线用例测试：使用openscap、mugen对标准镜像进行用例测试。覆盖初始部署、安全访问、运行服务、日志审计等方面。在aarch64与x86_64上分别测试307个用例，失败项均符合 openEuler安全配置基线的openEuler发行版本说明，无遗留问题无风险

5、开源片段引用扫描：对openEuler社区孵化BaseOS范围内软件包仓库使用majun平台开源合规扫描工具进行扫描,共计扫描仓库97个，新增问题5832个，所有问题均已评估或修复，无风险。

6、开源合规license检查：对于Everything (包含BaseOS)、EPOL提供的软件包，根据SBOM文件扫描License合规情况。共计扫描52, 782个rpm包，发现问题63个，已完成63个。所有问题均已完成修复或评估，无风险。已通过合规SIG评审。

7、签名和完整性校验：对于Everything (包含BaseOS)、EPOL提供的软件包，使用rpm工具进行签名校验,共计验证52, 782个rpm包，均通过签名检查

8、SBOM校验：版本发布后对应的ISO镜像存在sha256sum签名文件、SBOM文件、SBOM文件签名，待版本发布后检查

openEuler-24.03-LTS-SP3 版本安全测试已完成。除CVE漏洞问题外，测试发现问题均已完成修复及评估，无遗留问题无风险

### 4.3.2 可靠性测试

| 测试类型     | 测试内容     | Arm/X86测试结果     | RISC-V RVA20测试结果 | RISC-V RVA23 测试结果 |Loongarch 测试结果 |
| ------------ | ------------------ | ----------------- | ----------------- | ----------------- |----------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况；稳定性测试时长7\*24 |通过|通过|通过|通过|


### 4.3.3 性能测试


| **指标大项** | **指标小项**     | **指标值** | Arm/X86测试结果  | RISC-V RVA20 测试结果 | RISC-V RVA23 测试结果 |Loongarch 测试结果 |
|--------------|-------------|-------------------------|-----------------------------------|-----------------------------------|-----------------------------------|-----------------------------------|
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 与基线版本（24.03-LTS）对比不劣化5%以内目标已达成 | 与基线版本（24.03-LTS）对比不劣化5%以内目标已达成 | NA（因目前还没有支持RVA23标准的物理机，暂时无法测试性能） |与基线版本（24.03-LTS）对比不劣化5%以内目标已达成 |


# 5   问题单统计

openEuler 24.03-LTS-SP3版本共发现问题322个，有效问题314个，其中遗留问题 0 个，详细分布见下表:

| 测试阶段               | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 | 
| --------------------------- | -------- | ------------ | ------------ | ------------ | 
| openEuler 24.03 LTS SP3  alpha      | 5     |  5   |  0  |   0   |
| openEuler 24.03 LTS SP3  RC1        | 141   |  138 |  3  |   0   | 
| openEuler 24.03 LTS SP3  RC2        | 46    |  46  |  0  |   0   | 
| openEuler 24.03 LTS SP3  RC3        | 19    |  18  |  1  |   0   |
| openEuler 24.03 LTS SP3  RC4        | 16    |  16  |  0  |   0   | 
| openEuler 24.03 LTS SP3  RC5        | 37    |  35  |  2  |   0   |
| openEuler 24.03 LTS SP3 RC6         | 53    |  51  |  2  |   0   | 
| openEuler 24.03 LTS SP3 RC7         | 5     |  5   |  0  |   0   | 


# 6 版本测试过程评估

#### 6.1 问题单分析


本次版本测试各迭代从RC1到RC9，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求。社区有效issue共计314个，新增issue总体趋势下降, 符合质量预期，风险可控

各阶段问题分析：
1.	Alpha属于开发自验证轮次，测试未提前介入，保障baseOS范围内软件包基础发布质量（无阻塞性构建失败、基础功能可运行），累计发现构建类问题5个（均为非阻塞性问题，已随迭代修复）；
2.	RC1-RC3保障everything\epol范围内软件包正常发布，发现构建和降级问题137个，新需求转测较少，发现问题6个，主要测试活动为OS通用场景和各专项测试，发现问题51个 
3.	RC4-RC6 sysSentry、llvm、OBMM、GMEM、智能交付平台等多个新需求集中转测，同步开展OS通用场景及专项测试，OS通用场景和各专项测试发现问题8个，sysSentry、llvm、OBMM、GMEM、智能交付平台等新需求转测，发现的问题也主要集中在新需求，共发现问题70+个。
4. RC7少量遗留需求验证及全量问题回归，发现新需求问题2个（低优先级体验优化类）、构建问题3个已修复，无阻塞性风险。
5. 综上所述，剔除RC5-RC6新需求集中转测的70+个问题后，其余阶段新增Issue从Alpha的5个→RC1-RC3的194个→RC7的5个，呈先升后降的收敛趋势，符合质量预期。高风险问题（严重/主要）仅RC3出现2个（已闭环），其余阶段以主要/次要问题为主，且无OS基础能力退化问题。


#### 6.2 OS集成测试迭代版本基线

| 迭代版本                    | 测试项           | 测试子项                       |
| --------------------------- | ---------------- | ------------------------------ |
| openEuler 24.03 LTS SP3 RC1 | 冒烟测试         |                                |
|                             | 包管理专项       | 软件包安装卸载                     |
|                             |                | 自编译                      |
|                             | 安全专项      |        |
|                             | 性能专项      |        |
|                             | 安装部署         | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像PXE安装                |
|                             |                 | 标准镜像U盘安装                |
|                             |                 | everything镜像PXE安装                |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             |                 | stratovirt镜像x86_64虚拟机                 |
|                             |                 | 边缘镜像     | 
|                             | 单包             | 单包命令            |
|                             |                 | 单包服务            |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                       |
|                             |                  | 安全测试                       |
| openEuler 24.03 LTS SP3 RC2   | 冒烟测试         |                                |
|                             | 包管理专项         | 软件包升降级                     |
|                             | 安全专项      |        |
|                             | 性能专项         |                    |
|                             | 安装部署         | 标准镜像x86_64物理机 |
|                             |                 | 标准镜像x86_64虚拟机 |
|                             | 单包           | 单包命令             |
|                             |               | 单包服务             |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
| openEuler 24.03 LTS SP3 RC3 | 冒烟测试         |                                |
|                             | 包管理专项       |   软件包安装卸载                     |
|                             |                | 自编译                      |
|                             | 重启专项专项     |  冷重启                         |
|                             |                  | 热重启                         |
|                             |                  | 高压重启                       |
|                             |                  | 新增重启专项                       |
|                             | 虚拟机兼容性         |                      |
|                             | 文件系统     |                                |
|                             | 网络系统     |                                |
|                             | 安全专项         |                     |
|                             | 性能专项         |                    |
|                             | 安装部署         |  |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
| openEuler 24.03 LTS SP3 RC4 | 冒烟测试         |                                |
|                             | 包管理专项       |  软件包升级回滚      |
|                             | 安全专项         |                     |
|                             | 性能专项         |                   |
|                             | 安装部署         | 标准镜像x86物理机                       |
|                             |                  | 标准镜像x86虚拟机                       |
|                             |                  | 标准镜像u盘安装                 |
|                             |                 | stratovirt镜像x86虚拟机                 |
|                             |                 | stratovirt镜像aarch64虚拟机                 |
|                             |                 | 边缘镜像                 |
|                             | 单包            | 单包命令             |
|                             |                 | 单包服务             |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             |                  | 长稳测试                  |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
| openEuler 24.03 LTS SP3 RC5 | 冒烟测试         |                                |
|                             | 包管理专项       | 软件包安装卸载      |
|                             |                 | 软件包升降级      |
|                             |                 | 自编译           |
|                             | 安全专项         |                |
|                             | 操作系统默认参数对比       |                       |
|                             | 性能专项         |                   |
|                             | 安装部署         |  |
|                             |                 | 标准镜像aarch64物理机 |
|                             |                 | 标准镜像aarch64虚拟机 |
|                             |                 | 标准镜像PXE安装                |
|                             |                 | everything镜像PXE安装                |
|                             | 版本变化检查专项 |             |
|                             |                 |软件包升降级变化分析            |
|                             |                 |软件范围变化测试                |
|                             | 单包            | 单包命令             |
|                             |                 | 单包服务             |
| openEuler 24.03 LTS SP3 RC6     | 冒烟测试         |                                |
|                             | 包管理专项       | 增量      |
|                             |                 | 软件包安装卸载      |
|                             |                 | 软件包升降级      |
|                             | 重启专项专项     |                           |
|                             | 性能专项         |                   |
|                             |                 | 标准镜像x86_64物理机 |
|                             |                 | 标准镜像x86_64虚拟机 |
|                             | 单包            | 增量             |
|                             |                 | 单包命令             |
|                             |                 | 单包服务             |
|                             | 内核专项         | 基本功能测试                   |
|                             |                  | POSIX标准测试                  |
|                             |                  | 性能测试                  |
|                             |                  | 安全测试                  |
|                             |                  | 长稳测试                  |
| openEuler 24.03 LTS SP3 RC7     |    冒烟测试   |                    |
|                             | 回归测试       | 问题单回归                        |
 openEuler 24.03 LTS SP3 RC8    |    冒烟测试   |                    |
|                             | 回归测试       | 问题单回归                        |
 openEuler 24.03 LTS SP3 RC9     |    冒烟测试   |                    |
|                             | 回归测试       | 问题单回归                        |
|                             | release发布件测试      | release发布件测试                        |
|                             | 发布件sha256值校验       | 发布件sha256值校验                        |



# 7   附件

## 遗留问题列表

|序号|问题单号|问题简述|问题级别|影响分析|规避措施|
| ---- | ---- | ------------- | ----| ------ | ----| 

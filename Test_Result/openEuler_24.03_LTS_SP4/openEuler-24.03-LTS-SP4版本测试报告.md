![openEuler ico](../../images/openEuler.png)

版权所有 © 2026  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期        | 修订版本  | 修改章节              | 修改描述      |
| --------- | ----- | ----------------- | --------- |
| 2026/6/20 | 1.0.0 | 初稿                | sunfubin  |
| 2026/6/23 | 1.0.1 | 新增Loongarch64测试结果 | liqianwen |
| 2026/6/28 | 1.0.2 | 遗留问题刷新            | sunfubin  |
|           |       |                   |           |
|           |       |                   |           |




摘要：

文本主要描述openEuler 24.03 LTS SP4版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名                             | 中文解释       |
| ------ | ------------------------------------ | -------------- |
| OS     | Operation System                     | 操作系统       |


# 1   概述

openEuler是一款开源操作系统。当前openEuler内核源于Linux，支持鲲鹏及其它多种处理器，能够充分释放计算芯片的潜能，是由全球开源贡献者构建的高效、稳定、安全的开源操作系统，适用于数据库、大数据、云计算、人工智能等应用场景。

本文主要描述openEuler 24.03 LTS SP4版本的总体测试活动，按照社区开发模式进行运作，结合社区release-manager团队制定的版本计划规划相应的测试计划及活动。测试报告覆盖新需求、继承需求的测试执行情况和评估，并结合各类专项测试活动和版本问题单总体情况进行整体的说明和质量评估。

# 2   测试版本说明

openEuler 24.03 LTS SP4版本是基于6.6内核的增强扩展版本，面向服务器、云、边缘计算和嵌入式场景，持续提供更多新特性和功能扩展，给开发者和用户带来全新的体验，服务更多的领域和更多的用户。该版本基于openEuler 24.03 LTS-Next分支拉出，发布范围相较24.03 LTS版本主要变动：

1.  软件版本选型升级，详情请见[版本变更说明](https://atomgit.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP4/release-change.yaml)
2.  修复bug和cve
3.  交付需求，列表详情见[openEuler-24.03-LTS-SP4 release plan](https://gitcode.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP4/release-plan.md#feature-list)


## 2.1 版本测试计划
openEuler 24.03 LTS SP4版本按照社区release-manager团队的计划，共规划9轮测试，详细的版本信息和测试时间如下表：

| Stage Name                  | Deadline for PR | Begin Time | End Time  | Days | Notes                              |
| --------------------------- | --------------- | ---------- | --------- | ---- | ---------------------------------- |
| Collect key features        | -               | 2026/3/23  | 2026/4/30 | 39   | 版本需求收集                             |
| Change Review 1             | -               | 2026/4/1   | 2026/5/8  | 38   | Review 软件包变更（升级）SP版本尽可能保持版本不变      |
| Herited features            | -               | 2026/3/20  | 2026/4/10 | 22   | 继承特性合入（Branch前完成合入）                |
| Develop                     | -               | 2026/4/1   | 2026/6/6  | 67   | 新特性开发，合入24.03 LTS Next+SP4分支       |
| Kernel freezing             | -               | 2026/4/1   | 2026/5/8  | 38   | 内核冻结，KABI稳定                        |
| Branch                      | <br />          | 2026/3/27  | 2026/4/10 | 15   | 24.03 LTS Next 拉取 24.03 LTS SP4 分支 |
| Next Build                  | -               | 2026/4/4   | 2026/4/10 | 7    | 启动新版本构建，新开发特性合入                    |
| Alpha                       | 2026/4/8        | 2026/4/11  | 2026/4/17 | 7    | Alpha版本发布，24.03 LTS SP4 开发者测试      |
| Test round 1                | 2026/4/15       | 2026/4/18  | 2026/4/24 | 7    | 24.03 LTS SP4 模块测试                 |
| Test round 2                | 2026/4/22       | 2026/4/25  | 2026/5/8  | 6    | 24.03 LTS SP4 模块测试，五一劳动节快乐         |
| Change Review 2             | <br />          | 2026/5/6   | 2026/5/8  | 3    | 发起软件包淘汰评审                          |
| Test round 3 (Beta Version) | 2026/5/6        | 2026/5/9   | 2026/5/15 | 7    | 24.03 LTS SP4 模块测试                 |
| Test round 4                | 2026/5/13       | 2026/5/16  | 2026/5/22 | 7    | 24.03 LTS SP4 模块测试                 |
| Test round 5                | 2026/5/20       | 2026/5/23  | 2026/5/29 | 7    | 24.03 LTS SP4 模块测试                 |
| Test round 6                | 2026/5/27       | 2026/5/30  | 2026/6/5  | 7    | 24.03 LTS SP4 模块测试                 |
| Change Review 3             | <br />          | 2026/6/3   | 2026/6/5  | 3    | 确定软件包发布范围                          |
| Test round 7                | 2026/6/3        | 2026/6/6   | 2026/6/12 | 7    | 全量验证(全量SIT)，分支冻结，只允许bug fix        |
| Test round 8                | 2026/6/10       | 2026/6/13  | 2026/6/18 | 6    | 全量验证(全量SIT)，分支冻结，只允许bug fix        |
| Test round 9                | 2026/6/17       | 2026/6/22  | 2026/6/26 | 5    | 回归测试，只允许阻塞bug fix                  |
| Release Review              | -               | 2026/6/25  | 2026/6/26 | 2    | 版本发布决策/ Go or No Go                |
| Release preparation         | -               | 2026/6/22  | 2026/6/28 | 7    | 发布前准备阶段，发布件系统梳理                    |
| Release                     | -               | 2026/6/29  | 2026/6/30 | 2    | 社区Release评审通过正式发布                  |



## 2.2 测试硬件信息
测试的硬件环境如下：

| 硬件型号                             | 硬件配置信息                                    | 重点场景   |     |
| -------------------------------- | ----------------------------------------- | ------ | --- |
| TaiShan 200 2280均衡型              | Kunpeng 920(支持1.70以上的bios版本)              | OS集成测试 |     |
| TaiShan 200 2280均衡型              | Kunpeng 950(支持1.70以上的bios版本)              | OS集成测试 |     |
| RH2288H V5                       | Intel(R) Xeon(R) Gold 6266c CPU @ 2.30GHz | OS集成测试 |     |
| H3C UniServer R4950 G6           | AMD EPYC 9654 96-Core Processor           | OS集成测试 |     |
| TC512A0                          | 3C5000+7A2000 16核 TC512A0_V1.1 单路         | OS集成测试 |     |
| LS2C5LC2                         | 3C5000+7A2000 LS2C5LC2_V2.1 双路            | OS集成测试 |     |
| LS2C5LC6                         | 3C5000+7A2000 LS2C5LC6_V1.0 双路            | OS集成测试 |     |
| TC542F0                          | 3C5000+7A2000 TC542F0 V1.0 四路双桥           | OS集成测试 |     |
| TD542F0                          | 3D5000 TD542F0_V1.0 四路主板                  | OS集成测试 |     |
| TC512A0                          | 3C5000+7A2000 12核 TC512A0_V1.1 单路主板       | OS集成测试 |     |
| LS2C5LE                          | 3C5000LL+7A1000 LS2C5LE 双路单桥(LL主频2.0)     | OS集成测试 |     |
| loongson-3C6000/s                | 3C6000+7A2000 单路                          | OS集成测试 |     |
| Loongson-QC622D0V10              | 3C6000+7A2000 双路                          | OS集成测试 |     |
| Loongson-3C6000/Dx2-7A2000x1-EVB | 3D6000+7A2000 双路                          | OS集成测试 |     |



## 2.3 需求清单

  openEuler 24.03 LTS SP4版本交付需求列表如下，详情见[openEuler-24.03-LTS-SP4 release plan](https://gitcode.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP4/release-plan.md#feature-list)：

| no                                                                                                                                                                                                                                                                 | feature                                                                        | status     | sig                      | owner                                                                                                | 发布方式       | 涉及软件包列表                                                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ---------- | ------------------------ | ---------------------------------------------------------------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------ |
| [2366](https://atomgit.com/openeuler/release-management/issues/2366)                                                                                                                                                                                               | 增加可信计算资源分发服务组件                                                                 | Developing | sig-security-facility    | [@yang8621](https://atomgit.com/yang8621)                                                            | EPOL       | globaltrustauthority-rbs                                                                                                 |
| [2434](https://atomgit.com/openeuler/release-management/issues/2434)                                                                                                                                                                                               | 远程证明支持DICE                                                                     | Developing | sig-security-facility    | [@yang8621](https://atomgit.com/yang8621)                                                            | EPOL       | global-trust-authority                                                                                                   |
| [2441](https://atomgit.com/openeuler/release-management/issues/2441)                                                                                                                                                                                               | [海光ccp驱动升级，支持sm4-xts和sm4-gcm](https://atomgit.com/openeuler/kernel/pull/21130) | Developing | SIG-Kernel               | [@partycoder](https://atomgit.com/partycoder)                                                        | ISO        | kernel                                                                                                                   |
| [2442](https://atomgit.com/openeuler/release-management/issues/2442)                                                                                                                                                                                               | 新增海光CIS指令集sm3,sm4驱动                                                            | Developing | SIG-Kernel               | [@partycoder](https://atomgit.com/partycoder)                                                        | ISO        | kernel                                                                                                                   |
| [2448](https://atomgit.com/openeuler/release-management/issues/2448)                                                                                                                                                                                               | 支持树莓派                                                                          | Developing | sig-SBC                  | [@woqidaideshi](https://atomgit.com/woqidaideshi)                                                    | EPOL       | raspberrypi-firmware,raspberrypi-bluetooth,raspi-config,pigpio,raspberrypi-userland,raspberrypi-eeprom,raspberrypi-utils |
| [2463](https://atomgit.com/openeuler/release-management/issues/2463)                                                                                                                                                                                               | cu-cockpit                                                                     | Developing | sig-security-facility    | [@qiucx15](https://atomgit.com/qiucx15)                                                              | EPOL       | cu-cockpit                                                                                                               |
| [2459](https://atomgit.com/openeuler/release-management/issues/2459)                                                                                                                                                                                               | fastblock块存储项目                                                                 | Developing | sig-SDS                  | [@wuxingyi](https://atomgit.com/wuxingyi)                                                            | EPOL       | fastblock,fastblock-osd,fastblock-mon,fastblock-kmod                                                                     |
| [2460](https://atomgit.com/openeuler/release-management/issues/2460)                                                                                                                                                                                               | cu-concrete                                                                    | Developing | sig-security-facility    | [@liuk311](https://atomgit.com/liuk311)                                                              | EPOL       | cu-concrete                                                                                                              |
| [2461](https://atomgit.com/openeuler/release-management/issues/2461)                                                                                                                                                                                               | cu-scanner                                                                     | Developing | sig-security-facility    | [@caojingbo](https://atomgit.com/caojingbo)                                                          | EPOL       | cu-scanner                                                                                                               |
| [2462](https://atomgit.com/openeuler/release-management/issues/2462)                                                                                                                                                                                               | safeguard                                                                      | Developing | sig-ebpf                 | [@tongyx633](https://atomgit.com/tongyx633)                                                          | EPOL       | safeguard                                                                                                                |
| [2476](https://atomgit.com/openeuler/release-management/issues/2476)                                                                                                                                                                                               | sysSentry支持节点故障快速通告                                                            | Developing | Kernel-sig, Base-service | [@tong_1001](https://atomgit.com/tong_1001),[@minknov](https://atomgit.com/minknov)                  | ISO        | Kernel,sysSentry                                                                                                         |
| [82](https://atomgit.com/openeuler/libvirt/issues/82)                                                                                                                                                                                                              | UBNative支持libvirt自动管理vfio-ub驱动                                                 | Developing | Virt-sig                 | [@xiangzixua](https://atomgit.com/xiangzixua)                                                        | ISO        | libvirt                                                                                                                  |
| [8929](https://atomgit.com/openeuler/kernel/issues/8929)                                                                                                                                                                                                           | 混部场景，降低在线任务P99劣化率，提高整机的CPU利用率                                                  | Developing | Kernel-sig               | [@liaochang](https://atomgit.com/liaochang)                                                          | ISO        | Kernel                                                                                                                   |
| [1](https://atomgit.com/openeuler/witty-opentunex/issues/1)                                                                                                                                                                                                        | 提供OS层性能分析调优skills，TopDown性能瓶颈自动化识别                                             | Developing | sig-intelligence         | [@hubin95](https://atomgit.com/hubin95)                                                              | EPOL       | witty-opentunex                                                                                                          |
| [8862](https://atomgit.com/openeuler/kernel/issues/8862)                                                                                                                                                                                                           | EXT4支持硬件原子写                                                                    | Developing | Kernel-sig               | [@lonuxli](https://atomgit.com/lonuxli)                                                              | ISO        | Kernel                                                                                                                   |
| [2478](https://atomgit.com/openeuler/release-management/issues/2478)                                                                                                                                                                                               | 针对社区kernel包的性能维度问题的自动化定位                                                       | Developing | sig-cicd                 | [@xiaoniuzi](https://atomgit.com/xiaoniuzi)                                                          | 独立发布       | compass-ci                                                                                                               |
| [113](https://atomgit.com/src-openeuler/ignition/issues/113)                                                                                                                                                                                                       | Support ignition new features                                                  | Developing | sig-k8sdistro            | [@shiyang0321](https://atomgit.com/shiyang0321)                                                      | ISO        | ignition                                                                                                                 |
| [2479](https://atomgit.com/openeuler/release-management/issues/2479)                                                                                                                                                                                               | 虚拟化支持vtimer透传                                                                  | Developing | Virt                     | [@wanywhn](https://atomgit.com/wanywhn)                                                              | ISO        | qemu,KVM                                                                                                                 |
| [2480](https://atomgit.com/openeuler/release-management/issues/2480)                                                                                                                                                                                               | AI推理场景支持运行时/基础库行为采集、分析                                                         | Developing | sig-intelligence         | [@h3288824963](https://atomgit.com/h3288824963)                                                      | EPOL       | witty-profiler                                                                                                           |
| [2481](https://atomgit.com/openeuler/release-management/issues/2481)                                                                                                                                                                                               | AI训练场景慢卡、慢节点检测算法增强                                                             | Developing | sig-ops                  | [@JDLihoo](https://atomgit.com/JDLihoo)                                                              | EPOL       | sysTrace                                                                                                                 |
| [8424](https://atomgit.com/openeuler/kernel/issues/8424)                                                                                                                                                                                                           | 支持 NPU 显存 MB 级切分及隔离                                                            | Developing | Kernel-sig               | [@lukace](https://atomgit.com/lukace)                                                                | ISO        | kernel                                                                                                                   |
| [2482](https://atomgit.com/openeuler/release-management/issues/2482)                                                                                                                                                                                               | OBMM共享内存支持GDB                                                                  | Developing | Kernel-sig               | [@TrueAI](https://atomgit.com/TrueAI), [@kazero00](https://atomgit.com/kazero00)                     | ISO        | kernel                                                                                                                   |
| [4](https://atomgit.com/openeuler/ANNC/issues/4)                                                                                                                                                                                                                   | AI图编译器Embedding复杂算子自动图融合&常量折叠等优化，提升搜推广性能                                       | Developing | Compiler SIG             | [@zhaiwuyue](https://atomgit.com/zhaiwuyue)                                                          | Everything | ANNC                                                                                                                     |
| [2](https://atomgit.com/openeuler/golang/issues/2)                                                                                                                                                                                                                 | Go编译器静态编译优化增强，运行时内存分区等优化，提升程序性能                                                | Developing | Compiler SIG, Go SIG     | [@wd-gitcode](https://atomgit.com/wd-gitcode)                                                        | Everything | golang                                                                                                                   |
| [2477](https://atomgit.com/openeuler/release-management/issues/2477)                                                                                                                                                                                               | openEuler 24.03 LTS SP4支持CGroupV2                                              | Developing | Kernel SIG               | [@lujialin2](https://atomgit.com/lujialin2)                                                          | ISO        | kernel                                                                                                                   |
| [2483](https://atomgit.com/openeuler/release-management/issues/2483)                                                                                                                                                                                               | openEuler支持64k内核发布(双内核方案)                                                      | Developing | sig-os-builder           | [@zhangqiumiao](https://atomgit.com/zhangqiumiao), [@haoyonghao10](https://atomgit.com/haoyonghao10) | ISO        | kernel, oemaker, anaconda                                                                                                |
| [117](https://atomgit.com/openeuler/llvm-project/issues/117)                                                                                                                                                                                                       | Dwarfutil功能增强，减少典型应用编译后Debug信息                                                 | Developing | Compiler SIG             | [@eastb233](https://atomgit.com/eastb233)                                                            | Everything | llvm-project, llvm                                                                                                       |
| [2484](https://atomgit.com/openeuler/release-management/issues/2484)                                                                                                                                                                                               | 优化内核补丁回合，提升内核版本补丁合入效率                                                          | Developing | sig-devstation           | [@duan_pengjie](https://atomgit.com/duan_pengjie)                                                    | 独立发布       | nvwa-cve-fixer                                                                                                           |
| [9216](https://link.atomgit.com/?target=https%3A%2F%2Fhttps%2F%2Fatomgit.com%2Fopeneuler%2Fkernel%2Fissues%2F9216&from=https%3A%2F%2Fatomgit.com%2Fopeneuler%2Frelease-management%2Fblob%2Fmaster%2FopenEuler-24.03-LTS-SP4%2Frelease-plan.md&lang=zh&theme=white) | 大页内存支持swap机制                                                                   | Developing | Kernel-sig               | [@zhangliang5](https://atomgit.com/zhangliang5)                                                      | ISO        | kernel                                                                                                                   |
| [2490](https://atomgit.com/openeuler/release-management/issues/2490)                                                                                                                                                                                               | 优化鲲鹏950虚拟化转换率                                                                  | Developing | Virt-sig                 | [@cfalfie](https://atomgit.com/cfalfie)                                                              | ISO        | spdk                                                                                                                     |
| [2491](https://atomgit.com/openeuler/release-management/issues/2491)                                                                                                                                                                                               | AI软件包适配（新增30+），覆盖推理场景，兼容DeepSeek，使能沐曦                                          | Developing | sig-intelligence         | [@jimmy_hero](https://atomgit.com/jimmy_hero), [@fromhsc](https://atomgit.com/fromhsc)               | NA         | NA                                                                                                                       |
| [20](https://atomgit.com/openeuler/MLCacheDirect/issues/20)                                                                                                                                                                                                        | RH2D多级缓存直通加速                                                                   | Developing | sig long                 | [@PhoenixVang](https://atomgit.com/PhoenixVang)                                                      | EPOL       | MLCacheDirect                                                                                                            |






## 2.4 测试活动分工
 本次版本继承测试活动分工如下：

| **序号** | **需求**                                           | **开发主体**                                   | **测试主体**                                   | **测试分层策略**                                                                                                         |     |
| :----- | :----------------------------------------------- | :----------------------------------------- | :----------------------------------------- | :----------------------------------------------------------------------------------------------------------------- | --- |
| 1      | 支持UKUI桌面                                         | sig-UKUI                                   | sig-UKUI                                   | 验证UKUI桌面系统在openEuler版本上的可安装和基本功能                                                                                   |     |
| 2      | 支持DDE桌面                                          | sig-DDE                                    | sig-DDE                                    | 验证DDE桌面系统在openEuler版本上的可安装和基本功能及其他性能指标                                                                             |     |
| 3      | 支持Kiran桌面                                        | sig-KIRAN-DESKTOP                          | sig-KIRAN-DESKTOP                          | 验证kiran桌面在openEuler版本上的可安装卸载和基本功能                                                                                  |     |
| 4      | 安装部署                                             | sig-OS-Builder                             | sig-QA                                     | 验证覆盖裸机/虚机场景下，通过光盘/PXE等安装方式，覆盖最小化/虚拟化/服务器三种模式的安装部署                                                                  |     |
| 5      | 内核                                               | Kernel                                     | Kernel                                     | 关注本次版本发布特性涉及内核配置参数修改后，是否对原有内核功能有影响；采用开源测试套LTP/mmtest等进行内核基本功能的测试保障；通过开源性能测试工具对内核性能进行验证，保证性能基线与LTS基本持平，波动范围小于5%以内   |     |
| 6      | 容器(isula/docker/安全容器/系统容器/镜像)                    | sig-CloudNative                            | sig-CloudNative                            | 关注本次容器领域相关软件包升级后，容器引擎原有功能完整性和有效性，需覆盖isula、docker两个引擎；分别验证安全容器、系统容器和普通容器场景下基本功能验证；另外需要对发布的openEuler容器镜像进行基本的使用验证    |     |
| 7      | 虚拟化                                              | Virt                                       | Virt                                       | 重点关注回合新特性后，新版本上虚拟化相关组件的基本功能                                                                                        |     |
| 8      | 系统性能自优化组件A-Tune                                  | A-Tune                                     | A-Tune                                     | 重点关注本次新合入部分优化需求后，A-Tune整体性能调优引擎功能在各类场景下是否能根据业务特征进行最佳参数的适配；另外A-Tune服务/配置检查也需重点关注                                    |     |
| 9      | 支持secPaver                                       | sig-security-facility                      | sig-QA                                     | 验证secPave策略开发工具在openEuler上的安装及基本功能，关注服务端的稳定性                                                                       |     |
| 10     | 支持secGear                                        | sig-confidential-computing                 | sig-QA                                     | 关注secGear特性的功能完整性                                                                                                  |     |
| 11     | 支持kubeOS                                         | sig-CloudNative                            | sig-QA                                     | 验证kubeOS提供的镜像制作工具和制作出来镜像在K8S集群场景下的双区升级的能力；可靠性需关注在分区信息异常及升级过程中故障异常场景下的恢复能力；另外关注连续反复的双区交替升级                          |     |
| 12     | 支持etmem                                          | Storage                                    | sig-QA                                     | 验证新发布模块memRouter内存策略框架的基本功能以及用户态页面切换技术userswap的内存迁移能力                                                              |     |
| 13     | 支持用户态协议栈gazelle                                  | sig-high-performance-network               | sig-QA                                     | 关注gazelle高性能用户态协议栈功能                                                                                               |     |
| 14     | 支持国密算法                                           | sig-security-facility                      | sig-QA                                     | 验证openEuler操作系统对关键安全特性进行商密算法使能，并为上层应用提供商密算法库、证书、安全传输协议等密码服务。                                                       |     |
| 15     | 支持pod带宽管理oncn-bwm                                | sig-high-performance-network               | sig-QAk                                    | 验证命令行接口，带宽管理功能场景，并发、异常流程、网卡故障以及ebpf程序篡改等故障注入，功能生效过程中反复使能/网卡Qos功能、反复修改cgroup优先级、反复修改在线水线、反复修改离线带宽等测试                |     |
| 16     | iSulad                                           | sig-iSulad                                 | sig-QA                                     | 覆盖继承功能，重点验证isulad长稳场景                                                                                              |     |
| 17     | 支持A-OPS                                          | sig-iSulad                                 | sig-QA                                     | 重点关注本次新增合入容器干扰检测，微服务性能问题分钟级定位定界场景                                                                                  |     |
| 18     | 支持系统运维套件x-diagnosis                              | sig-ops                                    | sig-QA                                     | 覆盖x-diagnosis的问题定位工具集、系统巡检、ftrace增强等功能                                                                             |     |
| 19     | 支持自动化热升级组件nvwa                                   | sig-ops                                    | sig-QA                                     | 覆盖内核热升级管理能力：内核热升级命令行、保持业务的配置、升级状态查询、热升级特性开关等                                                                       |     |
| 20     | 支持DPU直连聚合特性dpu-utilities                         | sig-DPU                                    | sig-DPU                                    | 验证DPU支持将管理面进程无感卸载到DPU，搭配网络、存储、安全等的卸载，释放主机计算资源                                                                      |     |
| 21     | 支持系统热修复组件syscare                                 | sig-ops                                    | sig-QA                                     | 验证热补丁服务管理工具syscare在补丁管理、补丁制作等能力                                                                                    |     |
| 22     | iSula容器镜像构建工具isula-build                         | sig-iSulad                                 | sig-QA                                     | 验证通过Dockerfile文件快速构建容器镜像，并支持镜像的查询、删除、登录、退出等功能                                                                      |     |
| 23     | 支持进程完整性防护特性DIM                                   | sig-security-facility                      | sig-security-facility                      | 验证DIM动态完整性度量特性支持在内核模块代码段等关键内存数据的度量能力                                                                               |     |
| 24     | 支持入侵检测框架secDetector                              | sig-security-facility                      | sig-security-facility                      | 验证secDetector 入侵检测系统支持检测能力、响应能力和服务能力等                                                                              |     |
| 25     | isocut镜像裁剪                                       | sig-OS-Builder                             | sig-OS-Builder                             | 验证基于openEuler发布的标准ISO镜像进行最小系统定制裁剪，定制安装过程中支持按需裁剪RPM包                                                                |     |
| 26     | 支持devmaster组件                                    | sig-dev-utils                              | sig-dev-utils                              | 验证devmaster的安装部署、进程配置、客户端工具等使用场景                                                                                   |     |
| 27     | 支持TPCM特性                                         | sig-Base-service                           | sig-Base-service                           | 验证openEuler支持TPCM能力，覆盖shim和grub支持国密算法度量、上报度量信息到BMC、接收BMC控制命令等                                                      |     |
| 28     | 支持sysMaster组件                                    | sig-dev-utils                              | sig-dev-utils                              | 验证sysMaster组件支持进程、容器和虚拟机的统一管理能力，覆盖创建单元配置文件、管理单元服务等场景                                                               |     |
| 29     | 支持sysmonitor特性                                   | sig-ops                                    | sig-QA                                     | 验证sysmonitor监控OS系统运行过程中的异常，并将监控到的异常记录到系统日志的能力，覆盖文件监控、磁盘分区监控、网卡监控、cpu监控等场景                                          |     |
| 30     | 支持容器场景在离线混合部署rubik                               | sig-CloudNative                            | sig-CloudNative                            | 结合容器场景，验证在线对离线业务的抢占，以及混部情况下的调度优先级测试                                                                                |     |
| 31     | 支持IMA                                            | sig-security-facility                      | sig-QA                                     | 验证rpm构建时，使用第三方证书对rpm摘要列表进行签名，内核导入第三方证书后，IMA摘要列表功能正常，以及xfs文件系统下，正常开启IMA摘要列表评估模式                                     |     |
| 32     | 支持IMA virtCCA                                    | sig-security-facility                      | sig-QA                                     | 验证可信根为virtcca时，IMA度量扩展日志可正常扩展到可信根，以及存在全0度量日志，系统不会crash等                                                            |     |
| 33     | 安全启动                                             | sig-security-facility                      | sig-QA                                     | 验证bios导入证书后，正常开启安全启动，以及防回滚功能开启后，无法进行版本降级操作等；                                                                       |     |
| 34     | Kmesh                                            | sig-ebpf                                   | sig-QA                                     | 验证mdacore使能\去使能\查询功能，k8s场景的fortio网格加速测试、非容器场景的tcp网格加速功能，kmesh支持pod粒度/namespace粒度流量治理功能等                            |     |
| 35     | openEuler安全配置规范框架设计及核心内容构建                       | sig-security-facility                      | sig-QA                                     | 验证安全配置构建工程可以正常构建，安全配置指导内容正确，具有指导性                                                                                  |     |
| 36     | oemaker                                          | sig-OS-Builder                             | sig-QA                                     | 重点验证oemaker在构建工程中功能正常                                                                                              |     |
| 37     | openssl                                          | sig-security-facility                      | sig-QA                                     | 验证相比关闭指令集加速开关，sm4算法的加解密速度在默认打开情况下提升40倍以上                                                                           |     |
| 38     | 编译器(gcc/jdk)                                     | Compiler                                   | sig-QA                                     | 基于开源测试套对gcc和jdk相关功能进行验证                                                                                            |     |
| 39     | 支持HA软件                                           | sig-Ha                                     | sig-Ha                                     | 验证HA软件的安装和软件的基本功能，重点关注服务的可靠性和性能等指标                                                                                 |     |
| 40     | 支持KubeSphere                                     | sig-K8sDistro                              | sig-K8sDistro                              | 验证kubeSphere的安装部署和针对容器应用的基本自动化运维能力                                                                                 |     |
| 41     | 支持OpenStack Train 和 Wallaby                      | sig-OpenStack                              | sig-OpenStack                              | 重点验证openstack T和W版本发布主要组件的安装部署、基本功能                                                                                |     |
| 42     | 支持智能运维助手                                         | sig-ops                                    | sig-QA                                     | 关注智能定位（异常检测、故障诊断）功能、可靠性                                                                                            |     |
| 43     | 支持k3s                                            | sig-K8sDistro                              | sig-K8sDistro                              | 验证k3s软件的部署测试过程                                                                                                     |     |
| 44     | migration-tools增加图形化迁移openeuler功能                | sig-Migration                              | sig-Migration                              | 验证migration-tools图形化迁移工具支持其他操作系统快速、平滑、稳定且安全地迁移至 openEuler 系操作系统                                                    |     |
| 45     | 发布Nestos-kubernetes-deployer                     | sig-K8sDistro                              | sig-K8sDistro                              | 验证在NestOS上部署，升级和维护kubernetes集群功能正常                                                                                 |     |
| 46     | 支持NestOS                                         | sig-CloudNative                            | sig-CloudNative                            | 验证NestOS各项特性：ignition自定义配置、nestos-installer安装、zincati自动升级、rpm-ostree原子化更新、双系统分区验证                                  |     |
| 47     | 发布PilotGo及其插件特性新版本                               | sig-ops                                    | sig-QA                                     | 验证PilotGo支持 topo 图的展示和智能调优能力                                                                                       |     |
| 48     | 社区签名体系建立                                         | sig-security-facility                      | sig-security-facility                      | 验证安装 openEuler 镜像后，开启安全启动、内核模块校验、IMA、RPM 校验等按机制，在系统启动和运行阶段使能相应的签名验证功能，保障系统组件的真实性和完整性                               |     |
| 49     | 支持GreatSQL                                       | sig-DB                                     | sig-DB                                     | 验证openEuler支持高可用、高性能、高安全、高兼容的GreatSQL开源数据库                                                                         |     |
| 50     | 支持RISC-V                                         | sig-RISC-V                                 | sig-RISC-V                                 | 验证openEuler版本在RISV-V处理器上的可安装和可使用性                                                                                  |     |
| 51     | 为 RISC-V 架构引入 Penglai TEE 支持                     | sig-RISC-V                                 | sig-RISC-V                                 | 验证openEuler操作系统在RISC-V 架构上对可扩展 TEE的支持，使能高安全性要求的应用场景：如安全通信、密码鉴权等                                                    |     |
| 52     | LLVM平行宇宙计划 RISC-V Preview 版本                     | sig-RISC-V                                 | sig-RISC-V                                 | 验证 openEuler 平行宇宙计划产物镜像的可安装和可使用性, 覆盖功能、性能、可靠性、安全等各项测试活动                                                            |     |
| 53     | virtCCA机密虚机特性合入                                  | sig-kernel/sig-virt                        | sig-kernel/sig-virt                        | 继承已有测试能力，重点验证机密虚机的基本功能、安全、兼容性以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试                                                     |     |
| 54     | 增加YouQu自动化测试平台支持                                 | sig-QA                                     | sig-QA                                     | 验证YouQu自动化测试平台部署正常，并在DDE环境上执行自动化测试                                                                                 |     |
| 55     | 增加 utsudo 支持                                     | sig-memsafety                              | sig-memsafety                              | 继承已有测试能力，验证utsudo基础命令使用正常                                                                                          |     |
| 56     | 增加 utshell支持                                     | sig-memsafety                              | sig-memsafety                              | 继承已有测试能力，验证utshell基础命令使用正常                                                                                         |     |
| 57     | 海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核）               | sig-kernel                                 | sig-kernel                                 | 重点验证CSV3虚拟机的不同启动方式，覆盖功能、稳定性、兼容性测试                                                                                  |     |
| 58     | 集成openGauss 6.0.0 LTS企业版                         | sig=DB                                     | sig=DB                                     | 重点验证openGauss 6.0.0数据库系统工具、SQL功能、数据库升级、兼容B库模块等功能测试                                                                 |     |
| 59     | LLVM多版本实现                                        | sig-Compiler                               | sig-Compiler                               | 继承已有测试能力，验证LLVM多版本下，全量版本构建正常、LLVM多版本包能够正常工作和使用。                                                                    |     |
| 60     | 新增密码套件openHiTLS                                  | sig-security-facility                      | sig-security-facility                      | 继承已有测试能力，重点验证openHiTLS密码算法、密码协议和证书的功能测试                                                                            |     |
| 61     | 支持oeaware                                        | sig-A-Tune                                 | sig-QA                                     | 继承已有测试能力，重点验证oeaware插件框架以及采集、感知等插件，主要覆盖了服务测试、客户端测试、框架测试、可靠性测试、安全测试等测试内容                                            |     |
| 62     | AI集群慢节点快速发现 Add Fail-slow Detection              | sig-desktop                                | sig-desktop                                | 继承已有测试能力，重点验证组内多节点/多卡空间维度对比，输出慢节点/慢卡的检测精度                                                                          |     |
| 63     | RPM国密签名支持                                        | sig-security-facility                      | sig-security-facility                      | 重点验证异常参数解析&异常配置文件接口功能，验证gpg支持生成国密公私钥、生成国密证书，、国密签名和验签，rpm支持国密算法签名和验签等测试内容                                           |     |
| 64     | 鲲鹏KAE加速器驱动安装包合入                                  | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，验证KAE加解密加速SSL/TLS应用和使用KAEzip进行数据压缩                                                                        |     |
| 65     | Add Intel QAT packages support                   | sig-Intel-Arch                             | sig-Intel-Arch                             | 继承已有测试能力，重点验证intel qat相关软件包的功能和性能                                                                                  |     |
| 66     | Add OpenVINO packages native support             | sig-Intel-Arch/sig-intelligence            | sig-Intel-Arch/sig-intelligence            | 继承已有测试能力，验证OpenVINO框架上sample code编译运行成功和OpenVINO的推理功能                                                              |     |
| 67     | Add oneAPI low level native support              | sig-Intel-Arch/sig-intelligenc             | sig-Intel-Arch/sig-intelligenc             | 继承已有测试能力，重点验证oneAPI对于sample code的编译运行，大模型基于oneAPI加速框架的正确支持以及相应软件包的功能测试                                             |     |
| 68     | 版本引入ACPO包                                        | sig-Compiler                               | sig-Compiler                               | 继承已有测试能力，重点验证使能ACPO、使用ACPO进行模型训练和推理，覆盖功能、性能和可靠性测试内容                                                                |     |
| 69     | 内核TCP/IP协议栈支持CAQM拥塞                              | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，验证CAQM拥塞控制算法使能后标准功能和性能                                                                                    |     |
| 70     | openEuler安全配置基线检测工具                              | SIG-security-facility                      | SIG-security-facility                      | 使用Linux系统安全检查工具 secureguardian，通过执行一系列的安全检查脚本, 查看生成的安全报告，评估系统的安全性是否存在风险                                            |     |
| 71     | 支持树莓派                                            | SIG-SBC                                    | SIG-SBC                                    | 继承已有测试能力，对树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性等测试                                                                      |     |
| 72     | OVMF_CODE.fd支持CSV1/2/3开箱即用                       | sig-edk2                                   | sig-edk2                                   | 继承已有测试能力，主要包括功能测试，稳定性测试，压力测试                                                                                       |     |
| 73     | OVMF.fd支持CSV1/2/3开箱即用                            | sig-edk2                                   | sig-edk2                                   | 继承已有测试能力，主要包括功能测试,稳定性测试                                                                                            |     |
| 74     | 新的psp/ccp device id支持                            | sig-kernel/sig-qemu                        | sig-kernel/sig-qemu                        | 继承已有测试能力，主要覆盖海光可信功能验证                                                                                              |     |
| 75     | 可信功能内核驱动剥离sev依赖                                  | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，主要覆盖海光可信功能验证                                                                                              |     |
| 76     | vTKM 性能优化                                        | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，主要覆盖普通虚拟机和CSV虚拟机下的TKM功能验证，性能测试验证,内部密钥的SM2签名、SM2解密、SM4                                                     |     |
| 77     | 基于通信算子的低开销高精度慢节点检测                               | sig-ops                                    | sig-ops                                    | 继承已有测试能力，覆盖功能、长稳、资料测试，功能覆盖模型数据timeline图转化，数据采集开销验证，分组验证，慢节点分析验证                                                    |     |
| 78     | FUSE passthrough支持                               | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，主要覆盖功能测试和性能测试                                                                                             |     |
| 79     | 基于eBPF等技术实现AI作业进程Stack Mergeing，支持典型内存故障定位       | sig-ops                                    | sig-ops                                    | 继承已有测试能力，主要覆盖功能测试，功能覆盖模型内存timeline图转化、内存堆栈转化，可以在网页上正确显示火焰图和时间线                                                     |     |
| 80     | 虚拟化场景支持vKAE直通设备热迁移                               | virt-sig                                   | virt-sig                                   | 继承已有测试能力，覆盖功能、性能、资料测试，功能覆盖vKAE直通虚拟机热迁移验证                                                                           |     |
| 81     | secGear支持机密虚机基于UEFI启动方式的报告生成及验证                  | sig-confidential-computing                 | sig-confidential-computing                 | 继承已有测试能力，覆盖功能测试和可靠性测试                                                                                              |     |
| 82     | 支持可信计算远程证明服务组件                                   | sig-security-facility                      | sig-security-facility                      | 继承已有测试能力，涉及基础冒烟测试和ltp测试                                                                                            |     |
| 83     | 支持Kuasar机密容器镜像加解密                                | sig-confidential-computing/sig-Cloudnative | sig-confidential-computing/sig-Cloudnative | 继承已有测试能力，覆盖功能、可靠性、资料测试。                                                                                            |     |
| 84     | 支持众核高密容器级资源隔离技术                                  | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，测试众核调度对计算密集型与IO密集型业务服务QPS的影响，在部署密度提升超过10%的情况下业务性能良好无劣化                                                    |     |
| 85     | snappy库：FindMatchLength支持RISC-V架构的优化             | sig-Base-service                           | sig-QA                                     | 继承已有测试能力，主要覆盖功能测试，验证引入snappy优化后，snappy能够正常解压缩                                                                      |     |
| 86     | lz4库：提高riscv架构的压缩速度                              | sig-Base-service                           | sig-QA                                     | 继承已有测试能力，主要覆盖功能测试、性能测试、兼容性测试和稳定性测试，重点验证优化后的性能提升效果                                                                  |     |
| 87     | openssl库：RISC-V架构的系列优化-SM2优化                     | sig-dev-utils                              | sig-QA                                     | 继承已有测试能力，使用官方自带测试用例，运行make test涵盖特性的所有类型验证测试；使用openssl speed工具测试加入特性前后的sm2/rsa2048/aes-128-cbc性能                   |     |
| 88     | virtcca: 支持virtCCA机密虚机热迁移                        | sig-kernel,virt                            | sig-QA                                     | 继承已有测试能力，主要覆盖功能测试、可靠性测试、性能测试，功能重点覆盖不同虚机规格、数量热迁移执行，业务不中断，可靠性重点覆盖迁移前可用资源检查、迁移失败源虚机恢复、并发/反复迁移稳定性、内存完整性检查等             |     |
| 89     | golang: Backport RVA23                           | sig-golang                                 | sig-QA                                     | 继承已有测试能力，重点验证 Backport 后 Golang 软件包本身能够通过所有测试                                                                      |     |
| 90     | TSB-agent: 支持可信计算虚拟化vTPCM                        | sig-security-facility                      | sig-QA                                     | 继承已有测试能力，重点验证在Host端使用 cli/api 进行虚机创建、展示、启动、停止、删除、迁移成功                                                              |     |
| 91     | openssl：Backport 主线 RISC-V 架构的 SHA-2 汇编优化        | sig-dev-utils                              | sig-QA                                     | 继承已有测试能力，验证SHA-2算法核心应用场景，如数据完整性验证，数据签名基础，密码安全存储                                                                    |     |
| 92     | URMA：URMA支持UB基础通信能力                              | sig-UnifiedBus                             | sig-QA                                     | 继承已有测试能力，重点覆盖对用户呈现的接口测试，功能方面覆盖URMA初始化、管理面建链、数据面收发等测试，对资源不足、对端进程异常退出等可靠性场景开展测试                                      |     |
| 93     | UMS：UMS支持socket接口通信                              | sig-UnifiedBus                             | sig-QA                                     | 继承已有测试能力，重点覆盖用户使用UMS的主要场景，功能方面覆盖UMS的正常建链、逃生通道触发、建链信息打印以及配置参数写入等场景                                                  |     |
| 94     | DLock：支持基于UB的分布式锁                                | sig-UnifiedBus                             | sig-QA                                     | 继承已有测试能力，覆盖对用户呈现的接口测试，功能方面覆盖DLock初始化、管理面建链、数据面收发等测试，对资源上限、进程异常退出等可靠性开展测试                                           |     |
| 95     | URPC：URPC支持UB                                    | sig-UnifiedBus                             | sig-QA                                     | 继承已有测试能力，功能方面覆盖对用户呈现的接口测试、URPC初始化、管理面建链、数据面收发等功能测试，对资源不足、对端进程异常退出等可靠性场景开展测试，并开展正常使用流程的长稳压测                         |     |
| 96     | UBTurbo: HAM支持确定性热迁移能力                           | sig-UnifiedBus                             | sig-QA                                     | 继承已有测试能力，主要覆盖基于灵衢总线的远端内存访问能力与大带宽，实现确定性时长的虚机热迁移能力                                                                   |     |
| 97     | UBTurbo： SMAP支持内存冷热扫描和迁移能力                       | sig-UnifiedBus                             | sig-QA                                     | 继承已有测试能力，重点验证SMAP可进行页面的冷热判断，根据冷热把页面在本地内存和远端内存之间做迁移，主要覆盖功能测试、可靠性测试和安全测试                                             |     |
| 98     | UBTurbo：RMRS Agent支持内存迁移决策与执行                    | sig-UnifiedBus                             | sig-QA                                     | 继承已有测试能力，重点覆盖RMRS Agent对用户提供的API接口，验证内存迁移决策与执行功能                                                                   |     |
| 99     | UB Turbo： UBTurbo提供基础框架(配置读取、插件加载、日志管理、IPC通信等)能力 | sig-UnifiedBus                             | sig-QA                                     | 继承已有测试能力，构建UBTurbo测试插件，覆盖UBTurbo框架提供的插件注册/去注册,配置项获取以及日志记录功能                                                        |     |
| 100    | UBS Engine: UBS Engine支持UB池化资源管理能力               | sig-UB-ServiceCore                         | sig-QA                                     | 继承已有测试能力，结合UBS Engine需求的交付的能力，覆盖接口/功能、场景、专项测试                                                                      |     |
| 101    | UBS Comm: HCOM支持UB通信能力                           | sig-UB-ServiceCore                         | sig-QA                                     | 继承已有测试能力，重点测试UB通信单边Read/Write，双边send以及多路径能力，基于场景侧通信能力要求，多并发大数据量发送验证                                                |     |
| 102    | OBMM: 提供跨节点内存访问与一致性控制能力                          | sig-Long                                   | sig-QA                                     | 继承已有测试能力，主要覆盖接口／功能，以及场景测试,验证OBMM提供跨节点内存访问与一致性控制能力功能正常                                                              |     |
| 103    | sysSentry：支持UB故障劫持能力及超节点故障上报能力                   | sig-Base-service                           | sig-QA                                     | 继承已有测试能力，重点覆盖panic/reboot场景劫持通过URMA/UVB通道上报消息答复功能；主动下电/oom通过sysSentry内部逻辑上报消息答复功能；ub内存故障上报以及故障上报后根据物理地址杀掉对应的业务进程功能 |     |
| 104    | qemu：支持基于urma通道的内存热迁移                            | sig-Virt                                   | sig-QA                                     | 继承已有测试能力，重点验证基于urma通道的内存热迁移功能，主要覆盖功能测试、可靠性测试和性能测试                                                                  |     |
| 105    | UBNative：灵衢虚拟化基础能力支持UBNative直通虚拟化                | sig-Virt                                   | sig-QA                                     | 继承已有测试能力，重点验证基于虚拟机ub设备直通功能，主要覆盖功能测试、可靠性测试                                                                          |     |
| 106    | memlink：灵衢虚拟化基础能力支持memlink大规格虚拟机、内存回收            | sig-long                                   | sig-QA                                     | 继承已有测试能力，重点验证验证memlink内存回收功能， 主要覆盖功能测试、可靠性和性能测试                                                                    |     |
| 107    | utpam：基于Rust开发的身份认证模块                            | sig-memsafety                              | sig-QA                                     | 继承已有测试能力，重点验证utpam在openEuler版本上可正常编辑PAM配置文件设置认证策略                                                                  |     |
| 108    | UB lib & tool：灵衢基础工具和库                           | sig-UnifiedBus                             | sig-QA                                     | 继承已有测试能力，重点验证ubctl作为dfx工具查询公共功能配置、模块状态、统计数据和固件信息等功能                                                                |     |
| 109    | secScanner:操作系统安全加固组件                            | sig-security_facility                      | sig-QA                                     | 继承已有测试能力，重点验证安全加固、漏洞扫描、入侵检测在openEuler系统下正常运行，以及检测组件使用权限限制、组件日志未泄露系统敏感信息                                            |     |
| 110    | VMAnalyzer:轻量级虚拟化性能监控组件                          | sig-ops                                    | sig-QA                                     | 继承已有测试能力，重点验证虚拟机运行状况和性能采集检测、宿主机信息/虚拟化环境信息/虚机基本信息采集检测测试 ｜                                                           |     |
| 111    | 引入IOInflight QoS控制器，降低混部场景在线业务干扰率                | sig-kernel                                 | sig-QA                                     | 继承已有测试能力，重点验证识别和优先处理关键任务的读写请求能力，主要覆盖功能测试和可靠性测试                                                                     |     |
| 112    | SPDK支持vq均衡多reactor功能，降低虚拟化开销                     | sig-Storage                                | sig-QA                                     | 继承已有测试能力，验证openEuler SPDK支持vq均衡多reactor功能，虚拟化开销小于5%，主要覆盖功能测试和性能测试                                                  |     |
| 113    | ModelFS提升推理服务启动速度                                | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，重点验证ModelFS 语义功能和事件管理功能，以及长稳测试                                                                            |     |
| 114    | GMem异构融合内存提升异构资源利用率                              | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，重点验证基础融合内存能力，通过内存协同，互相借用扩大内存空间提升异构资源利用率，主要覆盖功能、性能、安全和可靠性测试                                                |     |
| 115    | 毕昇JDK21支持元数据压缩优化降低堆数据内存使用                        | sig-Compiler                               | sig-QA                                     | 继承已有测试能力，重点验证通过降低Java对象头占用而减少Java堆内存（Heap Memory）占用能力，主要覆盖功能和可靠性测试                                                 |     |
| 116    | TF原生Embedding算子图优化提高推理性能                         | sig-Compiler                               | sig-QA                                     | 继承已有测试能力，重点验证图算优化提升推理性能，主要覆盖功能测试和性能测试                                                                              |     |
| 117    | 毕昇JDK21版本 G1、PS支持堆内存扩缩容                          | sig-Compiler                               | sig-QA                                     | 继承已有测试能力，重点验证用户可在应用运行时动态扩展Java堆内存的上限无需重启JVM的能力，主要覆盖功能、性能和可靠性测试                                                     |     |
| 118    | LLVM编译器提升数据库（MySQL）、压缩解压缩（lz4/zstd/xz）等性能        | sig-Compiler                               | sig-QA                                     | 继承已有测试能力，重点验证通过编译器优化提升应用性能，主要覆盖功能、性能和可靠性测试                                                                         |     |
| 119    | 毕昇JDK21支持JIT warmup， 提升Java启动性能                  | sig-Compiler                               | sig-QA                                     | 继承已有测试能力，重点验证开启优化特性可避免编译竞争提升应用性能，主要覆盖功能、性能和可靠性测试                                                                   |     |
| 120    | OS灵衢组件一键安装配置，业务可感知的通信故障场景快速定位                    | sig-unifiedbus                             | sig-QA                                     | 继承已有测试能力，UB组件可一键快速安装部署与驱动自动加载，重点验证ub-pkg-cli命令用于配置UB相关组件的配置参数与基础功能检测能力                                             |     |
| 121    | 内核态操作用户态内存场景，通过容错机制避免UCE故障上报导致系统panic            | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，重点验证内核在已知故障模式下可保持稳定，避免远端UB内存故障引发的内核崩溃，主要覆盖功能测试和可靠性测试                                                      |     |
| 122    | NPU时域切分及隔离提升利用率                                  | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，验证算力切分特性实现任务到异构算力的按需调度机制，主要覆盖功能、性能和可靠性测试                                                                  |     |
| 123    | CRIU支持NPU设备dump/restore                          | sig-kernel                                 | sig-QA                                     | 继承已有测试能力，验证cuiu冻结运行中的应用程序/部分组件后可通过检查点文件从冻结点恢复的能力，主要覆盖功能测试、接口测试、可靠测试和性能测试                                           |     |
| 124    | AI训练场景慢卡、慢节点分钟级检测、快速定界                           | sig-intelligence                           | sig-intelligence                           | 继承已有测试能力，验证在AI训练场景下，实现对XPU卡的慢卡/慢节点检测和定位，主要覆盖功能测试和可靠性测试                                                             |     |
| 125    | E2B Agent沙箱提供生命周期管理统一接口，支持脚本、K8S方式部署E2B集群        | sig-CloudNative                            | sig-CloudNative                            | 继承已有测试能力，验证E2B沙箱平台在openEuler上可一键部署，并可使用K8S进行管理部署，主要覆盖功能测试和可靠性测试                                                    |     |
| 126    | cgroup v2支持内存异步回收功能                              | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，验证cgroup v2 内存异步回收解决当前cgroup隔离方案导致的易卡死，同步内存回收带来性能下降的痛点，主要覆盖功能测试、性能测试和可靠性测试                                |     |
| 127    | 智能Cache注入                                        | sig-A-tune                                 | sig-A-tune                                 | 继承已有测试能力，验证智能cache注入支持LLC与L2 cache stash配置，主要覆盖API接口测试、功能测试、可靠性测试和性能测试                                             |     |
| 128    | sockmap加速同主机tcp流                                 | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，验证sockmap在socket层旁路tcp协议栈，降低延迟的作用，主要覆盖功能测试和性能测试                                                           |     |
| 129    | GIC超分优化，提升Nginx性能                                | sig-kernel                                 | sig-kernel                                 | 继承已有测试能力，验证相同亲和组动静态迁移测试，跨亲和组动静态迁移测试，主要覆盖功能、性能和可靠性测试等                                                               |     |
| 130    | hisock功能增强，提升目标流量吞吐性能                            | sig-kernel                                 | sig-kernel                                 | 待确认                                                                                                                |     |
| 131    | sysSentry支持硬盘寿命检测和健康监控                           | sig-Base-service                           | sig-Base-service                           | 继承已有测试能力，增强sysSentry故障检测能力，支持上报BMC所有硬盘告警事件，支持告警事件类型可配置化等，主要覆盖功能测试和可靠性测试                                            |     |
| 132    | 内存支持zone粒度内存回收（异步模式）                             | sig-kernel                                 | sig-kernel                                 | 待确认                                                                                                                |     |
| 133    | CCA机密虚机支持设备直通                                    | sig-virt                                   | sig-QA                                     | 测试已有测试能力，验证CCA机密虚机支持nvme盘/网卡等设备直通PF，多nvme/网卡等设备直通机密虚机                                                              |     |
| 134    | Go语言map SIMD加速、hashtriemap算法优化等，提升hashmap性能      | sig-golang                                 | sig-QA                                     | 继承已有测试能力，验证Go语言map SIMD加速、hashtriemap算法优化等效果，主要覆盖功能测试和性能测试                                                         |     |
| 135    | AI图编译器TF+XLA动态batch场景并行化优化，提升性能                  | sig-Compiler                               | sig-QA                                     | 继承已有测试能力，验证XLA编译器支持动态batch和并行优化的效果，主要覆盖功能测试和性能测试                                                                   |     |
| 136    | LLVM实现RabitQ性能提升                                 | sig-Compiler                               | sig-QA                                     | 继承已有测试能力，验证向量化增强优化和memcpy inline优化效果，主要覆盖功能测试和性能测试                                                                 |     |
| 137    | LLVM优化降低数据库、搜推场景编译时长                             | sig-Compiler                               | sig-QA                                     | 继承已有测试能力，验证LLVM使能编译优化效果，主要覆盖功能测试和性能测试                                                                              |     |
| 138    | 毕昇JDK GC算法、SVE/DMB指令等优化，提升大数据性能                  | sig-Compiler                               | sig-QA                                     | 继承已有测试能力，验证毕昇JDK17 GC算法、SVE/DMB指令等优化特性效果，主要覆盖功能测试和性能测试                                                             |     |
| 139    | 虚拟机QEMU支持UB mem D2H                              | sig-virt                                   | sig-QA                                     | 继承已有测试能力，验证A5虚拟化场景通过UB总线访问KVCache内存，主要覆盖功能测试、可靠性测试和性能测试                                                            |     |
| 140    | 支持IP over URMA                                   | sig-unifiedbus                             | sig-QA                                     | 继承已有测试能力，验证IP over URMA支持智算组网TCP/IP协议通信，主要覆盖API接口测试，功能测试，并发压力测试，可靠性测试以及安全测试等                                       |     |



本次版本新增测试活动分工参见 **2.3 需求清单** 章节，由需求对应sig负责开发与测试


# 3 版本概要测试结论

   openEuler 24.03 LTS SP4版本整体测试按照release-manager团队的计划，1轮开发者自验证 + 6轮继承特性和新增特性合入测试 + 2轮全量测试 + 1轮回归测试（版本发布验收测试）；开发自验证轮次主要依赖各sig开发者自验证，聚焦于代码静态检查、安装卸载自编译、软件接口变更等测试项， RC1-RC3主要覆盖冒烟测试、安装部署、单包等OS测试项; RC4-RC6主要基于新需求测试，同步开展OS通用场景及专项测试，RC7/RC8全量测试版本交付的所有特性和各类专项测试；RC9重点对问题单较多模块的覆盖和扩展测试以及验证问题的修复；最后一轮还包括版本发布验收测试，是在版本正式发布至官网后开展的轻量化验证活动，旨在保证发布件和测试验证过程交付件的一致性。


   openEuler 24.03 LTS SP4版本共发现问题410 个，有效问题 386 个，无效问题 24 个，遗留问题6个，风险可控，版本整体质量良好。




# 4 版本详细测试结论

openEuler 24.03 LTS SP4版本详细测试内容包括：

1、完成重要组件包括内核、容器、虚拟化、编译器和从历史版本继承特性的全量功能验证，组件和特性质量较好

2、对发布软件包通过软件包专项完成了软件包的安装卸载、升级回滚、编译、命令行、服务检查等测试，测试较充分，质量良好

3、系统集成测试覆盖系统配置、文件系统及网络系统等多个方面，系统整体集成验证无风险

4、专项测试包括安全专项、性能测试、可靠性测试、兼容性性测试、资料测试，均已完成验证，质量良好

5、对版本新增特性进行测试，新增特性均满足发布要求，测试较充分，质量良好


## 4.1   特性测试结论

### 4.1.1   继承特性评价

对产品所有继承特性进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| 序号  | 组件/特性名称                                          |     **aarch64/x86_64质量评估**     | **risc-v rva20质量评估** | **risc-v rva23质量评估** | **loongarch质量评估**             | 备注  |     |
| --- | ------------------------------------------------ | :----------------------------: | :------------------: | :------------------: | ----------------------------- | :-: | :-: |
| 1   | 支持UKUI桌面                                         |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 2   | 支持DDE桌面                                          |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 3   | 支持Kiran桌面                                        |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 4   | 安装部署                                             |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 5   | 内核                                               |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 6   | 容器(isula/docker/安全容器/系统容器/镜像)                    |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 7   | 虚拟化                                              |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 8   | 系统性能自优化组件A-Tune                                  |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 9   | 支持secPaver                                       |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 10  | 支持secGear                                        |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 11  | 支持kubeOS                                         |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 12  | 支持etmem                                          |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 13  | 支持用户态协议栈gazelle                                  |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 14  | 支持国密算法                                           |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 15  | 支持pod带宽管理oncn-bwm                                |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 16  | iSulad                                           |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 17  | 支持A-OPS                                          |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 18  | 支持系统运维套件x-diagnosis                              |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 19  | 支持自动化热升级组件nvwa                                   |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 20  | 支持DPU直连聚合特性dpu-utilities                         |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 21  | 支持系统热修复组件syscare                                 |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 22  | iSula容器镜像构建工具isula-build                         |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 23  | 支持进程完整性防护特性DIM                                   |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 24  | 支持入侵检测框架secDetector                              |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 25  | isocut镜像裁剪                                       |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 26  | 支持devmaster组件                                    |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 27  | 支持TPCM特性                                         |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 28  | 支持sysMaster组件                                    |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 29  | 支持sysmonitor特性                                   |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 30  | 支持容器场景在离线混合部署rubik                               |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 31  | 支持IMA                                            |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 32  | 支持IMA virtCCA                                    |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 33  | 安全启动                                             |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 34  | Kmesh                                            |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 35  | openEuler安全配置规范框架设计及核心内容构建                       |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 36  | oemaker                                          |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 37  | openssl                                          |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 38  | 编译器(gcc/jdk)                                     |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 39  | 支持HA软件                                           |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 40  | 支持KubeSphere                                     |  特性不维护，本次不刷新验证结论，已在RM会议上汇报通过；  |                      |                      | NA                            |     |     |
| 41  | 支持OpenStack Train 和 Wallaby                      |  特性不维护，本次不刷新验证结论，已在RM会议上汇报通过；  |                      |                      | <font color=green>█</font>    |     |     |
| 42  | 支持智能运维助手                                         |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 43  | 支持k3s                                            |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 44  | migration-tools增加图形化迁移openeuler功能                |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 45  | 发布Nestos-kubernetes-deployer                     |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 46  | 支持NestOS                                         |  特性不发布，本次不刷新验证结论，已在RM会议上汇报通过；  |                      |                      | NA                            |     |     |
| 47  | 发布PilotGo及其插件特性新版本                               |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 48  | 社区签名体系建立                                         |   <font color=green>█</font>   |                      |                      | NA                            |     |     |
| 49  | 支持GreatSQL                                       |   <font color=green>█</font>   |                      |                      | <font color=green>█</font>    |     |     |
| 50  | 支持RISC-V                                         |               NA               |                      |                      | NA                            |     |     |
| 51  | 为 RISC-V 架构引入 Penglai TEE 支持                     |               NA               |                      |                      | NA                            |     |     |
| 52  | LLVM平行宇宙计划 RISC-V Preview 版本                     |      sp4不发布，已在RM会议上汇报通过；       |                      |                      | NA                            |     |     |
| 53  | virtCCA机密虚机特性合入                                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 54  | 增加YouQu自动化测试平台支持                                 |      sp4不发布，已在RM会议上汇报通过；       |                      |                      | NA                            |     |     |
| 55  | 增加 utsudo 支持                                     | <font color=green> █  </font>  |                      |                      | <font color=green> █  </font> |     |     |
| 56  | 增加 utshell支持                                     | <font color=green> █  </font>  |                      |                      | <font color=green> █  </font> |     |     |
| 57  | 海光CSV3支持（支持主机创建CSV3虚拟机，支持虚拟机中运行内核）               | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 58  | 集成openGauss 6.0.0 LTS企业版                         | <font color=green>  █  </font> |                      |                      | NA                            |     |     |
| 59  | LLVM多版本实现                                        | <font color=green> █  </font>  |                      |                      | <font color=green> █  </font> |     |     |
| 60  | 新增密码套件openHiTLS                                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 61  | 支持oeaware                                        | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 62  | AI集群慢节点快速发现 Add Fail-slow Detection              | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 63  | RPM国密签名支持                                        | <font color=green> █  </font>  |                      |                      | <font color=green> █  </font> |     |     |
| 64  | 鲲鹏KAE加速器驱动安装包合入                                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 65  | Add Intel QAT packages support                   | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 66  | Add OpenVINO packages native support             |      sp4不发布，已在RM会议上汇报通过；       |                      |                      | NA                            |     |     |
| 67  | Add oneAPI low level native support              |    软件包有缺失，不可用，已在RM会议上汇报通过；     |                      |                      | NA                            |     |     |
| 68  | 版本引入ACPO包                                        | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 69  | 内核TCP/IP协议栈支持CAQM拥塞                              | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 70  | openEuler安全配置基线检测工具                              | <font color=green> █  </font>  |                      |                      | <font color=green> █  </font> |     |     |
| 71  | 支持树莓派                                            | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 72  | OVMF_CODE.fd支持CSV1/2/3开箱即用                       | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 73  | OVMF.fd支持CSV1/2/3开箱即用                            | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 74  | 新的psp/ccp device id支持                            | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 75  | 可信功能内核驱动剥离sev依赖                                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 76  | vTKM 性能优化                                        | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 77  | 基于通信算子的低开销高精度慢节点检测                               | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 78  | FUSE passthrough支持                               | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 79  | 基于eBPF等技术实现AI作业进程Stack Mergeing，支持典型内存故障定位       | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 80  | 虚拟化场景支持vKAE直通设备热迁移                               | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 81  | secGear支持机密虚机基于UEFI启动方式的报告生成及验证                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 82  | 支持可信计算远程证明服务组件                                   | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 83  | 支持Kuasar机密容器镜像加解密                                | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 84  | 支持众核高密容器级资源隔离技术                                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 85  | snappy库：FindMatchLength支持RISC-V架构的优化             |               NA               |                      |                      | NA                            |     |     |
| 86  | lz4库：提高riscv架构的压缩速度                              |               NA               |                      |                      | NA                            |     |     |
| 87  | openssl库：RISC-V架构的系列优化-SM2优化                     |               NA               |                      |                      | NA                            |     |     |
| 88  | virtcca: 支持virtCCA机密虚机热迁移                        | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 89  | golang: Backport RVA23                           |               NA               |                      |                      | NA                            |     |     |
| 90  | TSB-agent: 支持可信计算虚拟化vTPCM                        | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 91  | openssl：Backport 主线 RISC-V 架构的 SHA-2 汇编优化        |               NA               |                      |                      | NA                            |     |     |
| 92  | URMA：URMA支持UB基础通信能力                              |  <font color=green>█ </font>   |                      |                      | NA                            |     |     |
| 93  | UMS：UMS支持socket接口通信                              | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 94  | DLock：支持基于UB的分布式锁                                | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 95  | URPC：URPC支持UB                                    | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 96  | UBTurbo: HAM支持确定性热迁移能力                           | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 97  | UBTurbo： SMAP支持内存冷热扫描和迁移能力                       | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 98  | UBTurbo：RMRS Agent支持内存迁移决策与执行                    | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 99  | UB Turbo： UBTurbo提供基础框架(配置读取、插件加载、日志管理、IPC通信等)能力 | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 100 | UBS Engine: UBS Engine支持UB池化资源管理能力               | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 101 | UBS Comm: HCOM支持UB通信能力                           | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 102 | OBMM: 提供跨节点内存访问与一致性控制能力                          | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 103 | sysSentry：支持UB故障劫持能力及超节点故障上报能力                   | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 104 | qemu：支持基于urma通道的内存热迁移                            | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 105 | UBNative：灵衢虚拟化基础能力支持UBNative直通虚拟化                | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 106 | memlink：灵衢虚拟化基础能力支持memlink大规格虚拟机、内存回收            | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 107 | utpam：基于Rust开发的身份认证模块                            | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 108 | UB lib & tool：灵衢基础工具和库                           | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 109 | secScanner:操作系统安全加固组件                            | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 110 | VMAnalyzer:轻量级虚拟化性能监控组件                          | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 111 | 引入IOInflight QoS控制器，降低混部场景在线业务干扰率                | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 112 | SPDK支持vq均衡多reactor功能，降低虚拟化开销                     | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 113 | ModelFS提升推理服务启动速度                                | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 114 | GMem异构融合内存提升异构资源利用率                              | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 115 | 毕昇JDK21支持元数据压缩优化降低堆数据内存使用                        | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 116 | TF原生Embedding算子图优化提高推理性能                         | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 117 | 毕昇JDK21版本 G1、PS支持堆内存扩缩容                          | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 118 | LLVM编译器提升数据库（MySQL）、压缩解压缩（lz4/zstd/xz）等性能        | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 119 | 毕昇JDK21支持JIT warmup， 提升Java启动性能                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 120 | OS灵衢组件一键安装配置，业务可感知的通信故障场景快速定位                    | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 121 | 内核态操作用户态内存场景，通过容错机制避免UCE故障上报导致系统panic            | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 122 | NPU时域切分及隔离提升利用率                                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 123 | CRIU支持NPU设备dump/restore                          | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 124 | AI训练场景慢卡、慢节点分钟级检测、快速定界                           | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 125 | E2B Agent沙箱提供生命周期管理统一接口，支持脚本、K8S方式部署E2B集群        | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 126 | cgroup v2支持内存异步回收功能                              | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 127 | 智能Cache注入                                        | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 128 | sockmap加速同主机tcp流                                 | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 129 | GIC超分优化，提升Nginx性能                                | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 130 | hisock功能增强，提升目标流量吞吐性能                            | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 131 | sysSentry支持硬盘寿命检测和健康监控                           | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 132 | 内存支持zone粒度内存回收（异步模式）                             | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 133 | CCA机密虚机支持设备直通                                    | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 134 | Go语言map SIMD加速、hashtriemap算法优化等，提升hashmap性能      | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 135 | AI图编译器TF+XLA动态batch场景并行化优化，提升性能                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 136 | LLVM实现RabitQ性能提升                                 | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 137 | LLVM优化降低数据库、搜推场景编译时长                             | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 138 | 毕昇JDK GC算法、SVE/DMB指令等优化，提升大数据性能                  | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 139 | 虚拟机QEMU支持UB mem D2H                              | <font color=green> █  </font>  |                      |                      | NA                            |     |     |
| 140 | 支持IP over URMA                                   | <font color=green> █  </font>  |                      |                      | NA                            |     |     |



<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>█</font>： 表示特性质量良好

### 4.1.2   新需求评价


对新需求进行评价，用表格形式评价，包括特性列表（与特性清单保持一致），验证质量评估

| **序号**                                                                                                                                                                                                                                                                                                                                                                                                                                                  | **特性名称**                                 | **测试覆盖情况**                                                                                                                                                                                                                                                                                                                                                                                        | **约束依赖说明**                                                                          | **遗留问题单** | **aarch64/x86_64质量评估**     | **risc-v rva20质量评估** | **risc-v rva23质量评估** | **loongarch 质量评估** | **备注** |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | --------- | -------------------------- | -------------------- | -------------------- | ------------------ | ------ |
| [2366](https://gitcode.com/openeuler/release-management/issues/2366 "https://gitcode.com/openeuler/release-management/issues/2366")                                                                                                                                                                                                                                                                                                                     | 增加可信计算资源分发服务组件                           | [测试报告已评审](https://atomgit.com/openeuler/QA/pull/1458)                                                                                                                                                                                                                                                                                                                                             |                                                                                     |           |                            |                      |                      | NA                 |        |
| [2434](https://gitcode.com/openeuler/release-management/issues/2434 "https://gitcode.com/openeuler/release-management/issues/2434")                                                                                                                                                                                                                                                                                                                     | 远程证明支持DICE                               | [测试报告已评审](https://atomgit.com/openeuler/QA/pull/1481)                                                                                                                                                                                                                                                                                                                                             |                                                                                     |           |                            |                      |                      | NA                 |        |
| [2441](https://gitcode.com/openeuler/release-management/issues/2441 "https://gitcode.com/openeuler/release-management/issues/2441")                                                                                                                                                                                                                                                                                                                     | 海光ccp驱动升级，支持sm4-xts和sm4-gcm              | [测试报告已评审](https://gitcode.com/openeuler/QA/pull/1483)                                                                                                                                                                                                                                                                                                                                             |                                                                                     |           |                            |                      |                      | MA                 |        |
| [2442](https://gitcode.com/openeuler/release-management/issues/2442 "https://gitcode.com/openeuler/release-management/issues/2442")                                                                                                                                                                                                                                                                                                                     | 新增海光CIS指令集sm3,sm4驱动                      | 本需求在SP4不发布，已在RM上汇报通过                                                                                                                                                                                                                                                                                                                                                                              |                                                                                     |           |                            |                      |                      | NA                 |        |
| [2448](https://gitcode.com/openeuler/release-management/issues/2448 "https://gitcode.com/openeuler/release-management/issues/2448")                                                                                                                                                                                                                                                                                                                     | 支持树莓派                                    | 继承特性不单独评审，归档测试报告即可                                                                                                                                                                                                                                                                                                                                                                                |                                                                                     |           |                            |                      |                      | NA                 |        |
| [2463](https://gitcode.com/openeuler/release-management/issues/2463 "https://gitcode.com/openeuler/release-management/issues/2463")                                                                                                                                                                                                                                                                                                                     | cu-cockpit                               | [测试报告已评审](https://atomgit.com/openeuler/QA/pull/1458)                                                                                                                                                                                                                                                                                                                                             |                                                                                     |           |                            |                      |                      | NA                 |        |
| [2459](https://gitcode.com/openeuler/release-management/issues/2459 "https://gitcode.com/openeuler/release-management/issues/2459")                                                                                                                                                                                                                                                                                                                     | fastblock块存储项目                           | [测试报告待评审](https://atomgit.com/openeuler/QA/pull/1456)                                                                                                                                                                                                                                                                                                                                             |                                                                                     |           |                            |                      |                      | NA                 |        |
| [2460](https://gitcode.com/openeuler/release-management/issues/2460 "https://gitcode.com/openeuler/release-management/issues/2460")                                                                                                                                                                                                                                                                                                                     | cu-concrete                              | [测试报告已评审](https://atomgit.com/openeuler/QA/pull/1466)                                                                                                                                                                                                                                                                                                                                             |                                                                                     |           |                            |                      |                      | NA                 |        |
| [2461](https://gitcode.com/openeuler/release-management/issues/2461 "https://gitcode.com/openeuler/release-management/issues/2461")                                                                                                                                                                                                                                                                                                                     | cu-scanner                               | [测试报告已评审](https://atomgit.com/openeuler/QA/pull/1455)                                                                                                                                                                                                                                                                                                                                             |                                                                                     |           |                            |                      |                      | NA                 |        |
| [2462](https://gitcode.com/openeuler/release-management/issues/2462 "https://gitcode.com/openeuler/release-management/issues/2462")                                                                                                                                                                                                                                                                                                                     | safeguard                                | [测试报告已评审](https://atomgit.com/openeuler/QA/pull/1464)                                                                                                                                                                                                                                                                                                                                             |                                                                                     |           |                            |                      |                      | NA                 |        |
| [2476](https://gitcode.com/openeuler/release-management/issues/2476 "https://gitcode.com/openeuler/release-management/issues/2476")                                                                                                                                                                                                                                                                                                                     | sysSentry支持节点故障快速通告                      | 共8个用例，主要覆盖了功能测试、性能测试和可靠性测试，无遗留风险，整体质量良好。                                                                                                                                                                                                                                                                                                                                                          | 1、sysSentry故障跨节点广播节点数上限为32； 2、快速通告限定urma通信通道下达成，UVB不包含；                             | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [82](https://gitcode.com/openeuler/libvirt/issues/82 "https://gitcode.com/openeuler/libvirt/issues/82")                                                                                                                                                                                                                                                                                                                                                 | UBNative支持libvirt自动管理vfio-ub驱动           | 共1个用例，主要覆盖驱动的自动绑定与解绑、虚拟机的生命周期，整体质量良好                                                                                                                                                                                                                                                                                                                                                              | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [8929](https://gitcode.com/openeuler/kernel/issues/8929 "https://gitcode.com/openeuler/kernel/issues/8929")                                                                                                                                                                                                                                                                                                                                             | 混部场景，降低在线任务P99劣化率，提高整机的CPU利用率            | 测试用例14个。功能测试全部通过，无遗留问题。基础功能无质量风险，可以出口。                                                                                                                                                                                                                                                                                                                                                            | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [1](https://gitcode.com/openeuler/witty-opentunex/issues/1 "https://gitcode.com/openeuler/witty-opentunex/issues/1")                                                                                                                                                                                                                                                                                                                                    | 提供OS层性能分析调优skills，TopDown性能瓶颈自动化识别       | 共29个用例，主要覆盖功能测试，关注瓶颈分析流程遵从度，问题已闭环，无遗留风险，整体质量良好。                                                                                                                                                                                                                                                                                                                                                   | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [8862](https://gitcode.com/openeuler/kernel/issues/8862 "https://gitcode.com/openeuler/kernel/issues/8862")                                                                                                                                                                                                                                                                                                                                             | EXT4支持硬件原子写                              | EXT4硬件原子写特性共执行4个用例，账户要覆盖了功能测试和可靠性测试，经过3*24h的可靠性测试，未发现问题，整体质量良好                                                                                                                                                                                                                                                                                                                                    | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2478](https://gitcode.com/openeuler/release-management/issues/2478 "https://gitcode.com/openeuler/release-management/issues/2478")                                                                                                                                                                                                                                                                                                                     | 针对社区kernel包的性能维度问题的自动化定位                 | 共8个用例，主要覆盖了功能测试无遗留风险，整体质量良好。                                                                                                                                                                                                                                                                                                                                                                      | bisect需要基于compass-ci测试平台执行性能测试用例，所以要先搭建好compass-ci测试平台                              | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [113](https://gitcode.com/src-openeuler/ignition/issues/113 "https://gitcode.com/src-openeuler/ignition/issues/113")                                                                                                                                                                                                                                                                                                                                    | Support ignition new features            | 共5个用例，主要覆盖了功能测试，无遗留风险，整体质量良好。                                                                                                                                                                                                                                                                                                                                                                     | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2479](https://gitcode.com/openeuler/release-management/issues/2479 "https://gitcode.com/openeuler/release-management/issues/2479")                                                                                                                                                                                                                                                                                                                     | 虚拟化支持vtimer透传                            | 共3个用例，主要覆盖libvirt开关vtimer-status功能验证、timer中断提前注入验证，以及920B、950直通前后性能对比验证 ，整体质量良好。                                                                                                                                                                                                                                                                                                                  | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2480](https://gitcode.com/openeuler/release-management/issues/2480 "https://gitcode.com/openeuler/release-management/issues/2480")                                                                                                                                                                                                                                                                                                                     | AI推理场景支持运行时/基础库行为采集、分析                   | 共执行48个用例，主要覆盖witty-profiler命令功能测试和bottleneck-identification skill功能测试，异常构造场景等可靠可用性，问题都已闭环，质量良好                                                                                                                                                                                                                                                                                                    | 1.操作系统Linux（内核 ≥ 5.4，支持 BPF CO-RE） 2.Python ≥ 3.11 3.NPU华为昇腾（Atlas 系列），依赖npu-smi 可用 | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2481](https://gitcode.com/openeuler/release-management/issues/2481 "https://gitcode.com/openeuler/release-management/issues/2481")                                                                                                                                                                                                                                                                                                                     | AI训练场景慢卡、慢节点检测算法增强                       | 共执行24个用例，主要覆盖了功能、可靠性测试，整体质量良好                                                                                                                                                                                                                                                                                                                                                                     | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [8424](https://gitcode.com/openeuler/kernel/issues/8424 "https://gitcode.com/openeuler/kernel/issues/8424")                                                                                                                                                                                                                                                                                                                                             | 支持 NPU 显存 MB 级切分及隔离                      | 共计执行34个用例，主要覆盖了功能测试和可靠性测试，经过3*24h的可靠性测试，发现问题已解决，回归通过，无遗留风险，整体质量良好                                                                                                                                                                                                                                                                                                                                 | 依赖 NPU 原生软件栈：npu 驱动、固件                                                              | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2482](https://gitcode.com/openeuler/release-management/issues/2482 "https://gitcode.com/openeuler/release-management/issues/2482")                                                                                                                                                                                                                                                                                                                     | OBMM共享内存支持GDB                            | 共执行用例22个(新增12个+继承10个），覆盖了接口测试，功能测试，长稳及可靠性测试问题均已修复，无遗留问题，整体质量良好                                                                                                                                                                                                                                                                                                                                    | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [4](https://gitcode.com/openeuler/ANNC/issues/4 "https://gitcode.com/openeuler/ANNC/issues/4")                                                                                                                                                                                                                                                                                                                                                          | AI图编译器Embedding复杂算子自动图融合&常量折叠等优化，提升搜推广性能 | 共计执行4个用例，主要覆盖了功能测试，无遗留风险，整体质量良好                                                                                                                                                                                                                                                                                                                                                                   | 通过ANNC_FLAGS="--layout-matmul"使能                                                    | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2](https://gitcode.com/openeuler/golang/issues/2 "https://gitcode.com/openeuler/golang/issues/2")\|                                                                                                                                                                                                                                                                                                                                                    | Go编译器静态编译优化增强，运行时内存分区等优化，提升程序性能          | 共计执行10个用例，主要覆盖了功能测试，无遗留风险，整体质量良好。                                                                                                                                                                                                                                                                                                                                                                 | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2477](https://gitcode.com/openeuler/release-management/issues/2477 "https://gitcode.com/openeuler/release-management/issues/2477")                                                                                                                                                                                                                                                                                                                     | openEuler 24.03 LTS SP4支持CGroupV2        | 共计执行235个用例，主要覆盖了功能测试、可靠性测试。其中功能测试用例通过；经过3*24的可靠性测试，用例全部测试通过，整体质量良好。                                                                                                                                                                                                                                                                                                                               | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2483](https://gitcode.com/openeuler/release-management/issues/2483 "https://gitcode.com/openeuler/release-management/issues/2483")                                                                                                                                                                                                                                                                                                                     | openEuler支持64k内核发布(双内核方案)                | 需求交付64k工程配套、安装以及功能，目前经过验证工程能力已适配64k包引入版本构建及镜像构建能力，和64k可选安装能力；功能主要通过OS集成测试版本基线测试项进行64k镜像覆盖，验证镜像安装、软件包安装卸载、升降级、单包命令服务、文件/网络系统以及内核功能等基本功能，测试覆盖完成，无遗留问题，整体质量良好                                                                                                                                                                                                                                        | openEuler64K兼容性对标上游upstream内核子特性的兼容性，当前不对兼容64k做额外研发                                 | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [117](https://gitcode.com/openeuler/llvm-project/issues/117 "https://gitcode.com/openeuler/llvm-project/issues/117")                                                                                                                                                                                                                                                                                                                                    | Dwarfutil功能增强，减少典型应用编译后Debug信息           | 执行5个测试用例，主要覆盖了功能测试，通过mysql应用覆盖性能测试，无遗留风险，整体质量良好。                                                                                                                                                                                                                                                                                                                                                  | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2484](https://gitcode.com/openeuler/release-management/issues/2484 "https://gitcode.com/openeuler/release-management/issues/2484")                                                                                                                                                                                                                                                                                                                     | 优化内核补丁回合，提升内核版本补丁合入效率                    | 共23个用例，主要覆盖了功能与准确率测试，无遗留风险                                                                                                                                                                                                                                                                                                                                                                        | 面向内核仓库                                                                              | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [9216](https://link.gitcode.com/?target=https://https//gitcode.com/openeuler/kernel/issues/9216&from=https://gitcode.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP4/release-plan.md&lang=zh&theme=white "https://link.gitcode.com/?target=https://https//gitcode.com/openeuler/kernel/issues/9216&from=https://gitcode.com/openeuler/release-management/blob/master/openEuler-24.03-LTS-SP4/release-plan.md&lang=zh&theme=white") | 大页内存支持swap机制                             | 共9个用例，主要覆盖大页分级和冷热分级的功能、可靠性测试，整体质量良好。                                                                                                                                                                                                                                                                                                                                                              |                                                                                     |           | <font color=green>█</font> |                      |                      | NA                 |        |
| [2490](https://gitcode.com/openeuler/release-management/issues/2490 "https://gitcode.com/openeuler/release-management/issues/2490")                                                                                                                                                                                                                                                                                                                     | 优化鲲鹏950虚拟化转换率                            | 共5个用例，主要覆盖计算、内存、网络、存储、线性度的性能对比测试，整体质量良好。                                                                                                                                                                                                                                                                                                                                                          | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [2491](https://gitcode.com/openeuler/release-management/issues/2491 "https://gitcode.com/openeuler/release-management/issues/2491")                                                                                                                                                                                                                                                                                                                     | AI软件包适配（新增30+），覆盖推理场景，兼容DeepSeek，使能沐曦    | 1、兼容DeepSeek测试完成，能正常在openeuler环境下运行deepseek V4 Flash模型；<br>2、使能沐曦验证了沐曦 MetaX C500 加速卡在 openEuler 24.03 SP3（X86 平台）上的驱动可用性、硬件识别状态、<br>PCIe 链路与互联性能、计算与显存性能、稳定性及通信库功能等；<br>3、AI软件包适配（新增30+）测试覆盖了openEuler 24.03-LTS-SP4环境下的54个AI软件包（其中SP4新引入30个AI Pip软件包），共计执行162个测试用例（每个软件包包含安装卸载和测试验证两个用例），主要覆盖了功能测试和兼容性测试。测试结果显示，所有软件包均能在openEuler 24.03-LTS-SP4环境下成功安装和运行，功能正常，未发现严重问题。整体质量良好，满足AI开发和应用的需求。<br> | NA                                                                                  | NA        | <font color=green>█</font> |                      |                      | NA                 |        |
| [20](https://gitcode.com/openeuler/MLCacheDirect/issues/20 "https://gitcode.com/openeuler/MLCacheDirect/issues/20")                                                                                                                                                                                                                                                                                                                                     | RH2D多级缓存直通加速                             | 共计执行50个用例，主要覆盖了功能测试，可靠性测试，性能测试，4*24小时长稳测试，总计发现问题15个，当前发现问题均已回归完毕，整体质量良好                                                                                                                                                                                                                                                                                                                           | 依赖 GPU 原生软件栈：cuda 驱动、固件                                                             | NA        | <font color=green>█</font> |                      |                      | NA                 |        |




<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，或遗留少量问题

<font color=green>█</font>： 表示特性质量良好

## 4.2   兼容性测试结论

### 4.2.1 南向兼容性

整机

| CPU架构   | **CPU厂商** | **CPU代号**        | **整机厂商** | 测试结果 |                           |
| ------- | --------- | ---------------- | -------- | ---- | ------------------------- |
| aarch64 | huawei    | kunpeng920       | huawei   | pass |                           |
| aarch64 | huawei    | kunpeng920 7270z | huawei   | pass |                           |
| aarch64 | huawei    | kunpeng950       | huawei   | pass | disk/raid测试项不满足未测试，其他测试通过 |
| x86     | amd       | turin            | H3C/超聚变  | pass | disk/raid测试项不满足未测试，其他测试通过 |
| loongarch64     | loongson      |  3C5000         | loongson  | pass |  |
| loongarch64    | loongson       |   3C5000LL           | loongson   | pass|  |
| loongarch64     | loongson      |   3C6000      | loongson  | pass |  |
| loongarch64    | loongson       |   3D6000         | loongson   | pass|  |



板卡

| **对应团队**  | **芯片型号**      | **板卡型号**                        | **x86_64架构测试结果** | **aarch64架构测试结果** |     |
| --------- | ------------- | ------------------------------- | ---------------- | ----------------- | --- |
| huawei    | Hi1822        | SP580                           | pass             | pass              |     |
|           | 板载网卡          |                                 | NA               | pass              |     |
| microchip | PM8204        | PMC3152                         | pass             | pass              |     |
| nvidia    | ConnectX-6 DX | MCX623106AN-CDAT                | pass             | pass              |     |
|           | GA100         | Tesla A100                      | pass             | pass              |     |
| broadcom  | SAS3908       | 9560-8i                         | pass             | pass              |     |
|           | BCM57508      | P2100G                          | pass             | pass              |     |
|           | BCM57508      | P2100G                          | pass             | pass              |     |
| intel     | I350          | I350-F2                         | pass             | pass              |     |
|           | 82599ES       | SP310                           | pass             | pass              |     |
|           | E810-XXV      | E810-XXV-2                      | pass             | pass              |     |
| marvell   | ISP2812       | QLE2770/QLE2772/QLE2870/QLE2872 | pass             | pass              |     |
| netswift  | WX1860A2      | SF200T                          | pass             | pass              |     |
|           | WX1860A4      | SF400T                          | pass             | pass              |     |



### 4.2.2 虚机兼容性

| HostOS                  | GuestOS (虚拟机)       | 架构      | 测试结果 |
| ----------------------- | ------------------- | ------- | ---- |
| openEuler 24.03 LTS SP4 | Centos 6            | x86_64  | PASS |
| openEuler 24.03 LTS SP4 | Centos 7            | aarch64 | PASS |
| openEuler 24.03 LTS SP4 | Centos 7            | x86_64  | PASS |
| openEuler 24.03 LTS SP4 | Centos 8            | aarch64 | PASS |
| openEuler 24.03 LTS SP4 | Centos 8            | x86_64  | PASS |
| openEuler 24.03 LTS SP4 | Windows Server 2016 | x86_64  | PASS |
| openEuler 24.03 LTS SP4 | Windows Server 2019 | x86_64  | PASS |
| openEuler 24.03 LTS SP4 | Anolis os 8.10 | loongarch64  | PASS |
| openEuler 24.03 LTS SP4 | Loongnix server 23.2 | loongarch64  | PASS |
| openEuler 24.03 LTS SP4 | openCloudOS 9.4 | loongarch64  | PASS |
| openEuler 24.03 LTS SP4 | TencentOS Server 4.4 | loongarch64  | PASS |



## 4.3   专项测试结论

### 4.3.1 安全测试

[24.03-LTS-SP4版本安全测试报告](https://atomgit.com/openeuler/QA/pull/1474/)

24.03-LTS-SP4版本测试阶段完成了安全测试，包括病毒扫描、安全编译选项扫描、安全片段引用扫描、开源license合规检查、签名和完整性性校验、SBOM校验；测试发现的主要问题都得到了修正，回归测试结果正常。

1、病毒扫描：使用openlibing平台病毒扫描工具，对aarch64、x86_64架构的Everything(包含BaseOS)、EPOL所提供软件包、源码包进行病毒扫描。共计扫描53, 065个rpm包，未有病毒告警，无风险。

2、漏洞扫描：使用openlibing平台漏洞感知平台对BaseOS范围软件包进行评估。根据版本发布节奏，版本PR合入截止时间为2026/06/17，致命CVE在版本发布前仍然持续修复，CVE统计时间：2024/01/01 ~ 2026/06/14，统计范围：24.03-LTS-SPx版本。后续新增CVE在update版本修复。截至2026年6月14日，openlibing平台漏洞感知数据如下表。待办漏洞中，中低危32个，0分漏洞160个，在update版本持续修复。已挂起漏洞均为暂无解决方案或补丁，软件包维护者已确认当前版本上游暂无解决方案或补丁。

3、安全编译扫描：使用openlibing平台二进制扫描工具，对aarch64、x86_64架构的BaseOS所提供软件包进行安全编译选项（包括BIND_NOW、NX、PIE、RELRO、SP、NO Rpath/Runpath、Strip）扫描。共计扫描4, 917个rpm包，总计问题数3个，所有问题均已评估或修复，无风险。

4、安全测试基线用例：使用openscap、mugen对标准镜像进行用例测试。覆盖初始部署、安全访问、运行服务、日志审计等方面。在aarch64与x86_64上分别测试307个用例，失败项均符合 openEuler安全配置基线的openEuler发行版本说明，无遗留问题无风险。

5、安全片段引用扫描：对openEuler社区孵化软件包仓库使用openlibing平台开源合规扫描工具进行扫描。共计扫描仓库120个。待处理风险数已全部清零。当前版本平台由mujun切换至openlibing，扫描工具及规则有变动，和历史数据存在差异属于正常现象。

6、开源软件License合规检查：对于Everything (包含BaseOS)、EPOL提供的软件包，根据SBOM文件扫描License合规情况。共计扫描53, 065个rpm包，发现问题6个，已完成6个。所有问题均已完成修复或评估，无风险。已通过合规SIG评审。

7、软件包签名检查：对于Everything (包含BaseOS)、EPOL提供的软件包，使用rpm工具进行签名校验。共计验证53, 065个rpm包，均通过签名检查。

8、ISO签名及SBOM检查：版本发布后对应的ISO镜像存在sha256sum签名文件、SBOM文件、SBOM文件签名。待版本发布后检查。

openEuler-24.03-LTS-SP4 版本安全测试已完成。扫描项发现问题均已完成修复与评估, 评审遗留问题已闭环。

### 4.3.2 可靠性测试

| 测试类型   | 测试内容                                                      | Arm/X86测试结果 | RISC-V RVA20测试结果 | RISC-V RVA23 测试结果 | Loongarch 测试结果 |
| ------ | --------------------------------------------------------- | ----------- | ---------------- | ----------------- | -------------- |
| 操作系统长稳 | 系统在各种压力背景下，随机执行LTP等测试；过程中关注系统重要进程/服务、日志的运行情况；稳定性测试时长7\*24 | 通过          |                  |                   |  通过             |


### 4.3.3 性能测试


| **指标大项** | **指标小项**                                      | **指标值**    | Arm/X86测试结果                    | RISC-V RVA20 测试结果 | RISC-V RVA23 测试结果 | Loongarch 测试结果 |
| -------- | --------------------------------------------- | ---------- | ------------------------------ | ----------------- | ----------------- | -------------- |
| OS基础性能   | 进程调度子系统，内存管理子系统、进程通信子系统、系统调用、锁性能、文件子系统、网络子系统。 | 参考版本相应指标基线 | 与基线版本（24.03-LTS）对比不劣化5%以内目标已达成 |                   |                   | 与基线版本（24.03-LTS）对比性能数据上下浮动在5%范围内，测试结果属于正常               |


# 5   问题单统计

openEuler 24.03-LTS-SP4版本共发现问题410个，有效问题386个，其中遗留问题 6 个，详细分布见下表:

| 测试阶段                           | 问题总数 | 有效问题单数 | 无效问题单数 | 挂起问题单数 |     |
| ------------------------------ | ---- | ------ | ------ | ------ | --- |
| openEuler 24.03 LTS SP4  alpha | 21   | 21     | 0      | 0      |     |
| openEuler 24.03 LTS SP4  RC1   | 189  | 182    | 7      | 2      |     |
| openEuler 24.03 LTS SP4  RC2   | 46   | 44     | 2      | 1      |     |
| openEuler 24.03 LTS SP4  RC3   | 23   | 17     | 6      | 0      |     |
| openEuler 24.03 LTS SP4  RC4   | 8    | 8      | 0      | 0      |     |
| openEuler 24.03 LTS SP4  RC5   | 30   | 27     | 3      | 2      |     |
| openEuler 24.03 LTS SP4 RC6    | 61   | 58     | 3      | 0      |     |
| openEuler 24.03 LTS SP4 RC7    | 24   | 23     | 1      | 0      |     |
| openEuler 24.03 LTS SP4 RC8    | 8    | 6      | 2      | 0      |     |
| openEuler 24.03 LTS SP4 RC9    | 0    | 0      | 0      | 0      |     |



# 6 版本测试过程评估

#### 6.1 问题单分析


本次版本测试各迭代从RC1到RC9，每一轮迭代转测前问题解决率符合QA-sig制定的转测质量checklist要求。社区有效issue共计386个，新增issue总体趋势下降, 符合质量预期，风险可控

各阶段问题分析：
1.	Alpha属于开发自验证轮次，测试未提前介入，保障baseOS范围内软件包基础发布质量（无阻塞性构建失败、基础功能可运行），累计发现构建类问题16个（均为非阻塞性问题，已随迭代修复）；
2.	RC1-RC3保障everything\epol范围内软件包正常发布，发现构建和降级问题182个，新需求转测较少，发现问题3个，主要测试活动为OS通用场景和各专项测试，发现问题41个 
3.	RC4-RC6 新需求集中转测，同步开展OS通用场景及专项测试；OS通用场景和各专项测试发现问题14个，64K以及witty提供性能调优优化等新需求转测，发现新需求问题共55个。
4. RC7/RC8遗留需求验证、全量测试及问题回归，发现新需求问题3个、构建问题10个已修复，目前问题均已修复；


#### 6.2 OS集成测试迭代版本基线

| 迭代版本                            | 测试项          | 测试子项                   |     |
| ------------------------------- | ------------ | ---------------------- | --- |
| openEuler 24.03 LTS SP4 RC1     | 冒烟测试         |                        |     |
|                                 | 包管理专项        | 软件包安装卸载                |     |
|                                 |              | 自编译                    |     |
|                                 | 安全专项         |                        |     |
|                                 | 性能专项         |                        |     |
|                                 | 安装部署         | 标准镜像aarch64虚拟机         |     |
|                                 |              | 标准镜像aarch64物理机         |     |
|                                 |              | 标准镜像X86_64虚拟机          |     |
|                                 |              | 标准镜像PXE安装              |     |
|                                 |              | everything镜像PXE安装      |     |
|                                 | 单包           | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
|                                 | 版本变化检查专项     |                        |     |
|                                 |              | 软件包升降级变化分析             |     |
|                                 |              | 软件范围变化测试               |     |
|                                 | 内核专项         | 基本功能测试                 |     |
| openEuler 24.03 LTS SP4 RC2     | 冒烟测试         |                        |     |
|                                 | 包管理专项        | 软件包升级回滚                |     |
|                                 | 安全专项         |                        |     |
|                                 | 安装部署         | 标准镜像x86_64物理机          |     |
|                                 |              | 标准镜像U盘安装               |     |
|                                 |              | stratovirt镜像x86虚拟机     |     |
|                                 |              | stratovirt镜像aarch64虚拟机 |     |
|                                 |              | 边缘镜像x86虚拟机             |     |
|                                 |              | 边缘镜像aarch64虚拟机         |     |
|                                 |              | 标准镜像虚机安装兼容性            |     |
|                                 | 单包           | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
|                                 | 时延分析工具       |                        |     |
|                                 | oedeploy     |                        |     |
|                                 | 文件系统         |                        |     |
|                                 | 操作系统默认参数对比   |                        |     |
| openEuler 24.03 LTS SP4 RC3     | 冒烟测试         |                        |     |
|                                 | 包管理专项        | 软件包安装卸载                |     |
|                                 | 重启专项         | 冷重启                    |     |
|                                 |              | 热重启                    |     |
|                                 |              | 高压重启                   |     |
|                                 |              | 新增重启专项                 |     |
|                                 | 网络系统         |                        |     |
|                                 | k3s部署验证      |                        |     |
|                                 | 安全专项         |                        |     |
|                                 | 性能专项         |                        |     |
|                                 | 安装部署         |                        |     |
|                                 |              | 标准镜像aarch64物理机         |     |
|                                 |              | 标准镜像aarch64虚拟机         |     |
|                                 |              | 标准镜像X86_64虚拟机          |     |
|                                 |              | 标准镜像PXE安装              |     |
|                                 |              | everything镜像PXE安装      |     |
|                                 |              | 边缘镜像x86物理机             |     |
|                                 |              | 边缘镜像aarch64物理机         |     |
|                                 | 内核专项         | POSIX标准测试              |     |
|                                 |              | 性能测试                   |     |
|                                 |              | 安全测试                   |     |
|                                 |              | 长稳测试                   |     |
|                                 | 单包           | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
| openEuler 24.03 LTS SP4 RC4     | 冒烟测试         |                        |     |
|                                 | 包管理专项        | 软件包升级回滚                |     |
|                                 |              | 自编译                    |     |
|                                 | 安装部署         | 标准镜像x86物理机             |     |
|                                 |              | 标准镜像u盘安装               |     |
|                                 |              | stratovirt镜像x86虚拟机     |     |
|                                 |              | stratovirt镜像aarch64虚拟机 |     |
|                                 |              | 标准镜像虚机安装兼容性            |     |
|                                 | 单包           | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
| openEuler 24.03 LTS SP4 RC5     | 冒烟测试         |                        |     |
|                                 | 包管理专项        | 软件包安装卸载                |     |
|                                 |              | 软件包升级回滚                |     |
|                                 | oeaware      |                        |     |
|                                 | 安全专项         |                        |     |
|                                 | 操作系统默认参数对比   |                        |     |
|                                 | 性能专项         |                        |     |
|                                 | 版本变化检查专项     |                        |     |
|                                 |              | 软件包升降级变化分析             |     |
|                                 |              | 软件范围变化测试               |     |
|                                 | 单包           | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
|                                 | 内核专项         | 基本功能测试                 |     |
| openEuler 24.03 LTS SP4 RC5-64K | 安装部署         | 标准镜像aarch64物理机         |     |
|                                 |              | 标准镜像aarch64虚拟机         |     |
|                                 |              | 标准镜像PXE安装              |     |
|                                 |              | 边缘镜像aarch64虚拟机         |     |
|                                 | 内核专项         | 基本功能测试                 |     |
|                                 |              | POSIX标准测试              |     |
|                                 |              | 性能测试                   |     |
|                                 |              | 安全测试                   |     |
|                                 | 包管理专项        | 软件包安装卸载                |     |
| openEuler 24.03 LTS SP4 RC6     | 冒烟测试         |                        |     |
|                                 | 包管理专项        | 增量                     |     |
|                                 |              | 软件包安装卸载                |     |
|                                 | CPU 故障注入     |                        |     |
|                                 | 时延分析工具       |                        |     |
|                                 | aops         |                        |     |
|                                 | oedeploy     |                        |     |
|                                 | 安全专项         |                        |     |
|                                 | 安装部署         | 标准镜像aarch64物理机         |     |
|                                 |              | 标准镜像aarch64虚拟机         |     |
|                                 |              | 标准镜像x86_64虚拟机          |     |
|                                 |              | 标准镜像PXE安装              |     |
|                                 |              | everything镜像PXE安装      |     |
|                                 |              | stratovirt镜像x86虚拟机     |     |
|                                 |              | stratovirt镜像aarch64虚拟机 |     |
|                                 |              | 边缘镜像x86虚拟机             |     |
|                                 |              | 边缘镜像aarch64虚拟机         |     |
|                                 |              | 标准镜像虚机安装兼容性            |     |
|                                 | 单包           |                        |     |
|                                 |              | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
|                                 | 内核专项         |                        |     |
|                                 |              | 长稳测试                   |     |
| openEuler 24.03 LTS SP4 RC6-64K | 安装部署         | 标准镜像u盘安装               |     |
|                                 |              | everything镜像PXE安装      |     |
|                                 |              | 边缘镜像aarch64物理机         |     |
|                                 | 包管理专项        | 软件包升级回滚                |     |
|                                 | 单包           |                        |     |
|                                 |              | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
|                                 | 文件系统         |                        |     |
|                                 | 网络系统         |                        |     |
| openEuler 24.03 LTS SP4 RC7     | 冒烟测试         |                        |     |
|                                 | 安装部署         | 标准镜像x86物理机             |     |
|                                 |              | 标准镜像u盘安装               |     |
|                                 |              | 边缘镜像x86物理机             |     |
|                                 |              | 边缘镜像aarch64物理机         |     |
|                                 | 内核专项         |                        |     |
|                                 |              | POSIX标准测试              |     |
|                                 |              | 性能测试                   |     |
|                                 |              | 安全测试                   |     |
|                                 | 包管理专项        | 软件包升级回滚                |     |
|                                 |              | 自编译                    |     |
|                                 | 单包           |                        |     |
|                                 |              | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
|                                 | powerapi     |                        |     |
|                                 | eagle        |                        |     |
|                                 | k3s部署验证      |                        |     |
|                                 | 安全专项         |                        |     |
|                                 | 操作系统默认参数对比   |                        |     |
| openEuler 24.03 LTS SP4 RC7-64K | 安装部署         | 标准镜像虚机安装兼容性            |     |
|                                 | 内核专项         | 长稳测试                   |     |
|                                 | 重启专项         | 冷重启                    |     |
|                                 |              | 热重启                    |     |
|                                 |              | 高压重启                   |     |
|                                 |              | 新增重启专项                 |     |
| openEuler 24.03 LTS SP4 RC8     | 冒烟测试         |                        |     |
|                                 | 安装部署         | 标准镜像aarch64物理机         |     |
|                                 |              | 标准镜像PXE安装              |     |
|                                 |              | everything镜像PXE安装      |     |
|                                 | 内核专项         | 基本功能                   |     |
|                                 |              | 长稳测试                   |     |
|                                 | 包管理专项        | 软件包安装卸载                |     |
|                                 |              | 软件包升级回滚                |     |
|                                 | 单包           |                        |     |
|                                 |              | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
|                                 | oeaware      |                        |     |
|                                 | 文件系统         |                        |     |
|                                 | 网络系统         |                        |     |
|                                 | 重启专项         | 冷重启                    |     |
|                                 |              | 热重启                    |     |
|                                 |              | 高压重启                   |     |
|                                 |              | 新增重启专项                 |     |
|                                 | 安全专项         |                        |     |
|                                 | 性能专项         |                        |     |
|                                 | 操作系统默认参数对比   |                        |     |
|                                 | 版本变化检查专项     |                        |     |
|                                 |              | 软件包升降级变化分析             |     |
|                                 |              | 软件范围变化测试               |     |
|                                 | 多动态库检查       |                        |     |
| openEuler 24.03 LTS SP4 RC9     | 冒烟测试         |                        |     |
|                                 | 安装部署         | 标准镜像aarch64虚拟机         |     |
|                                 |              | 标准镜像x86_64物理机          |     |
|                                 |              | 标准镜像x86_64虚拟机          |     |
|                                 |              | 标准镜像u盘安装               |     |
|                                 |              | stratovirt镜像x86虚拟机     |     |
|                                 |              | stratovirt镜像aarch64虚拟机 |     |
|                                 |              | 标准镜像虚机安装兼容性            |     |
|                                 | 内核专项         | 基本功能                   |     |
|                                 |              | 长稳测试                   |     |
|                                 | 包管理专项        | 软件包安装卸载                |     |
|                                 |              | 软件包升级回滚                |     |
|                                 | 单包           |                        |     |
|                                 |              | 单包命令                   |     |
|                                 |              | 单包服务                   |     |
|                                 | 回归测试         | 问题单回归                  |     |
| openEuler 24.03 LTS SP4 release |              |                        |     |
|                                 | release发布件测试 | release发布件测试           |     |
|                                 | 发布件sha256值校验 | 发布件sha256值校验           |     |
|                                 | SBOM文件签名     |                        |     |
|                                 | RPM包签名       |                        |     |




# 7   附件

## 遗留问题列表

| 序号  | 问题单号                                                                  | 问题简述                                                                                                  | 问题级别 | 影响分析                                                                              | 规避措施               |
| --- | --------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ---- | --------------------------------------------------------------------------------- | ------------------ |
| 1   | [188](https://atomgit.com/src-openeuler/kiran-desktop/issues/188)     | [openEuler 24.03 sp4][kiran][loongarch64]点击下方任务栏中的帮助，界面弹窗“无法显示帮助文档mate-user-guide                     | 次要   | 用户进入kiran桌面环境后，在任务栏中打不开帮助文档，可使用外部桌面文档平替解决                                         | 后续通过增加/升级源中软件包解决   |
| 2   | [29](https://gitcode.com/src-openeuler/dde-control-center/issues/29)  | [openEuler 24.03 sp4][DDE][loongarch64]设置-个性化，通用模块中，主题和窗口功能模块设置后不生效                                   | 次要   | 用户使用DDE桌面环境，主题和窗口模块无法更换成其余样式，不影响用户的主要使用，非重要问题                                     | 等待DDE团队修复          |
| 3   | [31](https://gitcode.com/src-openeuler/dde-control-center/issues/31)  | [openEuler 24.03 sp4][DDE][loongarch64]设置-个性化，字体模块中的字号修改后，系统中字体大小不会随之更改                               | 次要   | 系统中字体不会随着字号修改而随之变换，不影响用户使用的主体功能                                                   | 等待DDE团队修复          |
| 4   | [17](https://gitcode.com/src-openeuler/dde-session-ui/issues/17)      | [openEuler 24.03 sp4][DDE][loongarch64]设置-账户，登录选项模块中的快速登录、自动登录、免密登录开关按钮均无法正常启用                        | 次要   | 用户界面设置账户时，无法设置快速登录、自动登录、免密登录等，平时用终端可以代替解决                                         | 等待DDE团队修复          |
| 5   | [30](https://gitcode.com/src-openeuler/dde-control-center/issues/30 ) | [openEuler 24.03 sp4][DDE][loongarch64]设置-个性化，图标主题设置后，效果不生效                                           | 次要   | 用户更换图标主题不生效，不影响用户正常使用DDE桌面                                                        | 等待DDE团队修复          |
| 6   | [47](https://atomgit.com/src-openeuler/KubeOS/issues/47)              | 【24.03-LTS-SP4】执行KubeOS相关的继承用例的时候，arm架构出现批量的用例等待升级/重启/配置超时、检查日志超时、节点删除后osinstance删除有延时、增加label报错重试等现象 | 次要   | 失败用例主要是因为等待升级/配置时间超出设定时间时出现超时现象，但升级/配置执行等功能正常，可通过增加KubeOS升级/配置的等待时间来解决，一般场景不影响功能。 | 增加KubeOS升级/配置的等待时间 |




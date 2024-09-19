![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者   |
| ---------- | ----------- | -------- | ------ |
| 2024-09-19 | v1.0        | 初稿     | 何歆玥 |
|            |             |          |        |

关键词： 
KubeOS 串行 时间窗 时间间隔 集群OS多版本

摘要：
24年建行云All in云原生，实现金融级云原生操作系统全栈能力，改善云底运维人工介入多，OS升级时间长等运维痛点，基于KubeOS统一运维框架功能，提供灵活、多维度的运维策略，满足用户定时、串行、集群OS多版本等多种场景下运维需求。本文主要叙述测试覆盖情况，并通过问题分析对该功能特性整体质量进行评估和总结。

# 1     特性概述

KubeOS是针对云原生场景而设计、轻量安全的云原生操作系统及运维工具，提供基于kubernetes的云原生操作系统统一运维能力。KubeOS设计了专为容器运行的云原生操作系统，通过根目录只读，仅包含容器运行所需组件，dm-verity安全加固，减少漏洞和攻击面，提升资源利用率和启动速度，提供云原化的、轻量安全的操作系统。KubeOS支持使用kubernetes原生声明式API，统一对集群worker节点OS的进行升级、配置和运维，从而降低云原生场景的运维难度、解决用户集群节点OS版本分裂，缺乏统一的OS运维管理方案的问题。 

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，不涉及硬件依赖。

| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| openEuler-24.09 RC3 | 2024-08-29   | 2024-09-04   |
| openEuler-24.09 RC4 | 2024-09-05   | 2024-09-11   |
| openEuler-24.09 RC5 | 2024-09-12   | 2024-09-18   |



# 3     测试结论概述

## 3.1   测试整体结论

KubeOS支持串并行升级策略、状态更新等声明式API特性，共计执行40个用例（33个继承用例+7个新增用例），主要覆盖了继承用例测试、新增功能和参数测试，发现问题已解决，回归通过，无遗留风险，整体质量良好。

| 测试活动     | 测试子项   | 活动评价                                 |
| ------------ | ---------- | ---------------------------------------- |
| 继承特性测试 | 功能测试   | 发现问题已解决，回归通过，无遗留风险     |
| 继承特性测试 | 场景测试   | 未发现问题，无遗留风险                   |
| 继承特性测试 | 可靠性测试 | 未发现问题，无遗留风险                   |
| 继承特性测试 | 安全测试   | 未发现问题，无遗留风险                   |
| 继承特性测试 | 性能测试   | 未发现问题，无遗留风险                   |
| 新增特性测试 | 功能测试   | 新增参数均已覆盖，未发现功能问题         |
| 兼容性测试   |            | 和历史版本不兼容，资料中已有约束，不涉及 |
| 资料测试     |            | 检视意见已解决，无遗留风险               |

## 3.2   约束说明

1. 公共约束
   1. 仅支持虚拟机x86和arm64 UEFI场景。
   2. 使用kubectl apply通过YAML创建或更新OS的CR时，不建议并发apply，当并发请求过多时，kube-apiserver会无法处理请求导致失败。
      1. 如用户配置了容器镜像仓的证书或密钥，请用户保证证书或密钥文件的权限最小。
      2. 本次新增支持串并行升级策略、状态更新等声明式API之后的KubeOS和历史版本不兼容 。
2. 升级约束
   1. 升级为所有软件包原子升级，默认不提供单包升级能力。
   2. 升级为双区升级的方式，不支持更多分区数量。
   3. 当前暂不支持跨大版本升级。
   4. 单节点的升级过程的日志可在节点的 /var/log/messages 文件查看。
   5. 请严格按照提供的升级和回退流程进行操作，异常调用顺序可能会导致系统无法升级或回退。
   6. 节点上containerd如需配置ctr使用的私有镜像，请将配置文件host.toml按照ctr指导放在/etc/containerd/certs.d目录下。
   7. 使用docker镜像升级和mtls双向认证仅支持 openEuler 22.09 及之后的版本
3. 配置约束
   1. 用户自行指定配置内容，用户需保证配置内容安全可靠 ，尤其是持久化配置（kernel.sysctl.persist、grub.cmdline.current、grub.cmdline.next），KubeOS不对参数有效性进行检验。
   2. opstype=config时，若osversion与当前集群节点的OS版本不一致，配置不会进行。
   3. 当前仅支持kernel参数临时配置（kernel.sysctl）、持久化配置（kernel.sysctl.persist）和grub cmdline配置（grub.cmdline.current和grub.cmdline.next）。
   4. 持久化配置会写入persist持久化分区，升级重启后配置保留；kernel参数临时配置重启后不保留。
   5. 配置grub.cmdline.current或grub.cmdline.next时，如为单个参数（非key=value格式参数），请指定key为该参数，value为空。
   6. 进行配置删除（operation=delete）时，key=value形式的配置需保证key、value和实际配置一致。
   7. 配置不支持回退，如需回退，请修改配置版本和配置内容，重新下发配置。
   8. 配置出现错误，节点状态陷入config时，请将配置版本恢复成上一版本并重新下发配置，从而使节点恢复至idel状态。 但是请注意：出现错误前已经配置完成的参数无法恢复。
   9. 在配置grub.cmdline.current或grub.cmdline.next时，若需要将已存在的“key=value”格式的参数更新为只有key无value格式，比如将“rd.info=0”更新成rd.info，需要先删除“key=value”，然后在下一次配置时，添加key。不支持直接更新或者更新删除动作在同一次完成。

## 3.3   遗留问题分析

不涉及遗留问题

# 4 详细测试结论

## 4.1 继承特性测试

### 4.1.1 功能测试结论

1. 覆盖以下19项配置测试，包含升级、回退、配置的正向配置功能，以及配置缺失、配置为空、重复配置、配置类型错误、配置无效等负向功能测试：Imagetype、opstype、osversion、maxunavailable、containerimage、imageurl、checksum、flagSafe、evictpodforce、sysconfigs、upgradeconfigs、version、configs、model、configpath、contents、key、value、operation
2. 覆盖升级前/回退前、升级后/回退后配置失败的负向流程测试，关注重试机制以及流程恢复；
3. 覆盖新节点加入集群后的自动升级/配置功能，包括全新节点、删除后重新加入的节点；
4. 覆盖基于crictl、ctr两种方式搭建的k8s集群。

### 4.1.2 场景测试结论

​	覆盖多节点集群端到端的升级、回退主流程测试，包含升级前/回退前配置、升级后/回退后配置，升级镜像类型覆盖容器镜像、磁盘镜像。

​	测试过程中，通过kubectl get命令关注node状态和节点osinstance状态变化，关注日志信息，关注配置版本的更新和配置的生效。

### 4.1.3 可靠性测试

​	覆盖以下可靠性场景，关注故障发生时operator、os-agent的重试机制以及相关日志记录，关注故障恢复后升级/回退能否成功：

1. 覆盖persist分区磁盘满场景下的升级、回退（KubeOS节点镜像文件系统结构特殊，persist分区无法构造只读，只能覆盖磁盘满场景）；
   1. 覆盖升级、回退掉电测试；
      1. 覆盖升级时节点os-agent服务重启的异常场景；
      2. os-agent服务反复restart、kill。

### 4.1.4 安全测试

1. 覆盖非root用户下发升级/回退/config操作；
2. 覆盖os-agent服务非root用户操作。

### 4.1.5 性能测试

​	通过ps检查/proxy进程和/usr/bin/os-agent进程的内存底噪，覆盖X86_64、ARM64，覆盖初始化、升级中、升级后三种状态，确保os-agent底噪不超过10M，os-agent和proxy的底噪总和不超过20M。 

## 4.2 新增特性测试

1. 覆盖以下4项API接口参数测试，包含升级、回退、配置的正向配置功能，以及配置缺失、配置为空、重复配置、配置类型错误、配置无效等负向功能测试：时间窗timewindow (包括starttime和endtime)、时间间隔timeinterval、串并行策略executionmode、集群OS多版本nodeselector
2. 覆盖新增参数的组合测试：
   1. executionmode和timeinterval配置组合；
   2. timewindow和timeinterval配置组合 。
3. 覆盖指定label分批定时串行间隔升级、回退（含config）主流程场景测试 ；
4. 覆盖串行失败场景，验证流程的阻塞及恢复。

## 4.3 资料测试

资料PR链接：https://gitee.com/openeuler/docs/pulls/14063/files

检视意见均已闭环，新增约束描述准确，新增参数规格描述完整准确，无遗留问题。

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称                     | 测试用例数 | 用例执行结果                       | 发现问题单数 | 对应issue                                                    |
| ---------------------------- | ---------- | ---------------------------------- | ------------ | ------------------------------------------------------------ |
| openEuler-24.09 RC3  ARM+X86 | 40         | 38 PASS + 2 FAIL                   | 1            | [IANSZA](https://gitee.com/src-openeuler/KubeOS/issues/IANSZA) |
| openEuler-24.09 RC4 ARM+X86  | 40         | ARM：40 PASS <br>X86：镜像裁剪失败 | 1            | [IAQW84](https://gitee.com/src-openeuler/KubeOS/issues/IAQW84) |
| openEuler-24.09 RC5 ARM+X86  | 40         | 40 PASS                            | 0            | 不涉及                                                       |

 



 

 
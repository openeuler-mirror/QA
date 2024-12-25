![avatar](../../images/openEuler.png)


版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者   |
| ---------- | ----------- | -------- | ------ |
| 2024-12-25 | v1.0        | 初稿     | 赵鹏 |
|            |             |          |        |

关键词： 
KubeOS 集群配置 镜像制作 静态完整性保护

摘要：
24年建行All in云原生，联合openEuler KubeOS团队打造金融级云原生操作系统，构筑金融行业首个金融级系统安全、云原生统一运维，性能与资源利用率4倍+提升的云原生操作系统，逐步改善现有云底座维护敏捷性不足、云底座服务响应慢等业务痛点问题，加速全栈创新提升竞争力，引领行业创新。在KubeOS统一运维框架的统一运维管理能力和镜像制作能力的基础上：增强云原生统一配置能力，支持节点containerd、kubelet等集群组件参数统一配置能力，提供支持定制化功能的镜像制作工具协助建行打造自主可控的云原生OS，增加启动完整性校验等需求。本文主要叙述测试覆盖情况，并通过问题分析对该功能特性整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

KubeOS是针对云原生场景而设计、轻量安全的云原生操作系统及运维工具，提供基于kubernetes的云原生操作系统统一运维能力，支持使用kubernetes原生声明式API，统一对集群worker节点OS的进行升级、配置和运维。本次特性在KubeOS特性的基础上：增强云原生统一配置能力，支持节点containerd、kubelet等集群组件参数统一配置能力；提供支持定制化功能的镜像制作工具协助建行打造自主可控的云原生OS；增加启动完整性校验，确保基础设施可信不可变。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，不涉及硬件依赖。

| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP1 RC3 | 2024-11-29   | 2024-12-05   |
| openEuler-24.03-LTS-SP1 RC4 | 2024-12-06   | 2024-12-14   |
| openEuler-24.03-LTS-SP1 RC5 | 2024-12-16   | 2024-12-25   |


# 3     测试结论概述

## 3.1   测试整体结论

KubeOS支持集群参数统一配置、镜像定制化和静态完整性保护dm-verity特性，共计执行49个用例（33个继承用例+16个新增用例），主要覆盖了继承用例测试、新增功能、集群配置、镜像制作参数测试，回归通过，无遗留风险，整体质量良好。

| 测试活动     | 测试子项   | 活动评价                                 |
| ------------ | ---------- | ---------------------------------------- |
| 继承特性测试 | 功能测试   | 发现问题已解决，回归通过，无遗留风险     |
| 继承特性测试 | 场景测试   | 未发现问题，无遗留风险                   |
| 继承特性测试 | 可靠性测试 | 未发现问题，无遗留风险                   |
| 继承特性测试 | 安全测试   | 未发现问题，无遗留风险                   |
| 继承特性测试 | 性能测试   | 未发现问题，无遗留风险                   |
| 新增特性测试 | 功能测试   | 发现问题已解决，回归通过，无遗留风险           |
| 新增特性测试 | 集群配置测试   | 发现问题已解决，回归通过，无遗留风险        |
| 新增特性测试 | 镜像制作参数测试   |  发现问题已解决，回归通过，无遗留风险        |
| 兼容性测试   |            | 和历史版本不兼容，资料中已有约束，不涉及 |
| 资料测试     |            | 检视意见已解决，无遗留风险               |

## 3.2   约束说明

1. 公共约束
   1. 仅支持虚拟机x86和arm64 UEFI场景。
   2. 使用kubectl apply通过YAML创建或更新OS的CR时，不建议并发apply，当并发请求过多时，kube-apiserver会无法处理请求导致失败。
     3. 如用户配置了容器镜像仓的证书或密钥，请用户保证证书或密钥文件的权限最小。
  2. 升级约束
       1. 升级为所有软件包原子升级，默认不提供单包升级能力。
       2. 升级为双区升级的方式，不支持更多分区数量。
       3. 当前暂不支持跨大版本升级。
       4. 单节点的升级过程的日志可在节点的 /var/log/messages 文件查看。
       5. 请严格按照提供的升级和回退流程进行操作，异常调用顺序可能会导致系统无法升级或回退。
       6. 节点上containerd如需配置ctr使用的私有镜像，请将配置文件host.toml按照ctr指导放在/etc/containerd/certs.d目录下。
       7. 使用docker镜像升级和mtls双向认证仅支持 openEuler 22.09 及之后的版本
       8. nodeselector、executionmode、timewindow和timeinterval 仅支持openEuler 24.09及之后版本。
       9. KubeOS 24.03-LTS-SP1 版本与历史版本不兼容。（本次新增约束）
       10. 使用从http/https服务器下载升级镜像功能需要同步使用对应版本镜像制作工具（本次新增约束）
  3. 配置约束
       1. 用户自行指定配置内容，用户需保证配置内容安全可靠 ，尤其是持久化配置（kernel.sysctl.persist、grub.cmdline.current、grub.cmdline.next、kubernetes.kubelet、container.containerd、pam.limits），KubeOS不对参数有效性进行检验。
       2. opstype=config时，若osversion与当前集群节点的OS版本不一致，配置不会进行。
       3. 当前仅支持kernel参数临时配置（kernel.sysctl）、持久化配置（kernel.sysctl.persist）和grub cmdline配置（grub.cmdline.current和grub.cmdline.next）、kubelet配置（kubernetes.kubelet）、containerd配置（container.containerd）和pam limits配置（pam.limits）。
       4. 持久化配置会写入persist持久化分区，升级重启后配置保留；kernel参数临时配置重启后不保留。
       5. 配置grub.cmdline.current或grub.cmdline.next时，如为单个参数（非key=value格式参数），请指定key为该参数，value为空。
       6. 进行配置删除（operation=delete）时，key=value形式的配置需保证key、value和实际配置一致。
       7. 配置不支持回退，如需回退，请修改配置版本和配置内容，重新下发配置。
       8. 配置出现错误，节点状态陷入config时，请将配置版本恢复成上一版本并重新下发配置，从而使节点恢复至idle状态。 但是请注意：出现错误前已经配置完成的参数无法恢复。
       9. 在配置grub.cmdline.current或grub.cmdline.next时，若需要将已存在的“key=value”格式的参数更新为只有key无value格式，比如将“rd.info=0”更新成rd.info，需要先删除“key=value”，然后在下一次配置时，添加key。不支持直接更新或者更新删除动作在同一次完成。

## 3.3   遗留问题分析

不涉及遗留问题

# 4 详细测试结论

## 4.1 继承特性测试
### 4.1.1 功能测试结论

1. 覆盖以下23项配置测试，包含升级、回退、配置的正向配置功能，以及配置缺失、配置为空、重复配置、配置类型错误、配置无效等负向功能测试：Imagetype、opstype、osversion、maxunavailable、containerimage、imageurl、checksum、flagSafe、evictpodforce、sysconfigs、upgradeconfigs、version、configs、model、configpath、contents、key、value、operation、nodeselector、executionmode、timewindow和timeinterval 
2. 覆盖升级前/回退前、升级后/回退后配置失败的负向流程测试，关注重试机制以及流程恢复；
3. 覆盖新节点加入集群后的自动升级/配置功能，包括全新节点、删除后重新加入的节点；
4. 覆盖基于crictl、ctr两种方式搭建的k8s集群。

### 4.1.2 场景测试结论

​	覆盖多节点集群端到端的升级、回退主流程测试，包含升级前/回退前配置、升级后/回退后配置、指定label分批定时串行间隔升级、回退（含config），升级镜像类型覆盖容器镜像、磁盘镜像。

​	测试过程中，通过kubectl get命令关注node状态和节点osinstance状态变化，关注日志信息，关注配置版本的更新和配置的生效。


### 4.1.3 可靠性测试

​	覆盖以下可靠性场景，关注故障发生时operator、os-agent的重试机制以及相关日志记录，关注故障恢复后升级/回退能否成功：

 	1. 覆盖persist分区磁盘满场景下的升级、回退（KubeOS节点镜像文件系统结构特殊，persist分区无法构造只读，只能覆盖磁盘满场景）；
 	2. 覆盖升级、回退掉电测试；串行升级失败测试；
 	3. 覆盖升级时节点os-agent服务重启的异常场景；
 	4. os-agent服务反复restart、kill。

### 4.1.4 安全测试

1. 覆盖非root用户下发升级/回退/config操作；
2. 覆盖os-agent服务非root用户操作。

### 4.1.5 性能测试

​	通过ps检查/proxy进程和/usr/bin/os-agent进程的内存底噪，覆盖X86_64、ARM64，覆盖初始化、升级中、升级后三种状态，确保os-agent底噪不超过10M，os-agent和proxy的底噪总和不超过20M。 

## 4.2 新增特性测试

1. 覆盖以下场景的升级、回退、配置功能：普通虚拟机镜像、pxe物理机/虚拟机镜像、开启dm_verity+安全启动的虚拟机镜像场景；
2. 覆盖以下3项集群参数配置测试，包含升级、回退、配置的正向配置功能，以及配置为空、配置无效等负向功能测试：pam.limits、kubernetes.kubelet、container.containerd；
3. 覆盖镜像制作测试，包括制作普通虚拟机镜像、开启dm_verity镜像、 pxe镜像、升级磁盘镜像、升级容器镜像、admin容器镜像，包括镜像制作参数的异常参数测试；

## 4.3 资料测试

资料PR链接：https://gitee.com/openeuler/docs/pulls/14293/files

检视意见均已闭环，新增约束描述准确，新增参数规格描述完整准确，无遗留问题。

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称                     | 测试用例数 | 用例执行结果                       | 发现问题单数 | 对应issue                                                    |
| ---------------------------- | ---------- | ---------------------------------- | ------------ | ------------------------------------------------------------ |
| openEuler-24.03-LTS-SP1 RC3  ARM+X86 |      36    | 3 FAIL                   | 3           | [IB8TSE](https://gitee.com/src-openeuler/KubeOS/issues/IB8TSE?from=project-issue) <br> [IB8UDV](https://gitee.com/src-openeuler/KubeOS/issues/IB8UDV?from=project-issue) <br> [IB9EM9](https://gitee.com/src-openeuler/KubeOS/issues/IB9EM9?from=project-issue) |
| openEuler-24.03-LTS-SP1 RC4 ARM+X86  | 49         | 4 FAIL  | 6            | [IB9RUF](https://gitee.com/src-openeuler/KubeOS/issues/IB9RUF?from=project-issue) <br> [IBALNI](https://gitee.com/src-openeuler/KubeOS/issues/IBALNI?from=project-issue) <br> [IBALTA](https://gitee.com/src-openeuler/KubeOS/issues/IBALTA?from=project-issue) <br> [IBALZL](https://gitee.com/src-openeuler/KubeOS/issues/IBALZL?from=project-issue) <br>[IBAYW8](https://gitee.com/src-openeuler/KubeOS/issues/IBAYW8?from=project-issue)<br> [IBBW8P](https://gitee.com/src-openeuler/KubeOS/issues/IBBW8P?from=project-issue)|
| openEuler-24.03-LTS-SP1 RC5 ARM+X86  |  49        | 49 PASS                            | 0        |                         不涉及                            |
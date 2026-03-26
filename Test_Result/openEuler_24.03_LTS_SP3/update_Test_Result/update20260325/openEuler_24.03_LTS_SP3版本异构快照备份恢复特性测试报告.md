![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026-3-18     |   V1.0          | openEuler_24.03_LTS_SP3版本异构快照备份恢复特性测试报告-CRIU支持NPU设备dump/restore         | 顾梦辰     |
|      |             |          |      |

关键词： 容器快照、快照恢复、推理服务、openEuler

摘要：本报告描述了对openEuler社区异构快照备份恢复特性的测试结果，重点验证了新增支持NPU设备dump/restore功能以及功能可靠性。该特性新增自研工具grus，并对开源criu进行商用加固。grus使用 CRIU等状态导出工具，实现容器粒度的状态checkpoint，同时新增k8s使用场景，实现容器快照与k8s生态无感对接，提供高性能、高可靠的容器快照能力；因测试环境限制，使用纯cpu的vllm推理服务模拟NPU的推理商用场景进行测试。本次测试未发现问题。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|  criu      |   stands for Checkpoint and Restore in Userspace       |     进程热迁移工具     |

# 1     特性概述

该特性通过grus使用criu等状态导出工具，实现容器粒度的状态checkpoint，同时实现容器快照与k8s生态无感对接，提供高性能、高可靠的容器快照能力。

grus是容器快照引擎项目，旨在实现容器快照与K8s生态无感对接，并提供高性能、高可靠的容器快照能力。
兼容CRI API规范的checkpoint接口。
通过grus-agent兼容OCI runtime规范，实现restore无感对接。
提供高性能、完整的容器 rw 层数据导入导出能力。该项目提供一个rpm包，包含两个二进制和一个service文件：
1. 二进制grus：由systemd管理的常驻进程 ，提供容器快照checkpoint功能，以及日志和restore流程的日志目录的管理能力。
2. 二进制grus-agent：checkpoint/restore操作时，瞬时执行的程序，完全符合OCI runtime规范的标准运行时，目前实现runc的对接。
3. grus.service文件：systemd配置文件。

criu是一个为Linux实现检查点/恢复功能的开源项目，全称Checkpoint/Restore In Userspace。通过此工具，可以冻结正在运行的应用程序（或其部分组件），并将其作为文件集合检查点化（checkpoint）存入硬盘，随后可通过这些文件从冻结点恢复并运行应用程序。基于开源criu软件包在特定场景下进行了开源加固和能力增强，该项目提供一个rpm包，包含一个二进制和一个so文件：
1. 二进制criu：提供容器快照dump/restore的底层能力，对容器进程涉及的资源进行转储和恢复。
2. npu_plugin.so：通过criu的plugin机制，对接npu设备资源（文件句柄、vma、SHM等），实现NPU设备资源的导入导出功能。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP3-update20260325	         | 2026-3-9             | 2026-3-17             |
|          |              |              |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  TaiShan 200 (Model 2280)        |     典型配置         |  NA    |
|          |              |      |

# 3     测试结论概述

## 3.1   测试整体结论

该特性共计执行18个用例，主要覆盖了功能测试、接口测试、可靠可用测试和性能测试，无遗留风险，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 |  通过    |
| 功能测试 | 新增特性测试 |  通过    |
| 兼容性测试 |          |   NA    |
| DFX专项测试 | 性能测试 |   通过   |
| DFX专项测试 | 可靠性/韧性测试 | 通过|
| DFX专项测试 | 安全测试 |   NA   |
| 其他测试 |         |         |

## 3.2   约束说明

Grus关键约束包括：功能约束checkpoint&restore共同约束

    1./var/log/grus-agent.log：最大长度限制为1MB，最多支持2个文件（分别为grus-agent.log/grus-agent.log.1），超过时覆盖grus-agent.log.1文件；
    2./var/log/grus-agent.log，如果并发失败时，同时写入存在日志丢失和复写风险（由于只有极少的错误流程才会写入该文件，正常流程不会写入）；
    3.checkpoint的容器的容器镜像和restore的容器的容器镜像，必须保持一致；
    4.容器rw层快照的tar包，由管理面统一管理，不做篡改校验；
    5.grus命令行参数指定多个相同参数时，最后一个合法的值被解析，前面的值被覆盖；
    6.商用不支持Host网络模式的容器恢复，仅作为原地恢复场景的调试测试使用（容器迁移恢复场景可能会失败，由于socket快照会包含IP信息，且主机侧的网络相关配置无法迁移，导致恢复失败）。
    7.仅商用支持推理场景，技术栈要求为“K8s + Containerd + runc + MindIE + CANN”，其他推理框架或者管理组件需要新需求跟踪;
    8.在criu/grus rpm包升级期间，不能执行checkpoint和restore操作

Checkpoint功能约束：

    1.grus的checkpoint接口的timeout参数，只用于控制返回给客户端的请求超时，无法结束已经运行的checkpoint底层操作。因此，如果超时返回，需要用户自行检查容器状态，并做好状态清理恢复。
    2.使用特权容器镜像制作快照的场景，特权容器镜像和主机使用相同的rpm源，相关软件版本必须一致
    3.异常场景约束：checkpoint卡住或者错误退出时，存在如下问题：
    1) 生成的快照可能有问题，需要管理面清理；
    2）卡住时，需要管理组件介入故障清理；
    3） 超时退出时，grus会中断操作，但是criu进程可能D状态无法清理，存在进程残留风险；（返回特殊的错误信息即可，由管理面进行风险上报进行自动重启或者人工介入。）
restore功能约束：

    1.容器rootfs diff数据不超过1GB（防止误操作，例如保留了大量的无用日志文件））
    2./var/run/grus/restore：默认最多缓存128个restore日志目录；用户可通过GRUS_MAX_RESTORE_DIRS环境变量修改，最小数量不小于8，最大数量不大于4096(由于周期性排查，存在短时间超过阈值的可能性)；
    3.只支持恢复的容器网络设置为ipv4，不支持ipv6
    4.并发约束：资料约束单节点同时不超过8个容器（在grus侧未做限制）；criu并发度受pthread限制以及cgroup限制，因此，单节点同时恢复多个推理容器时，需要判断pthread和cgroup对进程的限制，如果超过会导致恢复容器失败;

兼容性约束容器引擎约束：

1. 只支持containerd容器引擎，且要求1.6版本及以上，建议1.6版本；
3. 仅支持Cgroup V1；
4. 只支持“K8s + containerd”的场景。命令行客户端ctr等场景，只作为测试联调使用。
5. 镜像文件系统只支持overlayfs（containerd.DefaultSnapshotter）。
6. 必须支持SnapshotService服务。
7. 必须支持Stat/View/Remove/Mounts等规范接口。
8. checkpoint目标容器，仅支持default和k8s.io namespace的容器。
9. checkpoint容器时，不允许对目标容器进行其他影响容器状态的操作，如kill/stop/pause/resume/delete/exec等。
10. restore的容器形态和配置，需要和checkpoint的容器保持一致。如不同运行时、不同场景ctr命令启动的容器做快照，用于K8s场景restore等等。
11. 快照节点和恢复节点的环境完全一致，软件栈版本必须完全一致（二进制，so的build-id相同）

OCI运行时约束：
1. 只支持OCI运行时：runc ,且要求runc 1.1版本及以上，建议1.1.8版本。
2. 支持--root参数。
3. checkpoint/pause/resume/state/restore子命令支持参数。
4. 必须支持通用参数：--log/--log-format/--root/。
5. restore子命令必须支持参数：--image-path/--work-path/--detach/--bundle/--pid-file/--tcp-established/--ext-unix-sk/--shell-job/--file-locks。
6. checkpoint子命令必须支持参数：--image-path/--work-path/--leave-running/--tcp-established/--shell-job/--ext-unix-sk/--file-locks。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- | 
|     |    无     |        |         |         |         |            |


# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1 |grus-agent | <font color=green>■</font> | 日志功能正常 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1|grus | <font color=green>■</font> |   新增对推理容器vllm发起checkpoint、restore场景；新增在特权容器中对推理容器发起checkpoint请求场景|
| 2|criu|<font color=green>■</font>| 质量加固，新增推理容器restore后ip可变功能场景|
|3|kubulet|    |不交付该组件，只是使用k8s集群场景|
|4| vllm|      |不交付该组件，使用vllm纯cpu推理场景测试|

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好


## 4.2 DFX专项测试结论

### 4.2.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|   在推理容器中起进程申请20G大内存后restore的恢复时间      |         |   <30s     |    通过     |

### 4.2.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|    异常场景测试      |  覆盖异常数据进行restore场景，checkpoint和restore过程中容器状态异常、grus服务异常、containerd服务异常、grus-agent异常退出、criu退出等异常可靠性场景 | 通过|
|  系统可靠性测试 |时间跳变、系统掉电等可靠性场景|通过|
| 服务可靠性测试|服务生命周期过程中构造目录所在盘故障测试场景| 通过|

## 4.4 其他测试结论
不涉及


# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|  openEuler-24.03-LTS-SP3-update20260325        |     18     |       通过       |        0      |
|          |            |              |              |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 

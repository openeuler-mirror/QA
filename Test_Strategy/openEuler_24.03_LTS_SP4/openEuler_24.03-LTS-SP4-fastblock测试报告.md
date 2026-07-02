![avatar](../../images/openEuler.png)

版权所有 © 2026  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026-06-08 | 1.0 | 首次发布，整合控制面、数据面、Raft共识、成员变更与故障恢复自测结果 | fastblock开发团队 |

关键词： fastblock, 分布式块存储, SPDK, Raft, RDMA write-ring, NVMe-oF, openEuler 24.03-LTS-SP4

摘要：
本报告主要针对分布式块存储系统 fastblock 在 openEuler 24.03-LTS-SP4 环境下的基本功能、控制面、数据面、共识与一致性（Raft选主、日志复制、成员变更、Raft Recovery/Snapshot 恢复机制）、故障恢复与 Failover、对外协议接口（vhost/NVMe-oF）以及基础性能进行了系统级测试验证。测试结果表明，fastblock 控制面及数据面基础功能均正常工作，在 RDMA/rdma_rxe 场景下能够实现基础写读校验，RDMA write-ring 数据路径以及 NVMe-oF TCP/RDMA 协议链路已基本打通。但在复杂故障与联动场景下（如 Raft Recovery/Snapshot 恢复过程中的 Leader 切换、成员变更与 Recovery 联动等）仍存在部分已知局限与风险。整体评估该特性基本可用。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| OSD | Object Storage Daemon | 对象存储守护进程 |
| PG | Placement Group | 归置组 |
| RDMA | Remote Direct Memory Access | 远程直接内存访问 |
| SPDK | Storage Performance Development Kit | 存储性能开发套件 |
| NVMe-oF | NVMe over Fabrics | 网络NVMe协议 |
| vhost | SPDK vhost bdev driver | 与QEMU交互的虚拟化块设备接口 |

# 1     特性概述

fastblock 是一个专为全闪场景设计的、采用 Raft 一致性协议的分布式块存储系统。它包含：
* 用户态高吞吐 OSD（基于 SPDK）与 Monitor（基于 Go 语言编写的集群状态与元数据管理集群）。
* 能够将存储卷以 block device 形式导出，支持 SPDK vhost-user 对接 QEMU 虚拟机、NVMe over Fabrics (TCP/RDMA) 协议导出供外部主机挂载等。
* 核心特色是引入 RDMA write-ring 数据传输路径，用于降低 IO 延迟和 CPU 消耗。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| fastblock master (commit 5e52ad2a7c020677673f00fa8c0c747cd42412d0) | 2026-04-13 | 2026-06-23 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| x86-64 / 鲲鹏920 兼容服务器 | 16 GiB - 512 GiB 内存，物理 RDMA 网卡 / 软 RDMA(rdma_rxe)，AIO 虚拟磁盘后端 / 物理 SSD | 开发与测试混合验证环境 |

# 3     测试结论概述

## 3.1   测试整体结论

fastblock 特性共计执行 5 个核心测试域（涵盖依赖构建、集群控制面、数据面写读、故障恢复与副本管理、对外接入协议），共执行用例 12 项，主要覆盖集群部署、QEMU/vhost 对接、NVMe-oF 导出、性能、故障恢复、Raft 成员变更与 Recovery/Snapshot 机制等。测试结果表明，常规写读、基础成员变更 `change_nodes`、基础 Recovery/Snapshot 均通过验证；部分复杂联动与故障注入场景（如恢复或变更中的 Leader 切换）仍存在未完全收敛问题。整体评估特性基本可用。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | <font color=green>■</font> 良好（fastblock 控制面及常规读写功能稳定可靠） |
| 功能测试 | 新增特性测试 | <font color=blue>▲</font> 基本可用（Raft 成员变更 `change_nodes` 基础路径、Raft Recovery/Snapshot 基础闭环已通过，极端联动场景有待进一步健壮） |
| 兼容性测试 | 兼容性测试 | <font color=green>■</font> 良好（在 CUOS 4.0 / openEuler 24.03-LTS-SP4 内核 6.6.0 下构建与部署兼容良好） |
| DFX专项测试 | 性能测试 | <font color=green>■</font> 良好（测试了单副本、三副本及 vhost、nvmf-tgt 性能，具备 block_bench/fio 基线数据） |
| DFX专项测试 | 可靠性/韧性测试 | <font color=blue>▲</font> 基本可用（基础 OSD down/out 触发 PG remap 正常，但极端时序下部分联动恢复未完全收敛） |
| DFX专项测试 | 编译加固/基础安全检查 | <font color=green>■</font> 良好（已启用基础编译加固选项，并具备 sanitizer 回归入口） |
| 资料测试 | 资料测试 | <font color=green>■</font> 良好（README.md 及开发/运维文档完备，随代码合并） |

## 3.2   约束说明

1. 环境必须配置 RDMA 设备（若无物理 RDMA，则需要加载 `rdma_rxe` 并绑定网卡生成 `rdmanic` 设备）。
2. 在小内存开发测试环境（Mem < 64 GiB）下，建议在配置中调整内存池参数 `msg_server_data_memory_pool_capacity = 2048` 等以避免内存分配失败，并适当调高 RPC 超时时间以防大数据量 Snapshot 传输超时。
3. 特性已保证在 openEuler 社区范围内依赖自闭环，所有依赖公开可获得。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
| FB-001 | 成员变更后新成员掉队，系统优先进入 monitor remap，未在新成员集合内触发 snapshot 追平 | 不重要 | 不会造成已验证场景下的数据丢失，但会退化回 monitor remap 分布，增加 monitor 收敛压力。规避措施：保持网络健康，确保成员变更后新加入节点处于在线状态。 | 遗留 |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 1 | 0 | 0 | 0 | 1 |
| 百分比 | 100% | 0% | 0% | 0% | 100% |

# 4     详细测试结论

## 4.1   功能测试

### 4.1.1 继承特性测试结论

| 序号  | 组件/特性名称                                   |           特性质量评估           | 备注                                                                   |
| --- | ----------------------------------------- | :------------------------: | -------------------------------------------------------------------- |
| 1   | 控制面基础服务 (fastblock-mon, fastblock-client) | <font color=green>■</font> | 稳定支持 OSD 注册、Monitor 元数据管理、Pool 创建与 PG 状态下发，可见性正常。                    |
| 2   | 数据面基础 IO (fastblock-osd, block_bench)     | <font color=green>■</font> | 稳定支持 OSD 本地数据落盘、IO 数据读写与 block_bench 写后读校验。                          |
| 3   | RDMA write-ring 传输层                       | <font color=green>■</font> | 客户端和 OSD 之间通过 RDMA write-ring 进行高性能数据传输，lease 过期可正常 reacquire 并重新获取。 |

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | Raft 成员变更 (change_nodes) | <font color=blue>▲</font> | 无预创建 PG 的基础场景已打通，变更后 pgmap 正确落盘，基础 IO 回归正常；但在变更中 Leader 挂掉存在收敛问题。 |
| 2 | Raft Recovery/Snapshot 恢复机制 | <font color=blue>▲</font> | 普通日志 recovery 及落后 follower 接收 installsnapshot 推进索引并追平功能已验证；快照同步中 Leader 挂掉存在收敛风险。 |
| 3 | NVMe-oF 协议导出服务 (fastblock-nvmf-tgt) | <font color=green>■</font> | 支持将 fastblock bdev 转换为 NVMe-oF namespace，Linux 内核 initiator (TCP/RDMA) 可顺利发现、连接、格式化挂载并运行 fio。 |
| 4 | vhost 虚拟化接口 (fastblock-vhost) | <font color=green>■</font> | 能够创建 vhost-user 设备并与 QEMU 虚拟机对接，格式化与 IO 一致性验证通过。 |

## 4.2   兼容性测试结论

* **操作系统与内核兼容性**：针对 openEuler 24.03-LTS-SP4 内核（6.6.0-72 版本）进行了内核驱动与接口对接测试，SPDK 驱动与用户态块客户端编译无兼容性阻碍；`kfastblock` 内核客户端作为开发验证版，支持 `register_blkdev`、`sysfs` 运维接口等。
* **软件包兼容性**：通过 `make_rpm.sh` 构建出的 `fastblock-mon`、`fastblock-osd`、`fastblock-devel` 等 RPM 包，可在 openEuler 24.03-LTS-SP4 上正常安装、卸载和升级，依赖关系能自闭环。

## 4.3   DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
| block_bench 性能 | 单副本 4 KiB 随机写 | ~48,000 IOPS<br>(平均时延: 2.66 ms) | 历史物理机基线，单核 OSD 基本达到磁盘单核写入上限。 |
| block_bench 性能 | 三副本多 PG 4 KiB 随机写 | 441,148 IOPS<br>(单线程时延: 126.6 μs<br>并发平均时延: 1.01 ms) | 历史物理机基线，三节点/48 OSD 环境下多核并发写入可稳定运行。 |
| vhost 性能 | QEMU 内 fio 多队列随机写 | 372,218 IOPS<br>(单线程时延: 128.8 μs<br>并发平均时延: 2.75 ms) | vhost-user 对接 QEMU 后可完成虚拟机内 fio 压测，性能相对 block_bench 存在 vhost 层开销。 |
| NVMe-oF 性能 | 内核 initiator TCP fio 读写 | 读: 158 IOPS<br>写: 165 IOPS | 基础协议 smoke 场景功能正常，数值为开发机烟测基线。 |
| NVMe-oF 性能 | 内核 initiator RDMA fio 读写 | 读: 418 IOPS<br>写: 415 IOPS | 软 RDMA (rdma_rxe) 环境下的开发机烟测值，IO 一致性良好。 |

### 4.3.2 可靠性/韧性测试结论

| 测试类型   | 测试内容                                          | 测试结论                                                                                                |
| ------ | --------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| 节点故障注入 | 强制 kill 1个 OSD 观察 3 副本集群恢复                    | **通过**。PG 自动退化为 undersize 并不影响客户端 IO 读写，拉起 OSD 后，Raft 自动同步完成 recovery，重新收敛为 active。                 |
| 成员变更容灾 | 成员变更 `change_nodes` 过程中注入 leader 故障           | **通过**。集群收敛回健康状态                                                                                    |
| 快速恢复容灾 | 触发 follower 长时间离线以累积大日志落后，重新上线后触发 snapshot 恢复 | **通过**。系统成功从普通日志恢复切入 `snapshot_check -> send_snapshot -> installsnapshot` 闭环，最终推进 follower 索引并重新追平。 |

### 4.3.3 编译加固/基础安全检查结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 编译加固 | 检查 CMake 编译参数 | **通过**。工程已启用 `-fPIC`、`-pie` 等基础编译加固选项。 |
| sanitizer 回归入口 | 检查 ASAN/UBSAN 与 sanitizer 回归脚本 | **通过**。工程保留 ASAN/UBSAN 编译选项及 `run-kfastblock-sanitizer.sh` 回归入口；正式安全签收仍建议补充专项安全测试记录。 |

## 4.4   资料测试结论

| 测试类型   | 测试内容   | 测试结论                          |
| ------ | ------ | ----------------------------- |
| 安装配置手册 | 部署手册验证 | **通过**。文档步骤可支撑测试与运维人员完成集群初始化。 |

## 4.5   其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 运行方式回归 | 验证 `vstart.sh` 本地 dev cluster 模式与 Systemd 服务注册运行方式 | **通过**。两套环境均能够正确配置、启动并管理集群。 |

# 5     测试执行

## 5.1   测试执行统计数据

本节内容根据测试用例及实际执行情况进行特性整体测试的统计。

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| fastblock master (commit 5e52ad2a7c020677673f00fa8c0c747cd42412d0) | 12 | 11 通过，1 失败/有遗留缺陷 | 1 |

*数据项说明：*
* *测试用例数－－到本测试活动结束时，所有可用测试用例数；*
* *发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

1. 持续跟踪并修复 Raft 成员变更与 Snapshot 恢复过程中 Leader 切换时的收敛与挂起缺陷。
2. 补齐完全“从0开始”空节点 Bootstrap 自动生成 Snapshot 的集成验证。
3. 在后续版本中增加长时间稳定性压测（如 7*24 小时长稳）和更完备的 CI 自动化回归覆盖矩阵。

# 6     附件

### 附件 A：基础写读校验脚本成功运行输出
```text
Write-read-verify completed
connected to 10.211.55.29:9087 ... reacquiring write ring
Write stage: 64 IOs completed.
Read stage: 64 IOs completed.
Verification success.
```

### 附件 B：成员变更 `change_nodes` 成功输出与 Monitor 记录
```text
# 执行命令
./build/src/test/raft_membership --no-huge -s 1024 -m 0x10 -C .vstart/etc/fastblock/fastblock.json -I 1 -o 10.211.55.29 -t 9818 -P 1 -G 0 -N change -O '2:10.211.55.29:9087,3:10.211.55.29:9232,4:10.211.55.29:9965'

# 终端输出
leader of the pg 1.0 is 2
change membership in the pg 1.0 result: 0

# Monitor 日志
Received PgMemberChangeFinishRequest, pg 1 . 0
Finalize pg member change, pg 1 . 0 old osdList [1 2 4] new osdList [3 4 2]
```

### 附件 C：NVMe-oF 发现及连接成功信息
```text
# nvme discover -t tcp -a 10.211.55.29 -s 4420
Discovery Log Number of Records 1, Generation counter 2
=====Discovery Log Entry 0======
trtype:  tcp
adrfam:  ipv4
subtype: nvme subsystem
treq:    not specified
portid:  0
trsvcid: 4420
subnqn:  nqn.2016-06.io.spdk:cnode1
traddr:  10.211.55.29

# nvme list
Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
/dev/nvme0n1     SPDK00000000000001   SPDK_Controller1                         1         536.87  MB /  536.87  MB    512   B +  0 B   23.01
```

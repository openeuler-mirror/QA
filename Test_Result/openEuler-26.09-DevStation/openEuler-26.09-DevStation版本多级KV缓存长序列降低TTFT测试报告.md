![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期      | 修订版本 | 修改描述 | 作者   |
| --------- | -------- | -------- | ------ |
| 2026-9-24 | 1.0      | 新建     | 江叶根 |
|           |          |          |        |


关键词： KVC池化，多级KV缓存，P2P池化，PD分离，KVCache，NPU

摘要：

LMCache PD（Prefill-Decode 分离） 将推理的 Prefill 阶段与 Decode 阶段拆分到不同实例执行。Sender 完成 Prefill 后将 KV Cache 通过 HCCL 传输至 Receiver，Receiver 据此执行 Decode，支持NPU buffer 与 CPU offload 两种存储模式，由 proxy 协调两端连接。该机制使 Prefill 与 Decode 可分别针对各自负载独立调度资源，提升整体吞吐。

LMCache P2P 实现多 vLLM 实例间 KV Cache 的 Peer-to-Peer 共享。通过 Controller 协调各实例注册与发现，基于 HCCL 通道在 NPU 间直接传输 KV Cache，支持 pull mode（按需拉取）与 delay pull（延迟拉取）两种策略，并提供 NPU buffer 与 host staging 两级缓存。开启后，一个实例已生成的 KV Cache 可被其他实例复用，减少重复计算，降低 TTFT。


缩略语清单：

| 缩略语 | 英文全名                                                  | 中文解释                                                     |
| ------ | --------------------------------------------------------- | ------------------------------------------------------------ |
| TTFT   | Time to First Token                                       | 从用户发起请求到系统返回第一个生成字符（Token）所经历的时间  |
| KVC/KV | Key Value Cache                                           | 在推理过程中常用的一种优化技术，主要用于加速自回归生成任务（如文本生成）中的计算效率 |
| NPU    | Neural Processing Unit                                    | 神经处理单元                                                 |
| PD     | Prefill-Decode                                            | Prefill（预填充）和 Decode（解码）                           |
| P2P    | Peer-to-Peer                                              | *P2P*（点对点）网络是一种没有中心服务器的网络架构，每个节点（peer）既是客户端也是服务器，节点之间直接相连、直接通信、共同维护网络运行 |
| HCCL   | Huawei Collective Communication Library                   | 基于昇腾AI处理器的高性能集合通信库，提供单机多卡以及多机多卡间的集合通信能力 |
| HBM    | High Bandwidth Memory                                     | 一款新型的 GPU 内存芯片                                      |
| DDR    | Double Data Rate Synchronous Dynamic Random Access Memory | 一种在电脑和服务器中广泛使用的内存技术                       |
| SSD    | Solid State Disk                                          | 固态硬盘                                                     |
| LFU    | First In First Out                                        | 缓存淘汰算法：计算每个数据被访问的总次数，删掉访问次数最少的数据 |
| LRU    | Least Recently Used                                       | 缓存淘汰算法：删掉长时间没被访问过的数据                     |
| FIFO   | Least Frequently Used                                     | 缓存淘汰算法：最先进入缓存的数据，最先被删掉                 |
| MRU    | Most Recently Used                                        | 缓存淘汰算法：和 LRU 正好相反，它优先删掉最近刚刚被访问过的数据 |
| UB     | Unified Bus                                               | 一种数据中心级统一硬件互联协议与超节点架构，旨在应对 AI 大模型爆发带来的算力与通信瓶颈 |


# 1     特性概述

1、构建HBM/DDR/远端DDR/SSD多级KVC缓存池，提供LFU、LRU、FIFO、MRU等多级缓存策略，实现KV Cache分层存储、冷热迁移能力；
2、结合UB加速PD间KV传输，同时扩充Pull-Delay传输模式，P节点KV异步卸载到DDR上，D节点按需加载； 

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                              | 测试起始时间 | 测试结束时间 |
| ------------------------------------- | ------------ | ------------ |
| openEuler  26.09-devstation           | NA           | NA           |
| docker容器环境                        | NA           | NA           |
| LMCache-Ascend-0.4.4-6.oe2609.aarch64 | 2026-09-04   | 2026-09-23   |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 鲲鹏     | NA           | NA   |
| 昇腾     | NA           | NA   |

# 3     测试结论概述

## 3.1   测试整体结论

KVC池化&多级KV缓存特性，共计执行3个用例，主要覆盖了功能测试和性能测试和资料测试，无遗留风险，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 特性测试 | 质量良好 |
| 兼容性测试 | 不涉及 | 不涉及 |
| DFX专项测试 | 性能测试 | 质量良好 |
| DFX专项测试 | 可靠性/韧性测试 | 不涉及 |
| DFX专项测试 | 安全测试 | 不涉及 |
| 资料测试 |         | 质量良好 |
| 其他测试 |         | 不涉及 |

## 3.2   约束说明

昇腾物理环境，vLLM 0.18.0，LMCache 0.4.2+ 

  P2P 池化

```
1. Controller 必须先于 vLLM 实例启动，否则 Worker 注册失败
2. TP>1 时 lookup 仅返回单个 peer，多 Worker retrieve 失败
3. prompt 短于 chunk_size 永不命中
4. max_local_cpu_size 受物理内存约束，过大触发 OOM
5. 各组端口（init/lookup/worker）需互不重叠且未被占用
6. 传输绑定 NPU HCCL 通道，要求实例间 NPU 可通信
```

  PD 分离

```
1. 必须 sender + receiver 同时出现，无接收方或无发送方则服务不可用
2. Sender 需配置 proxy，由 proxy 协调连接建立
3. 每个实例只能承担一种角色，不可兼任
4. buffer 设备选择影响资源占用，NPU buffer 占显存，CPU offload 受 pd_cpu_buffer_size 约束
```

  通用

```
1. 传输绑定 HCCL，非通用网络通道
2. P2P 与 PD 各自独立开关，不建议同一实例同时启用
3. 开关关闭后组件可能仍初始化，需通过日志验证实际行为
```

## 

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及

### 3.3.2 问题统计

### 3.3.2.1 问题数量

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 5        | 1    | 4    | 0    | 0      |
| 百分比 | 100%     | 20%  | 80%  | 0%   | 0%     |

### 3.3.2.2 发现问题

| 序号 | 问题单号                                                  | 问题简述                                                     | 优先级 | 当前状态 |
| ---- | --------------------------------------------------------- | ------------------------------------------------------------ | ------ | -------- |
| 1    | https://gitcode.com/src-openeuler/LMCache-Ascend/issues/1 | 使用pd分离模式执行/v1/chat/completions推理，不传max_tokens，报错异常 | 主要   | 已闭环   |
| 2    | https://gitcode.com/src-openeuler/LMCache-Ascend/issues/2 | 使用pd分离模式执行/v1/completions推理，使用token值，报错异常 | 主要   | 已闭环   |
| 3    | https://gitcode.com/src-openeuler/LMCache-Ascend/issues/3 | 使用pd分离模式执行/v1/completions推理，不传prompt，报错异常  | 主要   | 已闭环   |
| 4    | https://gitcode.com/src-openeuler/LMCache-Ascend/issues/4 | 使用pd分离模式执行/v1/completions、/v1/chat/completions推理，不传提示词，报错异常 | 主要   | 已闭环   |
| 5    | https://gitcode.com/src-openeuler/LMCache-Ascend/issues/7 | 使用p2p池化模式，p2p访问对端缓存有报错                       | 严重   | 已闭环   |


# 4 详细测试结论

## 4.1 功能测试
### 4.1.1 特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | PD分离功能测试 | <font color=green>■</font> | NA |
| 2 | P2P池化功能测试 | <font color=green>■</font> | NA |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好



## 4.2 兼容性测试结论

不涉及

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

获取P2P池化，PD分离，未启用LMCache三种模式的大模型首Token生成时间ttft值，取长时间运行的一个平均值，进行性能值计算，P2P池化在整体表现上降低50%，PD分离在整体表现上降低30%，测试通过



### 4.3.2 可靠性/韧性测试结论

不涉及

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论

测试通过

## 4.5 其他测试结论

不涉及

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称                    | 测试用例数 | 用例执行结果 | 发现问题单数 |
| --------------------------- | ---------- | ------------ | ------------ |
| openEuler  26.09-devstation | 3          | PASS         | 5            |
|                             |            |              |              |



## 5.2   后续测试建议

NA

# 6     附件

NA

 



 

 
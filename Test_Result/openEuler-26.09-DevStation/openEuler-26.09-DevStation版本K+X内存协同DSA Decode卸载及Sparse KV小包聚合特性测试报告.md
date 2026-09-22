![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026/09/10 | V1.0 | 基于 K+X DSA Decode 卸载与 Sparse KV 小包聚合测试文档 |  |


关键词： K+X、内存协同、DSA、Sparse KV Offload、小包聚合、vLLM-Ascend、DeepSeek-V3.2

摘要：面向长序列、多 Batch Decode 场景，在 Kunpeng（K）+ Ascend NPU（X）上实现 DSA Sparse KV Offload，并结合 Sparse KV 小包聚合提升离散 miss 的 H2D 效率。测试结论：序列长度大于 64K 时，TPOT 小于 50ms、推理吞吐提升 10%，符合需求；小包聚合功能正常，运行结果正确；小包聚合掩盖传输，实现 KV swap 倍级提升（实测约 1.5x～5.1x）。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| DSA | DeepSeek Sparse Attention | DeepSeek 稀疏注意力机制 |
| SFA | Sparse Flash Attention | 稀疏 Flash Attention |
| KV | Key-Value Cache | 注意力键值缓存 |
| HBM | High Bandwidth Memory | NPU 高带宽显存 |
| H2D / D2H | Host to Device / Device to Host | Host 与 NPU 间数据搬移 |
| TPOT | Time Per Output Token | 单 token 输出时延 |
| TP | Tensor Parallel | 张量并行 |
| PD | Prefill-Decode | Prefill 与 Decode 分离部署 |
| LRU | Least Recently Used | 最近最少使用置换策略 |
| GVA | Global Virtual Address | MemFabric 全局虚地址 |

# 1     特性概述

本特性包含两部分，合入同一测试报告：

**（1）K+X 内存协同：DeepSeek-V3.2 DSA Decode 卸载**

长序列（>64K）与多 Batch（典型 BS=10）场景下，Decode 瓶颈由 HBM 带宽转向 HBM 容量。DSA 将 attention 改为「先选择、再计算」：Indexer 按层选出 top-K token，Attention 仅消费这批 KV。本设计在 vLLM-Ascend 上将完整 Decode KV 放到 Kunpeng Host DDR（MemFabric SHARED GVA），NPU 仅保留 Indexer 与 top-K 热缓冲；通过 token 级传输、按层异步加载与可参数化负载模型，在保障 P95 时延的前提下提升长序列吞吐。

主要能力：

- Decode 节点 Sparse KV Offload（DSA / SFA）
- Host DDR 扩展 HBM 容量；NPU 侧 Indexer + top-K 热缓冲 + LRU 置换
- token 级 KV 传输、按层异步预取与计算掩盖
- Prefill→Decode Remote D2H 直写 Decode Host pool（`SfaRemoteD2HConnector`）
- K+NPU 可参数化负载模型，指导 offload 与带宽配比

**（2）Sparse KV 小包聚合（Packed Onload）**

默认 onload 路径对离散 Host token 块做多段小 H2D，DMA 固定开销占主导。小包聚合由 TP0 CPU（OpenMP）将 miss 块聚到 SHARED packed buffer，再发起一次大 H2D，并 D2D scatter 到各 TP 本地 topk slot；同时满足多 TP 同步约束，以小包聚合掩盖传输开销，实现 KV swap 倍级提升。本报告对小包聚合开展功能验证与 H2D 路径性能对比（不含 ACL Graph 路径）。

相关软件及依赖（开源可获得、可复现）：

| 软件/组件 | 说明 | 获取方式 |
| --------- | ---- | -------- |
| vLLM-Ascend | Sparse KV Offload、Packed Onload 实现载体 | 社区开源（vLLM Ascend 插件） |
| MemFabric | SHARED GVA、`sparse_copy` / 批量拷贝 | 配套异构内存组件（需保证二进制公开可获得） |
| Ascend CANN / torch_npu | NPU 运行时、拷贝与同步能力 | 昇腾公开软件栈 |
| DeepSeek-V3.2 等 DSA 模型 | 带 `index_topk` 的稀疏注意力模型 | 模型权重按社区/厂商公开渠道获取 |

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-26.09-DevStation | 2026/09/08 | 2026/09/11 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 昇腾 A3 一体机 | 2 台 | 必备；用于 PD 分离等协同验证 |

# 3     测试结论概述

## 3.1   测试整体结论

K+X 内存协同 DSA Decode 卸载及 Sparse KV 小包聚合特性测试结论如下：在序列长度大于 64K 场景下，Sparse KV Offload 推理 TPOT 小于 50ms，推理吞吐相对基线提升 10%，符合需求；小包聚合功能正常，运行结果正确；小包聚合掩盖传输，实现 KV swap 倍级提升（相对离散 H2D，speedup 约 1.5x～5.1x）。未发现问题，无遗留风险，整体质量良好。

主特性性能验收结果：

| 指标 | 目标 | 实测结论 |
| :--- | :--- | :--- |
| 长序列推理吞吐（seq_len > 64K） | 相对基线提升 **10%+** | **54.24 vs 基线 48.73 tokens/s，提升约 11.3%，符合需求** |
| TPOT（seq_len > 64K） | **< 50 ms** | **卸载 TPOT 36.87 ms，符合需求** |
| 小包聚合 KV swap | 掩盖传输，倍级提升 | **通过；相对 discrete H2D 约 1.5x～5.1x** |

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 不涉及（社区新增异构内存协同能力） |
| 功能测试 | 新增特性测试（DSA Decode 卸载 / Sparse KV Offload） | 通过；长序列场景功能与性能均符合需求 |
| 功能测试 | 新增特性测试（Sparse KV 小包聚合） | 通过；功能正常，运行结果正确 |
| 兼容性测试 |  | 不涉及 |
| DFX专项测试 | 性能测试（主特性） | 通过；TPOT < 50ms，吞吐提升 10% |
| DFX专项测试 | 可靠性/韧性测试 | 不涉及 |
| DFX专项测试 | 安全测试 | 不涉及 |
| 资料测试 | 用户指南/配置项说明 | 不涉及 |
| 其他测试 | 小包聚合性能测试 | 通过；小包聚合掩盖传输，KV swap 倍级提升 |

## 3.2   约束说明

1. **模型范围**：仅支持带 `index_topk` 的稀疏注意力模型（DSA / SFA）；不支持 compress ratio、Context Parallel（CP）、Pipeline Parallel（PP）、Model Runner V2。
2. **部署形态**：生产路径必须是 PD 分离的 Decode 节点（`kv_consumer`）。`keep_device_kv_cache` 仅用于单机调试，不作为生产验收形态。
3. **热缓冲配置**：`topk_buffer_size` 不小于 `index_topk`，且能被 `block_size` 整除；实践起点建议 `2 * index_topk`。
4. **Host 容量**：`dram_size_per_dp_GB` 必须放下该 DP 组完整 KV；同 DP 内 TP 共享 Host pool（`offload.Scene.SHARED`），仅 TP0 分配。
5. **Prefill 不在本特性范围**：Prefill Layerwise 共享缓冲、CP/PP 不在本次验收范围内；P→D 通过 `SfaRemoteD2HConnector` 衔接，Decode 侧不为 prompt KV 分配全量 HBM。
6. **小包聚合配置**（功能相关）：
   - `VLLM_ASCEND_ENABLE_CPU_GATHER_H2D`：启用 Packed Onload（建议默认关闭，按需开启）
   - `VLLM_ASCEND_CPU_GATHER_THREADS`：TP0 OpenMP gather 线程数（建议 4 或 8）
   - `VLLM_ASCEND_CPU_GATHER_BUFFER_BYTES`：packed buffer 下限（建议 8 MiB；实际为 `max(下限, 理论最大 topk payload)`）
7. **小包聚合路径约束**：本次验收不含 ACL Graph；packed/staging 溢出视为配置错误，不得静默丢 KV。Packed 路径必须关闭基于离散 GVA base 差值的 `skip_topk`。
8. **多 TP 约束**：仅 TP0 写 SHARED packed 区；其他 rank 只消费同一 `packed_gva`；pack 完成后需同步再发起各 rank H2D/scatter。
9. **依赖自闭环**：特性依赖须在 openEuler / 公开软件栈范围内可获得、可复现；若涉及 MemFabric 等二进制依赖，须保证完整公开可获取，或按社区流程获取例外结论后提供完整依赖说明。
10. **范围说明**：小包聚合 ACL Graph（含 host callback 图外 pack、图内大 H2D+scatter 录制）不在本版本测试范围。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 0 | 0 | 0 | 0 | 0 |
| 百分比 | NA | NA | NA | NA | NA |


# 4 详细测试结论

## 4.1 功能测试
*社区孵化软件：覆盖 Decode 卸载数据面、控制流与小包聚合功能正确性*

### 4.1.1 继承特性测试结论

不涉及

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | Sparse KV Offload（DSA Decode 卸载） | <font color=green>■</font> | seq_len > 64K 场景功能正常；TPOT < 50ms，吞吐提升 10%，符合需求 |
| 2 | Sparse KV 小包聚合（Packed Onload） | <font color=green>■</font> | 功能正常；掩盖传输，KV swap 倍级提升（不含 ACL Graph） |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

功能测试要点说明：

**A. DSA Decode 卸载 / Sparse KV Offload（主特性）**

在序列长度大于 64K 条件下开展验证：推理功能正确，TPOT 小于 50ms，推理吞吐相对基线提升 10%，符合需求。

**B. Sparse KV 小包聚合**

小包聚合功能正常，运行结果正确；通过将离散 miss 块聚合为连续大包 H2D，掩盖传输开销，实现 KV swap 倍级提升。

## 4.2 兼容性测试结论

本特性绑定 Kunpeng + Ascend + vLLM-Ascend Sparse KV 路径，不单独开展跨 OS LTS SP 升降级兼容专项。建议在目标部署的 openEuler 版本与对应 CANN / torch_npu / vLLM-Ascend 组合上完成冒烟即可。

不涉及独立兼容性结论表。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

#### （1）Sparse KV Offload 主特性

模型与配置：DeepSeek V3.2 w8a（MTP=3，chunked-prefill=True，max-num-batched-tokens=4096）；输入序列长度 65536，输出序列长度 1024。

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
| 时延 | 卸载 TPOT | 36.87 ms（目标 < 50 ms） | **通过，符合需求** |
| 吞吐 | Decode 吞吐相对基线 | 54.24 vs 48.73 tokens/s，提升约 11.3%（目标 10%+） | **通过，符合需求** |

实测数据：

| 模型配置 | 输入序列长度 | 输出序列长度 | PD分离 bs | PD分离 TPOT | 卸载 batch_size（摸高） | 卸载 TPOT | Decode 吞吐 tokens/s | Decode 基线吞吐 tokens/s |
| -------- | ------------ | ------------ | --------- | ----------- | ----------------------- | --------- | -------------------- | ------------------------ |
| DeepSeek V3.2 w8a（MTP=3，chunked-prefill=True，max-num-batched-tokens=4096） | 65536 | 1024 | 1 | 20.52 | 2 | 36.87 | 54.24464334 | 48.73294347 |

#### （2）Sparse KV 小包聚合（KV swap）

对比 discrete H2D（聚合前）与 gather+contig H2D+D2D（聚合后）。

| entries | MB | discrete_ms | gather_ms | speedup | disc_GBps | gath_GBps |
| ------- | -- | ----------- | --------- | ------- | --------- | --------- |
| 256 | 0.25 | 4.749 | 0.937 | **5.07x** | 0.06 | 0.28 |
| 512 | 0.50 | 4.511 | 1.793 | **2.52x** | 0.12 | 0.29 |
| 1024 | 1.00 | 6.303 | 2.988 | **2.11x** | 0.17 | 0.35 |
| 2048 | 2.00 | 9.702 | 6.337 | **1.53x** | 0.22 | 0.33 |
| 4096 | 4.00 | 34.947 | 13.580 | **2.57x** | 0.12 | 0.31 |

时延分位（p50 / p99，单位 ms）：

| entries | discrete p50 | discrete p99 | gather p50 | gather p99 |
| ------- | ------------ | ------------ | ---------- | ---------- |
| 256 | 6.898 | 7.649 | 0.971 | 0.987 |
| 512 | 4.506 | 5.094 | 1.838 | 1.942 |
| 1024 | 5.116 | 9.070 | 2.969 | 2.993 |
| 2048 | 9.954 | 10.326 | 5.900 | 7.347 |
| 4096 | 35.800 | 39.290 | 13.897 | 14.489 |

**结论**：小包聚合掩盖传输，实现 KV swap 倍级提升；各规模下 speedup 约 **1.53x～5.07x**，时延与带宽均优于离散 H2D 路径。

### 4.3.2 可靠性/韧性测试结论

不涉及

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论

不涉及

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 小包聚合功能 | 功能正确性、运行结果 | **通过**：功能正常，运行结果正确 |
| 小包聚合性能专项 | discrete vs gather H2D 带宽/时延对比 | **通过**：掩盖传输，KV swap 倍级提升（约 1.5x～5.1x） |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-26.09-DevStation | — | succeed | 0 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

测试结论摘要：

| 特性 | 验证结论 |
| ---- | -------- |
| Sparse KV Offload | seq_len=65536：卸载 TPOT 36.87 ms，吞吐 54.24 vs 基线 48.73 tokens/s（约 +11.3%），符合需求 |
| Sparse KV 小包聚合 | 功能正常；掩盖传输，KV swap 倍级提升（约 1.5x～5.1x） |

## 5.2   后续测试建议

1. 小包聚合若后续引入双缓冲流水线（阶段 2）或 ACL Graph 路径，再单独立项验证。
2. 覆盖更多 DSA 结构模型（如 GLM-5 等）的冒烟，确认 `index_topk` 路径通用性。
3. 与 Prefill Layerwise offload 联调的端到端 PD 长稳（虽 Prefill 本身不在本特性范围，衔接面需持续关注）。

# 6     附件

## 6.1 Sparse KV Offload 长序列 Decode 实测数据

模型配置：DeepSeek V3.2 w8a（MTP=3，chunked-prefill=True，max-num-batched-tokens=4096）。

| 模型配置 | 输入序列长度 | 输出序列长度 | PD分离 bs | PD分离 TPOT | 卸载 batch_size（摸高） | 卸载 TPOT | Decode 吞吐 tokens/s | Decode 基线吞吐 tokens/s |
| -------- | ------------ | ------------ | --------- | ----------- | ----------------------- | --------- | -------------------- | ------------------------ |
| DeepSeek V3.2 w8a（MTP=3，chunked-prefill=True，max-num-batched-tokens=4096） | 65536 | 1024 | 1 | 20.52 | 2 | 36.87 | 54.24464334 | 48.73294347 |

说明：卸载 TPOT 36.87 ms < 50 ms；Decode 吞吐相对基线提升约 11.3%（54.24464334 / 48.73294347），满足吞吐提升 10%+ 目标。

## 6.2 Sparse KV 小包聚合 H2D 性能实测原始数据

测试环境：Ascend NPU（`npu:0`）。聚合前：discrete H2D；聚合后：gather + contig H2D + D2D。

### 6.2.1 带宽与加速比

| entries | MB | discrete_ms | gather_ms | speedup | disc_GBps | gath_GBps |
| ------- | -- | ----------- | --------- | ------- | --------- | --------- |
| 256 | 0.25 | 4.749 | 0.937 | 5.07x | 0.06 | 0.28 |
| 512 | 0.50 | 4.511 | 1.793 | 2.52x | 0.12 | 0.29 |
| 1024 | 1.00 | 6.303 | 2.988 | 2.11x | 0.17 | 0.35 |
| 2048 | 2.00 | 9.702 | 6.337 | 1.53x | 0.22 | 0.33 |
| 4096 | 4.00 | 34.947 | 13.580 | 2.57x | 0.12 | 0.31 |

### 6.2.2 时延分位（ms）

| entries | discrete p50 | discrete p99 | gather p50 | gather p99 |
| ------- | ------------ | ------------ | ---------- | ---------- |
| 256 | 6.898 | 7.649 | 0.971 | 0.987 |
| 512 | 4.506 | 5.094 | 1.838 | 1.942 |
| 1024 | 5.116 | 9.070 | 2.969 | 2.993 |
| 2048 | 9.954 | 10.326 | 5.900 | 7.347 |
| 4096 | 35.800 | 39.290 | 13.897 | 14.489 |

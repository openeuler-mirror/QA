![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者   |
| ---------- | ----------- | -------- | ------ |
| 2026-09-12 | 1.0         | 创建     | 储成凯 |


关键词： 记忆智能、Agent Infra、RAM-A-KV

摘要：
    RAM-A-KV 承载推理栈 KVCache 的协同调度能力，对上适配多 Agent 框架，对下适配多 KVCache 管理组件。通过引用计数机制保证共享 chunk 的安全驱逐，并与 Agent 长短期记忆&执行行为联动，对 KVCache 进行主动管理（预取、驱逐），从而提高 KVCache 的命中率和加载时间，降低首 Token 时延。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |

# 1     特性概述

Agent 框架通过统一事件接口 POST /event 与 RAM-A-KV 交互，事件类型覆盖 Agent 运行全周期：推理轮次开始（turn_start）、推理轮次结束（turn_end）、快照恢复（snapshot_restore）、会话映射查询（session_map）、会话关闭（session_close）、会话挂起（session_suspend）、会话分叉（session_fork）、分叉结束（session_fork_end）、健康检查（health），以及元事件（list_events）。RAM-A-KV 内部通过 EventRegistry 进行事件路由，KvCacheManager 维护全局引用计数和 Session 级 KvCacheMap，驱动 KvCacheBackend（默认 LMCacheAscendBackend）执行实际的缓存操作。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间，包括依赖的硬件。

| 版本名称                    | 测试起始时间 | 测试结束时间 |
| --------------------------- | ------------ | ------------ |
| openEuler-26.09-DevStation | 2026-08-20   | 2026-09-05   |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注   |
| -------- | ------------ | ------ |
| NA       | NA           | 虚拟机 |
| 昇腾 NPU    |  NA          | 物理机 |

描述特性软件包测试版本

| 软件包测试版本 |
| -------- |
| ram-a-kv-0.0.1-1.oe2609 |

# 3     测试结论概述

## 3.1   测试整体结论

记忆智能RAM-A-KV特性，共计执行22个用例，覆盖了场景、接口、功能、可靠性、性能测试和安全测试，发现有效问题6个，已提issue解决，回归通过，无遗留风险，整体质量良好


## 3.2   约束说明

1. 需部署 LMCache-Ascend 服务（HTTP 端点 `/memory/prefetch`、`/memory/evict`、`/memory/query`），配套昇腾 NPU 与 CANN 驱动。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

NA

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |     6    |   1   |  3    |   1   |    1    |
| 百分比 |      100%    |  16%    |    48%  |  16%    |   16%   |

# 4 详细测试结论

## 4.1 场景测试

| 测试类型 | 测试内容 | 测试结论 |
| --- | ----------- | --- |
| 1| 验证xiaoO场景下Agent推理全周期端到端事件执行正确性 | 测试通过  |
| 2| 验证OpenClaw场景下Agent推理全周期端到端事件执行正确性 |测试通过   |

## 4.2 接口测试

| 测试类型 | 测试内容 | 测试结论 |
| --- | ----------- |  --- |
|1 |验证POST /event异常参数的拦截和错误响应 | 测试通过  |
|2 |验证配置文件/etc/ram-a-kv/config.toml各配置项有效值和无效值 | 测试通过  |

## 4.3 功能测试

| 测试类型 | 测试内容 | 测试结论 |
| --- | ----------- |  --- |
|1 |验证turn_start事件的KVCache预取逻辑 | 测试通过  |
|2 |验证turn_end事件的引用计数计算和安全驱逐逻辑 | 测试通过  |
|3 |验证session_fork/session_fork_end的引用计数变更 | 测试通过  |
|4 |验证session_suspend/snapshot_restore的会话管理逻辑 | 测试通过  |
|5 |验证daemon启动和重启恢复流程 | 测试通过  |
|6 |验证list_events元事件返回所有已注册事件规格 | 测试通过  |
|7 |验证chunk hash长度校验的边界行为 | 测试通过  |
|8 |单个session的chunk数量上限1000 |测试通过  |

### 4.4 可靠性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|  1       |验证后端LMCache Ascend恢复后的操作恢复         |测试通过|
|  2       |验证长期运行下daemon正常表现         | 测试通过|
|  3       |验证SQLite文件损坏的处理         | 测试通过|
|  4       |验证SQLite并发写入的锁竞争行为         |测试通过|
|  5       | 不同agent并发        | 测试通过|

## 4.5 资料测试

| 测试类型 | 测试内容 | 测试结论 |
| --- | ----------- |  --- |
|1 |验证配置文件文档与实际配置项的一致性 | 测试通过  |
|2 |验证API接口文档与实际响应格式的一致性 | 测试通过  |


### 4.6 性能测试结论

| 指标项 | 指标值 | 实际测试值 | 测试结论 |
| ------- | ------- | ------ | ------- |
| 验证启用RAM-A-KV后Agent推理等待时延降低|20%|25%|测试通过|

### 4.7 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 1        |验证配置文件config.toml的权限控制         |测试通过|
| 2        | AI代码安全审计        |测试通过|

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称                    | 测试用例数 | 用例执行结果 | 发现问题单数 |
| --------------------------- | ---------- | ------------ | ------------ |
| openEuler-26.09-DevStation  | 22          | 执行通过            | 6            |

issue链接

| 序号 | 问题链接 | 问题描述 | 状态  |
 	 | -- | --------------------------------------------- | ----------------------- | ------ |
 	 | 1  | https://gitcode.com/openeuler/RAM-A/issues/2 | ram-a-kv请求返回type字段异常 | 已解决 |
 	 | 2  | https://gitcode.com/openeuler/RAM-A/issues/3 | ram-a-kv 调用health接口daemon日志多打印了session_id字段 | 已解决 |
 	 | 3  | https://gitcode.com/openeuler/RAM-A/issues/4 | ram-a-kv的chunk的数据长度超过100上限 | 已解决 |
 	 | 4  | https://gitcode.com/openeuler/RAM-A/issues/5 | ram-a-kv的chunk的数量超过1000上限 | 已解决 |
 	 | 5  | https://gitcode.com/openeuler/RAM-A/issues/9 | ram-a-kv的AI代码安全审计结果确认以及修改 | 已解决 |
 	 | 6  | https://gitcode.com/openeuler/RAM-A/issues/16 | ram-a-kv的list_events事件返回与资料描述不一致 | 已解决 |

## 5.2   后续测试建议

NA
 
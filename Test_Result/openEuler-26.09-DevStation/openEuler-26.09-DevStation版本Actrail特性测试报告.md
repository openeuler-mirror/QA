![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对"本文档"的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称"CC BY-SA 4.0")的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026-09-22 | V1.0 | 新建 | 张晓枫 |


关键词：AcTrail、Agent行为追踪、eBPF、TLS明文采集、治理、长稳

摘要：本报告针对 openEuler 26.09 版本 AcTrail特性进行测试。AcTrail 通过 eBPF 旁路采集 Agent 进程的进程生命周期、文件、网络、TLS 明文、LLM 语义活动等核心事实，持久化至 SQLite 并通过 actrailviewer 命令行与 actrailweb Web API 提供查询展示，同时支持基于插件的告警与命令/文件治理能力，支持Agent动作完整记录导出。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|  |  |  |

# 1     特性概述

AcTrail（Agent长稳可靠运行）特性面向 AI Agent 运行时的可观测性与治理。其基本能力包括：

1. **核心事实采集与持久化**：通过 eBPF 旁路非侵入方式采集目标 Agent 进程的进程生命周期、execve 上下文、文件访问、网络传输、工具调用、TLS 明文载荷、HTTP/LLM 语义活动等核心事实，事务提交后持久化至 SQLite（WAL 模式），daemon 退出后仍可重新读取。
2. **查询展示**：提供 `actrailviewer` 命令行与 `actrailweb` Web API/UI 两种查询入口，支持按 Trace 查询进程、事件、语义动作、载荷、告警等，并生成 Agent 运行链路。
3. **插件化告警与治理**：通过 `actraild plugin` 加载告警插件（如 activity-anomaly、file-leakage、tool-consecutive-failure-alert）和治理插件（command-policy），支持命令执行 allow/deny、文件工作边界、模型交互规模异常等检测与治理。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| AcTrail-0.7.2-2.oe2609 / openEuler 26.09 (DevStation) | 2026-08-24 | 2026-09-17 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 虚拟机 | 4 vCPU | openEuler 26.09 (DevStation) |

# 3     测试结论概述

## 3.1   测试整体结论

AcTrail 特性本轮共计执行 55 个测试用例，覆盖功能测试（含接口测试）、性能测试、可靠性和安全测试，全部通过，通过率 100%。共发现确认问题 6 个，均已整改并经回归验证确认修复，遗留问题为 0。整体质量良好。

| 测试活动    | 测试子项        | 活动评价 |
| ----------- | --------------- | -------- |
| 功能测试    | 新增特性测试    | 通过     |
| 兼容性测试  | 跨架构兼容      | 通过     |
| DFX专项测试 | 性能测试        | 通过     |
| DFX专项测试 | 可靠性/韧性测试 | 通过     |
| DFX专项测试 | 安全测试        | 通过     |
| 资料测试    | 资料验证        | 通过     |

## 3.2   约束说明

1. AcTrail当前只支持opencode和xiaoo
2. **AcTrail 需 root 权限运行**：eBPF 采集与控制面需要 root 或等价能力。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

本轮测试共发现确认问题 6 个，均已由开发侧整改并经回归验证确认修复，**遗留问题为 0**，无待整改问题，无规避措施要求。

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 6        | 2    | 4    | 0    | 0      |
| 百分比 | 100%     | 33.3% | 66.7% | 0%   | 0%     |

6 个确认 issue 及整改情况如下

| 序号 | Issue | 问题简述 | 问题级别 | 整改情况 |
| --- | ------- | ------ | ------- | ------- |
| 1 | [AcTrail日志优化](https://gitcode.com/src-openeuler/AcTrail/issues/2) | actrailctl 错误信息不用户友好；actraild.log 不包含 "daemon started"/"daemon stopped" 关键字且无时间戳 | 主要 | 已整改，错误信息增强与生命周期关键字回归通过 |
| 2 | [daemon 异常退出后无法直接重启](https://gitcode.com/src-openeuler/AcTrail/issues/3) | actraild start 不自动清理 stale PID file/control.sock | 严重 | 已整改，启动时自动清理 stale 文件回归通过 |
| 3 | [list-traces --root-pid 过滤不工作](https://gitcode.com/src-openeuler/AcTrail/issues/4) | actrailctl list-traces --root-pid 过滤无效 | 主要 | 已整改，按 root-pid 过滤回归通过 |
| 4 | [高并发 Trace 启动下 daemon 概率性崩溃](https://gitcode.com/src-openeuler/AcTrail/issues/5) | 大量trace启动后，daemon 概率性崩溃，所有进行中 Trace 丢失 | 严重 | 已整改，高并发压测回归通过 |
| 5 | [actrailctl 运行 xiaoo web 界面不显示 LLM Call](https://gitcode.com/src-openeuler/AcTrail/issues/6) | xiaoo --cli run 的 LLM 动作未被完整捕获 | 主要 | 已整改，LLM 语义动作捕获回归通过 |
| 6 | [文件权限需满足安全规范](https://gitcode.com/src-openeuler/AcTrail/issues/7) | 文件权限当前不满足linux安全规范 | 主要 | 已整改，权限收紧回归通过 |

# 4 详细测试结论

## 4.1 功能测试
*AcTrail 为社区孵化新增软件，以下为新增特性测试结论*

### 4.1.1 继承特性测试结论

不适用（AcTrail 为新增特性，无继承特性）。

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 核心事实采集与持久化（actraild 核心） | <font color=green>■</font> | 进程/文件/工具调用/TLS明文/LLM 语义采集与 SQLite 持久化主流程通过；工具调用验证 llm.tool_call / llm.tool_result 语义动作存在、状态 success 及时间顺序正确；TLS 明文覆盖 rustls / BoringSSL 双向明文采集完整性、TLS 探测失败降级诊断、3 路 Agent 混合 TLS 库并发自动解析不报错 |
| 2 | actrailctl 控制命令（launch/stop/list-traces/doctor/clean） | <font color=green>■</font> | 主流程通过；错误信息用户友好化 |
| 3 | actrailweb Web API/UI 查询展示 | <font color=green>■</font> | 查询/告警/action-tree 主流程通过；trace 的 LLM 动作已完整采集并在 web 展示 |
| 4 | actrailviewer 命令行查询展示 | <font color=green>■</font> | events/actions/payloads/alerts 查询正常，与 Web API 结果一致 |
| 5 | 插件系统（加载/卸载/告警/治理） | <font color=green>■</font> | activity-anomaly/file-leakage/tool-consecutive-failure-alert/command-policy 插件功能全部通过；容量字段默认配置下告警与溢出保护场景通过 |
| 6 | 命令/文件治理（allow/deny） | <font color=green>■</font> | command-policy allow/deny 生效，execve deny 事件与告警正常生成；文件操作（open/mkdir/rmdir）与命令执行（execve/execveat）的 allow/deny 治理判定及告警、eBPF 事件采集投影、进程树还原、host-ebpf / seccomp-notify 参数处理均通过；file-policy 通过 actrailweb 运行时配置即时生效 |
| 7 | Agent动作完整记录导出，支持审计 | <font color=green>■</font> | 导出插件最终为 Active，记录成功导出，且无丢弃、无积压、无错误。 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

AcTrail 用例适用产品标注为 arm 与x86，两者均已执行验证。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
| 采集开销 | 30轮运行Agent，端到端时延开销对比 | <5% | 通过（performance_001） |

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 长稳运行 | 单 Agent 长稳、daemon 异常退出恢复、终态分析 | 通过 |
| 容量保护 | activity-anomaly 溢出保护场景 | 通过：默认配置下候选溢出保护可验证 |
| 并发稳定性 | 高并发 Trace 启动 daemon 稳定性 | 通过：并发压测下 daemon 稳定运行 |

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 敏感明文持久化 | 默认配置下 LLM prompt/HTTP 头明文持久化情况 | 通过：LLM prompt 明文被持久化到 llm_request_blocks(风险可见)，HTTP Authorization/Bearer 及 API key 明文未被持久化(当前安全) |
| 基础安全 | 非法访问/权限控制 | 通过：非法访问与权限控制场景全部通过 |

## 4.4 资料测试结论
https://gitcode.com/openeuler/AcTrail 

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 资料测试 | 特性使用文档、命令/配置说明、FAQ 准确性 | 手动覆盖：CLI 命令、Web API、插件配置与文档描述一致，资料内容准确 |

## 4.5 其他测试结论

无

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-26.09-DevStation | 55 | 通过 55 / 失败 0（通过率 100%） | 6 |

本轮 55 个用例全部通过，通过率 100%，无失败用例。测试共发现确认问题 6 个，均已由开发侧整改并经回归验证确认修复，遗留问题为 0。

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

NA

# 6     附件

NA

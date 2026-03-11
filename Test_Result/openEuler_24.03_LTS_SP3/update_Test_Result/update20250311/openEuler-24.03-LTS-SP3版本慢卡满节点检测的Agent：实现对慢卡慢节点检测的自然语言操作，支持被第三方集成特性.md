# openEuler-24.03-LTS-SP3版本慢卡慢节点检测的Agent：实现对慢卡慢节点检测的自然语言操作，支持被第三方集成特性测试报告

> 状态：已完成 Manager 侧 openEuler 环境验证，框架侧联调与长稳项待补充

## 修订记录

| 日期 | 版本 | 修订说明 | 作者 |
| --- | --- | --- | --- |
| 2026/3/11 | 1.0 |  | 史鸿宇 |

**关键词**：witty-mcp-manager；witty-framework-lite；MCP；UDS；STDIO；SSE

**摘要**：
本报告面向 `witty-mcp-manager` 自身能力及其与 `witty-framework-lite` 的对接联调场景，覆盖健康检查、Server 注册发现、用户级启停、凭据配置、工具发现与调用、运行时会话、异常处理、权限隔离、性能与稳定性等测试内容。本次已在 openEuler 24.03 LTS SP3（aarch64）虚拟机环境完成 Manager 侧验证，共执行 48 个检查点，全部通过，未发现新增问题。验证结果表明：Manager 侧核心 API、STDIO/SSE 传输适配、用户隔离、基础异常处理、基础性能与并发能力表现正常；框架侧人工联调、长稳与更大规模压力项仍建议在后续轮次补充。

## 缩略语清单

| 缩略语 | 英文全称 | 说明 |
| --- | --- | --- |
| MCP | Model Context Protocol | 模型上下文协议 |
| UDS | Unix Domain Socket | 本地 Unix 域套接字通信 |
| STDIO | Standard Input/Output | 子进程标准输入输出通信 |
| SSE | Server-Sent Events | 服务端推送事件流通信 |
| API | Application Programming Interface | 应用程序接口 |
| LLM | Large Language Model | 大语言模型 |

## 1 特性概述

`witty-mcp-manager` 是面向 Witty/openEuler AI 助手的通用 MCP Host/Loader，负责统一发现、管理和调用多来源 MCP Server，并通过 UDS 暴露本地 API，供 `witty-framework-lite` 进行工具发现与工具调用转发。

本次测试关注以下能力：

1. **Manager 侧基础能力**：健康检查、Server 注册发现、用户级启用/禁用、用户级配置、工具发现、工具调用、运行时会话管理。
2. **多传输适配能力**：支持 `STDIO` 与 `SSE` 两类 MCP Server。
3. **安全与隔离能力**：依赖 UDS 本地访问与 `X-Witty-User` 用户标识实现多用户隔离。
4. **框架联调能力**：`witty-framework-lite` 通过 UDS 调用 Manager API，聚合工具列表并转发 LLM 的工具调用请求。
5. **健壮性与 DFX 能力**：覆盖参数异常、依赖缺失、会话异常、权限异常、延迟、并发与资源稳定性。

## 2 特性测试信息

本节描述被测对象版本、测试输入与环境要求。若实际执行环境与下表不一致，应在回填时同步更新。

| 项目 | 内容 |
| --- | --- |
| 被测特性 | witty-framework-lite × witty-mcp-manager 对接特性 |
| Manager 版本 | `1.0.0` |
| 框架版本 | 待填写 |
| 目标 OS 版本 | openEuler 24.03 LTS SP3 |
| 测试依据 | 功能需求、接口定义及自动化验证能力 |
| 当前执行状态 | 已在 openEuler VM 完成 Manager 侧正式执行 |
| 测试时间 | 2026-03-11 |
| 测试轮次 | 第 1 轮 |

硬件/软件环境建议如下：

| 类别 | 环境要求 | 备注 |
| --- | --- | --- |
| 操作系统 | openEuler 24.03 LTS SP3 | 实际执行环境 |
| 架构 | aarch64 | 实际执行环境 |
| Python | 3.11+ | 与项目声明保持一致 |
| 守护进程 | `witty-mcp-manager` 运行中 | 已验证，可访问 `/run/witty/mcp-manager.sock` |
| 已发现 MCP Server | 12 个 | 含 rpm 与 admin 两类来源 |
| STDIO MCP | 已验证 | `cvekit_mcp` 工具发现与调用通过 |
| SSE MCP | 已验证 | `mcp_server_mcp` 工具发现通过 |
|                   |                            |                                              |

## 3 测试结论概述

## 3.1 测试整体结论

本轮已在 openEuler 24.03 LTS SP3（aarch64）虚拟机环境完成 Manager 侧特性验证，**共执行 48 个检查点，48 个通过，0 个失败，0 个跳过**。已确认的整体结论如下：

| 项目 | 结果 | 说明 |
| --- | --- | --- |
| 执行环境要求 | 已确认 | 相关测试需在 openEuler 目标环境执行 |
| 运行前置条件 | 满足 | UDS、本地守护进程、已安装 MCP Server 均已就绪 |
| 功能测试结果 | 通过 | 健康检查、注册发现、启停、配置、工具发现/调用、会话管理、传输方式、配置层级均通过 |
| 异常场景结果 | 通过 | 参数异常、依赖降级、会话异常、权限隔离场景均通过 |
| 基础性能与并发结果 | 通过 | `/health`、`/v1/servers`、工具发现延迟满足预期，5 并发用户工具调用全部通过 |

综合本轮执行结果，`witty-mcp-manager` Manager 侧核心能力整体质量良好，满足当前阶段发布与联调验证预期。需要说明的是，本轮主要覆盖 Manager 侧能力验证，框架侧人工联调、长稳和更高强度压力项未纳入本次自动执行范围，建议在后续轮次补充。

后续仍建议补充以下结果：

- 实际执行用例/检查点数量
- 通过 / 失败 / 阻塞 / 跳过数量
- 新发现缺陷数量及风险等级
- 是否达到发布准入条件

可参考如下结论写法回填：

> witty-framework-lite × witty-mcp-manager 特性本轮共执行 48 个测试项，主要覆盖 Manager 侧功能验证、异常处理、用户隔离、基础性能与并发测试。执行过程中未发现新增问题，全部检查点通过。当前版本 Manager 侧整体质量良好，满足当前阶段发布与联调准入要求；框架侧人工联调与长稳项建议在后续轮次补充验证。

建议回填的总体结论表如下：

| 测试类型 | 细分项 | 结论 |
| --- | --- | --- |
| 功能测试 | 继承特性测试 | 本轮未执行 |
| 功能测试 | 新增特性测试 | 质量良好 |
| 兼容性测试 | UDS/API/联调兼容性 | Manager 侧验证通过，框架联调待补充 |
| DFX专项测试 | 性能测试 | 质量良好（基础性能） |
| DFX专项测试 | 可靠性/韧性测试 | 质量良好（基础异常场景） |
| DFX专项测试 | 安全测试 | 质量良好 |
| 资料测试 | 文档与接口资料 | 已完成基础整理 |
| 其他测试 | 其他 | NA |

## 3.2 约束说明

1. Manager 仅支持本机 **UDS** 访问，请求路径依赖 `/run/witty/mcp-manager.sock`。
2. 所有业务 API 均需携带 `X-Witty-User` 请求头，以区分用户级启停、凭据与运行时会话。
3. `STDIO` 与 `SSE` 两类 MCP 的配置方式不同：前者使用 `env`，后者使用 `headers`，不可混用。
4. 运行时会话默认存在空闲回收策略，测试时需注意 `idle_ttl_sec` 对观察结果的影响。
5. 框架联调项依赖 `witty-framework-lite` 已完成 UDS 接入与工具调用转发逻辑，若未完成，仅可先执行 Manager 侧测试。
6. 本轮自动执行范围主要覆盖 Manager 侧能力验证，框架侧人工联调、长稳和更高规模压力测试未纳入本轮结果。
7. 性能测试结果受本地硬件、MCP 实现、网络连通性（SSE 场景）等因素影响，需结合实际环境解释。

## 3.3 遗留问题分析

### 3.3.1 遗留问题影响及规避措施

本轮执行未发现新增遗留问题。当前未见需要规避的已知高、中风险问题；如后续框架侧联调或长稳测试发现问题，再按下表补充。

| 问题单/链接 | 问题描述 | 影响范围 | 风险等级 | 规避措施 | 当前状态 |
| --- | --- | --- | --- | --- | --- |
| 待填写 | 待填写 | 待填写 | 待填写 | 待填写 | 待填写 |

### 3.3.2 问题统计

#### 3.3.2.1 问题数量

| 指标 | 高 | 中 | 低 | 已解决 | 遗留 |
| --- | --- | --- | --- | --- | --- |
| 数目 | 0 | 0 | 0 | 0 | 0 |
| 百分比 | NA | NA | NA | NA | NA |

#### 3.3.2.2 发现问题

| 序号 | 问题单/链接 | 问题描述 | 严重级别 | 状态 |
| --- | --- | --- | --- | --- |
| 1 | 暂无 | 本轮未发现新增问题 | 暂无 | 暂无 |

## 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

本特性以新增的 Manager API 与框架联调能力为主，本轮未单独拆分继承特性测试，故标记为“不涉及”。

### 4.1.2 新增特性测试结论

建议按能力域而不是逐条搬运原始测试表单，保持报告简洁。

| 序号 | 能力域 | 计划覆盖点 | 结论 |
| --- | --- | --- | --- |
| 1 | 健康检查（Health API） | 服务存活、字段完整性、`uptime_sec` 递增 | 通过，`server_count=12`，`uptime_sec` 递增正常 |
| 2 | Server 注册与发现（Registry API） | 列表、详情、来源类型、诊断信息、生效配置 | 通过，发现 12 个 Server，含 rpm/admin 两类来源 |
| 3 | 用户级启用/禁用 | enable/disable、生效验证、用户隔离 | 通过，启停状态切换正常，用户隔离生效 |
| 4 | 用户级凭据配置 | STDIO `env`、SSE `headers`、覆盖更新 | 通过，敏感值以 `secret://***` 形式回显 |
| 5 | 工具发现（Tools API） | schema 返回、缓存命中、强制刷新 | 通过，`cvekit_mcp` 发现 6 个工具，缓存与强制刷新生效 |
| 6 | 工具调用（Tool Call API） | 冷启动、会话复用、超时控制、多内容返回/错误回传 | 通过，冷启动约 951ms，会话复用约 686ms，超时错误可正确返回 |
| 7 | 运行时会话管理（Runtime API） | 会话列表、单会话查询、空闲回收、跨用户视图 | 通过，可查询活跃会话与单会话详情 |
| 8 | 传输方式适配 | STDIO / SSE 工具发现与调用一致性 | 通过，STDIO 与 SSE 传输识别正确，SSE 工具发现返回 7 个工具 |
| 9 | 配置层级覆盖 | 系统层 / 全局层 / 用户层优先级 | 通过，`tool_call_timeout_sec=600`、`idle_ttl_sec=600` 生效 |
|      |                                   |                                                 |                                                            |

> 注：本轮已完成 Manager 侧自动化验证；框架侧联调、对话上下文回写等仍待补充人工验证。

## 4.2 兼容性测试结论

本轮建议将兼容性测试聚焦于以下三个维度：

| 兼容维度 | 说明 | 结论 |
| --- | --- | --- |
| UDS 访问兼容性 | 通过 Unix Domain Socket 调用 Manager | 通过 |
| 多用户隔离兼容性 | 同进程不同用户请求下的启用状态、会话、凭据隔离 | 通过 |
| 多传输兼容性 | STDIO 与 SSE 两类 MCP 的发现/调用行为一致性 | 通过 |

若未开展跨 SP、跨版本升降级、上层软件兼容性测试，可在正式报告中注明“不涉及”。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 测试项 | 关注点 | 结论 |
| --- | --- | --- |
| `GET /health` 高频请求 | 平均延迟、P95、无超时 | 通过，平均 0.2ms，P95 0.2ms |
| 冷启动工具发现/调用 | 子进程启动开销、端到端耗时 | 通过，首次工具调用约 951ms，二次复用约 686ms |
| 缓存命中工具发现 | 缓存命中后的延迟收益 | 通过，P95 0.9ms |
| `GET /v1/servers` 列表查询 | 多 MCP 注册场景下的响应时间 | 通过，P95 0.7ms |
| 并发工具调用 | 多用户/单用户并发下的正确性与响应 | 通过，5 并发用户 5/5 成功 |

### 4.3.2 可靠性/韧性测试结论

| 测试项 | 关注点 | 结论 |
| --- | --- | --- |
| 依赖降级识别 | 缺失依赖时的诊断、状态标记与调用行为 | 通过，`git_mcp` 正确标记为 degraded，缺失 `python3-mcp` |
| 会话异常处理 | 不存在会话查询、超时调用等错误处理 | 通过，404 与超时返回符合预期 |
| 权限与隔离 | 普通用户视角与跨用户会话隔离 | 通过，普通用户 `all_users=true` 仅返回自身数据 |
| daemon 基本恢复能力 | 启动后能正常发现 Server 并提供 UDS 服务 | 通过 |
|                     |                                         |                                                         |

### 4.3.3 安全测试结论

| 测试项 | 关注点 | 结论 |
| --- | --- | --- |
| 请求身份校验 | 缺失 `X-Witty-User` 时拒绝访问 | 通过，返回 401 |
| 用户隔离 | 用户 A/B 的启用状态、会话、凭据不串用 | 通过 |
| 降级诊断 | 依赖缺失场景下给出诊断信息 | 通过 |
| 配置校验 | `env`/`headers` 类型与 transport 匹配校验 | 通过 |

## 4.4 资料测试结论

| 资料项 | 内容 | 结论 |
| --- | --- | --- |
| 特性说明 | 对外能力边界、接口语义、运行方式 | 已完成基础整理 |
| 测试设计 | 功能、异常、性能与联调覆盖范围 | 已完成基础整理 |
| 执行材料 | 命令、日志、关键响应样例 | 已补充本轮 openEuler 执行结果 |
| 其他 | NA | NA |

## 4.5 其他测试结论

| 类别 | 内容 | 结论 |
| --- | --- | --- |
| 其他 | NA | NA |

## 5 测试执行

## 5.1 测试执行统计数据

建议以“计划数 + 实际执行数 + 结果统计”的方式回填，避免仅写“成功/失败”而缺少上下文。

| 版本/轮次 | 执行状态 | 实际执行数 | 通过 | 失败 | 阻塞/跳过 | 问题单数 |
| --- | --- | --- | --- | --- | --- | --- |
| openEuler-24.03-LTS-SP3 / witty-mcp-manager 1.0.0 | 已完成 Manager 侧执行 | 48 | 48 | 0 | 0 | 0 |

说明：

- 本轮已执行 Manager 侧功能、异常、基础性能和基础并发验证，共 48 个检查点全部通过；
- 运行环境中共发现 12 个 MCP Server，Manager 服务正常启动并通过 UDS 对外提供能力；
- 框架联调项（如工具聚合、LLM 调用转发、对话上下文回写）仍需结合 `witty-framework-lite` 实际运行日志补充验证结果。

## 5.2 后续测试建议

1. **补齐框架侧联调测试**：重点验证工具聚合、LLM 工具调用转发和对话上下文回写。
2. **补齐长期稳定性数据**：若用于发布评审，建议增加 30 分钟以上持续对话、1000 次工具调用、daemon 重启恢复等数据。
3. **扩大并发与压力范围**：建议补测更高并发用户数、单用户超过 `max_concurrency` 上限的场景。
4. **保留本轮执行日志**：作为回归基线，便于后续版本对比。

## 6 附件

### 6.1 测试执行输出摘要

```text
════════════════════════════════════════════════════════════
  witty-mcp-manager 特性测试
  socket: /run/witty/mcp-manager.sock
  时间: 2026-03-11 10:50:53
════════════════════════════════════════════════════════════

  1.1-健康检查             3通过
  1.2-Server发现          4通过
  1.3-用户启用禁用         5通过
  1.4-凭据配置             2通过
  1.5-工具发现             4通过
  1.6-工具调用             4通过
  1.7-会话管理             3通过
  1.8-传输方式             3通过
  1.9-配置层级             2通过
  2.1-参数异常             6通过
  2.2-依赖异常             3通过
  2.3-会话异常             3通过
  2.4-权限隔离             2通过
  3.1-响应延迟             3通过
  3.2-并发能力             1通过

  总计: 48/48 通过  ✓  0 跳过
```

### 6.2 服务启动日志摘录

```text
== active ==
active
== socket ==
srw-rw-rw- 1 root root 0 3月11日 10:50 /run/witty/mcp-manager.sock
== recent logs ==
Started Witty MCP Manager - Universal MCP Host/Loader.
Starting Witty MCP Manager daemon...
No config file found, using defaults
Starting UDS HTTP server on /run/witty/mcp-manager.sock
Found 10 RPM servers in /opt/mcp-servers/servers
Found 2 RPM servers in /usr/lib/sysagent/mcp_center/mcp_config
Total servers discovered: 12
Discovered 12 MCP servers
Session recycler started (idle_ttl=600s, interval=60s)
Uvicorn running on unix socket /run/witty/mcp-manager.sock
```

### 6.3 关键 API 响应样例

#### 6.3.1 健康检查响应样例

```json
{
  "success": true,
  "data": {
    "status": "healthy",
    "version": "1.0.0",
    "uptime_sec": 12,
    "server_count": 12,
    "active_sessions": 0
  }
}
```

#### 6.3.2 Server 详情响应样例

```json
{
  "diagnostics": {
    "command_allowed": true,
    "command": "uv",
    "allowed_commands": [],
    "deps_missing": {
      "system": [],
      "python": []
    },
    "files_valid": true,
    "errors": [],
    "sse_reachable": null
  },
  "effective_config": {
    "transport": "stdio",
    "tool_call_timeout_sec": 600,
    "idle_ttl_sec": 600,
    "max_concurrency": 5,
    "env": {
      "LANG": "en_US.UTF-8"
    }
  }
}
```

#### 6.3.3 工具发现响应样例

```json
{
  "tools_count": 6,
  "cache_info": {
    "cached_at": "2026-03-11T02:50:56.417824Z",
    "expires_at": "2026-03-11T03:00:56.417824Z",
    "from_cache": false
  },
  "sample_tool": {
    "name": "parse_issue",
    "fields": [
      "name",
      "description",
      "inputSchema"
    ]
  }
}
```

#### 6.3.4 工具调用与异常返回样例

```json
{
  "first_call": {
    "code": 200,
    "elapsed_ms": 951,
    "content": [
      {
        "type": "text",
        "text": "Parse Issue failed: Command ['cvekit', '--action=parse-issue', '--json', '--cve-id=CVE-2021-44228', '--gitee-token=None'] returned non-zero exit status 1."
      }
    ]
  },
  "timeout_case": {
    "code": 200,
    "isError": true,
    "content": [
      {
        "type": "text",
        "text": "Tool call timed out after 0.001s"
      }
    ]
  }
}
```

### 6.4 基础性能数据摘录

```text
GET /health 并发1 × 100次：平均 0.2ms，P95 0.2ms
缓存命中工具发现：P95 0.9ms
GET /v1/servers：P95 0.7ms
5 并发用户工具调用：5/5 成功
```

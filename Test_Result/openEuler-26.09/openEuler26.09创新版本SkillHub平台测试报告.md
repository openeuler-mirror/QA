![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对"本文档"的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称"CC BY-SA 4.0")的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026/09/14 | V1.0 | 完成 | 魏机会 |

关键词：SkillHub，AI Agent Skills，生态收集，安全审计，SkillSpector，CLI

摘要：
SkillHub 是面向 AI Agent 的 Skills 检索与分发平台，基于 FastAPI + Vue 3 构建，形成"收集 → 审计 → 索引 → 分发 → 治理"闭环。平台定时自动收集社区与三方 Skill 入库（增量发现 + 幂等去重 + 多源覆盖 GitHub/GitCode），入库即触发 SkillSpector 安全审计（68 项检查 × 17 大类，0-100 风险评分），风险分与结构化报告异步回写；配合 openEuler-skills 锚定贡献仓库实现"索引即治理"（PR 门禁 + skill_id 三方不变式）；同时提供 wittyhub CLI 实现脚手架生成（init）、规范校验（validate）、安装（install）、安全报告（audit）、管理清理（list/remove）与搜索发现（search/get）等能力，CLI 与 Web 站点同源同数据。

本报告覆盖 SkillHub 平台全量功能测试（冒烟/生态收集/锚定门禁/CLI/后端 API/安全审计/前端 Web/部署配置）、安全测试、性能测试、可靠性测试与资料测试，共计执行 50 个用例，全部通过。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| SkillSpector | Skill Security Inspector | Skill 安全审计扫描器（68 项检查 × 17 大类） |
| SSRF | Server-Side Request Forgery | 服务端请求伪造 |

# 1     特性概述

SkillHub 平台提供以下基本能力：

(1) 生态自动收集：skillcrawler 定时触发 discover，多源仓库扫描（GitHub/GitCode）、增量发现（commit 比对）、幂等去重、自动分类，Skill 入库即自动触发 SkillSpector 异步审计（审计失败不阻塞入库）；

(2) 锚定贡献仓库与 PR 门禁：openEuler-skills 公开锚定仓库接收社区贡献，PR CI 执行规范校验 + audit-by-url 安全门禁，合入后平台收录；skill_id 在平台/锚点/上游三方保持不变式；

(3) 多级安全检测：SkillSpector 68 项检查 × 17 大类，0-100 风险评分；入库自动审计、SkillspectorCollector 后台轮询回写风险分与结构化报告；

(4) CLI 工具：wittyhub init / validate / install / audit / list / remove / search / get，与 Web 站点同源同数据（同一套 REST API）；

(5) Web 浏览：首页列表、搜索、筛选、排序、分页、详情、下载；

(6) 部署运维：Docker Compose 一键部署、健康检查、启动依赖链（DB → API → 前端），skillspector 审计栈按需启动。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 26.09 | 2026-09-07 | 2026-09-14 |
|          |              |              |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| x86_64 虚拟机 | 8 vCPU / 16 GB 内存 | 基础环境：Docker Compose 部署 api/postgres/web |

# 3     测试结论概述

## 3.1   测试整体结论

SkillHub 平台特性测试，共计执行 50 个用例，主要覆盖了功能测试、安全测试、性能测试、可靠性测试和资料测试，用例全部通过，无遗留问题，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 不涉及 |
| 功能测试 | 新增特性测试 | 质量良好 |
| 兼容性测试 | 不涉及 | 不涉及 |
| DFX专项测试 | 性能测试 | 质量良好 |
| DFX专项测试 | 可靠性/韧性测试 | 质量良好 |
| DFX专项测试 | 安全测试 | 质量良好 |
| 资料测试 | 文档有效性 | 质量良好 |
| 其他测试 | 不涉及 | 不涉及 |

## 3.2   约束说明

1. 平台通过 Docker Compose 部署（api/postgres/web），审计栈需通过 `--profile skillspector` 按需启动（Jenkins + SkillSpector）；降级类用例以 mock Jenkins 代替真实环境执行；
2. 生态收集依赖可访问 GitHub/GitCode 的公网环境，网络受限场景下相关用例无法执行；
3. 管理接口需配置 ADMIN_API_TOKEN；GET /audit-by-url/report 按设计无鉴权（供 PR 评审直接打开报告链接）；
4. CLI 要求 Python ≥ 3.10，安装目录约定 ~/.agents/skills/，telemetry 上报与安装解耦；
5. 特性依赖（PostgreSQL/pgvector、Meilisearch、FastAPI、Vue 3、Jenkins、git 等）均为开源组件，公开可获得，依赖自闭环，无闭源二进制依赖。

## 3.3   问题分析
### 3.3.1 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 6        | NA   | 3    | 3   | NA     |
| 百分比 |      |      |  50%    |   50%   |        |

### 3.3.2 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
| https://gitcode.com/openeuler/wittyhub/issues/4       | 并发create审计数据没有幂等去重       | 主要       | NA                | 已修复       |
| https://gitcode.com/openeuler/wittyhub/issues/6       | [Bug] 管理接口错误 Token 返回 401 而非预期的 403       | 次要       | NA                | 已修复       |
| https://gitcode.com/openeuler/wittyhub/issues/7       | [Bug] discover 路径 Jenkins 触发失败时不落库 unknown 审计记录       | 次要       | NA                | 已修复       |
| https://gitcode.com/openeuler/wittyhub/issues/8       | [Bug] SkillspectorCollector 单条失败回滚后批次被 MissingGreenlet 中断       | 次要       | NA                | 已修复       |
| https://gitcode.com/openeuler/wittyhub/issues/9       | [Bug] 已直接收录的仓库登记进锚定仓库后清单来源不迁移       | 主要       | NA                | 已修复       |
| https://gitcode.com/openeuler/wittyhub/issues/10      | [Bug] security_audits 表因存储完整 skillspector_report 导致单行数据膨胀至 85 MB       | 主要       | NA                | 已修复       |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

不涉及（SkillHub 为本版本全新平台，全部特性均为新增）。

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 全栈端到端冒烟 | <font color=green>■</font> | 部署→收集→审计→搜索→安装→卸载主链路 |
| 2 | 生态自动收集 | <font color=green>■</font> | 定时调度/增量发现/幂等去重/无 SKILL.md 处理/审计联动/tag 版本快照 |
| 3 | 锚定贡献仓库与 PR 门禁 | <font color=green>■</font> | CI 收录/skill_id 三方不变式/audit-by-url 两模式/异步轮询与报告下载 |
| 4 | CLI 命令行工具 | <font color=green>■</font> | init/validate/install/audit/list/remove |
| 5 | 后端 REST API | <font color=green>■</font> | 列表/筛选/详情/版本历史/下载/审计查询与触发/telemetry/版本排序 |
| 6 | 安全审计（SkillSpector） | <font color=green>■</font> | 入库自动审计/评分映射/降级容错/Collector 轮询回写/tagged 版本回写 |
| 7 | 前端 Web | <font color=green>■</font> | 首页/搜索/分页/下载 |
| 8 | 部署与配置 | <font color=green>■</font> | 一键部署/生产配置校验/审计栈按需启动/启动依赖链 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

不涉及（平台仅在 openEuler 上运行，无跨平台/多版本兼容性测试需求）。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
| API 基准性能 | 列表/详情/搜索接口响应时间（P95） | < 500 ms | 通过 |
| API 基准性能 | 100 并发下错误率 / 吞吐 | 0% / ≥ 500 req/s | 通过 |
| 收集器批量处理 | 多仓库 discover 单轮耗时（10 仓库） | < 10 min | 通过 |
| 收集器批量处理 | 长稳运行内存/磁盘占用 | 无持续增长（无泄漏） | 通过 |

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 服务重启恢复 | api/web/postgres 容器重启后服务自愈、数据不丢失 | 测试通过 |
| 并发一致性 | 并发下载/安装/审计触发下 download_count 与审计状态无错乱 | 测试通过 |
| 长稳运行 | 收集器连续多轮 discover + Collector 持续轮询，无重复入库/重复记录/资源泄漏 | 测试通过 |

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| Admin 鉴权 | 无/错 Token 返回 401/403，覆盖全部管理接口；report 端点按设计无鉴权 | 测试通过 |
| SSRF 防护 | audit-by-url 内网地址/非 git 协议拒绝，校验先于网络访问 | 测试通过 |
| 命令注入防护 | skill_id/branch/filename 特殊字符安全处理 | 测试通过 |
| 接口限流 | telemetry 10/min 超限返回 429 | 测试通过 |
| CORS | 白名单配置与安全响应头 | 测试通过 |

## 4.4 资料测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 文档有效性 | README/部署文档/CLI --help 与实际命令一致，可按文档完成部署与安装 | 测试通过 |

资料 PR 链接：
- https://gitcode.com/openeuler/wittyhub
- https://gitcode.com/openeuler/wittyhub/tree/master/doc


# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 26.09| 50 | PASS | 6 |

## 5.2   后续测试建议
下次生产部署时重点关注 Jenkins 审计链路，保障 skillspector 可用和正常回写；


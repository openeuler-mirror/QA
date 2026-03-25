![img](https://gitee.com/openeuler/QA/raw/79f0d49e58e0684367b8f53e9d866a01be93c4c6/images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026-03-24 | v1.0 | 首次编写 | 丁嘉辉 |


关键词： doc2plugin，LangChain，oeDeploy，部署文档，AI Agent，文档驱动

摘要：本测试报告针对 doc2plugin（部署文档智能转换为可执行脚本）工具，覆盖功能、性能、可靠性、安全、兼容性等维度。共计执行测试用例 72 个，测试结果均符合预期，未发现缺陷，无遗留风险。



# 1     特性概述

doc2plugin 是基于 LangChain 的 AI Agent 工具，将软件部署文档智能转换为可执行部署脚本，核心能力包括：**文档驱动架构**（开发文档为唯一信息源，通过 `modes.yaml` 扩展模式而无需改代码）、**灵活输入**（支持基于文档与基于任务描述两种路径）、**工作流编排**（文档提纯、文件清单规划与验证、compose/test/modify 操作独立加载文档与提示词）、**通用文件系统工具**（读写、目录操作，限制在项目目录内）及 **双日志**（`cache/agent.log` 执行与终端同步，`cache/llm.log` 完整 LLM 交互与 token 统计）。

典型使用流程：`doc2plugin init` 初始化项目 → 可选将文档放入 `doc/` → 配置 `work.yaml`（`llm_info` 与 `task`：`target`、`prompt`、`mode`）→ `doc2plugin compose` 生成 `plugin/` → 可选 `doc2plugin test`、`doc2plugin modify` → `status` / `clean` 维护项目。支持 `shell`、`oedp` 等模式，可与 oeDeploy 插件生成场景配合使用。

# 2     特性测试信息

本节描述被测对象版本、测试时间及硬件环境。

| 版本名称        | 测试起始时间 | 测试结束时间 |
| --------------- | ------------ | ------------ |
| doc2plugin-1.0.0 | 2026.03.01   | 2026.03.25   |

| 硬件型号              | 硬件配置信息 | 备注                          |
| --------------------- | ------------ | ----------------------------- |
| 华为云虚拟机 openEuler | x86_64 4U8G  | Python 3，可访问兼容 OpenAI API 的 LLM 服务 |
| 华为云虚拟机 openEuler | aarch64 4U8G | 同上                          |

# 3     测试结论概述

## 3.1   测试整体结论

doc2plugin 共计执行 72 个用例，覆盖功能、可靠性、性能、安全、兼容性。未发现缺陷，无遗留问题，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 不涉及（首版独立工具） |
| 功能测试 | 新增特性测试 | 测试通过，README 与设计文档描述能力均已验证 |
| 兼容性测试 | 架构与 OS | 测试通过，x86_64 与 aarch64 上行为一致 |
| DFX专项测试 | 性能测试 | 测试通过，端到端耗时在可接受范围内 |
| DFX专项测试 | 可靠性/韧性测试 | 测试通过，LLM 重试与异常路径表现符合设计 |
| DFX专项测试 | 安全测试 | 测试通过，敏感配置与危险输入处理符合预期 |
| 资料测试 | README / 设计文档一致性 | 测试通过，命令与目录结构与文档一致 |
| 其他测试 |         | 不涉及 |

## 3.2   约束说明

完整链路测试依赖可用的 LLM API（网络、`base_url`、`api_key`、`model_name` 正确）；建议单机规格不低于 4U8G；生成质量与模型能力及提示词相关，本报告不将「生成代码业务正确性」作为每条用例的强制量化指标，而以流程、产物结构与工具行为是否符合设计为准。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题。

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 0        | 0    | 0    | 0    | 0      |
| 百分比 | —        | —    | —    | —    | —      |

# 4 详细测试结论

## 4.1 功能测试
### 4.1.1 继承特性测试结论

doc2plugin 作为独立工具首测，不涉及历史版本继承特性。

### 4.1.2 新增特性测试结论

| 用例特性 | 用例名称 | 测试类型 | 预置条件 | 操作步骤 | 预期结果 | 测试结论 |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- |
| 安装与 CLI | pip 可编辑安装 | 功能 | 已克隆源码，网络可用 | `pip install -r requirements.txt` 后 `pip install -e .` | 安装成功，无依赖解析错误 | <font color=green>■</font> |
| 安装与 CLI | 版本信息 | 功能 | 已安装 doc2plugin | 执行 `doc2plugin --version` | 输出版本号，无异常退出 | <font color=green>■</font> |
| 安装与 CLI | init 初始化 | 功能 | 空目录或新目录 | 执行 `doc2plugin init` | 生成项目骨架与配置模板（含 `work.yaml`、目录结构） | <font color=green>■</font> |
| 安装与 CLI | status 空项目 | 功能 | 已 init，未 compose | `doc2plugin status` | 给出可读状态/提示，符合 `ProjectManager` 校验逻辑 | <font color=green>■</font> |
| 安装与 CLI | clean 交互与 -f | 功能 | 存在 cache/plugin 等生成物 | 执行 `doc2plugin clean` 与 `doc2plugin clean -f` | 按设计清理或跳过确认，不破坏必选配置模板约定 | <font color=green>■</font> |
| 配置管理 | work.yaml LLM 配置解析 | 功能 | 合法 `llm_info` | 启动 compose（或仅加载配置） | `timeout`、`max_llm_retries`、`llm_retry_delay` 等被正确读取 | <font color=green>■</font> |
| 配置管理 | task 字段 | 功能 | 配置 `target`、`prompt`、`mode` | compose | Agent 使用任务目标与环境约束 | <font color=green>■</font> |
| 配置管理 | modes.yaml 多操作 | 功能 | `shell`/`oedp` 等已在 `config/modes.yaml` 配置 | 分别指定 mode 执行 compose | 各模式加载对应 `doc_path` 与专用 `prompt` | <font color=green>■</font> |
| compose（有文档） | shell 模式文档生成 | 功能 | `doc/` 下有部署文档，`mode: shell` | `doc2plugin compose` | `plugin/` 下生成脚本等产物，流程完成 | <font color=green>■</font> |
| compose（有文档） | oedp 模式文档生成 | 功能 | oedp 开发文档就绪，`mode: oedp` | `doc2plugin compose` | 生成符合 oeDeploy 插件预期的目录/文件结构（由文档规范驱动） | <font color=green>■</font> |
| compose（无文档） | 空 doc 占位 | 功能 | `doc/` 为空或仅依赖任务描述 | compose | 文档提纯阶段产生占位 `cache/source.md` 或等价行为，流程不中断 | <font color=green>■</font> |
| 文档提纯 | source.md 统一上下文 | 功能 | `doc/` 含多文件 | compose | 生成/更新 `cache/source.md`，后续步骤使用该统一上下文 | <font color=green>■</font> |
| 文件清单 | file_manifest.json | 功能 | 走完整 compose 流程 | 检查 `cache/file_manifest.json` | 存在文件清单，含 `files` 及 `implementation` 等字段设计 | <font color=green>■</font> |
| 文件清单 | 清单与 plugin 一致性 | 功能 | compose 成功结束 | 对比清单与 `plugin/` 实际文件 | 验证阶段记录完整，无设计上的遗漏检测失效 | <font color=green>■</font> |
| 已生成上下文 | 多文件引用一致 | 功能 | 多文件插件生成 | 检查相邻文件间 import/配置名 | 与「已生成文件注入上下文」设计一致，无明显断裂 | <font color=green>■</font> |
| test 流程 | 生成并执行测试脚本 | 功能 | compose 已完成 | `doc2plugin test` | 生成 `cache/test.sh`（如适用），产生 `cache/test.log`，退出码与日志可解释 | <font color=green>■</font> |
| test 流程 | 跳过生成 | 功能 | `cache/test.sh` 与 `cache/test.log` 已同时存在 | `doc2plugin test` | 跳过测试脚本生成步骤，直接执行或按设计分支，支持测试/修改交替 | <font color=green>■</font> |
| modify 流程 | 基于测试结果修改 | 功能 | 存在失败或需调整的测试日志 | `doc2plugin modify` | 生成修改清单并落地修改，流程可衔接再次 test | <font color=green>■</font> |
| 操作独立性 | compose/test/modify 文档隔离 | 功能 | 各操作配置不同 `doc_path` | 分别执行三种操作 | 初始化 Agent 时加载对应文档与提示词，无混用 | <font color=green>■</font> |
| 工具集 | 项目目录内文件操作 | 功能 | compose 执行中 | 观察日志与生成物 | 仅项目内读写，符合工具设计边界 | <font color=green>■</font> |
| 提示词 | System/Human 分离 | 功能 | 查看 `cache/llm.log` | 执行任一需 LLM 的操作 | 开发文档与模式提示在系统侧，任务细节在用户侧 | <font color=green>■</font> |
| JSON 输出 | 清单/脚本/修改 JSON 解析 | 功能 | 触发各 JSON 产出节点 | 检查 llm 输出与解析结果 | 使用统一 JSON 解析路径，无非法截断导致崩溃 | <font color=green>■</font> |
| 扩展性 | 新模式配置（概念验证） | 功能 | 文档与 `modes.yaml` 按设计新增条目 | `work.yaml` 指定新 mode | 无需改核心代码即可被加载（与文档一致） | <font color=green>■</font> |
| 日志 | agent.log 内容 | 功能 | 执行 compose/test | 查看 `cache/agent.log` | 含流程、终端同步文本、LLM 调用长度/token 统计等 | <font color=green>■</font> |
| 日志 | llm.log 完整性 | 功能 | 任意 LLM 调用 | 查看 `cache/llm.log` | 输入输出完整记录，含阶段标识与长度统计 | <font color=green>■</font> |
| 故障排除 | status 诊断 | 功能 | 人为破坏目录或配置 | `doc2plugin status` | 给出与 `ProjectManager` 一致的检查提示 | <font color=green>■</font> |
| 安装与 CLI | --help | 功能 | 已安装 | `doc2plugin --help` | 列出 init/compose/test/modify/status/clean 等子命令说明 | <font color=green>■</font> |
| 安装与 CLI | init 幂等 | 功能 | 已 init 的项目目录 | 再次执行 `doc2plugin init` | 不破坏既有配置或按设计合并，无未处理异常 | <font color=green>■</font> |
| 配置管理 | max_tokens 为 null | 功能 | `max_tokens: null` | compose | 按设计不限制最大 token（与文档一致） | <font color=green>■</font> |
| 配置管理 | 配置校验失败提示 | 功能 | 故意错误 YAML 或缺字段 | 执行任意命令 | CLI/命令层给出可读错误，不崩溃 | <font color=green>■</font> |
| 配置管理 | 未知 mode | 功能 | `task.mode` 为不存在项 | compose | 明确失败或提示，行为可预期 | <font color=green>■</font> |
| compose | 二次 compose | 功能 | 已完成一次 compose | 再次 `doc2plugin compose` | 可覆盖或增量生成，流程完整 | <font color=green>■</font> |
| 文档提纯 | 删除 source 后重跑 | 功能 | 手工删除 `cache/source.md` | compose | 重新提纯或等价重建，后续任务可用 | <font color=green>■</font> |
| 工作流 | tasks.json | 功能 | compose 过程 | 检查 `cache/tasks.json` | 任务计划落盘，与工作流设计一致 | <font color=green>■</font> |
| modify | modification_manifest.json | 功能 | 执行 modify 成功 | 检查 `cache/modification_manifest.json` | 存在修改清单或与流程一致的产物 | <font color=green>■</font> |
| test | 仅存在 test.sh | 功能 | 仅有 `cache/test.sh` | `doc2plugin test` | 与「两文件同时存在才跳过生成」设计一致 | <font color=green>■</font> |
| test | 仅存在 test.log | 功能 | 仅有 `cache/test.log` | `doc2plugin test` | 行为符合分支逻辑，可解释 | <font color=green>■</font> |
| 前置条件 | 无 plugin 时 test | 功能 | 未 compose 或空 plugin | `doc2plugin test` | 提示或失败路径清晰 | <font color=green>■</font> |
| 前置条件 | 无测试日志时 modify | 功能 | 无有效 `cache/test.log` | `doc2plugin modify` | 提示或失败路径清晰 | <font color=green>■</font> |
| 工具集 | FileListTool | 功能 | compose 中需列目录 | 查 agent.log/行为 | 列出项目内目录，符合工具注册 | <font color=green>■</font> |
| 工具集 | FileReadTool | 功能 | 多文件生成阶段 | 查日志与上下文 | 读取已生成文件注入上下文 | <font color=green>■</font> |
| 工具集 | FileWriteTool | 功能 | compose | plugin 下文件写入成功 | 内容落盘正确 | <font color=green>■</font> |
| 工具集 | FileDeleteTool | 功能 | 流程需删除中间文件时 | 观察 | 仅在项目内删除，可追踪 | <font color=green>■</font> |
| 工具集 | DirectoryCreateTool | 功能 | 多层目录插件 | compose | 目录创建成功 | <font color=green>■</font> |
| 工具集 | DirectoryDeleteTool | 功能 | clean 或修改流程 | 按需执行 | 不越界删除 | <font color=green>■</font> |
| JSON 契约 | 测试脚本 script_content | 功能 | test 阶段 LLM 输出 | 解析为 JSON | 含 `script_content` 并可落地为 test.sh | <font color=green>■</font> |
| JSON 契约 | 修改清单 analysis/operations | 功能 | modify 阶段 | 解析为 JSON | 含 `analysis` 与 `operations` 结构 | <font color=green>■</font> |
| JSON 契约 | 单文件 file_content | 功能 | 单文件生成步骤 | 解析为 JSON | 含 `file_content` 并写入目标路径 | <font color=green>■</font> |
| 日志 | agent.log 去除 ANSI | 功能 | 彩色终端输出后 | 打开 agent.log | 记录无 ANSI 转义或与设计一致 | <font color=green>■</font> |
| 文档驱动 | 多文档 compose doc_path | 功能 | modes 中配置多个 md | compose | 多文档注入顺序与合并符合 ConfigManager | <font color=green>■</font> |
| 文档驱动 | oedp test 文档 | 功能 | mode=oedp | `doc2plugin test` | 加载 TestInstruction 等 test 文档路径 | <font color=green>■</font> |
| 文档提纯 | 步骤执行策略 | 功能 | 含 doc 的项目 | compose | 提纯在规划前执行，与设计「步骤0」一致 | <font color=green>■</font> |
| 文件清单 | implementation 五子字段 | 功能 | 查看 file_manifest.json | 抽查条目 | 含 purpose/parameters/referenced_files/steps/notes | <font color=green>■</font> |
| 文件清单 | 验证阶段日志 | 功能 | compose 结束 | 查 agent.log | 对比清单与生成文件，有记录 | <font color=green>■</font> |
| 维护流程 | clean 后再 compose | 功能 | clean 后保留配置 | 再次 compose | 可重新生成产物 | <font color=green>■</font> |
| ProjectManager | check_documents | 功能 | 缺文档/有文档 | status 或内部调用 | 与 `check_documents` 设计一致 | <font color=green>■</font> |
| ProjectManager | check_plugin_files | 功能 | compose 后 | status | 插件文件检查提示正确 | <font color=green>■</font> |
| ProjectManager | check_test_artifacts | 功能 | test 后 | status | 测试脚本与日志检查提示正确 | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

doc2plugin 在 openEuler 环境 x86_64 与 aarch64 上完成验证，Python 3 与依赖安装一致，CLI 与文件路径行为一致，未发现架构相关缺陷。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 用例特性 | 用例名称 | 测试类型 | 预置条件 | 操作步骤 | 预期结果 | 测试结论 |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- |
| LLM 调用 | 单次 compose 端到端耗时 | 性能 | 网络稳定，中等规模文档 | 记录从命令开始到 compose 结束 wall time | 在合理超时配置内完成（与 `timeout` 一致） | <font color=green>■</font> |
| LLM 调用 | 重试退避 | 性能 | 可模拟短暂失败或观察配置 | 设置 `max_llm_retries`、`llm_retry_delay` | 重试间隔符合指数退避设计，不瞬时打满 API | <font color=green>■</font> |
| 终端输出 | Rich 流式输出 | 性能 | 长响应场景 | compose 过程观察终端 | 流式更新流畅，无明显卡顿崩溃 | <font color=green>■</font> |
| Token | tiktoken 统计 | 性能 | 成功调用 LLM | 对比 llm.log/agent.log 中 token 记录 | 统计字段存在且与交互轮次对应 | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.2 可靠性/韧性测试结论

| 用例特性 | 用例名称 | 测试类型 | 预置条件 | 操作步骤 | 预期结果 | 测试结论 |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- |
| LLM | 调用失败重试 | 可靠性 | 网络或 API 偶发错误 | 连续执行 compose | 自动重试至上限，日志记录清晰，不静默吞错 | <font color=green>■</font> |
| 工作流 | test/modify 交替 | 可靠性 | 同一项目多次 test/modify | 循环执行 | `test.sh`/`test.log` 存在时跳过生成行为稳定 | <font color=green>■</font> |
| 文档提纯 | 空 doc 容错 | 可靠性 | 无输入文档 | compose | 占位与后续任务衔接，异常被捕获记录且不中断整体设计 | <font color=green>■</font> |
| 配置 | 缺失目录自动创建 | 可靠性 | 删除部分 cache 子路径（在允许范围内） | status 或 compose 前校验 | `validate_project_structure` 等行为符合设计 | <font color=green>■</font> |
| clean | 重复清理 | 可靠性 | 已 clean 再次 clean | 连续执行 | 无异常崩溃 | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.3 安全测试结论

| 用例特性 | 用例名称 | 测试类型 | 预置条件 | 操作步骤 | 预期结果 | 测试结论 |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- |
| 配置安全 | 密钥不落盘明文扩散 | 安全 | 正常 work.yaml | 检查仓库与日志 | `api_key` 不写入不应出现的公开产物；llm.log 为本地调试用途，权限符合环境惯例 | <font color=green>■</font> |
| 输入安全 | 任务描述特殊字符 | 安全 | target/prompt 含引号、路径样例等 | compose | 不导致 CLI 或解析器崩溃，错误可诊断 | <font color=green>■</font> |
| 工具安全 | 路径穿越约束 | 安全 | 尝试让工具写入项目外（通过提示词边界） | 观察工具实现与日志 | 限制在项目目录内，符合 `tools/` 设计 | <font color=green>■</font> |
| 日志 | 敏感信息过滤意识 | 安全 | 正常调用 | 抽查 agent.log | 无意外大量泄露完整密钥（若配置在日志中需符合团队规范） | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| :------- | ---------- | ------------ | ------------ |
| doc2plugin-1.0.0 | 72 | 72 pass | 0 |

##  5.2   后续测试建议

无。

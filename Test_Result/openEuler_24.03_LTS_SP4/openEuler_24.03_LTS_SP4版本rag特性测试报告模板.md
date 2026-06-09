![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026/6/9 | 1.0 | 初稿完成 | 赵家麒 |


关键词：RAG、检索增强、向量数据库、知识库、文档解析、召回率

摘要：
本文档针对 euler-copilot-rag 特性在 openEuler-24.03-LTS-SP4-round5 阶段进行系统测试，覆盖功能测试、可靠性测试及性能召回测试。共计执行 320 个用例（200 功能 + 120 可靠性），通过 6000+ 条 QA 对验证召回率，整体功能正常，可靠性满足要求，召回率 85.43% 大于 85% 目标值。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| RAG | Retrieval-Augmented Generation | 检索增强生成 |
| QA | Question Answering | 问答 |
| KB | Knowledge Base | 知识库 |
| DFX | Design for X | 面向某特性的设计 |

# 1     特性概述

euler-copilot-rag 是面向 openEuler 智能问答系统的检索增强服务，提供数据管理、文档解析、向量化存储、混合检索及问答召回等核心能力。主要功能包括：

1. **文档解析**：支持 PDF（含 deep 解析）、DOCX、PPTX、TXT、MD、HTML、XLSX、YAML、JSON、图片等多种格式文档的解析与分块；
2. **向量化存储**：支持 Milvus、OpenGauss、Postgres、Qdrant 四种向量数据库的文档、chunk、JSON 数据管理；
3. **检索服务**：提供 doc2chunk 检索、混合检索（hybrid search）、JSON 检索等多模态检索能力；
4. **模型服务**：集成 Embedding、Rerank、LLM、OCR 等模型服务，支持异步调用；
5. **任务调度**：支持知识库导入、导出、文档解析、JSON 解析等异步任务队列；
6. **Agent 能力**：提供 witty_doc（文档上传）、witty_chunk（chunk 检索与提取）、test_recall（召回测试）等 skill 能力；
7. **安全与追踪**：支持 access_key 的 SHA256 哈希存库、trace 链路追踪及操作审计。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP4-round5 | 2026-05-20 | 2026-06-08 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 鲲鹏920 | CPU: 64核, 内存: 256GB, 磁盘: 2TB SSD | 兼容性验证 |

# 3     测试结论概述

## 3.1   测试整体结论

euler-copilot-rag 特性在 openEuler-24.03-LTS-SP4-round5 阶段共计执行 320 个用例（200 功能用例 + 120 可靠性用例），通过 6000+ 条 QA 对验证召回率达到 85.43%。主要覆盖了文档解析、向量存储、混合检索、任务调度、模型服务及 Agent 能力的全量功能测试和 7×24 小时长稳测试。发现的 38 个 issue 已修复并回归通过，无遗留风险，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | <font color=green>■</font> 质量良好 |
| 功能测试 | 新增特性测试 | <font color=green>■</font> 质量良好 |
| 兼容性测试 | 向量数据库兼容性（Milvus/OpenGauss/Postgres/Qdrant） | <font color=green>■</font> 质量良好 |
| DFX专项测试 | 性能测试（召回率/检索时延） | <font color=green>■</font> 召回率85.43%，满足≥85%要求 |
| DFX专项测试 | 可靠性/韧性测试 | <font color=green>■</font> 7×24长稳通过 |
| DFX专项测试 | 安全测试 | <font color=green>■</font> access_key哈希存储正常 |
| 资料测试 | README/开发文档/SKILL文档 | <font color=green>■</font> 资料完整 |
| 其他测试 | 多端兼容性（x86_64/ARM64） | <font color=green>■</font> 兼容正常 |

## 3.2   约束说明

1. 特性使用时需保证向量数据库（Milvus/OpenGauss/Postgres/Qdrant）服务可达，且网络延迟 < 50ms；
2. 大文件（>100MB）PDF 解析建议使用 deep 解析模式，但耗时较长，需异步任务支持；
3. 特性需保证在 openEuler 社区范围内依赖自闭环；当前已通过 venv 和 requirements.txt 管理 Python 依赖，所有依赖公开可获得。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

本轮测试共登记 38 个 issue（详见附件 6.1），其中 36 个已修复并回归验证通过，剩余 2 个遗留问题如下：

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- |
| 1 | #50 | 检索时延在极端大数据量场景下仍偏高 | 次要 | 仅影响百万级文档以上的检索响应 | 通过分库分表及缓存优化规避 | round5性能测试 |
| 2 | #56 | deep PDF解析模式在复杂排版文档中偶有遗漏 | 次要 | 仅影响极少数特殊排版PDF | 建议用户先转换为标准格式 | round5文档解析测试 |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 38 | 0 | 5 | 28 | 5 |
| 百分比 | 100% | 0% | 13.2% | 73.7% | 13.1% |

### 3.3.3 已发现问题按类型统计

本轮测试基于 rag_core 代码提交记录提取并登记 38 个 issue，均挂靠里程碑 **openEuler-24.03-LTS-SP4-round5**，按类型分布如下：

| 问题类型 | 数量 | 占比 | 说明 |
| -------- | ---- | ---- | ---- |
| [Bug] | 18 | 47.4% | 涵盖检索逻辑、PDF解析、向量存储、任务队列等模块的缺陷修复 |
| [Enhancement] | 7 | 18.4% | 文档完善、Dockerfile优化、依赖补充、测试脚本增强 |
| [Task] | 8 | 21.1% | 配置清理、打印关闭、模型思考过程关闭、嵌入方式调整等工程任务 |
| [Feature] | 4 | 10.5% | 新增 witty_doc skill、测试 skill、开发文档、默认值支持 |
| [Performance] | 1 | 2.6% | 检索时延优化专项 |
| **合计** | **38** | **100%** | |

按模块分布：
- **Parser（文档解析）**：8个 issue（#48, #49, #56, #57, #58, #59, #60, #61）
- **Vector DB（向量存储）**：10个 issue（#53, #54, #55, #63, #64, #69, #76, #77, #79, #81）
- **RAG/Service（检索与服务）**：8个 issue（#45, #50, #52, #54, #62, #68, #79, #81）
- **Agent/Skill**：5个 issue（#71, #73, #74, #75, #78）
- **Task/Deploy（任务与部署）**：5个 issue（#46, #47, #51, #66, #67）
- **Docs/Other**：2个 issue（#44, #72）

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 文档解析（PDF/DOCX/TXT/MD等） | <font color=green>■</font> | 解析准确率满足要求 |
| 2 | 向量存储（Milvus/OpenGauss/Postgres） | <font color=green>■</font> | 数据一致性验证通过 |
| 3 | 混合检索（Hybrid Search） | <font color=green>■</font> | 检索结果相关性良好 |
| 4 | Embedding/Rerank 模型服务 | <font color=green>■</font> | 异步调用性能稳定 |
| 5 | 任务调度与队列管理 | <font color=green>■</font> | 长任务不阻塞 |
| 6 | JSON 检索与逻辑表达式 | <font color=green>■</font> | 复杂条件检索正确 |

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | Qdrant 向量数据库适配 | <font color=green>■</font> | 新增适配，功能完整 |
| 2 | Deep PDF 解析模式 | <font color=green>■</font> | 支持表格、图片、文字提取 |
| 3 | witty_doc / witty_chunk Skill | <font color=green>■</font> | Agent 能力扩展 |
| 4 | test_recall 召回测试框架 | <font color=green>■</font> | 支持自动化召回评测 |
| 5 | access_key SHA256 哈希存储 | <font color=green>■</font> | 安全增强 |

## 4.2 兼容性测试结论

*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

本特性在 openEuler-24.03-LTS-SP4 上完成测试，同时在 x86_64 和 ARM64 架构上验证通过。向量数据库方面，Milvus、OpenGauss、Postgres、Qdrant 四个后端均完成兼容性验证，数据格式及 API 接口保持向后兼容。Python 依赖通过 requirements.txt 锁定版本，保证环境一致性。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
| 召回率 | QA对召回测试 | 85.43%（目标≥85%） | 满足要求 |
| 检索时延 | 千级文档检索 P99 | < 200ms | 满足要求 |
| 检索时延 | 万级文档检索 P99 | < 500ms | 满足要求 |
| Embedding | 单条文本嵌入时延 | < 50ms | 满足要求 |
| PDF解析 | 10页标准PDF解析时延 | < 3s | 满足要求 |
| 并发能力 | 10并发检索 | 成功率 100% | 满足要求 |

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 长稳测试 | 7×24小时持续检索服务 | 通过，无内存泄漏 |
| 异常输入 | 空文档/损坏PDF/超大文件 | 通过，异常处理正常 |
| 数据库故障 | 向量数据库断连后重连 | 通过，自动恢复 |
| 并发压力 | 100并发任务提交 | 通过，队列不阻塞 |
| 数据一致性 | 文档增删改后检索一致性 | 通过，无脏数据 |
| 故障恢复 | 服务重启后数据完整性 | 通过，数据无丢失 |
| 资源限制 | CPU/内存受限场景 | 通过， graceful degradation |
| 网络抖动 | 模拟网络延迟/丢包 | 通过，重试机制生效 |

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 认证鉴权 | access_key 有效性校验 | 通过 |
| 密码安全 | access_key SHA256 哈希存储 | 通过，无明文存储 |
| 输入校验 | SQL 注入/XSS 特殊字符过滤 | 通过 |
| 权限控制 | 知识库隔离访问 | 通过 |

## 4.4 资料测试结论
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 开发文档 | rag_core/docs/DEVELOPER_GUIDE.md | 通过，内容完整 |
| API文档 | rag_core/docs/README.md | 通过，接口描述清晰 |
| Skill文档 | agent/*/SKILL.md | 通过，使用说明完整 |

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 召回测试 | 6000+ QA对多维度召回评测 | 通过，召回率85.43% |
| Agent测试 | witty_doc/witty_chunk端到端 | 通过 |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP4-round5 | 320（200功能+120可靠性） | 全部通过 | 38 |
| 召回专项测试 | 6000+ QA对 | 召回率85.43% | 2（性能优化项） |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

### 功能用例分布（200个）

| 测试模块 | 用例数 | 说明 |
| -------- | ------ | ---- |
| 文档解析 | 35 | 覆盖PDF（标准/deep）、DOCX、PPTX、TXT、MD、HTML、XLSX、YAML、JSON、图片格式 |
| 向量化存储 | 40 | 覆盖Milvus/OpenGauss/Postgres/Qdrant的文档/Chunk/JSON增删改查 |
| 检索服务 | 35 | 覆盖doc2chunk检索、混合检索、JSON检索、逻辑表达式检索 |
| 模型服务 | 25 | 覆盖Embedding、Rerank、LLM、OCR的调用及异步处理 |
| 任务调度 | 20 | 覆盖知识库导入/导出、文档解析、JSON解析任务队列 |
| Agent Skill | 25 | 覆盖witty_doc、witty_chunk、test_recall端到端场景 |
| 服务接口 | 20 | 覆盖REST API、Schema校验、异常返回 |

### 可靠性用例分布（120个）

| 测试类型 | 用例数 | 说明 |
| -------- | ------ | ---- |
| 长稳测试 | 15 | 7×24小时持续运行，覆盖检索、解析、存储 |
| 异常输入 | 20 | 空文件、损坏文件、超大文件、特殊字符注入 |
| 数据库故障 | 15 | 断连、超时、主备切换、数据不一致恢复 |
| 并发压力 | 20 | 10/50/100并发检索、任务提交、文档上传 |
| 数据一致性 | 15 | 文档增删改后检索结果一致性验证 |
| 故障恢复 | 15 | 服务重启、容器重建、数据卷恢复 |
| 资源限制 | 10 | CPU/内存受限、磁盘满、网络受限 |
| 网络抖动 | 10 | 延迟、丢包、重连、超时 |

## 5.2   后续测试建议

1. 持续关注百万级文档量下的检索时延优化，建议引入缓存及预计算策略；
2. 针对复杂排版PDF（多栏、图文混排）的deep解析准确率进行专项提升；
3. 建议在后续版本中增加对更多向量数据库（如Weaviate、Pinecone）的适配验证；
4. 持续扩充召回测试数据集，目标覆盖10000+ QA对，进一步验证召回率稳定性。

# 6     附件

## 6.1 问题单详细清单


| 序号 | Issue单号 | 类型 | 问题简述 | 涉及模块 | 当前状态 |
| --- | --------- | ---- | ------- | ------- | -------- |
| 1 | [#44](https://gitcode.com/openeuler/euler-copilot-rag/issues/44) | Enhancement | 完善readme | docs, db_scalar, db_vector, service | 已完成 |
| 2 | [#45](https://gitcode.com/openeuler/euler-copilot-rag/issues/45) | Bug | 修复ratio为1的时候检索的bug | service/chunk.py | 已完成 |
| 3 | [#46](https://gitcode.com/openeuler/euler-copilot-rag/issues/46) | Enhancement | 完善dockerfile | deploy | 已完成 |
| 4 | [#47](https://gitcode.com/openeuler/euler-copilot-rag/issues/47) | Enhancement | 完善依赖 | deploy, docs | 已完成 |
| 5 | [#48](https://gitcode.com/openeuler/euler-copilot-rag/issues/48) | Bug | 修复deep pdf解析中image提取的逻辑 | parser/deep_pdf_parser.py | 已完成 |
| 6 | [#49](https://gitcode.com/openeuler/euler-copilot-rag/issues/49) | Bug | 修复deep pdf重复提取内容的问题 | parser/deep_pdf_parser.py, parser/pdf_parser.py | 已完成 |
| 7 | [#50](https://gitcode.com/openeuler/euler-copilot-rag/issues/50) | Performance | 优化检索时延 | rag/doc2chunk_searcher.py, hybrid_searcher.py, json_searcher.py, service/chunk.py, service/json.py | 已完成 |
| 8 | [#51](https://gitcode.com/openeuler/euler-copilot-rag/issues/51) | Enhancement | requirements.txt补充qdrant_client | deploy | 已完成 |
| 9 | [#52](https://gitcode.com/openeuler/euler-copilot-rag/issues/52) | Bug | 修复bug（document.py部署及deep测试脚本） | service/document.py, deploy/run.sh | 已完成 |
| 10 | [#53](https://gitcode.com/openeuler/euler-copilot-rag/issues/53) | Task | embedding和rerank使用异步 | model/embedding.py, model/rerank.py, db_vector/qdrant/manager/doc_manager.py | 已完成 |
| 11 | [#54](https://gitcode.com/openeuler/euler-copilot-rag/issues/54) | Bug | 修复chunk service的bug，增加doc enabled字段降低检索时延 | db_vector/*/manager/chunk_manager.py, service/chunk.py, service/document.py | 已完成 |
| 12 | [#55](https://gitcode.com/openeuler/euler-copilot-rag/issues/55) | Task | 适配opengauss存空变None的情况 | db_scalar/opengauss/convertor.py | 已完成 |
| 13 | [#56](https://gitcode.com/openeuler/euler-copilot-rag/issues/56) | Bug | 修复deep方法解析慢的问题 | parser/deep_pdf_parser.py | 已完成 |
| 14 | [#57](https://gitcode.com/openeuler/euler-copilot-rag/issues/57) | Bug | 修复表格提取的逻辑bug | parser/deep_pdf_parser.py | 已完成 |
| 15 | [#58](https://gitcode.com/openeuler/euler-copilot-rag/issues/58) | Bug | 修复表格提取的逻辑bug | parser/deep_pdf_parser.py | 已完成 |
| 16 | [#59](https://gitcode.com/openeuler/euler-copilot-rag/issues/59) | Bug | 修复deep pdf提取文字的bug | parser/deep_pdf_parser.py | 已完成 |
| 17 | [#60](https://gitcode.com/openeuler/euler-copilot-rag/issues/60) | Task | 批量处理pdf的页 | parser/deep_pdf_parser.py | 已完成 |
| 18 | [#61](https://gitcode.com/openeuler/euler-copilot-rag/issues/61) | Enhancement | 完善deep方法pdf的提取效果 | parser/deep_pdf_parser.py | 已完成 |
| 19 | [#62](https://gitcode.com/openeuler/euler-copilot-rag/issues/62) | Task | 关闭模型思考过程 | common/prompt.py, model/llm.py | 已完成 |
| 20 | [#63](https://gitcode.com/openeuler/euler-copilot-rag/issues/63) | Bug | 修复trace存库和计算分数导致检索时间过慢的问题 | common/tracer.py, db_vector/milvus/manager/chunk_manager.py | 已完成 |
| 21 | [#64](https://gitcode.com/openeuler/euler-copilot-rag/issues/64) | Bug | 修复trace存库和计算分数导致检索时间过慢的问题 | db_vector/milvus/convertor.py, db_vector/milvus/manager/chunk_manager.py, db_vector/opengauss/manager/chunk_manager.py, routers/chunk.py, routers/json.py, service/chunk.py, task/worker/document_parse_worker.py | 已完成 |
| 22 | [#65](https://gitcode.com/openeuler/euler-copilot-rag/issues/65) | Bug | 修复deep解析方法中提取表格的bug | db_vector/milvus/manager/doc_manager.py, parser/deep_pdf_parser.py | 已完成 |
| 23 | [#66](https://gitcode.com/openeuler/euler-copilot-rag/issues/66) | Task | 关闭无用打印 | app.py, task/task_handler.py | 已完成 |
| 24 | [#67](https://gitcode.com/openeuler/euler-copilot-rag/issues/67) | Task | 使用text_feature进行嵌入 | task/worker/document_parse_worker.py | 已完成 |
| 25 | [#68](https://gitcode.com/openeuler/euler-copilot-rag/issues/68) | Bug | 修复文档摘要为空embedding嵌入失败的问题 | schema/request.py, task/worker/document_parse_worker.py | 已完成 |
| 26 | [#69](https://gitcode.com/openeuler/euler-copilot-rag/issues/69) | Bug | fix bug（opengauss/postgres engine及worker修复） | db_vector/opengauss/engine.py, db_vector/postgres/engine.py, task/worker/document_parse_worker.py, task/worker/json_parse_worker.py | 已完成 |
| 27 | [#70](https://gitcode.com/openeuler/euler-copilot-rag/issues/70) | Bug | 修复任务队列的bug | task/worker/base_worker.py | 已完成 |
| 28 | [#71](https://gitcode.com/openeuler/euler-copilot-rag/issues/71) | Feature | 增加上传文档的skill | agent/witty_doc/* | 已完成 |
| 29 | [#72](https://gitcode.com/openeuler/euler-copilot-rag/issues/72) | Task | access存库sha256哈希 | db_scalar/opengauss/manager/access_key_manager.py, db_scalar/postgres/manager/access_key_manager.py | 已完成 |
| 30 | [#73](https://gitcode.com/openeuler/euler-copilot-rag/issues/73) | Task | 删除配置文件 | agent/test_recall/config.toml | 已完成 |
| 31 | [#74](https://gitcode.com/openeuler/euler-copilot-rag/issues/74) | Enhancement | 完善rag测试脚本 | agent/test_recall/*, agent/witty_chunk/SKILL.md | 已完成 |
| 32 | [#75](https://gitcode.com/openeuler/euler-copilot-rag/issues/75) | Feature | 开发测试的skill | agent/witty_chunk/*, agent/test_recall/resources/stopwords.txt | 已完成 |
| 33 | [#76](https://gitcode.com/openeuler/euler-copilot-rag/issues/76) | Bug | 修复opengauss postgres milvus json检索的bug | ENUM/database.py, db_vector/milvus/engine.py, db_vector/opengauss/engine.py, db_vector/postgres/engine.py | 已完成 |
| 34 | [#77](https://gitcode.com/openeuler/euler-copilot-rag/issues/77) | Bug/Feature | 增加对qdrant的适配，修复基于逻辑表达式的json检索bug | db_vector/qdrant/*, schema/knowledge_base.py, task/worker/json_parse_worker.py | 已完成 |
| 35 | [#78](https://gitcode.com/openeuler/euler-copilot-rag/issues/78) | Feature | 增加开发文档 | docs/fastapi_development_outline.md, docs/fastapi_development_practice.md | 已完成 |
| 36 | [#79](https://gitcode.com/openeuler/euler-copilot-rag/issues/79) | Bug | 修复json混合检索的bug | db_vector/postgres/manager/json_manager.py, rag/json_searcher.py | 已完成 |
| 37 | [#80](https://gitcode.com/openeuler/euler-copilot-rag/issues/80) | Feature | json和json value增加默认值 | schema/json.py, schema/knowledge_base.py, schema/request.py | 已完成 |
| 38 | [#81](https://gitcode.com/openeuler/euler-copilot-rag/issues/81) | Enhancement | 完善基于json的检索 | rag/hybrid_searcher.py, rag/json_searcher.py, schema/json.py, service/json.py, task/worker/json_parse_worker.py | 已完成 |
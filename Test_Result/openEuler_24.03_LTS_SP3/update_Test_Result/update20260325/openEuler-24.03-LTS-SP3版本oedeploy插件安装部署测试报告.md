![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对"本文档"的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称"CC BY-SA 4.0")的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026-03-25 | v1.0 | 首次编写 | 朱泽旭 |

关键词： oedeploy, 插件, 安装部署, 测试报告

摘要： 本文档是关于openEuler 24.03-LTS-SP3版本中oedeploy工具的19个插件安装部署测试报告，包括tensorflow、ravendb、ragflow、pytorch等插件的安装、配置、验证和卸载测试，旨在验证这些插件在openEuler 24.03-LTS-SP3环境下的可用性和稳定性。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| oedeploy | openEuler Deploy | openEuler部署工具 |
| LLM | Large Language Model | 大语言模型 |
| NLP | Natural Language Processing | 自然语言处理 |
| GPU | Graphics Processing Unit | 图形处理单元 |

# 1     特性概述

oedeploy是openEuler社区开发的部署工具，用于帮助开发者和运维人员快速部署各种应用和服务。本次测试涉及19个插件，包括深度学习框架、数据库、NLP工具、LLM应用等多个领域的部署插件。这些插件提供了标准化的部署流程，支持自动化安装、配置、验证和卸载操作，大大简化了应用部署的复杂度。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 24.03-LTS-SP3 | 2026-03-20 | 2026-03-25 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| x86_64服务器 | CPU: Intel Xeon 8核, 内存: 32GB, 磁盘: 500GB SSD | 支持GPU加速 |
| ARM64服务器 | CPU: Kunpeng 920 8核, 内存: 32GB, 磁盘: 500GB SSD | 支持Ascend加速卡 |

# 3     测试结论概述

## 3.1   测试整体结论

本次测试覆盖了oedeploy工具的19个插件的安装部署功能，共计执行57个测试用例，主要覆盖了功能测试、兼容性测试和可靠性测试。测试结果显示，所有插件均能在openEuler 24.03-LTS-SP3环境下成功安装和部署，功能运行正常，未发现严重问题。整体质量良好，满足生产环境使用要求。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 插件安装测试 | 测试通过 |
| 功能测试 | 插件配置测试 | 测试通过 |
| 功能测试 | 插件验证测试 | 测试通过 |
| 功能测试 | 插件卸载测试 | 测试通过 |
| 兼容性测试 | x86_64架构兼容性 | 测试通过 |
| 兼容性测试 | ARM64架构兼容性 | 测试通过 |
| 资料测试 | 文档完整性 | 测试通过 |

## 3.2   约束说明

1. 部分插件（如tensorflow、pytorch、mindspore-deepseek）需要GPU或Ascend加速卡支持，在无加速硬件的环境下可能性能受限。
2. 部分插件（如ragflow、anythingLLM）需要较大的内存和磁盘空间，建议在配置充足的环境中部署。
3. 部分插件（如kubeflow、kuberay）需要Kubernetes集群环境。
4. 部分插件（如openai）需要调用可用的openai客户端（本地部署或者互联网服务）。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无

### 3.3.2 问题统计

#### 3.3.2.1 问题数量

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 2 | 0 | 2 | 0 | 0 |
| 百分比 | 100% | 0% | 100% | 0% | 0% |

#### 3.3.2.2 发现问题

| 序号 | 问题单号 | 问题简述 | 优先级 | 当前状态 |
| --- | ------- | ------ | ------- | ------- |
| 1 | https://gitcode.com/openeuler/oeDeploy/issues/138 |raven和MongoDB doc文档中存在明文默认密码 | 主要 | 已修复 |
| 2 | https://gitcode.com/openeuler/oeDeploy/issues/137 | raven和MongoDB部署yaml中存在明文默认密码 | 主要 | 已修复 |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | tensorflow | 正常| 安装成功，功能正常 |
| 2 | ravebdb | 正常| 安装成功，功能正常 |
| 3 | ragflow | 正常| 安装成功，功能正常 |
| 4 | pytorch | 正常| 安装成功，功能正常 |
| 5 | python-science-env | 正常 | 安装成功，功能正常 |
| 6 | python-nlp-env | 正常| 安装成功，功能正常 |
| 7 | python-llm-env | 正常| 安装成功，功能正常 |
| 8 | python-deeplearning-env | 正常 | 安装成功，功能正常 |
| 9 | openclaw | 正常 | 安装成功，功能正常 |
| 10 | mongodb | 正常| 安装成功，功能正常 |
| 11 | mindspore-deepseek | 正常 | 安装成功，功能正常 |
| 12 | kuberay | 正常 | 安装成功，功能正常 |
| 13 | kubeflow | <正常 | 安装成功，功能正常 |
| 14 | agent_env | 正常 | 安装成功，功能正常 |
| 15 | anythingLLM | 正常 | 安装成功，功能正常 |
| 16 | ascend-driver-manager | 正常 | 安装成功，功能正常 |
| 17 | cann-toolkit | 正常 | 安装成功，功能正常 |
| 18 | helm | 正常| 安装成功，功能正常 |
| 19 | dify | 正常 | 安装成功，功能正常 |


### 4.1.2 新增特性测试结论

本次测试中所有插件均为继承特性，无新增特性。

## 4.2 兼容性测试结论

所有插件均在x86_64和ARM64架构的openEuler 24.03-LTS-SP3环境下进行了测试，测试结果显示所有插件均能正常安装和运行，兼容性良好。

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 架构兼容性 | x86_64架构 | 良好 |
| 架构兼容性 | ARM64架构 | 良好 |
| 版本兼容性 | openEuler 24.03-LTS-SP3 | 良好 |

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
| 安装性能 | 平均安装时间 | < 30分钟 | 良好 |
| 启动性能 | 服务启动时间 | < 2分钟 | 良好 |
| 资源占用 | 内存使用 | 符合预期 | 良好 |
| 资源占用 | CPU使用 | 符合预期 | 良好 |



## 4.4 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 卸载测试 | 插件卸载 | 成功 |
| 重复安装测试 | 多次安装 | 成功 |

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 24.03-LTS-SP3 | 57 | 57通过 | 2 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

1. 建议在更多硬件配置环境下进行测试，验证插件在不同硬件配置下的表现。
2. 建议进行长期稳定性测试，验证插件在长时间运行后的稳定性。
3. 建议测试插件之间的协同工作能力，验证多个插件同时部署时的兼容性。
4. 建议定期更新插件版本，确保与上游开源项目的同步。
5. 建议加强插件的错误处理能力，提高在异常情况下的稳定性。

# 6     附件

*此处可粘贴各类专项测试数据或报告*

## 6.1 测试环境配置

### x86_64服务器配置
- CPU: Intel Xeon 8核
- 内存: 32GB
- 磁盘: 500GB SSD
- GPU: NVIDIA Tesla V100
- 操作系统: openEuler 24.03-LTS-SP3

### ARM64服务器配置
- CPU: Kunpeng 920 8核
- 内存: 32GB
- 磁盘: 500GB SSD
- 加速卡: Ascend 910
- 操作系统: openEuler 24.03-LTS-SP3

## 6.2 测试用例列表

| 测试用例ID | 测试用例名称 | 测试结果 |
| ---------- | ------------ | -------- |
| TEST-001 | tensorflow插件安装测试 | 通过 |
| TEST-002 | tensorflow插件验证测试 | 通过 |
| TEST-003 | tensorflow插件卸载测试 | 通过 |
| TEST-004 | ravebdb插件安装测试 | 通过 |
| TEST-005 | ravebdb插件验证测试 | 通过 |
| TEST-006 | ravebdb插件卸载测试 | 通过 |
| TEST-007 | ragflow插件安装测试 | 通过 |
| TEST-008 | ragflow插件验证测试 | 通过 |
| TEST-009 | ragflow插件卸载测试 | 通过 |
| TEST-010 | pytorch插件安装测试 | 通过 |
| TEST-011 | pytorch插件验证测试 | 通过 |
| TEST-012 | pytorch插件卸载测试 | 通过 |
| TEST-013 | python-science-env插件安装测试 | 通过 |
| TEST-014 | python-science-env插件验证测试 | 通过 |
| TEST-015 | python-science-env插件卸载测试 | 通过 |
| TEST-016 | python-nlp-env插件安装测试 | 通过 |
| TEST-017 | python-nlp-env插件验证测试 | 通过 |
| TEST-018 | python-nlp-env插件卸载测试 | 通过 |
| TEST-019 | python-llm-env插件安装测试 | 通过 |
| TEST-020 | python-llm-env插件验证测试 | 通过 |
| TEST-021 | python-llm-env插件卸载测试 | 通过 |
| TEST-022 | python-deeplearning-env插件安装测试 | 通过 |
| TEST-023 | python-deeplearning-env插件验证测试 | 通过 |
| TEST-024 | python-deeplearning-env插件卸载测试 | 通过 |
| TEST-025 | openclaw插件安装测试 | 通过 |
| TEST-026 | openclaw插件验证测试 | 通过 |
| TEST-027 | openclaw插件卸载测试 | 通过 |
| TEST-028 | mongodb插件安装测试 | 通过 |
| TEST-029 | mongodb插件验证测试 | 通过 |
| TEST-030 | mongodb插件卸载测试 | 通过 |
| TEST-031 | mindspore-deepseek插件安装测试 | 通过 |
| TEST-032 | mindspore-deepseek插件验证测试 | 通过 |
| TEST-033 | mindspore-deepseek插件卸载测试 | 通过 |
| TEST-034 | kuberay插件安装测试 | 通过 |
| TEST-035 | kuberay插件验证测试 | 通过 |
| TEST-036 | kuberay插件卸载测试 | 通过 |
| TEST-037 | kubeflow插件安装测试 | 通过 |
| TEST-038 | kubeflow插件验证测试 | 通过 |
| TEST-039 | kubeflow插件卸载测试 | 通过 |
| TEST-040 | agent_env插件安装测试 | 通过 |
| TEST-041 | agent_env插件验证测试 | 通过 |
| TEST-042 | agent_env插件卸载测试 | 通过 |
| TEST-043 | anythingLLM插件安装测试 | 通过 |
| TEST-044 | anythingLLM插件验证测试 | 通过 |
| TEST-045 | anythingLLM插件卸载测试 | 通过 |
| TEST-046 | ascend-driver-manager插件安装测试 | 通过 |
| TEST-047 | ascend-driver-manager插件验证测试 | 通过 |
| TEST-048 | ascend-driver-manager插件卸载测试 | 通过 |
| TEST-049 | cann-toolkit插件安装测试 | 通过 |
| TEST-050 | cann-toolkit插件验证测试 | 通过 |
| TEST-051 | cann-toolkit插件卸载测试 | 通过 |
| TEST-052 | helm插件安装测试 | 通过 |
| TEST-053 | helm插件验证测试 | 通过 |
| TEST-054 | helm插件卸载测试 | 通过 |
| TEST-055 | dify插件安装测试 | 通过 |
| TEST-056 | dify插件验证测试 | 通过 |
| TEST-057 | dify插件卸载测试 | 通过 |

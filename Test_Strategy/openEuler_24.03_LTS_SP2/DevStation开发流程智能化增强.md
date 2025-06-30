![openEuler ico](../../images/openEuler.png)

版权所有 © 2025 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025-4-21 |  1.0.0    |  初稿     | 叶晨欢 |

关键词： DevStation、MCP、EulerCopilot

摘要：本文从特性介绍、测试目标、测试内容、测试计划等说明DevStation开发流程智能化增强的测试策略。

缩略语清单：
| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |

# 特性描述
<!-- 主要介绍特性实现的背景、功能以及作用 -->

建设MCP Servers的REPO，结合EulerCopilot基于自然语言交互完成开发流程

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|[IC61QU](https://gitee.com/openeuler/release-management/issues/IC61QU?from=project-issue)| DevStation开发流程智能化增强|	Developing | sig-intelligence | @duan_pj |独立发布镜像 | / |


# 特性分层策略
## 总体测试策略
<!-- 主要描述特性的整体测试策略，主要开展哪些测试(接口/功能/场景/专项) -->

- 测试目标：本次测试主要覆盖功能测试、可靠性测试，功能部分重点覆盖devstation上已支持MCP协议,在devstation上能正常调用eulermaker mcp server、oedeploy mcp server的功能，devstation默认集成EulerCopilot且EulerCopilot支持调用mcp servers实现自然语言交互
- 时间进度：待评估
- 风险评估：NA
- 重点事项：同测试目标
- 争议事项：NA

## 特性测试约束
<!-- 主要描述特性测试的约束条件 -->

NA

## 接口测试
<!-- 主要描述接口级测试策略及测试设计思路 -->

NA

## 功能测试
<!-- 主要描述特性提供的功能的测试策略及测试思路 -->

| 功能描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| devstation上支持MCP测试|  验证安装devstation后已配置MCP协议、roocode及相关运行环境，且相关配置正常|  已集成MCP，且相关配置正常 |      |
| devstation集成EulerCopilot测试 | 验证devstation上默认安装EulerCopilot桌面版且EulerCopilot基本功能正常，可调用mcp server|   EulerCopilot基本功能正常，可调用mcp server | |
| devstation支持EulerMaker  mcp server测试| 验证EulerMaker mcp server已合入社区mcp-sercers仓库，通过roocode可正常使用工具，覆盖创建执行任务等基础功能验证 |  EulerMaker | mcp server基础功能正常   |   |
| devstation支持oedeploy mcp server测试| 验证oedeploy mcp server已合入社区mcp-sercers仓库，且工具能正常使用，通过该mcp server验证oedeploy一键部署组件功能|  oedeploy mcp server基础功能正常   |   |



## 场景测试CP
<!-- 主要描述对特性使用的主要场景的测试策略及测试思路 -->

参考功能场景

## 专项测试
<!-- 主要描述其他专项测试,如安全测试 稳定性测试 性能测试 兼容性测试等 -->

| 专项测试类型 |专项测试描述 | 测试预期结果 | 备注|
| -------- | ------------ | ---- |----|
| 可靠性测试 |验证构造mcp配置异常、命名重复等场景以及多次反复调用、调用时中断场景 | 异常情况报错、日志记录符合预期，相关日志均正常记录，多次调用成功， 调用时中断重新调用成功 | |

# 特性测试环境描述
<!-- 主要描述执行测试的硬件信息 -->
不涉及特殊硬件

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |

# 特性测试执行策略

## 测试计划
<!-- 测试执行策略主要描述该轮次执行的分层策略中的测试项 -->

| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
|     round3-round5     |  2025/5/09        |2025/5/29       |     21|                    全量测试           |        |
|     round6-round7         |   2025/5/30        |  2025/6/12        |14      |   回归测试                           |        |

# 入口标准  
1.特性满足质量标准，达成需求设计要求目标

# 出口标准  
1.策略规划的测试活动涉及测试用例100%执行完毕  
2.版本无严重问题遗留，其他问题有规避措施

# 附件

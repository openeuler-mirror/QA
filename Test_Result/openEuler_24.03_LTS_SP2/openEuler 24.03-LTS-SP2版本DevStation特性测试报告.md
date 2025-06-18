![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述                                          | 作者      |
| ---------- | ----------- | ------------------------------------------------- | --------- |
| 2025.06.10 | 1.0         | openEuler 24.03-LTS-SP2版本DevStation特性测试报告 | yangqufei |

关键词： DevStation，openEuler Intelligence，mcp，openEuler-24.03-LTS-SP2

摘要：

文本主要描述devstation openEuler-24.03-LTS-SP2版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。 按照测试策略，对devstation项目下的新需求功能、文档以及易用性进行测试。


缩略语清单：

| 缩略语 | 英文全名               | 中文解释                |
| ------ | ---------------------- | ----------------------- |
|        | openEuler Intelligence | openEuler智能化解决方案 |

# 1     特性概述

该版本devstation是openEuler主要配置mcp服务，预装opeEuler Intelligence，大幅提升开发者效率；预装roo coode，支持mcp协议，开发者可以通过自然语言调用相关mcp，方便开发者进行开发；支持oeDeploy和EulerMaker等mcp，可以使用自然语言安装卸载服务，或者构建软件包。

## 1.1 新增特性功能

#### MCP 开箱即用

- 深度集成MCP协议，默认配置部分mcp servers

- 预装roo code，支持mcp协议
- 预装MCP工具链和运行时环境

### DevStation 默认集成EulerCopilot桌面版

- DevStation默认继承EulerCopilot桌面版

### 建设MCP Servers的REPO，结合EulerCopilot实现自然语言交互完成开发流程

- 结合EulerCopilot实现自然语言交互
- 建设MCP Servers的REPO（上量目标，不限制内容）

### DevStation支持社区oedeploy，eulermaker等mcp servers

- 构建eulermaker mcp servers
- devstation支持oedeploy eulermaker mcp servers
- 构建oedeploy mcp servers



# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                     | 测试起始时间 | 测试结束时间 |
| ---------------------------- | ------------ | ------------ |
| devstation 24.03-LTS-SP2 RC3 | 2025-05-09   | 2025-05-15   |
| devstation 24.03-LTS-SP2 RC4 | 2025-05-16   | 2025-05-22   |
| devstation 24.03-LTS-SP2 RC5 | 2025-05-23   | 2025-05-29   |
| devstation 24.03-LTS-SP2 RC6 | 2025-05-30   | 2025-06-06   |
| devstation 24.03-LTS-SP2 RC7 | 2025-06-07   | 2025-06-13   |

描述特性测试的硬件环境信息

| 硬件型号     | 硬件配置信息                                                 | 备注         |
| ------------ | ------------------------------------------------------------ | ------------ |
| Taishan 2280 | 物理机                                                       | Kunpeng 920  |
| 笔记本       | x86 AMD 16核心，32G内存，硬盘 954G，GPU AMD Device 1900（rev 08），桌面版 | 惠普PAVILION |

# 3     测试结论概述

## 3.1   测试整体结论

DevStation特性，共计执行110个用例，主要覆盖了：深度集成MCP协议，默认配置部分mcp servers；预装roo code，支持mcp协议；预装MCP工具链和运行时环境；DevStation默认继承EulerCopilot桌面版；结合；ulerCopilot实现自然语言交互；建设MCP Servers的REPO（上量目标，不限制内容）；构建eulermaker mcp servers；devstation支持oedeploy eulermaker mcp servers；构建oedeploy mcp servers等功能测试、兼容性测试、资料测试，共发现问题6个，发现问题已解决5个，1个正在解决中，已解决问题回归通过，无遗留风险，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 质量良好 |
| 功能测试 | 新增特性测试 | 质量良好 |
| 兼容性测试 |          | 质量良好 |
| DFX专项测试 | 性能测试 | 不涉及 |
| DFX专项测试 | 可靠性/韧性测试 | 质量良好 |
| DFX专项测试 | 安全测试 | 不涉及 |
| 资料测试 |         | 质量良好 |
| 其他测试 |         |         |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- |
| 1 | 无 | 安装系统过程中，用户设置输入密码，当光标放在密码中间位置，输入一个字符后，光标会跳到密码末尾 | 主要 | 较大 | 使用新框架 | |

### 3.3.2 问题

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 4        | 0    | 3    | 1    | 0      |
| 百分比 | 100%     | 0    | 75%  | 25%  | 0      |



| 序号 | 问题单号                                                     | 问题简述                                         | 问题级别 | 影响分析 | 规避措施               | 历史发现场景 |
| ---- | ------------------------------------------------------------ | ------------------------------------------------ | -------- | -------- | ---------------------- | ------------ |
| 1    | 无                                                           | 社区文档命令显示不正确yum -y install Devplugin   | 次要     | 较小     | 修改文档，DevPlugin    |              |
| 2    | 无                                                           | EulerCopilot运行后，托盘图标和快捷方式图标不一致 | 主要     | 较大     | 使用新版本EulerCopilot |              |
| 3    | https://gitee.com/src-openeuler/calamares/issues/IC9XQ3?from=project-issue | 系统内核版本和安装启动内核版本不一致             | 主要     | 较大     | 使用新版本系统         |              |



# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|  |               | <font color=green>■</font> | |
|  |  | <font color=blue>▲</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称                                 |        特性质量评估        | 备注 |
| ---- | --------------------------------------------- | :------------------------: | ---- |
| 1    | 深度集成MCP协议，默认配置部分mcp servers      | <font color=green>■</font> |      |
| 2    | 预装roo code，支持mcp协议                     | <font color=green>■</font> |      |
| 3    | 预装MCP工具链和运行时环境                     | <font color=green>■</font> |      |
| 4    | DevStation默认继承EulerCopilot桌面版          | <font color=green>■</font> |      |
| 5    | 结合EulerCopilot实现自然语言交互；            | <font color=green>■</font> |      |
| 6    | 建设MCP Servers的REPO（上量目标，不限制内容） | <font color=green>■</font> |      |
| 7    | 构建eulermaker mcp servers                    | <font color=green>■</font> |      |
| 8    | devstation支持oedeploy eulermaker mcp servers | <font color=green>■</font> |      |
| 9    | 构建oedeploy mcp servers                      | <font color=green>■</font> |      |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

支持x86和arm架构。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|         |         |        |         |

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 可靠性测试 | 反复安装、卸载、开启、关闭mcp | 卸载无残留文件，开启可正常运行 |

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

## 4.4 资料测试结论
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| calamares文档 | https://gitee.com/src-openeuler/calamares/pulls/56 | 测试通过，质量良好 |
| oeDevplugin文档 | https://gitee.com/src-openeuler/oeDevPlugin/pulls/23 | 测试通过，质量良好 |
| oeGitExt文档 | https://gitee.com/src-openeuler/oeGitExt/pulls/10 | 测试通过，质量良好 |
| roo-code文档 | https://gitee.com/src-openeuler/roo-code/pulls/2 | 测试通过，质量良好 |
| oeDeploy文档 | https://gitee.com/src-openeuler/oeDeploy/pulls/19 <br>https://gitee.com/src-openeuler/oeDeploy/pulls/20 | 测试通过，质量良好 |

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                          | 测试用例数 | 用例执行结果 | 发现问题单数 |
| --------------------------------- | ---------- | ------------ | ------------ |
| devstations 24.03-LTS-SP2 RC3~RC7 | 110        | 110          | 4            |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 
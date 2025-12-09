![avatar](../../images/openEuler.png)

版权所有 © 2025  openEuler社区
 您对"本文档"的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称"CC BY-SA 4.0")的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期      | 修订版本 | 修改描述 | 作者      |
| --------- | ------- | ------- | --------- |
| 2025.12.8 | 1.0     | openEuler-24.03-LTS-SP3版本cvekit特性测试报告  | Wang Kui  |

关键词： cvekit, CVE修复, mcp, MCP Servers

摘要：

本文档主要描述openEuler-24.03-LTS-SP3版本cvekit特性的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。按照测试策略，对cvekit项目下的新需求功能、文档以及易用性进行全面测试。

# 1     特性概述

openEuler-24.03-LTS-SP3版本cvekit是一个CVE修复流程自动化工具，提供CVE分析、补丁分析及应用、冲突解决、PR提交等功能。


# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                        | 测试起始时间 | 测试结束时间 |
| ------------------------------ | ---------- | ---------- |
| openEuler-24.03-LTS-SP3-round6 | 2025-12-8  | 2025-12-10 |

描述特性测试的硬件环境信息

| 环境信息                          | 配置信息 | 备注                                                 |
| ------------------------------- | ------------ | ------------------------------------------------ |
| 虚拟机 openEuler24.03-LTS-SP3     | x86_64   | 桌面系统能正常使用                                    |
| 虚拟机 openEuler24.03-LTS-SP3     | aarch64  | 桌面系统能正常使用                                    |

# 3     测试结论概述

## 3.1   测试整体结论

测试cvekit基本特性。

测试缺陷密度：共发现6个问题，代码量8k，缺陷密度0.75个/KLoc，质量风险较好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 不涉及 |
| 功能测试 | 新增特性测试 | 测试通过，预期功能全部实现 |
| 兼容性测试 |  | 测试通过 |
| DFX专项测试 | 性能测试 | 测试通过，性能符合预期 |
| DFX专项测试 | 可靠性/韧性测试 | 测试通过，压力测试下功能正常 |
| DFX专项测试 | 安全测试 | 测试通过，构造危险输入无异常、无敏感信息泄露 |
| 资料测试 |         | 质量良好 |
| 其他测试 |         | 不涉及 |

## 3.2   约束说明

- cvekit测试需要代理，本次测试基于vscodium和roo-code
- roo-code API提供商已配置成功，MCP Servers可正常使用
- ctags >= 6.0，下载地址：https://repo.oepkgs.net/openEuler/rpm/openEuler-24.03-LTS/contrib/DevStation/ctags/

## 3.3   遗留问题分析

### 3.3.1 遗留问题

不涉及

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目    | 6        | 1    | 4    | 1    | 0      |
| 百分比  | 100%     | 16.7%    | 66.6%  | 16.7% | 0      |

### 3.3.3 问题记录

| 序号  | 链接     | 问题简述   | 严重程度  | 状态      |
| ---- | -------- | -------- | -------- | -------- |
| 1    | https://gitee.com/openeuler/mcp-servers/issues/ID9XNN | 在分析CVE-2025-38226这个漏洞时，只给出了6.6分支的分析结论 | 主要 | 已修复 |
| 2    | https://gitee.com/openeuler/mcp-servers/issues/IDAQ9U | cvekit 在英语调用时，部分日志仍是中文 | 次要 | 已修复 |
| 3    | https://gitee.com/openeuler/mcp-servers/issues/IDAQMA | agent用的silicon接口，mcp用的deepseek接口，导致冲突功能无法运行 | 严重 | 已修复 |
| 4    | https://gitee.com/openeuler/mcp-servers/issues/IDAQSX | cve服务平台用户需要将cvekit-mcp部署成服务 | 主要 | 已修复 |
| 5    | https://gitee.com/openeuler/mcp-servers/issues/IDAQV5 | 当前cvekit-mcp从linux公告中获取commits直接使用硬规则，且没有区分大小写 | 主要 | 已修复 |
| 6    | https://gitee.com/openeuler/mcp-servers/issues/IDAQV9 | cvekit服务超时没有反馈 | 主要 | 已修复 |

# 4 详细测试结论

## 4.1 功能测试
### 4.1.1 继承特性测试结论

不涉及

### 4.1.2 新增特性测试结论

| 用例特性             | 用例名称                                   | 测试类型 | 预置条件                                                     | 操作步骤                                                     | 预期结果                                                     | 测试结论                   |
| -------------------- | ------------------------------------------ | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------- |
| 安装部署与初始化 | 软件安装   | 功能  | vscodium和roo-code已安装    | yum安装mcp-servers-cvekit软件包  | 安装成功| <font color=green>■</font> |
| 安装部署与初始化 | 软件卸载  | 功能 | vscodium，roo-code和mcp-servers-cvekit已安装 | yum卸载mcp-servers-cvekit软件包   | 卸载成功，无文件残留   | <font color=green>■</font> |
| 安装部署与初始化 | 服务配置   | 功能 | vscodium，roo-code和mcp-servers-cvekit已安装  | 在vscodium的root-code中mcpServers中可配置cvekit | MCP Servers中可查看到cvekit_mcp  | <font color=green>■</font> |
| 安装部署与初始化 | 中英文切换 | 功能 | vscodium，roo-code和mcp-servers-cvekit已安装  | 修改mcp_config.json中env的LANG，切换en_US.UTF-8和zh_CN.UTF-8 | 中英文可自由切换 |<font color=green>■</font> |
| 功能测试 | 修复CVEl漏洞 | 功能 | vscodium，roo-code和mcp-servers-cvekit已安装，API提供商已配置成功，mcp可正常使用  | 在roo-code中提交修复cve的task | PR提交成功 |<font color=green>■</font> |


## 4.2 兼容性测试结论

mcp-servers-cvekit 在 24.03sp3 x86_64和aarch64）上测试，未发现兼容性问题。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 用例特性        | 用例名称            | 测试类型 | 预置条件                                                     | 操作步骤                                                     | 预期结果                                                     | 测试结论                   |
| --------------- | ------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------- |
| cve分析与处理  | parse_issue | 性能 | mcp-servers-cvekit软件包已安装，服务启动 | 创建CVE修复任务，记录parse_issue阶段API请求时间  | parse_issue时间少于10s | <font color=green>■</font> |
| cve分析与处理  | setup_env | 性能 | mcp-servers-cvekit软件包已安装，服务启动 | 创建CVE修复任务，记录setup_env阶段API请求时间  | setup_env时间少于10s | <font color=green>■</font> |
| cve分析与处理  | get_commits | 性能 | mcp-servers-cvekit软件包已安装，服务启动 | 创建CVE修复任务，记录get_commits阶段API请求时间  | get_commits时间少于60s | <font color=green>■</font> |
| cve分析与处理  | analyze_branches | 性能 | mcp-servers-cvekit软件包已安装，服务启动 | 创建CVE修复任务，记录analyze_branches阶段API请求时间  | analyze_branches时间少于100s | <font color=green>■</font> |
| cve分析与处理  | apply_patch | 性能 | mcp-servers-cvekit软件包已安装，服务启动 | 创建CVE修复任务，记录apply_patch阶段API请求时间  | apply_patch时间少于200s | <font color=green>■</font> |
| cve分析与处理  | create_pr | 性能 | mcp-servers-cvekit软件包已安装，服务启动 | 创建CVE修复任务，记录create_pr阶段API请求时间  | create_pr时间少于100s | <font color=green>■</font> |


<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.2 可靠性/韧性测试结论

| 用例特性             | 用例名称                         | 测试类型 | 预置条件                                                 | 操作步骤                                                     | 预期结果                                                     | 测试结论                   |
| -------------------- | -------------------------------- | -------- | -------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------- |
| CVE修复     | 修复CVE  | 可靠性   | mcp-servers-cvekit软件包已安装  | 修复同一个CVE，重复10次，比较修复结果（每次修复完成手动回退修复结果） | 10次修复结果一致  | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.3 安全测试结论

| 用例特性       | 用例名称             | 测试类型 | 预置条件                       | 操作步骤                                                     | 预期结果                             | 测试结论                   |
| -------------- | -------------------- | -------- | ------------------------------ | ------------------------------------------------------------ | ------------------------------------ | -------------------------- |
| CVE修复 | task危险字段测试 | 安全     | task执行正常 | task中输入单引号、双引号、分号、半括号，以及常用的危险关键词：'; DROP TABLE users; --，admin'--，\<script\>alert('XSS')\</script\>，javascript:alert('XSS')，; whoami，; cat /etc/passwd，file:///etc/passwd，等等 | task执行正常，无用关键词被过滤 | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.4   资料测试结论

| 测试类型 | 测试内容  | 测试结论 |
| :----- | -------- | ------- |
| 用户手册 | https://gitee.com/openeuler/mcp-servers/blob/master/servers/cvekit_mcp/README.md  | 测试通过 |



# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数              | 用例执行结果   | 发现问题单数 |
| :------- | ----------------------- | -------------- | ------------ |
| 1.1.2    | 14        | 14 pass 0 fail | 6            |


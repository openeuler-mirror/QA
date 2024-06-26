![avatar](../../images/openEuler.png)

版权所有 © 2023 openEuler 社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享 4.0 国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[_https://creativecommons.org/licenses/by-sa/4.0/_](https://creativecommons.org/licenses/by-sa/4.0/) 了解 CC BY-SA 4.0 的概要 (但不是替代)。CC BY-SA 4.0 的完整协议内容您可以访问如下网址获取：[_https://creativecommons.org/licenses/by-sa/4.0/legalcode_](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期      | 修订版本 | 修改章节         | 修改描述  |
| --------- | -------- | ---------------- | --------- |
| 2023-8-28 | 1.0      | PilotGo2.0 测试报告 | @wubijie |
| 2024-3-12 | 1.1      | PilotGo2.0 平台优化 | @jxy_git |

关键词：PilotGo2.0测试报告

摘要：按照测试要求，针对openEuler 23.09测试PilotGo的安装、主要功能进行测试。测试结果良好，基本支持PilotGo主要功能的正常使用。

---

\*\*\*

# 1 概述

本测试报告为 PilotGo 在 openEuler 23.09 操作系统上的测试报告，目的在于跟踪测试阶段中发现的问题，总结 PilotGo 在硬件平台上的测试结果，测试的范围主要包括 PilotGo 安装、PilotGo 各功能组件使用、PilotGo 各组件的稳定性等。

# 2 测试版本说明

本测试报告适用于openEuler-23.09版本操作系统，测试的时间及测试轮次如下。

| 版本名称        | 测试起始时间        | 测试结束时间        |备注 |
| --------------- | ------------------- | ------------------- | ---- |
| openEuler-23.09 | 2023 年 08 月 28 日 | 2023 年 09 月 02 日 | 第一轮测试 |
| openEuler-23.09 | 2023 年 09 月 04 日 | 2023 年 09 月 08 日 | 第二轮回归测试|

测试硬件平台如下。
| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------------------------------------------------------------------------------------------------------------ | ---- |
| aarch64 | CPU 型号：鲲鹏 920<br>CPU 核数：2<br>内存：4G<br>硬盘容量：40G | 1 |
| x86_64 | CPU 型号：Intel(R) Core(TM) i5-10210U CPU @ 1.60GHz<br>CPU 内核总数：4<br>内存容量：50G | 1 |

# 3 版本概要测试结论

pilotgo2.0版本在openEuler-23.09版本测试阶段完成了功能测试，包括概览、用户、角色、配置库、日志、批次、机器特性、插件八大模块执行47个测试用例，整体核心功能稳定正常；完成了可靠性测试，可以长时间稳定运行；完成了鲲鹏 920和intel/amd x86-64平台的兼容性测试；对测试发现的主要问题都得到了修正，回归测试结果正常。

# 4 版本详细测试结论

本章节针对总体测试策略计划的测试内容，给出详细的测试结论。

## 4.1 特性测试结论

### 4.1.1 继承特性评价
无

### 4.1.2 新需求评价

| 序号 | 特性名称 | 约束依赖说明 | 遗留问题单 | 特性质量评估               | 备注     |
| ---- | -------- | ------------ | ---------- | -------------------------- | -------- |
| 1    | 概览模块 | 用户登录     |    暂无    | <font color=green>○</font>   |  |
| 2    | 用户模块 | 用户登录     |    暂无    | <font color=green>○</font>  |          |
| 3    | 角色模块 | 用户登录      |    暂无    | <font color=green>○</font> |          |
| 4    | 配置库模块 | 用户登录、agent启动 |  暂无      | <font color=green>○</font> |          |
| 5    | 日志模块 | 用户登录     |    暂无    | <font color=green>○</font> |          |
| 6    | 批次模块 | 用户登录      |     暂无    | <font color=green>○</font> |          |
| 7    | 机器特性模块 | 用户登录、agent启动 | 暂无      | <font color=green>○</font> |          |
| 8    | 插件模块 | 用户登录、agent启动 |    暂无    | <font color=green>○</font> |          |

## 4.2 兼容性测试结论

在鲲鹏 920和intel/amd x86-64两个平台上均可正常运行。
| 序号 | 型号 |  遗留问题单 | 特性质量评估               | 备注     |
| ---- | -------- |  ---------- | -------------------------- | -------- |
| 1    | 鲲鹏 920 |     暂无    | <font color=green>○</font>   | pilotgo-server、agent均可正常运行 |
| 2    | intel/amd x86-64 |     暂无    | <font color=green>○</font>  | pilotgo-server、agent均可正常运行 |

## 4.3 专项测试结论

### 4.3.1 安全测试结论
安全性测试主要从日志审计、用户登录、用户权限、远程终端四个方面进行测试。
| 序号 | 特性名称 | 约束依赖说明 | 遗留问题单 | 特性质量评估               | 备注     |
| ---- | -------- | ------------ | ---------- | -------------------------- | -------- |
| 1    | 用户登录 |              |  暂无    | <font color=green>○</font>   | 账号和密码可正常登录。 |
| 2    |日志审计 | 用户登录     |    暂无    | <font color=green>○</font>  | 记录不同用户的不同操作，生成对应的审计日志信息存储到数据库并显示在有查看权限用户的页面上。 |
| 3    | 用户权限 | 用户登录      |    暂无    | <font color=green>○</font> | 每一个登录账号根据角色设置不一样的权限，呈现出不一样的新系统功能。 |
| 4    | 远程终端 | 用户登录、agent启动 |  暂无      | <font color=green>○</font> | 平台可以安全正常的连接机器终端。 |

### 4.3.2 可靠性测试结论
可靠性主要从压力长稳测试、基础功能测试和操作响应测试三个方面进行测试。
| 序号 | 特性名称 | 约束依赖说明 | 遗留问题单 | 特性质量评估               | 备注     |
| ---- | -------- | ------------ | ---------- | -------------------------- | -------- |
| 1    | 基础功能测试 | 用户登录   |  暂无    | <font color=green>○</font>   | 基础功能良好，界面友好，操作便捷，可立即响应。 |
| 2    |操作响应测试 | 用户登录     |    暂无    | <font color=green>○</font>  | 基本功能应当立即响应；单个软件包安装、卸载与软件包的大小、网络速度相关，批量操作任务提交应当立即响应，批次执行完成时间与批次大小、单个任务完成时间有关。 |
| 3    | 压力长稳测试 | 用户登录      |    暂无    | <font color=green>○</font> | pilotgo-server可最大支持6000个agent接入，最大支持200个并发操作。 |

# 5 问题单统计

无。

# 6 附件

## 6.1 附件 1：遗留问题列表

## 6.2 附件 2：各种专项测试报告

# 7 PilotGo 平台优化

## 7.1 x86_64 平台优化验证

### 7.1.1 未优化前安装 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/x86_未优化前安装.png)

### 7.1.2 升级 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/x86_升级.png)

### 7.1.3 降级 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/x86_降级.png)

### 7.1.4 卸载旧版本后安装已优化版本 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/x86_安装已优化版本.png)

### 7.1.5 启动 PilotGo-server PilotGo-agent 服务
![](/images/openEuler_23.09/x86_服务启动成功.png)

### 7.1.6 PilotGo 平台正常运行
![](/images/openEuler_23.09/x86_平台正常运行.png)

### 7.1.7 停止 PilotGo-server PilotGo-agent 服务
![](/images/openEuler_23.09/x86_服务停止成功.png)

### 7.1.8 卸载已优化版本 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/x86_卸载已优化版本.png)

## 7.2 aarch64 平台优化验证

### 7.2.1 未优化前安装 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/arm_未优化前安装.png)

### 7.2.2 升级 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/arm_升级.png)

### 7.2.3 降级 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/arm_降级.png)

### 7.2.4 卸载旧版本后安装已优化版本 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/arm_安装已优化版本.png)

### 7.2.5 启动 PilotGo-server PilotGo-agent 服务
![](/images/openEuler_23.09/arm_服务启动成功.png)

### 7.2.6 PilotGo 平台正常运行
![](/images/openEuler_23.09/arm_平台正常运行.png)

### 7.2.7 停止 PilotGo-server PilotGo-agent 服务
![](/images/openEuler_23.09/arm_服务停止成功.png)

### 7.2.8 卸载已优化版本 PilotGo-server PilotGo-agent
![](/images/openEuler_23.09/arm_卸载已优化版本.png)


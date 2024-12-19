![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订版本 | 修改描述 | 作者 |
| ---- | ------ | ------- | ---- |
| 2024/12/13 | v1.0 | 创建 | @jxy_git |

关键词：PilotGo 特性 测试报告

摘要：PilotGo 是在社区孵化的一个插件式运维管理平台，采用插件式开发，增强平台的扩展性、并打通不同运维组件之间的壁垒。实现单一平台的完整、流畅的运维体验。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |

# 1 特性概述

当前的特性交付包括 PilotGo 基础的运维管理能力和四款插件：PilotGo-plugin-a-tune、PilotGo-plugin-grafana、PilotGo-plugin-prometheus、PilotGo-plugin-topology。openEuler-24.03-LTS-SP1 版本整合了这些核心功能和插件，为用户提供了全面的运维管理解决方案。

# 2 特性测试信息

PilotGo 特性在 rc1、rc2、rc3、rc4 进行四轮验证，同时验证 arm 和 x86 版本。

| 版本名称               | 测试模块           | 测试起始时间 | 测试结束时间 |
|-----------------------|-------------------|------------|------------|
| openEuler-24.03-LTS-SP1 rc1   | PilotGo 及其四个插件 | 2024/11/15 | 2024/11/22 |
| openEuler-24.03-LTS-SP1 rc2   | PilotGo 及其四个插件 | 2024/11/24 | 2024/11/28 |
| openEuler-24.03-LTS-SP1 rc3   | PilotGo 及其四个插件 | 2024/11/29 | 2024/12/04 |
| openEuler-24.03-LTS-SP1 rc4   | PilotGo 及其四个插件 | 2024/12/06 | 2024/12/13 |

硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| KunLun 2280 | CPU型号：Kunpeng 920 <br />CPU核数：96 <br />内存：128G |      |
| NF8260M6 | CPU型号：Intel Xeon Gold 6330H <br />CPU核数：96 <br />内存：256G |      |

# 3 测试结论概述

## 3.1 测试整体结论

PilotGo 在 openEuler-24.03-LTS-SP1 版本的测试阶段，主要涵盖了功能测试、安全性测试和可靠性测试。通过7*24小时的长时间稳定性测试，顺利完成了 16 个子模块的测试，执行了总计 138 个测试用例。整体核心功能表现稳定，插件功能运行正常。

## 3.2 约束说明

## 3.3 遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及

### 3.3.2 问题统计

无

# 4 详细测试结论

## 4.1 功能测试

| 序号 | 子模块名称                                                         | 约束依赖说明                     | 质量评估                    | 备注  |
| ---- | ---------------------------------------------------------------  | ------------------------------ | -------------------------- | ---- |
| 1    | PilotGo 及其插件软件安装、卸载，服务启动                             | 暂无                             | <font color=green>■</font> |      |
| 2    | PilotGo 支持用户添加、修改、删除功能                                 | 用户登录                         | <font color=green>■</font> |      |
| 3    | PilotGo 支持角色添加、修改、删除功能                                | 用户登录                          | <font color=green>■</font> |      |
| 4    | PilotGo 支持部门树添加、修改、删除功能                               | 用户登录                         | <font color=green>■</font> |      |
| 5    | PilotGo 支持变更和删除机器部门功能                                  | 用户登录                         | <font color=green>■</font> |      |
| 6    | PilotGo 支持批次添加、修改、删除功能                                 | 用户登录、agent 启动              | <font color=green>■</font> |      |
| 7    | PilotGo 支持批量软件包下发和卸载功能                                 | 用户登录、agent 启动              | <font color=green>■</font> |      |
| 8    | PilotGo 支持查看审计日志功能                                       | 用户登录、agent 启动              | <font color=green>■</font> |      |
| 9    | PilotGo 支持机器 ip、内存、架构、系统版本等详细信息的查看               | 用户登录、agent 启动              | <font color=green>■</font> |      |
| 10   | PilotGo-plugin-grafana 插件支持对接 grafana 平台                   | 用户登录、agent 启动              | <font color=green>■</font> |      |
| 11   | PilotGo-plugin-prometheus 插件支持监控机器性能指标，图表可视化展示     | 用户登录、agent 启动              | <font color=green>■</font> |      |
| 12   | PilotGo-plugin-a-tune 插件支持查询、添加、修改、删除调优模板           | 用户登录、插件启动                | <font color=green>■</font> |      |
| 13   | PilotGo-plugin-a-tune 插件支持查询、添加、修改、删除调优任务列表        | 用户登录、插件启动                | <font color=green>■</font> |      |
| 14   | PilotGo-plugin-a-tune 插件支持单个调优任务的重启和详情查看             | 用户登录、插件启动                | <font color=green>■</font> |      |
| 15   | PilotGo-plugin-topology 插件支持拓扑配置信息的自定义                 | 用户登录、插件启动、topo-agent 启动 | <font color=green>■</font> |      |
| 16   | PilotGo-plugin-topology 插件支持查看所有机器的单机拓扑图和全局网络拓扑图 | 用户登录、插件启动、topo-agent 启动 | <font color=green>■</font> |      |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

在 Kunpeng 920 和 Intel Xeon Gold 6330H 两种架构的机器上，经过测试，PilotGo 及其插件均可以正常运行。

| 序号 | 型号                   | 特性质量评估                 | 备注                   |
| ---- | --------------------- | -------------------------- | --------------------- |
| 1    | Kunpeng 920           | <font color=green>■</font> | PilotGo 及其插件运行正常 |
| 2    | Intel Xeon Gold 6330H | <font color=green>■</font> | PilotGo 及其插件运行正常 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.3 专项测试结论

### 4.3.1 安全测试结论

安全性测试主要从用户登录、日志审计、用户权限、插件权限四个方面进行测试。

| 序号 | 子模块名称 | 约束依赖说明       | 特性质量评估                 | 备注                                              |
| ---- | -------- | ---------------  | -----------------------   | --------------------------------------------------|
| 1    | 用户登录 | 暂无               | <font color=green>■</font> | 不同用户可以正常登录                                 |
| 2    | 日志审计 | 用户登录            | <font color=green>■</font> | 记录不同用户的不同操作，生成对应的审计日志信息显示在页面上 |
| 3    | 用户权限 | 用户登录            | <font color=green>■</font> | 每个登录账号根据其角色分配不同的权限，展现出不同的系统功能 |
| 4    | 插件权限 | 用户登录、插件启动   | <font color=green>■</font> | 用户是否具备执行插件操作的权限                         |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.2 可靠性测试结论

可靠性测试主要从基础功能、操作响应、压力长稳和 7*24 长稳测试四个方面进行测试。

| 序号 | 子模块名称 | 约束依赖说明 | 特性质量评估                | 备注                                                          |
| ---- | -------- | ---------- | -----------------------   | ------------------------------------------------------------ |
| 1    | 基础功能测试 | 用户登录 | <font color=green>■</font> | 基础功能完善，界面简洁友好，操作简单，响应迅速                        |
| 2    | 操作响应测试 | 用户登录 | <font color=green>■</font> | 基本功能应做到即时响应<br />单个软件包的安装和卸载速度取决于软件包的大小及网络速度<br />对于批量操作任务，任务提交应立即得到响应<br />批次执行的完成时间与批次的大小和每个任务的执行时间相关 |
| 3    | 压力长稳测试 | 用户登录 | <font color=green>■</font> | PilotGo-server 最大支持 6000 个 agent 接入，最大支持 200 个并发操作 |
| 4    | 7*24 长稳测试 | 用户登录 | <font color=green>■</font> | 平台在 7*24 不间断运行未出现崩溃、故障等问题                       |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好


# 5 测试执行

## 5.1 测试执行统计数据

| 版本名称             | 测试用例数   | 用例执行结果     | 发现问题单数 |
| ------------------- | ---------- | -------------- | ---------- |
| openEuler 24.03-LTS-SP1 rc1 | 138        | 通过138个失败0个 | 0个        |
| openEuler 24.03-LTS-SP1 rc2 | 138        | 通过138个失败0个 | 0个        |
| openEuler 24.03-LTS-SP1 rc3 | 138        | 通过138个失败0个 | 0个        |
| openEuler 24.03-LTS-SP1 rc4 | 138        | 通过138个失败0个 | 0个        |

## 5.2 后续测试建议

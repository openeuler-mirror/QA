![avatar](../../images/openEuler.png)
版权所有 © 2025 openEuler社区 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录
<table data-type="luckysheet_copy_action_table"><colgroup width="93px"></colgroup><colgroup width="72px"></colgroup><colgroup width="105px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:19px;font-weight: bold;">日期</td><td  style="font-weight: bold;">修订版本</td><td  style="font-weight: bold;">修改描述</td><td  style="font-weight: bold;">作者</td></tr><tr><td  style="height:19px;">2026-6-13</td><td>v1</td><td>openEuler 24.03-LTS-SP4版本远程证明特性测试报告</td><td>张帅柏</td></tr></table>

关键词：

摘要：

缩略语清单：
| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|RA|Remote Attestation|远程证明|
|RBS|Resource Broker Service|资源分发服务|

# 1. 特性概述

远程证明服务可实现分布式系统之间的硬件验证信任。它通过加密证明验证远程节点（例如，云实例）的完整性，确保它们在可信状态下运行真实软件。

Server：主要用于持续验证部署了代理的机器，确保其完整性和可信性。

CLI：用于管理服务所需的输入/输出文件或策略信息。

Agent：部署在需要验证的机器上，收集证据，与服务建立可信关系。

Key\_Manager：使用第三方密钥管理工具存储和提供服务在验证过程中所需的加密密钥。

RBS资源分发服务是与GTA远程证明接口强耦合的配套服务。 RBS提供资源（如密钥）导入导出及其安全存储的能力，并可对该资源绑定安全环境基准值。

# 2. 特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。
- 测试周期

<table data-type="luckysheet_copy_action_table"><colgroup width="164px"></colgroup><colgroup width="150px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:19px;font-weight: bold;">名称</td><td  style="font-weight: bold;">起始时间</td><td  style="font-weight: bold;">结束时间</td></tr><tr><td  style="height:19px;">openEuler-24.03-LTS-SP4</td><td>2026-4-16</td><td>2026-6-15</td></tr></table>

- 测试硬件环境信息

|||
|---|---|
|机型|Kunpeng 920|
|OS|openEuler-24.03-LTS-SP4|


# 3. 测试结论概述

## 3.1. 测试整体结论

该版本主要验证远程证明基础功能和性能,安全合规性。

* **测试活动覆盖度**：测试活动主要覆盖了功能、资料、可靠性以及安全专项测试，所有测试活动均完成且充分开展。
* **测试用例覆盖度**：共涉及用例396个，用例执行率100%，用例通过率100%，测试执行充分，版本交付范围无遗留问题单
* **问题发现情况：**版本内共发现问题单9个，9个问题均已闭环
* **总体结论：**

综上，远程证明在测试阶段完成了功能测试、安全测试、兼容性测试以及可靠性测试， 测试认为该版本在各阶段测试活动开展充分，版本交付范围内无新增遗留问题
<table data-type="luckysheet_copy_action_table"><colgroup width="97px"></colgroup><colgroup width="150px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:30.5px;font-weight: bold;">测试活动</td><td  style="font-weight: bold;">测试子项</td><td  style="font-weight: bold;">活动评价</td></tr><tr><td  style="height:30.5px;">功能测试</td><td>新增特性测试</td><td>PASS</td></tr><tr><td  style="height:30.5px;">DFX专项测试</td><td>可靠性/长稳压力测试</td><td>PASS</td></tr><tr><td  style="height:19px;">DFX专项测试</td><td>安全测试</td><td>PASS</td></tr><tr><td  style="height:31.5px;">资料测试</td><td></td><td>PASS</td></tr></table>


## 3.2.约束说明

rpm安装形式客户需要预置

1. kunpeng 920
2. key_manager与attestation\_server的mTLS证书
3. attestation\_server与attestation\_agent的SSL证书
4. 数据库等三方件

## 3.3.遗留问题分析

远程证明当前版本不涉及遗留问题

### 3.4.遗留问题影响以及规避措施
不涉及遗留问题

### 3.5.问题统计

#### 问题数量

||问题总数|严重|主要|次要|不重要|
|---|---|---|---|---|---|
|数目|9|0|1|6|2|
|百分比|100%|0%|11%|66%|22%|

#### 发现问题

<table data-type="luckysheet_copy_action_table"><colgroup width="45px"></colgroup><colgroup width="59px"></colgroup><colgroup width="345px"></colgroup><colgroup width="169px"></colgroup><tr><td  style="height:19px;font-weight: bold;">序号</td><td  style="font-weight: bold;">优先级</td><td  style="font-weight: bold;">问题简述</td><td  style="font-weight: bold;">当前状态</td></tr><tr><td  style="height:30.5px;">1</td><td>次要</td><td>	server_config.yaml文件新增配置项且修改了原默认配置无明确知会，导致安装脚本失败</td><td>关闭</td></tr><tr><td  style="height:30.5px;">2</td><td>不重要</td><td>ERROR日志级别错误，实际显示为INFO</td><td>关闭</td></tr><tr><td  style="height:30.5px;">3</td><td>主要</td><td>server配置文件is_require_sign设为false时，在调用challenge接口时未获取到密钥返回状态码500，接口调用失败</td><td>关闭</td></tr><tr><td  style="height:30.5px;">4</td><td>次要</td><td>server_config.yaml文件中部分配置项未在服务时校验合法性，配置非法值时服务正常启动，请定位修改</td><td>关闭</td></tr><tr><td  style="height:30.5px;">5</td><td>次要</td><td>RBS服务在批量获取资源策略时，传入的id为非法值接口的返回码为200，不符合预期</td><td>关闭</td></tr><tr><td  style="height:30.5px;">6</td><td>次要</td><td>多个返回码400请求缺少日志打印，重复打印问题</td><td>关闭</td></tr><tr><td  style="height:30.5px;">7</td><td>次要</td><td>agent配置文件各组件配置项log_file_path、dim_log_file_path配置为空时，agent重启失败</td><td>关闭</td></tr><tr><td  style="height:30.5px;">8</td><td>次要</td><td>远程证明NPU组件篡改证据进行挑战，返回码预期400，实际为500</td><td>关闭</td></tr><tr><td  style="height:30.5px;">9</td><td>不重要</td><td>策略证书过期后，调用获取token接口失败，对应报错日志失败原因不明确</td><td>关闭</td></tr><tr></table>

# 4 详细测试结论

## 4.1.功能测试

### 4.1.1.继承特性测试结论

<table data-type="luckysheet_copy_action_table"><colgroup width="56px"></colgroup><colgroup width="135px"></colgroup><colgroup width="169px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:19px;">序号</td><td>组件/特性名称</td><td>特性质量评估</td><td>备注</td></tr><tr><td  style="height:19px;">1</td><td>支持TPM/vTPM的远程证明服务组件</td><td>■</td><td></td></tr><tr><td  style="height:19px;">2</td><td>支持VirtCCA的远程证明服务组件</td><td>■</td><td></td></tr><tr><td  style="height:19px;">3</td><td>支持itrustee的远程证明服务组件</td><td>■</td><td><tr><td  style="height:19px;">4</td><td>支持NPU的远程证明服务组件</td><td>■</td><td><tr><td  style="height:19px;">5</td><td>支持cca的远程证明服务组件</td><td>■</td><td></tr></table>

●： 表示特性不稳定，风险高 ▲： 表示特性基本可用，遗留少量问题 ■： 表示特性质量良好

### 4.1.2.新增特性测试结论

<table data-type="luckysheet_copy_action_table"><colgroup width="56px"></colgroup><colgroup width="135px"></colgroup><colgroup width="169px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:19px;">序号</td><td>组件/特性名称</td><td>特性质量评估</td><td>备注</td></tr><tr><td  style="height:19px;">1</td><td>支持DICE的远程证明服务组件</td><td>■</td><td></td><tr><td  style="height:19px;">2</td><td>增加可信计算资源分发服务组件</td><td>■</td><td></td></tr></tr></table>

●： 表示特性不稳定，风险高 ▲： 表示特性基本可用，遗留少量问题 ■： 表示特性质量良好

## 4.2.兼容性测试结论

不涉及


## 4.3.DFX专项测试结论

### 4.3.1.性能测试结论

不涉及

### 4.3.2.可靠性/韧性测试结论

|可靠性测试|测试方法|测试结果|
|---|---|---|
|长稳压力测试|连续挑战7*24H不存在组件崩溃服务异常，内存会随着运行时间慢慢上升，但是不会超过最大占用占比无泄漏现象，句柄占用正常使用，无一直增加现象|通过|

### 4.3.3.安全测试结论

<table data-type="luckysheet_copy_action_table"><colgroup width="45px"></colgroup><colgroup width="175px"></colgroup><colgroup width="345px"></colgroup><tr><td  style="height:19px;font-weight: bold;">序号</td><td  style="font-weight: bold;">安全性测试活动</td><td  style="font-weight: bold;">结果</td></tr><tr><td  style="height:19px;">1</td><td>主机漏洞扫描</td><td>PASS</td></tr><tr><td  style="height:19px;">2</td><td>软件包安全扫描</td><td>PASS</td></tr><tr><td  style="height:19px;">3</td><td>敏感信息扫描</td><td>PASS</td></tr><tr><td  style="height:19px;">4</td><td>开放端口检查</td><td>PASS</td></tr><tr><td  style="height:19px;">5</td><td>安全编码</td><td>PASS</td></tr></table>

## 4.3.4.资料测试结论

经测试。测试结论为PASS，文档路径：

[https://atomgit.com/openeuler/global-trust-authority/tree/master/docs](https://atomgit.com/openeuler/global-trust-authority/tree/master/docs)

<table data-type="luckysheet_copy_action_table"><colgroup width="175px"></colgroup><colgroup width="345px"></colgroup><colgroup width="169px"></colgroup><tr><td  style="height:19px;font-weight: bold;">领域</td><td  style="font-weight: bold;">手册名称</td><td  style="font-weight: bold;">测试结果</td></tr><tr><td rowspan="8" colspan="1" style="height:19px;">远程证明</td><td>Challenge_Request_Challenge_Response_Environment_Preparation.md</td><td>PASS</td></tr><tr><td>Complete_List_of_Management_Tool_Commands.md</td><td>PASS</td></tr><tr><td>GTA_Usage_Guidelines.md</td><td>PASS</td></tr><tr><td>api_documentation.md</td><td>PASS</td></tr><tr><td>attestation_agent.md</td><td>PASS</td></tr><tr><td>attestation_common.md</td><td>PASS</td></tr><tr><td>attestation_service.md</td><td>PASS</td></tr><tr><td>key_manager_install.md</td><td>PASS</td></tr></table>

## 4.4 其他测试结论

无其他测试任务

# 5.测试执行

## 测试执行统计数据
<table data-type="luckysheet_copy_action_table"><colgroup width="175px"></colgroup><colgroup width="121px"></colgroup><colgroup width="169px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:19px;font-weight: bold;">版本名称</td><td  style="font-weight: bold;">测试用例数</td><td  style="font-weight: bold;">用例执行结果</td><td  style="font-weight: bold;">发现缺陷数</td></tr><tr><td  style="height:19px;">openEuler-24.03-LTS-SP4</td><td>396</td><td>PASS</td><td>9</td></tr></table>

# 后续测试建议

暂无

# 附件

暂无
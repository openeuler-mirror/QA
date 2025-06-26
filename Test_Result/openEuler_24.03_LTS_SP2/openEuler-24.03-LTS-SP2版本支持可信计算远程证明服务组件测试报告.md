![](./images/image.png)
版权所有 © 2025 openEuler社区 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录
<table data-type="luckysheet_copy_action_table"><colgroup width="93px"></colgroup><colgroup width="72px"></colgroup><colgroup width="105px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:19px;font-weight: bold;">日期</td><td  style="font-weight: bold;">修订版本</td><td  style="font-weight: bold;">修改描述</td><td  style="font-weight: bold;">作者</td></tr><tr><td  style="height:19px;">2025-06-18</td><td>v1</td><td>整体报告新增</td><td>马锐</td></tr></table>

关键词：

摘要：

缩略语清单：
<table data-type="luckysheet_copy_action_table"><colgroup width="93px"></colgroup><colgroup width="143px"></colgroup><colgroup width="185px"></colgroup><tr><td  style="height:19px;font-weight: bold;">缩略语</td><td  style="font-weight: bold;">英文全名</td><td  style="font-weight: bold;">中文解释</td></tr><tr><td  style="height:114.5px;">TPM</td><td>Trusted Platform Module</td><td>可信平台模块是一种集成在计算机硬件中的安全芯片，主要用于提供加密、身份验证、数据保护等安全功能</td></tr></table>

# 1. 特性概述

远程证明服务可实现分布式系统之间的硬件验证信任。它通过加密证明验证远程节点（例如，云实例）的完整性，确保它们在可信状态下运行真实软件。

Server：主要用于持续验证部署了代理的机器，确保其完整性和可信性。

CLI：用于管理服务所需的输入/输出文件或策略信息。

Agent：部署在需要验证的机器上，收集IMA和TPM PCR数据，与服务建立可信关系。

Key\_Manager：使用第三方密钥管理工具存储和提供服务在验证过程中所需的加密密钥。

# 2. 特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。
- 测试周期

<table data-type="luckysheet_copy_action_table"><colgroup width="164px"></colgroup><colgroup width="150px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:19px;font-weight: bold;">名称</td><td  style="font-weight: bold;">起始时间</td><td  style="font-weight: bold;">结束时间</td></tr><tr><td  style="height:19px;">Openeuler 24.03.SP2.RC4</td><td>2025-05-21</td><td>2025-05-29</td></tr><tr><td  style="height:19px;">Openeuler 24.03.SP2.RC4</td><td>2025-05-29</td><td>2025-05-29</td></tr><tr><td  style="height:19px;">Openeuler 24.03.SP2.RC4</td><td>2025-05-29</td><td>2025-06-06</td></tr><tr><td  style="height:19px;">Openeuler 24.03.SP2.RC5</td><td>2025-06-06</td><td>2025-06-09</td></tr></table>

- 测试硬件环境信息

|||
|---|---|
|机型|Kunpeng 920|
|iBMC|5.09.00.02|
|BIOS|21.16|
|CPU|Kunpeng 920|
|硬盘|系统盘：8\*2.5 SAS/SATA|
|OS|Openeuler 24.03.SP2.RC4以及Openeuler 24.03.SP2.RC5|
|TPM以及vTPM|协议：2.0，厂商：NTZ，厂商版本 ：7.51，芯片型号：NTZ32H330


# 3. 测试结论概述

## 3.1. 测试整体结论

该版本主要验证远程证明基础功能和性能,安全合规性。

* **测试活动覆盖度**：测试活动主要覆盖了功能、性能、资料、可靠性以及安全专项测试，所有测试活动均完成且充分开展。
* **测试用例覆盖度**：共涉及用例167个，用例执行率100%，用例通过率100%，测试执行充分，版本交付范围无遗留问题单
* **问题发现情况：**版本内共发现问题单18个，18个问题均已闭环
* **总体结论：**

综上，远程证明在测试阶段完成了功能测试、安全测试、兼容性测试以及可靠性测试， 测试认为该版本在各阶段测试活动开展充分，版本交付范围内无新增遗留问题
<table data-type="luckysheet_copy_action_table"><colgroup width="97px"></colgroup><colgroup width="150px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:30.5px;font-weight: bold;">测试活动</td><td  style="font-weight: bold;">测试子项</td><td  style="font-weight: bold;">活动评价</td></tr><tr><td  style="height:30.5px;">功能测试</td><td>新增特性测试</td><td>PASS</td></tr><tr><td  style="height:32.5px;">兼容性测试</td><td>架构兼容性/硬件兼容性</td><td>PASS</td></tr><tr><td  style="height:30.5px;">DFX专项测试</td><td>可靠性/长稳压力测试</td><td>PASS</td></tr><tr><td  style="height:19px;">DFX专项测试</td><td>安全测试</td><td>PASS</td></tr><tr><td  style="height:31.5px;">资料测试</td><td></td><td>PASS</td></tr></table>


## 3.2.约束说明

rpm安装形式客户需要预置

1. TPM2.0芯片或者vTPM，以及TPM的AK证书
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
|数目|18|5|9|4|0|
|百分比|100%|27%|50%|23%|0|

#### 发现问题

<table data-type="luckysheet_copy_action_table"><colgroup width="45px"></colgroup><colgroup width="59px"></colgroup><colgroup width="345px"></colgroup><colgroup width="169px"></colgroup><tr><td  style="height:19px;font-weight: bold;">序号</td><td  style="font-weight: bold;">优先级</td><td  style="font-weight: bold;">问题简述</td><td  style="font-weight: bold;">当前状态</td></tr><tr><td  style="height:30.5px;">1</td><td>一般</td><td>【测试提单】【远程证明】【安全扫描】源码敏感信息扫描结果存在个人邮箱</td><td>关闭</td></tr><tr><td  style="height:30.5px;">2</td><td>一般</td><td>【测试提单】【远程证明】attestation_service日志转储后权限过大</td><td>关闭</td></tr><tr><td  style="height:19px;">3</td><td>提示</td><td>【测试提单】【远程证明】【日志】agent端重复打印日志</td><td>关闭</td></tr><tr><td  style="height:30.5px;">4</td><td>一般</td><td>【测试提单】【远程证明】【安全】部分文件、脚本、目录不满足权限最小化要求</td><td>关闭</td></tr><tr><td  style="height:30.5px;">5</td><td>一般</td><td>【测试提单】【远程证明】【资料】远程证明资料存在问题，详见附件</td><td>关闭</td></tr><tr><td  style="height:32.5px;">6</td><td>提示</td><td>【测试提单】【远程证明】【规格】当前版本不支持tpm_ima验证，需求验证范围需同步</td><td>关闭</td></tr><tr><td  style="height:30.5px;">7</td><td>提示</td><td>【测试提单】【远程证明】证书管理不支持不同用户创建同名证书，需优化</td><td>关闭</td></tr><tr><td  style="height:19px;">8</td><td>严重</td><td>【测试提单】【远程证明】AK证书过期，预期挑战失败，实际挑战成功</td><td>关闭</td></tr><tr><td  style="height:31.5px;">9</td><td>严重</td><td>【测试提单】【远程证明】【功能】用户A删除用户B的基线预期失败，实际成功，且所有基线均被删除</td><td>关闭</td></tr><tr><td  style="height:19px;">10</td><td>严重</td><td>【测试提单】【远程证明】创建jwt类型策略失败</td><td>关闭</td></tr><tr><td  style="height:30.5px;">11</td><td>一般</td><td>【测试提单】【远程证明】更新基线接口返回的version值，与数据库存储不一致</td><td>关闭</td></tr><tr><td  style="height:50px;">12</td><td>提示</td><td>【测试提单】【远程证明】删除证书接口成功返回message信息，删除基线接口成功只返回200无message信息，同类接口需要排查，保持接口行为一致</td><td>关闭</td></tr><tr><td  style="height:50.5px;">13</td><td>一般</td><td>【测试提单】【远程证明】创建基线时，is_default参数未正常生效，传入true、false、或不传数据库中对应参数均存为1，refvalue_name不同用户不能同名，需要优化</td><td>关闭</td></tr><tr><td  style="height:30.5px;">14</td><td>一般</td><td>【测试提单】【远程证明】删除证书会同步删除吊销列表，设计不合理</td><td>关闭</td></tr><tr><td  style="height:30.5px;">15</td><td>一般</td><td>【测试提单】【远程证明】上传证书吊销列表未校验吊销列表有效期</td><td>关闭</td></tr><tr><td  style="height:32.5px;">16</td><td>严重</td><td>【测试提单】【远程证明】【功能】使用国民TPM芯片，Agent无法正常启动</td><td>关闭</td></tr><tr><td  style="height:48px;">17</td><td>一般</td><td>【测试提单】【远程证明】【资料】启动服务需要有LD_LIBRARY_PATH环境变量，文档中并未声明；缺少依赖件说明;未说明上传的证书需要为PEM格式</td><td>关闭</td></tr><tr><td  style="height:30.5px;">18</td><td>严重</td><td>【测试提单】【远程证明】【资料】当前开源仓库docs无法指导进行安装，API接口描述不合理</td><td>关闭</td></tr></table>

# 4 详细测试结论

## 4.1.功能测试

### 4.1.1.继承特性测试结论

新特性不涉及继承特性测试结论

●： 表示特性不稳定，风险高 ▲： 表示特性基本可用，遗留少量问题 ■： 表示特性质量良好

### 4.1.2.新增特性测试结论

<table data-type="luckysheet_copy_action_table"><colgroup width="56px"></colgroup><colgroup width="135px"></colgroup><colgroup width="169px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:19px;">序号</td><td>组件/特性名称</td><td>特性质量评估</td><td>备注</td></tr><tr><td  style="height:19px;">1</td><td>远程证明</td><td>■</td><td></td></tr></table>

●： 表示特性不稳定，风险高 ▲： 表示特性基本可用，遗留少量问题 ■： 表示特性质量良好

## 4.2.兼容性测试结论

<table data-type="luckysheet_copy_action_table"><colgroup width="169px"></colgroup><colgroup width="72px"></colgroup><colgroup width="72px"></colgroup><colgroup width="102px"></colgroup><tr><td  style="height:19px;font-weight: bold;">指标大项</td><td  style="font-weight: bold;">指标小项</td><td  style="font-weight: bold;">指标值</td><td  style="font-weight: bold;">测试结论</td></tr><tr><td  style="height:19px;">硬件TPM兼容性</td><td>国民技术芯片</td><td>NTZ32H330</td><td>PASS</td></tr><tr><td  style="height:19px;">架构兼容性</td><td>X86、aarch</td><td>X86、aarch</td><td>PASS</td></tr></table>


## 4.3.DFX专项测试结论

### 4.3.1.性能测试结论

无性能需求，不涉及

### 4.3.2.可靠性/韧性测试结论

|可靠性测试|测试方法|测试结果|
|---|---|---|
|特性可靠性|进程异常退出检查功能是否抛出异常不可用|PASS|
|长稳压力测试|以性能规格为基础，起点为3/4性能规格，逐步增加规格，检查服务是否异常以及资源是否超用等，长稳运行7\*24H|PASS|

### 4.3.3.安全测试结论

<table data-type="luckysheet_copy_action_table"><colgroup width="45px"></colgroup><colgroup width="175px"></colgroup><colgroup width="345px"></colgroup><tr><td  style="height:19px;font-weight: bold;">序号</td><td  style="font-weight: bold;">安全性测试活动</td><td  style="font-weight: bold;">结果</td></tr><tr><td  style="height:19px;">1</td><td>病毒扫描</td><td>PASS</td></tr><tr><td  style="height:19px;">2</td><td>安全编译选项检查</td><td>PASS</td></tr><tr><td  style="height:19px;">3</td><td>软件生命周期与漏洞测试</td><td>PASS</td></tr><tr><td  style="height:19px;">4</td><td>代码静态工具扫描</td><td>PASS</td></tr><tr><td  style="height:19px;">5</td><td>敏感信息扫描</td><td>PASS</td></tr><tr><td  style="height:19px;">6</td><td>加密算法扫描</td><td>PASS</td></tr><tr><td  style="height:19px;">7</td><td>开放端口检查</td><td>PASS</td></tr></table>

## 4.3.4.资料测试结论

经测试。测试结论为PASS，文档路径：

[https://gitee.com/openeuler/global-trust-authority/tree/master/docs](https://gitee.com/openeuler/global-trust-authority/tree/master/docs)

<table data-type="luckysheet_copy_action_table"><colgroup width="175px"></colgroup><colgroup width="345px"></colgroup><colgroup width="169px"></colgroup><tr><td  style="height:19px;font-weight: bold;">领域</td><td  style="font-weight: bold;">手册名称</td><td  style="font-weight: bold;">测试结果</td></tr><tr><td rowspan="2" colspan="1" style="height:19px;">远程证明</td><td>GTA_Usage_Guidelines.md</td><td>PASS</td></tr><tr><td>api_documentation.md</td><td>PASS</td></tr></table>

## 4.4 其他测试结论

无其他测试任务

# 5.测试执行

## 测试执行统计数据
<table data-type="luckysheet_copy_action_table"><colgroup width="175px"></colgroup><colgroup width="121px"></colgroup><colgroup width="169px"></colgroup><colgroup width="72px"></colgroup><tr><td  style="height:19px;font-weight: bold;">版本名称</td><td  style="font-weight: bold;">测试用例数</td><td  style="font-weight: bold;">用例执行结果</td><td  style="font-weight: bold;">发现缺陷数</td></tr><tr><td  style="height:19px;">Openeuler 24.03.SP2.RC4</td><td>4</td><td>PASS</td><td>1</td></tr><tr><td  style="height:19px;">Openeuler 24.03.SP2.RC4</td><td>130</td><td>PASS</td><td>12</td></tr><tr><td  style="height:19px;">Openeuler 24.03.SP2.RC4</td><td>8</td><td>PASS</td><td>0</td></tr><tr><td  style="height:19px;">Openeuler 24.03.SP2.RC4</td><td>11</td><td>PASS</td><td>3</td></tr><tr><td  style="height:19px;">Openeuler 24.03.SP2.RC5</td><td>14</td><td>PASS</td><td>2</td></tr></table>

# 后续测试建议

暂无

# 附件

暂无
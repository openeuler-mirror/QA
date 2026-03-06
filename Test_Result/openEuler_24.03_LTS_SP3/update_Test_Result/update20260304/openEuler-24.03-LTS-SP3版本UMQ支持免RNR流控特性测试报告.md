![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2026/3/02|1.0|创建测试报告|薛龙|
|      |             |          |      |

关键词： UMQ  JFR

摘要：对UMQ支持RNR流控情况进行总结说明


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|UMQ|Unified Message Queue|统一消息队列|
|JFR|Jetty for receive|用于接收消息的jetty|

# 1     特性概述

为确保业务IO处理流程中JFR有充足的RQE，避免芯片发生RNR后导致jetty故障不可用，UMQ支持以JFR中RQE数量为credit的流控功能，控制发送端可发送的IO数量

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|openEuler-24.03-LTS-SP3-update20260304|2026-1-14|2026-03-02| 

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|UB硬件|2节点互联组网|NA|

# 3     测试结论概述

## 3.1   测试整体结论

支持免RNR流控特性，共新增用例58个，主要覆盖API接口测试、功能测试、可靠性测试、特性耦合测试。测试功能包括：支持流控参数配置，支持流控报文统计，支持流控自适应，支持流控credit回收以及数据面通信等。当前发现问题已解决，回归通过，无遗留风险，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 |质量良好|
| 功能测试 | 新增特性测试 |质量良好|
| 兼容性测试 |          |不涉及|
| DFX专项测试 | 性能测试 |不涉及|
| DFX专项测试 | 可靠性/韧性测试 |质量良好|
| DFX专项测试 | 安全测试 |不涉及|
| 资料测试 |         |不涉及|
| 其他测试 |         |NA|

## 3.2   约束说明

1、两边必须同时开启流控

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- | 


### 3.3.2 问题统计

#### 3.3.2.1 问题数量

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |15|0|3|12|0|
| 百分比 |NA|0|20%|80%|0|

#### 3.3.2.2 发现问题

| 序号 | 问题单号 | 问题简述 | 优先级 | 当前状态 |
| --- | ------- | ------ | ------- | ------- |
| 1 |https://atomgit.com/openeuler/umdk/issues/62|开启流控，rx_depth=128, 流控参数默认，post_tx 返回-11，发起更新信用请求，credits_per_request预期按照128/16=8生效，实际只更新过来一个信用，赋值判断有误|次要|已验收
| 2 |https://atomgit.com/openeuler/umdk/issues/63|开启流控，flow_control.use_atomic_window = false，两边同时poll rx和tx， 数据面持续发送，当十几万次之后，出现发送申请credit请求失败，失败之后未释放发送权限|次要|已验收
| 3 |https://atomgit.com/openeuler/umdk/issues/70|开启流控，中断模式， bind完成后，空poll tx， queue的状态无法变成READY|次要|已验收
| 4 |https://atomgit.com/openeuler/umdk/issues/83|开启流控，发现unbind后还有流控请求交互导致 进程必现coredump在umq_ub_shared_credit_resp_send|主要|已验收
| 5 |https://atomgit.com/openeuler/umdk/issues/89|开启流控 post_rx 128次，unbind后 flush poll rx 排空后，调用流控统计查询pool_credit.pool_idle=128，预期应该变成0|次要|已验收
| 6 |https://atomgit.com/openeuler/umdk/issues/90|开启流控，两边互相打流，高概率出现一边发送信用请求失败，导致打流失败|次要|已验收
| 7 |https://atomgit.com/openeuler/umdk/issues/92|开启流控，共享jfr，10个子queue并发数据面，另起10个线程循环新create bind，unbind，destroy子queue，当停止并发后查询流控计数queue_be_allocted有翻转|次要|已验收
| 8 |https://atomgit.com/openeuler/umdk/issues/98|开启流控，use_atomic_window=false，创建1个父queue，一个子queue，触发子queue更新流控一次，total_queue_be_allocated一直为0 ， 预期不为0|次要|已验收
| 9 |https://atomgit.com/openeuler/umdk/issues/149|开启流控，init时配置credit_multiple=16，代码实际未赋值，导致未能生效|次要|已验收
| 10 |https://atomgit.com/openeuler/umdk/issues/72|未开启流控，程序coredump问题|主要|已验收
| 11 |https://atomgit.com/openeuler/umdk/issues/81|流控credit 申请，send tx，用户没有poll tx 导致流控 tx jfs 深度满的问题|次要|已验收
| 12 |https://atomgit.com/openeuler/umdk/issues/64|多eid场景 动态add 设备以后，出现coredump问题|主要|已验收
| 13 |https://atomgit.com/openeuler/umdk/issues/68|开启流控和共享jfr，创建1对父子queue，bind后post rx，子queue发送消息后，对端子queue去poll rx， 不应该poll到io消息|次要|已验收
| 14 |https://atomgit.com/openeuler/umdk/issues/69|未开启流控，执行read write基础场景，报错poll umq rx needs at least 2 buf |次要|已验收
| 15 |https://atomgit.com/openeuler/umdk/issues/168|开启流控， 1父queue 4子queue，高概率出现第四个子queue 短时间内申请不到信用 |次要|已验收


# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1|umq支持多设备|<font color=green>■</font> |   |
|2|umq初始化|<font color=green>■</font> |   |
|3|umq支持共享jfr|<font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1|支持流控参数配置| <font color=green>●</font> |   |
|2|支持免RNR自适应流控| <font color=green>●</font> |   |
|3|支持流控报文统计| <font color=green>●</font> |   |
|4|支持故障流控credit正常恢复| <font color=green>●</font> |   |
|5|umq日志整改规范| <font color=green>●</font> |   |


<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

不涉及

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|NA|NA|NA|

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|可靠性测试|开启流控时间跳变|测试通过，时间跳变对归还信用配置的超时时间无效|
|可靠性测试|流控归还和流控申请并发测试|测试通过，原子操作，归还信用和申请信用并发，不会导致总池子计数乱掉|

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|NA|NA|NA|

## 4.4 资料测试结论
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|NA|NA|NA|

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|NA|NA|NA|

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|openEuler-24.03-LTS-SP3-update20260304|58|成功|15|

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 
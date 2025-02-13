![openEuler ico](../../images/openEuler.png)

版权所有 © 2024 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2024-11-21 |  1.0.0    |  初稿     | 林孟孟 |

关键词：云原生 混部 联通云

摘要：openEuler云原生混部能力使能联通云

缩略语清单：
| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |

# 特性描述
<!-- 主要介绍特性实现的背景、功能以及作用 -->
背景：联通云当前cpu利用率<20%，对资源利用率提升有非常急迫诉求，达成降本增效。

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|[IB42HF](https://gitee.com/openeuler/release-management/issues/IB42HF?from=project-issue)| 【openEuler 24.03-LTS-SP1 】rubik在离线混部调度协同增强 | Developing | SIG-CloudNative-KubeOS | @jingwoo | ISO  | rubik |



# 特性分层策略
## 总体测试策略
<!-- 主要描述特性的整体测试策略，主要开展哪些测试(接口/功能/场景/专项) -->

- 测试目标：测试特性主要新增功能：cpu、mem水位线基本功能测试，覆盖systemd cgroup驱动。
- 时间进度：待评估
- 风险评估：NA
- 重点事项：rubik驱逐水位线接口测试，cpu驱逐水位线控制，内存驱逐水位线控制，cpu驱逐和内存驱逐互不干扰。
- 争议事项：NA

## 特性测试约束
<!-- 主要描述特性测试的约束条件 -->

NA

## 接口测试
<!-- 主要描述接口级测试策略及测试设计思路 -->

| 接口描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| rubik驱逐水位线接口测试 | 配置无效参数，如参数类型不匹配，参数不在有效范围等  | rubik pod启动失败  | NA  |

## 功能测试
<!-- 主要描述特性提供的功能的测试策略及测试思路 -->

| 功能描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| cpu驱逐水位线控制 | 默认配置运行rubik，启动3个离线pod，每个pod分别占用10%，50%，100%cpu，运行在线pod消耗cpu超过60%  |  cpu最高的离线pod被驱逐，之后每隔20s驱逐一个cpu占用最高的pod，直到离线pod全部被驱逐。在线pod不受影响    |      |
| 内存驱逐水位线控制 |  默认配置运行rubik，启动3个离线pod，每个pod分别占用100M，500M，1G内存，运行在线pod消耗内存超过60% |   mem占用最高的离线pod被驱逐，之后每隔20s驱逐一个mem占用最高的pod，直到离线pod全部被驱逐。在线pod不受影响   |     |



## 场景测试
<!-- 主要描述对特性使用的主要场景的测试策略及测试思路 -->

| 场景描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| cpu驱逐和内存驱逐互不干扰 |  运行3个离线pod，每个pod分别按照高、中、低占用cpu，同时按照相反的程度占用内存，运行pod同时让cpu和mem达到水位线 |  内存占用高的pod和cpu占用高的pod同时被驱逐，冷却结束后驱逐剩余pod  |     |
| 只有离线pod运行查看驱逐情况 |  内存占用高的pod和cpu占用高的pod同时被驱逐，冷却结束后驱逐剩余pod |  超过水位线后，cpu或内存占用最高的pod会被驱逐，直到cpu占用和内存占用下降到水位线下  |     |




## 专项测试
<!-- 主要描述其他专项测试,如安全测试 稳定性测试 性能测试 兼容性测试等 -->

| 专项测试类型 | 专项测试描述 | 测试预期结果 | 备注 |
| ----------- | ----------- | ----------- | ---- |
| 可靠性测试 | 大量离线pod需要被驱逐，开启cpu和内存水位线驱逐特性，创建100+在线和离线pod，查看rubik资源使用情况 | rubik资源使用不超过0.5 cpu，运行不会发生异常，水位线驱逐功能正常运行 |      |

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
|     round2       |  2024/11/22        |2024/11/28       |     12|                    全量测试           |        |
|     round3-round4         |   2024/11/28         |  2024/12/12         |7      |   回归测试+长稳测试                            |        |

# 入口标准  
1.特性满足质量标准，达成需求设计要求目标

# 出口标准  
1.策略规划的测试活动涉及测试用例100%执行完毕  
2.版本无严重问题遗留，其他问题有规避措施

# 附件

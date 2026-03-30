![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2026.03.24 | 1.0 | 创建 | 沈佳钰 |

关键词： UBS Comm，HCOM，UBSocket，UB通信

摘要：本报告主要描述针对HCOM新增接口和IPoverURMA方式建链以及UBSocket功能性能可靠性进行测试，输出测试结果。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|UBS Comm|UB Service core communication|UB通信库|
|HCOM|Hyper Communication|高性能通信库|
||||

# 1     特性概述

UBS Comm包括HCOM和UBSocket。

HCOM北向提供统一、易用的建链及通信接口，对用户屏蔽底层不同通信协议差异。针对不同业务场景，支持多路径/单路径选择能力，满足时延优先或带宽优先的不同诉求。支持纯UB网络建链，不依赖TCP/TP网卡，节省网卡成本。 

UBSocket是一个基于UB通信网络，通过劫持Socket API接口实现的高性能通信库。用户无需修改原有基于Socket API开发的代码，即可基于UB网络进行通信加速。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP3-update20260325 | 2026/03/20 | 2026/3/25 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|kunpeng 950新版本|典型配置| 两节点 |

# 3     测试结论概述

## 3.1   测试整体结论

HCOM共计执行1255个用例，主要覆盖了接口，功能，性能，可靠性，安全和可服务性测试，发现1个一般问题，无遗留风险，整体质量良好

| 测试活动   | 测试子项                       | 活动评价 |
|--------|----------------------------| ------- |
| 接口测试   | Read Sgl/Write Sgl | 测试通过 |
| 功能测试   | HCOM支持IPoverURMA建链通信 | 测试通过 |
| 性能测试   | 单双边时延                   | 测试通过 |
| 专项测试   | HCOM进程异常退出恢复                       | 测试通过 |
| 资料测试   | 资料文档                       | 测试通过 |

UBSocket共计执行37个用例，主要覆盖了功能，性能，可靠性，安全和可服务性测试，发现1个一般问题，1个遗留，整体风险可控

| 测试活动   | 测试子项                       | 活动评价 |
|--------|----------------------------| ------- |
| 功能测试   | UBSocket劫持brpc建链通信               | 测试通过 |
| 性能测试   | 与原生TCP相比P99时延下降40%                  | 遗留问题1个
| 专项测试   | UBSocket链路故障                   | 测试通过 |
| 资料测试   | 资料文档                       | 测试通过 |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件
1. 依赖UB硬件
2. 需要URMA配套支持。
3. HCOM、UBSocket本身不做并发限制，能够支持的链接数量取决于硬件规格

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号| 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| ---  | ------ | ------ | ------- | ------- | ------- | ---------- | 
|   1    | https://atomgit.com/openeuler/ubs-comm/issues/24|  UBSocket小包性能优化     |  一般       |   不涉及功能影响，仅1并发场景下，小包性能优化指标不达标     |   仅在1并发小包场景优化不达40%，其余大包场景、多并发场景都达到40%及以上，客户面影响可控      |      NA      |

### 3.3.2 问题统计

#### 3.3.2.1 问题数量

|        | 问题总数 | 严重  | 主要  | 次要  | 不重要 |
| ------ |------|-----|-----|-----|-----|
| 数目   | 2    | 0   | 2  | 0   | 0   |
| 百分比 | 100  | 0   | 100   | 0   | 0   |

#### 3.3.2.2 发现问题

| 序号 | 问题单号 | 问题简述 | 优先级 | 当前状态 |
| --- | ------- | ------ |-----| ------- |
| 1 | https://atomgit.com/openeuler/ubs-comm/issues/24   |  UBSocket小包性能优化   | 一般  |   遗留到下一个版本解决
| 2 |  https://atomgit.com/openeuler/ubs-comm/issues/18   |   hcom rdma perf性能带宽最大只有10GB/s，性能不足预期   | 一般  |   已验收


# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称        | 特性质量评估 | 备注 |
|---|----------------| :--------: | --- |
| 1   | HCOM支持UB通信 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ---------- | :--------: | --- |
| 1   | HCOM支持IPoverURMA方式建链 | <font color=green>■</font> |   |
| 2   | HCOM支持readsgl和writesgl| <font color=green>■</font> |   |
| 3   | UBSocket通信加速库，支持拦截TCP应用中的POSIX Socket API，将TCP通信转换为UB高性能通信，从而实现通信加速 | <font color=green>■</font>|   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

| 测试类型 | 测试内容 | 测试结论 |
|------| ------- | -------- |
| 接口测试   | Read Sgl/Write Sgl | 测试通过 |
| 功能测试   | HCOM支持IPoverURMA建链通信、 UBSocket劫持brpc建链通信              | 测试通过 |

## 4.2 兼容性测试结论

不涉及


## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论
#### 4.3.1.1 HCOM性能指标

| 指标大项 | 指标小项 | 指标值 | 测试值 | 测试结论 |
| ------- | ------- | ------ | -------  | ------- |
|    hcom软件栈时延     |     8KB单并发send    |  2.0us   | 1.69us   |  PASS       |
|   hcom软件栈时延    |     256KB单并发send     |  7.0us   | 6.86us   |  PASS       |
|    hcom软件栈时延   |     8KB单边read     |  0.5us   | 0.17us   |  PASS       |
|    hcom软件栈时延    |     8KB单边write     |  0.5us   | 0.29us   |  PASS       |

#### 4.3.1.2 UBSocket性能指标

| 指标大项 | 指标小项 | 指标值 | 测试值 | 测试结论 |
| ------- | ------- | ------ | -------  | ------- |
|    UBSocket与原生TCP相比P99时延下降40%     |     1K    |  40%   |  -26.47%  |       FAIL      |
|    UBSocket与原生TCP相比P99时延下降40%  |    4K    |  40%  | 8.7%   |    FAIL        |
|    UBSocket与原生TCP相比P99时延下降40%   |     8K   |  40%  | 12.0%  |   FAIL     |
|     UBSocket与原生TCP相比P99时延下降40%    |     100K    |  40%   | 48.13%  |  PASS       |
|     UBSocket与原生TCP相比P99时延下降40%    |     200K    |  40%   | 54.27%   |  PASS       |

小包场景下性能指标不达标，遗留到下一个版本解决

### 4.3.2 可靠性/韧性测试结论

| 测试类型  | 测试内容 | 测试结论 |
|-------| ------- | -------- |
| 可靠性测试 | HCOM进程异常退出恢复                 | 测试通过 |
| 可靠性测试  | UBSocket链路故障                  | 测试通过 |

### 4.3.3 安全测试结论

| 测试类型     | 测试内容       | 测试结论         |
| ----------- | ------------- | ---------------- |
| 安全工具扫描 | 端口扫描       | 测试通过 |
| 安全工具扫描 | 软件包安全扫描 | 测试通过 |
| 安全工具扫描 | 敏感信息扫描   | 测试通过 |
| 安全工具扫描 | 病毒扫描       | 测试通过 |
| 白盒安全验证 | 源码安全审计   | 测试通过 |
| 白盒安全验证 | DT fuzz测试   | 测试通过 |

## 4.4 资料测试结论

| 测试类型 | 测试内容 | 测试结论 |
|------| ------- | -------- |
| 资料测试 |https://atomgit.com/openeuler/ubs-comm/blob/master/README.md| 测试通过 |
|资料测试 |https://atomgit.com/openeuler/ubs-comm/blob/master/doc/hcom/HCOM-API-Spec.md| 测试通过 |
| 资料测试 |https://atomgit.com/openeuler/ubs-comm/blob/master/doc/hcom/HCOM-Architecture-Design-Specification.md| 测试通过 |
| 资料测试 |https://atomgit.com/openeuler/ubs-comm/blob/master/doc/hcom/HCOM-Code-Structure.md| 测试通过 |
| 资料测试 |https://atomgit.com/openeuler/ubs-comm/blob/master/doc/hcom/HCOM-Secure-Check-Guide.md| 测试通过 |
| 资料测试 |https://atomgit.com/openeuler/ubs-comm/blob/master/doc/hcom/HCOM-Tutorial-Demo.md| 测试通过 |
| 资料测试 |https://atomgit.com/openeuler/ubs-comm/blob/master/doc/hcom/HCOM-Tutorial-UseCase.md| 测试通过 |
| 资料测试 |https://atomgit.com/openeuler/ubs-comm/blob/master/src/ubsocket/README.md| 测试通过 |

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

# 5     测试执行

## 5.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|openEuler-24.03-LTS-SP3-update20260325 | 1292 | 1292 | 2    |


## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*
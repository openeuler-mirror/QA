![openEuler ico](https://gitee.com/openeuler/QA/raw/master/images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期       | 修订版本 | 修改描述    | 作者   |
| ---------- | -------- | ----------- | ------ |
| 2023/05/22 | v1.0     | TEE远程证明 | 朱晓莲 |

关键词：  TEE，远程证明

摘要：本文是openEuler 22.03 LTS SP2版本上TEE远程证明特性的整体测试策略，用于指导该版本后续测试活动的开展。


缩略语清单：

| 缩略语 | 英文全名                      | 中文解释     |
| ------ | ----------------------------- | ------------ |
| TEE    | Trusted Execution Environment | 可信执行环境 |


# 特性描述

远程证明作为可信计算以及机密计算领域的一个重要环节，配合目标系统的可信启动支持，实现对目标系统的平台、系统及应用的完整性感知和检测，为数据中心管理工具及云平台系统资源编排工具提供准确、及时的可信状态报告。

TEE远程证明是鲲鹏安全生态开源组件鲲鹏安全库的一个重要特性，支撑基于鲲鹏平台构建开源机密计算解决方案。当数据中心管理工具/管理员、云服务基础设施编排工具、密钥管理中心/模型提供方希望获取目标服务器上TEE中TA的可信状态时，需要触发TEE远程证明特性的功能。

## 需求清单

| no   | feature | status | sig  | owner | 发布方式 | 涉及软件包列表 |
| :--- | :------ | :----- | :--- | :---- | :------- | :------------- |
|      |         |        |      |       |          |                |
|      |         |        |      |       |          |                |

## 特性应用场景分析

<!-- 主要描述特性的应用场景分析，指导后面场景测试的测试策略制定 -->

TEE远程证明特性的应用场景主要是虚拟环境和物理环境。

1. 虚拟环境主要是指没有TPM和TrustZone的平台，需要使用RAC的测试模式和使用libqca的simulator来进行测试。
2. 物理环境主要是指至少有TPM和TrustZone之中的一样或者全部的平台，RAC可以以正常模式启动。

## 特性实现流程描述

<!-- 主要描述特性实现的流程，可使用流程图等方式描述 -->

### 最小实现

用户可基于TEE Verifier Lib和QCA Lib（由华为对外发布）自行编写TEE Attester来验证TEE中用户TA的完整性，使用TEE自生成的AK。

![最小实现](https://gitee.com/openeuler/kunpengsecl/raw/master/doc/TEE-flow.png)

### 独立实现

用户可基于TEE Verifier Lib和QCA Lib（由华为对外发布）自行编写TEE Attester来验证TEE中用户TA的完整性，使用TEE AK Service生成AK。

NO_DAA场景：

![独立实现1](https://gitee.com/openeuler/kunpengsecl/raw/master/doc/NoDAA_ak_generate.jpg)

WITH_DAA场景：
![独立实现2](https://gitee.com/openeuler/kunpengsecl/raw/master/doc/DAA_ak_generate.jpg)

### 整合实现

用户可使用整合在安全库已有远程证明框架中的TEE/TA远程证明能力来验证TEE中用户TA的完整性。

![整合实现](https://gitee.com/openeuler/kunpengsecl/raw/master/doc/integrated-implementation.png)

## 与其他特性交互描述

<!-- 主要描述特性与其他特性或功能的交互 -->

TEE远程证明特性需要在原始的平台远程证明特性基础上进行实现。

## 风险项

<!-- 主要描述特性已知风险项 -->

# 特性分层策略

## 总体测试策略

<!-- 主要描述特性的整体测试策略，主要开展哪些测试(接口/功能/场景/专项) -->

TEE远程证明测试分为两个场景，分别是虚拟环境和物理环境。虚拟环境主要是指没有TPM和TrustZone的平台；物理环境主要是指至少有TPM和TrustZone之中的一样或者全部的平台。测试主要是在两个场景下进行TEE远程证明的接口/功能测试。

## 接口/功能测试

<!-- 主要描述接口级测试策略及测试设计思路 -->

| 接口描述                                                     | 设计思路                                                     | 测试重点                                                     | 备注 |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ---- |
| 生成TEE AK和TA报告，并验证报告完整性                         | 1.管理员启动QCA之后，先通知QTA生成RSA AK及AK Cert；<br />2.再让QTA生成给定ID TA的完整性报告；<br />3.并通过运行TEE Attester访问QAPI获取完整性报告；<br />4.然后运行TEE Attester访问TEE Verifier Libs设置TA完整性验证策略；<br />5.最后运行TEE Attester访问TEE Verifier Lib验证TA的完整性报告。 | 1.TEE AK生成<br />2.TA报告生成<br />3.TA报告获取<br />4.TA验证策略设置<br />5.TA完整性验证 |      |
| NoDAA情况下生成AK                                            | 1.管理员运行QCA配合QTA和TEE AK Service为TEE生成RSA  AK和AK Cert；<br />2.TEE AK Service验证QTA完整性度量值。 | NoDAA生成AK                                                  |      |
| DAA情况下生成AK，设定DAA协议参数，生成TA报告，并验证其完整性 | 1.管理员运行QCA配合QTA和TEE AK Service为TEE生成匿名AK/gpk和AK Cert，TEE AK Service需要验证QTA完整性度量值；<br />2.访问TEE AK Service的RestAPI接口，设定所需的DAA协议参数；<br />3.通知QCA让QTA使用匿名AK生成给定ID TA的完整性报告；<br />4.运行TEE Attester访问TEE Verifier Lib设定使用匿名AK的TA完整性验证策略；<br />5.运行TEE Attester访问TEE Verifier Lib验证基于匿名AK的TA完整性报告。 | 1.DAA AK生成<br />2.DAA生成参数设定<br />3.基于DAA的TA报告生成<br />4.基于DAA的TA验证策略设定<br />5.基于DAA的TA完整性验证 |      |
| 获取TA完整性报告，并将其整合到平台完整性报告中，<br />自动生成和手动设定TA完整性验证策略，<br />最后RAS验证TA完整性并报告TA完整性状态 | 1.运行RAC访问QCA提供的QAPI获取给定ID TA的完整性报告；<br />2.将获取到的TA完整性报告集成到平台完整性报告中，并通过RAS的ClientAPI报告给RAS。<br />3.设定RAS为自动模式，RAS根据服务器平台上对应TA的首个完整性报告自动生成验证策略，并通过TEE Verifier Lib进行设置；<br />4.通过RAS的RestAPI来调用TEE Verifier Lib设定特定TA的完整性验证策略；<br />5.运行RAS通过调用TEE Verifier Lib来完成给定TA的完整性验证；<br />6.通过RAS的RestAPI获取给定TA的完整性状态。 | 1.RAC侧TA报告获取<br />2.完整性报告TA内容整合<br />3.TA完整性验证策略自动生成<br />4.TA完整性验证策略设定<br />5.RAS感知验证TA完整性<br />6.RAS报告TA完整性状态 |      |

## 场景测试

<!-- 主要描述对特性使用的主要场景的测试策略及测试思路 -->

| 场景描述 | 设计思路                                           | 测试重点                                                     | 备注 |
| -------- | -------------------------------------------------- | ------------------------------------------------------------ | ---- |
| 虚拟环境 | 使用RAC的测试模式和使用libqca的simulator来进行测试 | 在没有TPM和TrustZone的平台，测试TEE远程证明特性的接口/功能测试是否能成功通过。 |      |
| 物理环境 | 使用RAC的正常模式和使用QCA来进行测试               | 在至少有TPM和TrustZone之中的一样或者全部的平台，测试TEE远程证明特性的接口/功能测试是否能成功通过。 |      |

## 专项测试

<!-- 主要描述其他专项测试,如安全测试 可靠性、韧性测试 性能测试 兼容性测试等 -->

| 专项测试类型 | 专项测试描述 | 测试预期结果 | 备注 |
| ------------ | ------------ | ------------ | ---- |
|              |              |              |      |
|              |              |              |      |

# 特性测试执行策略

## 特性测试依赖描述

<!-- 主要描述特性测试所依赖的执行环境、软件包、环境变量等依赖 -->

1. 软件包地址：[Show openEuler:22.03:LTS:SP2](https://build.openeuler.openatom.cn/package/show/openEuler:22.03:LTS:SP2/kunpengsecl)
2. 
3. 

## 特性测试约束

<!-- 主要描述特性测试的约束条件 -->

1. 
2. 
3. 

## 特性测试环境描述

<!-- 主要描述执行测试的硬件信息 -->

| 硬件型号                       | 硬件配置信息                                                 | 备注 |
| ------------------------------ | ------------------------------------------------------------ | ---- |
| 惠普 Pavilion Laptop 14-ce1xxx | 8核，Intel(R) Core(TM) i5-8265U CPU @1.60GHz  1.80 GHz<br />显卡：Intel(R) UHD Graphics 620 |      |

## 测试计划

<!-- 测试执行策略主要描述该轮次执行的分层策略中的测试项 -->

| Stange name  | Begin time | End time   | Days | 测试执行策略                          | 备注 |
| :----------- | :--------- | :--------- | ---- | ------------------------------------- | ---- |
| Test round 3 | 2023-06-03 | 2023-06-09 | 7    | TEE远程证明相关部件安装及基本功能测试 |      |
| Test round 4 | 2023-06-10 | 2023-06-16 | 7    | 全量功能测试                          |      |
| Test round 5 | 2023-06-17 | 2023-06-23 | 7    | 回归测试                              |      |
| Test round 6 | 2023-06-24 | 2023-06-30 | 7    | 回归测试                              |      |

## 入口标准

<!--> 描述整个测试执行阶段的入口条件，包括前个阶段的检查、用例执行、问题修复等情况
例如:

1. 功能开发已完成
2. 上阶段无block问题遗留
3. 基础功能验证正常
   <-->

## 出口标准

<!--> 本节描述整个测试执行阶段的出口 

1. 策略规划的测试活动涉及测试用例100%执行完毕
2. 性能基线、功能基线等满足特性规划目标
3. 无block问题遗留，其它严重问题要有相应规避措施或说明
   <-->

# 附件
![avatar](../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期       | 修订版本     | 修改描述  | 作者 |
| ----       | ----------- | -------- | ---- |
|2025-11-18  |  1.0.0      | 初稿     | 阮瑞  |

关键词： 
vTPCM, 可信 3.0，虚机生命周期管理
vTPCM, Trusted 3.0, VM Lifecycle Management
 
摘要：
电信、移动纷纷推出安全云主机产品，鲲鹏基于 GCH 安全底座切入，希望构建安全和性能领先竞争力抢占格局。但是，目前 TPCM 可信计算目前仅支持 Host 主机度量，还需支持虚机场景。本需求针对 vTPCM 场景提供基础可信虚机生命周期管理能力，配合 BMC 端需求共同弥补虚机场景能力缺失。本资料聚焦于支持 OS 侧可信虚机的生命周期管理，支持使用 cli/api 进行虚机创建、启动、停止、删除、迁移等操作，并嵌入相应可信流程。
China Telecom and China Mobile have launched secure cloud host products. Kunpeng is based on the GCH security base and hopes to build leading competitiveness in security and performance to seize the market landscape. However, currently, TPCM trusted computing supports only host measurement and needs to support VM scenarios. This requirement provides the basic trusted VM lifecycle management capability for the vTPCM scenario and works with the BMC to make up for the lack of VM scenario capabilities. This document focuses on the lifecycle management of trusted VMs on the OS side, supports operations such as creating, starting, stopping, deleting, and migrating VMs using cli/api, and embeds the corresponding trusted processes.

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|vTPCM   |virtualized Trusted Platform Control Module |虚拟可信平台控制模块  |
|TPCM    |Trusted Platform Control Module             |可信平台控制模块          |
|CLI    |Command Line Interface                       |命令行界面          |
|API     |Application Programming Interface           |应用程序编程接口          |
|KVM     |Kernel-based&nbsp;Virtual&nbsp;Machine      |基于&nbsp;Linux&nbsp;内核的虚拟化技术          |
|QEMU    |Quick&nbsp;Emulator                         |机器模拟器和虚拟化器          |


# 特性描述
电信、移动纷纷推出安全云主机产品，鲲鹏基于 GCH 安全底座切入，希望构建安全和性能领先竞争力抢占格局。但是，目前 TPCM 可信计算目前仅支持 Host 主机度量，还需支持虚机场景。针对 vTPCM 场景提供基础可信虚机生命周期管理能力，配合 BMC 端需求共同弥补虚机场景能力缺失。支持 OS 侧可信虚机的生命周期管理，支持使用 cli/api 进行虚机创建、启动、停止、删除、迁移等操作，并嵌入相应可信流程。

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|1    |TSB-agent: 支持可信计算虚拟化vTPCM  |Accepted  |sig-security-facility    |@cx22757    |EPOL    |virtrust-sh,libvirtrust,libvirtrustd     |



## 特性应用场景分析
<!-- 主要描述特性的应用场景分析，指导后面场景测试的测试策略制定 -->
1. 支持虚机场景下的启动度量，预留虚机动态度量能力，以及支持虚机的生命周期管理（虚机创建、展示、启动、关闭、删除、迁移）
2. 同时BMC支持多虚机管理，对每个虚机预留虚拟可信根vTCM，支持虚机的机密数据管理（使用物理TCM芯片进行防护）

## 特性实现流程描述
<!-- 主要描述特性实现的流程，可使用流程图等方式描述 -->
支持 OS 侧可信虚机的生命周期管理，本次交付的最终产物为virtrust，通过底层调用libvirt，libvirt通过调用QEMU-KVM来进行虚拟管理，同时virtrust通过调用tsb-agent来实现可信度量。使用 cli/api 进行虚机创建、启动、停止、展示、删除、迁移。
## 与其他特性交互描述
<!-- 主要描述特性与其他特性或功能的交互 -->
新增特性，不涉及与其它特性交互
## 风险项
<!-- 主要描述特性已知风险项 -->
暂无
# 特性分层策略
## 总体测试策略
<!-- 主要描述特性的整体测试策略，主要开展哪些测试(接口/功能/场景/专项) -->
测试目标：在Host端使用 cli/api 进行虚机创建、展示、启动、停止、删除、迁移成功。
时间进度：待评估
风险评估：NA
重点事项：虚拟机生命周期管理的功能验证
争议事项：NA

## 接口/功能测试
<!-- 主要描述接口级测试策略及测试设计思路 -->
| 接口描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
|创建虚拟机|验证可信虚机通过CLI/API创建成功       |使用CLI/API创建虚拟机成功        |      |
|展示虚拟机|验证可信虚机通过CLI/API展示成功       |使用CLI/API查询虚拟机成功        |      |
|启动虚拟机|验证可信虚机通过CLI/API启动成功       |使用CLI/API启动虚拟机成功        |      |
|停止虚拟机|验证可信虚机通过CLI/API停止成功       |使用CLI/API停止虚拟机成功        |      |
|删除虚拟机|验证可信虚机通过CLI/API删除成功       |使用CLI/API删除虚拟机成功        |      |
|迁移虚拟机|验证可信虚机通过CLI/API迁移成功       |使用CLI/API迁移虚拟机成功        |      |
|日志管理  |验证可信虚机生命周期管理，对CLI/API提供用户设置日志功能   |日志打印具体的创建、删除、启动、停止迁移的操作信息，支持落盘        |      |

## 场景测试
<!-- 主要描述对特性使用的主要场景的测试策略及测试思路 -->
同接口/功能测试

## 专项测试
<!-- 主要描述其他专项测试,如安全测试 可靠性、韧性测试 性能测试 兼容性测试等 -->
| 专项测试类型 | 专项测试描述 | 测试预期结果 | 备注 |
| ----------- | ----------- | ----------- | ---- |
|可靠性测试    |验证多线程创建/迁移虚拟机    |多线程创建/迁移虚机成功             |      |
|可靠性测试    |验证迁移时两个主机之间通信/端口异常    |迁移失败            |      |
|可靠性测试    |验证迁移时密码资源和虚机状态不一致     |迁移失败
|安全测试      |安全编译选项   |二进制安全编译选项满足要求             |      |
|安全测试      |日志/配置文件   |日志/配置文件权限满足要求            |      |
|安全测试      |端口   |新增端口需要增加通信矩阵文件           |      |


# 特性测试执行策略

## 特性测试依赖描述
<!-- 主要描述特性测试所依赖的执行环境、软件包、环境变量等依赖 -->
1. 操作系统：openEuler 24.03 LTS SP1 或 openEuler 24.03 LTS SP2
2. 依赖：libvirt、gRPC 相关库
3. 配套 Libvirt 9.10.0

## 特性测试约束
<!-- 主要描述特性测试的约束条件 -->
1. Host端交付件最大支持32个虚机

## 特性测试环境描述
<!-- 主要描述执行测试的硬件信息 -->
| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|kunpeng 920B          | NA             |物理机      |

## 测试计划
<!-- 测试执行策略主要描述该轮次执行的分层策略中的测试项 -->
| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
|Test round 1   |2025/10/29  |2025/11/5   |   5  |需求验证                               |        |
|Test round 2   |2025/11/13  |2025/11/18  |   4  |需求验证                               |        |
|Test round 3   |2025/11/26  |2025/12/12  |   17 |全量SIT验证(安全专项、可靠性专项、资料专项)        |        |

## 入口标准
<!--> 描述整个测试执行阶段的入口条件，包括前个阶段的检查、用例执行、问题修复等情况
例如:
1. 功能开发已完成
2. 上阶段无block问题遗留
3. 基础功能验证正常
<-->
1.测试环境物料到位并搭建好测试环境
2.完成测试特性方案和用例输出，测试前通过TSE评审通过，并导入CIDA
3.遗留严重问题单必须给出影响分析
4.迭代规划需求100%实现，如果有AR需要遗留，转测会议上进行风险影响评估

## 出口标准
<!--> 本节描述整个测试执行阶段的出口 
1. 策略规划的测试活动涉及测试用例100%执行完毕
2. 性能基线、功能基线等满足特性规划目标
3. 无block问题遗留，其它严重问题要有相应规避措施或说明
<-->
1.迭代测试用例100%执行
2. 无阻塞性问题遗留，所有遗留问题必须要给出影响分析
3.版本转测回归的问题单100%执行
4.随特性转测的产品包资料已全部验证通过

# 附件
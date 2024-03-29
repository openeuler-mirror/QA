![avatar](../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2023.09.12 | 1.0.0    | 初次创建 | 何江洋 |
|      |             |          |      |



**介绍**

[CPDS](https://gitee.com/openeuler/Cpds) (Container Problem Detect System) 容器故障检测系统，是由[北京凝思软件股份有限公司](https://gitee.com/link?target=https%3A%2F%2Fwww.linx-info.com)设计并开发的容器集群故障检测系统，该软件系统实现了对容器TOP故障、亚健康检测的监测与识别。


**缩略语清单**：

| 缩略语 | 英文全名                        | 中文解释         |
| ------ | ------------------------------- | ---------------- |
| CPDS   | Container Problem Detect System | 容器故障检测系统 |


# 特性描述
**1. 采集集群信息**

在宿主机上实现节点代理，采用systemd、initv、ebpf等技术，对容器关键服务进行监控；对节点网络、内核、磁盘LVM等相关信息进行采集；对容器内的应用状态、资源消耗情况、关键系统函数执行情况、io执行状态等执行异常进行监控。

**2. 集群异常检测**

采集各节点原始数据，基于异常规则对采集的原始数据进行异常检测，提取关键信息。同时基于异常规则对采集数据进行异常检测，后将检测结果数据和原始据进行在线上传，并同步进行持久化操作。

**3. 节点、业务容器故障/亚健康诊断**

基于异常检测数据，对节点、业务容器进行故障/亚健康诊断，将分析检测结果进行持久化存储，并提供UI层进行实时、历史的诊断数据查看

## 需求清单
|no|feature|status|sig|owner|发布方式|
|:----|:---|:---|:--|:----|:----|
|pr-I6F7F6|容器故障/亚健康监测系统后端及采集器|Testing|sig/sig-CloudNative|<a href="https://gitee.com/pencc">@彭驿翔</a>||
| pr-I6ESLK | 容器服务是否正常 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> |     |
| pr-I6EY90 | 容器节点代理是否正常 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> |     |
| pr-I6ETAA | 容器组是否正常 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ETCF | 节点健康检测是否正常 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ETGY | 日志采集是否正常 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ETCF-1 | 磁盘用量占容量85% | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6EYAV | 网络故障 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6EYX9 | 内核Crash故障 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ETMQ | 残留LVM盘故障 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ETCF-2 | CPU使用率超过85% | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ETCF-3 | 节点监控是否正常 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ETNC | 容器内存申请失败 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ETNV | 容器内存申请超时 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6EYAV-1 | 容器网络响应超时 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ETCF-4 | 容器磁盘读写缓慢 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6EW1C | 容器应用僵尸子进程监测 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6EY4P | 容器应用子进程、线程创建失败监测 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ES54 | 支持查询（或检索）节点的原始监控数据 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6ERWJ | 支持健康检查 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6E9T9 | 节点故障/亚健康规则管理 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |
| pr-I6E9ER | 支持集群、节点监控 | Testing | sig/sig-CloudNative | <a href="https://gitee.com/pencc">@彭驿翔</a> | |

## 风险项
这里可以呈现已识别的影响版本交付的风险，根据版本需求调查、技术分析和物料状况进行汇总，识别出当前版本风险&障碍列举如下：

| 问题类型 | 问题描述 | 问题等级 | 应对措施 | 责任人 | 状态 |
| -------- | -------- | -------- | -------- | ------ | ---- |
| 暂无     |          |          |          |        |      |

# 测试分层策略
## 总体测试策略
容器故障检测系统总体测试策略主要从以下三个方面进行：

- **集群基础服务异常**。利用systemd、initv等技术对相关关键服务进行启动、停止、监控与策略执行。
- **集群OS异常**。在宿主机上实现节点消耗，对节点CPU、内存、磁盘、网络、系统调用、磁盘LVM等相关信息进行策略执行。
- **业务服务异常**。采用业务无侵入的方式在节点、容器内进行操作，针对容器内的应用、资源消耗等进行全方位的监控、分析与异常检测。



## 功能场景测试
| 场景描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| 容器服务是否正常 | 重启容器服务或杀容器服务进程 | 是否检测到容器服务异常 |      |
| 容器节点代理是否正常 | 杀容器节点代理服务进程 | 是否检测到容器节点代理服务异常 |      |
| 容器组是否正常 | 构造异常pod | 是否检测到容器组异常 | |
| 节点健康检测是否正常 | 模拟节点CPU、内存、磁盘、网络消耗 | 是否检测到节点资源异常以及节点资源监控是否正常 | |
| 日志采集是否正常 | 重启系统日志采集服务 | 是否检测到系统日志采集服务异常 | |
| 磁盘用量占容量85% | 模拟节点磁盘空间消耗 | 是否检测到节点磁盘空间占用 | |
| 网络故障 | 模拟节点网卡异常、网络丢包等 | 是否检测到节点网络故障 | |
| 内核Crash故障 | 模拟节点内核故障 | 是否检测到节点内核故障 | |
| 残留LVM盘故障 | 构造残留LVM盘 | 是否检测到节点残留LVM盘 | |
| CPU使用率超过85% | 模拟节点CPU消耗超过85% | 是否检测到节点CPU高负载 | |
| 节点监控是否正常 | 重启节点或节点监控服务 | 是否检测到节点监控异常 | |
| 容器内存申请失败 | 构造容器进程申请内存失败 | 是否检测到容器进程申请内存失败 | |
| 容器内存申请超时 | 构造容器进程申请内存超时 | 是否检测到容器进程申请内存超时 | |
| 容器网络响应超时 | 构造容器网络丢包、延迟场景 | 是否检测到容器网络丢包、高延迟 | |
| 容器磁盘读写缓慢 | 构造容器磁盘读写缓慢场景 | 是否检测到容器进程磁盘读写缓慢 | |
| 容器应用僵尸子进程监测 | 构造容器子进程成为僵尸进程场景 | 是否检测到容器僵尸子进程 | |
| 容器应用占用子进程、线程创建失败监测 | 构造容器子进程、子线程创建失败场景 | 是否检测到容器子进程、子线程创建失败 | |

## 专项测试策略

### 易用性测试

| 场景描述                 | 设计思路       | 测试重点                                                | 备注 |
| ------------------------ | -------------- | ------------------------------------------------------- | ---- |
| 查看概览页面显示是否正常 | UI界面功能使用 | 页面是否显示集群、节点、容器以及诊断结果信息            |      |
| 查看节点物理资源状态     | UI界面功能使用 | 页面是否显示集群节点所使用的CPU、内存、网络、磁盘等资源 |      |
| 查看集群容器健康监控     | UI界面功能使用 | 页面是否显示集群容器所使用资源与集群资源占比            |      |
| 查看亚健康/故障诊断结果  | UI界面功能使用 | 页面是否显示容器、节点出现亚健康/故障结果               |      |
| 原始数据检索             | UI界面功能使用 | 页面是否支持原始数据实时检索以及历史数据                |      |
| 规则管理                 | UI界面功能使用 | 页面是否支持规则添加、编辑、删除等操作                  |      |



###  性能测试

| 场景描述                                  | 设计思路                                   | 测试重点                                  | 备注 |
| ----------------------------------------- | ------------------------------------------ | ----------------------------------------- | ---- |
| 支持100个节点监控                         | 构造100个监控节点                          | 能否监控到100个节点资源使用信息           |      |
| 支持2000个容器监控                        | 构造2000个容器                             | 能否监控到2000个容器资源使用信息          |      |
| 100个节点情况下，管理节点资源消耗         | 构造100个监控节点                          | 管理节点的资源使用在合理范围              |      |
| 100个节点情况下，每个节点均出现容器故障   | 每个节点构造一个容器故障，如僵尸子进程     | 能完整检测到100个容器故障（如僵尸子进程） |      |
| 100个节点情况下，单个节点出现10个容器故障 | 选择一个节点构造10个容器故障，如僵尸子进程 | 能完整检测到10个容器故障（如僵尸子进程）  |      |

### 安全测试

| 场景描述 | 设计思路 | 测试重点 | 备注 |
| -------- | -------- | -------- | ---- |
| 暂无     |          |          |      |

### 可靠性测试

| 场景描述                      | 设计思路          | 测试重点         | 备注 |
| ----------------------------- | ----------------- | ---------------- | ---- |
| 100个节点情况下，运行3*24小时 | 构造100个监控节点 | 能稳定运行72小时 |      |

### 兼容性测试

| 场景描述                  | 设计思路                                | 测试重点     |
| ------------------------- | --------------------------------------- | ------------ |
| 支持不同版本openEuler系统 | 在不同版本openEuler系统环境中安装、使用 | 功能是否正常 |
| 支持不同的应用场景        | 在虚拟机、本地环境等安装、使用          | 功能是否正常 |

# 测试执行策略

## 测试计划
| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
| 测试阶段1 | 2023.07.18 | 2023.07.24 | 5 | 1.测试用例验证 |        |
| 测试阶段2 | 2023.08.02 | 2023.08.04 | 3 | 1.测试用例验证 2.测试问题回归验证 |        |
| 测试阶段3 | 2023.08.24 | 2023.08.28 | 3 | 1.测试用例验证 2.测试问题回归验证 |        |
| 测试阶段4 | 2023.09.01 | 2023.09.04 | 3 | 1.测试用例验证 2.测试问题回归验证 | |
| 测试阶段5 | 2023.09.08 | 2023.09.11 | 2 | 1.测试用例验证 2.测试问题回归验证 | |
| 测试阶段6 | 2023.09.21 | 2023.09.22 | 2 | 1.测试用例验证 | |

## 入口标准
1. 业务功能开发已完成
2. 上阶段无block问题遗留
3. 基础功能验证正常


## 出口标准
1. 策略规划的测试活动涉及测试用例100%执行完毕
2. 功能基线等满足特性规划目标
3. 版本无严重问题遗留，其它严重问题要有相应规避措施或说明


# 附件

*附件为本测试策略的补充部分*
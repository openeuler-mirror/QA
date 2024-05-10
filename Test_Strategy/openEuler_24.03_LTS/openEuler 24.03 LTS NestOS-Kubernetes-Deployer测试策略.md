![openEuler ico](../../images/openEuler.png)

版权所有 © 2023 openEuler 社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative
Commons)署名—相同方式共享 4.0 国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>
了解 CC BY-SA 4.0 的概要 (但不是替代)。CC BY-SA
4.0 的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期       | 修订版本 | 修改 章节                            | 修改描述 | 作者 |
| ---------- | -------- | ---------------------------------- | -------- | ---- |
| 2024-05-10 | 1.0      | NestOS-Kubernetes-Deployer 测试策略 | 初稿     | @jianli-97 |

关键词 ：NestOS-Kubernetes-Deployer NKD 测试策略

摘要：本文是 NestOS-Kubernetes-Deployer 24.03 LTS 版本的整体测试策略，用于指导该版本后续测试的展开。

缩略语清单：

| 缩略语 | 英文全名                    |
| -----  | -------------------------- |
| NKD    | NestOS-Kubernetes-Deployer |

# <br>概述
NKD（NestOS Kubernetes Deployer）是专为在 NestOS 上部署和维护 Kubernetes 集群而打造的解决方案。其旨在通过在集群外提供一系列服务，涵盖了基础设施和 Kubernetes 核心组件的部署、更新和配置管理等，从而简化了集群部署和升级的流程。NKD 的设计目标在于提供更为便捷的集群操作体验，使得用户能够轻松完成复杂的管理任务，从而提高整体部署和维护的效率。

## 需求清单
|no|feature|status|sig|owner|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|
| [I8U9QZ](https://gitee.com/openeuler/nestos-kubernetes-deployer/issues/I8U9QZ) | openstack平台部署集群不支持使用外部证书 | Developed | sig-K8sDistro | @lauk001 | nkd |
| [I8V91R](https://gitee.com/openeuler/nestos-kubernetes-deployer/issues/I8V91R) | NKD-0.2.0：集群启动后日志error显示"tls: private key does not match public key" | Developed | sig-K8sDistro | @duyiwei7w | nkd |
| [I8V9RE](https://gitee.com/openeuler/nestos-kubernetes-deployer/issues/I8V9RE) | NKD-0.2.0：rpc error：invalid IP address 10.96.0.1 | Developed | sig-K8sDistro | @duyiwei7w | nkd |
| [I8VL1E](https://gitee.com/openeuler/nestos-kubernetes-deployer/issues/I8VL1E) | 内部ign持久化字段不应该被传入参数影响 | Developed | sig-K8sDistro | @lauk001 | nkd |
| [I8VPSK](https://gitee.com/openeuler/nestos-kubernetes-deployer/issues/I8VPSK) | 重复部署同样cluster id集群未做拦截 | Developed | sig-K8sDistro | @lauk001 | nkd |
| [I8XGXL](https://gitee.com/openeuler/nestos-kubernetes-deployer/issues/I8XGXL) | worker节点hostname未正确配置 | Developed | sig-K8sDistro | @lauk001 | nkd |
| [I94ET0](https://gitee.com/openeuler/release-management/issues/I94ET0) | 发布NestOS-Kubernetes-Deployer | Developed | sig-K8sDistro | @duyiwei7w | nkd |

## 风险项
<!-- 主要描述特性已知风险项 -->
- 网络正常，可下载 Kubernetes 相关容器镜像

# 特性分层策略
## 总体测试策略
<!-- 主要描述特性的整体测试策略，主要开展哪些测试(接口/功能/场景/专项) -->
- 测试目标：NKD 功能正常，可正常部署、扩展、销毁、升级 NestOS实例 以及 Kubernetes 集群
- 时间进度：待评估
- 风险评估：NA
- 重点事项：NKD 功能
- 争议事项：NA

## 特性测试约束
<!-- 主要描述特性测试的约束条件 -->
NA

## 功能测试
<!-- 主要描述特性提供的功能的测试策略及测试思路 -->
| 功能描述            | 设计思路                          |
| ------------------- | ---------------------------------|
| 部署 NestOS 实例     | 部署 NestOS 实例，查看执行结果     |
| 扩展 NestOS 实例     | 扩展 NestOS 实例，查看执行结果     |
| 销毁 NestOS 实例     | 销毁 NestOS 实例，查看执行结果     |
| 升级 NestOS 实例     | 升级 NestOS 实例，查看执行结果     |
| 部署 Kubernetes 集群 | 部署 Kubernetes 集群，查看执行结果 |
| 扩展 Kubernetes 集群 | 扩展 Kubernetes 集群，查看执行结果 |
| 销毁 Kubernetes 集群 | 销毁 Kubernetes 集群，查看执行结果 |
| 升级 Kubernetes 集群 | 升级 Kubernetes 集群，查看执行结果 |

## 场景测试
<!-- 主要描述对特性使用的主要场景的测试策略及测试思路 -->
| 场景描述       | 设计思路                                                  |
| ------------- | --------------------------------------------------------- |
| Libvirt 平台   | 可正常部署、扩展、销毁、升级 NestOS 实例以及 Kubernetes 集群 |
| OpenStack 平台 | 可正常部署、扩展、销毁、升级 NestOS 实例以及 Kubernetes 集群 |

# 特性测试环境描述
<!-- 主要描述执行测试的硬件信息 -->
| 硬件型号          |
| -----------------|
| Phytium S2500    |
| Kunpeng 920      |
| Intel/AMD x86_64 |

单一实例的硬件规格：建议 4C CPU、8G RAM、50G Disk，最少 2C CPU、4G RAM、20G Disk。

# 特性测试执行策略

## 测试计划
NKD 24.03 LTS 版本需等待 NestOS 24.03 LTS 版本发布后再进行测试。

# 入口标准  
1.特性满足质量标准，达成需求设计要求目标

# 出口标准  
1.策略规划的测试活动涉及测试用例100%执行完毕  
2.版本无严重问题遗留，其他问题有规避措施

# 附件

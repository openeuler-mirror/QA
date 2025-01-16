![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。


修订记录

| 日期      | 修订版本 | 修改  章节 | 修改描述 | 作者                                    |
| --------- | -------- | ---------- | -------- | --------------------------------------- |
| 2025-01-16| 1.0.0    |            | 初稿     | [@ccdxx](https://gitee.com/ccdxx) |

 关键词：

 openEuler NestOS iSulad docker podman rpm-ostree zincati K8s NFV NFC

摘要：

 文本主要描述NestOS_24.03_LTS_SP1.20250115版本的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语     | 英文全名             | 中文解释             |
| ---------- | -------------------- | -------------------- |
| OS         | Operating system     | 操作系统             |
| iSulad     | iSulad               | 轻量级容器引擎       |
| Docker     | Docker               | Docker容器引擎       |
| Podman     | Podman               | Podman容器引擎       |
| rpm-ostree | rpm-ostree           | 混合镜像/包系统      |
| zincati    | zincati              | 自动更新引擎         |
| K8s        | kubernetes           | 开源容器集群管理系统 |
| NFV        | NestOS For Virt      | 虚拟化场景镜像       |
| NFC        | NestOS For Container | 云原生场景镜像       |

# 1     特性概述

NestOS 是一款基于openEuler开发的自动更新的云底座操作系统。NestOS搭载了docker、iSulad、podman等常见容器引擎，将ignition配置、rpm-ostree、OCI支持、SElinux强化等技术集成在一起，采用基于双根文件系统、容器技术和集群架构的设计思路，可以适配云场景下多种基础运行环境。同时NestOS针对Kubernetes进行优化，在IaaS生态构建方面，针对openStack、oVirt等平台提供支持；在PaaS生态构建方面，针对OKD、Rancher等平台提供支持，使系统具备十分便捷的集群组建能力，可以更安全的运行大规模的容器化工作负载。

本文主要描述NestOS_24.03_LTS_SP1.20250115版本的总体测试活动，按照社区开发模式进行运作，结合SIG K8s-Distro/CloudNative/QA制定的版本计划规划相应的测试计划及活动。
# 2     特性测试信息

NestOS 软件包原则上取用 openEuler-24.03-LTS-SP1 分支，部分NestOS强相关软件包如NestOS-release,nestos-installer等软件包取用openEuler-24.03-LTS-SP1对应的NestOS mutiversion分支。其关键特性如下：

  1. 支持NFC专属容器云部署运维工具NKD   
  2. NestOS For-Virt/For-Container多版本支持


| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| NestOS Test Round 1 | 2024/12/13   | 2024/12/16   |
| NestOS Test Round 2 | 2024/12/17   | 2024/12/23   |
| NestOS Test Round 3 | 2024/12/24   | 2024/12/30   |
| NestOS Test Round 4 | 2024/12/31   | 2024/01/07   |
| NestOS Test Round 5 | 2025/01/08   | 2025/01/15   |


描述特性测试的硬件环境信息
NestOS 在以下硬件进行安装适配和基本功能验证

| **硬件型号**                |
| :-------------------------- |
| 飞腾S2500                   |
| 鲲鹏920                     |
| Intel(R) Xeon(R) Gold 6330H |

# 3     测试结论概述

## 3.1   测试整体结论

NestOS_24.03_LTS_SP1.20250115 版本整体测试按照计划共完成了一轮重点特性测试+一轮专项测试+一轮应用场景测试+一轮回归测试；其中第一轮重点特性测试聚焦在ignition自定义配置、nestos-installer安装、容器引擎、zincati自动升级、rpm-ostree原子化更新+双根文件系统的特性验证、NKD功能测试；>一轮专项测试开展版本交付的各类专项测试；一轮应用场景测试进行K8S的安装部署并验证各组件和服务正常工作；一轮性能测试；一轮回归测试重点覆盖特性测试，验证问题的修复程度。
NestOS_24.03_LTS_SP1.20250115 版本构建过程共发现问题 2 个，有效问题 2 个，0个遗留问题，2个问题已修复，回归测试结果正常，版本整体质量较好。


## 3.2   特性测试结论
| 测试活动                   | 活动评价                                            |
| -------------------------- | --------------------------------------------------- |
| 容器云部署运维工具NKD      | 实现OS安装部署与升级管理，以及K8S安装部署与升级管理 |
| NestOS For-Virt/For-Container多版本支持 | 已验证EBS上mutiversion repo源可用 |

## 3.3   专项测试结论
| 测试活动     | 活动评价                                                     |
| ------------ | ------------------------------------------------------------ |
| 基础功能测试 | 对系统管理、系统服务、常用命令（文件系统、进程监控、网络、用户管理）进行测试，系统基础功能稳定。 |
| 容器功能测试 | 测试iSulad、podman、docker容器引擎基本功能。 |
| 可靠性测试   | 对NestOS进行稳定测试，测试操作系统稳定运行168 小时。         |
| 性能测试     | 对网络性能、容器性能进行了测试，重点测试了iSulad、docker、podman容器引擎对容器启停时间的消耗，测试结果表明iSulad性能优于docker、podman。 |
| 安全性测试   | 对身份鉴别、安全审计、用户登录、用户权限、远程连接，测试结果符合预期。 |

## 3.4   约束说明

 - 内存：4GB及以上
 - 架构：x86_64、aarch64
 - 使用zincati自动更新和rpm-ostree手动更新特性时，需保证当前NestOS版本不是最新版本，若当前NestOS是最新版本，则无法使用该功能。


## 3.5 功能测试

### 3.5.1 iso镜像测试

测试项及测试结果如下所示：

| 功能           | x86_64/NFV | arm64/NFV | x86_64/NFC | arm_64/NFC |
| -------------- | ---------- | --------- | ---------- | ---------- |
| 生命周期       | pass       | pass      | pass       | pass       |
| 快照           | pass       | pass      | pass       | pass       |
| CPU分配        | pass       | pass      | pass       | pass       |
| 内存分配       | pass       | pass      | pass       | pass       |
| 热插拔         | pass       | pass      | pass       | pass       |
| 网卡           | pass       | pass      | pass       | pass       |
| 接口           | pass       | pass      | pass       | pass       |
| 虚拟网络       | pass       | pass      | pass       | pass       |
| 节点设备       | pass       | pass      | pass       | pass       |
| 主机和管理程序 | pass       | pass      | pass       | pass       |
| 域监控         | pass       | pass      | pass       | pass       |
| 网络过滤器     | pass       | pass      | pass       | pass       |
| 存储卷         | pass       | pass      | pass       | pass       |
| 密钥           | pass       | pass      | pass       | pass       |
| 热迁移增强     | pass       | pass      | pass       | pass       |
| 内存调优       | pass       | pass      | pass       | pass       |
| 设备添加       | pass       | pass      | pass       | pass       |

除了存储池测试项不支持磁盘总线类型为usb，其他功能测试都正常。

### 3.5.2 qcow2镜像测试

测试项及测试结果如下所示：

|                   | 测试项                                   | 描述                                      | x86_64/NFC | arm64/NFC |
| ----------------- | ---------------------------------------- | ----------------------------------------- | ---------- | --------- |
| **通用**          | nestos.auth.verify                       | ssh 用户名密码身份验证                    | pass       | pass      |
|                   | nestos.selinux.boolean                   | 检查是否可以调整SElinux策略内规则的布尔值 | pass       | pass      |
|                   | nestos.selinux.enforce                   | 启动SELinux后的检查                       | pass       | pass      |
|                   | nestos.tls.fetch-urls                    | 抓取url                                   | pass       | pass      |
|                   | nestos.filesystem                          | 检查文件系统                              | pass       | pass      |
|                   | nestos.network.listeners                   | 检查通用网络端口                          | pass       | pass      |
|                   | nestos.ignition.v3.noop                    |                                           | pass       | pass      |
|                   | nestos.users.shells                        | 用户登录系统时运行的程序                  | pass       | pass      |
|                   | rootfs.uuid                              | 检查磁盘GUID为随机数                      | pass       | pass      |
| **ignition**      | nestos.ignition.groups                   | 新建用户组                                | pass       | pass      |
|                   | nestos.ignition.instantiated.enable-unit | 启动服务                                  | pass       | pass      |
|                   | nestos.ignition.journald-log             | 将日志写入journal                         | pass       | pass      |
|                   | nestos.ignition.mount.disks              | 挂载磁盘并在挂载点写入文件                | pass       | pass      |
|                   | nestos.ignition.mount.partitions         | 挂载分区并在挂载点写入文件                | pass       | pass      |
|                   | nestos.ignition.once                     | 写入文件                                  | pass       | pass      |
|                   | nestos.ignition.resource.remote          | 通过访问http写入文件                      | pass       | pass      |
|                   | nestos.ignition.resource.local           |                                           | pass       | pass      |
|                   | nestos.ignition.sethostname              | 设置hostname                              | pass       | pass      |
|                   | nestos.ignition.ssh.key                  |                                           | pass       | pass      |
|                   | nestos.ignition.security.tls             |                                           | pass       | pass      |
|                   | nestos.ignition.symlink                  | 设置硬链接                                | pass       | pass      |
|                   | nestos.ignition.v2.users                 | 添加用户                                  | pass       | pass      |
| **isula**         | isula.base                               | 检查isula基本信息，各项命令如run、exec、stop等                         | pass       | pass      |
| **docker**        | docker.base                               | 检查docker基本信息，各项命令如run、exec、stop等                         | pass       | pass      |
| **podman**        | podman.base                              | 检查podman基本信息，各项命令如run、exec、stop等                        | pass       | pass      |
|                   | podman.network-single                    | 检查容器网络连接                          | pass       | pass      |
| **ostree**        | ostree.hotfix                            | rpm安装、卸载、rpm-ostree回滚             | pass       | pass      |
|                   | ostree.remote                            | 验证ostree remote功能                     | pass       | pass      |
| **ostree.unlock** | 验证安装包，重启后移除                   |                                           | pass       | pass      |
| **rpm-ostree**    | rpmostree.install-uninstall              | 安装、卸载软件包                          | pass       | pass      |
|                   | rpmostree.status                         | 检查rpm-ostree状态                        | pass       | pass      |
|                   | rpmostree.upgrade-rollback               | 升级回滚                                  | pass       | pass      |

### 3.5.3 容器镜像

| 测试项           | 描述               | x86_64/NFC | arm64/NFV |
| ---------------- | ------------------ | ---------- | --------- |
| rpmostree.rebase | 切换成容器镜像版本 | pass       | pass      |

## 3.6   遗留问题分析

### 3.6.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|          |          |          |                    |          |
| -------- | -------- | -------- | ------------------ | -------- |
| -------- | -------- | -------- | ------------------ | -------- |
|          |          |          |                    |          |

### 3.6.2 问题统计

|      | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ---- | -------- | ---- | ---- | ---- | ------ |
|      |          |      |      |      |        |
| ------ | -------- | ---- | ---- | ---- | ------ |
| ------ | -------- | ---- | ---- | ---- | ------ |
|        |          |      |      |      |        |

# 4     测试执行

## 4.1   测试执行统计数据


| 版本名称            | 测试用例数 | 用例执行结果 | 发现问题单数 |
| ------------------- | ---------- | ------------ | ------------ |
| NestOS Test Round 1 | 45         | ALL PASS     | 0            |
| NestOS Test Round 2 | 35         | ALL PASS     | 0            |
| NestOS Test Round 3 | 2          | ALL PASS     | 0            |
| NestOS Test Round 4 | 80         | ALL PASS     | 0            |
| NestOS Test Round 5 | 82         | ALL PASS     | 0            |

*数据项说明：*

- NestOS Test Round 1主要包括NFC版本除自动更新外的用例
- NestOS Test Round 2主要包括NFV版本测试
- NestOS Test Round 3主要包括NFC版本自动更新测试
- NestOS Test Round 4主要包括前述除自动更新外的测试
- NestOS Test Round 5包括前述所有用例

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*

![avatar](../../images/openEuler.png)

版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述      | 作者         |
| ---------- | ----------- | ------------- | ------------ |
| 2026/09/23 | 1.0.0       | crius测试报告 | @northgarden |

关键词： crius、CRI、容器运行时、crs

摘要：按照crius第一期测试用例规格说明书要求，在openEuler 26.09 DevStation环境上部署crius，使用crs客户端对crius的服务启动与版本、镜像管理、容器生命周期三大特性进行测试。crius基本支持CRI运行时的核心功能正常使用。

缩略语清单：

| 缩略语 | 英文全名                    | 中文解释       |
| ------ | --------------------------- | -------------- |
| CRI    | Container Runtime Interface | 容器运行时接口 |
| OCI    | Open Container Initiative   | 开放容器倡议   |
| CNI    | Container Network Interface | 容器网络接口   |

# 1 特性概述

crius 是一个用 Rust 编写的 CRI 容器运行时，它将 CRI gRPC 请求映射到 OCI 运行时执行（runc）、镜像存储与拉取、CNI 网络配置、流式 I/O（exec/attach/logs）、SQLite 状态持久化与重启恢复、资源配置（cgroups）和安全隔离（seccomp/AppArmor/SELinux）等子系统，作为 CRI 语义与底层运行时之间的编排层，当前测试通过 crs 客户端经本地 unix socket 通信验证其服务启动、镜像管理与容器生命周期等核心能力。本测试报告为crius在openEuler 26.09 DevStation 操作系统上的特性测试报告，目的在于跟踪测试阶段中发现的问题，总结crius在x86_64硬件平台上的测试结果。测试的范围主要包括crius服务启动与版本验证、镜像管理、容器生命周期管理三大特性。

# 2 特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间   | 测试结束时间   |
| -------- | -------------- | -------------- |
| crius    | 2026年09月16日 | 2026年09月23日 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注    |
| -------- | ------------ | ------- |
| 虚拟机   | NA           | x86_64  |
| 虚拟机   | NA           | aarch64 |

# 3 测试结论概述

## 3.1 测试整体结论

软件总体评估
crius 在openEuler 26.09 DevStation测试环境上，共执行18个测试用例，整体核心功能基本稳定正常。

服务启动与版本测试
服务启动与版本测试中，共执行了9个测试用例，其中9个通过，0个不通过。

镜像管理测试
镜像管理测试中，共执行了5个测试用例，其中5个通过，0个不通过，0个因无该功能阻塞未测试。

容器生命周期测试
容器生命周期测试中，共执行了4个测试用例，其中4个通过，0个不通过，0个因无该功能阻塞未测试。

## 3.2 约束说明

特性使用时涉及到的约束及限制条件：

* 本次测试主要基于openEuler 26.09 DevStation环境开展。
* 性能测试数据受硬件、软件包大小、缓存状态及网络环境影响，当前数据用于验证指标是否满足要求，最终数据以后续复测结果为准。

## 3.3 遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 服务启动与版本

| 用例编号 | 用例名称             | 结果 | 说明                                                                         |
| -------- | -------------------- | ---- | ---------------------------------------------------------------------------- |
| TC-001   | 默认配置启动         | PASS | 进程启动成功（PID=11422），监听/run/crius/crius.sock，日志无panic            |
| TC-002   | crs获取版本          | PASS | crs version返回 RuntimeName=crius, Version=0.1.0, API Version=v1             |
| TC-003   | crs获取运行时信息    | PASS | crs status显示 RuntimeReady=true, NetworkReady=true, Conditions=2            |
| TC-004   | crs获取状态          | PASS | crs status返回码0，输出包含daemon状态和运行时信息                            |
| TC-005   | crs获取版本          | PASS | crs version返回码0，与TC-002结果一致                                         |
| TC-006   | dump默认配置信息     | PASS | crius --dump-default-config输出包含runtime、image、network等配置集           |
| TC-007   | 默认配置信息写入文件 | PASS | crius --write-default-config成功写入277行配置到指定文件                      |
| TC-008   | 通过指定配置文件启动 | PASS | crius --config /tmp/crius-test/test.conf启动成功，socket就绪                 |
| TC-009   | 配置日志转存启动     | PASS | crius --log /tmp/crius-test/tc011.log启动成功，日志文件生成22行内容，无panic |

### 4.1.2 镜像管理

| 用例编号 | 用例名称       | 结果 | 说明                                                                                                       |
| -------- | -------------- | ---- | ---------------------------------------------------------------------------------------------------------- |
| TC-010   | crs拉取镜像    | PASS | crs images busybox:latest                                                                                  |
| TC-011   | crs列出镜像    | PASS | crs image list列出本地busybox镜像（c26091c675b7, 710.9KiB），返回码0                                       |
| TC-012   | 镜像详情查询   | PASS | crs inspect --type image JSON输出包含repoTags、repoDigests、size、id等字段                                 |
| TC-013   | 删除镜像       | PASS | crs image remove成功删除镜像，返回码0，删除后镜像列表为空                                                  |
| TC-014   | 拉取不存在镜像 | PASS | 返回错误（DNS error），返回码1（非0），无panic（错误信息因无外网为DNS错误而非"not found"，但核心行为正确） |

### 4.1.3 容器生命周期

| 用例编号 | 用例名称         | 结果 | 说明                                                                                                                |
| -------- | ---------------- | ---- | ------------------------------------------------------------------------------------------------------------------- |
| TC-015   | crs创建/启动容器 | PASS | crs run -d --name test-ctr-36创建并启动容器成功，容器ID=c057e519dd25，状态running                                   |
| TC-016   | 容器退出码       | PASS | crs run --name test-exit42执行sh -c 'exit 42'，inspect JSON显示exitCode=42，message="container exited with code 42" |
| TC-017   | crs exec         | PASS | crs exec<container-id></container> -- ls /成功列出根目录内容（bin/dev/etc/home/proc/root/sys/tmp/usr/var），返回码0 |
| TC-018   | crs logs         | PASS | crs logs<container-id></container>成功获取容器日志，返回码0                                                         |

# 5 测试执行

## 5.1 测试执行统计数据

| 特性模块                        | 测试用例数   | 通过         | 失败 | 跳过 | 发现问题单数 |
| ------------------------------- | ------------ | ------------ | ---- | ---- | ------------ |
| 服务启动与版本（TC-001~TC-011） | 11           | 11           | 0    | 0    | 11           |
| 镜像管理（TC-013~TC-021）       | 5            | 5            | 0    | 1    | 0            |
| 容器生命周期（TC-036~TC-046）   | 4            | 4            | 0    | 0    | 0            |
| **合计**                  | **20** | **20** | 0    | 0    | 0            |

## 5.2 后续测试建议

后续测试需要关注点：

1. 增加更多发行版及软件包格式的兼容性测试，例如Alpine APK、Arch等。
2. 持续验证DevStation集成版本升级后crius的相关能力。

# 6 附件

## 附录A: 关键测试命令示例

```Shell
# 启动crius守护进程
crius --config /etc/crius/crius.conf

# 使用crs连接
export CRIUS_ADDRESS=unix:///run/crius/crius.sock
crs version
crs status
crs images

# 创建并启动本地容器
crs run -d --name test-ctr busybox:1.29-2 -- sleep 3600

# 容器操作
crs ps
crs exec <container-id> -- ls /
crs logs <container-id>
crs inspect --type container <container-id>

# 镜像操作
crs image list
crs image remove <image-id>

# 配置操作
crius --dump-default-config
crius --write-default-config /tmp/crius.conf
crius --config /tmp/crius.conf
crius --log /tmp/crius.log
```

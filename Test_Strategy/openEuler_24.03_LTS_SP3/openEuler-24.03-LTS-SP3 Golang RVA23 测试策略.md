![avatar](../images/openEuler.png)

版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025.11.07 | 1.0.0 | 初版 | HeliC829 |


关键词： 
Golang 云原生 RISC-V RVA23 Zbb

摘要：
为 openEuler 24.03 LTS SP3 中的 Golang 1.21 版本引入 RVA23 Profile 支持，添加更多高级 RISC-V Profile 中的拓展支持（Zbb、V），进一步优化 Golang 在 RISC-V 下的性能表现。
由于 Golang 是云原生时代的重要编程语言，是云时代软件基础架构的一部分，许多云原生的软件包都与 Golang 依赖非常紧密，因此保证 Backport 后 Golang 软件包本身能够通过所有测试，不出问题，就非常重要。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |


# 特性描述
根据 openEuler release management SIG 的会议结果，26.03 将不会有新的 LTS 版本，而是将继续基于 24.03 发布新的 SP3 版本。而在 24.03 SP3 软件基线版本不变动的情况下，Golang 版本基线将继续停留在 1.21。
为了能够更好的发挥出 RISC-V 上支持 RVA23 Profile 平台的硬件特性，需要将 Golang 1.25 上对 RVA20 RVA22 RVA23 等相关 RISC-V 优化移植 Backport 到 openEuler 24.03 SP3 的 Golang 1.21 上。
由于 Golang 是云原生时代的重要编程语言，是云时代软件基础架构的一部分，许多云原生的软件包都与 Golang 依赖非常紧密，因此保证 Backport 后 Golang 软件包本身能够通过所有测试，不出问题，就非常重要。

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
[ID2QHV](https://gitee.com/openeuler/release-management/issues/ID2QHV?from=project-issue)|golang: Backport RVA23 支持|Testing|sig-golang|@HeliC829|OS|golang|

## 特性应用场景分析

1. 支持生成 RVA22 Profile 中必选 Zbb 拓展的相关指令，以提升部分场景下的性能

2. 支持生成 RVA23 Profile 中必选 V 拓展的相关指令，以提升部分场景下的性能

1. 支持运行时判断 RISC-V CPU 的指令集拓展支持情况，动态启用部分拓展指令支持，以提升部分场景下的性能

## 特性实现流程描述

N/A

## 与其他特性交互描述

N/A

## 风险项

- 可能影响到部分使用 Go 语言编译的程序

# 特性分层策略
## 总体测试策略

N/A

## 接口/功能测试

N/A


## 场景测试

N/A

## 专项测试

N/A


# 特性测试执行策略

## 特性测试依赖描述

1. 需要支持 RISC-V Zbb 拓展的 RISC-V CPU 来执行 rva22u64 级别 Profile 的测试

2. 需要支持 RISC-V Zbb 和 V 拓展的 RISC-V CPU 来执行 rva23u64 级别 Profile 的测试

## 特性测试约束

1. Linux 内核需要大于 6.6 方支持 RISC-V hwprobe 特性（openEuler 已支持）

2. RISC-V CPU 需要支持 Zbb 拓展才可以执行 rva22u64 Profile 级别测试

3. RISC-V CPU 需要支持 V 拓展才可以执行 rva22u64 Profile 级别测试


## 特性测试环境描述
<!-- 主要描述执行测试的硬件信息 -->
| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 算能 SG2042 | 64C 128G | 支持 Zbb、V 拓展，可支持 Golang 中定义的 rva23u64 Profile 级别 |

## 测试计划
| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
| Test round 3-4 | 2025/11/7 | 2025/11/20 | 14 | 全量测试 |
| Test round 5 | 2025/11/21  | 2025/11/27 | 7  | 回归测试 |

## 入口标准

1. 编译时传入环境变量 GORISCV64=rva20u64/rva22u64/rva23u64 可以被支持，且编译通过，不报错

## 出口标准

1. 按照标准 Golang 贡献指南 (https://go.dev/doc/contribute) 当中的测试方法，在 Golang 源码的 src 目录下，执行 all.bash 命令，执行完整的 bootstrap 及测试
2. 执行 all.bash 命令时，传入环境变量 GORISCV64=rva20u64/rva22u64/rva23u64，能够完整执行并通过测试，不报错

# 附件

N/A
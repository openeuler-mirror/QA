![avatar](../images/openEuler.png)

版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025.12.16 | 1.0.0 | 初版 | jonsfy |


关键词： 
java OpenJDK RISC-V RVA23 性能优化

摘要：
为 openEuler 24.03 LTS SP3 中的 OpenJDK 21.0.9 版本 Backport 上游主线版本中已经合并的部分 RVA23 扩展以及关键 intrinsic 优化，进一步优化 OpenJDK 在 RISC-V 下的性能表现。
Java 作为企业级应用和大规模分布式系统的核心编程语言，长期支撑着金融、电信、互联网等关键领域的后端基础设施，因此保证 Backport 后 OpenJDK21 软件包本身能够通过所有测试，不出问题，就非常重要。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |


# 特性描述
openEuler 24.03 LTS SP3 中的 OpenJDK 基线版本为 21.0.9 ，而当前 OpenJDK 的最新版本已经到了 26 系列。与 OpenJDK 最新版本相比，21.0.9 版本缺少许多针对 RISC-V 的扩展支持及性能优化，将上游主线版本中已合并的部分RVA23扩展，密码学汇编优化算法，关键intrinsic优化 Backport 到 21.0.9 中，可以进一步优化 openEuler 24.03 LTS SP3 下 OpenJDK 在 RISC-V 下的性能表现。

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
[IDD4ZW](https://gitee.com/openeuler/release-management/issues/IDD4ZW?from=project-issue)|OpenJDK21：Backport 支持 OpenJDK master 中新增的部分RVA23扩展以及关键优化|Accepted|Compiler SIG|[@jonsfy](https://gitee.com/jonsfy)|OS|openjdk-21|

## 特性应用场景分析

1. 支持生成 RVA23 Profile 中包含的 Zfa、Zacas、Zabha、Zvkn、Zicond 扩展以及对应的hwprobe功能，以提升部分场景下的性能

2. 支持生成部分加解密算法（MD5、SHA1/2、ChaCha20、poly1305、CRC32、adler32、base64）的汇编优化代码 ，以提升网络传输、文件系统等场景下的性能

3. 支持HashCode、CopySign、BigInteger、fastlock等功能的intrinsic优化，以提升部分场景下的性能

## 特性实现流程描述

N/A

## 与其他特性交互描述

N/A

## 风险项

- 可能影响到部分使用 java 语言编译的程序

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

N/A

## 特性测试约束

1. Linux 内核需要大于 6.6 方支持 RISC-V hwprobe 特性（openEuler 已支持）

2. RISC-V CPU 需要支持 Zfa、Zacas、Zabha、Zvkn、Zicond 拓展才可以生成对应扩展的JIT代码

3. RISC-V CPU 需要支持 alignedAccesses 才能够启用大部分加解密算法的汇编优化 

4. fastlock的相关优化需要手动开启 -XX:LockingMode=2 

5. 若不满足条件则只使用普通汇编优化，不影响功能使用


## 特性测试环境描述
<!-- 主要描述执行测试的硬件信息 -->
| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 算能 SG2042 | 64C 128G | 支持 Zfa、Zicond 拓展 |

## 测试计划
| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
| Test func | 2025/11/21 | 2025/11/27 | 7 | 功能测试 |
| Test bench | 2025/11/28  | 2025/11/30 | 3  | 回归测试 |
| Test SPECjvm | 2025/12/01  | 2025/12/02 | 2  | 性能测试 |
| Test SPECjbb | 2025/12/03  | 2025/12/05 | 3  | 性能测试 |

## 入口标准

1. Backport 后的 openjdk21 能够正常进行编译，无报错

## 出口标准

1. openjdk21 编译完成后，能够正常执行 make test 测试，且测试通过
2. 配置环境变量 export JAVA_TOOL_OPTIONS="-XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions  -XX:-AvoidUnalignedAccesses  -XX:LockingMode=2 " 重新执行 make test 测试，能够完整执行并通过测试，不报错

# 附件

N/A
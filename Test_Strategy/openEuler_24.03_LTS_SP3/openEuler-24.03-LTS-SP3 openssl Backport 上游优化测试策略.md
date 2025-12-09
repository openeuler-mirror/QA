![avatar](../images/openEuler.png)

版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025.11.10 | 1.0.0 | 初版 | HeliC829 |

关键词： 
openssl 密码学 SHA-2 MD5 RISC-V Zbb

 
摘要：
为 openEuler 24.03 LTS SP3 中的 openssl 3.0.12 版本 Backport 上游主线版本中已经合并的 SHA-2 汇编优化，进一步优化 openssl SHA-2 算法在 RISC-V 下的性能表现。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |


# 特性描述
openEuler 24.03 LTS SP3 中的 openssl 基线版本为 3.0.12 ，而当前 openssl 的最新版本已经到了 3.6 系列。与openssl 最新版本相比，3.0.12 版本缺少许多针对 RISC-V 的汇编支持及性能优化，将上游主线版本中已合并的部分密码学汇编优化算法 Backport 到 3.0.12 中，可以进一步优化 openEuler 24.03 LTS SP3 下 openssl 在 RISC-V 下的性能表现。

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
[ID3WE6](https://gitee.com/openeuler/release-management/issues/ID3WE6?from=project-issue)|openssl：Backport 主线 RISC-V 架构的 SHA-2 汇编优化|Testing|dev-utils|@HeliC829|ISO|openssl|
[ID5TUY](https://gitee.com/openeuler/release-management/issues/ID5TUY?from=project-issue)|openssl：Backport 主线 RISC-V 架构的 SHA-2 汇编优化|Testing|dev-utils|@HeliC829|ISO|openssl|

## 特性应用场景分析

SHA-2 算法的核心应用场景如下：
1. 数据完整性验证
目的：保证数据未被篡改。
典型应用：计算文件、消息的哈希值。验证软件下载是否完整、数据传输是否准确。

2. 数字签名基础
目的：保证签名效率和安全性。
典型应用：对消息的哈希值进行签名，而非消息本身。作为SM2/RSA等签名算法的前置步骤。

3. 密码安全存储
目的：保证密码的机密性。
典型应用：系统数据库不存储明文密码，而是存储加盐后的密码哈希值。验证时对比哈希值即可。

MD5 算法的核心应用场景如下：
1. 非密码学安全校验
目的：快速检查数据意外错误。
典型应用：用于网络传输、文件系统的非恶意错误检测。（注：因存在严重安全漏洞，已不适用于安全场景）

2. 遗留系统兼容
目的：保证与旧系统、旧协议的兼容。
典型应用：在一些非安全的旧有文件校验、数据去重场景中可能遇到。（注：在新设计中严禁使用）

## 特性实现流程描述

1. 判断当前 RISC-V CPU 支持的指令集情况

2. 根据 CPU 指令拓展支持的情况，选用支持的优化函数版本

3. 若不支持 Zbb 拓展，则回落 RV64GC 汇编优化实现

## 与其他特性交互描述

N/A

## 风险项

N/A

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

2. RISC-V CPU 需要支持 Zbb 拓展才可以使用 SHA-2 Zbb 汇编优化 

3. RISC-V CPU 需要支持 Zbb 拓展才可以使用 MD5 Zbb 汇编优化 

4. 若不满足条件则只使用普通汇编优化，不影响功能使用

## 特性测试环境描述
<!-- 主要描述执行测试的硬件信息 -->
| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 算能 SG2042 | 64C 128G | 可使用 SHA-2 Zbb 汇编优化 |

## 测试计划
<!-- 测试执行策略主要描述该轮次执行的分层策略中的测试项 -->
| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
| Test round 3-4 | 2025/11/7 | 2025/11/20 | 14 | 全量测试 |
| Test round 5 | 2025/11/21  | 2025/11/27 | 7  | 回归测试 |


## 入口标准

1. Backport 后的 openssl 能够正常进行编译，无报错

## 出口标准

1. openssl 编译完成后，能够正常执行 make test 测试，且测试通过

2. 执行 export OPENSSL_riscvcap=rv64gc_zbb 设置环境变量，强制启用 SHA-2 的 Zbb 优化，再次执行 make test 测试，且测试通过

# 附件

N/A

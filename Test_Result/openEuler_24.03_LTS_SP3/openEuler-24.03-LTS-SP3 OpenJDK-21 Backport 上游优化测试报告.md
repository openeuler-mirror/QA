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

# 1     特性概述

openEuler 24.03 LTS SP3 中的 OpenJDK 基线版本为 21.0.9 ，而当前 OpenJDK 的最新版本已经到了 26 系列。与 OpenJDK 最新版本相比，21.0.9 版本缺少许多针对 RISC-V 的扩展支持及性能优化，将上游主线版本中已合并的部分RVA23扩展，密码学汇编优化算法，关键intrinsic优化 Backport 到 21.0.9 中，可以进一步优化 openEuler 24.03 LTS SP3 下 OpenJDK 在 RISC-V 下的性能表现。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler RISC-V 24.03 SP3 Test round 5 | 2025/11/21 | 2025/11/27 | 7 | 功能测试 |
| openEuler RISC-V 24.03 SP3 Test round 5 | 2025/11/28  | 2025/11/30 | 3  | 回归测试 |
| openEuler RISC-V 24.03 SP3 Test round 5 | 2025/12/01  | 2025/12/02 | 2  | 性能测试 |
| openEuler RISC-V 24.03 SP3 Test round 5 | 2025/12/03  | 2025/12/05 | 3  | 性能测试 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 算能 SG2044 | 64C 128G | 支持 Zbb、Zicond 拓展 |
| QEMU虚拟机 |  RVA23  |    |

# 3     测试结论概述

## 3.1   测试整体结论

配置环境变量 export JAVA_TOOL_OPTIONS="-XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions  -XX:+UseRVV  -XX:-AvoidUnalignedAccesses  -XX:LockingMode=2 "  针对反合代码，共计执行了36份测试文件，主要覆盖了功能测试和性能测试，通过经过长稳测试，测试通过，无遗留风险，整体质量良好；并使用 SPECjvm 和 SPECjbb 验证了反合后的代码对 Openjdk21 整体能够带来一定程度的性能提升。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 编译测试 | 测试通过 |
| 专项功能测试 | 测试通过 |
| 性能专项测试 | 测试通过 |


## 3.2   约束说明

1. Linux 内核需要大于 6.6 方支持 RISC-V hwprobe 特性（openEuler 已支持）

2. RISC-V CPU 需要支持 Zfa、Zacas、Zabha、Zvkn、Zicond 拓展才可以生成对应扩展的JIT代码

3. RISC-V CPU 需要支持 alignedAccesses 才能够启用大部分加解密算法的汇编优化 

4. fastlock的相关优化需要手动开启 -XX:LockingMode=2 

5. 若不满足条件则只使用普通汇编优化，不影响功能使用

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

NA

### 3.3.2 问题统计

NA

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

NA

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 增加了 RISC-V Zfa、Zacas、Zabha、Zvkn、Zicond 扩展支持 | <font color=green>■</font> |   |
| 2 | 增加了加解密算法的汇编优化 | <font color=green>■</font> |   |
| 3 | 增加了 HashCode、CopySign、BigInteger、fastlock 等功能的 intrinsic 优化 | <font color=green>■</font> |   |


<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

应用层接口无变化，不涉及兼容性。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 性能变化 | 测试结论 |
| ------- | ------- | ------ |
| Base64 | 综合性能提升 35.2%  | 存在性能提升 |
| Adler32 | 综合性能提升 314%  | 存在性能提升 |
| CRC32 | 综合性能提升 121% | 存在性能提升 |
| Comparison | 综合性能提升 -10.5% | 存在性能下降 |
| LockUnlock | 综合性能提升 31.4%  | 存在性能提升 |
| SPECjvm | 综合性能提升 1.6% | 存在性能提升 |
| SPECjbb | 性能提升 1.1% | 存在性能提升 |

### 4.3.2 可靠性/韧性测试结论

NA

### 4.3.3 安全测试结论

NA

## 4.4 资料测试结论

NA

## 4.5 其他测试结论

NA

# 5     测试执行

## 5.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|openEuler RISC-V 24.03 SP3 Test round 5 | 26份功能测试文件 | 完全通过 | 0 |
|openEuler RISC-V 24.03 SP3 Test round 5 | 10份性能测试文件 | 完全通过 | 0 |
|openEuler RISC-V 24.03 SP3 Test round 5 | 2个性能测试套件 | 完全通过 | 0 |


## 5.2   后续测试建议

NA

# 6     附件

*此处可粘贴各类专项测试数据或报告*

## 6.1    SPECjvm测试数据

| 测试项 | 反合前(ops/m) | 反合后(ops/m) | 性能提升比例 |
| -------- | ---------- | ------------ | ------------ |
| compress | 1681.03 | 1691.77 | +0.64% |
| crypto.aes | 428.66 | 385.48 | -10.07% |
| crypto.rsa | 8612.63 | 8487.93 | -1.45% |
| crypto.signverify | 5203.39 | 5581.49 | +7.27% |
| derby | 1278.84 | 1185.79 | -7.28% |
| mpegaudio | 1249.06 | 1289.77 | +3.26% |
| scimark.fft.large | 276.25 | 275.29 | -0.35% |
| scimark.lu.large | 87.21 | 87.41 | +0.23% |
| scimark.sor.large | 470.50 | 446.28 | -5.15% |
| scimark.sparse.large | 138.71 | 172.06 | +24.04% |
| scimark.monte_carlo | 1931.74 | 2441.58 | +26.39% |
| scimark.fft.small | 1741.21 | 1660.00 | -4.66% |
| scimark.lu.small | 2195.20 | 1975.65 | -10.00% |
| scimark.sor.small | 2659.33 | 2640.56 | -0.71% |
| scimark.sparse.small | 679.27 | 852.09 | +25.44% |
| serial | 629.25 | 596.62 | -5.19% |
| sunflow | 621.88 | 629.89 | +1.29% |
| xml.transform | 1263.17 | 1254.34 | -0.70% |
| xml.validation | 1954.46 | 1920.15 | -1.76% |


## 6.2    SPECjbb测试数据

| 测试项 | 反合前(ops/m) | 反合后(ops/m) | 性能提升比例 |
| -------- | ---------- | ------------ | ------------ |
| max-jops | 20977 | 21216 | 1.2% |
| critical-jops | 8703 | 8799 | 1.1% |

## 6.3    测试项目来源

| 特性 | 测试文件 | 测试类型 |
| -------- | ---------- | ------------ |
| Zfa | test/hotspot/jtreg/compiler/intrinsics/TestDoubleIsFinite.java | 功能测试 |
|     | test/hotspot/jtreg/compiler/floatingpoint/DmodTest.java | 功能测试 |
| Zacas、Zabha | test/micro/org/openjdk/bench/vm/lang/LockUnlock.java | 性能测试 |
| Zvkn | test/hotspot/jtreg/compiler/codegen/aes/TestAESMain.java | 功能测试 |
| Zicond | test/hotspot/gtest/riscv/test_assembler_riscv.cpp | 功能测试 |
|  | test/hotspot/jtreg/compiler/c2/irTests/TestConv2BExpansion.java | 功能测试 |
|  | test/hotspot/jtreg/compiler/c2/irTests/TestFPComparison.java | 功能测试 |
|  | test/hotspot/jtreg/compiler/vectorapi/TestVectorTest.java | 功能测试 |
|  | test/micro/org/openjdk/bench/java/lang/ClassComparison.java | 性能测试 |
|  | test/micro/org/openjdk/bench/java/lang/FPComparison.java | 性能测试 |
|  | test/micro/org/openjdk/bench/java/lang/IntegerComparison.java | 性能测试 |
|  | test/micro/org/openjdk/bench/java/lang/LongComparison.java | 性能测试 |
|  | test/micro/org/openjdk/bench/java/lang/PointerComparison.java | 性能测试 |
| SHA1 | test/hotspot/jtreg/compiler/intrinsics/sha/sanity/TestSHA1Intrinsics.java | 功能测试 |
| SHA2 | test/hotspot/jtreg/compiler/intrinsics/sha/sanity/TestSHA256Intrinsics.java | 功能测试 |
|  | test/hotspot/jtreg/compiler/intrinsics/sha/sanity/TestSHA512Intrinsics.java | 功能测试 |
|  | test/hotspot/jtreg/compiler/intrinsics/sha/TestDigest.java | 功能测试 |
| ChaCha20 | test/jdk/com/sun/crypto/provider/Cipher/ChaCha20/ChaCha20KeyGeneratorTest.java | 功能测试 |
| poly1305 | test/jdk/com/sun/crypto/provider/Cipher/ChaCha20/unittest/Poly1305UnitTestDriver.java | 功能测试 |
| CRC32 | test/hotspot/jtreg/compiler/intrinsics/chacha/TestChaCha20.java | 功能测试 |
|  | test/micro/org/openjdk/bench/java/util/TestCRC32.java | 性能测试 |
| adler32 | test/hotspot/jtreg/compiler/intrinsics/zip/TestAdler32.java | 功能测试 |
|  | test/micro/org/openjdk/bench/java/util/TestAdler32.java | 性能测试 |
| base64 | test/hotspot/jtreg/compiler/intrinsics/base64/TestBase64.java | 功能测试 |
|  | test/jdk/java/util/Base64/TestBase64.java | 功能测试 |
|  | test/micro/org/openjdk/bench/java/util/Base64Decode.java | 性能测试 |
|  | test/micro/org/openjdk/bench/java/util/Base64Encode.java | 性能测试 |
|  | test/micro/org/openjdk/bench/java/util/Base64VarLenDecode.java | 性能测试 |
| HashCode | test/hotspot/jtreg/compiler/escapeAnalysis/TestEAVectorizedHashCode.java | 功能测试 |
|  | test/hotspot/jtreg/compiler/intrinsics/TestArraysHashCode.java | 功能测试 |
|  | test/hotspot/jtreg/compiler/intrinsics/object/TestHashCode.java | 功能测试 |
| CopySign | test/micro/org/openjdk/bench/java/lang/MathBench.java | 功能测试 |
| BigInteger | test/hotspot/jtreg/compiler/intrinsics/bigInteger/TestSquareToLen.java | 功能测试 |
|  | test/hotspot/jtreg/compiler/intrinsics/bigInteger/MontgomeryMultiplyTest.java | 功能测试 |
|  | test/hotspot/jtreg/compiler/intrinsics/bigInteger/TestMultiplyToLen.java | 功能测试 |
| fastlock | test/micro/org/openjdk/bench/vm/lang/LockUnlock.java | 性能测试 |

## 6.4    专项性能测试数据

反合前
```
Benchmark                                     (addSpecial)  (count)  (errorIndex)  (innerCount)  (lineSize)  (maxNumBytes)   Mode  Cnt      Score      Error   Units
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4              1  thrpt    4  26267.338 ±  338.321  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4              3  thrpt    4  17512.770 ±   86.725  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4              7  thrpt    4  14245.780 ±  193.657  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4             32  thrpt    4   9126.681 ±  493.939  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4             64  thrpt    4   6449.117 ±  134.734  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4             80  thrpt    4   5709.655 ±   16.562  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4             96  thrpt    4   4949.429 ±   11.137  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4            112  thrpt    4   4441.368 ±   34.375  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4            512  thrpt    4   1355.141 ±   11.360  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4           1000  thrpt    4    594.476 ±   24.934  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4          20000  thrpt    4     39.334 ±    0.069  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4          50000  thrpt    4     16.542 ±    0.065  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32              1  thrpt    4  26800.649 ±  710.975  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32              3  thrpt    4  17458.608 ±   41.544  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32              7  thrpt    4  14286.975 ±  224.073  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32             32  thrpt    4   9146.883 ±  460.099  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32             64  thrpt    4   6544.332 ±   29.624  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32             80  thrpt    4   5691.718 ±  143.703  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32             96  thrpt    4   4918.062 ±   17.489  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32            112  thrpt    4   4473.848 ±   31.602  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32            512  thrpt    4   1311.613 ±  112.480  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32           1000  thrpt    4    608.559 ±   14.685  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32          20000  thrpt    4     39.031 ±    0.043  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32          50000  thrpt    4     16.528 ±    0.019  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76              1  thrpt    4  26062.581 ±  594.326  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76              3  thrpt    4  17402.282 ±  108.268  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76              7  thrpt    4  13899.103 ±  229.518  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76             32  thrpt    4   9260.762 ±  355.337  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76             64  thrpt    4   6464.558 ±   79.372  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76             80  thrpt    4   5712.744 ±   26.680  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76             96  thrpt    4   4945.664 ±   90.187  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76            112  thrpt    4   4475.306 ±   45.044  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76            512  thrpt    4   1357.679 ±   29.481  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76           1000  thrpt    4    607.095 ±   67.858  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76          20000  thrpt    4     39.197 ±    0.506  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76          50000  thrpt    4     16.433 ±    0.340  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128              1  thrpt    4  25727.118 ±  415.710  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128              3  thrpt    4  17429.820 ±  255.905  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128              7  thrpt    4  14109.320 ±   80.258  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128             32  thrpt    4   9285.942 ±  342.074  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128             64  thrpt    4   6487.280 ±   20.639  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128             80  thrpt    4   5668.177 ±   30.281  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128             96  thrpt    4   4967.115 ±   34.514  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128            112  thrpt    4   4452.806 ±   60.707  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128            512  thrpt    4   1347.177 ±    0.885  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128           1000  thrpt    4    667.673 ±   15.681  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128          20000  thrpt    4     39.662 ±    0.199  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128          50000  thrpt    4     16.571 ±    0.071  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4              1  thrpt    4  17835.180 ±   39.743  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4              3  thrpt    4  13068.901 ± 2005.898  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4              7  thrpt    4   7660.813 ±  573.387  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4             32  thrpt    4   2443.563 ±   97.523  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4             64  thrpt    4   1482.576 ±   19.626  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4             80  thrpt    4   1213.387 ±   49.212  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4             96  thrpt    4   1024.372 ±   59.417  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4            112  thrpt    4    873.638 ±   15.661  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4            512  thrpt    4    201.890 ±   13.910  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4           1000  thrpt    4    101.340 ±    8.437  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4          20000  thrpt    4      6.235 ±    0.112  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4          50000  thrpt    4      2.490 ±    0.012  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32              1  thrpt    4  22273.785 ±  145.545  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32              3  thrpt    4  15277.467 ±  192.560  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32              7  thrpt    4  11049.422 ±  419.142  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32             32  thrpt    4   4646.849 ±   35.966  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32             64  thrpt    4   2653.443 ±   72.806  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32             80  thrpt    4   2223.784 ±   13.859  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32             96  thrpt    4   1962.715 ±   15.987  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32            112  thrpt    4   1705.848 ±    7.805  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32            512  thrpt    4    414.773 ±    5.936  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32           1000  thrpt    4    213.618 ±    1.568  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32          20000  thrpt    4     11.029 ±    0.015  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32          50000  thrpt    4      6.455 ±    0.250  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76              1  thrpt    4  23188.237 ±  215.295  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76              3  thrpt    4  15357.022 ±   12.615  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76              7  thrpt    4  11205.474 ± 1260.286  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76             32  thrpt    4   5148.756 ±   71.034  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76             64  thrpt    4   3200.665 ±    4.202  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76             80  thrpt    4   2586.783 ±   20.458  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76             96  thrpt    4   2197.315 ±   12.006  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76            112  thrpt    4   1952.316 ±    4.579  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76            512  thrpt    4    474.463 ±    0.840  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76           1000  thrpt    4    249.699 ±    0.203  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76          20000  thrpt    4     12.996 ±    0.257  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76          50000  thrpt    4      6.932 ±    6.405  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128              1  thrpt    4  23308.001 ±  139.634  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128              3  thrpt    4  15263.968 ±   85.637  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128              7  thrpt    4  11093.548 ± 1526.921  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128             32  thrpt    4   5253.517 ±   21.837  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128             64  thrpt    4   3237.992 ±   25.778  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128             80  thrpt    4   2825.472 ±   37.868  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128             96  thrpt    4   2462.532 ±   11.382  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128            112  thrpt    4   2066.243 ±   35.020  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128            512  thrpt    4    495.887 ±    0.786  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128           1000  thrpt    4    256.987 ±    1.255  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128          20000  thrpt    4     13.661 ±    0.063  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128          50000  thrpt    4      7.192 ±    9.551  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4              1  thrpt    4  25604.716 ±   28.576  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4              3  thrpt    4  17497.249 ±  108.055  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4              7  thrpt    4  14346.051 ±   55.071  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4             32  thrpt    4   9255.328 ±  398.775  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4             64  thrpt    4   6454.183 ±   35.417  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4             80  thrpt    4   5644.508 ±   47.801  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4             96  thrpt    4   5077.742 ±   22.011  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4            112  thrpt    4   4487.794 ±   13.983  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4            512  thrpt    4   1315.704 ±   11.034  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4           1000  thrpt    4    664.478 ±    2.916  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4          20000  thrpt    4     39.819 ±    0.145  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4          50000  thrpt    4     15.641 ±    0.201  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32              1  thrpt    4  27068.594 ±   31.043  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32              3  thrpt    4  17446.949 ±   77.809  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32              7  thrpt    4  14285.136 ±   94.064  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32             32  thrpt    4   9087.205 ±  616.553  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32             64  thrpt    4   6523.362 ±   60.283  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32             80  thrpt    4   5708.967 ±   29.724  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32             96  thrpt    4   5080.051 ±   91.432  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32            112  thrpt    4   4470.423 ±   37.919  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32            512  thrpt    4   1333.857 ±    6.627  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32           1000  thrpt    4    669.234 ±    4.455  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32          20000  thrpt    4     39.934 ±    0.177  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32          50000  thrpt    4     15.661 ±    0.085  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76              1  thrpt    4  25979.412 ±   73.015  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76              3  thrpt    4  17393.184 ±   73.191  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76              7  thrpt    4  14133.413 ±   80.017  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76             32  thrpt    4   9214.095 ±  304.851  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76             64  thrpt    4   6474.858 ±   34.792  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76             80  thrpt    4   5676.776 ±   38.224  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76             96  thrpt    4   5093.600 ±   30.543  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76            112  thrpt    4   4490.900 ±   15.069  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76            512  thrpt    4   1283.997 ±    6.299  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76           1000  thrpt    4    666.199 ±   35.395  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76          20000  thrpt    4     39.786 ±    0.224  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76          50000  thrpt    4     15.647 ±    0.047  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128              1  thrpt    4  27421.660 ±  907.314  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128              3  thrpt    4  17270.453 ±  890.678  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128              7  thrpt    4  14266.022 ±   71.823  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128             32  thrpt    4   9090.462 ±  572.252  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128             64  thrpt    4   6472.192 ±   17.322  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128             80  thrpt    4   5691.371 ±   19.320  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128             96  thrpt    4   5087.809 ±   30.530  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128            112  thrpt    4   4482.427 ±   61.766  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128            512  thrpt    4   1322.959 ±    7.613  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128           1000  thrpt    4    667.367 ±    1.641  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128          20000  thrpt    4     40.011 ±    0.260  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128          50000  thrpt    4     15.649 ±    0.072  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4              1  thrpt    4     83.132 ±    0.891  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4              3  thrpt    4     84.667 ±    1.369  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4              7  thrpt    4     82.827 ±    1.840  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4             32  thrpt    4     82.160 ±    0.493  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4             64  thrpt    4     83.118 ±    0.375  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4             80  thrpt    4     83.387 ±    0.810  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4             96  thrpt    4     83.791 ±    0.720  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4            112  thrpt    4     83.096 ±    0.816  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4            512  thrpt    4     81.997 ±    1.873  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4           1000  thrpt    4     82.968 ±    0.656  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4          20000  thrpt    4     85.301 ±   21.765  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4          50000  thrpt    4     81.931 ±    0.343  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32              1  thrpt    4     81.019 ±    1.545  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32              3  thrpt    4     82.783 ±    0.522  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32              7  thrpt    4     81.164 ±    0.222  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32             32  thrpt    4     82.353 ±    1.241  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32             64  thrpt    4     83.692 ±    1.562  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32             80  thrpt    4     83.283 ±    0.894  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32             96  thrpt    4     83.894 ±    2.357  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32            112  thrpt    4     84.654 ±    2.102  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32            512  thrpt    4     82.298 ±    0.227  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32           1000  thrpt    4     82.516 ±    0.631  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32          20000  thrpt    4     85.560 ±   33.745  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32          50000  thrpt    4     82.417 ±    2.608  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76              1  thrpt    4     84.270 ±    0.857  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76              3  thrpt    4     83.142 ±    0.416  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76              7  thrpt    4     82.714 ±    1.074  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76             32  thrpt    4     82.814 ±    0.763  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76             64  thrpt    4     82.792 ±    1.073  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76             80  thrpt    4     83.470 ±    0.688  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76             96  thrpt    4     82.860 ±    0.567  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76            112  thrpt    4     85.480 ±    0.433  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76            512  thrpt    4     83.213 ±    2.046  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76           1000  thrpt    4     81.973 ±    1.115  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76          20000  thrpt    4     83.856 ±   27.093  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76          50000  thrpt    4     82.361 ±    0.938  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128              1  thrpt    4     83.193 ±    1.551  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128              3  thrpt    4     83.340 ±    2.213  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128              7  thrpt    4     83.997 ±    2.456  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128             32  thrpt    4     84.272 ±    0.993  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128             64  thrpt    4     85.822 ±    1.766  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128             80  thrpt    4     82.227 ±    1.180  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128             96  thrpt    4     84.982 ±    1.045  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128            112  thrpt    4     83.723 ±    2.286  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128            512  thrpt    4     83.722 ±    1.535  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128           1000  thrpt    4     81.185 ±    1.421  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128          20000  thrpt    4     84.692 ±   26.715  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128          50000  thrpt    4     83.199 ±    0.227  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              1  thrpt    4  41701.732 ±  250.542  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              2  thrpt    4  34464.342 ± 2134.537  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              3  thrpt    4  29426.492 ±  193.566  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              6  thrpt    4  22285.252 ±   28.938  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              7  thrpt    4  21191.071 ±   74.659  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              9  thrpt    4  18752.873 ±   99.516  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A             10  thrpt    4  17931.243 ±   66.856  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A             48  thrpt    4   9901.191 ±  371.422  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A            512  thrpt    4   1639.572 ±    2.639  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A           1000  thrpt    4    887.118 ±    4.496  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A          20000  thrpt    4     46.399 ±    0.287  ops/ms
Base64VarLenDecode.decodeMethod                        N/A      N/A           N/A           N/A         N/A            N/A  thrpt    4  36323.133 ± 1856.210   ops/s
TestAdler32.testAdler32Update                          N/A       64           N/A           N/A         N/A            N/A  thrpt   25   2951.845 ±   75.575  ops/ms
TestAdler32.testAdler32Update                          N/A      256           N/A           N/A         N/A            N/A  thrpt   25   2298.780 ±   42.284  ops/ms
TestAdler32.testAdler32Update                          N/A      512           N/A           N/A         N/A            N/A  thrpt   25   1748.580 ±   17.340  ops/ms
TestAdler32.testAdler32Update                          N/A     2048           N/A           N/A         N/A            N/A  thrpt   25    730.386 ±    4.697  ops/ms
TestAdler32.testAdler32Update                          N/A     5012           N/A           N/A         N/A            N/A  thrpt   25    344.386 ±    2.579  ops/ms
TestAdler32.testAdler32Update                          N/A    16384           N/A           N/A         N/A            N/A  thrpt   25    115.070 ±    0.845  ops/ms
TestAdler32.testAdler32Update                          N/A    65536           N/A           N/A         N/A            N/A  thrpt   25     29.141 ±    0.056  ops/ms
TestCRC32.testCRC32Update                              N/A       64           N/A           N/A         N/A            N/A  thrpt    4   2413.176 ±  148.951  ops/ms
TestCRC32.testCRC32Update                              N/A      128           N/A           N/A         N/A            N/A  thrpt    4   1917.264 ±  136.883  ops/ms
TestCRC32.testCRC32Update                              N/A      256           N/A           N/A         N/A            N/A  thrpt    4   1455.579 ±   39.898  ops/ms
TestCRC32.testCRC32Update                              N/A      512           N/A           N/A         N/A            N/A  thrpt    4    942.489 ±   41.308  ops/ms
TestCRC32.testCRC32Update                              N/A     2048           N/A           N/A         N/A            N/A  thrpt    4    334.597 ±   37.670  ops/ms
TestCRC32.testCRC32Update                              N/A    16384           N/A           N/A         N/A            N/A  thrpt    4     44.225 ±    5.958  ops/ms
TestCRC32.testCRC32Update                              N/A    65536           N/A           N/A         N/A            N/A  thrpt    4     11.416 ±    1.829  ops/ms
ClassComparison.equalClass                             N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    949.552 ±   63.286   ns/op
ClassComparison.notEqualClass                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    946.081 ±  115.899   ns/op
ClassComparison.notEqualClassResLong                   N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1168.399 ±  430.765   ns/op
FPComparison.equalDouble                               N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1579.613 ±   37.511   ns/op
FPComparison.equalDoubleResLong                        N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1839.084 ±  109.865   ns/op
FPComparison.equalFloat                                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1644.918 ±   52.927   ns/op
FPComparison.equalFloatResLong                         N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1870.221 ±  265.647   ns/op
FPComparison.greaterDouble                             N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1631.885 ±   20.271   ns/op
FPComparison.greaterDoubleResLong                      N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   2027.798 ±  232.731   ns/op
FPComparison.greaterEqualDouble                        N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1635.936 ±   21.968   ns/op
FPComparison.greaterEqualDoubleResLong                 N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1938.782 ±  152.480   ns/op
FPComparison.greaterEqualFloat                         N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1757.025 ±   11.442   ns/op
FPComparison.greaterEqualFloatResLong                  N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1958.383 ±  106.321   ns/op
FPComparison.greaterFloat                              N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1633.672 ±   29.282   ns/op
FPComparison.greaterFloatResLong                       N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   2016.234 ±  298.582   ns/op
FPComparison.isFiniteDouble                            N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1864.050 ±   65.824   ns/op
FPComparison.isFiniteFloat                             N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1928.207 ±   42.932   ns/op
FPComparison.isInfiniteDouble                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1858.171 ±   42.521   ns/op
FPComparison.isInfiniteFloat                           N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1886.191 ±   38.406   ns/op
FPComparison.isNanDouble                               N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1688.729 ±   67.649   ns/op
FPComparison.isNanFloat                                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1528.664 ±   55.265   ns/op
FPComparison.lessDouble                                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1760.980 ±    8.831   ns/op
FPComparison.lessDoubleResLong                         N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1928.656 ±  100.370   ns/op
FPComparison.lessEqualDouble                           N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1778.388 ±   23.844   ns/op
FPComparison.lessEqualDoubleResLong                    N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1851.205 ±  106.701   ns/op
FPComparison.lessEqualFloat                            N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1753.758 ±   24.652   ns/op
FPComparison.lessEqualFloatResLong                     N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1939.441 ±  101.006   ns/op
FPComparison.lessFloat                                 N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1698.857 ±   13.106   ns/op
FPComparison.lessFloatResLong                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1866.368 ±  137.047   ns/op
IntegerComparison.equalInteger                         N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    957.883 ±   11.308   ns/op
IntegerComparison.greaterEqualInteger                  N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1515.702 ±   13.011   ns/op
IntegerComparison.greaterEqualIntegerResLong           N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1753.507 ±  336.650   ns/op
IntegerComparison.greaterInteger                       N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1486.070 ±   19.500   ns/op
IntegerComparison.lessEqualInteger                     N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1490.255 ±   13.510   ns/op
IntegerComparison.lessEqualIntegerResLong              N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1653.168 ±  627.734   ns/op
IntegerComparison.lessInteger                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1512.164 ±   60.836   ns/op
IntegerComparison.notEqualInteger                      N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    912.598 ±   67.736   ns/op
IntegerComparison.notEqualIntegerResLong               N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1543.359 ±  452.304   ns/op
LockUnlock.testContendedLock                           N/A      N/A           N/A           100         N/A            N/A   avgt    4    384.621 ±  113.475   ns/op
LockUnlock.testRecursiveLockUnlock                     N/A      N/A           N/A           100         N/A            N/A   avgt    4  70649.731 ± 2980.816   ns/op
LockUnlock.testRecursiveSynchronization                N/A      N/A           N/A           100         N/A            N/A   avgt    4    128.339 ±    3.114   ns/op
LockUnlock.testSerialLockUnlock                        N/A      N/A           N/A           100         N/A            N/A   avgt    4   3938.903 ±   17.373   ns/op
LockUnlock.testSimpleLockUnlock                        N/A      N/A           N/A           100         N/A            N/A   avgt    4   3939.372 ±   17.360   ns/op
LongComparison.equalLong                               N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1024.299 ±   37.358   ns/op
LongComparison.greaterEqualLong                        N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1383.701 ±   36.973   ns/op
LongComparison.greaterEqualLongResLong                 N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1712.893 ±  251.506   ns/op
LongComparison.greaterLong                             N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1457.138 ±   37.665   ns/op
LongComparison.lessEqualLong                           N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1433.151 ±   23.095   ns/op
LongComparison.lessEqualLongResLong                    N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1809.819 ±  282.382   ns/op
LongComparison.lessLong                                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1395.446 ±   25.483   ns/op
LongComparison.notEqualLong                            N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1016.224 ±   58.749   ns/op
LongComparison.notEqualLongResLong                     N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1542.389 ±  500.403   ns/op
PointerComparison.equalObject                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    942.944 ±   33.402   ns/op
PointerComparison.notEqualObject                       N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    930.956 ±   55.430   ns/op
PointerComparison.notEqualObjectResLong                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5   1376.645 ±  575.245   ns/op
```

反合后
```
Benchmark                                     (addSpecial)  (count)  (errorIndex)  (innerCount)  (lineSize)  (maxNumBytes)   Mode  Cnt       Score      Error   Units
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4              1  thrpt    4   25822.492 ±   35.734  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4              3  thrpt    4   18216.135 ±   65.073  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4              7  thrpt    4   13491.824 ±  639.436  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4             32  thrpt    4    9838.492 ±  953.123  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4             64  thrpt    4    7974.505 ± 1043.699  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4             80  thrpt    4    7442.659 ±  133.750  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4             96  thrpt    4    6979.910 ±   34.455  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4            112  thrpt    4    6582.236 ±   93.231  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4            512  thrpt    4    2929.229 ±   12.257  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4           1000  thrpt    4    1574.222 ±   15.243  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4          20000  thrpt    4     126.085 ±    0.234  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A           4          50000  thrpt    4      52.608 ±    0.058  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32              1  thrpt    4   24449.580 ±  237.526  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32              3  thrpt    4   18249.174 ±  661.471  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32              7  thrpt    4   13407.426 ±  214.203  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32             32  thrpt    4    9814.737 ± 1028.335  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32             64  thrpt    4    7950.918 ±  885.025  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32             80  thrpt    4    7473.829 ±  106.058  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32             96  thrpt    4    6987.607 ±   22.054  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32            112  thrpt    4    6642.687 ±   23.929  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32            512  thrpt    4    2808.877 ±   91.753  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32           1000  thrpt    4    1616.068 ±   19.322  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32          20000  thrpt    4     126.818 ±    0.534  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          32          50000  thrpt    4      52.351 ±    0.422  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76              1  thrpt    4   24255.937 ±  325.594  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76              3  thrpt    4   18377.734 ±  472.981  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76              7  thrpt    4   13257.290 ±  112.752  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76             32  thrpt    4    9588.354 ± 1139.098  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76             64  thrpt    4    7925.170 ± 1455.843  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76             80  thrpt    4    7451.342 ±  153.420  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76             96  thrpt    4    6912.944 ±   58.433  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76            112  thrpt    4    6644.774 ±   21.525  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76            512  thrpt    4    3022.284 ±   35.509  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76           1000  thrpt    4    1661.460 ±  105.829  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76          20000  thrpt    4     125.692 ±    0.690  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A          76          50000  thrpt    4      53.090 ±    0.028  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128              1  thrpt    4   24215.960 ±   77.746  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128              3  thrpt    4   18345.802 ±  457.459  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128              7  thrpt    4   13444.984 ±  169.379  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128             32  thrpt    4    9413.669 ±  821.248  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128             64  thrpt    4    7983.616 ±  893.789  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128             80  thrpt    4    7412.054 ±  191.544  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128             96  thrpt    4    6959.518 ±   54.756  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128            112  thrpt    4    6639.346 ±   13.843  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128            512  thrpt    4    2839.152 ±   15.282  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128           1000  thrpt    4    1602.569 ±  111.799  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128          20000  thrpt    4     126.447 ±    0.434  ops/ms
Base64Decode.testBase64Decode                            0      N/A           144           N/A         128          50000  thrpt    4      53.113 ±    0.157  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4              1  thrpt    4    9633.896 ± 5664.729  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4              3  thrpt    4   10136.088 ± 1518.555  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4              7  thrpt    4    5989.897 ±   35.871  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4             32  thrpt    4    1900.629 ±    2.512  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4             64  thrpt    4    1030.312 ±    4.864  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4             80  thrpt    4     843.918 ±   14.430  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4             96  thrpt    4     719.153 ±    3.417  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4            112  thrpt    4     619.089 ±    2.477  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4            512  thrpt    4     141.083 ±    0.624  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4           1000  thrpt    4      72.481 ±    0.042  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4          20000  thrpt    4       4.365 ±    0.034  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A           4          50000  thrpt    4       1.617 ±    0.081  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32              1  thrpt    4   21852.363 ±  114.466  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32              3  thrpt    4   15083.427 ±  340.210  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32              7  thrpt    4   10175.501 ± 2443.258  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32             32  thrpt    4    4865.361 ±   26.739  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32             64  thrpt    4    2726.337 ±   13.683  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32             80  thrpt    4    2390.606 ±   32.062  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32             96  thrpt    4    2068.226 ±    3.068  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32            112  thrpt    4    1806.490 ±    1.676  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32            512  thrpt    4     438.139 ±    0.434  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32           1000  thrpt    4     223.786 ±    3.669  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32          20000  thrpt    4      12.152 ±    0.062  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          32          50000  thrpt    4       7.171 ±    0.534  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76              1  thrpt    4   20594.612 ±  381.079  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76              3  thrpt    4   15254.109 ±   84.575  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76              7  thrpt    4   10079.481 ± 2275.569  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76             32  thrpt    4    5323.046 ±   21.061  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76             64  thrpt    4    3409.471 ±    3.997  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76             80  thrpt    4    2821.556 ±    5.830  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76             96  thrpt    4    2438.670 ±    1.577  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76            112  thrpt    4    2149.702 ±    9.983  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76            512  thrpt    4     528.398 ±    6.246  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76           1000  thrpt    4     274.090 ±    0.649  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76          20000  thrpt    4      15.020 ±    0.062  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A          76          50000  thrpt    4       9.322 ±    2.518  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128              1  thrpt    4   22086.726 ± 3272.853  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128              3  thrpt    4   15105.851 ±  251.527  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128              7  thrpt    4   10114.407 ± 1530.519  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128             32  thrpt    4    5304.248 ±   40.769  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128             64  thrpt    4    3539.738 ±   20.589  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128             80  thrpt    4    3058.158 ±   15.431  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128             96  thrpt    4    2719.679 ±   11.761  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128            112  thrpt    4    2325.817 ±    4.383  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128            512  thrpt    4     579.553 ±    2.488  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128           1000  thrpt    4     298.439 ±    2.466  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128          20000  thrpt    4      16.327 ±    0.040  ops/ms
Base64Decode.testBase64MIMEDecode                        0      N/A           144           N/A         128          50000  thrpt    4       7.403 ±   12.609  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4              1  thrpt    4   25605.383 ±  280.695  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4              3  thrpt    4   18446.647 ±  579.200  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4              7  thrpt    4   13095.268 ±  417.439  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4             32  thrpt    4    9539.633 ±  971.494  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4             64  thrpt    4    7860.597 ±  790.735  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4             80  thrpt    4    7389.560 ±  129.909  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4             96  thrpt    4    7016.127 ±   46.741  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4            112  thrpt    4    6603.171 ±   46.911  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4            512  thrpt    4    2709.649 ±   29.018  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4           1000  thrpt    4    1584.756 ±   29.696  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4          20000  thrpt    4     126.875 ±    0.270  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A           4          50000  thrpt    4      50.364 ±    0.077  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32              1  thrpt    4   25372.693 ±  114.493  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32              3  thrpt    4   18583.452 ±  314.077  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32              7  thrpt    4   13227.981 ±  447.164  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32             32  thrpt    4    9524.507 ±  695.057  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32             64  thrpt    4    8028.763 ±  708.149  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32             80  thrpt    4    7334.657 ±   82.867  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32             96  thrpt    4    7009.961 ±   55.129  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32            112  thrpt    4    6599.261 ±   64.558  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32            512  thrpt    4    3120.579 ±   39.513  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32           1000  thrpt    4    1607.035 ±   41.436  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32          20000  thrpt    4     126.914 ±    0.683  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          32          50000  thrpt    4      50.176 ±    0.648  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76              1  thrpt    4   24267.528 ±  136.042  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76              3  thrpt    4   18286.351 ±  130.828  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76              7  thrpt    4   13135.758 ±  443.939  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76             32  thrpt    4    9822.837 ±  833.193  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76             64  thrpt    4    7996.564 ±  934.839  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76             80  thrpt    4    7410.291 ±  213.868  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76             96  thrpt    4    6720.266 ±   91.696  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76            112  thrpt    4    6639.300 ±   77.343  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76            512  thrpt    4    3178.128 ±    6.124  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76           1000  thrpt    4    1626.433 ±   29.196  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76          20000  thrpt    4     127.317 ±    2.428  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A          76          50000  thrpt    4      50.209 ±    0.074  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128              1  thrpt    4   25680.358 ±   94.329  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128              3  thrpt    4   18332.250 ±  662.101  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128              7  thrpt    4   13320.635 ±  433.735  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128             32  thrpt    4    9805.679 ±  794.638  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128             64  thrpt    4    7766.672 ±  343.131  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128             80  thrpt    4    7418.236 ±  175.806  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128             96  thrpt    4    7015.417 ±   23.983  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128            112  thrpt    4    6674.202 ±   25.254  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128            512  thrpt    4    3122.365 ±   22.932  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128           1000  thrpt    4    1640.303 ±   23.432  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128          20000  thrpt    4     126.570 ±    0.272  ops/ms
Base64Decode.testBase64URLDecode                         0      N/A           144           N/A         128          50000  thrpt    4      49.774 ±    0.017  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4              1  thrpt    4      81.269 ±   29.720  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4              3  thrpt    4      82.632 ±   27.890  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4              7  thrpt    4      79.985 ±   27.690  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4             32  thrpt    4      81.717 ±   31.263  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4             64  thrpt    4      82.492 ±   32.485  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4             80  thrpt    4      80.491 ±   30.518  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4             96  thrpt    4      81.854 ±   28.528  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4            112  thrpt    4      81.456 ±   29.028  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4            512  thrpt    4      80.507 ±   28.978  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4           1000  thrpt    4      80.498 ±   19.337  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4          20000  thrpt    4      81.356 ±   32.383  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A           4          50000  thrpt    4      82.789 ±   24.507  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32              1  thrpt    4      81.057 ±   26.053  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32              3  thrpt    4      80.109 ±   28.008  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32              7  thrpt    4      81.575 ±   30.719  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32             32  thrpt    4      80.895 ±   27.876  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32             64  thrpt    4      81.415 ±   36.533  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32             80  thrpt    4      80.149 ±   32.170  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32             96  thrpt    4      81.930 ±   28.041  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32            112  thrpt    4      82.131 ±   29.435  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32            512  thrpt    4      81.874 ±   32.809  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32           1000  thrpt    4      80.096 ±   10.018  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32          20000  thrpt    4      83.793 ±   29.506  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          32          50000  thrpt    4      84.182 ±   37.391  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76              1  thrpt    4      82.800 ±   31.535  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76              3  thrpt    4      83.025 ±   33.338  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76              7  thrpt    4      80.206 ±   23.865  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76             32  thrpt    4      77.693 ±   25.129  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76             64  thrpt    4      81.210 ±   28.633  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76             80  thrpt    4      80.839 ±   31.724  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76             96  thrpt    4      80.519 ±   24.990  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76            112  thrpt    4      80.023 ±   29.469  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76            512  thrpt    4      79.910 ±   18.758  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76           1000  thrpt    4      81.981 ±   33.264  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76          20000  thrpt    4      85.268 ±   34.799  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A          76          50000  thrpt    4      80.276 ±   32.916  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128              1  thrpt    4      82.119 ±   35.571  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128              3  thrpt    4      81.254 ±   32.218  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128              7  thrpt    4      81.137 ±   29.935  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128             32  thrpt    4      79.631 ±   28.075  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128             64  thrpt    4      80.330 ±   28.780  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128             80  thrpt    4      84.397 ±   42.008  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128             96  thrpt    4      80.409 ±   28.549  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128            112  thrpt    4      84.453 ±   42.837  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128            512  thrpt    4      81.495 ±   30.254  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128           1000  thrpt    4      78.936 ±   21.576  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128          20000  thrpt    4      83.751 ±   28.160  ops/ms
Base64Decode.testBase64WithErrorInputsDecode             0      N/A           144           N/A         128          50000  thrpt    4      77.843 ±   32.482  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              1  thrpt    4   41487.485 ±   42.034  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              2  thrpt    4   34544.281 ±  365.558  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              3  thrpt    4   25672.963 ±  330.570  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              6  thrpt    4   19682.535 ±  109.446  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              7  thrpt    4   18632.304 ±  104.400  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A              9  thrpt    4   17299.190 ±  429.445  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A             10  thrpt    4   16548.799 ±  201.210  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A             48  thrpt    4   10551.402 ±  418.788  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A            512  thrpt    4    3447.464 ±   15.728  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A           1000  thrpt    4    2079.592 ±   10.649  ops/ms
Base64Encode.testBase64Encode                          N/A      N/A           N/A           N/A         N/A          20000  thrpt    4     134.295 ±    0.369  ops/ms
Base64VarLenDecode.decodeMethod                        N/A      N/A           N/A           N/A         N/A            N/A  thrpt    4  125410.931 ± 4605.352   ops/s
TestAdler32.testAdler32Update                          N/A       64           N/A           N/A         N/A            N/A  thrpt   25   21972.824 ±  160.061  ops/ms
TestAdler32.testAdler32Update                          N/A      256           N/A           N/A         N/A            N/A  thrpt   25   12653.876 ±  184.115  ops/ms
TestAdler32.testAdler32Update                          N/A      512           N/A           N/A         N/A            N/A  thrpt   25    7881.891 ±   82.992  ops/ms
TestAdler32.testAdler32Update                          N/A     2048           N/A           N/A         N/A            N/A  thrpt   25    2334.064 ±    7.900  ops/ms
TestAdler32.testAdler32Update                          N/A     5012           N/A           N/A         N/A            N/A  thrpt   25    1016.784 ±    1.874  ops/ms
TestAdler32.testAdler32Update                          N/A    16384           N/A           N/A         N/A            N/A  thrpt   25     315.433 ±    0.981  ops/ms
TestAdler32.testAdler32Update                          N/A    65536           N/A           N/A         N/A            N/A  thrpt   25      79.694 ±    0.460  ops/ms
TestCRC32.testCRC32Update                              N/A       64           N/A           N/A         N/A            N/A  thrpt    4    9344.412 ±   44.634  ops/ms
TestCRC32.testCRC32Update                              N/A      128           N/A           N/A         N/A            N/A  thrpt    4    5470.763 ±   74.775  ops/ms
TestCRC32.testCRC32Update                              N/A      256           N/A           N/A         N/A            N/A  thrpt    4    2947.739 ±   14.650  ops/ms
TestCRC32.testCRC32Update                              N/A      512           N/A           N/A         N/A            N/A  thrpt    4    1533.949 ±    7.088  ops/ms
TestCRC32.testCRC32Update                              N/A     2048           N/A           N/A         N/A            N/A  thrpt    4     562.110 ±    7.842  ops/ms
TestCRC32.testCRC32Update                              N/A    16384           N/A           N/A         N/A            N/A  thrpt    4      77.742 ±    0.361  ops/ms
TestCRC32.testCRC32Update                              N/A    65536           N/A           N/A         N/A            N/A  thrpt    4      19.393 ±    0.090  ops/ms
ClassComparison.equalClass                             N/A      N/A           N/A           N/A         N/A            N/A   avgt    5     929.012 ±   60.858   ns/op
ClassComparison.notEqualClass                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5     953.039 ±   51.403   ns/op
ClassComparison.notEqualClassResLong                   N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1076.674 ±  205.541   ns/op
FPComparison.equalDouble                               N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1912.748 ±   48.833   ns/op
FPComparison.equalDoubleResLong                        N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2206.103 ±  227.105   ns/op
FPComparison.equalFloat                                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1922.743 ±   22.514   ns/op
FPComparison.equalFloatResLong                         N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2189.557 ±   78.884   ns/op
FPComparison.greaterDouble                             N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1663.261 ±   60.088   ns/op
FPComparison.greaterDoubleResLong                      N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1961.705 ±  237.634   ns/op
FPComparison.greaterEqualDouble                        N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1951.792 ±   28.978   ns/op
FPComparison.greaterEqualDoubleResLong                 N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2166.420 ±  191.165   ns/op
FPComparison.greaterEqualFloat                         N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1914.536 ±   69.095   ns/op
FPComparison.greaterEqualFloatResLong                  N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2207.254 ±  127.210   ns/op
FPComparison.greaterFloat                              N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1719.240 ±   27.082   ns/op
FPComparison.greaterFloatResLong                       N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2024.245 ±  294.829   ns/op
FPComparison.isFiniteDouble                            N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2287.435 ±   60.128   ns/op
FPComparison.isFiniteFloat                             N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2352.890 ±    9.698   ns/op
FPComparison.isInfiniteDouble                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2292.666 ±   14.675   ns/op
FPComparison.isInfiniteFloat                           N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2352.284 ±    9.772   ns/op
FPComparison.isNanDouble                               N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1453.342 ±   24.733   ns/op
FPComparison.isNanFloat                                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1490.964 ±   26.708   ns/op
FPComparison.lessDouble                                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1728.357 ±   35.313   ns/op
FPComparison.lessDoubleResLong                         N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1951.911 ±  116.970   ns/op
FPComparison.lessEqualDouble                           N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1919.197 ±   31.343   ns/op
FPComparison.lessEqualDoubleResLong                    N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2187.318 ±   31.272   ns/op
FPComparison.lessEqualFloat                            N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1914.758 ±   20.841   ns/op
FPComparison.lessEqualFloatResLong                     N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2223.156 ±  219.635   ns/op
FPComparison.lessFloat                                 N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1704.513 ±    6.127   ns/op
FPComparison.lessFloatResLong                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1996.324 ±  219.923   ns/op
IntegerComparison.equalInteger                         N/A      N/A           N/A           N/A         N/A            N/A   avgt    5     958.852 ±   65.547   ns/op
IntegerComparison.greaterEqualInteger                  N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1664.056 ±   22.593   ns/op
IntegerComparison.greaterEqualIntegerResLong           N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2176.546 ±  250.830   ns/op
IntegerComparison.greaterInteger                       N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1687.231 ±   16.717   ns/op
IntegerComparison.lessEqualInteger                     N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1666.376 ±   14.866   ns/op
IntegerComparison.lessEqualIntegerResLong              N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1998.938 ±  249.253   ns/op
IntegerComparison.lessInteger                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1660.765 ±    4.389   ns/op
IntegerComparison.notEqualInteger                      N/A      N/A           N/A           N/A         N/A            N/A   avgt    5     926.527 ±   54.982   ns/op
IntegerComparison.notEqualIntegerResLong               N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1479.080 ±  714.418   ns/op
LockUnlock.testContendedLock                           N/A      N/A           N/A           100         N/A            N/A   avgt    4     224.697 ±  245.540   ns/op
LockUnlock.testRecursiveLockUnlock                     N/A      N/A           N/A           100         N/A            N/A   avgt    4   20043.968 ±  265.393   ns/op
LockUnlock.testRecursiveSynchronization                N/A      N/A           N/A           100         N/A            N/A   avgt    4     121.157 ±    0.401   ns/op
LockUnlock.testSerialLockUnlock                        N/A      N/A           N/A           100         N/A            N/A   avgt    4    3188.814 ±   27.333   ns/op
LockUnlock.testSimpleLockUnlock                        N/A      N/A           N/A           100         N/A            N/A   avgt    4    3183.712 ±   15.150   ns/op
LongComparison.equalLong                               N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1086.740 ±   39.189   ns/op
LongComparison.greaterEqualLong                        N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1810.575 ±   18.363   ns/op
LongComparison.greaterEqualLongResLong                 N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2148.813 ±  291.381   ns/op
LongComparison.greaterLong                             N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1835.626 ±    4.062   ns/op
LongComparison.lessEqualLong                           N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1811.096 ±   14.189   ns/op
LongComparison.lessEqualLongResLong                    N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    2029.903 ±  199.080   ns/op
LongComparison.lessLong                                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1812.472 ±   22.008   ns/op
LongComparison.notEqualLong                            N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1010.173 ±   30.632   ns/op
LongComparison.notEqualLongResLong                     N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1590.023 ±  407.667   ns/op
PointerComparison.equalObject                          N/A      N/A           N/A           N/A         N/A            N/A   avgt    5     946.143 ±   36.054   ns/op
PointerComparison.notEqualObject                       N/A      N/A           N/A           N/A         N/A            N/A   avgt    5     954.649 ±   51.357   ns/op
PointerComparison.notEqualObjectResLong                N/A      N/A           N/A           N/A         N/A            N/A   avgt    5    1360.777 ±  371.180   ns/op
```
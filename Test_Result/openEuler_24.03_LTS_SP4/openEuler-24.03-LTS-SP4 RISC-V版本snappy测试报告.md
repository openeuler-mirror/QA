![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者           |
| ---------- | ----------- | -------- | -------------- |
| 2026-06-01 | v1.0        | 新建     | 郑紫阳，刘庆涛 |
|            |             |          |                |

关键词： 

snappy,riscv

摘要：

按照 Snappy 测试用例要求，部署 openEuler RISC-V 24.03-LTS-SP4 测试镜像环境，对 Snappy 的RPM构建、主要功能进行测试。测试结果正常，优化效果明显，完全支持 Snappy 主要功能的正常使用


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

优化snappy查找相同片段的效率，提升压缩速率

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                       | 测试起始时间 | 测试结束时间 |
| ------------------------------ | ------------ | ------------ |
| openEuler RISC-V 24.03-LTS-SP4 | 2026-06-01   | 2026-06-02   |
|                                |              |              |

描述特性测试的硬件环境信息

| 硬件型号   | 硬件配置信息 | 备注                                    |
| ---------- | ------------ | --------------------------------------- |
| QEMU虚拟机 | 无特殊配置   | 在 aarch64/x86_64 物理机上运行QEMU 测试 |
|            |              |                                         |

# 3     测试结论概述

## 3.1   测试整体结论

snappy优化查找特性，共计执行25个用例，主要覆盖了功能测试和性能测试，通过经过长稳测试，测试通过，无遗留风险，整体质量良好；

| 测试活动 | 测试子项 | 活动评价 |
| ------- | :------- | ------- |
| 功能测试 | 继承特性测试 | 测试通过 |
| DFX专项测试 | 性能测试 | 测试通过 |

## 3.2   约束说明

无

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- |
|     |         |        |         |         |         |            |
|     |         |        |         |         |         |            |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |          |      |      |      |        |
| 百分比 |          |      |      |      |        |

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 压缩 | <font color=green>■</font> |   |
| 2 | 解压缩 | <font color=blue><font color=green>■</font></font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| | | <font color=red>●</font> |   |
| | | <font color=blue>▲</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

## 不涉及结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|         |         |        |         |

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

## 4.4 资料测试结论
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                       | 测试用例数   | 用例执行结果 | 发现问题单数 |
| ------------------------------ | ------------ | ------------ | ------------ |
| openEuler RISC-V 24.03-LTS-SP4 | 24个单元测试 | pass         | 0            |
| openEuler RISC-V 24.03-LTS-SP4 | 1个性能测试  | pass         | 0            |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

```
unittest ([ PASSED ] 21 tests.)

Running main() from gmock_main.cc
[==========] Running 21 tests from 3 test suites.
[----------] Global test environment set-up.
[----------] 1 test from CorruptedTest
[ RUN      ] CorruptedTest.VerifyCorrupted
Crazy decompression lengths not checked on 64-bit build
[       OK ] CorruptedTest.VerifyCorrupted (13 ms)
[----------] 1 test from CorruptedTest (13 ms total)

[----------] 17 tests from Snappy
[ RUN      ] Snappy.SimpleTests
[       OK ] Snappy.SimpleTests (37 ms)
[ RUN      ] Snappy.AppendSelfPatternExtensionEdgeCases
[       OK ] Snappy.AppendSelfPatternExtensionEdgeCases (4 ms)
[ RUN      ] Snappy.AppendSelfPatternExtensionEdgeCasesExhaustive
[       OK ] Snappy.AppendSelfPatternExtensionEdgeCasesExhaustive (5477 ms)
[ RUN      ] Snappy.MaxBlowup
[       OK ] Snappy.MaxBlowup (32 ms)
[ DISABLED ] Snappy.DISABLED_MoreThan4GB
[ RUN      ] Snappy.RandomData
[       OK ] Snappy.RandomData (110328 ms)
[ RUN      ] Snappy.FourByteOffset
[       OK ] Snappy.FourByteOffset (3 ms)
[ RUN      ] Snappy.IOVecSourceEdgeCases
[       OK ] Snappy.IOVecSourceEdgeCases (0 ms)
[ RUN      ] Snappy.IOVecSinkEdgeCases
[       OK ] Snappy.IOVecSinkEdgeCases (0 ms)
[ RUN      ] Snappy.IOVecLiteralOverflow
[       OK ] Snappy.IOVecLiteralOverflow (0 ms)
[ RUN      ] Snappy.IOVecCopyOverflow
[       OK ] Snappy.IOVecCopyOverflow (0 ms)
[ RUN      ] Snappy.ReadPastEndOfBuffer
[       OK ] Snappy.ReadPastEndOfBuffer (0 ms)
[ RUN      ] Snappy.ZeroOffsetCopy
[       OK ] Snappy.ZeroOffsetCopy (0 ms)
[ RUN      ] Snappy.ZeroOffsetCopyValidation
[       OK ] Snappy.ZeroOffsetCopyValidation (0 ms)
[ RUN      ] Snappy.FindMatchLength
[       OK ] Snappy.FindMatchLength (0 ms)
[ RUN      ] Snappy.FindMatchLengthRandom
[       OK ] Snappy.FindMatchLengthRandom (2489 ms)
[ RUN      ] Snappy.VerifyCharTable
[       OK ] Snappy.VerifyCharTable (0 ms)
[ RUN      ] Snappy.TestBenchmarkFiles
[       OK ] Snappy.TestBenchmarkFiles (1817 ms)
[----------] 17 tests from Snappy (120191 ms total)

[----------] 3 tests from SnappyCorruption
[ RUN      ] SnappyCorruption.TruncatedVarint
[       OK ] SnappyCorruption.TruncatedVarint (0 ms)
[ RUN      ] SnappyCorruption.UnterminatedVarint
[       OK ] SnappyCorruption.UnterminatedVarint (0 ms)
[ RUN      ] SnappyCorruption.OverflowingVarint
[       OK ] SnappyCorruption.OverflowingVarint (0 ms)
[----------] 3 tests from SnappyCorruption (0 ms total)

[----------] Global test environment tear-down
[==========] 21 tests from 3 test suites ran. (120205 ms total)
**[  PASSED  ] 21 tests.**

lzbench test

| Compressor             | Compress  | Decompress | Size      | Ratio  |
| ---------------------- | --------- | ---------- | --------- | ------ |
| Snappy 1.1.10 (Before) | 15.3 MB/s | 32.5 MB/s  | 101403263 | 47.84% |
| Snappy 1.1.10 (After)  | 19.7 MB/s | 32.5 MB/s  | 101403263 | 47.84% |
```

 



 

 
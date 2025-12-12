![avatar](../../images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2025年12月10日|v1.0|ISA-L测试报告v1|董骥、刘庆涛|

关键词： ISA-L，CRC，RISC-V

摘要：按照 ISA-L 测试用例要求，部署 openEuler 24.03-LTS-SP3 测试镜像环境，对 ISA-L 的源码编译、RPM安装、二进制包安装、主要功能以及优化进行测试。测试结果良好，完全支持 ISA-L 主要功能的正常使用。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| CRC | Cyclic redundancy check | 循环冗余校验 |
| RAID | Redundant Array of Independent Disks | 独立硬盘冗余阵列 |
| EC | Erasure codes | 纠错码 |

# 1     特性概述

本测试报告为对 ISA-L 2.30.0 加入 RISC-V64 平台支持以及 CRC 计算优化后，在 openEuler 24.03-LTS-SP3 操作系统上的测试报告，目的在于跟踪测试阶段中发现的问题，总结 ISA-L 在 openEuler 24.03-LTS-SP3 操作系统中运行状况&功能特性支持的测试结果，测试的范围主要包括 ISA-L 源码编译、RPM安装、二进制包安装、主要功能及性能、稳定性等方面。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler RISC-V 24.03-LTS-SP3 | 2025年12月05日 | 2025年12月06日 |
| openEuler RISC-V 24.03-LTS-SP3 | 2025年12月08日 | 2025年12月09日 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| RISC-V64 QEMU虚拟机 | QEMU虚机打开zbc及zvbc扩展 | 在 aarch64/x86_64 物理机上运行 RISC-V64 QEMU 测试 |

# 3     测试结论概述

## 3.1   测试整体结论

ISA-L RISC-V64 支持特性，共计执行16个用例，主要覆盖了 ISA-L 加速库中 CRC，EC，RAID，IGZIP 这些功能测试发现问题已解决，回归通过，无遗留风险，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 测试通过 |
| 功能测试 | 新增特性测试 | 测试通过 |
| CRC 性能测试 | 新增特性测试 | 测试通过 |


## 3.2   约束说明

RISC-V64 CRC 计算优化特性使用需硬件开启zbc，zvbc扩展支持

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- | 
| 无 | 无 | 无 | 无 | 无 | 无 | 无 |

### 3.3.2 问题统计

#### 3.3.2.1 问题数量

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 1 | 0 | 1 | 0 | 0 |
| 百分比 | 100 | 0 | 100 | 0 | 0 |

#### 3.3.2.2 发现问题

| 序号 | 问题单号 | 问题简述 | 优先级 | 当前状态 |
| --- | ------- | ------ | ------- | ------- |
| 1 | [IDBVBW](https://gitee.com/src-openeuler/isa-l/issues/IDBVBW) | gcc升级导致iscsi校验出现错误 | 高 | 已合入 

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

不涉及

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 基础RISC-V64支持 | <font color=green>■</font> |   |
| 2 | CRC 计算性能优化 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

不涉及

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

基础实现为查表法，优化为折叠+Barrett缩减法，性能有较大提升。

### 4.3.2 可靠性/韧性测试结论

不涉及

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论

不涉及

## 4.5 其他测试结论

不涉及

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler RISC-V 24.03-LTS-SP3 | 16 | 15 PASS 1 FAIL| 1 |

## 5.2   后续测试建议

无

# 6     附件

```
PASS: raid/pq_gen_test
PASS: crc/crc16_t10dif_test
PASS: crc/crc16_t10dif_copy_test
PASS: crc/crc64_funcs_test
PASS: raid/xor_gen_test
PASS: crc/crc32_funcs_test
PASS: igzip/igzip_wrapper_hdr_test
PASS: igzip/checksum32_funcs_test
PASS: erasure_code/gf_inverse_test
PASS: erasure_code/gf_vect_mul_test
PASS: raid/xor_check_test
PASS: raid/pq_check_test
PASS: erasure_code/erasure_code_test
PASS: erasure_code/erasure_code_update_test
PASS: igzip/igzip_rand_test
PASS: mem/mem_zero_detect_test
============================================================================
Testsuite summary for libisal 2.30.0
============================================================================
# TOTAL: 16
# PASS:  16
# SKIP:  0
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
============================================================================
```
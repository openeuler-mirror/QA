![openEuler ico](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期        | 修订   版本 | 修改描述 | 作者 |
| ----       | ----------- | -------- | ---- |
| 2024/01/08 |   v1.0      | GCC for openEuler测试报告 | 纪晓慧 |

摘要：依据测试要求，对GCC for openEuler编译器进行功能测试、性能测试



# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| GCC for openEuler兼容性测试 | 2023-12-26 | 2024-01-08 |

描述兼容性测试的硬件环境信息

| OS |内核 |硬件型号 | 硬件配置信息 | 备注 |
| -------- |------| ---------------- | ------------ | ---- |
|openEuler 22.03-LTS-SP3 |5.10.0-153.8.0.86.oe2203sp2.aarch64 |Taishan 200k |96U 512G |aarch64|
|openEuler 20.03-LTS-SP4|4.19.90-2312.1.0.0255.oe2003sp4 | 虚拟机 |16U 8G | aarch64 |
|openEuler 20.03-LTS-SP3 |4.19.90-2112.8.0.0131.oe1.arrch64|虚拟机| 16U 8G | aarch64 |
|CentOS 7.6 |4.14.0-115.el7a.0.1.aarch64 | 虚拟机 | 16U 8G | aarch64 |
|Ubuntu 18.04 | Linux jvmtest-129 4.15.0-112-generic| TaiShan 200 (Model 5280)| 96U 1056G | aarch64 |
|Ubuntu 20.04 |Linux CloudCompiler-127 5.8.0-59-generic| TaiShan 200 (Model 2280) | 128U 128G | aarch64 |
|麒麟V10 |4.19.90-23.8.v2101.ky10.aarch64|虚拟机| 16U 8G | aarch64 |
|UOS 20 |4.19-2201.4.0.0135.up1.uel20.aarch64| 虚拟机 | 16U 8G | aarch64|

描述性能测试的硬件环境信息

| OS                              | 内核                                | 硬件型号                 | 硬件配置信息 | 备注             |
| ------------------------------- | ----------------------------------- | ------------------------ | ------------ | ---------------- |
| openEuler 22.03-LTS-SP3         | 5.10.0-166.0.0.79.oe2203sp3.aarch64 | TaiShan 200 (Model 2280) | 128U 512G    | SPEC2017测试环境 |
| Kylin Linux Advanced Server V10 | 4.19.90-23.8.v2101.ky10.aarch64     | TaiShan 200 (Model 5280) | 128U 512G    | CPUbench测试环境 |

# 3     测试结论概述

## 3.1   测试整体结论

GCC for openEuler编译器兼容性测试，共测试8个OS，主要覆盖基本功能测试，浮点精度测试和dejagnu测试，整体质量良好。

|测试OS| 测试活动 | 活动评价 |
| -------- | -------- | -------- |
| openEuler 22.03-LTS-SP3 | 执行测试套：dejagnu |无兼容性问题|
| openEuler 20.03-LTS-SP4 | 执行测试套：dejagnu |无兼容性问题|
| openEuler 20.03-LTS-SP3 | 执行测试套：dejagnu |无兼容性问题|
| CentOS 7.6 | 执行测试套：dejagnu |无兼容性问题|
| Ubuntu 18.04 | 执行测试套：dejagnu |无兼容性问题|
| Ubuntu 20.04 | 执行测试套：dejagnu |无兼容性问题|
| 麒麟V10 | 执行测试套：dejagnu |无兼容性问题|
| UOS20 | 执行测试套：dejagnu |无兼容性问题|
|openEuler22.03-LTS-SP3|基本功能测试：执行测试套bstest、llvmcase、Anghabench、jotai以及浮点精度测试 |无兼容性问题|

### SPEC2017 INT结果：

| Benchmarks            | Ratio |
| --------------------- | ----- |
| 500.perlbench_r       | 396   |
| 502.gcc_r             | 231   |
| 505.mcf_r             | 381   |
| 520.omnetpp_r         | 182   |
| 523.xalancbmk_r       | 329   |
| 525.x264_r            | 880   |
| 531.deepsjeng_r       | 507   |
| 541.leela_r           | 444   |
| 548.exchange2_r       | 1070  |
| 557.xz_r              | 244   |
| SPECrate2017_int_base | 401   |

### SPEC2017 FP结果：

| Benchmarks                | Ratio |
| ------------------------- | ----- |
| 503.bwaves_r              | 614   |
| 507.cactuBSSN_r           | 324   |
| 508.namd_r                | 315   |
| 510.parest_r              | 156   |
| 511.povray_r              | 510   |
| 519.lbm_r                 | 70.4  |
| 521.wrf_r                 | 258   |
| 526.blender_r             | 293   |
| 527.cam4_r                | 310   |
| 538.imagick_r             | 649   |
| 544.nab_r                 | 388   |
| 549.fotonik3d_r           | 183   |
| 554.roms_r                | 116   |
| Est. SPECrate2017_fp_base | 272   |

### CPUbench INT结果：

| Benchmark             | Result  |
| --------------------- | ------- |
| x264                  | 291.406 |
| gcc                   | 132.365 |
| gzip                  | 245.214 |
| tpcc                  | 173.074 |
| tpch                  | 163.047 |
| velvet                | 88.482  |
| openssl               | 385.942 |
| rapidjson             | 157.494 |
| python                | 180.956 |
| xz                    | 136.515 |
| IntConcurrent_Typical | 179.877 |

### CPUbench FP结果：

| Benchmark               | Result  |
| ----------------------- | ------- |
| lightgbm                | 33.969  |
| nektar                  | 135.521 |
| phenglei                | 80.438  |
| phyml                   | 118.873 |
| gromacs                 | 154.592 |
| povray                  | 198.047 |
| openfoam                | 171.227 |
| lammps                  | 118.014 |
| cube                    | 157.086 |
| wrf                     | 96.659  |
| FloatConcurrent_Typical | 115.252 |


## 3.3  问题分析
GCC for openEuler兼容性测试共发现问题单0个。

### 3.3.1 遗留问题影响以及规避措施
无

### 3.3.2 问题统计
无

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 测试活动 | 测试项 | 测试执行结果 | 发现问题单数 |   备注 |
| -------- | ---------- | ------------ | ------------ | -------- |
| 功能测试 | bstest、llvmcase、Anghabench、jotai以及浮点精度测试 | 通过 | 0 |  |
| 兼容性测试 | 8个OS的dejagnu测试 | 通过 | 0  |  |
| 性能测试 | SPECCPU2017 INT/FP、CPUbench INT/FP | 通过 | 0 | |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议


# 5     附件

*无*

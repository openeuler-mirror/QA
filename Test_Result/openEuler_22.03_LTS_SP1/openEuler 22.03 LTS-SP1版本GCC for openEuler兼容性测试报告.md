![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期        | 修订   版本 | 修改描述 | 作者 |
| ----       | ----------- | -------- | ---- |
| 2022/12/30 |   v1.0      | GCC for openEuler兼容性测试报告 | 纪晓慧 |

摘要：依据测试要求，对GCC for openEuler编译器进行兼容性测试



# 1     特性概述

GCC（GNU Compiler Collection，GNU编译器套件）是由GNU开发的编程语言器。GNU编译器套件包括C、C++、Objective-C、Fortran、java、Ada和Go语言前端，也包括了这些语言的库（如libstdc++，libgcj等。）

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| GCC for openEuler兼容性测试 | 2022-12-22 | 2022-12-30 |

描述特性测试的硬件环境信息

| OS |内核 |硬件型号 | 硬件配置信息 | 备注 |
| -------- |------| ---------------- | ------------ | ---- |
|openEuler 22.03-LTS|5.10-60.18.0.50.oe2203aarch64 | 虚拟机 |4U 8G | aarch64 |
|openEuler 20.03-LTS SP3 |4.19.90-2112.8.0.0131.oe1.arrch64|虚拟机| 4U 8G | aarch64 |
|CentOS 7.6 |4.14.0-115.el7a.0.1.aarch64 | 虚拟机 | 4U 2G | aarch64 |
|Ubuntu 18.04 | Linux jvmtest-129 4.15.0-112-generic| TaiShan 200 (Model 5280)| 96U 1056G | aarch64 |
|麒麟V10 |4.19.90-23.8.v2101.ky10.aarch64|虚拟机| 128U 128G | aarch64 |
|UOS 20 |4.19-arm64-desktop|  | 12U 16G | aarch64|
|Ubuntu 20.04 |Linux CloudCompiler-127 5.8.0-59-generic|   | 128U 128G | aarch64 |
|openEuler 21.09 |5.10.0-5.10.0.24.oe1.aarch6 4|Taishan 200k |96U 512G |aarch64,基本功能测试|


# 3     测试结论概述

## 3.1   测试整体结论

GCC for openEuler编译器兼容性测试，共测试7个OS，主要覆盖基本功能测试，浮点精度测试和dejagnu测试，发现问题3个，已修复问题1个并回归通过，遗留问题2个。

|测试OS| 测试活动 | 活动评价 |
| -------- | -------- | -------- |
| openEuler 22.03-LTS | 执行测试套：dejagnu |3个兼容性问题,[16856U](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I6856U?from=project-issue)、[1685DI](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I685DI?from=project-issue)、[1687B4](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I687B4?from=project-issue)；|
| openEuler 20.03-LTS SP3 | 执行测试套：dejagnu |3个兼容性问题,[16856U](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I6856U?from=project-issue)、[1685DI](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I685DI?from=project-issue)、[1687B4](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I687B4?from=project-issue)；|
| CentOS 7.6 | 执行测试套：dejagnu |2个兼容性问题,[1685DI](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I685DI?from=project-issue)、[1687B4](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I687B4?from=project-issue)；|
| Ubuntu 18.04 | 执行测试套：dejagnu |2个兼容性问题,[1685DI](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I685DI?from=project-issue)、[1687B4](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I687B4?from=project-issue)；|
| Ubuntu 20.04 | 执行测试套：dejagnu |2个兼容性问题,[1685DI](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I685DI?from=project-issue)、[1687B4](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I687B4?from=project-issue)；|
| 麒麟V10 | 执行测试套：dejagnu |2个兼容性问题,[1685DI](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I685DI?from=project-issue)、[1687B4](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I687B4?from=project-issue)；|
| UOS20 | 执行测试套dejagnu |2个兼容性问题,[1685DI](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I685DI?from=project-issue)、[1687B4](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I687B4?from=project-issue)；|
|openEuler21.09|基本功能测试：执行测试套dejagnu、bstest、llvmcase、Anghabench、jotai以及浮点精度测试 |3个兼容性问题,[16856U](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I6856U?from=project-issue)、[1685DI](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I685DI?from=project-issue)、[1687B4](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I687B4?from=project-issue)；|


## 3.2  约束说明

无

## 3.3  问题分析
GCC for openEuler兼容性测试共发现问题单3个，已修复问题单1个并回归通过，遗留问题单2个。

### 3.3.1 遗留问题影响以及规避措施
|序号 |问题单号 |问题简述 | 问题级别 | 问题单状态 |影响分析 |规避措施 |
| --- | ----- | ------- | --------- | ------| -------------------- | -------------------- |
|1 |[1685DI](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I685DI?from=project-issue) |-lmathlib编译运行出现core dump |主要 |已挂起 |开源问题，影响部分场景的变量精度 |删除-lmathlib选项 |
|2 |[1687B4](https://gitee.com/src-openeuler/gcc-for-openEuler/issues/I687B4?from=project-issue) |编译运行出现core dump |主要 |已挂起 |GCC for openEuler构建环境的glibc版本为2.17，没有提供__cxa_thread_atexit_impl函数，导致不能对thread_local变量按正确顺序析构。经分析，析构乱序问题不会影响程序正常运行，但是不符合C++标准，建议在高版本OS中使用规避方式规避。但注意，使用规避方式会使程序优先使用系统的库文件。|在高版本OS中(glibc2.18及以上)，设置-Wl,-rpath=/usr/lib64:{GCC_PATH}/lib64,从而优先使用系统的libstdc++.so.6.0.28、libstdc++.so.6文件|

### 3.3.2 问题统计
|  |问题总数 |严重 | 主要 | 次要 | 不重要 |
| -------- |------| ------------- | -------- | ---- |------|
|数目 |3 |0 |3 |0 |0 |
|百分比 |100% |0 |100% |0 |0 |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |   备注 |
| -------- | ---------- | ------------ | ------------ | -------- |
| GCC for openEuler兼容性测试  | 100w+ | 3个兼容性问题 | 3   |   |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议


# 5     附件

*无*

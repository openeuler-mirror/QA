![avatar](../../images/openEuler.png)

版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期      | 修订   版本 | 修改描述 | 作者   |
| --------- | ----------- | -------- | ------ |
| 2025.3.27 | v1.0        | 创建     | 刘哲晖 |

关键词： HAOC

摘要：针对 OLK-6.6 提交内核安全增强补丁，基于 ARM 处理器提供的 PAN 等硬件特性，在内核提供隔离执行环境，并对页表和其他敏感数据结构进行保护。目前，HAOC 已对 X86 架构提供支持。


缩略语清单：

| 缩略语 | 英文全名                                  | 中文解释               |
| ------ | ----------------------------------------- | ---------------------- |
| HAOC   | Hardware-assisted OS compartmentalization | 硬件辅助的操作系统隔离 |

# 1     特性概述

设计复式架构内核，为 Linux 内核提供进一步的隔离能力，从而阻止攻击者实施横向移动和权限提升。HAOC 3.0 同时支持ARM和X86，一共提供 8 个安全选项：

1. CONFIG_IEE，提供中枢核心支持
2. CONFIG_IEE_SIP，提供内核特权指令保护
3. CONFIG_IEE_PTR，提供中枢核心敏感指针保护
4. CONFIG_PTP，提供强页表防护，包括代码和只读数据DEP等
5. CONFIG_CREDP，提供进程和文件凭证安全存储与更新
6. CONFIG_SELINUXP，提供SELINUX访问控制机制的策略防护
7. CONFIG_KEYP，提供系统密钥防护
8. CONFIG_KOI，提供内核扩展KO的隔离框架



# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| openEuler-25.03-rc5 | 2025/3/22    | 2024/3/29    |

描述特性测试的硬件环境信息

| 硬件型号               | 硬件配置信息                                                 | 备注 |
| ---------------------- | ------------------------------------------------------------ | ---- |
| 鲲鹏 920 服务器        | 64c*2 2.6Ghz，1t内存，1.92t固态*4，2g raid卡，双电900w |      |
| H3C UniServer R4900 G5 | Intel(R) Xeon(R) Gold 5320 CPU @ 2.20GHz * 2, 内存 32GB *8   |      |

# 3     测试结论概述

## 3.1   测试整体结论

基于 openEuler-25.03 版本的 HAOC 特性操作系统内核，针对其功能，特性和性能进行共计 5 项测试，整体质量良好。

| 测试活动 | 测试子项                                            | 活动评价 |
| -------- | --------------------------------------------------- | -------- |
| 功能测试 | mugen  AT 测试套 （共计 270 个测试用例）            | 测试通过 |
| 功能测试 | mugen smoke-basic-os 测试套 （共计 280 个测试用例） | 测试通过 |
| 功能测试 | mugen LTP 测试套（共计 2230 个测试用例）            | 测试通过 |
| 特性测试 | 注入 CVE 进行安全测试                               | 测试通过 |
| 性能测试 | Lmbench、UNIX Bench、Netperf 和 Stream              | 测试通过 |



# 4 详细测试结论

## 4.1 功能测试
共计使用 Mugen 框架执行 AT, smoke-basic-os, LTP 测试用例，整体质量良好。其中 :

- AT 共执行测试用例 4 个，通过 4 个，失败 0 个，跳过 0 个。
- smoke-basic-os 共执行测试用例 312 个，成功 289 个，失败 23 个，跳过 0 个。
- LTP 共执行测试用例 2 个，oe_test_ltp 与 oe_test_posix 均成功。



## 4.2 新增特性测试

采用注入 CVE 的方式检测当前特性提供防御机制的有效性。策略为针对 kernel 源代码进行漏洞补丁反转，并利用漏洞进行特权测试。本次共进行 CVE 测试 14 个。

| 序号 | CVE 编号       | IEE  | PTP  | CREDP | 架构类型  |
| ---- | -------------- | ---- | ---- | ----- | --------- |
| 1    | CVE-2021-31400 | ☐    | ☐    | ☑     | arm64/x86 |
| 2    | CVE-2021-3490  | ☐    | ☐    | ☑     | arm64/x86 |
| 3    | CVE-2022-23222 | ☐    | ☐    | ☑     | arm64/x86 |
| 4    | CVE-2022-34918 | ☑    | ☑    | ☐     | arm64/x86 |
| 5    | CVE-2022-0185  | ☐    | ☐    | ☑     | x86       |
| 6    | CVE-2021-34866 | ☐    | ☐    | ☑     | arm64/x86 |
| 7    | CVE-2021-22555 | ☐    | ☐    | ☑     | x86       |
| 8    | CVE-2020-29661 | ☑    | ☑    | ☐     | arm64/x86 |
| 9    | CVE-2021-41073 | ☐    | ☐    | ☑     | arm64/x86 |
| 10   | CVE-2020-27194 | ☐    | ☐    | ☑     | arm64/x86 |

综上，特性质量评估如下：

| 特性名称 | 特性质量评估 | 备注 |
| ----------- | :--------: | --- |
| CONFIG_IEE | <font color=green>■</font> |   |
| CONFIG_IEE_SIP | <font color=green>■</font> |   |
| CONFIG_IEE_PTR | <font color=green>■</font> | |
| CONFIG_PTP | <font color=green>■</font> | |
| CONFIG_CREDP | <font color=green>■</font> | |
| CONFIG_SELINUXP | <font color=green>■</font> | |
| CONFIG_KEYP | <font color=green>■</font> | |
| CONFIG_KOI | <font color=green>■</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好
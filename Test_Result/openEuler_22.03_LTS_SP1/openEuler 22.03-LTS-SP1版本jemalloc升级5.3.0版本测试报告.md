![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2023-03-13|1|初稿|马文烁|

关键词：

openEuler:jemalloc-5.3.0

摘要：

文本主要描述 jemalloc-5.3.0 在 openEuler 22.03-LTS x86 和 aarch64 操作系统上的整体测试过程，详细叙述测试覆盖情况，并通过问题分析对版本整体质量进行评估和总结。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| LTS |long time support|长时间维护|

# 1     特性概述

jemalloc 作为新一代内存分配器。它是一个通用的 malloc 实现，侧重于减少内存碎片和提升高并发场景下内存的分配效率。

当前openEuler 22.03-LTS 对应的jemalloc版本为5.2.1，但jemalloc官网已发布最新稳定版本5.3.0。该版本相较于5.2.1在性能和内存占用上均有所提升，同时也提高内存回收速度。

[openEuler 22.03-LTS-SP1 jemalloc升级pr](https://gitee.com/src-openeuler/jemalloc/pulls/30)

[jemalloc5.3.0 release](https://github.com/jemalloc/jemalloc/releases/tag/5.3.0)

[jemalloc5.3.0 changelog](https://github.com/jemalloc/jemalloc/blob/5.3.0/ChangeLog)

[openEuler:jemalloc 升级分析](https://gitee.com/src-openeuler/jemalloc/pulls/28)

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| jemalloc-5.3.0 | 2023-03-8  | 2023-03-10 |
| jemalloc-5.3.0 | 2023-03-10  | 2023-03-14 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| x86-64 | NA | NA |
| aarch64 | NA | NA |

# 3     测试结论概述

## 3.1   测试整体结论

jemalloc-5.3.0版本整体测试情况，基本功能测试用例共计1135个，主要覆盖API测试及基本功能测试。失败用例个数0，无遗留问题，整体质量良好。性能测试压测用例共计12个，主要包括小内存申请与释放，大内存申请与释放。失败用例个数为0，整体测试结果，相较于5.2.1，耗时更少，性能有较明显提升。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 |测试用例均通过|
| 功能测试 | 新增特性测试 |测试用例均通过|
| 兼容性测试 | 动态库依赖 |无变更|
| 兼容性测试 | rpm包ABI |仅版本号变更，无兼容性问题|
| 兼容性测试 | 头文件对外接口 |仅版本号变更，无兼容性问题|
| DFX专项测试 | 性能测试 |测试用例通过，性能提升12%~19%|
| DFX专项测试 | 可靠性/韧性测试 | redis压力测试结果，无差异 |
| DFX专项测试 | 安全测试 |测试通过|
| 资料测试 | /  |jemalloc不涉及新增资料|
| 其他测试 | / | / |

## 3.2   约束说明

无

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 0 |      |      |      |        |
| 百分比 | 0 |      |      |      |        |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | jemalloc/malloc | <font color=green>■</font> |   |
| 2 | jemalloc/free | <font color=green>■</font> |   |
| 3 | jemalloc/realloc | <font color=green>■</font> |   |
| 4 | jemalloc/mallctl | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | jemalloc/malloc | <font color=green>■</font> |   |
| 2 | jemalloc/free | <font color=green>■</font> |   |
| 3 | jemalloc/realloc | <font color=green>■</font> |   |
| 4 | jemalloc/mallctl | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

兼容性测试，主要排查动态依赖库变更、rpm的ABI变更、以及头文件变更情况，jemalloc新版本无动态依赖库的变更，rpm的ABI也无变更，唯一变更点是软件版本号，无兼容性问题。

|测试项|对比结果|
| ------- | ------- |
|动态依赖库|未变更|
|ABI|未变更|
|头文件|未变更|

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|业务指标|申请内存响应时间|17.34ns|jemalloc5.3.0 平均耗时为15.11ns，耗时更少 |
|业务指标|释放内存响应时间|17.44ns|jemalloc5.3.0 平均耗时为15.09ns，耗时更少 |
|业务指标|ops|80000|基于jemalloc5.3.0的redis，与指标项持平 |
|资源指标|内存占用|284MB|基于jemalloc5.3.0的redis，与指标项持平 |

### 4.3.2 可靠性/韧性测试结论

jemalloc为基础软件库，非服务类软件。采用基于jemalloc的开源软件redis进行压测。压测结果与旧版本持平。测试统计见6.3章节

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|可靠性|基于数据类型压测| ops结果与旧版本持平 |

### 4.3.3 安全测试结论

针对jemalloc进行二进制包文件扫描。
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 开源软件漏洞检查 | 漏洞扫描 | 问题个数0 |
| 开源软件漏洞检查 | 漏洞级别 | 问题个数0 |
| 开源软件编译选项检查 | 安全编译项 | 问题个数0 |
| 开源软件配置项检查接口 | 鉴权会话管理 | 问题个数0 |
|关键信息泄露检查|弱口令|问题个数0|
|关键信息泄露检查|硬编码密码|问题个数0|
|关键信息泄露检查|硬编码密钥|问题个数0|
|关键信息泄露检查|url|问题个数0|
|关键信息泄露检查|ip地址|问题个数0|
|关键信息泄露检查|email|问题个数0|
|经典代码问题检查|不安全函数检查|问题个数0|
|经典代码问题检查|安全函数检查|问题个数0|
|经典代码问题检查|自定义风险函数检查|问题个数0|
|经典代码问题检查|自定义安全函数检查|问题个数0|

## 4.4 资料测试结论
无，jemalloc新版本无新增资料。
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|/|/|/|

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|/|/|/|

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| jemalloc-5.3.0 | 基本功能测试679 | 通过679，跳过0，失败0 | 0 |
| jemalloc-5.3.0 | 集成测试438 | 通过438，跳过0，失败0 | 0 |
| jemalloc-5.3.0 | 性能压力测试15 | 通过15，跳过0，失败0 | 0 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

## 6.1   jemalloc 基本功能测试结果
|测试套|通过|跳过|失败|
| ------- | ------- | ------ | ------ |
|unit|75|0|0|
|integration|17|0|0|
|stress|6|0|0|15|


=== test/unit === Test suite summary: pass: 75/75, skip: 0/75, fail: 0/75

=== test/integration === Test suite summary: pass: 17/17, skip: 0/17, fail: 0/17

=== test/stress === Test suite summary: pass: 6/6, skip: 0/6, fail: 0/6


## 6.2   采用jemalloc开源自带压测代码测试，针对每一项进行压测。
### 6.2.1   x86环境下
| 版本号 | 压测项 | 迭代次数 | 压测耗时 | 测试结论 |
| ------- | ------- | ------ | ------- | ------- |
| jemalloc-5.2.1 | malloc | 1千万次 | 1734000us | /|
| jemalloc-5.3.0 | malloc | 1千万次 | 1511000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降12.8% |
| jemalloc-5.2.1 | mallocx | 1千万次 | 1863000us | / |
| jemalloc-5.3.0 | mallocx | 1千万次 | 1508000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降19% |
| jemalloc-5.2.1 | free | 1千万次 | 1744000us | / |
| jemalloc-5.3.0 | free | 1千万次 | 1509000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降13.4% |
| jemalloc-5.2.1 | dallocx | 1千万次 | 1906000us | / |
| jemalloc-5.3.0 | dallocx | 1千万次 | 1626000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降14.6% |
| jemalloc-5.2.1 | sdallocx | 1千万次 | 1762000us | / |
| jemalloc-5.3.0 | sdallocx | 1千万次 | 886000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降49.7% |

### 6.2.2   arm环境下
| 版本号 | 压测项 | 迭代次数 | 压测耗时 | 测试结论 |
| ------- | ------- | ------ | ------- | ------- |
| jemalloc-5.2.1 | malloc | 1千万次 | 2948000us | /|
| jemalloc-5.3.0 | malloc | 1千万次 | 2348000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降20.3% |
| jemalloc-5.2.1 | mallocx | 1千万次 | 3420000us | / |
| jemalloc-5.3.0 | mallocx | 1千万次 | 3324000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降2% |
| jemalloc-5.2.1 | free | 1千万次 | 2956000us | / |
| jemalloc-5.3.0 | free | 1千万次 | 2352000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降20.4% |
| jemalloc-5.2.1 | dallocx | 1千万次 | 3104000us | / |
| jemalloc-5.3.0 | dallocx | 1千万次 | 2728000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降12.1% |
| jemalloc-5.2.1 | sdallocx | 1千万次 | 3672000us | / |
| jemalloc-5.3.0 | sdallocx | 1千万次 | 3104000us | 新版本迭代1千万次压测，最终耗时比5.2.1下降15.4% |

## 6.3   采用jemalloc自带压测代码检查内存占用
| 版本号 | 压力测试套 | rss(bytes) | virt(bytes) |
| ------- | ------- | ------ | ------ |
|jemalloc5.2.1|hookbench|2260|38472|
|jemalloc5.3.0|hookbench|2344|38656|
|jemalloc5.2.1|microbench|2120|46852|
|jemalloc5.3.0|microbench|2228|46664|


## 6.4   jemalloc兼容性测试
| rpm | old_rpm | new_rpm | ananlyse | compare_result |
| ------- | ------- | ------ | ------- | ------- |
|jemalloc-aarch64.rpm|jemalloc5.2.1|jemalloc5.3.0|header|diff（版本号变更）|
|jemalloc-devel-aarch64.rpm|jemalloc5.2.1|jemalloc5.3.0|header|diff（版本号变更）|
|jemalloc-aarch64.rpm|jemalloc5.2.1|jemalloc5.3.0|file|same|
|jemalloc-devel-aarch64.rpm|jemalloc5.2.1|jemalloc5.3.0|file|same|
|jemalloc-aarch64.rpm|jemalloc5.2.1|jemalloc5.3.0|cmd|same|
|jemalloc-devel-aarch64.rpm|jemalloc5.2.1|jemalloc5.3.0|cmd|same|
|jemalloc-aarch64.rpm|jemalloc5.2.1|jemalloc5.3.0|lib|same|
|jemalloc-aarch64.rpm|jemalloc5.2.1|jemalloc5.3.0|symbol|diff（版本号变更）|
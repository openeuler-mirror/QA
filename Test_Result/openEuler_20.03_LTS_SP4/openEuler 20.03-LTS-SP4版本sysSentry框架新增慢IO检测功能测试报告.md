![openEuler ico](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|  2024/10/12  |  v1.0           |测试报告初版          |谢守航 杨丽锦      |


关键词： sysSentry 慢IO检测功能

摘要：


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|   慢IO     | IO Fail-Slow         |    IO请求的平均服务时间超出预期      |


# 1     特性概述
   该功能主要是提升GaussDB在系统出现慢IO场景下的可靠性，当系统中存在由于磁盘故障、IO栈异常时，能够快速检测识别慢IO，能够根据操作系统sysSentry提供的慢IO时间，及时进行告警上报以及倒换，快速恢复业务，提升数据库业务的可用性。sysSentry：OS侧的慢IO检测服务，该检测服务会查询系统中IO栈各个阶段的指标数据，根据慢IO检测算法，识别是否存在慢IO，并且将慢IO事件上报给业务。本次迭代一主要是对采集模块，平均阈值模块，ai阈值模块进行功能测试，保证业务功能可以正常使用。

# 2     特性测试信息

慢IO特性测试迭代一主要进行三轮转测，同时验证ARM版本和X86版本。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 20.03_LTS_SP4  |  2024-09-14  | 2023-09-22 |
| openEuler 20.03_LTS_SP4  |  2023-09-23  | 2023-09-30 |
| openEuler 20.03_LTS_SP4  |  2023-10-08  | 2023-10-12 |


硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  物理机        |     8G 8U       |  ARM版本和X86版本  |

# 3     测试结论概述

## 3.1   测试整体结论

慢IO特性总共进行两轮转测，合计执行用例***条，主要对新增的接口、命令行、配置文件、阈值算法、日志文件进行了测试。

第一轮发现问题13个，回归通过13个，遗留问题0个。

第二轮发现问题12个，回归通过0个，遗留问题10个。

第三轮发现问题0个，回归通过6个，遗留问题4个。

整体核心功能基本可满足使用。一些比较偏的功能点跟易用性并未关注。

## 3.2   新增特性测试结论

| 序号 | 特性名称        | 特性质量评估                           | 备注 |
| ---- | --------------- | -------------------------------------- | ---- |
| 1    | sysSentry框架新增采集模块并支持内核无锁采集         | 功能正常，可正常通过内核采集磁盘IO信息      | 正常 |
| 2    | sysSentry框架支持基于ebpf采集能力          | 功能正常，可正常采集磁盘IO信息       | 正常 |
| 3    | sysSentry框架支持平均阈值慢IO检测能力 | 功能正常，可正常告警 |    正常 |
| 4    | sysSentry框架支持AI阈值慢IO检测能力 | 功能正常，可正常告警 |    正常 |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及

### 3.3.2 问题统计

| 问题单号 | 问题描述                                                     | 问题级别 | 问题影响                    | 当前状态 |
| -------- | ------------------------------------------------------------ | -------- | --------------------------- | -------- |
| https://gitee.com/src-openeuler/sysSentry/issues/IAS283   | 调用巡检任务停止接口后，回显状态有误 | 严重 | 影响业务功能   | 已验收   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAS6C5   | 当环境本身就超过10个disk，配置成default会导致配置有问题| 严重     | 影响业务功能   | 已验收   |
| https://gitee.com/src-openeuler/sysSentry/issues/IASWB3   | 配置文件存在多处需要去重  | 主要     | 影响业务功能 | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IASWJN   | 发现多处拼写错误 | 主要     | 影响业务功能          | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IASWNB   |  当配置了未存在的设备时，sentryCollector服务启动没有任何报错提示| 次要     | 影响业务功能           | 已完成  |
| https://gitee.com/src-openeuler/sysSentry/issues/IASWQ3   |avg_block_io.ini配置文件中common.disk和common.stage选项参数解析异常| 次要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IASWUI   | avg_block_io.ini配置中，1. common段的disk，stage，iotype，period_time校验行为不一致，2. algorithm段的win_size和win_threshold选项建议提供默认值| 次要     | 影响业务功能          | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IASX2A   | 配置文件中增加日志级别选项  | 次要     | 影响日志功能    | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IASXAX   | avg_block_io.ini配置文件中，不同section缺失的检验行为不一致| 主要     | 影响业务功能      | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IASXFL   | collector.conf 对于io.disk配置值大小写敏感| 次要     | 影响业务功能          | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAT5WV   | 启停sentryCollector服务，会出现栈信息的打印 | 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATCVS   | 配置文件ai_threshold_slow_io_detection.ini中多处配置未校验| 主要     | 影响业务功能           | 已完成   |
|https://gitee.com/src-openeuler/sysSentry/issues/IATGUD    | 配置文件ai_threshold_slow_io_detection中三个字段的默认值没有与设计文档保持一致| 主要     | 影响业务功能           | 已验收   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATHUJ  | 算法插件名称ai_threshold_slow_io_detection需改成ai_block_io| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATHWL  | ai检查算法缺少disk参数| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATI0P  | 平均阈值算法日志和和ai算法日志格式对齐| 主要     | 影响业务功能           | 已验收   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATJ8C  | ai算法ini文件参数有误时，调用采集接口打印错误日志的条数，1s打印几百条且无限打印| 主要     | 影响业务功能           | 已验收   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATOT7  | get_metric_value_from_io_data_dict_by_metric_name函数的返回值没有判空，导致程序崩溃| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATV7F | ai_threshold_slow_io_detection.ini配置文件中，section缺失异常未捕获| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATYAL | ai算法日志级别配置不生效| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATZAL | 启停ai_threshold_slow_io_detection插件，日志有异常报错信息
| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATZI5 | ai_threshold_slow_io_detection.ini配置中出现参数 或者 section重复时，未进行异常捕获| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAUR83?from=project-issue | 修改avg_block_io日志信息| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVABT | 【ebpf】sentryCollector服务启停，日志不合理| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVB69 | 【ebpf】collector.conf配置disk后，重启sentryCollector服务有报错| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVFKC | 采集模块新增提供一个磁盘类型的采集接口，供诊断插件查询磁盘的类型| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVFLA | 平均阈值算法的配置需要支持不同类型磁盘分别设置，提高检测准确率。| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVFLY | 【可维护性】平均阈值补充可维护性日志| 主要   | 影响业务功能  |    已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVR7L | ai_block_io.ini配置项，level单独成段，增加stage，iotype配置| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVTHT?from=project-issue | ebpf采集ai阈值算法,当采集服务关闭后，日志无限打印error级别日志| 主要     | 影响业务功能           | 已验收   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAW1K5 | 平均阈值和ai阈值配置ini文件参数问题整改集合| 主要     | 影响业务功能           | 已完成   |
| https://gitee.com/src-openeuler/sysSentry/issues/IATXS7 | ai算法在bio时延很稳定的情况下，会误报告警| 主要     | 影响业务功能           | 待办的   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAU2QZ | ai阈值部分功能缺失| 主要     | 影响业务功能           | 待办的   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVD14 | 1.nvme盘延时是微秒级的，当前配置文件单位是毫秒级的；2.所有配置项都提供默认值| 主要     | 影响业务功能           | 待办的   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVFM6 | 【可维护性】AI阈值算法需要补充日志| 主要     | 影响业务功能           | 待办的   |
| https://gitee.com/src-openeuler/sysSentry/issues/IAVRCX | AI阈值算法的配置需要支持不同类型磁盘分别设置，提高检测准确率| 主要     | 影响业务功能           | 待办的   |


|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |     10     | 1 |   3   |  5  |      1  |
| 百分比 | 100% | 10% | 3% | 50% | 10% |

# 4     测试执行

## 4.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 23.09 RC2 ARM+X86 |  232  |    219PASS + 12FAIL    |        4   |
|openEuler 23.09 RC3 ARM+X86  |331    |  325PASS + 6FAIL  | 6            |
|openEuler 23.09 RC4  ARM+X86 |155 | 152PASS + 3FAIL | 0 |
|openEuler 23.09 RC5  ARM+X86 |36 | 56PASS + 0FAIL | 0 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议
1. 需关注不同权限用户使用DDE，各核心功能是否正常
2. 关注DDE对整个系统性能的影响

# 5     附件

无



 



 

 
![openEuler ico](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期      | 修订   版本 | 修改描述                | 作者   |
| --------- | ----------- | ----------------------- | ------ |
| 2023/9/25 | v1.0        | 添加syscare特性测试报告 | 刘晓波 |

关键词： syscare 容器热补丁

摘要：
在docker环境中支持syscare的补丁制作，安装和使用，实现热补丁的全功能管理。
依据测试要求，对syscare特性进行功能测试、生命周期测试以及场景联调。

缩略语清单：

| 缩略语 | 英文全名  | 中文解释 |
| ------ | ------    | -------- |
|        |           |          |

# 1     特性概述
syscare支持在docker容器环境中制作，安装，管理热补丁，扩展syscare的应用范围。

# 2     特性测试信息
本节描述被测对象的版本信息和测试的时间及测试轮次，包括以来的硬件。
| 版本名称  | 测试起始时间 | 测试结束时间 |
| --------- | ------------ | ------------ |
| rc5 | 2023/9/19   | 2023/9/22   |

描述特性测试的硬件环境信息
| 硬件型号 | 硬件配置信息  | 备注  |
| ---------| --------------| ------|
| kvm      | 无特殊配置    |       |

# 3     测试结论概述
## 3.1   测试整体结论
syscare特性，共计执行23个用例，其中13个继承用例，10个新增用例，主要覆盖了功能场景测试，同时联调验证过特性质量。未发现问题，功能质量良好。

| 测试活动     | 活动评价|
| ------------ | ------------ |
| 继承用例 | 历史特性继承测试 |
| 功能测试 | 制作，查看，应用热补丁，可正常执行生命周期操作 |
| 场景联调 | 客户场景验证，测试客户实际使用场景现状 |


## 3.2   约束说明

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|          |          |          |                    |          |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 0        | 0    | 0    | 0   |        |
| 百分比 |          | 0%   | 0%  | 0%  |        |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称  | 测试用例数 | 用例执行结果       | 发现问题单数 |
| --------- | ---------- | ------------------ | ------------ |
|  rc5  | 23        | 通过23个，失败0个 | 0            |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*


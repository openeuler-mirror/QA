![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 10月17日|  1.0.0    |  初稿     | davidhan008 |
|  11月18日 |  1.0.1 |     提交版      |   anchuanxu       |

关键词： ROS1、ROS2


摘要：
ROS作为当今主流的机器人开发中间件，已经在Ubuntu上发展了近10多年。是一款比较成熟的机器人软件开发套件，并且有ROS1和ROS2两个大的套件版本。
本特性测试文档阐述将ROS1 Noetic和ROS2 Foxy基础组件在openEuler22.03上安装过程以及相关RPM包安装方法，作为系统测试人员进行测试工作时的输入参考文档。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|  ROS   |Robot Operating System    |  机器人操作系统        |
|   RPM     |Red-Hat Package Manager|RPM软件包管理器          |
|SPEC|Specification file|配置规范文件|

# 1     特性概述

1个ROS1 Noetic 版的ROS_COMM的RPM 和1个ROS1 Foxy 版的ROS_BASE的RPM是否能够成功安装和卸载，


# 2     特性测试信息

被测对象的版本信息和测试的时间及测试轮次：

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 22.03_LTS_SP1 test round 1 | 2022-11-23   | 2022-11-29   |
| openEuler 22.03_LTS_SP1 test round 2 | 2022-12-02 | 2022-12-08 |
| openEuler 22.03_LTS_SP1 test round 3 | 2022-12-09 | 2022-12-15 |

特性测试的硬件环境信息：

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 树莓派4B | cpu 1.5GHz 4核，GPU 500 MHz, 内存4G DDR4 |      |

# 3     测试结论概述

## 3.1   测试整体结论

在树莓派4B设备上，可以在openEuler 22.03_LTS_SP1系统上成功安装ROS1 Noetic 版的ROS_COMM的RPM 和ROS1 Foxy 版的ROS_BASE的RPM。

| 测试活动 | 活动评价                                                     |
| -------- | ------------------------------------------------------------ |
| 接口测试 | 对 ROS RPM 包开展接口测试，结果符合预期。                    |
| 功能测试 | 对 ROS RPM 包功能展开安装、卸载和编译工具测试，结果符合预期。 |
| 场景测试 | 对 ROS RPM 包ROS基本指令(roscore,rostopic,rosservice,rospack,rosmsg等)展开测试，结果符合预期。 |
| 专项测试 | 对 ROS RPM 包稳定性测试，安装和卸载功能可重复，结果符合预期。 |


## 3.2   约束说明

需要在openEuler 22.03 LTS SP1系统上进行测试。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

        无

### 3.3.2 问题统计

        无


# 4     测试执行

## 4.1   测试执行统计数据
*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                             | 测试用例数 | 用例执行结果 | 发现问题单数 |
| ------------------------------------ | ---------- | ------------ | ------------ |
| openEuler 22.03 LTS SP1 test round 1 | 5          | 通过         | 0            |
| openEuler 22.03 LTS SP1 test round 2 | 5          | 通过         | 0            |
| openEuler 22.03 LTS SP1 test round 3 | 5          | 通过         | 0            |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点：

- 增加测试用例

# 5     附件

        无

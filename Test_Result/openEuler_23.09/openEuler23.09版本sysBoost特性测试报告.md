![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2023.09.20 | 初稿 | sysBoost特性测试报告 | leijifeng |
|      |             |          |      |
|      |             |          |      |

关键词：bash加速、性能

 

摘要：部署openEuler 23.09测试镜像环境，对sysboost优化后的主要功能和性能进行测试，测试结果良好。

 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

通过sysboost代码重排技术对可执行文件和动态库文件在线重排操作，优化代码与运行环境的CPU微架构的适应性, 提升程序性能。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 23.09 RC2 | 2023.09.05 | 2023.09.06 |
| openEuler 23.09 RC5 | 2023.09.21 | 2023.09.22 |
|          |              |              |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| taishan2280 v2服务器 | CPU核数：128；内存：384G、磁盘容量：1.1T |      |

# 3     测试结论概述

## 3.1   测试整体结论

sysboost特性，共计执行18个用例，主要覆盖了bash功能测试、unixbench性能测试，发现问题已解决，回归通过，无遗留风险，整体质量良好

| 测试活动 | 活动评价 |
| -------- | -------- |
| 功能测试 | bash基本功能执行用例17个，全部通过 |
| 专项测试 | 执行unixbench测试套，单核性能提升5.29%、多核性能提升6.77%，符合预期 |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|          |          |          |                    |          |
|          |          |          |                    |          |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |     2     |   0   |   1   |   1   |    0    |
| 百分比 |     100%     |   0   |   50%   |   50%   |    0    |

问题列表：
https://gitee.com/openeuler/sysboost/issues/I7YP90?from=project-issue
https://gitee.com/openeuler/sysboost/issues/I80BKF?from=project-issue

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 23.09 RC2 |      18      |       18       |       2       |
| openEuler 23.09 RC2 |      18     |              |              |
|          |            |              |              |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*
单核总分提升5.29%、多核总分提升6.77%

| 单核 | 基线 |	sysboost优化后	| 提升比例 |
| -------- | ---------- | ------------ | ------------ |
| Dhrystone 2 using register variables | 3330.35 | 3328.49 | -0.06% |
| Double-Precision Whetstone | 822.79 | 822.73 | -0.01% |
| Execl Throughput | 541.62 | 553.94 | 2.27% |
| File Copy 1024 bufsize 2000 maxblocks | 2342.2 | 2361.57 | 0.83% |
| File Copy 256 bufsize 500 maxblocks | 1716.19 | 1715.97 | -0.01% |
| File Copy 4096 bufsize 8000 maxblocks | 4080.42 | 4044.6	-0.88% |
| Pipe Throughput | 931.05 | 949.26 | 1.96% |
| Pipe-based Context Switching | 355.16 | 352.48 | -0.75% |
| Process Creation | 350.01 | 351.8 | 0.51% |
| Shell Scripts (1 concurrent) | 1301.38 | 1655.79 | 27.23% |
| Shell Scripts (8 concurrent) | 6663.09 | 8806.91 | 32.17% |
| System Call Overhead | 680.84 | 723.06 | 6.20% |
| System Benchmarks Index Score | 1263.79 |	1330.6 | 5.29% |
|          |            |              |              |
			
| 多核 | 基线 |	sysboost优化后	| 提升比例 |
| -------- | ---------- | ------------ | ------------ |
| Dhrystone 2 using register variables | 424935.27 | 423978.74 | -0.23% |
| Double-Precision Whetstone | 105261.99 | 105258.39 | 0.00% |
| Execl Throughput | 5423.27 | 5198.05 | -4.15% |
| File Copy 1024 bufsize 2000 maxblocks | 110101.83 | 105349.24 | -4.32% |
| File Copy 256 bufsize 500 maxblocks | 38549.38 | 35393.54 | -8.19% |
| File Copy 4096 bufsize 8000 maxblocks | 112879.91 | 111603.17 | -1.13% |
| Pipe Throughput | 9887.23 | 9856.84 | -0.31% |
| Pipe-based Context Switching | 5696.9 | 6827.02 | 19.84% |
| Process Creation | 4075.63 | 4021.24 | -1.33% |
| Shell Scripts (1 concurrent) | 24126.88 | 37933.26 | 57.22% |
| Shell Scripts (8 concurrent) | 23580.37 | 35737.08 | 51.55% |
| System Call Overhead | 3650.67 | 3435.48 | -5.89% |
| System Benchmarks Index Score | 24848.56 | 26531.43 | 6.77% |
|          |            |              |              |

![avatar](../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者   |
| ---------- | ----------- | -------- | ------ |
| 2023.09.12 | 1.0.0       | 初次创建 | 何江洋 |
|            |             |          |        |

 

**介绍**

[CPDS](https://gitee.com/openeuler/Cpds) (Container Problem Detect System) 容器故障检测系统，是由[北京凝思软件股份有限公司](https://gitee.com/link?target=https%3A%2F%2Fwww.linx-info.com)设计并开发的容器集群故障检测系统，该软件系统实现了对容器TOP故障、亚健康检测的监测与识别。 

**缩略语清单**：

| 缩略语 | 英文全名                        | 中文解释         |
| ------ | ------------------------------- | ---------------- |
| CPDS   | Container Problem Detect System | 容器故障检测系统 |

# 1     特性概述

**1. 采集集群信息**

在宿主机上实现节点代理，采用systemd、initv、ebpf等技术，对容器关键服务进行监控；对节点网络、内核、磁盘LVM等相关信息进行采集；对容器内的应用状态、资源消耗情况、关键系统函数执行情况、io执行状态等执行异常进行监控。

**2. 集群异常检测**

采集各节点原始数据，基于异常规则对采集的原始数据进行异常检测，提取关键信息。同时基于异常规则对采集数据进行异常检测，后将检测结果数据和原始据进行在线上传，并同步进行持久化操作。

**3. 节点、业务容器故障/亚健康诊断**

基于异常检测数据，对节点、业务容器进行故障/亚健康诊断，将分析检测结果进行持久化存储，并提供UI层进行实时、历史的诊断数据查看

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称        | 测试起始时间 | 测试结束时间 |
| --------------- | ------------ | ------------ |
| CPDS-R1.0.0 B01 | 2023.07.18   | 2023.07.24   |
| CPDS-R1.0.0 B02 | 2023.08.02   | 2023.08.04   |
| CPDS-R1.0.0 B03 | 2023.08.24   | 2023.08.28   |
| CPDS-R1.0.0 B04 | 2023.09.01   | 2023.09.04   |
| CPDS-R1.0.0 B05 | 2023.09.08   | 2023.09.11   |
| CPDS-R1.0.0 B06 | 2023.09.21   | 2023.09.22   |

描述特性测试的硬件环境信息

| 架构    | 环境   | **配置信息**                                  |
| ------- | ------ | --------------------------------------------- |
| aarch64 | 虚拟机 | CPU：4核 <br />内存：16G<br />磁盘容量：100GB |

# 3    测试结论概述

## 3.1   测试整体结论

CPDS on openEuler 23.09特性，共执行62个用例，主要覆盖了在openEuler 23.09中节点、容器故障检测的功能测试，相关问题已收敛，已通过arm64架构环境测试。 

| 测试活动 | 测试子项 | 活动评价                                                     |
| -------- | -------- | ------------------------------------------------------------ |
| 功能测试 | 62       | 对容器故障检查系统功能进行测试，发现部分问题，问题已解决，整体质量良好，风险可控 |

## 3.2 约束说明

由于当前仅适配ARM64 操作系统，因此在 ARM64 中只测试了容器故障检测系统的功能。

## 3.3 遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 | 遗留问题 |
| ------ | -------- | ---- | ---- | ---- | ------ | -------- |
| 数目   | 58       |      | 8    | 36   | 14     | 0        |
| 百分比 | 100%     |      | 13%  | 63%  | 24%    | 0%       |

相关issue链接如下：

**cpds-dashboard**相关issue：https://gitee.com/openeuler/cpds-dashboard/issues?assignee_id=&author_id=&branch=&collaborator_ids=&issue_search=&label_ids=&label_text=&milestone_id=&priority=&private_issue=&program_id=&project_id=openeuler%2Fcpds-dashboard&project_type=&scope=&single_label_id=&single_label_text=&sort=&state=closed&target_project=

**cpds-analyzer**相关issue：https://gitee.com/openeuler/cpds-analyzer/issues?assignee_id=&author_id=&branch=&collaborator_ids=&issue_search=&label_ids=&label_text=&milestone_id=&priority=&private_issue=&program_id=&project_id=openeuler%2Fcpds-analyzer&project_type=&scope=&single_label_id=&single_label_text=&sort=&state=closed&target_project=

**cpds-detector**相关issue：https://gitee.com/openeuler/cpds-detector/issues?assignee_id=&author_id=&branch=&collaborator_ids=&issue_search=&label_ids=&label_text=&milestone_id=&priority=&private_issue=&program_id=&project_id=openeuler%2Fcpds-detector&project_type=&scope=&single_label_id=&single_label_text=&sort=&state=closed&target_project=

**cpds-agent**相关issue：https://gitee.com/openeuler/cpds-agent/issues?assignee_id=&author_id=&branch=&collaborator_ids=&issue_search=&label_ids=&label_text=&milestone_id=&priority=&private_issue=&program_id=&project_id=openeuler%2Fcpds-agent&project_type=&scope=&single_label_id=&single_label_text=&sort=&state=closed&target_project=

# 4 测试执行

## 4.1 测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称        | 测试用例数 | 用例执行结果 | 发现问题单数 |
| --------------- | ---------- | ------------ | ------------ |
| CPDS-R1.0.0 B01 | 50         | 全部执行     | 36           |
| CPDS-R1.0.0 B02 | 62         | 全部执行     | 14           |
| CPDS-R1.0.0 B03 | 62         | 全部执行     | 4            |
| CPDS-R1.0.0 B04 | 38         | 全部执行     | 4            |
| CPDS-R1.0.0 B05 | 38         | 全部执行     | 0            |
| CPDS-R1.0.0 B06 | 38         | 全部执行     | 0            |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

# 5 附件

NA

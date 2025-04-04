![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期      | 修订   版本 | 修改描述                | 作者   |
| --------- | ----------- | ----------------------- | ------ |
| 2024/8/8  | v1.0        | OS需要新增与BMC间的通信通道测试报告 | 薛文珍 |

关键词： BMC通信通道

摘要：sysSentry为OS故障巡检框架，给用户提供在后台进行故障巡检的能力，通过提前发现系统中的软硬件故障（例如内存UCE）并及时通知系统运维人员处理，从而达到减少故障演变为现网事故、提升系统可靠性的目标。
依据测试要求，对OS与BMC间的通信通道进行功能测试、可靠性测试和稳定性测试。

# 1     特性概述

本特性为新增OS与与BMC间的通信通道，基于sysSentry巡检框架提供与BMC之间的通信协议接口，通过IPMI接口实现与BMC的交互。

1）	libxalarm.so库提供信息传输标准接口，各个巡检插件通过调用标准接口实现将信息从组件发送至sysSentry服务；

2）	sysSentry服务接收巡检插件发送过来的信息，并对信息进行处理后发送到用户指定的模块（如BMC）。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括以来的硬件。

| 版本名称                    | 测试起始时间 | 测试结束时间 |
| --------------------------- | ------------ | ------------ |
| openEuler-22.03-LTS-SP4     | 2024-07-20   | 2024-08-10   |

描述特性测试的硬件环境信息

| 硬件型号                  | 硬件配置信息                              | 备注                   |
| ------------------------ | ----------------------------------------- | ---------------------- |
| kunpeng 920F | NA |    物理机     |

# 3     测试结论概述

## 3.1   测试整体结论

新增执行2个用例，覆盖以下测试点：

1、构造不同的消息发送给BMC，模拟OS与BMC通信，观察是否可以正常通信；

2、使用cat-cli隔离核1后，再隔离其他核，查看是否隔离成功；

经过了测试，未发现问题，整体质量良好。

## 3.2   约束说明

1.依赖鲲鹏920F物理机

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题

### 3.3.2 问题统计

不涉及

# 4     测试执行

新增接口：cpu_alarm_report

接口说明：将cpu异常上报到sysSentry服务（巡检插件使用），该函数将用户输入的信息拼装后发送到socket文件，sysSentry会对socket文件中的信息进行解析，处理后发送到用户指定的模块（如BMC）。

测试结果：CPU隔离后开启巡检，接口可正常响应，BMC成功接收CPU隔离信息。示例如下：

1）OS隔离CPU情况：

![OS与BMC通信1](../../images/openEuler_22.03_LTS_SP4/OS与BMC通信(1).png)
            
2）BMC接收到的CPU隔离情况：

![OS与BMC通信1](../../images/openEuler_22.03_LTS_SP4/OS与BMC通信(2).png)


## 4.1   测试执行统计数据


| 版本名称                    | 测试用例数 | 用例执行结果       | 发现问题单数 |
| --------------------------- | ---------- | ------------------ | ------------ |
| openEuler-22.03-LTS-SP4     |   2        | 均成功 | 0            |
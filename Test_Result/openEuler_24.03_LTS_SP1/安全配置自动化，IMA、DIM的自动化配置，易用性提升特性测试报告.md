![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期      | 修订   版本 | 修改描述                | 作者   |
| --------- | ----------- | ----------------------- | ------ |
| 2024/12/12 | v1.0        | 安全配置自动化，IMA、DIM的自动化配置，易用性提升特性测试报告 | 王亭亭 |

关键词： 安全配置 IMA DIM

摘要：xxx
依据测试要求，对安全配置自动化，IMA、DIM的自动化配置，易用性提升特性进行功能测试、可靠性测试。

# 1     特性概述
xxx


# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括以来的硬件。

| 版本名称                    | 测试起始时间 | 测试结束时间 |
| --------------------------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP1 RC1 | 2024-11-22   | 2024-11-28   |
| openEuler-24.03-LTS-SP1 RC2 | 2024-11-29   | 2024-12-05   |
| openEuler-24.03-LTS-SP1 RC3 | 2024-12-06   | 2024-12-12   |

描述特性测试的硬件环境信息

| 硬件型号                  | 硬件配置信息                              | 备注                   |
| ------------------------ | ----------------------------------------- | ---------------------- |
| NA | NA |    物理机     |

# 3     测试结论概述

## 3.1   测试整体结论

安全配置自动化，IMA、DIM的自动化配置，易用性提示特性，新增执行35个用例，覆盖以下测试点：
1、覆盖安全配置条目各项检查的正确性测试，以及安全配置条目失败后修复的正确行测试；
2、覆盖策略配置yaml中各配置项的正常值、异常值、边界值、默认值、缺省，以及yaml文件路径异常等情况下检查脚本和配置脚本生成测试；
3、覆盖sec_conf命令--help、--gen_config、--gen_config等选项测试；
4、覆盖使用配置脚本完成dim、ima、modsign、secure boot等各项功能的配置测试，以及提示信息的正确性测试；
5、覆盖使用检查脚本完成对dim、ima、modsign、secure boot等各项功能是否配置正确测试，以及检查项的完备性测试；
6、覆盖异常场景测试：包括非uefi模式配置安全启动、使用配置脚本下载证书超时、安装包失败等情况下，验证配置工具的可靠性。

经过了测试，发现20个问题，已解决，整体质量良好。

## 3.2   约束说明

NA

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题

### 3.3.2 问题统计

| 问题总数                    | 严重 | 主要       | 次要 | 不重要 |
| -------------- | ----- | ----------- | ------- | ------------ |
| 数目 |      1     | 1    |      0      | 0 |
| 百分比 |    100%  | 100% |    0%       | 0% |

问题列表如下：
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
| https://gitee.com/openeuler/secpaver/issues/IB7KB5?from=project-issue |
|--|

|  |



# 4     测试执行

## 4.1   测试执行统计数据


| 版本名称                    | 测试用例数 | 用例执行结果       | 发现问题单数 |
| --------------------------- | ---------- | ------------------ | ------------ |
| openEuler-24.03-LTS-SP1 RC1 |   5        | 失败1个 | 1            |
| openEuler-24.03-LTS-SP1 RC2 |   5        | 均成功    | 0            |
| openEuler-24.03-LTS-SP1 RC3 |   5        | 均成功    | 0            |


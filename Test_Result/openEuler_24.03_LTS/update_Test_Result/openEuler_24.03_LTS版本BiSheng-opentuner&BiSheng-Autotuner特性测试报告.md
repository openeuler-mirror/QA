![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2024-08-30 | 1.0 | 创建 | liyunfei33 |

关键词： 
BiSheng-opentuner BiSheng-Autotune Compiler/编译器
 

摘要：

本报告主要描述基于openEuler 24.03 LTS 版本进行的BiSheng-opentuner BiSheng-Autotune软件包的基础测试，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。
 

***

# 1     特性概述

OpenTuner is a new framework for building domain-specific multi-objective program autotuners. OpenTuner supports fully customizable configuration representations, an extensible technique representation to allow for domain-specific techniques, and an easy to use interface for communicating with the tuned program. A key capability inside OpenTuner is the use of ensembles of disparate search techniques simultaneously, techniques which perform well will receive larger testing budgets and techniques which perform poorly will be disabled.

BiSheng Autotuner is a command-line tool (llvm-autotune) that enables a user to search for the optimal compiler optimization parameters for fine-grained code regions in a given program, via an iterative compilation process using BiSheng Compiler.

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，以及硬件环境信息。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 24.03 LTS | 2024-08-30  | 2024-08-30 |


描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |    
| -------- | ------------ | ---- |
| NA | NA | 物理机/虚拟机 |

# 3     测试结论概述

## 3.1   测试整体结论

共执行107测试用例，包括BiSheng-opentuner和BiSheng-Autotuner的基本功能测试，无遗留风险，整体质量良好。


## 3.2   约束说明

无

## 3.3   遗留问题分析

无遗留问题
        

### 3.3.2 问题统计

无

# 4     测试执行

## 4.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 24.03 LTS | 107 |  Pass | NA|

测试log
```
# pytest BiSheng-opentuner/tests/* -W ignore::DeprecationWarning
================================================ test session starts ================================================
platform linux -- Python 3.11.6, pytest-7.4.4, pluggy-1.4.0
rootdir: /root/bisheng-opentuner-0.8.8.1
collected 23 items                                                                                                  

tests/test_manipulator.py ...................                                                                 [ 82%]
tests/test_technique.py ....                                                                                  [100%]

================================================ 23 passed in 0.49s =================================================

# python3 -m unittest discover -s BiSheng-Autotuner/autotuner/test/ --buffer
.......sysctl: cannot stat /proc/sys/machdep/cpu/brand_string: No such file or directory
.sysctl: cannot stat /proc/sys/machdep/cpu/brand_string: No such file or directory
.sysctl: cannot stat /proc/sys/machdep/cpu/brand_string: No such file or directory
.sysctl: cannot stat /proc/sys/machdep/cpu/brand_string: No such file or directory
.sysctl: cannot stat /proc/sys/machdep/cpu/brand_string: No such file or directory
.sysctl: cannot stat /proc/sys/machdep/cpu/brand_string: No such file or directory
........................................................................
----------------------------------------------------------------------
Ran 84 tests in 164.071s

OK
```


## 4.2   后续测试建议

无

# 5     附件

无
![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期           | 修订        版本 | 修改描述           | 作者         |
| -------------- | --------------- | ------------------- | ------------ |
| 2022/09/06     |   V1.0          |      测试报告初版   | harvey-rtos  |

关键词：yocto-pseudo 测试报告 

摘要：
    本报告主要描述基于openEuler 22.03 LTS版本yocto-pseudo测试执行过程，报告对测试情况进行说明。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |

# 1     特性概述

Pseudo 是一个可以直接使用或用作LD_PRELOAD的程序，它允许这些操作成功，就好像用户确实具有系统管理员权限一样，即使他们是普通用户。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                               | 测试起始时间 | 测试结束时间 |
| -------------------------------------- | ------------ | ------------ |
| openEuler22.03 LTS update test round 1 | 2022-09-06   | 2022-09-06   |

描述特性测试的Docker环境信息

| 架构信息 | 镜像信息                        | 发布版本            |
| -------- | --------------------------------| ------------------- |
|  x86_64  | openEuler-docker.x86_64.tar.xz  | openEuler-22.03-LTS |
|  aarch64 | openEuler-docker.aarch64.tar.xz | openEuler-22.03-LTS |

# 3     测试结论概述

## 3.1   测试整体结论

   yocto-pseudo软件，共计执行19个用例，主要覆盖了功能测试，暂未发现问题，无遗留风险，整体质量良好

| 测试活动 | 活动评价            |
| -------- | ------------------- |
| 功能测试 | 共计执行19个测试用例 |

## 3.2   约束说明

NA

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

NA

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 0        | 0    | 0    | 0    | 0      |
| 百分比 | 0        | 0    | 0    | 0    | 0      |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*
*测试用例来源：*
*源码包test路径*

| 版本名称            | 测试用例数 | 用例执行结果 | 发现问题单数 |
| ------------------- | ---------- | ------------ | ------------ |
| openEuler 22.03 LTS | 19         | 通过         | 0            |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

NA

# 5     附件

开源测试用例执行结果

PASS: test-acl.sh
PASS: test-chroot.sh
PASS: test-cp-setuid.sh
PASS: test-dir-move.sh
PASS: test-env_i.sh
PASS: test-execl.sh
PASS: test-fcntl.sh
PASS: test-fstat.sh
PASS: test-openat.sh
PASS: test-pseudo_disable-fork-env_i.sh
PASS: test-pseudo_disable-fork.sh
PASS: test-pseudo_unload-fork-env_i.sh
PASS: test-pseudo_unload-fork.sh
PASS: test-reexec-chroot.sh
PASS: test-rename-fstat.sh
PASS: test-statx.sh
PASS: test-tclsh-fork.sh
PASS: test-umask.sh
PASS: test-xattr.sh
============================================================================
Testsuite summary for yocto-pseudo df1d1321fb093283485c387e3c933d2d264e509c
============================================================================
# TOTAL: 19
# PASS:  19
# SKIP:  0
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
============================================================================



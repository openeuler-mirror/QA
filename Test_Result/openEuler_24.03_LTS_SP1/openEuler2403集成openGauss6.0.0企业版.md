![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改描述 | 作者     |
| ---------- | -------- | -------- | -------- |
| 2024/12/16 | v1.0     | 创建     | lihongji |

关键词：openEuler2403、openGauss6.0.0企业版

摘要：当前openEuler中集成的openGauss版本是5.0.1轻量版，openGauss已于2024.9.30发布最新的6.0.0LTS版本，openEuler2403操作系统需要升级数据库对应版本。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |

# 1 特性概述

本次特性是将之前集成的openGauss 5.0.1轻量版替换为6.0.0企业版，完整支持openGauss内核功能、dolphin插件功能。约束及限制：不包含mot功能、om、cm等外部组件，只有纯数据库内核功能。

# 2 特性测试信息

openEuler-24.03-LTS-SP1集成openGauss6.0.0数据库进行验证，同时验证 arm 和 x86 版本。

| 版本名称                   | 测试模块       | 测试起始时间 | 测试结束时间 |
| -------------------------- | -------------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP1rc4 | openGauss6.0.0 | 2024/12/5    | 2024/12/17   |

硬件环境信息

| 硬件型号      | 硬件配置信息                                                 | 备注 |
| ------------- | ------------------------------------------------------------ | ---- |
| 虚拟机（x86） | CPU:Intel(R) Xeon(R) Gold 6278C CPU @ 2.60GHz<br/>内存：30GB<br/>硬盘：98GB<br/>OS：openEuler release 24.03 (LTS-SP1) |      |
| 虚拟机(arm)   | CPU型号： Kunpeng-920<br />内存：2GB<br />硬盘：41GB<br/>OS: openEuler release 24.03 (LTS-SP1) |      |

# 3 测试结论概述

## 3.1 测试整体结论

openGauss6.0.0在 openEuler-24.03-LTS-SP1 版本的测试阶段，主要包括功能测试，覆盖数据库系统工具、SQL功能、数据库升级、兼容B库模块(原有CI用例执行)。执行了总计11 个测试用例，发现3个问题，遗留问题0，整体质量良好。

## 3.2 约束说明

## 3.3 遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及

### 3.3.2 问题统计

| 序号 | issue号                                                      | 级别 | 问题简述                                                     | 状态   |
| ---- | ------------------------------------------------------------ | ---- | ------------------------------------------------------------ | ------ |
| 1    | [IBAAVY](https://gitee.com/src-openeuler/opengauss-server/issues/IBAAVY?from=project-issue) | 次要 | 【测试类型：工具功能】【测试版本：6.0.0】卸载后再次安装当数据目录不为空时应退出安装，提示先清理数据目录 | 已完成 |
| 2    | [IBB3VO](https://gitee.com/src-openeuler/opengauss-server/issues/IBB3VO?from=project-issue) | 次要 | 【测试类型：工具功能】【测试版本：6.0.0】兼容B无法使用show tables语法 | 待办的 |
| 3    | [IBABJY](https://gitee.com/opengauss/docs/issues/IBABJY?from=project-issue) | 次要 | 【测试类型：资料】【测试版本：6.0.0】资料补充6.0.0rpm安装    | 待回归 |

# 4 详细测试结论

## 4.1 功能测试

| 序号 | 子模块名称                                                   | 约束依赖说明               | 质量评估                   | 备注 |
| ---- | ------------------------------------------------------------ | -------------------------- | -------------------------- | ---- |
| 1    | openEuler-24.03-LTS-SP1集成openGauss6.0.0功能验证（数据库安装卸载、目录层级、初始用户名、数据库版本、环境变量、启停状态查看、插件加载状态验证） | 暂无                       | <font color=green>■</font> |      |
| 2    | openGauss数据库随操作系统升级而升级（2.1.0升级至5.0.1升级至6.0.0） | 无法直接从2.1.0升级至6.0.0 | <font color=green>■</font> |      |
| 3    | 数据库系统工具、SQL功能、数据库升级、兼容B库模块(原有CI用例执行) | 暂无                       | <font color=green>■</font> |      |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

在 x86 和arm两种架构的机器上，经过测试openEuler-24.03-LTS-SP1操作系统集成的openGauss6.0.0，正常运行。

| 序号 | 型号 | 特性质量评估               | 备注                                              |
| ---- | ---- | -------------------------- | ------------------------------------------------- |
| 1    | x86  | <font color=green>■</font> | openEuler-24.03-LTS-SP1集成openGauss6.0.0功能正常 |
| 2    | arm  | <font color=green>■</font> | openEuler-24.03-LTS-SP1集成openGauss6.0.0功能正常 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好


# 5 测试执行

## 5.1 测试执行统计数据

| 版本名称                    | 测试用例数 | 用例执行结果   | 发现问题单数 |
| --------------------------- | ---------- | -------------- | ------------ |
| openEuler 24.03-LTS-SP1 rc4 | 11         | 通过8个失败3个 | 3个          |

## 5.2 后续测试建议

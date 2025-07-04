![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期         | 修订   版本 | 修改描述            | 作者         |
| ---------- | ------- | --------------- | ---------- |
| 2025/06/30 | v 1.0.0 | 新增LLVM多版本特性测试结果 | xiongyikun |

关键词： LLVM 17/18/19

摘要：将LLVM 17/18/19版本归一化, 并基于OpenEuler 24.03 LTS SP1版本更新LLVM17/LLVM 18/LLVM 19版本支持, 本次测试范围为使用openEuler 24.03 LTS SP2版本中提供的clang和LLVM tool set 18/19组件, 进行下载/安装/更新/编译测试验证, 并在aarch64和x86_64平台测试环境分别进行功能性测试。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| --- | ---- | ---- |
| -   | -    | -    |

# 1     特性概述

openEuler 24.03 LTS SP2默认支持的LLVM版本为llvm17，LLVM17/llvm18/LLVM19版本均可通过``yum install llvm-toolset-1x*``安装, 同时和默认clang版本共存, 支持多版本安装。  

# 2     特性测试信息

本章节描述被测对象的版本信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                  | 测试起始时间     | 测试结束时间     |
| --------------------- | ---------- | ---------- |
| openEuler 24.03 测试分支  | 2025/06/14 | 2025/06/19 |
| openEuler 24.03 测试分支 | 2025/06/21 | 2025/06/25 |
| openEuler 24.03 LTS SP2       | 2025/06/28 | 2025/06/29 |

描述特性测试的硬件环境信息

| 硬件型号      | 硬件配置信息 | 备注      |
| --------- | ------ | ------- |
| 鲲鹏 920 主机 | NA     | aarch64 |
| Intel服务器  | NA     | x86_64  |

# 3     测试结论概述

## 3.1   测试整体结论

共进行三轮测试，前两轮测试执行包括: 特性包构建，全量版本验证以及目标应用（Rust）及示例应用(LUA)编译，主要测试内容包括LLVM17/18/19版本包引入对于全量版本构建没有影响、LLVM多版本包能够正常工作和使用, 第三轮测试包含以下内容, 包括功能测试和可靠性测试，共发现0个问题，已全部解决，遗留问题数0,整体质量良好。

| 测试活动 | 测试子项                        | 活动评价 |
| ---- | --------------------------- | ---- |
| 功能测试 | aarch64 / x86 安装LLVM 17     | 测试通过 |
| 功能测试 | aarch64 / x86 更新LLVM 17     | 测试通过 |
| 功能测试 | aarch64 / x86 删除LLVM 17     | 测试通过 |
| 功能测试 | aarch64 / x86 安装LLVM 18     | 测试通过 |
| 功能测试 | aarch64 / x86 更新LLVM 18     | 测试通过 |
| 功能测试 | aarch64 / x86 使用LLVM 18编译应用 | 测试通过 |
| 功能测试 | aarch64 / x86 卸载LLVM 18     | 测试通过 |
| 功能测试 | aarch64 / x86 安装LLVM 19     | 测试通过 |
| 功能测试 | aarch64 / x86 使用LLVM 19编译应用 | 测试通过 |
| 功能测试 | aarch64 / x86 卸载LLVM 19     | 测试通过 |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 aarch64 / x86 安装LLVM 17

- 测试环境: openEuler 24.03 LTS SP2 (aarch64/x86_64)

| 测试子项                      | 测试结果                          |
| ------------------------- | ----------------------------- |
| aarch64安装LLVM tool set 17 | <font color=green>PASS</font> |
| x86安装LLVM tool set 17     | <font color=green>PASS</font> |

### 4.1.3 aarch64 / x86 卸载LLVM 17

| 测试子项                      | 测试结果                          |
| ------------------------- | ----------------------------- |
| aarch64卸载LLVM tool set 17 | <font color=green>PASS</font> |
| x86卸载LLVM tool set 17     | <font color=green>PASS</font> |

### 4.1.4 aarch64 / x86 安装LLVM 18

- 测试环境: openEuler 24.03 LTS SP2 (aarch64/x86_64)

| 测试子项                      | 测试结果                          |
| ------------------------- | ----------------------------- |
| aarch64安装LLVM tool set 18 | <font color=green>PASS</font> |
| x86安装LLVM tool set 18     | <font color=green>PASS</font> |

### 4.1.5 aarch64 / x_86 更新LLVM 18

| 测试子项                      | 测试结果                          |
| ------------------------- | ----------------------------- |
| aarch64更新LLVM tool set 18 | <font color=green>PASS</font> |
| x86更新LLVM tool set 18     | <font color=green>PASS</font> |

### 4.1.6 aarch64 / x86 使用LLVM 18编译应用

| 测试子项                                  | 测试结果                          |
| ------------------------------------- | ----------------------------- |
| aarch64使用LLVM tool set 18编译rust/cargo | <font color=green>PASS</font> |
| x86使用LLVM tool set 18编译rust/cargo     | <font color=green>PASS</font> |

### 4.1.7 aarch64 / x86 卸载LLVM 18

| 测试子项                      | 测试结果                          |
| ------------------------- | ----------------------------- |
| aarch64卸载LLVM tool set 18 | <font color=green>PASS</font> |
| x86卸载LLVM tool set 18     | <font color=green>PASS</font> |

### 4.1.8 aarch64 / x86 安装LLVM 19

- 测试环境: openEuler 24.03 LTS SP2 (aarch64/x86_64)

| 测试子项                      | 测试结果                          |
| ------------------------- | ----------------------------- |
| aarch64安装LLVM tool set 19 | <font color=green>PASS</font> |
| x86安装LLVM tool set 19     | <font color=green>PASS</font> |

### 4.1.9 aarch64 / x_86 更新LLVM 19

| 测试子项                      | 测试结果                          |
| ------------------------- | ----------------------------- |
| aarch64更新LLVM tool set 19 | <font color=green>PASS</font> |
| x86更新LLVM tool set 19     | <font color=green>PASS</font> |

### 4.1.10 aarch64 / x86 LLVM 19编译应用

| 测试子项                          | 测试结果                          |
| ----------------------------- | ----------------------------- |
| aarch64 LLVM tool set 19编译LUA | <font color=green>PASS</font> |
| x86 LLVM tool set 19编译LUA     | <font color=green>PASS</font> |

### 4.1.11 aarch64 / x86 卸载LLVM 19

| 测试子项                      | 测试结果                          |
| ------------------------- | ----------------------------- |
| aarch64卸载LLVM tool set 19 | <font color=green>PASS</font> |
| x86卸载LLVM tool set 19     | <font color=green>PASS</font> |

# 5 测试执行

第三轮测试结果统计如下，

| 版本名称            | 测试用例数 | 用例执行结果  | 发现问题单数 |
| --------------- | ----- | ------- | ------ |
| openEuler 24.03 LTS SP2 | 18    | 100% 通过 | 4      |

综上，特性质量评估如下：

| 特性名称                        | 特性质量评估                     | 备注  |
| --------------------------- |:--------------------------:| --- |
| aarch64 / x86 安装LLVM 17     | <font color=green>■</font> | -   |
| aarch64 / x86 删除LLVM 17     | <font color=green>■</font> | -   |
| aarch64 / x86 安装LLVM 18     | <font color=green>■</font> | -   |
| aarch64 / x86 更新LLVM 18     | <font color=green>■</font> | -   |
| aarch64 / x86 使用LLVM 18编译应用 | <font color=green>■</font> | -   |
| aarch64 / x86 卸载LLVM 18     | <font color=green>■</font> | -   |
| aarch64 / x86 安装LLVM 19     | <font color=green>■</font> | -   |
| aarch64 / x86 使用LLVM 19编译应用 | <font color=green>■</font> | -   |
| aarch64 / x86 卸载LLVM 19     | <font color=green>■</font> | -   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

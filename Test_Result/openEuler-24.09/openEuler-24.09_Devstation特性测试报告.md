![](../../images/openEuler.png)


版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2024-10-29|v1.0|测试报告初版|邱心皓|


关键词： Devstation 开发者工作站 测试报告

摘要：这份Devstation测试报告主要涉及功能、安全和用户体验方面的测试。报告指出，大部分功能问题已经得到解决，但仍存在一些用户使用体验方面的遗留问题。此外，报告还提到了Devstation中融合了Eulercopilot的部分功能，并对其进行了功能和用户体验方面的测试。

# 1     特性概述

Devstation主要是作为开发者工作站进行开发，主要是支持高校进行openEuler教学，对于初学者而言需要桌面降低linux开发门槛。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 | 测试问题数(不止issue) |
| -------- | ------------ | ------------ | --------|
| openEuler-24.09第一轮测试 | 2024-09-13 | 2024-09-30 | 31 |
| openEuler-24.09第二轮测试 | 2024-10-08 | 2024-10-15 | 16 |
| openEuler-24.09第二轮测试 | 2024-10-16 | 2024-10-31 | 4 |

描述特性测试的硬件环境信息

| 硬件 | 虚拟机平台 | 备注 |
| -------- | ------------ | ---- |
| 个人PC | Hyper-V | x86_64 |
| 个人PC | VMware workstation | x86_64 |
| 鲲鹏服务器 | qemu | aarch64 |

# 3     测试结论概述

## 3.1   测试整体结论

【DevStation】开发者工作站支持，共计执行109个用例，主要覆盖了功能测试、安全测试和其他测试，发现问题大部分已解决，回归通过，有部分遗留问题到11-15解决，整体基本可用，遗留少量问题；

## 3.2   约束说明

N/A

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 影响分析 | 措施 | 
| --- | ------- | ------ | ------- | ------- | 
| 1 | https://gitee.com/src-openeuler/calamares/issues/IAXQXG?from=project-issue | 安装时语言是中文，但地区选择仍然是英文 | 用户体验问题 | 后续解决 |
| 2 | https://gitee.com/src-openeuler/calamares/issues/IAXVTV?from=project-issue | 安装时在用户设置界面不显示光标 | 用户体验问题 | 后续解决 | 
| 3 | https://gitee.com/src-openeuler/calamares/issues/IAXVVP?from=project-issue | 安装时可以添加一个查看具体密码的选项 | 用户体验问题 | 后续解决 | 
| 4 | https://gitee.com/src-openeuler/calamares/issues/IB0D96?from=project-issue | 不询问密码自动登录选项好像没生效 | 用户体验问题 | 后续解决 | 
| 5 | https://gitee.com/src-openeuler/calamares/issues/IB0D9T?from=project-issue | 切换root用户之后为什么开头不显示root名字  | 用户体验问题 | 后续解决 | 
| 6 | https://gitee.com/src-openeuler/calamares/issues/IB0MME?from=project-issue | 默认加入中文输入法  | 用户体验问题 | 后续解决 | 
| 7 | https://gitee.com/src-openeuler/calamares/issues/IB0D9T?from=project-issue | 切换root用户之后为什么开头不显示root名字  | 用户体验问题 | 后续解决 | 
| 8 | https://gitee.com/src-openeuler/calamares/issues/IB0N7P?from=project-issue | eulercopilot设置API Key增加显示明文选项 | 用户体验问题 | 后续解决 | 
| 9 | https://gitee.com/src-openeuler/calamares/issues/IB0N9J?from=project-issue | eulercopilot-cli配置错误API KEY之后，没有明确去哪里修改API KEY | 用户体验问题 | 后续解决 | 


### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 20 | 0 | 4 | 12 | 4 |
| 百分比 | 100% | 0 | 20% | 60% | 20% |

# 4 详细测试结论

## 4.1 功能测试
### 4.1.1 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | 【DevStation】采用自研安装部署替代anaconda | <font color=blue>▲</font> |   |
| 2 | 【DevStation】支持epkg和eulermaker本地开发环境 | <font color=green>■</font> |   |
| 3 | 【DevStation】支持x2openEuler | <font color=green>■</font> |   |
| 4 | 【DevStation】支持EulerCopilot | <font color=blue>▲</font> |   |
| 5 | 【DevStation】支持图形化编程环境 | <font color=green>■</font> |   |
<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 用户体验测试 | Devstation用户体验 | 基本可用，遗留部分问题 |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler24.09 | 109 | Pass | 18 |

## 5.2   后续测试建议

关注用户体验测试。

# 6     附件

N/A

 



 

 
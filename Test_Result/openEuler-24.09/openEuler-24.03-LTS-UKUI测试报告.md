![openEuler ico](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节          | 修改描述    |
| ---------- | -------- | ----------------- | ----------- |
| 2024/09/10 | 1.0.0    | UKUI测试报告      |  @peijiankang  |


 关键词：UKUI 

 

摘要：按照UKUI3测试用例要求，部署openEuler 24.09测试镜像环境，对UKUI的安装、主要功能进行测试。测试结果良好，基本支持UKUI主要功能的正常使用。

 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述
UKUI在openEuler 24.09操作系统上做了全量更新，提供了更好的用户体验和美观的设计。它包括新的主题、图标和声音方案，以及改进的窗口管理器和桌面小部件，同时提供了对系统应用的更新，如 U 盘启动器、截图工具、用户手册等，提升了用户体验和系统的稳定性。
本测试报告为UKUI在openEuler 24.09操作系统上的测试报告，目的在于跟踪测试阶段中发现的问题，总结UKUI3在硬件平台上的测试结果，测试的范围主要包括UKUI安装、UKUI各功能组件使用、UKUI各组件的稳定性等。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-24.09-RC1 | 2024年08月13日 | 2024年08月19日 |
| openEuler-24.09-RC3 | 2024年08月29日 | 2024年09月04日 |
| openEuler-24.09-RC4 | 2024年09月05日 | 2024年09月11日 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  aarch64 | 长城擎天服务器<br>DF723 | CPU型号：FT2000+<br>CPU核数：64<br>内存：64G<br>硬盘容量：240G | 1    |
|  x86_64  | 联想启天台式机<br>M425-N000 | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz<br>CPU内核总数：6<br>内存容量：16G | 1    | 

# 3     测试结论概述

## 3.1   测试整体结论

测试结论总结
软件总体评估
UKUI3在openEuler 24.09测试镜像，共经过三轮测试，执行94个测试项，整体核心功能稳定正常。

重要组件测试
重要组件测试中，共执行了59个测试项，其中54个通过，5个不通过，第三轮测试已通过，0个因无该功能阻塞未测试。

系统插件测试
系统插件测试中，共执行了35个测试项，其中35个通过，0个不通过，0个因无该功能阻塞未测试。

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|          |          |          |                    |          |
|          |          |          |                    |          |

### 3.3.2 问题统计
| 问题单号 | 问题描述 | 问题级别 | 当前状态 |
| -------- | -------- | -------- | -------- |
|https://gitee.com/src-openeuler/ukui-greeter/issues/IAQ80T|安装完UKUI后，无界面|缺陷|已解决|
|https://gitee.com/src-openeuler/libkysdk-system/issues/IAQ6T3|【24.09】root用户下ukui-panel时间显示异常|缺陷|已解决|
|https://gitee.com/src-openeuler/ukui-panel/issues/IAQ6SS|【24.09】修复日历无农历|缺陷|已解决|
|https://gitee.com/src-openeuler/ukui-sidebar/issues/IAQ6R9|【24.09】侧边栏点击无反应|缺陷|已解决|
|https://gitee.com/src-openeuler/ukui-settings-daemon/issues/IAQ6QN|【24.09】点击侧边栏夜间模式有core|缺陷|已解决|


|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |   5      |  0   |  5   |  0   |   0    |
| 百分比 |  100%    |  0%  | 100% |  0%  |   0%   |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-24.09-RC1  |  94        |      94      |     1       |
| openEuler-24.09-RC3  |  94        |      94      |     4        |
| openEuler-24.09-RC4  |  94        |      94      |     0        |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 

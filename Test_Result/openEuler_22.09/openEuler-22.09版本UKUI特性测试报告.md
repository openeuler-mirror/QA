![avatar](../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2022.9.14 | V1.0 | 创建UKUI测试报告 |  |
|      |             |          |      |
|      |             |          |      |

 关键词：UKUI 测试报告

 

摘要：按照测试要求，针对openEuler-22.09测试镜像对UKUI的安装、主要功能进行测试。测试结果良好，基本支持UKUI主要功能的正常使用。

 
# 1     特性概述

本测试报告为UKUI3.0在openEuler 22.09操作系统上的测试报告，目的在于总结测试阶段发现的问题以及按版本及硬件平台测试结果，测试的范围主要包括安装、使用、稳定性等。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-22.09-RC1 | 2022年08月11日 | 2022年08月17日 | 第一轮测试 |
| openEuler-22.09-RC2 | 2022年08月23日 | 2022年08月29日 | 第二轮测试 |
| openEuler-22.09-RC3 | 2022年09月07日 | 2022年09月13日 | 第三轮回归测试 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  aarch64 | 长城擎天服务器<br>DF723 | CPU型号：FT2000+<br>CPU核数：64<br>内存：64G<br>硬盘容量：240G | 1    |
|  x86_64  | 联想启天台式机<br>M425-N000 | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz<br>CPU内核总数：6<br>内存容量：16G | 1    | 

# 3     测试结论概述

## 3.1   测试整体结论

测试结论总结
软件总体评估
UKUI3.0在openEuler-22.09测试镜像，共经过三轮测试，执行82个测试项，整体核心功能稳定正常。

重要组件测试
重要组件测试中，共执行了62个测试项，其中56个通过，6个不通过，第二轮、第三轮测试已通过，0个因无该功能阻塞未测试。

系统插件测试
系统插件测试中，共执行了20个测试项，其中16个通过，4个不通过，第二轮、第三轮测试已通过，0个因无该功能阻塞未测试。

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |


### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |   10       |  0    | 2   |  8    |  0   |
| 百分比 |  100%     |   0%   | 20% | 80% | 0% |

问题列表：
| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
| https://gitee.com/src-openeuler/ukui-control-center/issues/I5MC5B | 【2209】系统快捷键乱码 | 缺陷 |                    | 已解决 |
| https://gitee.com/src-openeuler/ukui-themes/issues/I5MIRL | 【2209】搜索 右上角在主体为经典的时候没有图标| 缺陷 |                    | 已解决 |
| https://gitee.com/src-openeuler/ukui-themes/issues/I5MOJW | 【2209】部分按钮图标不显示| 缺陷 |                    | 已解决 |
| https://gitee.com/src-openeuler/kylin-burner/issues/I5N5NJ | 【2209】kylin-burner中文乱码 | 缺陷 |                    | 已解决 |
| https://gitee.com/src-openeuler/kylin-video/issues/I5N4QW | 【2209】kylin-video打开没反应 |缺陷 |                    | 已解决 |
| https://gitee.com/src-openeuler/kylin-music/issues/I5MO9B | openEuler2209 aarch64安装kylin-music失败 | 缺陷 |                    | 已解决 |
| https://gitee.com/src-openeuler/kylin-music/issues/I5NFGX | kylin-music版本更新到1.1.2后，UKUI上kylin-music版本号和安装版本不一致 |缺陷 |                    | 已解决 |
| https://gitee.com/src-openeuler/kylin-video/issues/I5NFZ4 | kylin-video升级到3.1.3，UKUI上版本信息和实际安装的不一致 | 缺陷 |                    | 已解决 |
| https://gitee.com/src-openeuler/kylin-video/issues/I5NG1R | 主体为默认模式，关于背景为黑色，应该为白色 | 缺陷 |                    | 已解决 |
| https://gitee.com/src-openeuler/youker-assistant/issues/I5R2WW | 【2209】工具箱中“整机信息”和“硬件参数”不输出信息 | 缺陷 |                    | 已解决 |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-22.09-RC1  |  82        |      pass      |     10       |
| openEuler-22.09-RC2  |  82        |      pass      |     0        |
| openEuler-22.09-RC3  |  82        |      pass      |     0        |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 

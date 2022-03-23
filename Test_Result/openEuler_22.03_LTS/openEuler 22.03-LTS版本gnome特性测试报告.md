![avatar](../images/openEuler.png)

版权所有 © 2020  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|   2022/3/22   |      v1.0       |     Gnome测试报告     |   邓伟进   |

关键词：Gnome桌面 GUI

摘要：
按照测试要求，针对openEuler22.03-LTS测试镜像对Gnome的安装、主要功能进行测试。测试结果良好，基本支持Gnome主要功能的正常使用。
 
# 1     特性概述

本测试报告为Gnome3.38桌面在openEuler22.03-LTS操作系统上的测试报告，目的在于总结测试阶段发现的问题以及按版本及平台的测试结果，测试的范围主要包括安装、使用、稳定性等。

# 2     特性测试信息

本节描述被测对象的版本信息

桌面版本 Gnome3.38

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-22.03-rc-1 | 2022年2月18日  | 2022年2月24日  |
| openEuler-22.03-rc-2 | 2021年2月28日  | 2021年3月05日  |
| openEuler-22.03-rc-3 | 2021年3月08日  | 2021年3月11日  |
| openEuler-22.03-rc-4 | 2021年3月15日  | 2021年3月18日  |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| aarch64 | CPU核数：4<br>内存：4G<br>硬盘容量：40G  | 虚拟机 |
| x86_64  | CPU核数：4<br>内存：8G<br>硬盘容量：120G | 虚拟机 |

# 3     测试结论概述
## 3.1   测试整体结论

* 软件总体评估

Gnome3.38 在openEuler22.03-LTS版本上，共经过四轮测试，执行201个测试项，整体核心功能稳定正常。

* 重要组件测试

重要组件测试中，共执行了141个测试项，其中132个通过，9个未通过。第四轮测试后仅剩1个未通过。

* 系统插件测试

系统插件测试中，共执行了60个测试项，其中60个通过，0个未通过。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 功能接口测试 |     覆盖桌面各个主要使用场景，整体符合预期     |
| 专项测试     |     无    |

## 3.2   约束说明

* 安装文档

<https://gitee.com/openeuler/docs/blob/master/docs/zh/docs/desktop/Install_GNOME.md>

已测试验证，按照此文档可正常安装Gnome。

* 用户使用文档

<https://gitee.com/openeuler/docs/blob/master/docs/zh/docs/desktop/Gnome_userguide.md>

已测试验证。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
| https://gitee.com/src-openeuler/gnome-boxes/issues/I4WBM4?from=project-issue | gnome-boxes在aarch64架构上无法创建虚拟机 | 严重 | gnome-boxes是虚拟机管理器，无法创建虚拟机将带来不好体验。可以使用virt-manager来代替 | 挂起 |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |    1     |  1   |  0   |  0   |   0    |
| 百分比 |          | 100% |      |      |        |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|openEuler-22.03-rc-1|	201	|x86_64/aarch64失败3个，x86_64单独失败2个，aarch64单独失败2个| 7 |
|openEuler-22.03-rc-2|	201	|x86_64/aarch64失败1个(新增)，x86_64单独失败1个，aarch64单独失败1个| 3 |
|openEuler-22.03-rc-3|	201	|x86_64/aarch64失败1个(新增)，aarch64单独失败1个| 2 |
|openEuler-22.03-rc-4|	201	|aarch64单独失败1个| 1 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   问题解决统计
|issue|	描述 | 架构 | 状态 |
|-----| ---- | ---- | ---- |
|https://gitee.com/src-openeuler/gdm/issues/I4UJ8T?from=project-issue|gdm无法启动图形界面，图形界面黑屏|x86_64/aarch64|已解决|
|https://gitee.com/src-openeuler/gnome-boxes/issues/I4BXS3?from=project-issue|gnome-boxes无法在创建虚拟机，点击创建没有响应|x86_64|已解决|
|https://gitee.com/src-openeuler/gnome-music/issues/I4UTJ0?from=project-issue|gnome-music打开失败并coredump|x86_64/aarch64|已解决|
|https://gitee.com/src-openeuler/totem/issues/I4UTKT?from=project-issue|totem打开失败并coredump|x86_64/aarch64|已解决|
|https://gitee.com/src-openeuler/gnome-builder/issues/I4VPRS?from=project-issue|gnome-builder安装失败，找不到依赖devhelp-libs(aarch-64)|aarch64|已解决|
|https://gitee.com/src-openeuler/gnome-calendar/issues/I4WBX1?from=project-issue|gnome-calender从活动程序入口打开日历，正常打开和coredump交替出现|x86_64/aarch64|已解决|
|https://gitee.com/src-openeuler/totem/issues/I4BXZ9?from=project-issue|totem打开无法播放mp4视频|x86_64/aarch64|已解决|

## 4.3   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*

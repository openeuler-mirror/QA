![openEuler ico](../../images/openEuler.png)

版权所有 © 2020 openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative
Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>
了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。


修订记录

| Date 日期 | Revision Version 修订版本 | CR ID CR号 | Section Numbe 修改章节 | Change Description 修改描述 |  
| --------- | ------------------------- | ---------- | ---------------------- | --------------------------- |
|    2021/09/22       |   v1.0                        |            |                        |              创建               | 

Keywords 关键词：UKUI 测试报告

Abstract 摘要：按照测试要求，针对openEuler 21.09测试镜像对UKUI的安装、主要功能进行测试。测试结果良好，基本支持UKUI主要功能的正常使用。

# <br>概述

本测试报告为UKUI3.0在openEuler 21.09操作系统上的测试报告，目的在于总结测试阶段发现的问题以及按版本及硬件平台测试结果，测试的范围主要包括安装、使用、稳定性等。

# 测试版本说明

本测试报告适用于openEuler-21.09（arm和x86）版本操作系统，测试硬件平台如下：

| 环境    | 型号                    | 配置                                                           | 数量 |
| ------- | ----------------------- | -------------------------------------------------------------- | ---- |
| aarch64 | 长城擎天服务器<br>DF723 | CPU型号：FT2000+<br>CPU核数：64<br>内存：64G<br>硬盘容量：240G | 1    |
| x86_64 | 联想启天台式机<br>M425-N000 | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz<br>CPU内核总数：6<br>内存容量：16G | 1    |
## 测试版本信息

### 被测版本

ukui 3.0

| 版本名称 | 测试时间      | 结束时间      | 备注 |
| -------- | ------------- | ------------- | -------- |
| ukui 3.0 | 2021年08月25日 | 2021年08月31日 | 第一轮测试 |
| ukui 3.0 | 2021年09月16日 | 2021年09月22日 | 第二轮回归测试 |

# 版本概要测试结论、关键风险和规避措施

## 测试结论总结

* 软件总体评估

UKUI3.0在openEuler 21.09版本，共经过两轮测试，执行78个测试项，整体核心功能稳定正常。

* 重要组件测试

重要组件测试中，共执行了59个测试项，其中54个通过，5个不通过，第二轮测试已通过，0个因无该功能阻塞未测试。

* 系统插件测试

系统插件测试中，共执行了19个测试项，其中13个通过，6个不通过，第二轮测试已通过，0个因无该功能阻塞未测试。

# 版本详细测试结论

## 资料测试结论

* 安装文档

<https://gitee.com/openeuler/docs/blob/master/docs/zh/docs/desktop/%E5%AE%89%E8%A3%85UKUI.md>

已测试验证，按照此文档可正常安装UKUI。

* 用户使用文档

<https://gitee.com/openeuler/docs/blob/master/docs/zh/docs/desktop/UKUIuserguide.md>

已测试验证。

# 问题单统计

|缺陷所属模块包名| 描述 | Gitee链接|当前状态|
| ------------ | ------ | ---- | ------ |
| kylin-video | 21.09版本 播放视频显示缺少MPlayer/MPV插件 | https://gitee.com/src-openeuler/kylin-video/issues/I495R1 | 已解决 |
| ukui-control-center | 21.09版本 控制面板-账户-账户信息-密码时效功能异常 | https://gitee.com/src-openeuler/ukui-control-center/issues/I48FTE | 已解决 |
| ukui-control-center | 21.09版本 控制面板用户组相关功能全部失效 | https://gitee.com/src-openeuler/ukui-control-center/issues/I48CD8 | 已解决 |
| ukui-control-center | 21.09版本 控制面板在部分arm机器上无法启动 | https://gitee.com/src-openeuler/ukui-control-center/issues/I47YGO | 已解决 |
| ukui-desktop-environment | 21.09版本 系统监视器空闲率的显示不精准 | https://gitee.com/src-openeuler/ukui-system-monitor/issues/I473QK | 已解决 |
| pycharm-community | 21.09版本 pycharm安装后，UKUI桌面开始菜单未显示 | https://gitee.com/src-openeuler/pycharm-community/issues/I49H1Y | 已解决 |
| kylin-music | 21.09版本 mini按钮不显示图标 | https://gitee.com/src-openeuler/kylin-music/issues/I49FN0 | 已解决 |
| kylin-music | 21.09版本 界面未完全中文化 | https://gitee.com/src-openeuler/kylin-music/issues/I48UJR | 已解决 |
| kylin-music | 21.09版本 麒麟音乐标题栏显示异常 | https://gitee.com/src-openeuler/kylin-music/issues/I48UJF | 已解决 |
| ukui-menu | 21.09版本 kylin-music、kylin-recorder安装后开始菜单不显示图标 | https://gitee.com/src-openeuler/ukui-menu/issues/I49FKI | 已解决 |
| kylin-recorder | 21.09版本 双标题栏问题 | https://gitee.com/src-openeuler/kylin-recorder/issues/I49WQZ | 已解决 |

# 测试执行统计

| 版本名称 | 测试用例规模 | 用例执行   | 发现缺陷数 | 11       |          |     |
| -------- | ------------ | ---------- | ---------- | -------- | -------- | --- |
|          | 总用例数     | 新增用例数 | 手工执行   | 自动执行 | 自动化率 |     |
| ukui 3.0 | 78           | 11         | 78         | 0        | 0        |     |


## 测试用例执行结果统计数据

| 统计     | 总测试用例数 | 实际测试的用例数 | Passed项 | Failed项 | Blocked项 | Unavailable项 | 执行率 | 执行通过率 |
| -------- | ------------ | ---------------- | -------- | -------- | --------- | ------------- | ------ | ---------- |
| 重要组件 | 59           | 59               | 54       | 5        | 0         | 0             | 100%   | 91.5%       |
| 系统插件 | 19           | 19               | 13       | 6        | 0         | 0             | 100%   | 68.4%       |
| 总数     | 78           | 78               | 67       | 11        | 0         | 0             | 100%   | 85.9%       |

|          | 异常用例情况 | 影响分析                     | 规避措施 | 后续计划                   |
| -------- | ------------ | ---------------------------- | -------- | -------------------------- |
| 重要组件 | 5            | 第一轮测试未通过，已在第二轮测试中通过 | 无       | PR已与上游代码合，持续开发 |
| 系统插件 | 6            | 第一轮测试未通过，已在第二轮测试中通过 | 无       | PR已与上游代码合，持续开发 |

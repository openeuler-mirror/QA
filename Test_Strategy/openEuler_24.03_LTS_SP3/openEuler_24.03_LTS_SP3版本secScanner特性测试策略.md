![avatar](../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
|2025-12-03|1.0.0|  初稿        |王伟泽      |

关键词： secScanner

 
摘要：本文介绍说明了openEuler-24.03-LTS-SP3版本secScanner的测试内容和测试方法。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |


# 特性描述
secScanner是操作系统安全扫描工具，旨在为操作系统提供安全加固、漏洞扫描、rootkit入侵检测等功能。用户可以通过参数配置的定制化方式对系统进行安全方面的扫描检测，在满足系统基线安全加固的同时也可以对用户安装的软件包进行漏洞扫描，入侵检测扫描集成chkrootkit、secDetector工具。能够有效解决系统运维人员安全意识薄弱的问题，从系统安全配置、已知安全威胁，未知安全威胁三个角度为系统系统安全加固的能力。

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|28|[secScanner:操作系统安全加固组件](https://gitee.com/openeuler/release-management/issues/ID64P8?from=project-issue)|Testing|sig-security_facility|@wangweize_yewu|EPOL|secScanner|

## 特性应用场景分析
<!-- 主要描述特性的应用场景分析，指导后面场景测试的测试策略制定 -->
1. secscanner工具对系统配置进行进行检测，评估、加固。
2. secscanner工具从openEuler源中下载最新安全公告、CVE漏洞数据，对系统中的组件进行漏洞扫描。
3. secscanner工具调用secDetector工具对系统潜在内核rootkit模块进行扫描（当前openEuler不支持chkrootkit组件，仅使用secDetector扫描）。



## 与其他特性交互描述
与secDetector工具存在交互，在入侵检测功能中调用了secDetector进行rootkit扫描，调用secDetector之前需要确保secDetector已正确部署，否则可能检测失败。

## 风险项
<!-- 主要描述特性已知风险项 -->

# 特性分层策略
## 总体测试策略
- 测试目标：本次测试主要覆盖功能测试、安全测试,功能测试主要包括验证secScanner组件三个核心功能（安全加固、漏洞扫描、入侵检测）能够在openEuler系统下正常运行，安全测试主要检测组件使用权限限制、组件日志未泄露系统敏感信息。
- 时间进度：待评估
- 风险评估：NA
- 重点事项：同测试目标
- 争议事项：NA

## 功能测试
<!-- 主要描述接口级测试策略及测试设计思路 -->
| 功能描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| 安全加固 | 测试secScanner提供的系统安全加固功能 | 能够正常在openEuler系统下运行；能够检测系统的配置文件薄弱项；能够一键对其进行修复；能够一键还原到系统加固前初始状态        |      |
|漏洞扫描|测试secScanner提供的系统组件漏洞扫描功能|能够正常在openEuler系统下运行；能够一键同步社区的公告漏洞信息；能够一键进行漏洞扫描，输出系统组件漏洞信息|  |
|入侵检测|测试secScanner提供的系统入侵检测功能|能够正常在openEuler系统下运行；能够一键使用secDetector检测系统的潜在rootkit入侵|secscanner实际调用了chkrootkit和secDetector工具，chkrootkit工具不在openEuler源里，需要用户自行下载源码编译安装，本次测试仅测试secDetector工具|

## 安全测试
| 测试目标 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
|组件执行权限限制|验证secScanner只能由root权限用户执行|secScanner能够被root用户或者普通用户sudo使用；普通用户无权执行secScanner| |
|组件日志权限检查|验证secScanner记录的日志普通用户无法访问|secScanner能正常记录日志；secScanner记录的日志权限至少为600，普通用户无法访问| |


## 特性测试环境描述
- 不涉及特殊硬件

## 测试计划
<!-- 测试执行策略主要描述该轮次执行的分层策略中的测试项 -->
| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
| Test round 1 | 2025-11-27 | 2025-12-04 | 6    | secScanner全量功能测试 |      |
| Test round 2 | 2025-12-5 | 2025-12-11 | 7    | 回归测试                     |      |

## 入口标准
1.secScanner安全加固组件所有功能开发完成，基础功能验证正常。

## 出口标准
1.测试完毕，无严重问题遗留

# 附件
![avatar](../../images/openEuler.png)

版权所有 © 2020  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025-06-09 |  1.0       |   初稿       |   曹静波  |


关键词： OVAL 漏洞扫描 

摘要：本文从特性介绍、测试目标、测试内容、测试计划等说明cu-scanner漏洞OVAL格式转换测试策略。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| OVAL   |Open Vulnerability and Assessment Language | 开放漏洞评估语言 |
| CSAF   |Common Security Advisory Framework         | 通用安全公告框架 |

# 1     特性概述

cu-scanner 是一款专为网络安全领域打造的工具，其核心功能是依据操作 CVE（Common Vulnerabilities and Exposures，通用漏洞披露）与安全公告的文件或数据接口，对相关信息进行收集、整理和唯一化处理，进而快速生成 OVAL（Open Vulnerability and Assessment Language，开放漏洞评估语言）格式的 XML 文件以及 SCAF（Security Content Automation Framework，安全内容自动化框架）格式的 JSON 文件。

该工具能够帮助安全人员更高效地处理漏洞信息，为漏洞评估、安全扫描等工作提供标准化的数据支持，有助于提升网络安全防护的准确性和及时性。无论是面对大量的本地文件还是实时的数据接口，cu-scanner 都能稳定、快速地完成数据处理与格式转换，满足不同场景下的安全工作需求。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 24.04 LTS SP4 | 2026/06/02   | 2026/06/07             |



描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| RH2288H V3  | `Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz*2/内存16G*16` | 功能测试     |

# 3     测试结论概述

## 3.1   测试整体结论

cu-scanner特性，共计执行6个用例，主要覆盖了CSAF转换测试和获取OVAL文件测试，发现问题已解决，回归通过，无遗留风险，整体质量良好。


## 3.2   约束说明

- cu-scanner在使用中需要进行初始化的配置文件
- 使用之前需要预先配置好数据库
- 需要预先准备一个csaf文件的http 数据源

## 3.3   遗留问题分析

暂无。

# 4     测试执行

## 4.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| 1.0      |    6       |   通过       |   0          |





# 5     附件

测试用例

|测试场景  |前提条件   |执行步骤|  结果 |
| -------  | --------- | ------ | ----- |
| 单独csaf到oval转换   | 已安装cu-scanner | 安装后在命令行输入 `cu-scanner -f xxx.json -o xx.xml`  | 通过 |
| 配置好配置文件，确保数据保存 | 已安装cu-scanner，并配置好数据库、csaf数据源 | 启动cu-scanner服务: `systemctl start cu-scanner` | 通过 |
| 获取oval数据 | 已安装cu-scanner，数据库中已经有数据 | `curl http://127.0.0.1:8093/api/oval/get_all` |	通过 |
| 获取单个oval文件 | 已安装cu-scanner，数据库中已经有数据 | `wget http://127.0.0.1:8093/api/oval/each_file/security-oval-2025-1665.xml` 使用oscap 验证: `oscap oval eval security-oval-2025-1665.xml`|	通过|
| 按照月份获取oval文件 | 已经安装cu-scanner，数据库中有数据	| `wget http://127.0.0.1:8093/api/oval/export/monthly/2025/11` | 通过 |
| 按照系统获取oval文件 | 已经安装cu-scanner，数据库中有cuos的oval数据| `wget http://127.0.0.1:8093/api/oval/export/os/ule4` | 通过 |

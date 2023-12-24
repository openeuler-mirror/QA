![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2023-09-21     |   1.0          |    sysmaster支持虚拟机场景测试报告      |  @zhaopeng    |
|      |             |          |      |
|      |             |          |      |

 关键词：sysmaster 虚拟机场景


摘要：按照sysmaster支持范围，部署openEuler 23.09测试镜像环境，对sysmaster的安装部署、基本功能、配置项进行测试。支持sysmaster基本功能的正常使用。

 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

本测试报告为sysmaster在openEuler 23.09操作系统上的测试报告，目的在于跟踪测试阶段中发现的问题，总结sysmaster在虚拟机场景的测试结果，测试的范围主要包括sysmaster的安装部署、基本功能使用、支持部分配置项的基本配置。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-23.09-RC2 | 2023年09月04日 | 2023年09月15日 |
| openEuler-23.09-RC5 | 2023年09月22日 | 2023年09月25日 |

描述特性测试的硬件环境信息（不涉及）

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|   |  | |   |
|    |  |  |    | 

# 3     测试结论概述

## 3.1   测试整体结论

测试结论总结
软件总体评估
sysmaster在openEuler 23.09测试虚拟机场景，共经过两轮测试，执行28个测试用例，整体核心功能正常。

基本功能测试
在基本服务测试中，第一轮测试共执行了5个测试项，其中2个通过，3个不通过，第二轮测试回归不通过项，部分命令项转需求，其余单点问题回归通过。

基本配置项测试
系统插件测试中，共执行了23个测试项，其中13个通过，10个不通过，第二轮测试回归不通过项，部分配置项转需求，其余单点问题回归通过。


## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施
以下问题为当前实现差异，转需求跟踪：

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
| https://gitee.com/openeuler/sysmaster/issues/I7ZNM0?from=project-issue  |  虚拟机场景下，切换至sysmaster为1号进程的系统，手动执行挂载mount test.iso aaaa时提示挂载点不存在 | 缺陷  |  当前实现差异 | 转需求 |
| https://gitee.com/openeuler/sysmaster/issues/I7ZINU?from=project-issue  | 虚拟机场景，两个服务均配置After=为对方，启动服务返回0，应该返回非0  |  缺陷 |  当前实现差异 | 转需求|
| https://gitee.com/openeuler/sysmaster/issues/I7ZR1L?from=project-issue  | 虚拟机场景，服务1配置RequiredBy=服务2，enable服务1，启动服务2后停止服务1，服务2应该为inactive状态  |  缺陷 | 当前实现差异  |转需求|
| https://gitee.com/openeuler/sysmaster/issues/I7ZQPS?from=project-issue  | 虚拟机场景，服务1中配置WantedBy="服务2"，enable服务1，启动服务2后发现服务1未启动为inactive状态  | 缺陷  | 当前实现差异  |转需求|
| https://gitee.com/openeuler/sysmaster/issues/I7X8P4?from=project-issue  |  虚拟机场景下，lvm-activate-openeuler.service服务启动失败 |  缺陷 |  当前实现差异 |转需求|
| https://gitee.com/openeuler/sysmaster/issues/I7YXN6?from=project-issue  |  虚拟机场景，当unit触发启动限制时，服务启动失败，但是返回值却为0 | 缺陷  | 当前实现差异  |转需求|
| https://gitee.com/openeuler/sysmaster/issues/I7XLNK?from=project-issue  | 虚拟机场景，服务disable后重启环境，查询服务状态，提示服务不存在  | 缺陷  |  当前实现差异 |转需求|
| https://gitee.com/openeuler/sysmaster/issues/I7X8WU?from=project-issue  | 虚拟机场景下，hostname_setup服务的配置文件中命令/usr/lib/sysmaster/hostname_setup执行有异常回显日志  | 缺陷  | 当前实现差异  |转需求|
|https://gitee.com/openeuler/sysmaster/issues/I815BA?from=project-issue|虚拟机场景，ExecStart等执行操作没有日志记录，即使配置成=/usr/bin/echo xxx也没有记录到日志文件中|缺陷|当前实现差异|转需求|
| https://gitee.com/openeuler/sysmaster/issues/I7YSGD?from=project-issue  |  虚拟机场景下，缺少reboot.target、poweroff.target、shutdown.target等，且reboot --force可以成功执行 |  缺陷 |  当前实现差异 |转需求|
| https://gitee.com/openeuler/sysmaster/issues/I7YDBD?from=project-issue | 虚拟机场景，sctl mask命令执行成功后实际未生效  |  缺陷 |  当前实现差异 | 转需求|
| https://gitee.com/openeuler/sysmaster/issues/I7YMRO?from=project-issue  | 虚拟机场景，sctl isolate执行后报错信息不是预期结果，配置后AllowIsolate=true也不生效依旧报错  | 缺陷  | 当前实现差异  |转需求 |
| https://gitee.com/openeuler/sysmaster/issues/I7XV2K?from=project-issue  |  虚拟机场景，修改sysmaster的配置文件后执行daemon-reload无法生效，需要执行daemon-reexec才能生效，且日志中无关键操作的日志记录 | 缺陷  | 当前实现差异 |转需求|
|  https://gitee.com/openeuler/sysmaster/issues/I7ZIJA?from=project-issue |  虚拟机场景，服务删除后还能查询出来状态 | 缺陷  | 当前实现差异  |转需求|
| https://gitee.com/openeuler/sysmaster/issues/I80HDW?from=project-issue  | 虚拟机场景，配置同名的service和socket，启动后，直接stop service可以停止服务（预期不应该停止）；直接stop socket无法停止（预期应该可以停止）  | 缺陷  | 当前实现差异  |转需求|
|  https://gitee.com/openeuler/sysmaster/issues/I7ZQE9?from=project-issue | 虚拟机场景，在service文件和.service.d下的配置文件中同时配置[Install]，配置文件中的配置不生效  |  缺陷 | 当前实现差异  |转需求|

### 3.3.2 问题统计
| 问题单号 | 问题描述 | 问题级别 | 当前状态 |
| -------- | -------- | -------- | -------- |
|https://gitee.com/openeuler/sysmaster/issues/I81CTX?from=project-issue|虚拟机场景，ExecStop、ExecStopPost会出现超时（仅设置echo且未设置超时时间），ExecStartPre、ExecStartPost、ExecStop、ExecStopPost增加-忽略错误未生效|缺陷|已解决|
|https://gitee.com/openeuler/sysmaster/issues/I81AKP?from=project-issue|虚拟机场景下，TimeoutSec/TimeoutStartSec/TimeoutStopSec配置时间不生效|缺陷|已解决|
| https://gitee.com/openeuler/sysmaster/issues/I80OY6?from=project-issue  | 虚拟机场景，新启动的环境存在分区无法挂载，但是重启fstab服务可以挂载  | 缺陷  | 已解决 |
| https://gitee.com/openeuler/sysmaster/issues/I80OLQ?from=project-issue  |  虚拟机场景，配置SocketMode后socket无法启动 | 缺陷 | 非问题属配置差异  |
| https://gitee.com/openeuler/sysmaster/issues/I7ZTE5?from=project-issue  | 虚拟机场景，配置KillMode=后停止服务，与预期结果不符  |  缺陷 | 已解决  |
| https://gitee.com/openeuler/sysmaster/issues/I7ZNAQ?from=project-issue  | 虚拟机场景下，修改配置文件反复操作sctl daemon-reexec; sctl daemon-reload; sctl restart 各种服务概率性出现Failed to execute the given command: IoError，环境无法登陆  | 缺陷  | 已解决  |
| https://gitee.com/openeuler/sysmaster/issues/I7ZILX?from=project-issue  | 虚拟机场景，服务中配置Bindsto=，被依赖服务因condition失败后，服务启动应该也失败但是成功了  | 缺陷  |  已解决 |
|  https://gitee.com/openeuler/sysmaster/issues/I7ZIKO?from=project-issue |  虚拟机场景，服务中同时配置After和Requires，被依赖服务因condition失败后，服务启动应该成功，但是失败了 | 缺陷  | 已解决  |
| https://gitee.com/openeuler/sysmaster/issues/I7ZDZI?from=project-issue  |  虚拟机场景，Restart="always"后重启服务，服务最后会一直处于activating (autorestart)状态，且查看日志只有一条自动重启记录 |  缺陷 | 已解决  |
|  https://gitee.com/openeuler/sysmaster/issues/I7YRXT?from=project-issue | 虚拟机场景，支持的服务配置文件注释中包含systemd的关键字，不合理  |  缺陷 | 已解决  |
| https://gitee.com/openeuler/sysmaster/issues/I7XUL5?from=project-issue  | 虚拟机场景，不存在的服务start后可以查询到服务状态，但是实际服务不存在  |  缺陷 |  已解决 |
| https://gitee.com/openeuler/sysmaster/issues/I7X8UT?from=project-issue  | 虚拟机场景下，info级别日志打印过少，缺少关键日志记录  |  缺陷 |  已解决 |
| https://gitee.com/openeuler/sysmaster/issues/I7X8TZ?from=project-issue  | 虚拟机场景，fstab服务每重启一次，lsblk显示记录多一条  | 缺陷  |  已解决 |
| https://gitee.com/openeuler/sysmaster/issues/I7X8SI?from=project-issue | 虚拟机场景，udevd-control.socket和udevd-kernel.socket在系统启动后一直处于deactivating状态  | 缺陷  | 已解决  |
| https://gitee.com/openeuler/sysmaster/issues/I7X8H8?from=project-issue  | 虚拟机场景下启动sysmaster进入系统，lsblk查询发现单独挂载的盘未挂载  | 缺陷  | 已解决  |



|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |    31    |  1   |  9   |   21  |   0    |
| 百分比 |  100%    |  3.2%  | 29% |  67.8%  |   0%   |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-23.09-RC2  |  28        |      28      |     31        |
| openEuler-23.09-RC5  |  28        |     28     |       16      |
    *剩余16个问题已转需求*

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*
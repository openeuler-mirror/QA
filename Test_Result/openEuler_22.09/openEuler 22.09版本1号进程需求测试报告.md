![openEuler ico](../../images/openEuler.png)


版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2022年9月15日 | 初稿 |1号进程需求测试报告 | 牛叶 |

 关键词： 文件完整性保护, 商密

 

摘要：

 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |


# 1     特性概述

process1项目计划采用场景式替换的策略来逐步支持所有特性。
1号进程：兼容systemd：1号进程对外接口，与systemd的1号进程保持一致
；可靠性：1号进程使用rust来编写，避免systemd的内存泄漏和内存异常问题
1号进程crash自动恢复机制；轻量化：实现云原生场景快速启动

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 22.09 RC3 |	2022-08-24 | 2022-09-7 |


# 3     测试结论概述

## 3.1   测试整体结论

process1需求，共计执行30个用例，主要覆盖了：
1、run_with_sd模块，systemd以非2号进程运行，实现基本功能测试；
2、event模块，实现基本功能测试；3、unit_load模块，unit单元加载，配置加载；unitload的状态变迁；4、plugin模块，支持动态加载component动态库；5、Job模块，unit job事务管理；6、manager模块cgroup进程跟踪；7、unit模块，测试DefaultDependecies，Description，Documentation，Wants，Requires，dropin，fragment，Before，After，Conflicts，ConditionFileNotEmpty，ConditionNeedsUpdate，ConditionPathExists，OnFailureJobMode参数；8、Install模块RequiredBy，Also，DefaultInstance；9、Service模块服务拉起的方式，目前支持四种类型，simple(默认值)/forking/oneshot/notify，RemainAfterExit，PIDFIle，Environment，Sockets，NotifyAccessExecCondition/ExecStart/ExecStartPre/ExecStartPost/ExecStop/ExecStopPost，ExecStartPre/ExecStartChown/ExecStartPost/ExecStopPre/ExecStopPost，ListenStream，ListenDatagram，ListenNetlink，ReceiveBuffer 、SendBuffer，PassPacketInfo，PassCredentials，PassSecurity，Accept，SocketMode，Service；10、target模块；11、mount监控系统挂载点变化；12、fstab模块解析/etc/fstab文件，并挂载相关目录；13、random-seed模块加载和保存随机数种子；14、rc-local-generator模块；15、pctrl模块命令行管理工具；

综上，覆盖功能测试，性能测试，整体质量良好。

## 3.2   约束说明

基于系统容器构造process1， 即是要求OS基座提供多服务的管理能力，接近以虚拟机的方式来使用容器，好处是host与container保持一套代码， 要求具备一些底层的能力， 如具备网络配置， 多分区管理，sshd远程登录等系统服务能力


## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
| |  |  |  |  |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 已解决 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |  15 | 3 | 10 | 2 | 15 |
| 百分比 |  100%  | 30% | 50% | 20% |   100%   |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |解决问题单数 |剩余问题单数 |
| -------- | ---------- | ------------ | ------------ |------------ |------------ |
| openEuler 22.09 RC1 |  30  |  失败15个 |  15个   | 15个 | 0个 |
| openEuler 22.09 RC2 |  30  |  失败0个 |  0个   | 0个 | 0个 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

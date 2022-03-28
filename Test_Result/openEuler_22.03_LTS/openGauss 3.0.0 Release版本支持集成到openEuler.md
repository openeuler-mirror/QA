![avatar](../images/openGauss.png)

版权所有 © 2021  openGauss社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2022-3-12     |     1.0     |   特性测试报告初稿   | wan005 |
| 2022-3-14 | 1.1 | 针对测试环境进行对应章节的刷新 | wan005 |
|      |             |          |      |

关键词：

openGauss 3.0.0；openEuler release 22.03(LTS)；集成

摘要：

​		针对openGauss 3.0.0默认集成到openEule release 22.03(LTS)操作系统的ISO镜像这一特性展开测试，在openEuler系统上，简化openGauss编译流程，去除了openGauss厚重的三方库。openGauss构建为rpm包，集成到openEuler操作系统中，使用yum一键安装，默认启动数据库。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述
​		该特性实现了将openGauss打包到openEuler系统的ISO镜像中，通过yum方式一键安装，提升openGauss的易用性。在openEuler上支持轻量化的编译，不用再依赖独立的三方库二进制文件，绝大部分三方库可以适配操作系统自带版本。

# 2     特性测试信息

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openGauss 3.0.0 Release RC2 | 2022-1-27    | 2022-1-30    |
| openGauss 3.0.0 Release RC3 | 2022-2-10    | 2022-2-16    |
| openGauss 3.0.0 Release RC4 | 2022-2-17    | 2022-2-19    |
| openGauss 3.0.0 Release RC5 | 2022-2-20    | 2022-2-27    |

**硬件环境**

| 硬件型号                                 | 硬件配置信息                                                 | 备注 |
| ---------------------------------------- | ------------------------------------------------------------ | ---- |
| X86服务器：<br/>OpenStack Nova           | CPU: 4 Intel(R) Xeon(R) Gold 6161 CPU @ 2.20Ghz<br>内存: 30G<br>硬盘: 普通云盘 100G<br>OS:  openEuler release 22.03(LTS) |      |
| ARM服务器：<br/>Taishan 200 (Model 2280) | CPU: Kupeng 920-4826<br>内存: 249G<br>硬盘:  NVME 1T<br>OS:  openEuler release 22.03(LTS) |      |

**软件环境**

| 操作系统               | 数据库           | 备注 |
| ---------------------- |--------------------------------- | ---- |
| openEuler release 22.03(LTS) | openGauss 3.0.0 ||


# 3     测试结论概述

## 3.1   测试整体结论

​		openGauss 3.0.0在openEuler 22.03上测试了4轮，执行28423个测试用例，5个测试套（接入层、SQL层、存储层、高可用和安全特性测试套），发现问题6个已解决，回归通过，无遗留风险，整体质量良好。

## 3.2   约束说明

1.RPM包安装为单机实例数据库；

2.不支持灰度升级；

3.支持ARM和X86_64两种架构；

4.只包含内核能力，不支持OM工具。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无
### 3.3.2 问题统计
|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 6        | 3    | 3    | 0    | 0      |
| 百分比 |          | 50%  | 50%  | 0%   | 0%     |

# 4     测试执行

## 4.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openGauss 3.0.0 Release RC2  |3  | Passed: 3  Failed: 0 |  0  |
| openGauss 3.0.0 Release RC3  |11  | Passed: 9  Failed: 2 |  2   |
| openGauss 3.0.0 Release RC4  |14  | Passed: 12  Failed: 1 |  1  |
| openGauss 3.0.0 Release RC5  |28395  | Passed: 28392  Failed: 3 |  3  |

​		openGauss 3.0.0 Release RC2版本测试，测试环境为X86+openEuler，重点关注安装操作系统过程中选择安装openGauss数据库软件，操作系统安装完成后数据库能否正常运行，执行测试用例3个，发现问题数0个；openGauss 3.0.0 Release RC3版本测试，测试环境为X86+openEuler，重点关注基本功能是否可用，执行测试用例11个，发现问题数2个；openGauss 3.0.0 Release RC4版本测试，测试环境为ARM+openEuler，重点关注基本功能是否可用，执行测试用例14个，发现问题数1个；openGauss 3.0.0 Release RC5版本测试，测试环境为ARM+openEuler、X86+openEuler，重点进行可靠性测试、自动化用例连跑，执行测试用例28395个，发现问题数3个。

## 4.2   后续测试建议

在后续测试中关注以下几点：

1.默认端口被占用后，yum方式安装数据库失败，提示端口已被占用；

2.系统环境中已存在opengauss用户时，yum方式安装数据库成功，opengauss用户为数据库的初始用户；

3.yum方式安装数据库，执行gs_ctl stop、gs_ctl start停止、启动数据库后通过yum方式卸载数据库，数据库卸载干净，进程无残留；

4.升级测试。

# 5     附件

无


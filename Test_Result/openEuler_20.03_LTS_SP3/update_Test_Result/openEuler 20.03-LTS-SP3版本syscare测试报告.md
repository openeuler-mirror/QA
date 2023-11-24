![avatar](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者   |
| ---------- | ----------- | -------- | ------ |
| 2023-11-23 | 1.0         | 创建     | 林孟孟 |

 关键词： syscare 补丁管理工具 用户态补丁

 

摘要：
syscare特性针对DPU客户诉求，提供一键式集成用户态和内核态热补丁编译以及补丁生命周期管理工具，针对该特性进行功能、可靠性、长稳、并发等测试活动。本文对20.03-LTS-SP3 update版本（用于合入syscare支持DPU热补丁特性）的测试过程进行记录说明，并给出测试评估与总结。
本报告主要基于**openEuler 20.03-LTS-SP3**版本。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |

# 1     特性概述

特性主要分为两个功能：热补丁制作与热补丁管理。

## 1.1 热补丁制作

​	本次交付内核态热补丁制作和用户态热补丁制作。重点测试用户态热补丁的制作，基于源码包src.rpm、debuginfo包加patch的方式制作出热补丁包。热补丁包制作完成之后，使用RPM包方式进行安装，卸载等操作。

## 1.2 热补丁管理

​	提供综合的热补丁管理框架统一管理所有热补丁，提供补丁激活、补丁去激活、补丁接受，补丁状态保存与恢复，补丁冲突检测，补丁覆盖，补丁状态信息查询等功能。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本信息                   | 测试起始时间 | 测试结束时间 |测试活动|
| --------------------------- | ------------ | ------------ |------------ |
| openEuler 20.03-LTS-SP3     | 2023-11-04   | 2023-11-11   |   功能、SDV测试|
| openEuler 20.03-LTS-SP3     | 2023-11-11   | 2023-11-18   |   SIT测试|
| openEuler 20.03-LTS-SP3     | 2023-11-18   | 2023-11-23   |   回归测试|

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注   |
| -------- | ------------ | ------ |
| NA       | NA           | 虚拟机 |

# 3     测试结论概述

## 3.1   测试整体结论

syscare特性测试，共计执行24个用例，覆盖50个测试点，主要包括syscare build以及syscare管理功能，包括接口正向，负向的功能测试、以及可靠性测试，并发测试，长稳测试。测试过程共发现问题22个，遗留3个问题。

## 3.2   约束说明

1、补丁大小约束：单补丁不超过16个符号，总体大小不超过1MB。
2、补丁制作约束：参考官网补丁制作指导说明。
3、补丁场景约束：本版本暂不支持systemd打补丁场景。


## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

遗留问题分析：
| 编号 |  issue名称   |  遗留原因|遗留风险|   闭环日期 |
| -------- | ------------ | ------ | ------ | ----------- |
| 1       | syscare服务重启之后，残留补丁不会和现有补丁产生冲突，但是现有补丁不生效，生效的还是之前的补丁           | 方案待定 |仅影响服务重启场景，补丁状态丢失。规避措施：提前使用syscare save保存初始状态，在状态丢失时，使用syscare restore恢复初始状态。也可以使用syscare其他命令，使指定补丁达到预期状态。 | 2024-03-30     |
| 2       | openssl/glibc补丁制作并安装完成之后，因无systemd权限导致激活失败           | 方案待定 |暂不支持systemd打补丁场景 | 2024-03-30      |
| 3       | 20.03-LTS-SP3版本mysql源码包编译后无debuginfo包           | mysql自身工程原因，无解决方案|NA |NA    
 |


### 3.3.2 问题统计
本轮测试共发现问题22个，其中功能问题18个，DFX问题4个，问题列表如下：
| 编号 | issue名称                                                             | issue链接                                                               | issue状态 |
|----|---------------------------------------------------------------------|-----------------------------------------------------------------------|---------|
| 1  | syscare服务重启之后，残留补丁不会和现有补丁产生冲突，但是现有补丁不生效，生效的还是之前的补丁                  | https://gitee.com/openeuler/syscare/issues/I8F9SD?from=project-issue  | 遗留      |
| 2  | openssl/glibc补丁制作并安装完成之后，因无systemd权限导致激活失败                          | https://gitee.com/openeuler/syscare/issues/I8GEM2?from=project-issue  | 遗留      |
| 3  | 20.03-LTS-SP3版本mysql源码包编译后无debuginfo包                                 | https://gitee.com/openeuler/syscare/issues/I8GQZP?from=project-issue  | 遗留      |
| 4  | syscare apply 部分提示信息需要修改                                            | https://gitee.com/openeuler/syscare/issues/I8GDGF?from=project-issue  | 已解决     |
| 5  | 服务启动时，已经被激活的补丁无法解除激活，只有等服务停止之后，才能解除激活状态                             | https://gitee.com/openeuler/syscare/issues/I8C03D?from=project-issue  | 已解决     |
| 6  | syscare补丁激活后，再启动服务，补丁未生效                                            | https://gitee.com/openeuler/syscare/issues/I8BNXA?from=project-issue  | 已解决     |
| 7  | openEuler20.03环境上制作glibc的补丁失败                                       | https://gitee.com/openeuler/syscare/issues/I8AVF3?from=project-issue  | 已解决     |
| 8  | 基于补丁制作新补丁时，debuginfo包不匹配导致补丁制作失败                                    | https://gitee.com/openeuler/syscare/issues/I8C8AX?from=project-issue  | 已解决     |
| 9  | syscare 当前不支持批量激活补丁，和产品描述不符，需确认                                     | https://gitee.com/openeuler/syscare/issues/I8C85G?from=project-issue  | 已解决     |
| 10 | 制作redis补丁偶现失败                                                       | https://gitee.com/openeuler/syscare/issues/I8C8M7?from=project-issue  | 已解决     |
| 11 | 执行syscare相关命令后，系统出现call trace                                       | https://gitee.com/openeuler/syscare/issues/I8EV1P?from=project-issue  | 已解决     |
| 12 | 说明文档中，关于syscare build --patch-requires 后的参数描述有误                     | https://gitee.com/openeuler/syscare/issues/I8EN9I?from=project-issue  | 已解决     |
| 13 | syscare build --jobs 参数设置为0 执行成功，不合理                                | https://gitee.com/openeuler/syscare/issues/I8EN2A?from=project-issue  | 已解决     |
| 14 | 极端场景下存在补丁信息残留情况                                                     | https://gitee.com/openeuler/syscare/issues/I8EMSB?from=project-issue  | 已解决     |
| 15 | syscare apply 失败，出现与残留资源冲突问题                                        | https://gitee.com/openeuler/syscare/issues/I8F2GH?from=project-issue  | 已解决     |
| 16 | 有序补丁未按序remove时，预期：remove失败，实际：显示remove失败，但使用syscare list 查看remove成功 | https://gitee.com/openeuler/syscare/issues/I8F5E3?from=project-issue  | 已解决     |
| 17 | 强制覆盖生效的补丁，restore恢复其状态失败                                            | https://gitee.com/openeuler/syscare/issues/I8FG9Y?from=project-issue  | 已解决     |
| 18 | 并发执行syscare build，syscare 管理操作，大概率出现syscared进程codedump              | https://gitee.com/openeuler/syscare/issues/I8G5QQ?from=project-issue  | 已解决     |
| 19 | 20.03版本syscare build制作glibc补丁偶现失败                                   | https://gitee.com/openeuler/syscare/issues/I8GEJS?from=project-issue  | 已解决     |
| 20 | nginx特定场景制作补丁失败                                                     | https://gitee.com/openeuler/syscare/issues/I8GH8H?from=project-issue  | 已解决     |
| 21 | 特殊场景下，patch未生效                                                      | https://gitee.com/openeuler/syscare/issues/I8ICI8?from=project-issue  | 已解决     |
| 22 | 新进程启动的时候只打了一个补丁就退出，导致后续覆盖的补丁未生效                                     | https://gitee.com/openeuler/syscare/issues/I8IYA6?from=project-issue  | 已解决     |







# 4     详细测试结论

## 4.1.1 功能测试结论
（1）覆盖接口正常，异常测试。包括syscare build热补丁制作接口， syscare管理热补丁接口。
（2）覆盖用户态，内核态的热补丁制作测试。内核态覆盖内核和内核模块，用户态主要覆盖redis，nginx，openvswicth，dpdk，openssl，glibc，重点测试补丁依赖，累积补丁等场景。
（3）覆盖补丁管理流程测试，重点测试冲突检测，补丁覆盖，补丁状态保存与恢复等场景。

| 编号 | 用例名称                                 | 测试结果                                                                      |
|----|--------------------------------------|---------------------------------------------------------------------------|
| 1  | syscare-build异常测试                    | 通过                                                                        |
| 2  | syscare正常接口测试                        | 通过                                                                        |
| 3  | 内核态多补丁文件场景                           | 通过                                                                        |
| 4  | 内核态支持累积补丁                            | 通过                                                                        |
| 5  | 内核态热补丁制作并管理                          | 通过                                                                        |
| 6  | 制作同名内核态补丁                            | 通过                                                                        |
| 7 | 关注用例执行过程中是否有异常日志，日志风暴                | 通过                                                                        |
| 8  | 用户态支持累积补丁                            | 通过                                                                        |
| 9  | 补丁依赖                                 | 通过                                                                        |
| 10 | 用户态热补丁制作并管理                          | 通过                                                                        |
| 11 | 补丁状态保存与恢复                            | 通过                                                                        |
| 12 | 用户态补丁冲突检测测试                          | 通过                                                                        |
| 13 | 用户态补丁覆盖检测测试                          | 通过                                                                        |
| 14 | 用户态补丁覆盖异常场景测试                        | 通过                                                                        |
| 15 | 用户态补丁制作                              | 遗留问题：https://gitee.com/openeuler/syscare/issues/I8GEM2?from=project-issue |
| 16 | syscare管理流程异常接口测试                    | 通过                                                                        |
| 17 | 内核模块多补丁制作                            | 通过                                                                        |
| 18 | 日志明文，不能泄漏用户信息；超高权限755；日志风暴【明确日志转储规则】 | 通过                                                                        |






## 4.1.2 可靠性测试结论
针对本次交付的syscare热补丁制作和管理流程，构造以下可靠性场景
（1）热补丁制作和管理操作期间，构造CPU，内存高负载
（2）构造虚拟机异常重启，异常断电
（3）构造热补丁制作和管理期间，临时补丁文件和补丁状态等关键文件被篡改

| 编号 | 用例名称             | 测试结果                                                                      |
|----|------------------|---------------------------------------------------------------------------|
| 1  | 热补丁异常场景测试        | 通过                                                                        |
| 2  | 补丁状态重启后自动恢复      | 遗留问题：https://gitee.com/openeuler/syscare/issues/I8F9SD?from=project-issue |
| 3  | 补丁文件和补丁状态文件被异常篡改 | 通过                                                                        |



## 4.1.3 并发&长稳测试结论
针对本次交付的syscare热补丁制作和管理流程，构造以下并发&长稳场景
（1）并发起syscare-build，并穿插syscare一系列管理操作
（2）在syscare的管理流程并发执行背景下，不断执行kill syscare操作，不定期重启syscare服务
| 编号 | 用例名称                         | 测试结果 |
|----|------------------------------|------|
| 1  | 并发起多个syscare syscare-build进程 | 通过   |
| 2  | 热补丁流程长稳测试                    | 通过   |
| 3  | 热补丁操作并发测试                    | 通过   |



# 5     测试执行

## 5.1   测试执行统计数据

| 版本信息                   | 测试活动                   | 测试用例数  |测试用例通过个数| 发现问题单数 |
| --------------------------- | --------------------------- | ------------ | ------------ |----------- |
| openEuler 20.03-LTS-SP3   | 功能、SDV测试 | 19       |  14            |16         |
| openEuler 20.03-LTS-SP3   | SIT测试  | 22      |18            |6            |
| openEuler 20.03-LTS-SP3   | 回归测试  | 24        | 24            |0           |


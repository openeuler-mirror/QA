![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2023-12-20  |   1.0          |  创建        |    林孟孟  |

关键词：  syscare 补丁管理工具 用户态补丁 内核态补丁

摘要：22.03-LTS-SP3版本继承20.03-LTS-SP3版本syscare功能，提供一键式集成用户态和内核态热补丁编译以及补丁生命周期管理工具。本文针对22.03-LTS-SP3版本测试过程进行记录说明，重点记录功能、可靠性、长稳、并发、安全等测试活动，并给出测试评估与总结。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |


# 1     特性概述

特性主要分为两个功能：热补丁制作与热补丁管理。

## 1.1 热补丁制作

​	本次交付内核热补丁制作、内核模块热补丁制作和用户态热补丁制作。基于源码包src.rpm、debuginfo包加patch的方式制作出热补丁包。热补丁包制作完成之后，使用RPM包方式进行安装，卸载等操作。

## 1.2 热补丁管理

​	提供热补丁管理框架统一管理所有热补丁，包括用户态和内核态，提供补丁激活、补丁去激活、补丁接受，补丁状态保存与恢复，补丁冲突检测，补丁覆盖，补丁状态信息查询等功能。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次。

| 版本信息                   | 测试起始时间 | 测试结束时间 |测试活动|
| --------------------------- | ------------ | ------------ |------------ |
| openEuler 22.03-LTS-SP3     | 2023-11-23   | 2023-11-29   |   功能、SDV测试|
| openEuler 22.03-LTS-SP3     | 2023-12-02   | 2023-12-08   |   SIT-1测试|
| openEuler 22.03-LTS-SP3     | 2023-12-09   | 2023-12-15   |   SIT-2测试|
| openEuler 22.03-LTS-SP3     | 2023-12-16   | 2023-12-22   |   回归测试1|
| openEuler 22.03-LTS-SP3     | 2023-12-23   | 2023-12-29   |   回归测试2|

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注   |
| -------- | ------------ | ------ |
| NA       | NA           | 虚拟机 |

# 3     测试结论概述

## 3.1   测试整体结论

syscare特性测试，共计执行31个用例，覆盖60个测试点，主要包括syscare build以及syscare管理功能，包括接口正向，负向的功能测试、以及可靠性测试，并发测试，长稳测试，资料测试，安全测试。测试过程共发现问题14个，当前遗留4个问题。

## 3.2   约束说明
继承20.03-LTS-SP3版本约束
1、补丁大小约束：单补丁不超过16个符号，总体大小不超过1MB。
2、补丁制作约束：参考官网补丁制作指导说明。
3、补丁场景约束：本版本暂不支持systemd打补丁场景。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

遗留问题分析：
| 编号 |  issue名称   |  遗留原因|
| -------- | ------------ | ------ | 
| 1       | 加载内核模块失败，提示信息不明确           | 方案待定 |
| 2       | 编译用户态补丁时，偶现报错：Cannot find a local symbol in '***.c'          | 方案待定 |
| 3       | syscare build偶现错误：“/usr/libexec/syscare/upatch-diff: ERROR: 0x106d66.o: upatch_create_patches_sections: 156: lookup_relf failed.”           | 方案待定 |
| 4       | syscare服务涉及文件权限检查未通过，不符合红线要求 | 方案待定 |


### 3.3.2 问题统计
本轮测试共发现问题14个，其中功能问题4个，DFX问题10个，问题列表如下：

| 编号 | issue名称                                                                                                                            | issue链接                                                              | issue状态 |
|----|------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|---------|
| 1  | syscare资料部分描述需要修改                                                                                                                  | https://gitee.com/openeuler/syscare/issues/I8PYZU?from=project-issue | 已解决    |
| 2  | syscare制作内核模块补丁时，所使用的方式和普通补丁不同，但是syscare build -h的帮助信息中未显示，资料中也未说明                                                                 | https://gitee.com/openeuler/syscare/issues/I8OIV7?from=project-issue | 已解决     |
| 3  | yum install 下载syscare和syscare-build之后，部分包未下载成功                                                                                     | https://gitee.com/openeuler/syscare/issues/I8NUBH?from=project-issue | 已解决     |
| 4  | syscare补丁应用优化建议                                                                                                                    | https://gitee.com/openeuler/syscare/issues/I8NBEC?from=project-issue | 已解决     |
| 5  | 2203-LTS-SP3-x86版本并发创建补丁失败                                                                                                         | https://gitee.com/openeuler/syscare/issues/I8LNWM?from=project-issue | 已解决    |
| 6  | 加载内核模块失败，提示信息不明确                                                                                                                   | https://gitee.com/openeuler/syscare/issues/I8PCAE?from=project-issue | 挂起     |
| 7  | 编译用户态补丁时，偶现报错：Cannot find a local symbol in '***.c'                                                                                | https://gitee.com/openeuler/syscare/issues/I8OTLB?from=project-issue | 挂起    |
| 8  | "syscare build偶现错误：“/usr/libexec/syscare/upatch-diff: ERROR: 0x106d66.o: upatch_create_patches_sections: 156: lookup_relf failed. | https://gitee.com/openeuler/syscare/issues/I8Q7J3?from=project-issue                                                               | 挂起                                                                  |
| 9  | 卸载不完全 | https://gitee.com/openeuler/syscare/issues/I8PVR7?from=project-issue | 已解决     |
| 10 | 【内存泄漏】复制进程的fdmaps文件描述符后未释放导致内存泄漏  | https://gitee.com/openeuler/syscare/issues/I8PVLU?from=project-issue | 已解决     |
| 11 | upatch-manage并输出到/tmp目录下导致任意进程的物理地址泄漏     | https://gitee.com/openeuler/syscare/issues/I8PVIY?from=project-issue | 已解决 |
| 12 | 锁文件路径问题| https://gitee.com/openeuler/syscare/issues/I8PVE1?from=project-issue | 已解决    |
| 13 |syscare服务涉及文件权限检查未通过，不符合红线要求 | https://gitee.com/openeuler/syscare/issues/I8K3OZ?from=project-issue | 挂起     |
| 14 | syscare-build 偶现失败，upatch-diff产生coredump | https://gitee.com/openeuler/syscare/issues/I8QMBU?from=project-issue | 已解决    |


# 4 详细测试结论

## 4.1 功能测试结论
（1）覆盖接口正常，异常测试。包括syscare build热补丁制作接口， syscare管理热补丁接口。
（2）覆盖用户态，内核态的热补丁制作测试。内核态覆盖内核和内核模块，用户态主要覆盖redis，nginx，openvswicth，openssl，glibc，重点测试补丁依赖，累积补丁等场景。
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
| 15 | 用户态补丁制作                              | 遗留部分问题待解决|
| 16 | syscare管理流程异常接口测试                    | 通过                                                                        |
| 17 | 内核模块多补丁制作                            | 通过                                                                        |
| 18 | 日志明文，不能泄漏用户信息；超高权限755；日志风暴【明确日志转储规则】 | 通过                                                                        |
| 19 | 内核态制作补丁设置依赖 | 通过                                                                        |
| 20 | 内核模块支持多补丁功能 | 通过                                                                       |
| 21 | 内核态补丁状态重启后自动恢复 | 通过                                                                        |
| 22 | 内核态补丁状态保存与恢复 | 通过                                                                        |
| 23 | 内核支持多补丁功能 | 通过                                                                        |


## 4.2 可靠性测试结论
针对本次交付的syscare热补丁制作和管理流程，构造以下可靠性场景
（1）热补丁制作和管理操作期间，构造CPU，内存高负载
（2）构造虚拟机异常重启，异常断电
（3）构造热补丁制作和管理期间，临时补丁文件和补丁状态等关键文件被篡改

| 编号 | 用例名称             | 测试结果                                                                      |
|----|------------------|---------------------------------------------------------------------------|
| 1  | 热补丁异常场景测试        | 通过                                                                        |
| 2  | 补丁状态重启后自动恢复      | 通过 |
| 3  | 用户态补丁文件和补丁状态文件被异常篡改 | 通过                                                                        |
| 4  | 内核态补丁文件和补丁状态文件被异常篡改 | 通过 |


## 4.3 并发&长稳测试结论
针对本次交付的syscare热补丁制作和管理流程，构造以下并发&长稳场景
（1）并发起syscare-build，并穿插syscare一系列管理操作
（2）在syscare的管理流程并发执行背景下，不断执行kill syscare操作，不定期重启syscare服务
| 编号 | 用例名称                         | 测试结果 |
|----|------------------------------|------|
| 1  | 并发起多个syscare syscare-build进程 | 通过   |
| 2  | 热补丁流程长稳测试                    | 通过   |
| 3  | 热补丁操作并发测试                    | 通过   |



## 4.4 资料测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|   资料测试      |   https://gitee.com/openeuler/docs/pulls/12696    |     通过     |

## 4.5 安全测试结论
| 测试类型  |  测试内容 |  测试结论 |
| ------- | ------- | -------- |
| 渗透测试   |  地址泄漏 | 通过 |
| 代码检视   |  内存泄漏 | 通过 |
| 代码检视   |  越权操作 | 通过 |

# 5     测试执行

## 5.1   测试执行统计数据


| 版本信息                   | 测试活动                   | 测试用例数  |测试用例通过个数| 发现问题单数 |
| --------------------------- | --------------------------- | ------------ | ------------ |----------- |
| openEuler 22.03-LTS-SP3   | 功能、SDV测试 | 19       |  18           |2        |
| openEuler 22.03-LTS-SP3   | SIT测试  | 28     |24           |12            |
| openEuler 22.03-LTS-SP3   | 回归测试  | 31       | 31            |0           |

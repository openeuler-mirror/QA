![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录
|  日期       | 修订版本  | 修改描述 | 作者      |
| ---------- | -------- | ------- | -------- |
| 2022-09-30 | 1.0.0 | openEuler-22.09-EBS版本测试报告 | zjl_long |
| 2022-11-09 | 1.0.1 | 更新遗留问题，补充影响分析 | zjl_long |

关键词：  
    测试策略 测试报告
摘要：
    
缩略语清单：
| 缩略语  | 英文全名                              | 中文解释       |
| ------ | ------------------------------------ | ------------ |
| LTS    | Long time support                    | 长时间维护     |
| OS     | Operation System                     | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露  |


# 1     版本测试概述
按照openEuler 22.09 社区版本测试策略，对openEuler-22.09-EBS版本进行如下测试：<br> OS安装部署，AT冒烟测试，RPM包管理（自编译、安装、卸载），单包能力（命令、服务），以及内核LTP测试。
其他测试项继承openEuler 22.09版本测试结论。


# 2     版本测试信息
本节描述被测对象的版本信息和测试的时间，包括依赖的环境信息，测试repo源。

| 版本名称             | 测试起始时间   | 测试结束时间   |
| ------------------- | ------------ | ------------ |
| openEuler-22.09-EBS版本 RC1 |  2022-09-26  |  2022-09-29  |
| openEuler-22.09-EBS版本 RC2 |  2022-09-30  |  2022-09-30  |

描述版本测试的环境信息
|  环境  | 系统架构 |  配置信息                            | 备注 |
|:------|:--------|:------------------------------------|:----|
| 虚拟机 | arm架构 | CPU核数：4<br>内存：4G<br>硬盘容量：50G |     |
| 虚拟机 | x86架构 | CPU核数：4<br>内存：4G<br>硬盘容量：50G |     |
| 物理机 | arm架构 | CPU：Kunpeng 920<br> 内存：32G*32=1024G<br> 硬盘容量：1.09T |     |
| 物理机 | x86架构 | CPU：Intel(R) Xeon(R) Gold 6266C CPU @ 3.00GHz<br> 内存：32G\*12=384G<br> 硬盘容量：744.126G*2 |     |

测试repo源   
http://121.36.84.172/dailybuild/openEuler-22.09-unity-build/ebs_openeuler-2022-09-26-18-35-55/


# 3     测试结论概述

## 3.1   测试整体结论
openEuler-22.09-EBS版本，共计执行 21340 个测试用例，发现 9 个问题，其中有效问题 8 个。整体质量良好，满足出口质量标准。

| 测试活动    | 活动评价                                          |
| ---------- | ----------------------------------------------- |
| OS安装部署  | 通过执行baseOS安装测试用例，保证OS可以正常安装，无异常现象 |
| AT冒烟      | 通过执行AT测试用例，保证系统基础功能正常，验证版本满足基本转测试条件 |
| 源码包自编译 | 验证在openEuler系统arm和x86架构下，编译源码包，能够生成可用的二进制包，说明源码包正常可用 |
| 软件包管理   | 通过软件包管理测试，对转测试的二进制包的可安装、卸载进行整体保证 |
| 单包能力验证 | 通过对二进制包的命令、服务、应用等测试，保证软件包的基础功能正常 |
| 内核LTP     | 内核LTP测试保证系统在各种压力背景下，系统功能无异常 |

## 3.2   约束说明

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施
| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| ------- | ------ | ------- | --------------- | ------- |
| I5TQQX  | 【openEuler EBS 0926-ISO】【x86】nfs-blkmap服务启动之后，日志中显示Can't open PID file /run/blkmapd.pid (yet?) after start: Operation not permitted（偶现） | 主要 | Nginx启动时，PID文件未生成，导致文件读取失败。可以在执行文件前加上等待时间规避。非构建系统问题，需开发提交PR整改 | 待办的 |

### 3.3.2 问题统计
|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 | 已取消 |
| ------ | ------- | --- | --- | --- | ----- | ----- |
|  数目   |   9    |  0  |  8  |  0  |   0   |  1  |
|  百分比 |  100%  |  0  | 88.9% |  0  |  0  | 11.1% |

### 3.3.3 问题列表
| 问题单(issue链接) | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| ------- | ------ | ------- | --------------- | ------ |
| https://gitee.com/src-openeuler/pps-tools/issues/I5TWG4?from=project-issue | 【openEuler-22.09-x86】 pps-ktimer.c文件在x86上编译失败  | 主要 |   |  已取消  |
| https://gitee.com/src-openeuler/nfs-utils/issues/I5TQQX?from=project-issue | 【openEuler EBS 0926-ISO】【x86】nfs-blkmap服务启动之后，日志中显示Can't open PID file /run/blkmapd.pid (yet?) after start: Operation not permitted（偶现） |  主要  |  Nginx启动时，PID文件未生成，导致文件读取失败。可以在执行文件前加上等待时间规避。非构建系统问题，需开发提交PR整改  |  待办的  |
| https://gitee.com/src-openeuler/libwbxml/issues/I5TNUV?from=project-issue | xml2wbxml命令在arm上执行失败 |  主要  |   |  待办的  |
| https://gitee.com/src-openeuler/jetty/issues/I5TN89?from=project-issue | jetty包arm源中不存在 |  主要  |  |  已完成  |
| https://gitee.com/src-openeuler/lorax/issues/I5TQKF?from=project-issue | 【openEuler EBS 0926】【x86】安装lorax-composer和依赖包lorax冲突，导致无法安装 |  主要  |  dnf检测到两个包不是出自同一个源码包，报告文件冲突，原因是由于os与everything做镜像使用的不是同一个repo源，可以通过禁用os源或将everything调整到os之前提高优先级进行规避  |  已验收  |
| https://gitee.com/src-openeuler/A-Tune/issues/I5TL63?from=project-issue | 【openEuler EBS 0926-ISO】【x86】同时安装atune atune-engine出现冲突 |  主要  |    |  已验收  |
| https://gitee.com/src-openeuler/docker/issues/I5TWC7?from=project-issue | 【openEuler EBS 0926】【x86】同时安装docker-engine和containerd产生冲突 |  主要  |    |  已验收  |
| https://gitee.com/src-openeuler/docker/issues/I5TWBV?from=project-issue | 【openEuler EBS 0926】【x86】同时安装docker-engine和libnetwork产生冲突 |  主要  |    |  已验收  |
| https://gitee.com/src-openeuler/openvswitch/issues/I5TU6X?from=project-issue | 【openEuler EBS 0926】【x86】同时安装openvswitch和python3-openvswitch产生冲突 |  次要  |    |  已验收  |


# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

|  版本名称  | 测试用例数 | 用例执行结果 | 发现问题单数 |
| --------- | -------- | ---------- | ---------- |
| openEuler-22.09-EBS版本 RC1 | 21335 | succeed |   9   |
| openEuler-22.09-EBS版本 RC2 |   5   | succeed |   0   |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)      
增加RC3测试   
1、针对RC1测试发现的问题（I5TQKF、I5TL63、I5TWC7、I5TWBV、I5TU6X）不采用规避方案，在新的ISO环境下进行回归验证；  
2、进一步分析I5TN89问题单，排查jetty没有构建出来的根本原因；  
3、重新构建libwbxml包，对I5TNUV问题单进行回归验证。  


# 5     附件

*此处可粘贴各类专项测试数据或报告*


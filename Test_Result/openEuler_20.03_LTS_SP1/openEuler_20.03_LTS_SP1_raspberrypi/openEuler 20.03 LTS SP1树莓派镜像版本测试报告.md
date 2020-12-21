![openEuler ico](../../../images/openEuler.png)

版权所有 © 2020  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期 | 修订版本 | 修改章节 | 修改描述 |
| ---- | -------- | -------- | -------- |
| 2020/12/18 | v1.0 | /  | 创建      |

关键词：树莓派

摘要：依测试要求，对openEuler 20.03 LTS SP1树莓派镜像进行安装、基本功能、管理工具、硬件兼容性和稳定性测试。测试结果良好，基本支持上述功能的正常使用。 

***

# 1   概述

该测试报告汇总了openEuler 20.03 LTS SP1树莓派镜像RC2和RC4测试的最终测试结果，根据现有问题总结了测试结论及建议。

# 2   测试版本说明

## 2.1  测试对象

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| [openEuler 20.03 LTS SP1 RC2树莓派测试镜像](http://117.78.1.88:82/dailybuilds/openeuler/openEuler-20.03-LTS-SP1/openeuler_2020-11-30-01-07-43/raspi_img/aarch64/openEuler-20.03-LTS-SP1-raspi-aarch64.img.xz) | 2020/12/01 | 2020/12/05 |
| [openEuler 20.03 LTS SP1 RC4树莓派测试镜像](http://117.78.1.88:82/dailybuilds/openeuler/openEuler-20.03-LTS-SP1/openeuler_2020-12-14-11-40-05/raspi_img/aarch64/openEuler-20.03-LTS-SP1-raspi-aarch64.img.xz) | 2020/12/16 | 2020/12/19 |

## 2.2  硬件环境

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 树莓派4B卡 | CPU:Cortex-A72 * 4 内存：8GB 存储设备：SanDisk Ultra 16GB micro SD | 默认测试环境，数量1 |
| 树莓派3B+卡 | CPU:Cortex-A53 * 4 内存：1GB 存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |
| 树莓派3B卡 | CPU:Cortex-A53 * 4 内存：1GB 存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |
| 支持树莓派的7寸屏 | HDMI接口，1024*600分辨率电容屏 | 数量1 |
| thinkpad x1 carbon 2019 |  | 远程控制树莓派设备 |
| RG-AP740-I(C)室内802.11ac无线接入点 |  | 无线网环境 |
| 1Gbps交换机 |  | 有线网环境 |

## 2.3  软件环境

| 测试用软件源 | 备注 |
| ----------- | ---- |
| openEuler-20.03-LTS-SP1.repo | 手动更改配置文件，替换被测镜像内默认源进行本次版本测试 |

```
[root@openEuler ~]# vim /etc/yum.repos.d/openEuler-20.03-LTS-SP1.repo


[OS]
name=OS
baseurl=http://119.3.219.20:82/openEuler:/20.03:/LTS:/SP1/standard_$basearch/
enabled=1
gpgcheck=0

[EPOL]
name=EPOL
baseurl=http://119.3.219.20:82/openEuler:/20.03:/LTS:/SP1:/Epol/standard_$basearch/
enabled=1
gpgcheck=0
```

## 2.4  测试辅助工具

| 名称 | 备注 |
| --- | ---- |
| Testlink | 测试过程管理 |
| gitee | 问题追踪管理 |

# 3   版本概要测试结论

openEuler 20.03 LTS SP1树莓派镜像版本测试完成了功能测试，测试范围包括镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成了硬件兼容性测试，包括树莓派3B、3B+、4B开发板的USB接口、HDMI接口、以太网接口、Wi-Fi、蓝牙的兼容性验证；完成了稳定性测试，包括reboot100次自动化测试。测试发现的主要问题都得到了修正，回归测试结果正常。

# 4   版本详细测试结论

## 4.1   特性测试结论

| 序号 | 特性名称 | 特性质量评估               | 备注     |
| ---- | -------- | -------------------------- | -------- |
| 1    | 系统安装 | <font color=green>○</font> | 正常 |
| 2    | 基本功能及配置 | <font color=green>○</font> | 正常 |
| 3    | 软件管理 | <font color=green>○</font> | 正常 |
| 4    | 服务管理 | <font color=green>○</font> | 正常 |
| 4    | 进程管理 | <font color=green>○</font> | 正常 |
| 4    | 网络管理 | <font color=green>○</font> | 正常 |
| 4    | 开发环境 | <font color=green>○</font> | 大部分由软件源提供安装，依赖于版本发布时源的更正 |

 <font color=red>○</font>： 表示特性不稳定，风险高

<font color=blue>○</font>： 表示特性基本可用，遗留少量问题

<font color=green>○</font>： 表示特性质量良好

## 4.2   硬件兼容性测试结论

支持树莓派3B、3B+、4B开发板的USB接口、HDMI接口、以太网接口、Wi-Fi、蓝牙的正常使用。

# 5   问题单统计

| 编号 | issue号 | 描述 | 版本 | 备注 |
| ---- | ------- | ---- | ---- | ---- |
| 1 | [#I27ZBD](https://gitee.com/openeuler/raspberrypi/issues/I27ZBD) | 默认源无法使用 | RC2 | 版本发布即解决 |
| 2 | [#I27ZA7](https://gitee.com/openeuler/raspberrypi/issues/I27ZA7) | NetworkManager服务出现错误信息 | RC2 | RC4回归时已解 |


# 6   附件

## 6.1   附件1：遗留问题列表

截止RC4测试，除测试镜像默认源无法直接使用需要手动配置，其余测试项均通过。
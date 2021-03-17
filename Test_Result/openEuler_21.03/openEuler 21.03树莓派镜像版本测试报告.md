![openEuler ico](../../images/openEuler.png)

版权所有 © 2021 openEuler 社区
 您对“本文档”的复制、使用、修改及分发受知识共享( Creative Commons )署名—相同方式共享 4.0 国际公共许可协议(以下简称“ CC BY-SA 4.0 ”)的约束。为了方便用户理解，您可以通过访问 [*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/)  了解 CC BY-SA 4.0 的概要 (但不是替代)。CC BY-SA 4.0 的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode) 。

修订记录

| 日期 | 修订版本 | 修改章节 | 修改描述 |
| ---- | -------- | -------- | -------- |
| 2021/03/17 | v1.0 | /  | 创建      |

关键词：树莓派

摘要：依测试要求，对 openEuler 21.03 树莓派镜像进行安装、基本功能、管理工具、硬件兼容性和稳定性测试。测试结果良好，基本支持上述功能的正常使用。 

***

# 1   概述

openEuler 21.03 版本更新了 5.10 内核。该测试报告汇总了 openEuler 21.03 树莓派镜像 RC3 测试的信息, 根据以往版本的树莓派测试项，对其基本功能进行回归测试，保证其正常的使用。

# 2   测试版本说明

## 2.1  测试对象

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| [openEuler 21.03 RC3 树莓派测试镜像](http://121.36.84.172/dailybuild/openEuler-21.03/openeuler-2021-03-14-07-55-28/raspi_img/openEuler-21.03-raspi-aarch64.img.xz) | 2021/03/16 | 2021/03/17 |


## 2.2  硬件环境

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 树莓派4B卡 | CPU:Cortex-A72 * 4 内存：8GB 存储设备：SanDisk Ultra 16GB micro SD | 默认测试环境，数量1 |
| 树莓派3B+卡 | CPU:Cortex-A53 * 4 内存：1GB 存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |
| 树莓派3B卡 | CPU:Cortex-A53 * 4 内存：1GB 存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |
| 支持树莓派的7寸屏 | HDMI接口，1024*600分辨率电容屏 | 数量1 |

## 2.3  软件环境

| 测试用软件源 | 备注 |
| ----------- | ---- |
| openEuler.repo | 手动更改配置文件，替换被测镜像内默认源进行本次版本测试 |

```
[root@openEuler ~]# vim /etc/yum.repos.d/openEuler.repo


[OS]
name=OS
baseurl=http://119.3.219.20:82/openEuler:/21.03/standard_$basearch/
enabled=1
gpgcheck=0

[EPOL]
name=EPOL
baseurl=http://119.3.219.20:82/openEuler:/21.03:/Epol/standard_$basearch/
enabled=1
gpgcheck=0

```

## 2.4  测试辅助工具

| 名称 | 备注 |
| --- | ---- |
| Testlink | 测试过程管理 |
| gitee | 问题追踪管理 |

# 3   版本概要测试结论

openEuler 21.03 树莓派镜像版本测试完成了功能测试，测试范围包括镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成了硬件兼容性测试，包括树莓派 3B、3B+、4B 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的兼容性验证；完成了稳定性测试，包括 reboot 100 次自动化测试。以上测试内容均未发现问题。

# 4   版本详细测试结论

## 4.1   特性测试结论

| 序号 | 特性名称 | 特性质量评估               | 备注     |
| ---- | -------- | -------------------------- | -------- |
| 1    | 系统安装 | █ | 正常 |
| 2    | 基本功能及配置 | █ | 正常 |
| 3    | 软件管理 | █ | 正常 |
| 4    | 服务管理 | █ | 正常 |
| 4    | 进程管理 | █ | 正常 |
| 4    | 网络管理 | █ | 正常 |
| 4    | 开发环境 | █ | 正常，依赖于测试源 |

● ： 表示特性不稳定，风险高

▲ ： 表示特性基本可用，遗留少量问题

█ ： 表示特性质量良好

## 4.2   硬件兼容性测试结论

支持树莓派 3B、3B+、4B 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的正常使用。

# 5   问题单统计

| 编号 | issue号 | 描述 | 版本 | 备注 |
| ---- | ------- | ---- | ---- | ---- |
**注：上述测试项未发现问题**

# 6   附件

## 6.1   附件1：遗留问题列表

截止RC3测试，各测试项均通过。
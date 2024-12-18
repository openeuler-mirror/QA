![openEuler ico](../../images/openEuler.png)

版权所有 © 2024 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA
4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| 日期 | 修订版本 | 修改章节 | 修改描述 |
| ---- | -------- | -------- | -------- |
| 2024/05/23 | v1.0 |   | 创建      |

关键词：树莓派

摘要：依测试要求，对 openEuler 24.03 LTS 树莓派镜像进行内核版本检查，安装、基本功能、管理工具、硬件兼容性。测试结果良好，基本支持上述功能的正常使用。

***

# 1   概述

该测试报告汇总了 openEuler 24.03 LTS 树莓派镜像测试的信息, 根据以往版本的树莓派测试项，对其基本功能进行回归测试，保证其正常的使用。

# 2   测试版本说明

## 2.1  测试对象

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| [openEuler 24.03 LTS 树莓派测试镜像](http://121.36.84.172/dailybuild/EBS-openEuler-24.03-LTS/openeuler-2024-04-29-08-55-06/raspi_img/) | 2024/05/06 | 2024/05/12 |

## 2.2  硬件环境

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| 树莓派4B卡 | CPU:Cortex-A72 * 4 内存：8GB 存储设备：SanDisk Ultra 16GB micro SD | 默认测试环境，数量1 |
| 树莓派3B+卡 | CPU:Cortex-A53 * 4 内存：1GB 存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |
| 树莓派3B卡 | CPU:Cortex-A53 * 4 内存：1GB 存储设备：SanDisk Ultra 16GB micro SD | 硬件兼容性测试环境，数量1 |

## 2.3  软件环境

| 测试用软件源 | 备注 |
| ----------- | ---- |
| openEuler.repo | 手动更改配置文件，替换被测镜像内默认源进行本次版本测试 |

## 2.4  测试辅助工具

| 名称 | 备注 |
| --- | ---- |
| Testlink | 测试过程管理 |
| gitee | 问题追踪管理 |

# 3   版本概要测试结论

openEuler 24.03 LTS 树莓派镜像版本测试完成了功能测试，测试范围包括镜像安装，系统基本信息查看，用户功能，软件管理功能，服务管理功能，进程管理功能，网络管理功能，开发环境等；完成了硬件兼容性测试，包括树莓派 3B、3B+、4B 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的兼容性验证。以上测试内容均未发现问题。

# 4   版本详细测试结论

## 4.1   特性测试结论

| 序号 | 特性名称 | 特性质量评估               | 备注     |
| ---- | -------- | -------------------------- | -------- |
| 1    | 系统安装 | █ |  |
| 2    | 基本功能及配置 | █ |  |
| 3    | 软件管理 | █ |  |
| 4    | 服务管理 | █ |  |
| 5    | 进程管理 | █ |  |
| 6    | 网络管理 | █ |  |
| 7    | 开发环境 | █ | 依赖于更换源 |

● ： 表示特性不稳定，风险高

▲ ： 表示特性基本可用，遗留少量问题

█ ： 表示特性质量良好

## 4.2   硬件兼容性测试结论

支持树莓派 3B、3B+、4B 开发板的 USB 接口、HDMI 接口、以太网接口、Wi-Fi 、蓝牙的正常使用。

# 5   测试执行

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
|---------|------------|-------------|-------------|
| RC 4 | 144 | 100% 通过 | 0 |

其中：系统安装 11 项用例、基本功能及配置 25 项用例、管理工具 53 项用例、硬件兼容性 36 项用例、开发环境验证 18 项用例、稳定性 1 项用例，合计 144 项用例。通过率 100% 。

# 6   问题单统计

| 编号 | issue号 | 描述 | 版本 | 备注 |
| ---- | ------- | ---- | ---- | ---- |

[TOC]

![img](https://gitee.com/openeuler/QA/raw/79f0d49e58e0684367b8f53e9d866a01be93c4c6/images/openEuler.png)

版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改描述                   | 作者                       |
| ---------- | -------- | -------------------------- | -------------------------- |
| 2024.12.06 | 0.1      | k8s部署测试执行与记录      | 俞典典、刘江斌、丁嘉辉     |
| 2024.12.09 | 0.2      | kubeflow部署测试执行与记录 | 舒飘扬、富焘、王葵、袁礼鹏 |
| 2024.12.10 | 0.3      | 测试报告撰写               | 丁嘉辉                     |
| 2024.12.13 | 0.4      | 更新测试结论与遗留问题     | 丁嘉辉、富焘               |

关键词： oeDeploy、oedp、k8s、kubeflow、安装部署

摘要：这份oeDeploy测试报告主要涉及功能、性能、兼容性方面的测试。报告指出，大部分功能已经通过测试，但仍存在一些细分场景存在未解决的问题。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |



# 1    需求概述

本节描述特性提供的基本能力

| No.  | 需求描述                                             |
| ---- | ---------------------------------------------------- |
| 1    | 新增命令行oedp，插件式管理不同软件的安装部署能力     |
| 2    | oedp list：查询支持的插件列表                        |
| 3    | oedp run install：一键部署                           |
| 4    | oedp run uninstall：一键卸载                         |
| 5    | 支持k8s在多节点上自动部署，部署阶段支持重入          |
| 6    | 支持kubeflow自动部署，部署阶段支持重入               |
| 7    | kubeflow自动部署后，支持notebook/automl/发布模型服务 |



# 2    需求测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称   | 测试起始时间 | 测试结束时间 |
| ---------- | ------------ | ------------ |
| oedp-1.0.0 | 2024.12.05   | 2024.12.10   |

描述特性测试的硬件环境信息

-   注：实际测试环境为虚拟机集群，由以下同一宿主环境中的多种环境排列组合（例如：同一网段的多个华为云虚拟机，或者同个鲲鹏服务器上创建的多个虚拟机）

| OS环境                    | 架构：虚拟机配置、Host环境                                   |
| ------------------------- | ------------------------------------------------------------ |
| openEuler22.03sp3         | arm：2U4G，华为云虚拟机(鲲鹏服务器)<br />arm：4U8G，华为云虚拟机(鲲鹏服务器)<br />x86：2U4G，华为云虚拟机<br />x86：4U8G，华为云虚拟机<br />x86：2U4G，Hyper-V虚拟机 |
| openEuler22.03sp4         | arm：2U4G，华为云虚拟机(鲲鹏服务器)<br />arm：4U8G，华为云虚拟机(鲲鹏服务器)<br />arm：2U2G，鲲鹏服务器<br />x86：2U4G，华为云虚拟机<br />x86：4U8G，华为云虚拟机<br />x86：2U2G，鲲鹏服务器<br />x86：2U4G，Hyper-V虚拟机 |
| openEuler24.03            | x86：2U4G，华为云虚拟机<br />x86：4U8G，华为云虚拟机<br />x86：2U2G，鲲鹏服务器<br />x86：2U4G，Hyper-V虚拟机 |
| openEuler24.09            | arm：2U4G，华为云虚拟机(鲲鹏服务器)<br />arm：4U8G，华为云虚拟机(鲲鹏服务器) |
| openEuler24.09-DevStation | arm：2U4G，华为云虚拟机(鲲鹏服务器)<br />x86：2U4G，Hyper-V虚拟机 |
| openEuler24.03sp1-rc3     | arm：2U4G，华为云虚拟机(鲲鹏服务器)<br />x86：2U4G，华为云虚拟机 |

# 3    测试结论概述

## 3.1  测试整体结论

oeDeploy需求，26个测试场景，执行92个用例，主要覆盖了功能测试、兼容性测试、性能测试，截至1230版本发布前，所有问题都已修复。

| 测试活动 | 测试说明 | 测试结果 |
| ------- | -------- | :------ |
| 功能测试-oedp软件包 | oedp命令行基本功能（list/info/help） | <font color=green>■</font> 通过 |
| 功能测试-oedp软件包 | 反复卸载oedp软件包（3+次），安装后功能正常，卸载后功能不可用，无相关文件残留 | <font color=green>■</font> 通过 |
| 功能测试-oedp软件包 | oedp入参错误时报错且有提示信息 | <font color=green>■</font> 通过 |
| 功能测试-k8s部署 | 1 master + 1 worker 环境多次install/uninstall（3+次），安装k8s后功能正常，卸载后功能不可用，无相关文件残留 | <font color=green>■</font> 通过 |
| 功能测试-k8s部署 | 1 master + 2 worker 环境多次install/uninstall（3+次），安装k8s后功能正常，卸载后功能不可用，无相关文件残留 | <font color=green>■</font> 通过 |
| 功能测试-k8s部署 | k8s部署过程中构造中断/失败，日志中有对应的提示信息 | <font color=green>■</font> 通过 |
| 功能测试-k8s部署 | k8s部署过程中构造中断/失败，失败后命令行再次重新部署可以部署成功 | <font color=green>■</font> 通过 |
| 功能测试-k8s部署 | k8s部署后基础命令行测试，kubectl get pod -A，kubectl get ns，kubectl get node | <font color=green>■</font> 通过 |
| 功能测试-k8s部署 | k8s卸载后支持环境清理 | <font color=green>■</font> 通过 |
| 功能测试-k8s部署 | k8s部署时，构造空闲空间不足的情况，日志中有相关提示；空间恢复后重试可以部署成功 | <font color=green>■</font> 通过 |
| 功能测试-kubeflow部署 | 1 master + 1 worker 环境多次install/uninstall（3+次），安装kubeflow后功能正常，卸载后功能不可用，无相关文件残留 | <font color=green>■</font> 通过 |
| 功能测试-kubeflow部署 | 1 master + 2 worker 环境多次install/uninstall（3+次），安装kubeflow后功能正常，卸载后功能不可用，无相关文件残留 | <font color=green>■</font> 通过 |
| 功能测试-kubeflow部署 | kubeflow部署过程中构造中断/失败，日志中有对应的提示信息 | <font color=green>■</font> 通过 |
| 功能测试-kubeflow部署 | kubeflow部署过程中构造中断/失败，失败后命令行再次重新部署可以部署成功 | <font color=green>■</font> 通过 |
| 功能测试-kubeflow部署 | 未安装k8s时直接部署kubeflow，是否有关检查提示k8s未安装 | <font color=green>■</font> 通过 |
| 功能测试-kubeflow部署 | kubeflow部署时，构造空闲空间不足的情况，日志中有相关提示；空间恢复后重试可以部署成功 | <font color=green>■</font> 通过 |
| 功能测试-kubeflow部署 | kubeflow卸载后支持环境清理 | <font color=green>■</font> 通过 |
| 功能测试-kubeflow功能拓展 | kubeflow部署完成后，基础命令行测试，kubectl get pods -n kubeflow | <font color=green>■</font> 通过 |
| 功能测试-kubeflow功能拓展 | kubeflow部署Serverless基础功能测试，能正常发布模型（仅x86） | <font color=green>■</font> 通过 |
| 功能测试-kubeflow功能拓展 | AutoML组件基础功能测试（仅x86） | <font color=green>■</font> 通过 |
| 功能测试-kubeflow功能拓展 | notebook功能测试，对应文档服务功能。 | <font color=green>■</font> 通过 |
| 兼容性测试 | oedp软件包支持安装在openEuler22.03系列与openEuler24.03系列 | <font color=green>■</font> 通过 |
| 兼容性测试 | k8s、kubeflow部署支持openEuler22.03系列与openEuler24.03系列，支持任意排列组合的openEuler集群 | <font color=green>■</font> 通过 |
| 性能测试 | 典型场景下，oedp一键部署kubeflow典型场景时间小于30分钟，多次重复均小于30分钟 | <font color=green>■</font> 通过 |
| 资料测试 | 用户文档清晰，无错误，对读者友好 | <font color=green>■</font> 通过 |

<font color=red>●</font>： 表示不稳定，风险高
<font color=blue>▲</font>： 表示基本可用，遗留少量问题
<font color=green>■</font>： 表示质量良好

## 3.2   约束说明

使用时涉及到的约束及限制条件

-   k8s、kubeflow部署节点的最低要求2U4G，如果启动kServer或者katib服务，部署节点最低要求4U8G。
-   kServer不涉及arm环境

## 3.3  遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 |   影响分析   | 解决措施 |
| :-: | ------- | ------ | :-----: | :-----: | :-----: |
|  |  |  |          |          |          |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| :----: | :------: | :--: | :--: | :--: | :----: |
|  数目  |    13    |      |  5   |  7   |   1    |
| 百分比 |   100%   |      | 38%  | 54%  |   8%   |



# 4    详细测试结论

## 4.1  功能测试
-   注：同一测试目标下用OS的不同架构、不同版本构造不同测试用例

| 测试模块 | 测试目标 | 测试基本步骤 | 用例数 | 用例执行结果 | 发现问题单数 |
| :------: | ---------- | :----------- | :----------: | :----------- | :----------: |
| oedp软件包 | oedp命令行基本功能（list/info/help） | yum install oedp-1.0.0-20241207.aarch64.rpm<br/>oedp --help<br/>oedp -h<br />未安装任何插件，oedp list<br />将k8s和kubeflow的部署插件上传到插件目录，oedp list | 8 | <font color=green>■</font> 通过 | 1 |
| oedp软件包 | 反复卸载oedp软件包（3+次），安装后功能正常，卸载后功能不可用，无相关文件残留 | yum install oedp-1.0.0-20241207.aarch64.rpm<br/>执行 oedp list，检查功能<br/>yum remove oedp<br/>执行 oedp list，并检查文件残留<br/>重复以上步骤 3 次 | 4      | <font color=green>■</font> 通过 | 1 |
| oedp软件包 | oedp入参错误时报错且有提示信息 | oedp后随意填充字符串，构造错误输入 | 4      | <font color=green>■</font> 通过 | |
| oedp软件包 | 同个控制节点对多个集群的并发部署 | 安装oedp，在本地创建两个项目，启动两个窗口同时触发部署<br />重复install/delete操作3次，install和delete并发3次 | 4 | <font color=green>■</font> 通过 | |
| k8s部署 | 1 master + 1 worker 环境多次install/uninstall（3+次），安装后功能正常，卸载后功能不可用，无相关文件残留 | 将k8s-1.0.1.tar.gz解压到/root目录，修改config.yaml后<br/>oedp run install -p ~/k8s-1.0.1/<br/>oedp run delete -p ~/k8s-1.0.1/<br/>重复执行3次 | 4      | <font color=green>■</font> 通过 | 2 |
| k8s部署 | 1 master + 2 worker 环境多次install/uninstall（3+次），安装后功能正常，卸载后功能不可用，无相关文件残留 | 将k8s-1.0.1.tar.gz解压到/root目录，修改config.yaml后<br/>oedp run install -p ~/k8s-1.0.1/<br/>oedp run delete -p ~/k8s-1.0.1/<br/>重复执行3次 | 4 | <font color=green>■</font> 通过 | 2 |
| k8s部署 | k8s部署过程中构造中断/失败，日志中有对应的提示信息 | 将k8s-1.0.1.tar.gz解压到/root目录，修改config.yaml后<br/>oedp run install -p ~/k8s-1.0.1/<br/>首次联通时未添加known_hosts会导致ssh登录失败 | 4 | <font color=green>■</font> 通过 | |
| k8s部署 | k8s部署过程中构造中断/失败，失败后命令行再次重新部署可以部署成功 | 将k8s-1.0.1.tar.gz解压到/root目录，修改config.yaml后<br/>oedp run install -p ~/k8s-1.0.1/<br/>任意时刻中断命令行执行，重新执行，最后卸载，重复3次 | 4 | <font color=green>■</font> 通过 | |
| k8s部署 | k8s部署后基础命令行测试，kubectl get pod -A，kubectl get ns，kubectl get node | 略 | 4 | <font color=green>■</font> 通过 | |
|     k8s部署      | k8s卸载后支持环境清理 | k8s卸载成功后<br />oedp run clean -p ~/k8s-1.0.1/ | 4      | <font color=green>■</font> 通过 | 1 |
| k8s部署 | k8s部署时，构造空闲空间不足的情况，日志中有相关提示；空间恢复后重试可以部署成功 | k8s部署前，用fallocate -l 29.5G test.txt构造磁盘空间不足的场景<br/>oedp run install -p ~/k8s-1.0.2/<br/>删掉大文件后重新执行 | 4 | <font color=green>■</font> 通过 | |
| kubeflow部署 | 1 master + 1 worker 环境多次install/uninstall（3+次），安装后功能正常，卸载后功能不可用，无相关文件残留 | k8s部署完成后，解压kubeflow部署插件<br/>oedp run install -p ~/kubeflow-1.31.1/<br/>oedp run delete -p ~/kubeflow-1.31.1/<br/>重复执行3次 | 4 | <font color=green>■</font> 通过 | |
| kubeflow部署 | 1 master + 2 worker 环境多次install/uninstall（3+次），安装后功能正常，卸载后功能不可用，无相关文件残留 | k8s部署完成后，解压kubeflow部署插件<br/>oedp run install -p ~/kubeflow-1.31.1/<br/>oedp run delete -p ~/kubeflow-1.31.1/<br/>重复执行3次<br /><br />解压k8s、kubeflow部署插件到本地<br/>oedp run install -p ~/k8s-1.0.2/<br/>oedp run install -p ~/kubeflow-1.31.1/<br/>oedp run delete -p ~/kubeflow-1.31.1/<br/>oedp run delete -p ~/k8s-1.0.2/<br/>重复执行3次 | 4 | <font color=green>■</font> 通过 | 3 |
|   kubeflow部署   | k8s部署过程中构造中断/失败，日志中有对应的提示信息           | k8s部署完成后，解压kubeflow部署插件<br/>oedp run install -p ~/kubeflow-1.31.1/<br/>任意时刻中断命令行执行，重新执行，最后卸载，重复3次 | 4      |               <font color=green>■</font> 通过                |              |
| kubeflow部署 | kubeflow部署过程中构造中断/失败，失败后命令行再次重新部署可以部署成功 | k8s部署完成后，解压kubeflow部署插件<br/>oedp run install -p ~/kubeflow-1.31.1/<br/>任意时刻中断命令行执行，重新执行，最后卸载，重复3次 | 4 | <font color=green>■</font> 通过 | |
| kubeflow部署 | 未安装k8s时直接部署kubeflow，是否有关检查提示k8s未安装 | 未安装k8s，直接部署kubeflow | 4      | <font color=green>■</font> 通过 | |
| kubeflow部署 | kubeflow部署时，构造空闲空间不足的情况，日志中有相关提示；空间恢复后重试可以部署成功 | k8s部署前，用fallocate -l 27G test.txt构造磁盘空间不足的场景<br/>oedp run install -p ~/kubeflow-1.31.1/<br/>删掉大文件后重新执行 | 4 | <font color=green>■</font> 通过 | |
| kubeflow部署 | kubeflow卸载后支持环境清理 | kubeflow卸载成功后<br />oedp run clean -p ~/kubeflow-1.31.1/ | 4 | <font color=green>■</font> 通过                              | 1 |
| kubeflow功能拓展 | kubeflow部署完成后，基础命令行测试，kubectl get pods -n kubeflow | kubeflow部署成功后，在master上执行kubectl get pod -n kubeflow | 4 | <font color=green>■</font> 通过 | 1 |
| kubeflow功能拓展 | kubeflow部署Serverless基础功能测试，能正常发布模型（仅x86） | 详见插件附带的文档                                           | 2 | <font color=green>■</font> 通过 | 1 |
| kubeflow功能拓展 | AutoML组件基础功能测（仅x86） | 详见插件附带的文档 | 2 | <font color=green>■</font> 通过 | |
| kubeflow功能拓展 | notebook功能测试，对应文档服务功能。 | 详见插件附带的文档 | 2 | <font color=green>■</font> 通过 | |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2  兼容性测试结论

oedp软件在openEuler22.03系列与openEuler24.03系列上无兼容性问题，k8s、kubeflow部署支持openEuler22.03系列与openEuler24.03系列。

| 序号 | 组件/特性名称                                                |          特性质量评估           |
| :--: | ------------------------------------------------------------ | :-----------------------------: |
|  1   | oedp软件包支持安装在openEuler22.03系列与openEuler24.03系列   | <font color=green>■</font> 通过 |
|  2   | k8s、kubeflow部署支持openEuler22.03系列与openEuler24.03系列，支持任意排列组合的openEuler集群 | <font color=green>■</font> 通过 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.3  性能测试结论

kubeflow部署性能达成测试指标。

| 指标大项 | 指标小项 | 指标值 | 测试用例数 | 测试结论 | 发现问题单数及问题单|
| ------- | ------- | ------ | ------- | ------- | ------------ |
| kubeflow部署性能 | 1. x86 1 master + 1 worker<br />2. x86 1 master + 2 worker<br />3. arm 1 master + 1 worker<br />4. arm 1 master + 2 worker<br />华为云的4U8G虚拟机 | 30分钟 | 4 | <font color=green>■</font> 通过<br />k8s+kubeflow部署实际耗时平均6min10s | 无 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.4  资料测试结论

用户文档：https://gitee.com/openeuler/oeDeploy/blob/master/README.md

katib：https://gitee.com/openeuler/oeDeploy/blob/master/plugins/kubeflow-1.9.1/doc/katib.md

notebook：https://gitee.com/openeuler/oeDeploy/blob/master/plugins/kubeflow-1.9.1/doc/notebook.md

模型发布：https://gitee.com/openeuler/oeDeploy/blob/master/plugins/kubeflow-1.9.1/doc/%E5%9F%BA%E4%BA%8EKServe%E9%83%A8%E7%BD%B2%E4%B8%80%E4%B8%AA%E6%8E%A8%E7%90%86%E6%9C%8D%E5%8A%A1.md

| 测试类型 | 测试内容 | 测试用例数 | 测试结论 |发现问题单数及问题单|
| ------- | ------- | -------- | ------- | ------------ |
| 用户文档 | 主要交付特性都有对应的用户文档，通俗易懂，无明显错误。 | 1 | <font color=green>■</font> 通过 | 无 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好



 



 

 
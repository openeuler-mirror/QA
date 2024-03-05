![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       |修订版本|修改描述| 作者         |
|:---------|:----|:----|:-----------|
| 2024-3-4 |1|初稿| @lin-shoubao|

关键词：

poissonsearch-py

摘要：

在 ```openEuler 22.03 LTS SP3``` 版本中提供 对```poissonsearch-py```进行自编译、安装卸载验证及功能测试。

缩略语清单：

|缩略语|英文全名|中文解释|
|:----|:----|:----|
||  ||

## 1 特性概述

poissonsearch-py是以市场和需求为导向的一款软件，提供对elasticsearch数据库提供的知识检索能力。


## 2 特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                   | 测试起始时间    | 测试结束时间    |
|:-----------------------|:----------|:----------|
| openEuler 22.03 LTS SP3| 2024.2.28 | 2024.2.28 |

描述特性测试的硬件环境信息

| 硬件型号   |硬件配置信息| 备注    |
|:-------|:----|:------|
| 容器     |CPU:8core MEM:32G DISK:200G	| x86架构 |


## 3 测试结论概述

### 3.1 测试整体结论

测试共计执行275个用例，覆盖特性的接口、基本功能用例全部通过，自编译以及安装卸载，无遗留风险，整体质量良好。


|测试活动| tempest集成测试                           |
|:----|:--------------------------------------|
|自编译测试| 自编译功能正常，结果如预期                         |
|安装卸载测试| 安装卸载正常，结果如预期。                         |
|功能测试| 相关测试用例275个，其中Skip 65个，Fail 0个, 其他全通过。 |


### 3.2   约束说明

特性使用时涉及到的约束及限制条件

### 3.3   遗留问题分析

#### 3.3.1 遗留问题影响以及规避措施

|问题单号|问题描述|问题级别|问题影响和规避措施|当前状态|
|:----|:----|:----|:----|:----|
|N/A|N/A|N/A|N/A|N/A|

#### 3.3.2 问题统计

|    | 问题总数 |严重| 主要 |次要|不重要|
|:----|:-----|:----|:---|:----|:----|
|数目| 0    |0| 0  |0|0|
|百分比| 0    |0| 0  |0|0|


## 4 测试执行

### 4.1 测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

|版本名称| 测试用例数 | 用例执行结果                  |发现问题单数|
|:----|:------|:------------------------|:----|
|openEuler 22.03 LTS SP3| 275   | 通过210个，skip 65个，Fail 0个 |0|

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

### 4.2 后续测试建议

后续测试需要关注点(可选)

## 5 附件

*N/A*

## 自编译测试报告

### 执行步骤

```
rpm -ivh *.src.rpm
cd WORK_DIR/rpmbuild/SPECS/
dnf install dnf-plugins-core -y
dnf builddep *.spec
rpmbuild -ba *.spec
```

### 执行结果

```
Processing files: python3-poissonsearch-py-7.10.1-2.noarch
Provides: python-elasticsearch python3-poissonsearch-py = 7.10.1-2 python3.9dist(elasticsearch) = 7.10.1 python3dist(elasticsearch) = 7.10.1
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PartialHardlinkSets) <= 4.0.4-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires: python(abi) = 3.9 python3.9dist(certifi) python3.9dist(urllib3) >= 1.21.1 python3.9dist(urllib3) < 2
Processing files: poissonsearch-py-help-7.10.1-2.noarch
warning: Empty %files file /root/rpmbuild/BUILD/poissonsearch-py-7.10.1/doclist.lst
Provides: poissonsearch-py-help = 7.10.1-2 python3-poissonsearch-py-doc
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Checking for unpackaged file(s): /usr/lib/rpm/check-files /root/rpmbuild/BUILDROOT/poissonsearch-py-7.10.1-2.x86_64
Wrote: /root/rpmbuild/SRPMS/poissonsearch-py-7.10.1-2.src.rpm
Wrote: /root/rpmbuild/RPMS/noarch/poissonsearch-py-help-7.10.1-2.noarch.rpm
Wrote: /root/rpmbuild/RPMS/noarch/python3-poissonsearch-py-7.10.1-2.noarch.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.zKgQug
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd poissonsearch-py-7.10.1
+ /usr/bin/rm -rf /root/rpmbuild/BUILDROOT/poissonsearch-py-7.10.1-2.x86_64
+ RPM_EC=0
++ jobs -p
+ exit 0
```

测试通过

## 安装卸载测试报告

### 执行步骤

```
cd WORK_DIR/rpmbuild/RPM/noarch/
rpm -i *.rpm
rpm -e python3-poissonsearch-py-7.10.1-2
```

### 执行结果

安装和卸载均成功，测试通过

## 功能测试覆盖率

![avatar](../../images/openEuler.png)

版权所有 © 2022 openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (
但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期        | 修订   版本 | 修改描述 | 作者  |
|-----------|---------|------|-----|
| 2023.1.29 | v1.0    | 初始化  | 汪庆华 |

关键词： jieba测试报告

摘要：依据测试要求，对jieba进行自编译、安装卸载验证及功能测试。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
|-----|------|------|
|     |      |      |
|     |      |      |

# 1     特性概述

本测试报告为jieba 0.42.1-1.oe2203sp1 在openEuler22.03_LTS 操作系统上的测试报告，目的在于总结测试阶段发现的问题以及按版本及平台测试结果，测试的范围主要包括安装、使用、功能等。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                | 测试起始时间    | 测试结束时间    |
|---------------------|-----------|-----------|
| openEuler 22.03_LTS | 2023-1-29 | 2023-1-29 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息                      | 备注        |
|------|-----------------------------|-----------|
| 容器   | CPU:8core MEM:32G DISK:200G | x86架构     |
| 容器   | CPU:8core MEM:32G DISK:200G | aarch64架构 |

# 3     测试结论概述

## 3.1   测试整体结论

jieba特性，共执行16个单点测试用例以及1个带有10个不同功能用例的测试套，代码覆盖率90%。覆盖特性的基本功能，自编译以及安装卸载，不涉及命令验证和服务验证。未发现问题，所有测试点全部通过

| 测试活动   | 活动评价                       |
|--------|----------------------------|
| 自编译测试  | 自编译功能正常，结果如预期              |
| 安装卸载测试 | 安装卸载正常，结果如预期               |
| 功能测试   | 服务与命令行功能正常，结果如预期，安装包升级功能正常 |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
|------|------|------|-----------|------|
|      |      |      |           |      |
|      |      |      |           |      |

### 3.3.2 问题统计

|     | 问题总数 | 严重  | 主要  | 次要  | 不重要 |
|-----|------|-----|-----|-----|-----|
| 数目  | 0    |     |     |     |     |
| 百分比 |      |     |     |     |     |

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                | 测试用例数 | 用例执行结果   | 发现问题单数 |
|---------------------|-------|----------|--------|
| openEuler 22.03_LTS | 26    | ALL PASS | 0      |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

*此处可粘贴各类专项测试数据或报告*

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
Processing files: python3-jieba-0.42.1-1.noarch
Provides: jieba python3-jieba = 0.42.1-1 python3.9dist(jieba) = 0.42.1 python3dist(jieba) = 0.42.1
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PartialHardlinkSets) <= 4.0.4-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires: python(abi) = 3.9
Checking for unpackaged file(s): /usr/lib/rpm/check-files /root/rpmbuild/BUILDROOT/jieba-0.42.1-1.x86_64
Wrote: /root/rpmbuild/SRPMS/jieba-0.42.1-1.src.rpm
Wrote: /root/rpmbuild/RPMS/noarch/python3-jieba-0.42.1-1.noarch.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.IxeJNj
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd jieba-0.42.1
+ /usr/bin/rm -rf /root/rpmbuild/BUILDROOT/jieba-0.42.1-1.x86_64
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
rpm -e python3-jieba-0.42.1-1
```

### 执行结果

安装和卸载均成功，测试通过

## 功能测试覆盖率

| Name                                 | Stmts | Miss | Cover |
|--------------------------------------|-------|------|-------|
| jieba/jieba/__init__.py              | 437   | 78   | 82%   |
| jieba/jieba/_compat.py               | 58    | 31   | 47%   |
| jieba/jieba/analyse/__init__.py      | 15    | 2    | 87%   |
| jieba/jieba/analyse/analyzer.py      | 22    | 0    | 100%  |
| jieba/jieba/analyse/textrank.py      | 70    | 4    | 94%   |
| jieba/jieba/analyse/tfidf.py         | 76    | 21   | 72%   |
| jieba/jieba/finalseg/__init__.py     | 72    | 6    | 92%   |
| jieba/jieba/finalseg/prob_emit.py    | 2     | 0    | 100%  |
| jieba/jieba/finalseg/prob_start.py   | 1     | 0    | 100%  |
| jieba/jieba/finalseg/prob_trans.py   | 1     | 0    | 100%  |
| jieba/jieba/posseg/__init__.py       | 226   | 52   | 77%   |
| jieba/jieba/posseg/char_state_tab.py | 2     | 0    | 100%  |
| jieba/jieba/posseg/prob_emit.py      | 2     | 0    | 100%  |
| jieba/jieba/posseg/prob_start.py     | 1     | 0    | 100%  |
| jieba/jieba/posseg/prob_trans.py     | 1     | 0    | 100%  |
| jieba/jieba/posseg/viterbi.py        | 36    | 2    | 94%   |
| demo.py                              | 59    | 0    | 100%  |
| jieba_test.py                        | 102   | 0    | 100%  |
| test.py                              | 97    | 0    | 100%  |
| test_bug.py                          | 8     | 0    | 100%  |
| test_change_dictpath.py              | 23    | 0    | 100%  |
| test_cut_for_search.py               | 94    | 0    | 100%  |
| test_cutall.py                       | 97    | 0    | 100%  |
| test_multithread.py                  | 21    | 0    | 100%  |
| test_no_hmm.py                       | 95    | 0    | 100%  |
| test_pos.py                          | 95    | 0    | 100%  |
| test_pos_no_hmm.py                   | 95    | 0    | 100%  |
| test_tokenize.py                     | 100   | 0    | 100%  |
| test_tokenize_no_hmm.py              | 100   | 0    | 100%  |
| test_userdict.py                     | 29    | 0    | 100%  |
| test_whoosh.py                       | 30    | 0    | 100%  |
| test_whoosh_file.py                  | 30    | 16   | 47%   |
| test_whoosh_file_read.py             | 22    | 2    | 91%   |
| TOTAL                                | 2119  | 214  | 90%   |


 

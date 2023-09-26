![avatar](../../images/openEuler.png)

版权所有 © 2022 openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA
4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (
但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期        | 修订   版本 | 修改描述 | 作者  |
|-----------|---------|------|-----|
| 2023.8.23 | v1.0    | 初始化  | 林守宝 |

关键词： python docx测试报告

摘要：依据测试要求，对python docx进行自编译、安装卸载验证及功能测试。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
|-----|------|------|
|     |      |      |
|     |      |      |

# 1     特性概述

本测试报告为python docx 0.8.11-1.oe2203sp1 在openEuler22.03_LTS_SP1 操作系统上的测试报告，目的在于总结测试阶段发现的问题以及按版本及平台测试结果，测试的范围主要包括安装、使用、功能等。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                 | 测试起始时间    | 测试结束时间    |
|-------------------------|----------------|----------------|
| openEuler 22.03_LTS_SP1 | 2023-8-23      | 2023-8-23      |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息                      | 备注        |
|------|-----------------------------|-----------|
| 容器   | CPU:8core MEM:32G DISK:200G | x86架构     |
| 容器   | CPU:8core MEM:32G DISK:200G | aarch64架构 |

# 3     测试结论概述

## 3.1   测试整体结论

python docx特性，共执行40个单点测试用例，代码覆盖率98%。覆盖特性的基本功能，自编译以及安装卸载，不涉及命令验证和服务验证。未发现问题，所有测试点全部通过

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

| 版本名称                 | 测试用例数 | 用例执行结果   | 发现问题单数 |
|-------------------------|-----------|---------------|-------------|
| openEuler 22.03_LTS_SP1 | 40       | ALL PASS      | 0           |

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
Processing files: python3-python-docx-0.8.11-1.noarch
Provides: python-python-docx = 0.8.11-1 python3-python-docx = 0.8.11-1 python3.9dist(python-docx) = 0.8.11 python3dist(python-docx) = 0.8.11
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PartialHardlinkSets) <= 4.0.4-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires: python(abi) = 3.9 python3.9dist(lxml) >= 2.3.2
Processing files: python-python-docx-help-0.8.11-1.noarch
warning: Empty %files file /root/rpmbuild/BUILD/python-docx-0.8.11/doclist.lst
Provides: python-python-docx-help = 0.8.11-1 python3-python-docx-doc
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Checking for unpackaged file(s): /usr/lib/rpm/check-files /root/rpmbuild/BUILDROOT/python-python-docx-0.8.11-1.x86_64
Wrote: /root/rpmbuild/SRPMS/python-python-docx-0.8.11-1.src.rpm
Wrote: /root/rpmbuild/RPMS/noarch/python-python-docx-help-0.8.11-1.noarch.rpm
Wrote: /root/rpmbuild/RPMS/noarch/python3-python-docx-0.8.11-1.noarch.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.dwzNnu
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd python-docx-0.8.11
+ /usr/bin/rm -rf /root/rpmbuild/BUILDROOT/python-python-docx-0.8.11-1.x86_64
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
rpm -e python3-python-docx-0.8.11-1
```

### 执行结果

安装和卸载均成功，测试通过

## 功能测试覆盖率

| Module                               | statements| missing| coverage |
|--------------------------------------|-----------|--------|----------|
| docx\__init__.py                     | 24        | 0      | 100%     |
| docx\api.py                          | 15        | 2      | 87%      |
| docx\blkcntnr.py                     | 28        | 0      | 100%     |
| docx\compat.py                       | 14        | 5      | 64%      |
| docx\dml\__init__.py                 | 0         | 0      | 100%     |
| docx\dml\color.py                    | 48        | 0      | 100%     |
| docx\document.py                     | 67        | 0      | 100%     |
| docx\enum\__init__.py                | 7         | 2      | 71%      |
| docx\enum\base.py                    | 135       | 4      | 97%      |
| docx\enum\dml.py                     | 12        | 0      | 100%     |
| docx\enum\section.py                 | 18        | 0      | 100%     |
| docx\enum\shape.py                   | 9         | 0      | 100%     |
| docx\enum\style.py                   | 12        | 0      | 100%     |
| docx\enum\table.py                   | 21        | 0      | 100%     |
| docx\enum\text.py                    | 42        | 0      | 100%     |
| docx\exceptions.py                   | 4         | 0      | 100%     |
| docx\image\__init__.py               | 8         | 0      | 100%     |
| docx\image\bmp.py                    | 22        | 0      | 100%     |
| docx\image\constants.py              | 81        | 0      | 100%     |
| docx\image\exceptions.py             | 4         | 0      | 100%     |
| docx\image\gif.py                    | 18        | 0      | 100%     |
| docx\image\helpers.py                | 47        | 0      | 100%     |
| docx\image\image.py                  | 98        | 0      | 100%     |
| docx\image\jpeg.py                   | 191       | 0      | 100%     |
| docx\image\png.py                    | 129       | 0      | 100%     |
| docx\image\tiff.py                   | 116       | 0      | 100%     |
| docx\opc\__init__.py                 | 0         | 0      | 100%     |
| docx\opc\compat.py                   | 13        | 5      | 62%      |
| docx\opc\constants.py                | 172       | 0      | 100%     |
| docx\opc\coreprops.py                | 65        | 0      | 100%     |
| docx\opc\exceptions.py               | 3         | 0      | 100%     |
| docx\opc\oxml.py                     | 97        | 0      | 100%     |
| docx\opc\package.py                  | 100       | 3      | 97%      |
| docx\opc\packuri.py                  | 45        | 1      | 98%      |
| docx\opc\part.py                     | 85        | 2      | 98%      |
| docx\opc\parts\__init__.py           | 0         | 0      | 100%     |
| docx\opc\parts\coreprops.py          | 24        | 0      | 100%     |
| docx\opc\phys_pkg.py                 | 63        | 0      | 100%     |
| docx\opc\pkgreader.py                | 140       | 0      | 100%     |
| docx\opc\pkgwriter.py                | 50        | 1      | 98%      |
| docx\opc\rel.py                      | 86        | 6      | 93%      |
| docx\opc\shared.py                   | 20        | 0      | 100%     |
| docx\opc\spec.py                     | 3         | 0      | 100%     |
| docx\oxml\__init__.py                | 139       | 0      | 100%     |
| docx\oxml\coreprops.py               | 170       | 12     | 93%      |
| docx\oxml\document.py                | 22        | 1      | 95%      |
| docx\oxml\exceptions.py              | 3         | 0      | 100%     |
| docx\oxml\ns.py                      | 32        | 1      | 97%      |
| docx\oxml\numbering.py               | 44        | 21     | 52%      |
| docx\oxml\section.py                 | 173       | 6      | 97%      |
| docx\oxml\settings.py                | 16        | 0      | 100%     |
| docx\oxml\shape.py                   | 102       | 16     | 84%      |
| docx\oxml\shared.py                  | 18        | 4      | 78%      |
| docx\oxml\simpletypes.py             | 184       | 26     | 86%      |
| docx\oxml\styles.py                  | 172       | 4      | 98%      |
| docx\oxml\table.py                   | 407       | 13     | 97%      |
| docx\oxml\text\__init__.py           | 0         | 0      | 100%     |
| docx\oxml\text\font.py               | 173       | 9      | 95%      |
| docx\oxml\text\paragraph.py          | 38        | 1      | 97%      |
| docx\oxml\text\parfmt.py             | 183       | 5      | 97%      |
| docx\oxml\text\run.py                | 77        | 1      | 99%      |
| docx\oxml\xmlchemy.py                | 323       | 6      | 98%      |
| docx\package.py                      | 59        | 5      | 92%      |
| docx\parts\__init__.py               | 0         | 0      | 100%     |
| docx\parts\document.py               | 63        | 1      | 98%      |
| docx\parts\hdrftr.py                 | 28        | 0      | 100%     |
| docx\parts\image.py                  | 34        | 0      | 100%     |
| docx\parts\numbering.py              | 15        | 1      | 93%      |
| docx\parts\settings.py               | 21        | 0      | 100%     |
| docx\parts\story.py                  | 28        | 0      | 100%     |
| docx\parts\styles.py                 | 21        | 0      | 100%     |
| docx\section.py                      | 154       | 5      | 97%      |
| docx\settings.py                     | 9         | 0      | 100%     |
| docx\shape.py                        | 51        | 0      | 100%     |
| docx\shared.py                       | 98        | 2      | 98%      |
| docx\styles\__init__.py              | 10        | 0      | 100%     |
| docx\styles\latent.py                | 71        | 0      | 100%     |
| docx\styles\style.py                 | 88        | 2      | 98%      |
| docx\styles\styles.py                | 65        | 0      | 100%     |
| docx\table.py                        | 180       | 0      | 100%     |
| docx\text\__init__.py                | 0         | 0      | 100%     |
| docx\text\font.py                    | 145       | 1      | 99%      |
| docx\text\paragraph.py               | 53        | 0      | 100%     |
| docx\text\parfmt.py                  | 132       | 0      | 100%     |
| docx\text\run.py                     | 58        | 2      | 97%      |
| docx\text\tabstops.py                | 59        | 0      | 100%     |
| tests\__init__.py                    | 0         | 0      | 100%     |
| tests\dml\__init__.py                | 0         | 0      | 100%     |
| tests\dml\test_color.py              | 50        | 0      | 100%     |
| tests\image\__init__.py              | 0         | 0      | 100%     |
| tests\image\test_bmp.py              | 23        | 0      | 100%     |
| tests\image\test_gif.py              | 23        | 0      | 100%     |
| tests\image\test_helpers.py          | 29        | 0      | 100%     |
| tests\image\test_image.py            | 193       | 1      | 99%      |
| tests\image\test_jpeg.py             | 324       | 0      | 100%     |
| tests\image\test_png.py              | 243       | 0      | 100%     |
| tests\image\test_tiff.py             | 221       | 1      | 99%      |
| tests\opc\__init__.py                | 0         | 0      | 100%     |
| tests\opc\parts\__init__.py          | 0         | 0      | 100%     |
| tests\opc\parts\test_coreprops.py    | 31        | 0      | 100%     |
| tests\opc\test_coreprops.py          | 71        | 1      | 99%      |
| tests\opc\test_oxml.py               | 84        | 0      | 100%     |
| tests\opc\test_package.py            | 238       | 0      | 100%     |
| tests\opc\test_packuri.py            | 48        | 2      | 96%      |
| tests\opc\test_part.py               | 264       | 0      | 100%     |
| tests\opc\test_phys_pkg.py           | 118       | 3      | 97%      |
| tests\opc\test_pkgreader.py          | 244       | 4      | 98%      |
| tests\opc\test_pkgwriter.py          | 101       | 1      | 99%      |
| tests\opc\test_rel.py                | 149       | 0      | 100%     |
| tests\opc\unitdata\__init__.py       | 0         | 0      | 100%     |
| tests\opc\unitdata\rels.py           | 143       | 18     | 87%      |
| tests\opc\unitdata\types.py          | 25        | 0      | 100%     |
| tests\oxml\__init__.py               | 0         | 0      | 100%     |
| tests\oxml\parts\__init__.py         | 0         | 0      | 100%     |
| tests\oxml\parts\test_document.py    | 23        | 0      | 100%     |
| tests\oxml\parts\unitdata\__init__.py| 0         | 0      | 100%     |
| tests\oxml\parts\unitdata\document.py| 14        | 0      | 100%     |
| tests\oxml\test__init__.py           | 61        | 0      | 100%     |
| tests\oxml\test_ns.py                | 32        | 0      | 100%     |
| tests\oxml\test_styles.py            | 16        | 0      | 100%     |
| tests\oxml\test_table.py             | 159       | 0      | 100%     |
| tests\oxml\test_xmlchemy.py          | 434       | 1      | 99%      |
| tests\oxml\text\__init__.py          | 0         | 0      | 100%     |
| tests\oxml\text\test_run.py          | 14        | 0      | 100%     |
| tests\oxml\unitdata\__init__.py      | 0         | 0      | 100%     |
| tests\oxml\unitdata\dml.py           | 124       | 19     | 85%      |
| tests\oxml\unitdata\numbering.py     | 14        | 0      | 100%     |
| tests\oxml\unitdata\shared.py        | 20        | 6      | 70%      |
| tests\oxml\unitdata\table.py         | 53        | 4      | 92%      |
| tests\oxml\unitdata\text.py          | 114       | 32     | 72%      |
| tests\parts\__init__.py              | 0         | 0      | 100%     |
| tests\parts\test_document.py         | 202       | 0      | 100%     |
| tests\parts\test_hdrftr.py           | 81        | 0      | 100%     |
| tests\parts\test_image.py            | 69        | 0      | 100%     |
| tests\parts\test_numbering.py        | 34        | 0      | 100%     |
| tests\parts\test_settings.py         | 46        | 0      | 100%     |
| tests\parts\test_story.py            | 85        | 0      | 100%     |
| tests\parts\test_styles.py           | 32        | 0      | 100%     |
| tests\styles\__init__.py             | 0         | 0      | 100%     |
| tests\styles\test_latent.py          | 153       | 0      | 100%     |
| tests\styles\test_style.py           | 257       | 0      | 100%     |
| tests\styles\test_styles.py          | 214       | 0      | 100%     |
| tests\test_api.py                    | 45        | 0      | 100%     |
| tests\test_blkcntnr.py               | 79        | 0      | 100%     |
| tests\test_document.py               | 233       | 0      | 100%     |
| tests\test_enum.py                   | 49        | 0      | 100%     |
| tests\test_package.py                | 91        | 0      | 100%     |
| tests\test_section.py                | 385       | 0      | 100%     |
| tests\test_settings.py               | 25        | 0      | 100%     |
| tests\test_shape.py                  | 105       | 0      | 100%     |
| tests\test_shared.py                 | 76        | 0      | 100%     |
| tests\test_table.py                  | 532       | 0      | 100%     |
| tests\text\__init__.py               | 0         | 0      | 100%     |
| tests\text\test_font.py              | 134       | 0      | 100%     |
| tests\text\test_paragraph.py         | 161       | 0      | 100%     |
| tests\text\test_parfmt.py            | 168       | 0      | 100%     |
| tests\text\test_run.py               | 168       | 0      | 100%     |
| tests\text\test_tabstops.py          | 141       | 0      | 100%     |
| tests\unitdata.py                    | 72        | 8      | 89%      |
| tests\unitutil\__init__.py           | 0         | 0      | 100%     |
| tests\unitutil\cxml.py               | 119       | 1      | 99%      |
| tests\unitutil\file.py               | 25        | 2      | 92%      |
| tests\unitutil\mock.py               | 51        | 10     | 80%      |
| Total                                | 13386     | 290    | 98%      |

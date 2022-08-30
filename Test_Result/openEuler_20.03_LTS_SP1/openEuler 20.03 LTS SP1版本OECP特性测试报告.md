![openEuler ico](../../images/openEuler.png)

版权所有 © 2022 openEuler社区 
您对“本文档”的复制、使用、修改及分发受知识共享(CreativeCommons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA4.0”)的约束。为了方便用户理解，您可以通过访问<https://creativecommons.org/licenses/by-sa/4.0/>了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA4.0的完整协议内容您可以访问如下网址获取：<https://creativecommons.org/licenses/by-sa/4.0/legalcode>。

修订记录

| Date 日期 | Revision Version 修订版本 | CR ID CR号 | Section Numbe 修改章节 | Change Description 修改描述 |  
| --------- | ------------------------- | ---------- | ---------------------- | ----------------------------|
|2022/07/20 | OECP 1.0                  |            |                        |              创建           | 

Keywords 关键词：openEuler OECP特性 测试报告

摘要：按照测试要求，使用OECP工具对不同的两个iso镜像进行比较，包括工具的安装使用、iso比较、比较结果的正确性验证等主要功能进行测试。

# 概述

本测试报告为OECP在openEuler20.03-LTS-SP1操作系统上对各种不同的iso进行比较的测试报告，目的在于验证工具可用性，以及比较结果的正确性等。

# 测试版本说明

## 工具说明

### 工具来源
https://gitee.com/openeuler/oecp.git

### 语法格式
python3 cli.py [参数] 软件包目录/软件包/镜像
可选参数举例ython3 cli.py [-h] [-n PARALLEL] [-w WORK_DIR] [-p PLAN_PATH] [-c CATEGORY_PATH] [-b PERF_BASELINE_FILE] [-f OUTPUT_FORMAT] [-o OUTPUT_FILE] file file

###常用参数说明
|参数|是否必选|解释说明|取值|
|----|-------|-------|----|
|-v, --version|否|指定版本，默认为OECP 1.0|用户指定|
|-d, --debuginfo|否|比较时携带debuginfo包|NA|
|-n, --parallel|否|指定进程池并发数量，默认cpu核数|自然数|
|-w, --work-dir|否|指定工作路径，默认路径为/tmp/oecp|用户指定|
|-p, --plan|否|指定比较计划，默认执行全部计划oecp/conf/plan/all.json|用户可指定自定义计划，详见plan特性说明，当前可选计划详见子标题|
|-c, --category|否|指定包级别信息，生成的报告中category level为指定的json文件中包的级别，默认为src/conf/category/category.json|用户输入，格式见category.json：openEuler 软件包兼容性分级|
|-f, --format|否|指定输出格式，默认为csv|json,csv|
|-o, --output|否|指定输出结果路径，默认为/tmp/oecp|用户指定|
|-b, --baseline|否|指定性能测试基线文件路径， 默认为：oecp/conf/performance/baseline-openEuler-20.03-LTS-SP1-everything-aarch64-dvd.iso.performance.json|	用户指定|

#### 当前可选择的计划：
- oecp/conf/plan/all.json：涵盖下面所有配置项的比较；
- oecp/conf/plan/package_list.json：比较iso中包列表；
- oecp/conf/plan/cmd.json：文件级别比较命令文件；
- oecp/conf/plan/config_file.json；比较rpm包的配置文件信息；
- oecp/conf/plan/kconfig.json：比较内核配置文件信息；
- oecp/conf/plan/kabi.json：比较内核rpm包的abi接口信息；
- oecp/conf/plan/jabi.json：比较rpm中jar包的java接口信息；
- oecp/conf/plan/abi.json：比较rpm包中so库文件的abi接口信息；
- oecp/conf/plan/kconfig_drive.json：比较内核驱动的配置文件信息；
- oecp/conf/plan/service.json：比较软件启动文件的配置信息；
- oecp/conf/plan/header.json：文件级别比较头文件，不比较详细信息；
- oecp/conf/plan/provides_requires.json：比较提供的符号及依赖的符号；
- oecp/conf/plan/lib.json：文件级别比较so和jar包abi；
- oecp/conf/plan/file_list.json：文件级别比较除其他比较项涵盖文件的其他类型文件

### 工具测试
|参数项|是否指定|成功与否|执行结果目录及文件检查|
|-----|--------|--------|----------|
|-v, --version|是/否|是|正确|
|-d, --debuginfo|是/否|是|正确|
|-n, --parallel|是/否|是|正确|
|-w, --work-dir|是/否|是|正确|
|-p, --plan|是/否|是|正确|
|-c, --category|是/否|是|正确|
|-f, --format|是/否|是|正确|
|-o, --output|是/否|是|正确|
|-b, --baseline|是/否|是|正确|

## 测试版本信息

### 被测版本

| 版本名称 | 测试时间      | 结束时间      | 备注 |
| -------- | ------------- | ------------- | -------- |
| OECP 1.0 | 2022年7月9 日 | 2022年7月12日 | 第一轮测试 |

### 被测的iso

|iso_A           |iso_B     |架构      |指定plan生成结果|CMP_RESULT校验|CMP_TYPE校验|
|----------------|----------|----------|---------------|-------------|------------|
|Anolis 8.2      |CentOs 8.2|x86_64    |成功|正确|正确|
|CentOs 8.2      |Anolis 8.2|x86_64    |成功|正确|正确|
|openEuler SP1   |CentOs 8.4|x86_64    |成功|正确|正确|
|Fedora 36       |RedHat 8.6|x86_64    |成功|正确|正确|
|openEuler SP1|OpenSUSE 15.4|aarch64   |成功|正确|正确|
|openEuler SP1   |CentOs 8.4|aarch64   |成功|正确|正确|
|Anolis 8.4      |CentOs 8.4|aarch64   |成功|正确|正确|

# 版本概要测试结论、关键风险和规避措施

## 测试结论总结

### 工具总体评估

-OECP 1.0在测试过程中可以正常进行使用，执行30个测试项，核心功能稳定正常。
检查工具比较的结果文件，执行15个测试项，核心功能点正确。

# 版本详细测试结论

## 问题单统计

|缺陷编号  | 描述                         | Gitee链接                                                         |当前状态|
| -------- | ---------------------------- |------------------------------------------------------------------ | ------ |
| I5H0V0   |两次生成的csv中内容显示不一致 | https://gitee.com/openeuler/oecp/issues/I5H0V0?from=project-issue | 解决中 |
| I5GZUE   |csv中rpm包数量和iso中不一致   | https://gitee.com/openeuler/oecp/issues/I5GZUE?from=project-issue | 解决中 |
| I5H1AT   |含有files选项,rpm查询目录为空 | https://gitee.com/openeuler/oecp/issues/I5H1AT?from=project-issue | 解决中 |

## 测试执行统计

| 版本名称 | 测试用例规模 |异常用例 | 用例执行 | 发现缺陷数 | 手工执行用例数 |自动化执行用例数 |自动化率 |
| ------- | ----------- |-------- | ------- | --------- | ------------ | -------------- | ------- |
| OECP 1.0 | 45         |12       |45       | 5        | 5         | 40             | 89%   |

# 附件
测试用例：https://gitee.com/hanson_fang/ltpstress-for-openeuler/tree/master/oecp/oecp_testcases.xlsx  
结果校验脚本：https://gitee.com/hanson_fang/ltpstress-for-openeuler/tree/master/oecp/oecp_compare_result.py  
OECP使用说明：https://gitee.com/hanson_fang/ltpstress-for-openeuler/tree/master/oecp/OECP功能测试文档.docx

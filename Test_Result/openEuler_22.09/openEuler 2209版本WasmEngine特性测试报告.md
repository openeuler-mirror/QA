![avatar](../images/openEuler.png)


版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2022-08-17|1.0|初稿完成|王刚强|
|2022-09-06|2.0|第二版完成|王刚强      |

 关键词：WebAssembly/Webh汇编语言, Sandbox/沙箱，FaaS/函数计算即服务 

摘要：轻量级Wasm沙箱引擎主要面向函数计算场景的提供轻量级高性能的函数运行安全隔离环境，通过高效的用户态函数调度算法，提高函数执行的吞吐量。
	The lightweight Wasm sandbox engine provides a lightweight and high-performance function running security isolation environment for function computing scenarios. It uses an efficient user-mode function scheduling algorithm to improve the function execution throughput.

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|  Wasm|WebAssembly|WebAssembly是一个可移植、体积小、加载快并且兼容 Web 的全新格式|
|OCI|Open Container Initiative|OCI是Linux基金会旗下负责操作系统层虚拟化(容器) 开放标准，OCI标准定义了容器运行时和镜像规范|
|FaaS|Function as a Service|函数即服务|
|EDF|Earliest Deadline First|最早截止时间 (EDF) 是一个实时操作系统中使用的，动态优先级的将进程放入优先队列的算法|

# 1     特性概述

&emsp;&emsp;WebAssembly（简称Wasm）是W3C的一项开放标准，其愿景是使不同语言代码在不同平台上通过统一IR实现高效的运行。Wasm凭借安全、可移植、底层代码格式和高性能的能力，Wasm成为业界关注的热点。Wasm沙箱轻量级内存底噪、毫秒级极速冷启动速度，非常适合作为FaaS场景下函数的运行环境。本系统设计的轻量级Wasm沙箱引擎主要面向云原生场景的提供轻量级高性能的函数运行安全隔离环境，通过高效的用户态函数调度算法，提高Wasm函数执行的吞吐量。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                 | 测试起始时间 | 测试结束时间 | 备注 |
| ----------------------- | ------------ | ------------ | --- | 
| openEuler 22.09 RC1(实际) | 2022-08-08(延期7天) | 2022-08-14| |
| openEuler 22.09 RC2(实际) | 2022-08-15(延期7天) | 2022-08-21| |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|openeuler 22.09|              |      |

# 3     测试结论概述

## 3.1   测试整体结论

&emsp;&emsp;wasm_engine特性，共计执行10个用例，主要覆盖了接口、功能、性能测试，发现问题已解决，回归通过，无遗留风险，整体质量良好。

## 3.2   约束说明

1.	Wasm目标格式需要满足WebAssembly Spec 1.0正式标准
2.	如果应用程序需要WASI能力支持，只支持通过wasi-sdk或rust语言的wasm32-unknown-wasi编译工具链编译得到的Wasm模块
3.	不支持设置每个函数调用的资源限额
4.	只支持单函数运行模型，不支持函数间调用模型
5.	Wasm函数镜像中只允许有一个wasm格式模块文件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

暂无

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |      1    |      |      |      |    1    |
| 百分比 |      100%    |      |      |      |    100%    |

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|https://gitee.com/openeuler/WasmEngine/issues/I5L1XX | 接口调用输出信息不一致|低|修改调用输出信息|  已修复   |

# 4     测试执行

## 4.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|WasmEngine-v0.1.2-1.oe2209|10|通过| 1|
|WasmEngine-v0.1.2-3.oe2209|10|通过| 0|

## 4.2   后续测试建议

关注性能方面，不劣化。

# 5     附件

```
sh /root/openeuler/zatanna/runtest.sh -d /root/openeuler/container-test/wasm/testcases/ testCE_wasm_delete_para002.sh:PASS[2022-08-08-19-31-50] testCE_wasm_deploy_para001.sh:PASS[2022-08-08-19-31-56]
testCE_wasm_FUN001.sh:PASS[2022-08-08-19-32-03]
testCE_wasm_FUN002.sh:PASS[2022-08-08-19-32-09]
testCE_wasm_FUN003.sh:PASS[2022-08-08-19-32-15]
testCE_wasm_FUN004.sh:PASS[2022-08-08-19-32-23]
testCE_wasm_FUN005.sh:PASS[2022-08-08-19-32-38]
testCE_wasm_performance001.sh:PASS[2022-08-08-19-32-45] testCE_wasm_performance002.sh:PASS[2022-08-08-19-32-56] testCE_wasm_query_para003.sh:PASS[2022-08-08-19-33-02]
|[2022-08-08-19-33-02]| Total Testcase: 10 | SKIP: 0 | FAIL: 0 | PASS: 10 | PASS Rate: 100.00 % |
```

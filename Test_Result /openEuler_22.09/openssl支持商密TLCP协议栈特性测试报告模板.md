![avatar](../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录
| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2022年9月6日|初稿|openssl支持商密TLCP协议 测试报告|刘扬媚|

关键词：TLCP

摘要：

缩略语清单：
| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述
  TLCP是指符合《GB/T38636 2020信息安全技术 传输层密码协议（TLCP）》的安全通信协议，其特点是采用加密证书/私钥和签名证书/私钥相分离的方式。openEuler 22.09版本之后发布的openSSL软件在开源版本的基础上增加了对商密TLCP协议的支持，提供了如下主要的功能：
- 新增对TLCP商密双证书加载的支持；
- 新增对ECC_SM4_CBC_SM3和ECDHE_SM4_CBC_SM3算法套的支持；
- 新增对SM2证书的支持。

# 2     特性测试信息
本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。
| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|openEuler 22.09 RC1|2022-08-05|2022-08-12|

# 3     测试结论概述
## 3.1   测试整体结论
openssl支持商密TLCP协议特性，共计执行3个用例，主要覆盖了功能测试，暂未发现问题，回归通过，无遗留风险，整体质量良好。
| 测试活动 | 活动评价            |
| -------- | ------------------- |
| 功能测试 | 共计执行3个测试用例 |
## 3.2   约束说明
openEuler操作系统安装的openSSL软件版本号大于1.1.1m-4。
## 3.3   遗留问题分析
### 3.3.1 遗留问题影响以及规避措施
暂无
### 3.3.2 问题统计
暂无

# 4     测试执行
## 4.1   测试执行统计数据
*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*
| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|openEuler 22.09|3|通过|0|
*数据项说明：*
*测试用例数－－到本测试活动结束时，所有可用测试用例数；*
*发现问题单数－－本测试活动总共发现的问题单数。*

# 5     附件
开源用例执行情况：
../test/recipes/85-test_tlcp.t  .......................ok

手动执行情况：
[root@openEuler src]# ./server

server listen port = 4422

**** connected suite = ECDHE-SM4-CBC-SM3

**** version is = TLCP

[server handler] msg = this is client!

[root@openEuler src]# ./ecc-server

server listen port = 4422

**** connected suite = ECC-SM4-CBC-SM3

**** version is = TLCP

[server handler] msg = this is client!
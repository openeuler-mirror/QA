版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。
修订记录
| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2022-09-15      |   1.0          |  创建        |    @xukuohai  |
关键词： 
BPF、XDP、Redis、性能优化
摘要：
本报告主要描述基于openEuler 22.09版本进行的BMC for Redis测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。

# 1     特性概述

Redis是一种用户态key/value数据库，可以利用eBPF的MAP为Redis构建内核态缓存，当请求命中内核态缓存时，直接由eBPF从内核态将value返回，绕过内核协议栈与用户态处理，提升性能.

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。
| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 22.09 Test round 4         | 2022-09-08             |  2022-09-15            |
描述特性测试的硬件环境信息
| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |

| BMC01        | Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz, 3.8GB RAM, virtio_net             | KVM虚拟机           |

| BMC02        | Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz, 3.8GB RAM, virtio_net             | KVM虚拟机           |

# 3     测试结论概述

## 3.1   测试整体结论

Redis BMC特性，共计执行8个用例，主要覆盖了基本功能测试和性能测试，在cache命中和不命中时，redis功能均正常，cache命中时，时延由0.127ms下降至0.087ms，优化31.5%.

## 3.2   约束说明

当前bmc只支持字符串类型的key和value，key最长为64字节，value最长为128字节.

# 4     测试执行

## 4.1   测试执行统计数据

| 版本名称                         | 测试用例数 | 用例执行结果   | 发现问题单数 |
| ---------------------------- | ----- | -------- | ------ |
| openEuler 22.09 Test round 4 | 8     | All Pass | 0      |

# 5     附件

执行以下压测命令：

```
./redis-benchmark -c 10 -r 1 -n 1000 -t get  -h 192.168.4.101 -q -n 1000000
```

未使能BMC结果

```
GET: 62684.13 requests per second, p50=0.127 msec
```

使能BMC结果

```
GET: 77808.90 requests per second, p50=0.087 msec
```

时延从0.127ms优化到0.087ms.

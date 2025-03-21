![avatar](../../images/openEuler.png)

版权所有 © 2024  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|  2024-12-17  |           V1.0  |      创建      |  陈仕娟    |
|  2024-12-20  |           V1.1  |      补充继承特性遗留问题      |  陈仕娟    |

关键词：redis主从 redis集群 xdp

摘要：gazelle是一款高性能用户态协议栈。它基于DPDK在用户态直接读写网卡报文，共享大页内存传递报文，使用轻量级LwIP协议栈。能够大幅提高应用的网络I/O吞吐能力

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|     XDP   |   eXpress Data Path     | 快速数据路径（Linux内核提供的高性能，可编程的网络数据包处理框架）      |
# 1     特性概述

本次京东数据库业务使能gazelle调优，OS ipvlan和gazelle需支持XDP特性，新增的功能点包含四部分内容，一个基于京东组网环境支持对XDP网卡转发，一个是基于降低CPU使用率的诉求支持中断模式，一个是性能优化支持pingpong模式，以及支持京东场景的容器自动化部署。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                | 测试起始时间 | 测试结束时间 |
| ----------------------- | ------------ | ------------ |
| openEuler 22.03-LTS-SP4 | 2024/9/25    | 2024/9/27    |
| openEuler 22.03-LTS-SP4 | 2024/9/28    | 2024/9/30    |
| openEuler 22.03-LTS-SP4 | 2024/10/8    | 2024/10/11   |
| openEuler 22.03-LTS-SP4 | 2024/12/2    | 2024/12/6   |

描述特性测试的硬件环境信息


| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|      2288H V5    |       CPU型号：Intel(R) Xeon(R) Gold 6278C <br />CPU核数：48 <br />网卡：mlx CX5       |      |
|     TaiShan200 2280     |   CPU型号：Kunpeng <br />CPU核数：96 <br />网卡：mlx CX5    |      |
# 3     测试结论概述

## 3.1   测试整体结论

本次京东数据库业务使能gazelle调优，OS ipvlan和gazelle需支持XDP特性测试，共执行260个用例，覆盖新增和继承的功能测试、性能测试，可维护性测试，易用性测试，通过7*24的长稳测试，本次测试共发现24个issue，2个增加资料约束，22个已解决，回归通过，无遗留风险，整体质量良好

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 部分通过 |
| 功能测试 | 新增特性测试 | 测试通过 |
| DFX专项测试 | 性能测试 | 测试通过 |
| DFX专项测试 | 可靠性测试      | 测试通过 |
| DFX专项测试 | 可维护性测试       | 测试通过 |
| DFX专项测试 | 易用性测试       | 测试通过 |

## 3.2   约束说明

1）当前仅支持IPV4，IPV6暂不支持</br>
2）并发数限制最大为2w</br>
3）当前不支持gazelle多进程，即一个节点上不能用gazelle启动多个redis server</br>
4）当前使用的dpdk版本需要基于最新支持xdp内核编译</br>
5）若使用2M大页，redis.conf内的maxclients设置为最大连接数+2000, 需要至少为gazelle本身预留2000个fd</br>
6）中断模式暂不支持igb_uio驱动</br>
7）中断模式不能与共线程模式和bond模式同时使用，也不可与hinic1822网卡配套使用</br>
8）XDP当前只支持设置单队列的XDP网卡</br>
9）XDP当前只支持用户态流量转发，非用户态流量转发暂不支持</br>

以上约束仅针对当前特性

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

如下问题为继承功能遗留问题，不影响当前新特性使用

| 序号 | 问题单号                                          | 问题简述                                                     | 问题级别 | 影响分析                         | 规避措施                      |
| ---- | ------------------------------------------------- | ------------------------------------------------------------ | -------- | -------------------------------- | ----------------------------- |
| 1    | https://gitee.com/openeuler/gazelle/issues/IAZZ03 | 大并发但资源不足时，连接都能建立但所有连接不能打流，且在客户端退出后，连接长时间保持在close_wait状态不断开 | 次要     | 超规格时场景影响                 | 在正常规格范围内使用          |
| 2    | https://gitee.com/openeuler/gazelle/issues/IABS2H | 多线程大连接时gazellectl 执行卡住                            | 次要     | 调测命令执行异常，不影响正常功能 | 在正常规格范围内使用          |
| 3    | https://gitee.com/openeuler/gazelle/issues/I9D61Q | gazelle用的网卡和cpu都在numa1上，启动gazelle未给numa0配置内存启动会报错 | 次要     | 跨numa启动时的易用性             | 给numa0也配上内存可以正常启动 |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 24     | 0    | 3   | 20   | 1      |
| 百分比 | 100%     | 0%   | 12.5% | 83.3%  | 4.2%     |

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | lstack配置文件 | <font color=green>■</font> |   |
| 2 | 仅lstack转发模式的TCP和UDP转发 | <font color=blue>▲</font> |   |
| 3 | gazellectl调测命令 | <font color=blue>▲</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | XDP网络下的redis主从同步，上下线(哨兵模式)，扩容 | <font color=green>■</font> |   |
| 2 | XDP网络下的集群同步，上下线，扩容 | <font color=green>■</font> |   |
| 3 | XDP网络下中断模式的中断轮询切换 | <font color=green>■</font> | |
| 4 | redis应用下的pingpong模式的进入退出 | <font color=green>■</font> | |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 DFX专项测试结论

### 4.2.1 性能测试结论

新增特性性能测试

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
| XDP网络K8S场景redis性能 | redis-benchmark set，get测试 | rps | 通过 |

继承特性性能测试

| 指标大项                      | 指标小项                     | 指标值 | 测试结论 |
| ----------------------------- | ---------------------------- | ------ | -------- |
| ovs+dpdk组网vm场景redis性能   | redis-benchmark set，get测试 | rps    | 通过     |
| vf直通组网vm场景redis性能     | redis-benchmark set，get测试 | rps    | 通过     |
| vf直通组网docker场景redis性能 | redis-benchmark set，get测试 | rps    | 通过     |
| ovs+dpdk组网vm场景mysql性能   | sysbench 读写测试            | tps    | 通过     |
| vf直通组网docker场景mysql性能 | sysbench 读写测试            | tps    | 通过     |
| 物理机mysql性能               | TPCC测试                     | tpmc   | 通过     |

### 4.2.2 可靠性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 压力测试 | 多包长大并发及网络故障，反复上下线等 | 通过 |
### 4.2.3 可维护性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 可维护性 |xdp网卡pdump抓包 | 测试通过 |
| 可维护性 |xdp网卡gezellectl调测命令 | 通过 |
### 4.2.4 易用性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 易用性测试 | k8s容器自动自动部署 | 通过 |

## 4.3 资料测试

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|    资料测试     | https://gitee.com/openeuler/docs/pulls/14289 |      通过    | 
# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                | 测试用例数 | 用例执行结果      | 发现问题单数 |
| ----------------------- | ---------- | ----------------- | ------------ |
| openEuler 22.03-LTS-SP4 | 190        | 通过180个失败10个 | 6个          |
| openEuler 22.03-LTS-SP4 | 200        | 通过185个失败15个  | 10个          |
| openEuler 22.03-LTS-SP4 | 215        | 通过207个失败8个  |   8 个           |
| openEuler 22.03-LTS-SP4 | 260        | 通过260个失败0个  |    0个          |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

NA
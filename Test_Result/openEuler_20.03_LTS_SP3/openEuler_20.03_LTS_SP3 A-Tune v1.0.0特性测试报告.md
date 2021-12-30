![avatar](../images/openEuler.png)

版权所有 © 2021 openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2021-12-29 | 1.0 | 创建 | @gaoruoshu |

关键词： A-Tune 性能调优

 
摘要：
本报告主要描述在openEuler 20.03 LTS SP3版本上对A-Tune v1.0.0版本进行新增特性测试的测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。

 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| DDS | distributed data store | 分布式存储 |

# 1     特性概述

在openEuler 20.03 LTS SP2中使用的A-Tune v0.3版本已经提供了对mysql、nginx等应用的调优功能，在openEuler 20.03 LTS SP3版本上使用的A-Tune v1.0.0版本将应用数量扩充至50款，业务由11大类扩充至14大类，可调节参数扩展至500+，新增参数的类型为应用参数、磁盘参数、芯片参数。

以下为A-Tune v1.0.0支持的应用及业务类型列表：
| 业务大类 | 业务类型 | 支持的应用 |
| ------- | -------- | --------- |
| default | 默认类型 | N/A |
| webserver | web应用 | Nginx, Apache Traffic Server, Tomcat, Apache Http Server, Squid, Postfix, lighttpd |
| ftp server | ftp应用 | vsftpd, proftpd |
| database | 数据库 | MongoDB, MySQL, PostgreSQL, MariaDB, openGauss, tidb, sqlite, QuestDB, influxDB, splunk, Cassandra, Neo4j |
| DDS | 分布式存储 | storm, glusterFS, Ceph, Infinispan, ElasticSearch |
| big-data | 大数据 | hadoop-hdfs, hadoop-spark, hive |
| middleware | 中间件 | dubbo, zookeeper, kafka, rabbitMQ, activeMQ, rocketMQ, etcd, karaf |
| in-memory-database | 内存数据库 | redis, memcached |
| operation | 运维工具 | prometheus, ansible, puppet, zabbix |
| basic-test-suite | 基础测试套 | SPECCPU2006, SPECjbb2015 |
| hpc | 人类基因组 | Gatk4 |
| virtualization | 虚拟化 | consumer-clound, mariadb |
| docker | 容器 | mariadb |
| others | 其他 | encryption |

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 20.03 LTS SP3 Test Round 3 | 2021.12.11 | 2021.12.13 |
| openEuler 20.03 LTS SP3 Test Round 4 | 2021.12.19 | 2021.12.21 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| TaiShan 200-2280 | Kunpeng 920 | 分别测试aarch64架构虚拟机和x86架构虚拟机 |

# 3     测试结论概述

## 3.1   测试整体结论

针对A-Tune v1.0.0特性及功能进行测试，共计执行439个测试用例，主要包含功能测试和集成测试，无skip用例，无失败用例，整体质量良好。

| 测试活动 | 测试内容 |
| ------- | ------- |
| 功能测试 | 25个针对应用的特性测试用例，覆盖A-Tune v1.0.0新增的25款应用，aarch64及x86机器均用例全部通过。 |
| 功能测试 | 300个针对新增参数的测试用例，覆盖A-Tune v1.0.0新增的300个调优参数，aarch64及x86机器均用例全部通过。 |
| 功能测试 | 114个自动化测试用例，测试A-Tune整体核心功能，aarch64及x86机器均用例全部通过。 |

## 3.2   约束说明

（1）建议使用两台机器进行测试；
（2）如仅使用一台机器，需要在特性测试时进行绑核操作，故需要确保机器为4核及以上；
（3）芯片参数仅针对鲲鹏920处理器，无法在其他处理器上使用

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无

### 3.3.2 问题统计

无

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 20.03 LTS SP3 A-Tune v1.0.0 | 439 | aarch64机器及x86机器均全部通过，无skip，无fail | N/A |

## 4.2   后续测试建议

（1）本次测试仅使用单机进行测试，建议后续测试使用两台同规格机器进行测试

# 5     附件

*N/A*

 



 

 
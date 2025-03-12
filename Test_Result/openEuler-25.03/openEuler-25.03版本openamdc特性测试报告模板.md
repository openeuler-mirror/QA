![avatar](../../images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|   2025-03-10   |      openamdc_v1.0       |     分布式缓存冷热数据替换特性支持     |  changzhi    |
|      |             |          |      |

关键词： 

摘要：
    
    1.测试目的：本次测试旨在验证【openamdc】V1.0版本的功能完整性、性能稳定性、兼容性以及安全性，确保软件在openEuler 25.03环境下能够稳定运行并保证满足业务需求。

    2.测试范围：测试覆盖了软件的核心功能模块，包括string、list、hash、set、sortedset等数据类型读写和主从复制、服务高可用功能。测试环境包括：openEuler操作系统。测试类型包括：功能测试、性能测试、兼容性测试、安全测试。

    3.测试方法：测试过程中主要采用手动测试与自动化测试相结合的方式。功能测试通过手动测试和脚本自动化测试完成，性能测试使用memtier_benchmark工具进行压力测试，兼容性测试覆盖openEuler操作系统。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|   openamdc     |  open Apusic In-Memory Data Cache        |    开源分布式缓存软件      |
|        |          |          |

# 1     特性概述

1.基于多线程架构高效处理大量并发请求。

2.支持利用rocksdb将数据扩展至DRAM容量之外，显著扩大存储容量，降低缓存综合使用成本。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|  openEuler 25.03 rc1 arm64   |  2025-02-17     |   2025-03-10    |
|  openEuler 25.03 rc1 x86_64   |  2025-02-17     |   2025-03-10    |

描述特性测试的硬件环境信息 

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|   Kunpeng-920    |   CPU: 16核 @2.0GHz  内存：14GB   磁盘：200GB       |   Architecture: aarch64   |
|   Intel(R) Xeon(R) Gold 5218   |   CPU: 64核 @2.3GHz  内存：128GB    硬盘：1000GB |   Architecture: x86_64   |

# 3     测试结论概述

## 3.1   测试整体结论

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 功能运行正常     |
| 功能测试 | 新增特性测试 | 功能符合需求     |
| 兼容性测试 |      | 兼容openEuler 25.03 rc1 arm64     |
| DFX专项测试 | 性能测试 | 在多线程并发用户下，set命令QPS达到22W+, 99%平均延迟为5.5毫秒     |
| DFX专项测试 | 可靠性/韧性测试 | 数据持久化和服务高可用功能正常，7*24服务运行读写功能正常|
| DFX专项测试 | 安全测试 |  TLS加密传输、ACL授权等功能正常    |
| 资料测试 |         |         |
| 其他测试 |         |         |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- | 
|     |         |        |         |         |         |            |
|     |         |        |         |         |         |            |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |     6     |   0   |  1    |   5   |     0   |
| 百分比 |     0%     |   0%   |   16.7%   |    83%  |     0%   |

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | string命令集功能正常 | <font color=green>■</font> | String命令集命令：set、get、getrange、getset、mget、setbit、setex、setnx、setrange、strlen、mset、msetnx、psetex、incr、incrby、incrbyfloat、decr、decrby、append、getdel、getex、substr  |
| 2 | Hash命令集功能正常 | <font color=green>■</font>  | Hash命令集命令：hdel、hexists、hget、hgetall、hincrby、hkeys、hlen、hset、hvals、hincrbyfloat、hmset、hmget、hrandfield、hscan、hsetnx、hstrlen、httl |
| 3 | Set命令集功能正常 | <font color=green>■</font> | Set命令集命令：sadd、scard、sdiff、sdiffstore、sinter、sinterstore、sismember、smembers、smove、spop、srandmember、srem、sunion、sunionstore、sscan |
| 4 | Zset命令集功能正常 | <font color=green>■</font> | Zset命令集命令：zadd、zcard、zcount、zincrby、zinterstore、zlexcount、zrange、zrangebylex、zrangebyscore、zrank、zrem、zremrangebylex、zremrangebyrank、zremrangebyscore、zrevrange、zrevrangebyscore、zrevrank、zscore、zunionstore、zscan |
| 5 | List命令集功能正常 | <font color=green>■</font> | List命令集命令：blpop、brpop、brpoplpush、lindex、linsert、llen、lpop、lpush、lpushx、lrange、lrem、lset、ltrim、rpop、rpoplpush、rpush、rpushx |
| 6 | Stream命令集功能正常 | <font color=green>■</font> | Stream命令集命令：xack、xadd、xautoclaim、xclaim、xdel、xgroup create、xgroup createconcumer、xgroup delconsumer、xgroup destroy、xgroup setid、xinfo consumers、xinfo groups、xinfo stream、xlen、xpending、xrange、xread、xreadgroup、xrevrange、xsetid、xtrim |
| 7 | Geo命令集功能正常 | <font color=green>■</font> | Geo命令集命令：geoadd、geodist、geohash、geopos、georadius、georadius_ro、georadiusbymember、georadiusbymember_ro、geosearch、geosearchstore |
| 8 | Bitmap命令集功能正常 | <font color=green>■</font> | Bitmap命令集命令：setbit、getbit、bitop、bitfield、bitfield_ro |
| 9 | HyperLogLog命令集功能正常 | <font color=green>■</font> | HyperLogLog命令集命令：pfadd、pfcount、pfdebug、pfmerge、pfselftest |
| 10 | Server命令集功能正常 | <font color=green>■</font> | Server命令集命令：acl cat、acl deluser、acl genpass、cal getuser、acl list 、acl load、acl log、acl save、acl setuser、acl users、acl whoami、bgrewriteaof、bgsave、command、command count、command getkeys、command info、command list、config get、config resetstat、config rewrite、config set、dbsize、failover、flushall、flushdb、info等 |
| 11 | Connection management命令集功能正常 | <font color=green>■</font>  | Connection management命令集命令：auth、client caching、client getname、client getredir、client id、client info、client kill、client list、client psuse、client reply、client setname、client tracking、client reackinginginfo、client unblock、client unpause、echo、hello、ping、quit、reset、select |
| 12 | Pub/Sub命令集功能正常 | <font color=green>■</font> | Pub/Sub命令集命令：psubscribe、publish、pubsub channels、pubsub numpat、pubsub numsub、punsubscribe、subscribe、unsubscribe |
| 13 | Script命令集功能正常 | <font color=green>■</font> | Script命令集命令：eval、evalsha、script debug、script exists、script flush、script kill、script load |
| 14 | Expire命令集合功能正常 | <font color=green>■</font> | Expire命令集命令：expire、expireat、pexpire、ttl、persist |
| 15 | ACL授权功能 | <font color=green>■</font> | 1.openamdc-cli客户端设置只读用户权限（acl setuser reader on > abc ~* +@read），设置只写用户权限（acl setuser writer on >123 ~* +@writer）  2.openamdc-cli --user <username> --pass <password>登陆只读用户，get获取键值和set设置键值测试用户权限隔离是否生效  3.openamdc-cli --user <username> --pass <password>登陆只写用户，get获取键值和set设置键值测试用户权限隔离是否生效 |
| 16 | TLS加密 | <font color=green>■</font> | 1.进入openamdc目录，打开README.md文件查看TLS构建相关信息，安装相关构建依赖包，再make BUILD_TLS=yes构建支持TLS功能  2.打开TLS.md查询启动TLS服务和客户端连接服务相关信息，启动TLS服务器  3.openamdc-cli TLS传输加密，验证客户端与服务器是否强制使用TLS |
| 17 | 高危命令防护 | <font color=green>■</font> | 1.打开openamdc.conf配置文件打开swap功能，并配置相关信息；配置文件通过rename-command重命名或禁用高位命令（rename-command FLUSHDB "super_secret_flushdb"） 2.启动openamdc服务，openamdc-cli客户连接检测flushdb是否被禁用 |
| 18 | RDB数据持久化 | <font color=green>■</font> | 触发SAVE（阻塞）或BGSAVE(后台)生成RDB文件，检测数据恢复完整性 |
| 19 | AOF数据持久化 | <font color=green>■</font> | 启动AOF（appendonly yes），模拟断电后通过openamdc-check-aof修复日志文件并验证数据 |
| 20 | 主从复制高可用与故障转移 | <font color=green>■</font> | 主从复制：主节点写入数据，检查从节点是否同步 |
| 21 | 哨兵高可用与故障转移 | <font color=green>■</font> | 模拟注解顶啊宕机，验证sentinel是否自动选举新主节点 |
| 22 | 集群高可用与故障转移 | <font color=green>■</font> | 断开某节点网络，检查集群是否自动迁移槽位并恢复 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | String类型命令支持写入存储器 | <font color=green>■</font> | String包含的写数据命令：set, setnx, setex, psetex, getex, getset, setrange, mset, incr, incrbyfloat, append |
| 2 | Hash类型命令支持写入存储器 | <font color=green>■</font> | Hash包含的写数据命令：hsetnx, hset, hincrby, hincrbyfloat, hdel |
| 3 | Set类型命令支持写入存储器 | <font color=green>■</font> | Set包含的写数据命令：sadd, srem, smove, spop, sinter, sinterstore, sunion, sunionstore, sdiff, sdiffstore |
| 4 | Zset类型命令支持写入存储器 | <font color=green>■</font> | Zset包含的写数据命令：zadd, zrem, zremrangebyrank, zremrangebyscore, zremrangebylex, zunionstore, zinterstore, zdiffstore, zunion, zinter, zdiff, zrangestore, zrange, zrevrange |
| 5 | List类型命令支持写入存储器 | <font color=green>■</font> | List包含的写数据命令：lpush, rpush, lpushx, rpushx, linsert, lset, lpop, rpop, ltrim, lmove |
| 6 | Stream类型命令支持写入存储器 | <font color=green>■</font> | Stream包含的写数据命令：xadd, xgroup, xsetid, xdel, xclain, xautoclain |
| 7 | Bitmap类型命令支持写入存储器 | <font color=green>■</font> | Bitmap类型包含的写数据命令：setbit, bitop, bitfield, bitfield_ro |
| 8 | Generic类型命令支持写入存储器 | <font color=green>■</font> | Generic类型包含的写数据命令：del, rename, move, copy, restore, dump, sort |
| 9 | Expire类型命令支持写入存储器 | <font color=green>■</font> | Expire包含的写数据命令：expire, expireat, pexpire, persist |
| 10 | Geo类型命令支持写入存储器 | <font color=green>■</font> | Geo包含的写数据命令：georadius, georadiusbymember |
| 11 | HyperLogLog类型命令支持写入存储器 | <font color=green>■</font> | HyperLogLog包含的写数据命令：pfadd, pfmerge |
| 12 | RANDOMKEY命令适配swap-enabled模式 | <font color=green>■</font> | 随机返回内存或存储器中的数据 |
| 13 | SCAN命令适配swap-enabled模式 | <font color=green>■</font> | 随机迭代内存或存储器中的数据 |
| 14 | KEYS命令适配swap-enabled模式 | <font color=green>■</font> | 返回内存和存储器中的所有数据 |
| 15 | DBSIZE命令适配swap-enabled模式 | <font color=green>■</font> | 返回内存和存储器中的数据数量 |
| 16 | FLUSH DB命令适配swap-enabled模式 | <font color=green>■</font> | 清空某一个db中的所有数据，包括内存和存储器中的数据 |
| 17 | FLUSH ALL命令适配swap-enabled模式 | <font color=green>■</font> | 清空所有db中的数据，包括内存和存储器中的数据 |
| 18 | SAVE命令适配swap-enabled模式 | <font color=green>■</font> | SAVE命令用于同步执行数据库持久化操作，即创建一个当前数据库状态的快照文件（RDB 文件）。在swap-enabled模式下，生成的RDB文件包含内存数据与存储器中的数据。 |
| 19 | BGSAVE 命令适配swap-enabled模式 | <font color=green>■</font> | BGSAVE命令用于在后台异步执行数据库的持久化操作，也就是生成一个当前数据库状态的快照文件（RDB 文件）。在swap-enabled模式下，生成的RDB文件包含内存数据与存储器中的数据。 |
| 20 | BGREWRITEAOF 命令适配swap-enabled模式 | <font color=green>■</font> | BGREWRITEAOF命令的作用就是在后台异步地对AOF文件进行重写，去除冗余的命令，生成一个最小化且能准确恢复当前数据库状态的新AOF文件，从而减少AOF文件的体积，提高加载和恢复数据的效率。在swap-enabled模式下，生成的文件包含内存数据与存储器中的数据。 |
| 21 | 键生存时间过期功能适配swap-enabled模式 | <font color=green>■</font> | 允许为键设定一个过期时间，一旦到达该时间，无论对应的数据处于内存之中还是存储设备上，相应的键都会自动被删除。 |
| 22 | 事务功能适配swap-enabled模式 | <font color=green>■</font> | 顺序执行一组命令的集合，其中写命令在swap-enabled模式下写入存储器 |
| 23 | 键生存时间过期功能适配swap-enabled模式 | <font color=green>■</font> | 允许为键设定一个过期时间，一旦到达该时间，无论对应的数据处于内存之中还是存储设备上，相应的键都会自动被删除。 |
| 24 | swap-enabled模式下启用swap-hotmemory配置项 | <font color=green>■</font> | 新增swap-hormemory参数，用于将热数据内存使用限制设置为指定的字节数。热数据内存不包括 RocksDB所使用的内存。值为0表示永远不会使用热内存。值大于0表示可使用的热数据内存量。当达到热内存限制时，不同于普通模式下将数据删除，在swap-enabled模式下系统会尝试把数据交换到RocksDB中。 |
| 25 | SHUTDOWN命令适配swap-enabled模式  | <font color=green>■</font> | SHUTDOWN命令的主要功能是安全地关闭服务。在关闭过程中，它会根据配置执行持久化操作，确保数据的完整性，然后正常停止服务。 在swap-enabled模式下，若热内存（swap-hotmemory）的值大于 0 ，那么在服务退出前，系统会先将内存中的数据写入Rocksdb，随后才关闭服务。 |
| 26 | swap-enabled模式下服务启动时恢复热数据 | <font color=green>■</font> | 在swap-enabled模式下，服务启动时不会加载RDB或AOF文件，而是会依据热内存（swap-hotmemory）的配置来确定将多少Rocksdb数据加载至内存。 |
| 27 | 主从复制功能适配swap-enabled模式  | <font color=green>■</font> | 主从复制是一种数据同步机制，通过将一个主节的数据自动复制到一个或多个其他从节点，实现数据的备份、读写分离以提升性能，同时增强系统的可用性和容错能力。在swap-enabled模式下，首次建立主从节点时，主节点需将内存和存储设备中的所有数据同步至从节点。 |
| 28 | swap-enabled模式从存储起去读数据  | <font color=green>■</font> | 在swap-enabled模式下，所有读命令支持从Rocksdb中加载数据到内存中。 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

本次兼容性测试覆盖了以下主要方面：
操作系统兼容性：openEuler 25.03 rc1

硬件架构兼容性：arm64、x86_64

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|    未开启RocksDB性能     |   单线程写性能      |   7.8W QPS     |    未开启RocksDB功能，在当前服务器软硬件环境下，单线程写的QPS值为：78947     |
|    开启RocksDB性能     |   单线程批量值为4性能      |   6W QPS     |    开启RocksDB功能，在当前服务器软硬件环境下，单线程批量值为4的QPS值为：61122     |
|    开启RocksDB性能     |   单线程批量值为16性能      |   6.5W QPS     |    开启RocksDB功能，在当前服务器软硬件环境下，单线程批量值为16的QPS值为：65306     |
|    开启RocksDB性能     |   客户端1线程批量值为4性能      |   7.8W QPS     |    开启RocksDB功能，在当前服务器软硬件环境下，单线程批量值为4的QPS值为：78978     |
|    开启RocksDB性能     |   客户端2线程批量值为4性能      |   7.8W QPS     |    开启RocksDB功能，在当前服务器软硬件环境下，单线程批量值为4的QPS值为：78350     |
|    开启RocksDB性能     |   服务器worker_threads为2客户端2线程批量值为4性能      |   15.7W QPS     |    开启RocksDB功能，在当前服务器软硬件环境下，单线程批量值为4的QPS值为：157421     |
|    开启RocksDB性能     |   服务器worker_threads为3客户端2线程批量值为4性能      |   22W QPS     |    开启RocksDB功能，在当前服务器软硬件环境下，单线程批量值为4的QPS值为：223183     |


### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|     数据持久化    |    AOF、RDB、RocksDB     |   数据持久化功能正常      |
|     服务高可用    |    AOF、RDB、RocksDB     |   Sentinel哨兵和Cluster集群服务高可用功能正常       |
|     7*24小时稳定性    |    AOF、RDB、RocksDB     |   7*24服务运行读写功能正常       |

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|    认证与访问控制     |   requirepass和ACL授权      |     requirepass和ACL授权功能正常     |
|    网络与通信安全     |   TLS加密传输      |     requirepass和ACL授权功能正常     |

## 4.4 资料测试结论
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|    功能测试用例      |      65      |        通过      |      6        |
|     安全测试用例    |      4      |        通过      |       0       |
|     可靠性和韧性测试用例    |      7      |        通过      |     0         |
|     性能测试用例    |      7      |        通过      |       0       |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 
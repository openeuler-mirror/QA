![avatar](../../images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|   2025-09-22   |      openamdc_v1.1       |    openamdc性能优化与问题修复     |  changzhi    |
|      |             |          |      |

关键词： 缓存 冷热数替换

摘要：openAMDC(open Advanced In-Memory Data Cache ，简称：openAMDC) 是一款高性能、大容量、支持多场景应用的开源分布式缓存系统，致力于为大规模、高并发、高可用的关键业务提供安全可靠的缓存服务支持。openAMDC 完全兼容 Redis 协议及持久化数据格式，可帮助用户快速、平滑地完成对 Redis 的替换，大幅降低系统迁移的复杂度和风险。

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|   openamdc     |  open Advanced In-Memory Data Cache        |    开源分布式缓存软件      |
|        |          |          |

# 1     特性概述

1.openamdc基于多线程架构高效处理大量并发请求。

2.openamdc支持利用rocksdb将数据扩展至DRAM容量之外，显著扩大存储容量，降低缓存综合使用成本。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|  openEuler 25.09 rc3 arm64   |  2025-09-04     |   2025-09-22    |
|  openEuler 25.09 rc3 x86_64   |  2025-09-04     |   2025-09-22    |
|  ubuntu 22.04 x86_64   |  2025-09-04     |   2025-09-22    |

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
| 兼容性测试 |      | 兼容openEuler 25.09 rc3 arm64     |
| DFX专项测试 | 性能测试 | 多线程性能优化 |
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
| 数目   |     4     |   0   |  4    |   0   |     0   |
| 百分比 |     0%     |   0%   |   100%   |    0%  |     0%   |

### 3.3.3 发现问题

|    序号    | 问题简述 | 优先级 | 当前状态 |
| ------ | -------- | ---- | ---- |
| 1   |   服务器多线程主从模式，openamdc-benchmark压测客户端阻塞      |   主要   |  已验收    |
| 2 |     打开冷热数据，写入超长hash阈值对，keys * 返回数据重复     |   主要  |   已验收  |
| 3 |     worker-threads:4回归BZPOPMIN命令服务器阻塞不可用     |   主要  |   已验收  |
| 4 |     主从模式多线程跨线程数据交互主节点死锁     |   主要  |   已验收  |

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
| 23 | String类型命令支持写入存储器 | <font color=green>■</font> | String包含的写数据命令：set, setnx, setex, psetex, getex, getset, setrange, mset, incr, incrbyfloat, append |
| 24 | Hash类型命令支持写入存储器 | <font color=green>■</font> | Hash包含的写数据命令：hsetnx, hset, hincrby, hincrbyfloat, hdel |
| 25 | Set类型命令支持写入存储器 | <font color=green>■</font> | Set包含的写数据命令：sadd, srem, smove, spop, sinter, sinterstore, sunion, sunionstore, sdiff, sdiffstore |
| 26 | Zset类型命令支持写入存储器 | <font color=green>■</font> | Zset包含的写数据命令：zadd, zrem, zremrangebyrank, zremrangebyscore, zremrangebylex, zunionstore, zinterstore, zdiffstore, zunion, zinter, zdiff, zrangestore, zrange, zrevrange |
| 27 | List类型命令支持写入存储器 | <font color=green>■</font> | List包含的写数据命令：lpush, rpush, lpushx, rpushx, linsert, lset, lpop, rpop, ltrim, lmove |
| 28 | Stream类型命令支持写入存储器 | <font color=green>■</font> | Stream包含的写数据命令：xadd, xgroup, xsetid, xdel, xclain, xautoclain |
| 29 | Bitmap类型命令支持写入存储器 | <font color=green>■</font> | Bitmap类型包含的写数据命令：setbit, bitop, bitfield, bitfield_ro |
| 30 | Generic类型命令支持写入存储器 | <font color=green>■</font> | Generic类型包含的写数据命令：del, rename, move, copy, restore, dump, sort |
| 31 | Expire类型命令支持写入存储器 | <font color=green>■</font> | Expire包含的写数据命令：expire, expireat, pexpire, persist |
| 32 | Geo类型命令支持写入存储器 | <font color=green>■</font> | Geo包含的写数据命令：georadius, georadiusbymember |
| 33 | HyperLogLog类型命令支持写入存储器 | <font color=green>■</font> | HyperLogLog包含的写数据命令：pfadd, pfmerge |
| 34 | RANDOMKEY命令适配swap-enabled模式 | <font color=green>■</font> | 随机返回内存或存储器中的数据 |
| 35 | SCAN命令适配swap-enabled模式 | <font color=green>■</font> | 随机迭代内存或存储器中的数据 |
| 36 | KEYS命令适配swap-enabled模式 | <font color=green>■</font> | 返回内存和存储器中的所有数据 |
| 37 | DBSIZE命令适配swap-enabled模式 | <font color=green>■</font> | 返回内存和存储器中的数据数量 |
| 38 | FLUSH DB命令适配swap-enabled模式 | <font color=green>■</font> | 清空某一个db中的所有数据，包括内存和存储器中的数据 |
| 39 | FLUSH ALL命令适配swap-enabled模式 | <font color=green>■</font> | 清空所有db中的数据，包括内存和存储器中的数据 |
| 40 | SAVE命令适配swap-enabled模式 | <font color=green>■</font> | SAVE命令用于同步执行数据库持久化操作，即创建一个当前数据库状态的快照文件（RDB 文件）。在swap-enabled模式下，生成的RDB文件包含内存数据与存储器中的数据。 |
| 41 | BGSAVE 命令适配swap-enabled模式 | <font color=green>■</font> | BGSAVE命令用于在后台异步执行数据库的持久化操作，也就是生成一个当前数据库状态的快照文件（RDB 文件）。在swap-enabled模式下，生成的RDB文件包含内存数据与存储器中的数据。 |
| 42 | BGREWRITEAOF 命令适配swap-enabled模式 | <font color=green>■</font> | BGREWRITEAOF命令的作用就是在后台异步地对AOF文件进行重写，去除冗余的命令，生成一个最小化且能准确恢复当前数据库状态的新AOF文件，从而减少AOF文件的体积，提高加载和恢复数据的效率。在swap-enabled模式下，生成的文件包含内存数据与存储器中的数据。 |
| 43 | 键生存时间过期功能适配swap-enabled模式 | <font color=green>■</font> | 允许为键设定一个过期时间，一旦到达该时间，无论对应的数据处于内存之中还是存储设备上，相应的键都会自动被删除。 |
| 44 | 事务功能适配swap-enabled模式 | <font color=green>■</font> | 顺序执行一组命令的集合，其中写命令在swap-enabled模式下写入存储器 |
| 45 | 键生存时间过期功能适配swap-enabled模式 | <font color=green>■</font> | 允许为键设定一个过期时间，一旦到达该时间，无论对应的数据处于内存之中还是存储设备上，相应的键都会自动被删除。 |
| 46 | swap-enabled模式下启用swap-hotmemory配置项 | <font color=green>■</font> | 新增swap-hormemory参数，用于将热数据内存使用限制设置为指定的字节数。热数据内存不包括 RocksDB所使用的内存。值为0表示永远不会使用热内存。值大于0表示可使用的热数据内存量。当达到热内存限制时，不同于普通模式下将数据删除，在swap-enabled模式下系统会尝试把数据交换到RocksDB中。 |
| 47 | SHUTDOWN命令适配swap-enabled模式  | <font color=green>■</font> | SHUTDOWN命令的主要功能是安全地关闭服务。在关闭过程中，它会根据配置执行持久化操作，确保数据的完整性，然后正常停止服务。 在swap-enabled模式下，若热内存（swap-hotmemory）的值大于 0 ，那么在服务退出前，系统会先将内存中的数据写入Rocksdb，随后才关闭服务。 |
| 48 | swap-enabled模式下服务启动时恢复热数据 | <font color=green>■</font> | 在swap-enabled模式下，服务启动时不会加载RDB或AOF文件，而是会依据热内存（swap-hotmemory）的配置来确定将多少Rocksdb数据加载至内存。 |
| 49 | 主从复制功能适配swap-enabled模式  | <font color=green>■</font> | 主从复制是一种数据同步机制，通过将一个主节的数据自动复制到一个或多个其他从节点，实现数据的备份、读写分离以提升性能，同时增强系统的可用性和容错能力。在swap-enabled模式下，首次建立主从节点时，主节点需将内存和存储设备中的所有数据同步至从节点。 |
| 50 | swap-enabled模式从存储起去读数据  | <font color=green>■</font> | 在swap-enabled模式下，所有读命令支持从Rocksdb中加载数据到内存中。 |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

## 4.2 兼容性测试结论

本次兼容性测试覆盖了以下主要方面：
操作系统兼容性：openEuler 25.09 rc3

硬件架构兼容性：arm64、x86_64

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项（线程数） | 指标值（优化后QPS/优化前QPS） | 测试结论 |
| ------- | ------- | ------ | ------- |
|    多线程写性能测试     |   worker_threads为1时写性能      |   86982 QPS / 76063 QPS    |    性能提高 14.3%     |
|    多线程写性能测试       |   worker_threads为2时写性能      |   173916 QPS / 167140 QPS      |    性能提高 4%     |
|    多线程写性能测试       |   worker_threads为3时写性能      |  258037 QPS / 229917 QPS    |   性能提高 12.2%     |
|    多线程写性能测试       |   worker_threads为4时写性能      |  356884  QPS / 329635 QPS    |    性能提高 8.2%    |
|    多线程写性能测试       |   worker_threads为5时写性能      |  495444 QPS / 402059 QPS      |  性能提高 23.2%   |
|    多线程写性能测试       |   worker_threads为6时写性能      |  406762 QPS / 378614 QPS     |    性能提高 7.4%    |
|    多线程写性能测试       |   worker_threads为7时写性能      |  534068 QPS / 454571 QPS     |    性能提高 17.4%    |
|    多线程写性能测试       |   worker_threads为8时写性能      |  473032 QPS / 444167 QPS     |    性能提高 6.4%    |
|    多线程写性能测试       |   worker_threads为9时写性能      |  434953 QPS / 415025 QPS      |    性能提高 4.8%    |
|    多线程写性能测试       |   worker_threads为10时写性能      |  428351 QPS / 497554 QPS      |    性能提高 -13.9%    |
|    多线程写性能测试       |   worker_threads为11时写性能      |  465465 QPS / 390360 QPS     |    性能提高 19.2%    |
|    多线程写性能测试       |   worker_threads为12时写性能      |  387293 QPS / 378341 QPS     |    性能提高 2.3%    |
|    多线程写性能测试       |   worker_threads为13时写性能      |  428779 QPS / 427565 QPS     |    性能提高 0.2%    |
|    多线程写性能测试       |   worker_threads为14时写性能      |  423708 QPS / 406445 QPS      |    性能提高 4.2%    |
|    多线程写性能测试       |   worker_threads为15时写性能      |  413739 QPS / 368738 QPS      |    性能提高 12.2%    |
|    多线程写性能测试       |   worker_threads为16时写性能      |  399722 QPS / 366348 QPS     |    性能提高 9.1%    |


### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|     数据持久化    |    AOF、RDB、RocksDB     |   数据持久化功能正常      |
|     服务高可用    |    AOF、RDB、RocksDB     |   Sentinel哨兵和Cluster集群服务高可用功能正常       |
|     7*24小时稳定性    |    AOF、RDB、RocksDB     |   7*24服务运行读写功能正常       |

### 4.3.3 安全测试结论

不涉及

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
|    功能测试用例      |      68      |        通过      |      4        |
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

 



 

 
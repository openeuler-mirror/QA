![openEuler ico](../../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期      | 修订   版本 | 修改描述 | 作者 |
| --------- | ----------- | -------- | ---- |
| 2022.9.14 | 1.0         |          |      |
|           |             |          |      |
|           |             |          |      |

 关键词：多流   astream   mysql   

摘要：通过IO智能多流提升NVMe SSD存储性能，延长磁盘寿命

# 1     特性概述

IO智能多流通过astream工具使能。它是一款延长磁盘使用寿命的工具。它基于Linux提供的inotify机制进行目录监控，同时配合用户针对应用场景定义的流分配规则，为匹配到的文件在创建时设置流信息，而后通过内核透传流信息至已使能多流特性的NVMe SSD磁盘，最终使得文件的存储能够根据流信息的标识进行更优的分类存储，降低磁盘垃圾回收的工作量，从而降低磁盘的写放大水平，最终达到延长磁盘使用寿命。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称            | 测试起始时间 | 测试结束时间 |
| ------------------- | ------------ | ------------ |
| openEuler 22.09 RC2 | 2022.8.18    | 2022.9.5     |
|                     |              |              |
|                     |              |              |

## 2.1 硬件信息

​	要求服务端（server）和客户端（client）各一台，且光口直连。

|          |             Server              |          Client           |
| :------- | :-----------------------------: | :-----------------------: |
| CPU      |      Kunpeng 920-6426 * 2       |   Kunpeng 920-6426 * 2    |
| 核数     |            64cores*2            |         64cores*2         |
| 主频     |             2600MHz             |          2600MHz          |
| 内存大小 |    16 * 32G Samsung 2666 MHz    | 16 * 32G Samsung 2666 MHz |
| 网络     |           SP580 10GE            |        SP580 10GE         |
| 系统盘   |        1.2T HDD TOSHIBA         |     1.12 HDD TOSHIBA      |
| 数据盘   | 1.6T ES3000 V5  NVMe PCIe SSD*2 |            NA             |

## 2.2 软件信息

|   软件名称   |  版本  |
| :----------: | :----: |
|    mysql     | 8.0.20 |
| benchmarksql |  5.0   |


# 3     测试结论概述

## 3.1   测试整体结论

​		**在当前mysql场景下进行实测，通过使用astream工具，NVMe SSD磁盘在长稳运行后期稳定保持12%的WA下降幅度，即性能较前提升12%**。

| 测试活动 | 活动评价                                                     |
| -------- | ------------------------------------------------------------ |
| 功能测试 | 部署Server端MySQL环境、Client端测试工具                      |
| 专项测试 | 开启IO智能多流特性，使能astream定时监控MySQL特定数据文件生成 |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

- 提供的命令行以root权限运行astream守护进程，在测试过程中，常驻系统。
- 待测磁盘的IO压力必须足够大，且磁盘空间占用较高，这样写放大恶化越明显，使用本工具的多流收益越明显
- 在启动astream守护进程后，不得删除受监控的目录后再次创建同目录，请重新启动astream；
- 规则文件中支持正则匹配一组文件，用户需具备一定的正则匹配知识。
- 测试时的NVMe SSD磁盘实现了基于NVMe 1.3协议描述的多流功能。

# 4     特性使能

## 4.1 安装

配置openEuler 22.09的yum源，直接使用yum命令安装

```
yum install astream
```

编译安装软件包astream 

 `cd src && make`

## 4.2 配置

在介绍astream的使用方法前，首先介绍astream启动所需要的流分配规则文件。

#### 1.介绍

流分配规则文件是用户根据自身对workload特征的理解，针对其中具有相同或相似生命周期的一类数据定义的流信息的规则集合的文件。

在一个流分配规则文件中，每一行表示定义的一条规则，每条规则示例如下： `^/data/mysql/data/undo 4` 。它表示为路径`/data/mysql/data`下的所有以`undo`为前缀的文件都分配流信息4。 

#### 2.完整示例

如下示例一个具体的MySQL的流分配规则文件。

```
^/data/mysql/data/ib_logfile 2
^/data/mysql/data/ibdata1$ 3
^/data/mysql/data/undo 4
^/data/mysql/data/mysql-bin 5
```

该规则文件定义了如下四条规则：

- 以`/data/mysql/data/ib_logfile`为前缀的文件绝对路径对应的文件配置流信息2

- 以`/data/mysql/data/ibdata1`为文件绝对路径对应的文件配置流信息3

- 以`/data/mysql/data/undo`为前缀的文件绝对路径对应的文件配置流信息4

- 以`/data/mysql/data/mysql-bin`为前缀的文件绝对路径对应的文件配置流信息5

## 4.3 使能

假设规则文件`stream_rule1.txt`和`stream_rule2.txt` 位于`/home`下（下同），则

- 监控单目录 

  ```shell
  astream -i /data/mysql/data -r /home/stream_rule1.txt
  ```

- 监控多目录 

  本工具支持同时监控多个目录，意味着每个监控目录都需要传入与之匹配的流分配规则文件。

  如下示例同时监控两个目录： 

  ```shell
  astream -i /data/mysql-1/data /data/mysql-2/data -r /home/stream_rule1.txt /home/stream_rule2.txt
  ```

  上述命令中监控了两个目录，目录1`/data/mysql-1/data`，对应的流分配规则文件为`/home/stream_rule1.txt`，目录2`/data/mysql-2/data`，对应的流分配规则文件为`/home/stream_rule2.txt`。

# 5     附录

写入放大**（英语：Write amplification，简称**WA**）是闪存和固态硬盘（SSD）中一种不良的现象，即实际写入的物理数据量是写入数据量的多倍。其公式为：
$$
WA=\frac{实际写入的数据量}{主机提交的写入数据量}
$$
WA的结果越小越好。

一般来说，随着数据的存储以及磁盘的碎片化愈演愈烈，WA的值将越来越大，如果WA的值能够延迟升高，那么将有助于延长磁盘的使用寿命。

 



 

 
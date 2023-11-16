# openEuler社区测试能力执行指南 

## 1、功能测试

### 1.1、mugen

测试工具指导来源于 https://gitee.com/openeuler/mugen

**mugen介绍**
mugen是openEuler社区开发的测试框架，提供公共配置和方法以便社区开发者进行测试代码的编写和执行

**mugen更新说明**
优化了mugen框架的入口函数
当前版本添加了对测试套路径和测试用例环境的添加
新增python公共函数

**mugen使用教程**
安装依赖软件
```bash dep_install.sh```

**配置测试套环境变量**
命令执行：

```bash
bash mugen.sh -c --ip $ip --password $passwd --user $user --port $port
```

参数说明：

```
ip：测试机的ip地址
user：测试机的登录用户，默认为root
password: 测试机的登录密码
port：测试机ssh登录端口，默认为22
环境变量文件：./conf/env.json
{
    "NODE": [
        {
            "ID": 1,
            "LOCALTION": "local",
            "MACHINE": "physical",
            "FRAME": "aarch64",
            "NIC": "eth0",
            "MAC": "55:54:00:c8:a9:21",
            "IPV4": "192.168.0.10",
            "USER": "root",
            "PASSWORD": "openEuler12#\$",
            "SSH_PORT": 22,
            "BMC_IP": "",
            "BMC_USER": "",
            "BMC_PASSWORD": ""
        },
        {
            "ID": 2,
            "LOCALTION": "remote",
            "MACHINE": "kvm",
            "FRAME": "aarch64",
            "NIC": "eth0",
            "MAC": "55:54:00:c8:a9:22",
            "IPV4": "192.168.0.11",
            "USER": "root",
            "PASSWORD": "openEuler12#$",
            "SSH_PORT": 22,
            "HOST_IP": "",
            "HOST_USER": "",
            "HOST_PASSWORD": ""
            "HOST_SSH_PORT": ""
        }
    ]
}
在用例中的使用：NODE{id}_{LOCALTION}
```

**用例执行**
执行所有用例 ```bash mugen.sh -a```
执行指定测试套 ```bash mugen.sh -f testsuite```
执行单条用例 ```bash mugen.sh -f testsuite -r testcase```
日志输出shell脚本的执行过程
```bash mugen.sh -a -x ```
```bash mugen.sh -f testsuite -x ```
```bash mugen.sh -f testsuite -r testcase -x ```

**用例添加**
根据模板编写用例脚本(推荐)

```source ${OET_PATH}/libs/locallibs/common_lib.sh```

**需要预加载的数据、参数配置**

```bash
function config_params() {
    LOG_INFO "Start to config params of the case."
    LOG_INFO "No params need to config."
    LOG_INFO "End to config params of the case."
}
```

**测试对象、测试需要的工具等安装准备**

```bash
function pre_test() {
    LOG_INFO "Start to prepare the test environment."
    LOG_INFO "No pkgs need to install."
    LOG_INFO "End to prepare the test environment."
}
```

**测试点的执行**

```bash
function run_test() {
    LOG_INFO "Start to run test."

    # 测试命令：ls
    ls -CZl -all
    CHECK_RESULT 0

    # 测试/目录下是否存在proc|usr|roor|var|sys|etc|boot|dev目录
    CHECK_RESULT "$(ls / | grep -cE 'proc|usr|roor|var|sys|etc|boot|dev')" 7

    LOG_INFO "End to run test."
}
```

**后置处理，恢复测试环境**

```bash
function post_test() {
    LOG_INFO "Start to restore the test environment."
    LOG_INFO "Nothing to do."
    LOG_INFO "End to restore the test environment."
}
```

```main "$@" ```

单纯的shell脚本或python脚本，通过脚本执行的返回码判断用例是否成功。
可参考样例：testsuite测试套下用例oe_test_casename_02和oe_test_casename_03
suite2cases中json文件的写法
文件名为测试套名，文件后缀.json

**文件内容说明**

框架的公共函数
如何加载到用例中，以供调用

bash

```source ${OET_PATH}/libs/locallibs/common_lib.sh```

python

```python
import os, sys, subprocess

LIBS_PATH = os.environ.get("OET_PATH") + "/libs/locallibs"
sys.path.append(LIBS_PATH)
import xxx
```

**公共函数**

- 日志打印

bash 

```bash
LOG_INFO "$message"
LOG_WARN "$message"
LOG_DEBUG "$message"
LOG_ERROR "$message"
```

python

```python
import mugen_log
mugen_log.logging(level, message) # level:INFO,WARN,DEBUG,ERROR;message:日志输出
```

- 结果检查

bash

```bash
CHECK_RESULT $1 $2 $3 $4
# $1：测试点的返回结果
# $2：预期结果
# $3：对比模式，0：返回结果和预期结果相对；1：返回结果和预期结果不等
# $4：发现问题，日志输出
```

- rpm包安装卸载

bash

```bash
## func 1
DNF_INSTALL "vim bc" "$node_id"
DNF_REMOVE "$node_id" "jq" "$mode"

# mode：默认为0，会删除用例中安装的包，当为非0时，则只卸载当软件包
```

python

```python
import rpm_manage
tpmfile = rpm_manage.rpm_install(pkgs, node, tmpfile)
rpm_manage.rpm_remove(node, pkgs, tmpfile)
```

- 远程命令执行

bash

```bash
## func 1
SSH_CMD "$cmd" $remote_ip $remote_password $remote_user $time_out $remote_port`
## func 2
P_SSH_CMD --cmd $cmd --node $node(远端节点号)
P_SSH_CMD --cmd $cmd --ip $remote_ip --password $remote_password --port $remote_port --user $remote_user --timeout $timeout
```

python

```python
conn = ssh_cmd.pssh_conn(remote_ip, remote_password,remote_port,remote_user,remote_timeout)
exitcode, output = ssh_cmd.pssh_cmd(conn, cmd)

# port：默认为22
# user：默认为root
# timeout: 默认不限制
```

- 目录文件传输

bash

```bash
## func 1
### 本地文件传输到远端  
`SSH_SCP $local_path/$file $REMOTE_USER@$REMOTE_IP:$remote_path "$REMOTE_PASSWD"`
### 远端文件传输到本地  
`SSH_SCP $REMOTE_USER@$REMOTE_IP:$remote_path/$file $local_path "$REMOTE_PASSWD"`
## func 2
### 目录传输
SFTP get/put --localdir $localdir --remotedir $remotedir
### 文件传输
SFTP get/put --localdir $localdir --remotedir $remotedir --localfile/remotefile $localfile/$remotefile
```

python

```python
### 目录传输
import ssh_cmd, sftp
conn = ssh_cmd.pssh_conn(remote_ip, remote_password,remote_port,remote_user,remote_timeout)
psftp_get(conn,remote_dir, local_dir)
psftp_put(local_dir=local_dir, remote_dir=remote_dir)
### 文件传输
import ssh_cmd, sftp
psftp_get(remote_dir, remote_file, local_dir)
psftp_put(local_dir=local_dir, local_file=local_file, remote_dir=remote_dir)

# get：从远端获取
# put：传输到远端
# localdir: 默认为当前目录
# remotedir：默认为远端根目录
```

- 获取空闲端口

bash

```GET_FREE_PORT $ip```

python

```import free_port```
```free_port.find_free_port(ip)```

- 检查端口是否被占用

bash 

```IS_FREE_PORT $port $ip```

python

```python
import free_port
free_port.is_free_port(port, ip)
```

- 获取测试网卡

bash

``TEST_NIC $node_id``

python

```python
import get_test_device
get_test_nic(node_id)

# node_id：默认为1号节点
```

- 获取测试磁盘

bash

```TEST_DISK $node_id```

python

```python
import get_test_device
get_test_disk(node_id)
 
 # node_id：默认为1号节点   
```

- 睡眠等待

bash

```SLEEP_WAIT $wait_time $cmd```

python

```python
import sleep_wait
sleep_wait.sleep_wait(wait_time,cmd)
```

- 远端重启等待

bash

```REMOTE_REBOOT_WAIT $node_id $wait_time```

**用例如何调试**

设置OET_PATH(mugen框架路径环境变量)之后，就可以在用例所在目录直接执行用例脚本
用例超时说明
默认超时30m
如果某条用例执行超过30m，在用例对TIMEOUT重新赋值

**FAQ**

远程后台执行命令时，用例执行卡住，导致用例超时失败
原因：ssh远程执行命令不会自动退出，会一直等待命令的控制台标准输出，直至命令运行信号结束
解决方案：可以将标准输出与标准错误输出重定向到/dev/null，如此ssh就不会一直等待cmd > /dev/nul 2>&1 &


### 1.2、LTP

**环境准备**

- 准备镜像
  从转测的正式地址获取镜像包(官方源: http://repo.openeuler.org)

- 准备ltp测试套
  ltp源码下载地址: https://github.com/linux-test-project/ltp
  ltp脚本和测试套获取：https://gitee.com/hanson_fang/ltpstress-for-openeuler

**环境安装**

- 机器安装（物理机安装参照安装指南）

- yum源配置(见start_ltp_test.sh中set_yum_env)

  '''sh start_ltp_test.sh compile 0803'''

**用例执行**

- 安装依赖包(见start_ltp_test.sh中的install_rpm)

- 编译ltp包(见start_ltp_test.sh中的compile_ltp)

- 运行用例(见start_ltp_test.sh中的run_testcases)

  '''sh start_ltp_test.sh run'''

**结果分析**

- 过滤失败用例
  grep -ir fail results/LTP*.log
- 重新执行
  ./runltp -s case_name
- 提单
  在问题单仓库(https://gitee.com/openeuler/kernel/issues)查看是否有单，如果不存在问题单则提单跟踪  

## 2、基础性能测试

建议测试前将以下依赖包安装
gcc bc make libtool automake gcc-c++ libtirpc-devel

### 2.1、unixbench

**基本概念**

Unixbench是一个类unix系统下的开源性能测试工具，被广泛用于测试linux系统主机的综合性能，测试结果不仅依赖硬件配置（CPU/内存/硬盘），还取决于操作系统、库甚至编译器的差异。既可以评估单进程性能，也可以评估多进程性能。

**预置条件**

1.获取Unixbench软件包5.1.3版本  
下载地址：https://github.com/kdlucas/byte-unixbench/archive/refs/tags/v5.1.3.tar.gz  

**编译安装**

1.安装依赖包
```shell
yum install perl -y
```

2.下载工具并解压

```shell
wget https://github.com/kdlucas/byte-unixbench/archive/refs/tags/v5.1.3.tar.gz
tar -xzf v5.1.3.tar.gz
cd byte-unixbench-5.1.3/UnixBench/
```

3.修改Run运行文件的参数
由于工具默认只支持测试最大16线程测试，需要将Run第109行的maxCopies参数更改为系统的逻辑核数以满足超过16线程的多线程测试。

```shell
sed -i "s/\('system.*'maxCopies'\) => 16/\1 => `nproc`/" Run
```

4.编译

```shell
make all
```

**测试执行**

1.单进程测试

```shell
./Run -c 1
```

2.多进程测试，进程数根据配置环境逻辑核数调整

```shell
./Run -c 96
```

**结果查看**

测试完成后结果会在运行界面打印出来，或可进入results文件查看。

### 2.2、netperf

**基本概念**

netperf是一种网络性能测试工具，主要基于TCP或UDP的传输。netperf根据应用的不同，可以进行不同模式的网络性能测试，即批量数据传输（bulk data transfer）模式和请求/应答（request/response）模式。可以测量TCP和UDP传输的吞吐量、时延、CPU 占用率等性能参数。netperf测试结果所反映的是一个系统能够以多快的速度向另一个系统发送数据，以及另一个系统能够以多快的速度接收数据。

**预置条件**

1.获取netperf软件包  
下载地址：https://github.com/HewlettPackard/netperf/archive/refs/tags/netperf-2.7.0.tar.gz  
2.客户端主机和服务端主机通过板载光口直连通信  
3.服务端主机关闭防火墙

**编译安装**

1.安装依赖包

```shell
yum install automake texinfo -y
```

2.在客户端主机和服务端主机分别安装netperf软件包

```shell
wget https://github.com/HewlettPackard/netperf/archive/refs/tags/netperf-2.7.0.tar.gz
tar xvf netperf-2.7.0.tar.gz
cd netperf-netperf-2.7.0
```
根据架构生成对应Makefile：  
arm:
```shell
./configure CFLAGS=-fcommon --host=arm-linux --build=arm-linux
```
x86:
```shell
./configure CFLAGS=-fcommon --host=x86-linux --build=x86-linux
```

执行编译
```shell
make clean && make -j
```

**测试执行**

1.服务端主机运行netserver

```shell
systemctl stop firewalld
cd src
./netserver
```
2.客户端主机执行压测命令，压测脚本命令如下：

```shell
#!/bin/bash
host_ip=$1
for i in 1 64 512 65536;do
./netperf -t TCP_STREAM -H $host_ip -l 60 -- -m $i
done

for i in 1 64 128 256 512 32768;do
./netperf -t UDP_STREAM -H $host_ip -l 60 -- -m $i
done

./netperf -t TCP_RR -H $host_ip
./netperf -t TCP_CRR -H $host_ip
./netperf -t UDP_RR -H $host_ip
```

3.执行测试脚本时传入服务端主机ip

**请替换真实服务端ip**

```shell
sh test-netperf.sh ${server_ip}
```

**结果查看**

测试完成后结果会在运行界面打印出来。

### 2.3、iozone

**基本概念**

 iozone是一个性能测试工具，用于评估存储系统（如磁盘、文件系统、网络文件系统等）的I/O性能。它可以进行各种读取和写入操作的测试，并提供了一系列的性能指标和报告。iozone可以测试顺序读取、随机读取、顺序写入、随机写入等不同类型的操作，并测量吞吐量、延迟、文件系统缓存效果等性能指标。

**预置条件**

1.获取iozone3_430软件包  
下载地址：https://www.iozone.org/src/current/iozone3_430.tar  
2.测试硬盘为NVMe盘

**编译安装**

```shell
wget https://www.iozone.org/src/current/iozone3_430.tar
tar xvf iozone3_430.tar
cd iozone3_430/src/current
make clean && make CFLAGS=-fcommon linux
```

**测试执行**

注：以下代码以shell脚本形式承载。

1.挂载待测NVMe数据盘

$disk替换为挂载数据盘名称
```shell
umount /dev/$disk && rm -rf /test && mkdir /test
mkfs.ext4 -F -E lazy_itable_init=0 /dev/$disk
mount -odioread_lock /dev/$disk /test
```

2.获取主机内存大小

```shell
num_dimm=`dmidecode -t 17 | grep "Size: [0-9]" | sed 's/^[\t]*//g' | grep ^"S" | wc -l`

dmidecode -t 17 | grep "Size: [0-9]" | grep "32768 MB" >/dev/null 2>&1 && dimm_size=32
dmidecode -t 17 | grep "Size: [0-9]" | grep "32 GB" >/dev/null 2>&1 && dimm_size=32
dmidecode -t 17 | grep "Size: [0-9]" | grep "64 GB" >/dev/null 2>&1 && dimm_size=64
dmidecode -t 17 | grep "Size: [0-9]" | grep "128 GB" >/dev/null 2>&1 && dimm_size=128

mem_size=`expr $num_dimm \* ${dimm_size}`
half_mem_size=`expr $mem_size / 2`
double_mem_size=`expr $mem_size + $mem_size`
```

3.针对测试文件为主机内存大小的1/2、1倍、2倍进行测试，测试命令如下：
```shell
for i in $double_mem_size $mem_size $half_mem_size
do
    sync
    echo 3 > /proc/sys/vm/drop_caches
    taskset -c 3 ./iozone -i 0 -i 1 -i 2 -s ${i}g -r 16m -f /test/tmptest -Rb iozone_${i}g.xls
    sleep 5
done
```
**结果查看**

测试完成后记录所有结果，即write、rewrite、read、reread、random_write、random_reed。

### 2.4、fio

**基本概念**

Fio是测试IOPS的工具，用来对磁盘进行压力测试和验证。磁盘IO是检查磁盘性能的重要指标，可以按照负载情况分成顺序读写、随机读写两大类。FIO是一个可以产生很多线程或进程并执行用户指定的特定类型I/O操作的工具，Fio的典型用法是编译和模拟的I/O负载匹配的作业文件。也就是说Fio是一个多线程IO生成工具，可以生成多种IO模式，用来测试磁盘设备的性能（也包括文件系统：如针对网络文件系统NFS的IO测试）。

**预置条件**

1.获取fio-3.33版本软件包  
下载地址：https://github.com/axboe/fio/archive/refs/tags/fio-3.33.zip  
2.测试硬盘为NVMe盘

**编译安装**

1.安装依赖包
```shell
yum install -y libaio-devel
```

2.编译安装
```shell
wget https://github.com/axboe/fio/archive/refs/tags/fio-3.33.zip
unzip fio-fio-3.33.zip
cd fio-fio-3.33
make clean
./configure --extra-cflags=-fcommon
make -j
```

**测试执行**

1.生成fio-test.sh测试脚本，测试命令如下：

```shell
#!/bin/bash
disk=nvme0n1
numjobs=10
iodepth=10
mkdir -p /test
for rw in read write randread randwrite randrw;do
    for bs in 4 16 32 64 128 256 512 1024;do
        mkfs.ext4 -F -E lazy_itable_init=0 /dev/$disk
        mount /dev/$disk /test
        if[ $rw == "randrw" ];then
            ./fio -filename=/test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw -rwmixread=70 -ioengine=libaio -bs=${bs}k -size=100G -numjobs=${numjobs} -runtime=30 -group_reporting -name=job1
        else
            ./fio -filename=/test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw -ioengine=libaio -bs=${bs}k -size=100G -numjobs=${numjobs} -runtime=30 -group_reporting -name=job1
        fi
        umount /test
        sleep 20
    done
done
```

**结果查看**

测试完成后,记录每个测试项的IOPS和带宽值。

### 2.5、stream

**基本概念**

stream是通过对数组的copy,scale,add,triad操作来测试CPU的内存访问带宽和浮点运算能力。Copy为最简单的操作，即从一个内存单元中读取一个数，并复制到另一个内存单元，有2次访存操作。Scale是乘法操作，从一个内存单元中读取一个数，与常数Scale相乘，得到的结果写入另一个内存单元，有2次访存。Add是加法操作，从两个内存单元中分别读取两个数，将其进行加法操作，得到的结果写入另一个内存单元中，有2次读和1次写共3次访存。Triad是前面三种的结合，先从内存中读取一个数，与scale相乘得到一个乘积，然后从一个内存单元中读取一个数与之前的乘积相加，得到的结果再写入内存，所以，有2次读和1次写共三次访存操作。

**预置条件**

1.获取stream软件包  
下载地址：https://github.com/jeffhammond/STREAM/archive/master.zip

**编译安装**

1.下载软件包解压缩

```shell
wget https://github.com/jeffhammond/STREAM/archive/master.zip
unzip STREAM-master.zip
chmod -R +x STREAM-master
cd STREAM-master
```

2.编译安装

```shell
gcc -fopenmp -O -DSTREAM_ARRAY_SIZE=100000000 stream.c -o fstream100M
```
注：参数-DSTREAM_ARRAY_SIZE表示测试数组大小，该参数的数值需要远大于CPU最高级缓存（一般为L3 Cache）的大小，通常是四倍以上。  

**测试执行**

1.执行单核测试：
```shell
export OMP_NUM_THREADS=1
export GOMP_CPU_AFFINITY=0
sync && sysctl -w vm.drop_caches=3
./fstream100M
```
2.执行满核测试：
```shell
export OMP_NUM_THREADS=`nproc`
export GOMP_CPU_AFFINITY=0-`expr $(nproc) - 1`
sync && sysctl -w vm.drop_caches=3
./fstream100M
```

**结果查看**

测试完成后结果会在运行界面打印出来。

### 2.6、lmbench

**基本概念**

lmbench是一套简易可移植的，符合 ANSI/C 标准为 UNIX/POSIX 而制定的微型测评工具。一般来说，它衡量两个关键特征：反应时间和带宽。它能够测试包括文档读写、内存操作、进程创建销毁开销、网络等性能。

**预置条件**

1.获取lmbench软件包  
下载地址：https://sourceforge.net/projects/lmbench/files/OldFiles/lmbench-3.0-a4.tgz/download  

**编译安装**

1.安装依赖包
```shell
yum install -y libtirpc libtirpc-devel
```

2.安装lmbench软件包
```shell
tar xvf lmbench-3.0-a4.tgz
cd lmbench-3.0-a4
```

3.修改相关配置使编译通过  
修改scripts/gnu-os脚本，将158、166、823行的`arm*`改为`aarch64*` (注：只针对ARM架构，x86架构不用修改)。  
修改src/disk.c文件，将292行和294行的`llseek`函数修改为`lseek64`。  
修改scripts/build脚本，在`LDLIBS=-lm`下面添加两行：
```shell
LDLIBS="${LDLIBS} -ltirpc"
CFLAGS="${CFLAGS} -I/usr/include/tirpc"
```

4.执行编译命令
```shell
make clobber clean && make
```

**测试执行**

1.进入交互模式
```shell
make results
```

2.配置测试所需config参数
```shell
MULTIPLE COPIES[DEFAULT 1]: (默认回车)
Job placement selection[DEFAULT 1]: （默认回车）
MB[default 182159]:512  (输入512)
SUBSET （ALL|HARWARE|OS|DEVELOPMENT）[default all]:(默认回车)
FASTMEM[default no]:(默认回车)
SLOWFS[default no]: (默认回车)
DISKS[default none]:(默认回车)
REMOTE[default none]: (默认回车)
Processor mhz[default 2599MHz,0.3848 nanosec clock]: (默认回车)
FSDIR[default /usr/tmp]: /usr/tmp
Status output file [default /dev/tty]: (默认回车)
Mail results [default yes]: no (设置为no)
```

**结果查看**

测试完成后结果会在运行界面打印出来。

## 3、DFX测试



## 4、安全测试

### 4.1 oss-fuzz:  以sleuthkit为例 

安全测试工具oss-fuzz工具指导来源于google oss-fuzz框架：https://github.com/google/oss-fuzz

**基本概念：**

- fuzz测试（模糊测试）是发现软件编程错误的著名技术。许多可检测的错误，如缓冲区溢出，可能会带来严重的安全隐患。谷歌通过部署guided in-process fuzzing of Chrome components发现了数千个安全漏洞和稳定性漏洞，我们现在希望与开源社区共享这项服务。

- OSS Fuzz与核心基础设施计划（Core Infrastructure Initiative）和OpenSSF合作，旨在通过将现代模糊技术与可扩展的分布式执行相结合，使通用开源软件更加安全和稳定。不符合OSS Fuzz标准的项目（例如封闭源代码）可以运行自己的ClusterFuzz或ClusterFuzzLite实例。

- 支持libFuzzer、AFL++和Honggfuzz这些fuzz引擎与Sanitizers以及ClusterFuzz（一种分布式fuzz执行环境和报告工具）相结合。

- 目前，OSS Fuzz支持C/C++、Rust、Go、Python和Java/JVM代码。LLVM支持的其他语言也可以工作。OSS Fuzz支持对x86_64和i386版本进行fuzz。

**测试部署环境准备：**

- 基础依赖包安装

  ```bash
  dnf -y install rpm-build docker git
  ```

- 下载docker并打标签 

  ```bash
  docker pull lutianxiong/base-builder
  docker pull lutianxiong/base-runner
  docker pull lutianxiong/base-msan-builder
  docker pull lutianxiong/msan-builder
  docker pull xxrz/msan-libs-builder
  docker tag lutianxiong/base-builder gcr.io/oss-fuzz-base/base-builder
  docker tag lutianxiong/base-runner gcr.io/oss-fuzz-base/base-runner
  docker tag lutianxiong/base-msan-builder gcr.io/oss-fuzz-base/base-msan-builder
  docker tag lutianxiong/msan-builder gcr.io/oss-fuzz-base/msan-builder
  docker tag xxrz/msan-libs-builder gcr.io/oss-fuzz-base/msan-libs-builder
  ```

- 查看镜像包适配的环境

  ```bash 
  docker image inspect “image的ID（需修改）” | grep Architecture
  ```

- 设置rpm打包环境

  ```bash
  dnf -y install rpmdevtools
  rpmdev-setuptree    #自动在用户家目录生成一个rpmbuild的文件夹，作为工作路径
  ```

**测试安装部署：**

- 源码下载

  ```bash
  git clone https://github.com/google/oss-fuzz.git
  git clone https://gitee.com/src-oepkgs/sleuthkit
  ```

**测试执行准备：**

- 复制下载的sleuthkit源码包到/root/rpmbuild/SOURCES
  ```bash
  cp -r ./sleuthkit/* /root/rpmbuild/SOURCES
  ```
- 切换到对应目录，解压对应源码包并打补丁
  ```bash
  cd /root/rpmbuild/SOURCES
  rpmbuild -bp sleuthkit.spec
  ```
- 复制解压并打了补丁的源码文件到oss-fuzz框架sleuthkit目录下
  ```bash
  cd /root/rpmbuild/BUILD
  cp -r sleuthkit-4.9.0/ /root/oss-fuzz/projects/sleuthkit
  ```
- 编辑Dockerfile文件
  ```bash
  cd /root/oss-fuzz/projects/sleuthkit
  vim Dockerfile
  ```

  ```bash
  FROM gcr.io/oss-fuzz-base/base-builder
  RUN apt-get update && apt-get install -y make autoconf automake libtool zlib1g-dev libstdc++6
  COPY sleuthkit-4.9.0 sleuthkit
  WORKDIR $SRC/sleuthkit
  COPY build.sh buildcorpus.sh sleuthkit_mem_img.h *_fuzzer.cc $SRC/
  ```

- 创建daemon.json文件
  ```bash
  touch /etc/docker/daemon.json
  ```
- 在daemon.json文件中设置：
  ```bash
  { 
    "experimental": true 
  }
  ```
- 重启docker服务
  ```bash
  systemctl restart docker
  ```
- 查看experimental值为true
  ```bash
  docker info | grep -i 'experimental'
  ```
- 创建bootstrap文件
  ```bash
  vim /root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0/bootstrap
  ```
  ```bash
  #!/bin/sh
  aclocal \
      && (libtoolize -c --force || glibtoolize -c --force) \
      && automake --foreign --add-missing --copy \
      && autoconf

  echo "c_FileTypeSigModule"
  (cd modules/c_FileTypeSigModule; sh ./bootstrap)
  echo "c_LibExifModule"
  (cd modules/c_LibExifModule; sh ./bootstrap)
  ```
- 赋权
  ```bash
  chmod a+x /root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0/bootstrap
  ```
- 复制modules文件到/root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0



  ```bash
  cd /opt/
  git clone https://gitee.com/src-openeuler/sleuthkit（只下载复制其中的modules文件，因为4.9.0里面没有这个文件）
  tar -xvf sleuthkit/sleuthkit-4.6.7.tar.gz
  cp -rf /opt/sleuthkit-4.6.7/framework/modules /root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0/
  ```
  
**测试执行及结果分析：**

- 编译fuzz文件

  ```bash
  cd /root/oss-fuzz/
  python3 infra/helper.py build_fuzzers --sanitizer undefined sleuthkit
  python3 infra/helper.py build_fuzzers --sanitizer memory sleuthkit
  python3 infra/helper.py build_fuzzers --sanitizer address sleuthkit
  ```
- 出现报错missing libstdc++的规避措施（未研究出解决办法，只能注释代码）：
  注释/root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0/configure中的两行
  查询libstdc++
  ```bash
  #else
  #  as_fn_error $? "missing libstdc++" "$LINENO" 5
  ```
  注释/root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0/configure.ac中的一行
  查询libstdc++
  ```bash
  #AC_CHECK_LIB(stdc++, main, , AC_MSG_ERROR([missing libstdc++]))
  ```
- 修改/root/oss-fuzz/infra/helper.py文件，添加执行最大时间参数和超时参数
  ```bash
  在344行添加如下代码：
  run_fuzzer_parser.add_argument('-max_total_time',
                                 help='seconds to run fuzzer',
                                 default=1800)
  run_fuzzer_parser.add_argument('-timeout',
                                 help='timeout seconds to run fuzzer',
                                 default=180)

  在1392行添加如下代码：
  args.fuzzer_args = [
          f'-max_total_time={args.max_total_time}', f'-timeout={args.timeout}'
      ]
  ```
- 执行fuzz文件，默认最大执行时间为1800秒，超时时间为180秒，如需修改可在下方执行语句后添加-max_total_time=1800 -timeout=180（修改具体值即可）

  ```bash
  python3 infra/helper.py run_fuzzer sleuthkit sleuthkit_fls_ext_fuzzer  
  python3 infra/helper.py run_fuzzer sleuthkit sleuthkit_fls_fat_fuzzer 
  python3 infra/helper.py run_fuzzer sleuthkit sleuthkit_fls_hfs_fuzzer  
  python3 infra/helper.py run_fuzzer sleuthkit sleuthkit_fls_iso9660_fuzzer 
  python3 infra/helper.py run_fuzzer sleuthkit sleuthkit_fls_ntfs_fuzzer   
  python3 infra/helper.py run_fuzzer sleuthkit sleuthkit_mmls_dos_fuzzer   
  python3 infra/helper.py run_fuzzer sleuthkit sleuthkit_mmls_gpt_fuzzer 
  python3 infra/helper.py run_fuzzer sleuthkit sleuthkit_mmls_mac_fuzzer  
  python3 infra/helper.py run_fuzzer sleuthkit sleuthkit_mmls_sun_fuzzer
  
  ```

- 复现fuzz问题
  当执行fuzz的过程中出现了问题，会在out目录下生成crash文件，通过以下命令即可复现fuzz问题


  ```bash
  python3 infra/helper.py reproduce sleuthkit sleuthkit_fls_hfs_fuzzer  crash-cdff9a3162823e34d63c04591442071ff1a9df72
  ```
- 日志解读
  ```bash
  #588154 NEW    cov: 263 ft: 484 corp: 219/112Kb lim: 4096 exec/s: 5026 rss: 31Mb L: 526/1048 MS: 1 ChangeASCIIInt-

  cov：执行当前语料库覆盖的代码块或边缘总数
  ft：libFuzzer 使用不同的信号来评估代码覆盖率，(edge coverage, edge counters, value profiles, indirect caller/callee)，这些信号的组合即为特性ft
  crop：当前内存测试语料库中的条目数及其字节大小
  Lim：当前对语料库中新词条长度的限制。随时间增加，直到达到最大长度（-max_len）
  exec/s：每秒模糊器迭代次数
  rss：当前内存消耗，对于 NEW 和 REDUCE 事件，输出行还包括有关产生新输入的变异操作的信息
  L：新输入的大小 (字节)
  MS：用于生成输入的变异操作的计数和列表
  ```

### 4.2、syzkaller

**环境准备**

- 准备syzkaller测试套
  脚本和测试套获取：https://gitee.com/hanson_fang/ltpstress-for-openeuler
  
**环境安装**

- 机器安装（物理机安装参照安装指南）
- 安装依赖服务
  执行sh syzdelop.sh deploy脚本qemu和syzkaller。
- 编译kernel
  执行sh syzdelop.sh build ubsan进行编译
- 创建虚拟vm
  执行sh syzdelop.sh createvm，然后通过tigervnc页面进行安装(安装同物理机安装)，也可参照syzkaller测试方法.docx
- 配置config文件
  执行sh syzdelop.sh config进行配置文件的配置，然后查看kernel的安装情况，'''rpm -q kernel'''

**用例执行**

- 运行syzkaller服务
  执行sh syzdelop.sh fuzz启动服务，并在url中输入ip：1234来查看服务的运行情况

**结果分析**

- 查看运行结果
  在url中输入ip：1234来查看服务的运行情况，没有crash出现，服务也没有中断即可
- 失败分析
  如果出现crash或出现服务中断需要提单

### 4.3、nmap 

安全测试工具nmap工具指导来源于博客：https://blog.csdn.net/u010142437/article/details/80097869

**测试安装部署：**

- 安装依赖

  ```bash
  yum install gcc -y
  yum install g++ -y
  ```

- 下载nmap并解压

  ```bash
  wget http://nmap.org/dist/nmap-7.01.tar.bz2
  tar -xvf nmap-7.01.tar.bz2 
  ```

- 编译安装

  ```bash
  ./configure
  make
  make install
  ```

- 运行nmap执行端口扫描任务


  扫描特定主机：

  ```bash
nmap 192.168.1.2 
  ```

  扫描整个子网：

  ```bash
nmap 192.168.1.1/24 
  ```

  扫描多个目标：

  ```bash
nmap 192.168.1.2 192.168.1.5 
  ```

  扫描一个范围内主机 (扫描IP地址为192.168.1.1-192.168.1.100内的所有主机) 

  ```bash：
nmap 192.168.1.1-100
  ```

### 4.4、mugen/security_test

参考1.1章节，security_test为其中的一个测试套

## 5、虚拟化测试

虚拟化测试工具指导来源于博客：https://www.openeuler.org/zh/blog/kezhiming/2021-01-20-virttest-avocado-vt.html

**基本概念：**

- Avocado：Avocado是一套帮助自动化测试的工具和库，源于autotest，最主要的优势包括可以多种形式的结果呈现、提供了多个实用的程序模块、可通过插件扩展等；更多信息可参见官方指导https://avocado-framework.readthedocs.io/en/latest/index.html
- Avocado-VT：Avocado-VT是一个虚拟化测试插件，提供与虚拟化测试相关的原子，并提供Avocado提供的所有便利；更多信息可参见官方指导https://avocado-vt.readthedocs.io/en/latest/index.html
- Tp（test-providers）：主要是提供组件测试用例集，当前openEuler上已有tp-libvirt/tp-qemu；

**测试部署环境准备：**

- 基础rpm包安装

  虚拟化组件包安装，qemu、libvirt、edk2等

  框架依赖包，git、gcc、python3-pip、python3-devel、tcpdump、nc、diffutils、iputils等

- pip3源配置

  avocado/avocado-vt部署时，需要通过pip3安装python第三方库，如果不配置，则通过pip3从python官方库获取第三方库。基于用户实际网络情况，选择配置pip3，可一定程度上提升下载的速率及稳定性。

  使用如下命令可配置，如配置tsinghua的源

  ```bash
  pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
  ```

- 其他配置

  基于用户的实际网络环境，如果测试环境有做相关的网络隔离，根据实际情况选择是否配置代理，包括git配置http/https代理、网络配置http/https代理

**测试安装部署：**

- 源码下载

  依次下载框架及用例集代码并切换到对应分支，其中branch当前支持openEuler-20.03

  ```bash
  git clone $url
  git checkout -f $branch
  ```

  包含以下几个仓库：

  https://gitee.com/src-openeuler/avocado

  https://gitee.com/openeuler/avocado-vt

  https://gitee.com/openeuler/tp-libvirt

  https://gitee.com/openeuler/tp-qemu

- avocado安装

  依赖包安装：pip3 install -r requirements-selftests.txt

  avocado框架安装： python3 setup.py install

- avacado-vt安装

  配置test-providers：配置libvirt、qemu

  依赖包安装：pip3 install -r requirements.txt

  avocado-vt插件安装： python3 setup.py install

- 用例集引导

  引导tp-libvirt、tp-qemu用例集

  ```bash
  avocado vt-bootstrap --vt-type qemu --vt-skip-verify-download-assets --yes-to-all
  avocado vt-bootstrap --vt-type libvirt --vt-skip-verify-download-assets --yes-to-all
  ```

- 以上的部署过程总结成如下代码：

  ```bash
  install_virttest() {
      local branch=$1
  
      cd "$srcdir/tp-qemu"
      git checkout -f "$branch"
  
      cd "$srcdir/tp-libvirt"
      git checkout -f "$branch"
  
      cd "$srcdir/avocado"
      git checkout -f "$branch"
      sed -i "s/^libvirt-python/#&/" requirements-selftests.txt
      pip3 install -r requirements-selftests.txt
      python3 setup.py install
  
      cd "$srcdir/avocado-vt"
      git checkout -f "$branch"
      sed -i "/^branch: /d" test-providers.d/io-github-autotest-qemu.ini
      sed -i "/^uri: /c uri: $srcdir/tp-qemu" test-providers.d/io-github-autotest-qemu.ini
      sed -i "/^uri: /a branch: $branch" test-providers.d/io-github-autotest-qemu.ini
      sed -i "/^branch: /d" test-providers.d/io-github-autotest-libvirt.ini
      sed -i "/^uri: /c uri: $srcdir/tp-libvirt" test-providers.d/io-github-autotest-libvirt.ini
      sed -i "/^uri: /a branch: $branch" test-providers.d/io-github-autotest-libvirt.ini
      rm -f test-providers.d/io-github-spiceqa-spice.ini
      pip3 install -r requirements.txt
      python3 setup.py install
  
      avocado vt-bootstrap --vt-type qemu --vt-skip-verify-download-assets --yes-to-all
      avocado vt-bootstrap --vt-type libvirt --vt-skip-verify-download-assets --yes-to-all
  }
  ```

**测试执行准备：**

- 虚拟机xml

  需要提前准备好libvirt的xml，并在执行tp-libvirt相关用例前先define

- 测试虚拟机镜像准备

  镜像的命名要求、支持镜像的范围，可参见配置/var/lib/avocado/data/avocado-vt/backends/libvirt/cfg/guestos-os.cfg

  镜像存放路径为/var/lib/avocado/data/avocado-vt/images/，所在磁盘分区空间需要足够大，在用例执行过程中会先备份一下镜像，故此空间至少是镜像大小两倍以上。多机场景的用例，会通过virt-clone等方式克隆多份镜像，尤其需要注意镜像所在磁盘分区空间的大小

- libvirt配置

  设置/etc/libvirt/qemu.conf下user/group字段，配置为root

- 测试框架的base配置

  基础配置，包含了虚拟机名称、镜像名称、镜像登录用户密码等。如果涉及迁移双机场景，需要配置迁移环境的配置信息。

  ```text
  /var/lib/avocado/data/avocado-vt/backends/libvirt/cfg/base.cfg
  /var/lib/avocado/data/avocado-vt/backends/libvirt/cfg/guest-os.cfg
  ```

**测试执行及结果分析：**

- 用例查看

  在用例执行之前，先通过avocado list查看对应模块的用例，可同时用于检测框架部署的正确性。

  如下几条命令，分别可查看qemu、libvirt以及通过多个条件组合过滤后的qemu_img模块的用例集。如果不做过滤用例集较大，命令执行稍微耗时多点（1分钟内）

  ```bash
  avocado list --vt-type qemu --vt-machine-type arm64-pci
  avocado list --vt-type libvirt --vt-machine-type arm64-pci 
  avocado list qemu_img --vt-type qemu --vt-no-filter non-preallocated --vt-only-filter cluster_size_default --vt-machine-type arm64-pci
  ```

- qemu用例执行

  qemu用例可直接执行，不依赖libvirt的配置以及使用libvirt事先define一个虚拟机

  示例：

  ```bash
  avocado run type_specific.io-github-autotest-qemu.qemu_img.create.preallocated.cluster_size_default --vt-type qemu --vt-guest-os Guest.Linux.openEuler.20.03 --vt-machine-type arm64-pci
  ```

  ![run-qemu-test-20210120](https://www.openeuler.org/assets/img/run-qemu-test-20210120.1c2ea242.png)

- libvirt用例执行

  libvirt用例执行之前，确保libvirt服务启动状态，同时需要基于前一章节中准备的虚拟机xml和镜像define一个测试虚拟机

  示例：

  ```bash
  avocado list virsh.reset --vt-type libvirt --vt-no-filter acl_test --vt-only-filter uuid_options --vt-machine-type arm64-pci
  ```

- 结果定位

  框架执行的每个用例的日志，都会归档在logs_dir = ~/avocado/job-results下（具体可配置avocado.conf中logs_dir字段）。

  参考前面qemu用例的执行示例图，可以看到日志的归档，关注JOB LOG文件 ，可以基于此开展失败分析定位。

## 6、内核测试

### 6.1、trinity:  syscall fuzzer

**基本概念：**

trinity是一个关于Linux系统调用的fuzz测试工具，此工具采用一些技术将半智能参数传递给被调用的系统调用，支持aarch64、x86-64等多种架构。

智能功能包括：

- 如果系统调用需要某种数据类型作为参数（例如文件描述符），它会被传递一个。这就是初始启动缓慢的原因，因为它会生成可以从 /sys、/proc 和 /dev 读取的文件的 fd 列表，然后用 fd 对各种网络协议套接字进行补充。（关于哪些协议成功/失败的信息在第一次运行时被缓存，大大提高了后续运行的速度）。
- 如果系统调用只接受某些值作为参数（例如“标志”字段），Trinity 会列出所有可以传递的有效标志。只是为了在工作中扔一把扳手，偶尔，它会翻转其中一个标志，只是为了让事情变得更有趣。
- 如果系统调用只接受一个范围的值，则传递的随机值通常会偏向该范围内。

Trinity 将它的输出记录到文件中（每个子进程 1 个），并且 fsync 在它实际进行系统调用之前记录文件。这样，如果你触发了一些让内核恐慌的事情，你应该能够通过检查日志来准确地找出发生了什么。

提供了几个测试工具 (test-*.sh)，它们以各种模式运行 trinity，并负责处理 CPU 亲和性等事情，并确保它从 tmp 目录运行。（便于清理任何名为垃圾的文件；之后只需 rm -rf tmp）

**安装部署：**

```bash
git clone https://github.com/kernelslacker/trinity.git
cd trinity
./configure
make && make install
```

**参数说明：**

```
--quiet/-q: reduce verbosity.
   Specify once to not output register values, or twice to also suppress syscall count.

 --verbose: increase verbosity.

 -D: Debug mode.
     This is useful for catching core dumps if trinity is segfaulting, as by default
     the child processes ignore those signals.

 -sN: use N as random seed.  (Omitting this uses time of day as a seed).
  Note: There are currently a few bugs that mean no two runs are necessary 100%
  identical with the same seed. See the TODO for details.

 --kernel_taint/-T: controls which kernel taint flags should be considered.
	The following flag names are supported: PROPRIETARY_MODULE, FORCED_MODULE, UNSAFE_SMP,
	FORCED_RMMOD, MACHINE_CHECK, BAD_PAGE, USER, DIE, OVERRIDDEN_ACPI_TABLE, WARN, CRAP,
	FIRMWARE_WORKAROUND, and OOT_MODULE. For instance, to set trinity to monitor only BAD,
	WARN and MACHINE_CHECK flags one should specify "-T BAD,WARN,MACHINE_CHECK" parameter.

 --list/-L: list known syscalls and their offsets

 --proto/-P: For network sockets, only use a specific packet family.

 --victims/-V: Victim file/dirs.  By default, on startup trinity tree-walks /dev, /sys and /proc.
     Using this option you can specify a different path.
     (Currently limited to just one path)

 -p: Pause after making a syscall

 --children/-C: Number of child processes.

 -x: Exclude a syscall from being called.  Useful when there's a known kernel bug
     you keep hitting that you want to avoid.
     Can be specified multiple times.

 -cN: do syscall N with random inputs.
     Good for concentrating on a certain syscall, if for eg, you just added one.
     Can be specified multiple times.

 --group/-g
   Used to specify enabling a group of syscalls. Current groups defined are 'vm' and 'vfs'.

 --logging/-l <arg>
  off: This disables logging to files. Useful if you have a serial console, though you
         will likely lose any information about what system call was being called,
         what maps got set up etc. Does make things go considerably faster however,
         as it no longer fsync()'s after every syscall
  <hostname> : sends packets over udp to a trinity server running on another host.
         Note: Still in development. Enabling this feature disables log-to-file.
  <dir> : Specify a directory where trinity will dump its log files.

 --ioctls/-I will dump all available ioctls.

 --arch/-a Explicit selection of 32 or 64 bit variant of system calls.
```

**使用示例：**

对splice这个系统调用进行压力测试

```bash
./trinity -c splice
```

 对除splice这个系统调用以外的所有系统调用进行测试

```bash
./trinity -x splice
```

关闭日志记录，并抑制大多数输出以尽可能快地运行。使用 16 个子进程

```bash
./trinity -qq -l off -C16
```

## 7、接口测试

### 7.1、api sanity checker: an automatic generator of basic unit tests for a C/C++ library API

**基本概念：**

API Sanity Checker 是 C/C++库基本单元测试的自动生成器。此工具基于签名、数据类型定义和直接来自库头文件的函数之间的关系（“标题驱动的生成”）对API快速生成简易测试（“健全”或“浅薄”质量）。每个测试用例都包含一个合理输入参数的函数调用（在大多数情况下，但不是所有情况下）。工具可以为库引入高度可重用的专用类型以大幅提高测试质量。使用者可以通过生成测试的质量以检查简单实用场景下是否存在严重错误。

该工具可以执行生成的测试并检测崩溃、中止、各种发出的信号、非零程序返回码、程序挂起和要求失败（如果指定）。该工具可以被认为是开箱即用的工具库 API 的低成本健全性检查或作为测试开发框架用于高级测试的初始模板生成。它还支持通用Template2Code格式测试、夹板规范、随机测试生成模式和其他有用的功能。

**使用示例：**

```bash
api-sanity-checker -lib NAME -d VERSION.xml -gen -build -run

VERSION.xml is XML-descriptor:
<version>1.0</version>
<headers>
  /path1/to/header(s)/
  /path2/to/header(s)/
  ...
</headers>
<libs>
  /path1/to/library(ies)/
  /path2/to/library(ies)/
  ...
</libs>
```

**测试结果：**

当运行后返回值为0时，测试通过。

**参数说明：**

```
-h|-help								Print this help.

-info										Print complete info.

-v|-version							Print version information.

-dumpversion						Print the tool version (1.98.7) and don't do anything else.

-l|-lib|-library 				NAME

		Library name (without version).

-d|-descriptor 					PATH

		Path to the library descriptor (VER.xml file):

		<version>

				1.0

		</version>

		<headers>

				/path1/to/header(s)/ /path2/to/header(s)/ ...

		</headers>

		<libs>

				/path1/to/library(ies)/ /path2/to/library(ies)/ ...

		</libs>

		For more information, please see: http://lvc.github.com/api-sanity-checker/Xml-Descriptor.html

-gen|-generate

    Generate  test(s). Options -l and -d should be specified.  To generate test for the
    particular function use it with -f option.  Exit code: number of test cases  failed
    to build.

-build|-make

    Build  test(s).  Options  -l  and  -d  should  be specified.  To build test for the
    particular function use it with -f option.  Exit code: number of test cases  failed
    to generate.

-run

    Run  test(s),  create  test  report. Options -l and -d should be specified.  To run
    test for the particular function use it with  -f  option.   Exit  code:  number  of
    failed test cases.

-clean

    Clean  test(s).  Options  -l  and  -d  should  be specified.  To clean test for the
    particular function use it with -f option.

-vnum NUM

		Specify library version outside the descriptor.

-s|-symbol NAME

		Generate/Build/Run test for the specified function (mangled name in C++).

-symbols-list PATH

    This option allows one to specify a file with a list of functions  (one  per  line,
    mangled  name  in  C++)  that should be tested, other library functions will not be
    tested.

-header NAME

    This option allows one to restrict a list of functions that  should  be  tested  by
    providing  a  header  file name in which they are declared. This option is intended
    for step-by-step tests development.

-all

		Generate tests for all symbols recursively included in header file(s).

-xvfb

		Use Xvfb-server instead of current X-server (default) for running tests.

-t2c|-template2code

    Generate tests in the universal Template2Code format.  For more information, please
    see: http://sourceforge.net/projects/template2code/

-strict-gen

    Terminate  the  process  of  generating  tests  and return error code '1' if cannot
    generate at least one test case.

-strict-build

    Terminate the process of building tesst and return error code '1' if  cannot  build
    at least one test case.

-strict-run

    Terminate  the  process  of running tests and return error code '1' if at least one
    test case failed.

-strict

		This option enables all -strict-* options.

-r|-random

		Random test generation mode.

-min

    Generate minimun  code,  call  functions  with  minimum  number  of  parameters  to
    initialize parameters of other functions.

-max

    Generate  maximum  code,  call  functions  with  maximum  number  of  parameters to
    initialize parameters of other functions.

-show-retval

		Show the function return type in the report.

-check-retval

		Insert requirements on return values (retval!=NULL) for each called function.

-st|-specialized-types PATH

    Path to the file with the collection of specialized types.  For  more  information,
    please see: http://lvc.github.com/api-sanity-checker/Specialized-Type.html

-td|-test-data PATH

    Path to the directory with the test data files.  For more information, please see:
    http://lvc.github.com/api-sanity-checker/Specialized-Type.html

-headers-only

    If the library consists of inline functions only and has no shared objects then you
    should specify this option.

-no-inline

		Don't generate tests for inline functions.

-keep-internal

    Generate tests for internal symbols (functions with  '__'  prefix  and  methods  of
    classes declared inside other classes).

-isolated

    Allow one to restrict functions usage by the lists specified by the -functions-list
    option or by the group devision in the descriptor.

-view-only

    Remove all files from the test suite except *.html files. This option allows one to
    create a lightweight html-index for all tests.

-disable-default-values

		Disable usage of default values for function parameters.

-optimize-includes LEVEL

    Enable  optimization  of the list of included headers in each test case.  Available
    levels:

    High (default) Medium Low None - disable

-p|-params PATH

    Path to file with the function parameter  names.  It  can  be  used  for  improving
    generated  tests  if  the  library header files don't contain parameter names. File
    format:

    func1;param1;param2;param3 ...  func2;param1;param2;param3 ...  ...

-title NAME

		The name of the library in the report title.

-relpath|-reldir PATH

		Replace {RELPATH} in the library descriptor by PATH.

-lang LANG

    Set library language (C or C++). You  can  use  this  option  if  the  tool  cannot
    auto-detect a language.

-target COMPILER

    The  compiler  that  should  be  used  to  build  generated  tests  under  Windows.
    Supported:

    gcc - GNU compiler cl - MS compiler (default)

-debug

		Write extended log for debugging.

-cache

		Cache the ABI dump and use it on the next run.

-test

    Run internal tests. Create a simple library and run the tool on  it.   This  option
    allows one to check if the tool works correctly on the system.

-disable-variable-reuse

		Disable reusing of previously created variables in the test.

-long-variable-names

		Enable long (complex) variable names instead of short names.
```

## 8、长稳测试

### 8.1、long stress

**环境准备**

- 准备long_stress测试套
  ltp脚本和测试套获取: https://gitee.com/hanson_fang/ltpstress-for-openeuler

**用例执行**

- 运行ltpstress工具套
  执行sh run_ltpstress.sh，如sh run_ltpstree.sh -m 512 -t 48H

**结果分析**

- 查看运行结果
  需要查看服务是否出现中断，crash文件生成，大文件生成等，具体检查项见dfx.txt


## 9、GUI测试

### 9.1、openQA

openQA测试指导请阅读[openQA](./openQA/openQA.md)文档

## 10、编译器测试

### 10.1、dejagnu

**安裝**

1、下载dejagnu工具

https://mirrors.ustc.edu.cn/gnu/dejagnu/dejagnu-1.6.1.tar.gz

(下载到/home下)

2、构建dejagnu（这一步是为了生成runtest的二进制文件）

（1）安装expect(否则会报错)

dnf install -y expect

（2）解压并构建

tar -zxf dejagnu-1.6.1.tar.gz

mkdir /home/install_runtest

cd dejagnu-1.6.1/

./configure --prefix=/home/install_runtest

make -j

make install

3、设置环境变量（这里设置的是runtest的）

export PATH=/home/install_runtest/bin:$PATH



**测试**

1、设置编译器环境变量

export PATH=/home/install/bin:$PATH

2、在gcc源码主目录下执行命令测试

make -j -k check

获取源码方式1：

git clone https://gitee.com/openeuler/gcc.git

这种方式获取的源码里面有testsuite，可以直接复制测试套进行测试

获取源码方式2：

git clone -b branch_name https://gitee.com/src-openeuler/gcc.git

获取的源码需要rpmbuild 后才能在/root/rpmbuild/BUILD下生成正真的源码

cd gcc

rpmbuild -bp gcc.spec

如果没有rpmbuild命令，则安装：yum install -y rpm-build

若有错误，则在当前目录(源码主目录)下执行：cp ./* /root/rpmbuild/SOURCES/

```
此种方式的testsuite在 /root/rpmbuild/BUILD下，复制一个测试套进行测试全量用例测试

cp /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite  /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite-gcc -r

runtest --tool gcc

cp /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite  /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite-g++ -r

runtest --tool g++

cp /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite  /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite-gfortran

runtest --tool gfortran
```

3、测试结果保存在如下日志文件

./host-aarch64-linux-gnu/gcc/testsuit/gcc/gcc.log

./host-aarch64-linux-gnu/gcc/testsuit/g++/g++.log

./host-aarch64-linux-gnu/gcc/testsuit/obj-c++/pbj-c++.log

./host-aarch64-linux-gnu/gcc/testsuit/objc/objc.log

./host-aarch64-linux-gnu/gcc/testsuit/gfortran/gfortran.log



**单个用例或单个exp执行**

例如split-path-10.c，同目录下有exp文件：tree-ssa.exp，如果没有在上层目录找

在testsuite目录下执行：

runtest --tool gcc tree-ssa.exp=split-path-10.c

runtest --tool gcc tree-ssa.exp

全量执行gcc

runtest --tool gcc

### 10.2、llvmcase

**基本概念：**

LLVM 项目是模块化和可重用的编译器和工具链技术的集合

**测试部署环境准备：**

安装GCC:yum install -y gcc gcc-*

**测试安装部署：**

- 源码下载

  git clone https://github.com/llvm/llvm-project.git

- 编译

  (1).c文件编译

  ```
  gcc ***.c ${option} -o ***.out
  ```

  (2).cpp文件编译

  ```
  g++ ***.cpp ${option} -o ***.out
  ```

  (3).f .F90 .f90文件编译

  ```
  gfortran ***.f ${option} -o ***.out
  ```

- 运行

  ./***.out

### 10.3、Anghabench

**基本概念：**

一个包含 100 万个可编译程序的基准套件，从 GitHub 上最大的公共 C 存储库中挖掘出来

**测试部署环境准备：**

安装GCC:yum install -y gcc gcc-*

**测试安装部署：**

- 源码下载

  git clone https://github.com/brenocfg/AnghaBench.git

- 编译

  gcc ***.c ${option} -o ***.out

  编译成功会生成.out文件

- 运行

  ./***.out

### 10.4、jotai

**基本概念：**

一个开源存储库挖掘的可执行基准的大量集合。每个基准测试由一个用C编写的函数组成，加上一个运行该函数的驱动程序。

**测试部署环境准备：**

安装GCC:yum install -y gcc gcc-*

**测试安装部署：**

- 源码下载

  git clone https://github.com/lac-dcc/jotai-benchmarks.git

- 编译

  gcc ***.c ${option} -o ***.out

  编译成功会生成.out文件

- 运行

  ./***.out

### 10.5、csmith

**基本概念：**

Csmith 是 C 程序的随机生成器。它的主要目的是使用差异测试作为测试预言，使用随机程序查找编译器错误

**测试部署环境准备：**

- 安装GCC:yum install -y gcc gcc-*

- 安装依赖：yum install -y cmake m4

- 源码下载

  git clone https://github.com/csmith-project/csmith.git

- csmith编译

  cd csmith

  cmake -DCMAKE_INSTALL_PREFIX=<INSTALL-PREFIX> .

  make && make install

- 使用csmith生成.c文件

  export PATH=$PATH:$HOME/csmith/bin

  csmith > random1.c

- 编译及运行

  gcc random1.c -I$HOME/csmith/include -o random1

  ./random1

**其他**

查看csmith其他选项：./csmith -h

具体使用：通过自动化批量生成百万级用例来验证编译器

### 10.6、yarpgen

**基本概念：**

yarpgen是一个随机程序生成器，可生成正确的可运行 C/C++ 和 DPC++（这项工作处于早期阶段）程序。该生成器专门设计用于触发编译器优化错误，并用于编译器测试

**测试部署环境准备：**

- 安装GCC:yum install -y gcc gcc-*

- 安装依赖：yum install -y cmake

- 源码下载

  git clone https://github.com/intel/yarpgen.git

- yarpgen编译

  cd yarpgen

  mkdir build

  cd build

  cmake ..

  make

- 使用yarpgen生成.cpp文件

  ./yarpgen

  cat init.h func.cpp driver.cpp > random1.cpp

  sed -i 's|#include "init.h"||g' random1.cpp

- 编译及运行

  g++ random1.cpp -I$HOME/csmith/include -o random1

  ./random1

**其他**

查看yarpgen其他选项：./yarpgen -h

具体使用：通过自动化批量生成百万级用例来验证编译器

## 11、自编译测试

## 12、北向兼容性测试

从全栈的角度看，操作系统处于中间层，软件处于上方，北向兼容性即操作系统的软件兼容性

进行软件兼容性测试请参考下列文档，来源于https://gitee.com/openeuler/oec-application/blob/master/doc/

[北向开源软件包适配迁移详细指导](https://gitee.com/openeuler/oec-application/blob/master/doc/北向开源软件包适配迁移详细指导.md)

[openEuler社区开源软件适配流程](https://gitee.com/openeuler/oec-application/blob/master/doc/openEuler社区开源软件适配流程.md)

[软件所oepkgs上rpm构建以及建仓流程](https://gitee.com/openeuler/oec-application/blob/master/doc/rpm构建以及建仓流程.md)

[openEuler软件包兼容性分级](https://gitee.com/openeuler/oec-application/blob/master/doc/compatibility_level.md)

### 12.1 oecp

**工具介绍**
本工具旨在
* 检测2个ISO（基于RPM）的软件包，软件包内文件，库文件接口（C/C++）,内核KABI的变化差异
* 检测同一个软件（rpm包）在不同版本下的变化以及差异

**执行方法介绍**
```bash
### 安装预置环境，libabigail需要openEuler-20.03-LTS-SP2及以上版本的everything仓库
yum install libabigail createrepo binutils

python3 cli.py [-h] [-n PARALLEL] [-w WORK_DIR] [-p PLAN_PATH] [-c CATEGORY_PATH] [--platform PLATFORM_TEST_PATH] [-f OUTPUT_FORMAT] [-o OUTPUT_FILE] [-d DEBUGINFO] file1 file2
```

**参数解释**
* **位置参数(必选)**
  * **`file`**
    指定两个比较的iso文件/存放rpm包的目录（directory）/rpm包，注意以file1作为基准

* **可选参数**

  * **`-n, --parallel`**
    指定`进程池并发数量`，默认cpu核数

  * **`-w, --work-dir`**
    指定`工作路径`，默认路径为/tmp/oecp
  
  * **`-p, --plan`**
    指定`比较计划`，默认为oecp/conf/plan/all.json

  * **`-c, --category`**
    指定`包级别信息`，默认为oecp/conf/category/category.json
	
  * **`-d, --debuginfo`**
    指定`debuginfo iso/rpm路径`
	
  * **`-f, --format`**
    指定`输出格式`，默认为csv

  * **`-o, --output`**
    指定`输出结果路径`，默认为/tmp/oecp

  * **`--platform`**
    指定`进行平台验证有关json报告地址`，默认为/tmp/oecp；性能测试默认基线文件为oecp/conf/performance/openEuler-20.03-LTS-aarch64-dvd.iso.performance.json
    
* **举例**

  * **` python3 cli.py  /root/openEuler-20.03-LTS-aarch64-dvd.iso /root/openEuler-20.03-LTS-SP1-aarch64-dvd.iso`**

* **比较计划说明**
  * **`all.json`**
    涵盖下面所有配置项的比较
  * **`config_file.json`**
    比较rpm包中配置文件内容的差异，需依赖RPMExtractDumper（提取解压rpm的dumper类）
  * **`file_list.json`**
    比较rpm包文件列表差异，可通过rpm -pql ${rpm_path}命令获取rpm文件列表
  * **`kconfig.json`**
    比较内核配置文件，需依赖RPMExtractDumper（提取解压rpm的dumper类）
  * **`package_list.json`**
    比较两个rpm包名称、版本、发行版本的差异
  * **`provides_requires.json`**
    比较rpm的provides和requires差异，可通过rpm -pq --provides/requires ${rpm_path}查询

## 13、南向兼容性测试

从全栈的角度看，操作系统处于中间层，硬件处于下方，南向兼容性即操作系统的硬件兼容性

### 13.1、oech-ci

**工具介绍**

本工具将南向兼容性测试工具 oec-hardware 集成到 compass-ci ，通过指定板卡配置文件，实现自动在 compass-ci 的测试机环境中获取存在测试板卡的机器，自动生成需要提交的 job yaml 文件，自动提交任务，实现oec-hardware硬件自动化测试。

1. 非网卡测试，会随机获取一台符合条件的机器进行测试，也可以配置文件中指定机器进行测试。

2. 网卡（NIC/IB）测试，需要在配置文件中指定服务端和客户端测试机名称进行测试。

- 注意：

  目前不支持虚拟机和物理机的混合集群，因为物理机和虚拟机不在统一网段，不能组成集群。

- 优化方向：

  关于集群信息的获取，现在是读取lab库，可以优化为从data-api读取。

  读取接口： cci hosts

**执行测试方法介绍**

    * 调试命令，不真实提交，只是看提交流程是否正确：
    
            python3 oech_ci.py -o /home/user/tmp \
                                    -j $LKP_SRC/jobs/oech.yaml \
                                    -l /home/user/lab-z9 \
                                    -c ./test_conf.json
    
    * 提交命令：
    
            python3 oech_ci.py -j $LKP_SRC/jobs/oech.yaml \
                                    -l /home/user/lab-z9 \
                                    -c ./test_conf.json

**参数解释**

```
-o 

    调试路径，不真实提交，输出处理好的yaml,测试的时候可以用这个参数调试

-j

    oech的job yaml 文件路径

-l

    测试机环境的库

-c 

    板卡文件配置文件，可参考 config 目录下的文件
```

**结果查询**

处理提交过程会有打印以外，会在当前的目录下生成一个以提交时间为名的目录，例如：

```
2022-05-05-17-32-23
    - ethernet-SP580-14e4-16d7-1402-14e4-cs-s1-a112-c1-a113.yaml
    - submit_result
```

这个submit_result文件包含了提交的信息和job_id,可以根据job_id来查询job的执行过程和结果。

注意测试提交时也会有这个文件，但是没有job_id的。

另一个yaml文件就是提交的完整job yaml(无论测试还是真实提交都会有这个文件)。

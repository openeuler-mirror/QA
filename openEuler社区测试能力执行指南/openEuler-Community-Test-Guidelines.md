# openEuler Community Test Execution Guide

## 1. Functional Testing

### 1.1. mugen

The tool guide comes from https://gitcode.com/openeuler/mugen

**Introduction to mugen**
mugen is a testing framework developed by the openEuler community. It provides common configuration and methods so that community developers can write and execute test code.

**mugen Update Notes**
Optimized the entry point of the mugen framework.
The current version adds support for test suite paths and test case environments.
Added new Python common functions.

**mugen Usage Tutorial**
Install dependencies:

`bash dep_install.sh`

**Configure Test Suite Environment Variables**
Command execution:

```bash
bash mugen.sh -c --ip $ip --password $passwd --user $user --port $port
```

Parameter description:

```
ip: the IP address of the test machine
user: the login user of the test machine, defaults to root
password: the login password of the test machine
port: the SSH login port of the test machine, defaults to 22
Environment variable file: ./conf/env.json
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
            "HOST_PASSWORD": "",
            "HOST_SSH_PORT": ""
        }
    ]
}
Usage in test cases: NODE{id}_{LOCALTION}
```

**Test Case Execution**

- Execute all test cases: `bash mugen.sh -a`
- Execute a specified test suite: `bash mugen.sh -f testsuite`
- Execute a single test case: `bash mugen.sh -f testsuite -r testcase`
- Output the execution process of shell scripts:

```bash
bash mugen.sh -a -x
bash mugen.sh -f testsuite -x
bash mugen.sh -f testsuite -r testcase -x
```

**Adding Test Cases**
Write test case scripts according to the template (recommended):

`source ${OET_PATH}/libs/locallibs/common_lib.sh`

**Data and parameter configuration to preload**

```bash
function config_params() {
    LOG_INFO "Start to config params of the case."
    LOG_INFO "No params need to config."
    LOG_INFO "End to config params of the case."
}
```

**Preparing the test object and the tools required by the test**

```bash
function pre_test() {
    LOG_INFO "Start to prepare the test environment."
    LOG_INFO "No pkgs need to install."
    LOG_INFO "End to prepare the test environment."
}
```

**Execution of test points**

```bash
function run_test() {
    LOG_INFO "Start to run test."

    # Test command: ls
    ls -CZl -all
    CHECK_RESULT 0

    # Test whether the proc|usr|roor|var|sys|etc|boot|dev directories exist under /
    CHECK_RESULT "$(ls / | grep -cE 'proc|usr|roor|var|sys|etc|boot|dev')" 7

    LOG_INFO "End to run test."
}
```

**Post-processing to restore the test environment**

```bash
function post_test() {
    LOG_INFO "Start to restore the test environment."
    LOG_INFO "Nothing to do."
    LOG_INFO "End to restore the test environment."
}
```

`main "$@"`

For a plain shell script or Python script, whether the test case succeeds is determined by the return code of the script execution.
Refer to the samples: test cases oe_test_casename_02 and oe_test_casename_03 
How to write the json file in suite2cases.
The file name is the test suite name and the file suffix is .json.

**File Content Description**

Common functions of the framework.
How to load them into test cases for invocation.

**bash**

`source ${OET_PATH}/libs/locallibs/common_lib.sh`

**python**

```python
import os, sys, subprocess

LIBS_PATH = os.environ.get("OET_PATH") + "/libs/locallibs"
sys.path.append(LIBS_PATH)
import xxx
```

**Common Functions**

- Log printing

**bash**

```bash
LOG_INFO "$message"
LOG_WARN "$message"
LOG_DEBUG "$message"
LOG_ERROR "$message"
```

**python**

```python
import mugen_log
mugen_log.logging(level, message) # level:INFO,WARN,DEBUG,ERROR;message: log output
```

- Result checking

**bash**

```bash
CHECK_RESULT $1 $2 $3 $4
# $1: the returned result of the test point
# $2: the expected result
# $3: comparison mode, 0: the returned result and the expected result are equal; 1: the returned result and the expected result are not equal
# $4: problem-found log output
```

- rpm package installation and removal

**bash**

```bash
## func 1
DNF_INSTALL "vim bc" "$node_id"
DNF_REMOVE "$node_id" "jq" "$mode"

# mode: defaults to 0, which removes the packages installed in the test case; when it is non-zero, only the current software package is uninstalled
```

**python**

```python
import rpm_manage
tpmfile = rpm_manage.rpm_install(pkgs, node, tmpfile)
rpm_manage.rpm_remove(node, pkgs, tmpfile)
```

- Remote command execution

**bash**

```bash
## func 1
SSH_CMD "$cmd" $remote_ip $remote_password $remote_user $time_out $remote_port
## func 2
P_SSH_CMD --cmd $cmd --node $node(remote node number)
P_SSH_CMD --cmd $cmd --ip $remote_ip --password $remote_password --port $remote_port --user $remote_user --timeout $timeout
```

**python**

```python
conn = ssh_cmd.pssh_conn(remote_ip, remote_password,remote_port,remote_user,remote_timeout)
exitcode, output = ssh_cmd.pssh_cmd(conn, cmd)

# port: defaults to 22
# user: defaults to root
# timeout: no limit by default
```

- Directory/file transfer

**bash**

```bash
## func 1
### Transfer a local file to the remote end  
`SSH_SCP $local_path/$file $REMOTE_USER@$REMOTE_IP:$remote_path "$REMOTE_PASSWD"`
### Transfer a remote file to the local end  
`SSH_SCP $REMOTE_USER@$REMOTE_IP:$remote_path/$file $local_path "$REMOTE_PASSWD"`
## func 2
### Directory transfer
SFTP get/put --localdir $localdir --remotedir $remotedir
### File transfer
SFTP get/put --localdir $localdir --remotedir $remotedir --localfile/remotefile $localfile/$remotefile
```

**python**

```python
### Directory transfer
import ssh_cmd, sftp
conn = ssh_cmd.pssh_conn(remote_ip, remote_password,remote_port,remote_user,remote_timeout)
psftp_get(conn,remote_dir, local_dir)
psftp_put(local_dir=local_dir, remote_dir=remote_dir)
### File transfer
import ssh_cmd, sftp
psftp_get(remote_dir, remote_file, local_dir)
psftp_put(local_dir=local_dir, local_file=local_file, remote_dir=remote_dir)

# get: fetch from the remote 
# put: transfer to the remote 
# localdir: defaults to the current directory
# remotedir: defaults to the remote root directory
```

- Get a free port

**bash**

`GET_FREE_PORT $ip`

**python**

```python
import free_port
free_port.find_free_port(ip)
```

- Check whether a port is occupied

**bash**

`IS_FREE_PORT $port $ip`

**python**

```python
import free_port
free_port.is_free_port(port, ip)
```

- Get the test NIC

**bash**

`TEST_NIC $node_id`

**python**

```python
import get_test_device
get_test_nic(node_id)

# node_id: defaults to node 1
```

- Get the test disk

**bash**

`TEST_DISK $node_id`

**python**

```python
import get_test_device
get_test_disk(node_id)

# node_id: defaults to node 1
```

- Sleep and wait

**bash**

`SLEEP_WAIT $wait_time $cmd`

**python**

```python
import sleep_wait
sleep_wait.sleep_wait(wait_time,cmd)
```

- Remote reboot and wait

**bash**

`REMOTE_REBOOT_WAIT $node_id $wait_time`

**How to Debug Test Cases**

After setting OET_PATH (the mugen framework path environment variable), you can directly execute the test case script in the directory.
Test case timeout description.
The default timeout is 30m.
If a test case runs for more than 30m, reassign TIMEOUT in the test case.

**FAQ**

When executing a command remotely in the background, the test case gets stuck, causing it to fail due to timeout.
Cause: a command executed remotely via ssh does not exit automatically; it keeps waiting for the standard output of the  console until the command's running signal ends.
Solution: redirect standard output and standard error output to /dev/null, so that ssh no longer keeps waiting: `cmd > /dev/null 2>&1 &`


### 1.2. LTP

**Test Preparation**

- Prepare the ltp test suite and scripts
  ltp source code download address: https://github.com/linux-test-project/ltp
  ltp script download address: https://gitcode.com/openeuler/test-tools/tree/master/kernel-testsuite/ltp

**Test Case Execution**

Execute the following script to run the test cases: `sh start_ltp_test.sh`
> The above command contains the following 3 parts:
> 1) Install the dependency packages (see install_rpm in start_ltp_test.sh);
> 2) Compile the ltp package (see compile_ltp in start_ltp_test.sh);
> 3) Run the test cases (see run_testcases in start_ltp_test.sh).

**Result Analysis**

1. Filter out the failed test cases
  `grep -ir fail results/LTP*.log`
2. Re-execute
  `./runltp -s case_name`
3. Analyze the failed test cases and submit issues
  After confirming it is an issue, check whether the issue has already been reported in the repository `(https://gitcode.com/openeuler/kernel/issues)`; if not, submit a new issue and track it.

## 2. Basic Performance Testing

Environment preparation:
1. Install the following dependency packages before starting the test
```shell
yum install -y gcc bc make libtool automake gcc-c++ libtirpc-devel
```

### 2.1. unixbench

**Basic Concepts**

Unixbench is an open-source performance testing tool for Unix-like systems, widely used to test the overall performance of Linux system hosts. The test results depend not only on hardware configuration (CPU/memory/disk) but also on differences in the operating system, libraries, and even the compiler. It can evaluate both single-process performance and multi-process performance. 

**Prerequisites**

1. Obtain the Unixbench package version 5.1.3
Download address: https://github.com/kdlucas/byte-unixbench/archive/refs/tags/v5.1.3.tar.gz

**Compilation and Installation**

1. Install the dependency packages
```shell
yum install perl -y
```

2. Download the tool and extract it

```shell
wget https://github.com/kdlucas/byte-unixbench/archive/refs/tags/v5.1.3.tar.gz
tar -xzf v5.1.3.tar.gz
cd byte-unixbench-5.1.3/UnixBench/
```

3. Modify the parameters of the Run execution file
Since the tool supports testing a maximum of 16 threads by default, change the maxCopies parameter at line 109 of Run to the number of logical cores of the system to satisfy multithread testing of more than 16 threads.

```shell
sed -i "s/\('system.*'maxCopies'\) => 16/\1 => `nproc`/" Run
```

4. Compile

```shell
make all
```

**Test Execution**

1. Single-thread test

```shell
./Run -c 1 -i 3
```

2. Multi-thread test. You can use `nproc` to specify the maximum number of logical cores of the system for testing

```shell
./Run -c `nproc` -i 3
```

**Viewing Results**

After the test completes, Unixbench will output the scores of each test sub-item in the terminal, where the value of System Benchmarks Index Score is the total score of all test sub-items.
Run the test three times and average the total scores. Higher is better.

### 2.2. netperf

**Basic Concepts**

netperf is a network performance testing tool, mainly based on TCP or UDP transmission. Depending on the application, netperf can carry out network performance tests in different modes, namely bulk data transfer mode and request/response mode. It can measure performance parameters such as the throughput, latency, and CPU utilization of TCP and UDP transmission. The netperf test result reflects how fast one system can send data to another and how fast the other system can receive data.

**Prerequisites**

1. Obtain the netperf package
Download address: https://github.com/HewlettPackard/netperf/archive/refs/tags/netperf-2.7.0.tar.gz
2. The client node and the server node are connected directly through the on-board optical port.
3. Disable the firewall on the server node.

**Compilation and Installation**

1. Install the dependency packages

```shell
yum install automake texinfo -y
```

2. Install the netperf package on both the client node and the server node.

```shell
wget https://github.com/HewlettPackard/netperf/archive/refs/tags/netperf-2.7.0.tar.gz
tar -xvf netperf-2.7.0.tar.gz
cd netperf-netperf-2.7.0
./autogen.sh
```
Generate the corresponding Makefile according to the architecture:
arm:
```shell
./configure CFLAGS=-fcommon --host=arm-linux --build=arm-linux
```
x86:
```shell
./configure CFLAGS=-fcommon --host=x86-linux --build=x86-linux
```

Execute compilation
```shell
make clean && make -j
```

**Test Execution**

1. Run netserver on the server node.

```shell
systemctl stop firewalld
cd src
./netserver
```
2. Run the stress test command on the client node. The stress test script test-netperf.sh is as follows:

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

3. Pass the server node IP when executing the test script.

**Please replace with the real server IP**

```shell
sh test-netperf.sh ${server_ip}
```

**Viewing Results**

After the test completes, the result is printed on the running interface.
Record the throughput of TCP_STREAM and UDP_STREAM under different test sizes respectively, and take their geometric mean to obtain value A. At the same time, record the throughput of the TCP_RR, TCP_CRR, and UDP_RR tests, and take the geometric mean with value A to obtain the final score.
Run the test three times and average the total scores. Higher is better.

### 2.3. iozone

**Basic Concepts**

iozone is a performance testing tool used to evaluate the I/O performance of storage systems (such as disks, file systems, network file systems, etc.). It can test various read and write operations and provide a series of performance metrics and reports. iozone can test different types of operations such as sequential read, random read, sequential write, and random write, and measure performance metrics such as throughput, latency, and file system cache effects.

**Prerequisites**

1. Obtain the iozone package
Download address: https://www.iozone.org/src/current/iozone3_430.tar
2. The test disk is a NVMe

**Compilation and Installation**

```shell
wget https://www.iozone.org/src/current/iozone3_430.tar
tar -xvf iozone3_430.tar
cd iozone3_430/src/current
make clean && make CFLAGS=-fcommon linux
```

**Test Execution**

Note: the following commands are provided as a shell script.

1. Mount the NVMe data disk

Replace $disk with the name of the data disk to be mounted
```shell
umount /dev/$disk && rm -rf /test && mkdir /test
mkfs.ext4 -F -E lazy_itable_init=0 /dev/$disk
mount -odioread_lock /dev/$disk /test
```

2. Get the host memory size

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

3. Run the test with a test file of half, 1x, and 2x the host memory size. The test command is as follows:
```shell
for i in $double_mem_size $mem_size $half_mem_size
do
    sync
    echo 3 > /proc/sys/vm/drop_caches
    taskset -c 3 ./iozone -i 0 -i 1 -i 2 -s ${i}g -r 16m -f /test/tmptest -Rb iozone_${i}g.xls
    sleep 5
done
```
**Viewing Results**

After the test completes, record the results of the write, rewrite, read, reread, random_write, and random_read items, and take the geometric mean as a single value for the measurement standard.
Run the test three times and average the total scores. Higher is better.

### 2.4. fio

**Basic Concepts**

Fio is a tool for testing IOPS, used to stress test and verify disks. Disk IO is an important metric for checking disk performance, and can be divided into two major categories according to load conditions: sequential read/write and random read/write. FIO is a tool that can spawn many threads or processes and execute user-specified specific types of I/O operations. A typical use of Fio is to write and simulate job files that match the I/O load. That is, Fio is a multi-threaded IO generation tool that can generate multiple IO modes to test the performance of disk devices (including file systems, such as IO testing for the NFS network file system).

**Prerequisites**

1. Obtain the fio package
Download address: https://github.com/axboe/fio/archive/refs/tags/fio-3.33.zip
2. The test disk is a NVMe

**Compilation and Installation**

1. Install the dependency packages
```shell
yum install -y libaio-devel
```

2. Compile and install
```shell
wget https://github.com/axboe/fio/archive/refs/tags/fio-3.33.zip
unzip fio-fio-3.33.zip
cd fio-fio-3.33
make clean
./configure --extra-cflags=-fcommon
make -j
```

**Test Execution**

1. Generate the fio-test.sh test script, where $disk is replaced with the actual disk name. The specific test script command is as follows:

```shell
#!/bin/bash
disk=$disk
numjobs=10
iodepth=10
mkdir -p /test
for rw in read write randread randwrite randrw;do
    for bs in 4 16 32 64 128 256 512 1024;do
        mkfs.ext4 -F -E lazy_itable_init=0 /dev/$disk
        mount /dev/$disk /test
        if [ $rw == "randrw" ];then
            ./fio -filename=/test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw \
              -rwmixread=70 -ioengine=libaio -bs=${bs}k -size=100G -numjobs=${numjobs} \
              -runtime=30 -group_reporting -name=job1 > $rm$bs.log
        else
            ./fio -filename=/test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw \
              -ioengine=libaio -bs=${bs}k -size=100G -numjobs=${numjobs} -runtime=30 \
              -group_reporting -name=job1 > $rm$bs.log
        fi
        umount /test
        sleep 20
    done
done
```

**Viewing Results**

After the test completes, the result of each test item is saved to the corresponding \$rm\$bs.log file. Take the geometric mean of the IOPS and bandwidth values of each sub-item from 4k to 1024k, and then use all the geometric means as the total score.
Run the test three times and average the total scores. Higher is better.

### 2.5. stream

**Basic Concepts**

stream tests the CPU's memory access bandwidth and floating-point computing capability through copy, scale, add, and triad operations on arrays. Copy is the simplest operation, reading a number from one memory unit and copying it to another memory unit, with 2 memory accesses. Scale is a multiplication operation, reading a number from one memory unit, multiplying it by a constant Scale, and writing the result to another memory unit, with 2 memory accesses. Add is an addition operation, reading two numbers from two memory units separately, adding them, and writing the result to another memory unit, with 2 reads and 1 write for a total of 3 memory accesses. Triad is a combination of the previous three, reading a number from memory, multiplying it with scale to obtain a product, then reading a number from a memory unit and adding it to the previous product, and writing the result to memory, so there are 2 reads and 1 write for a total of 3 memory accesses.

**Prerequisites**

1. Obtain the stream package
Download address: https://github.com/jeffhammond/STREAM/archive/master.zip

**Compilation and Installation**

1. Download and extract the package

```shell
wget https://github.com/jeffhammond/STREAM/archive/master.zip
unzip STREAM-master.zip
chmod -R +x STREAM-master
cd STREAM-master
```

2. Compile and install

```shell
gcc -fopenmp -O -DSTREAM_ARRAY_SIZE=100000000 stream.c -o fstream100M
```
Note: the parameter -DSTREAM_ARRAY_SIZE represents the test array size. The value of this parameter needs to be much larger than the size of the CPU's highest-level cache (usually L3 Cache), typically more than four times.

**Test Execution**

1. Execute the single-core test:
```shell
export OMP_NUM_THREADS=1
export GOMP_CPU_AFFINITY=0
sync && sysctl -w vm.drop_caches=3
./fstream100M
```
2. Execute the full-core test:
```shell
export OMP_NUM_THREADS=`nproc`
export GOMP_CPU_AFFINITY=0-`expr $(nproc) - 1`
sync && sysctl -w vm.drop_caches=3
./fstream100M
```

**Viewing Results**

After the test completes, the result is printed on the running interface. Record the four values of copy, scale, add, and triad in the single-core and full-core tests, and take the geometric mean as the test result.
Run the test three times and average the results. Higher is better.

### 2.6. lmbench

**Basic Concepts**

lmbench is a simple and portable micro-benchmarking tool that conforms to the ANSI/C standard and is developed for UNIX/POSIX. Generally speaking, it measures two key characteristics: latency and bandwidth. It can test the performance of file read/write, memory operations, process creation/destruction overhead, network, and so on.

**Prerequisites**

1. Obtain the lmbench package
Download address: https://sourceforge.net/projects/lmbench/files/OldFiles/lmbench-3.0-a4.tgz/download

**Compilation and Installation**

1. Install the dependency packages
```shell
yum install -y libtirpc libtirpc-devel
```

2. Install the lmbench package
```shell
tar -xvf lmbench-3.0-a4.tgz
cd lmbench-3.0-a4
```

3. Modify the relevant configuration so that compilation passes
Modify the scripts/gnu-os script and change `arm*` at lines 158, 166, and 823 to `aarch64*` (Note: only for the ARM architecture; no modification is needed for the x86 architecture).
Modify the src/disk.c file and change the `llseek` function at lines 292 and 294 to `lseek64`.
Modify the scripts/build script and add the following two lines below `LDLIBS=-lm`:
```shell
LDLIBS="${LDLIBS} -ltirpc"
CFLAGS="${CFLAGS} -I/usr/include/tirpc"
```

4. Execute the compilation command
```shell
make clobber clean && make
```

**Test Execution**

1. Enter interactive mode
```shell
make results
```

2. Configure the config parameters required by the test
```shell
MULTIPLE COPIES[DEFAULT 1]: (press Enter by default)
Job placement selection[DEFAULT 1]: (press Enter by default)
MB[default 182159]:512  (enter 512)
SUBSET (ALL|HARWARE|OS|DEVELOPMENT)[default all]:(press Enter by default)
FASTMEM[default no]:(press Enter by default)
SLOWFS[default no]: (press Enter by default)
DISKS[default none]:(press Enter by default)
REMOTE[default none]: (press Enter by default)
Processor mhz[default 2599MHz,0.3848 nanosec clock]: (press Enter by default)
FSDIR[default /usr/tmp]: /usr/tmp
Status output file [default /dev/tty]: (press Enter by default)
Mail results [default yes]: no (set to no)
```

**Viewing Results**

After the test completes, execute `make see` to view the results. Take the geometric mean of Processor Processor, Context switching, Local latency, File & VM system, and Memory latency respectively as the latency metrics; calculate the geometric mean of Local Bandwidth as the bandwidth metric.
Run the test three times and average the results. For latency, lower is better; for bandwidth, higher is better.

## 3. DFX Testing

## 4. Security Testing

### 4.1 oss-fuzz: taking sleuthkit as an example

The guide for the security testing tool oss-fuzz comes from the Google oss-fuzz framework: https://github.com/google/oss-fuzz

**Basic Concepts:**

- Fuzz testing is a well-known technique for discovering software programming errors. Many detectable errors, such as buffer overflows, may bring serious security risks. Google discovered thousands of security vulnerabilities and stability vulnerabilities by deploying guided in-process fuzzing of Chrome components, and we now wish to share this service with the open-source community.

- OSS Fuzz, in cooperation with the Core Infrastructure Initiative and OpenSSF, aims to make general-purpose open-source software more secure and stable by combining modern fuzzing techniques with scalable distributed execution. Projects that do not meet the OSS Fuzz standards (for example, closed-source code) can run their own ClusterFuzz or ClusterFuzzLite instances.

- It combines fuzz engines such as libFuzzer, AFL++, and Honggfuzz with Sanitizers and ClusterFuzz (a distributed fuzz execution environment and reporting tool).

- Currently, OSS Fuzz supports C/C++, Rust, Go, Python, and Java/JVM code. Other languages supported by LLVM can also work. OSS Fuzz supports fuzzing x86_64 and i386 builds.

**Test Deployment Environment Preparation:**

- Install the base dependency packages

  ```bash
  dnf -y install rpm-build docker git
  ```

- Download docker images and tag them

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

- Check the target architecture of an image

  ```bash 
  docker image inspect "the ID of the image (to be modified)" | grep Architecture
  ```

- Set up the rpm packaging environment

  ```bash
  dnf -y install rpmdevtools
  rpmdev-setuptree    # Automatically generate an rpmbuild folder in the user's home directory as the working path
  ```

**Test Installation and Deployment:**

- Download the source code

  ```bash
  git clone https://github.com/google/oss-fuzz.git
  git clone https://gitee.com/src-oepkgs/sleuthkit  
  ```
Note: the src-oepkgs repository has not been migrated.

**Test Execution Preparation:**

- Copy the downloaded sleuthkit source package to /root/rpmbuild/SOURCES
  ```bash
  cp -r ./sleuthkit/* /root/rpmbuild/SOURCES
  ```
- Switch to the corresponding directory, extract the corresponding source package, and apply patches
  ```bash
  cd /root/rpmbuild/SOURCES
  rpmbuild -bp sleuthkit.spec
  ```
- Copy the extracted and patched source files to the sleuthkit directory of the oss-fuzz framework
  ```bash
  cd /root/rpmbuild/BUILD
  cp -r sleuthkit-4.9.0/ /root/oss-fuzz/projects/sleuthkit
  ```
- Edit the Dockerfile
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

- Create the daemon.json file
  ```bash
  touch /etc/docker/daemon.json
  ```
- Set the following in the daemon.json file:
  ```bash
  { 
    "experimental": true 
  }
  ```
- Restart the docker service
  ```bash
  systemctl restart docker
  ```
- Check that the experimental value is true
  ```bash
  docker info | grep -i 'experimental'
  ```
- Create the bootstrap file
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
- Grant permissions
  ```bash
  chmod a+x /root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0/bootstrap
  ```
- Copy the modules file to /root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0



  ```bash
  cd /opt/
  git clone https://gitee.com/src-openeuler/sleuthkit (only download and copy the modules file in it, because version 4.9.0 does not have this file)
  tar -xvf sleuthkit/sleuthkit-4.6.7.tar.gz
  cp -rf /opt/sleuthkit-4.6.7/framework/modules /root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0/
  ```

**Test Execution and Result Analysis:**

- Compile the fuzz files

  ```bash
  cd /root/oss-fuzz/
  python3 infra/helper.py build_fuzzers --sanitizer undefined sleuthkit
  python3 infra/helper.py build_fuzzers --sanitizer memory sleuthkit
  python3 infra/helper.py build_fuzzers --sanitizer address sleuthkit
  ```
- Workaround for the "missing libstdc++" error (no solution has been found yet; only comment out the code):
  Comment out two lines in /root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0/configure
  (line that checks for libstdc++)
  ```bash
  #else
  #  as_fn_error $? "missing libstdc++" "$LINENO" 5
  ```
  Comment out one line in /root/oss-fuzz/projects/sleuthkit/sleuthkit-4.9.0/configure.ac
  (line that checks for libstdc++)
  ```bash
  #AC_CHECK_LIB(stdc++, main, , AC_MSG_ERROR([missing libstdc++]))
  ```
- Modify the /root/oss-fuzz/infra/helper.py file and add the maximum execution time parameter and the timeout parameter
  ```bash
  Add the following code at line 344:
  run_fuzzer_parser.add_argument('-max_total_time',
                                 help='seconds to run fuzzer',
                                 default=1800)
  run_fuzzer_parser.add_argument('-timeout',
                                 help='timeout seconds to run fuzzer',
                                 default=180)

  Add the following code at line 1392:
  args.fuzzer_args = [
          f'-max_total_time={args.max_total_time}', f'-timeout={args.timeout}'
      ]
  ```
- Run the fuzz files. The default maximum execution time is 1800 seconds and the timeout is 180 seconds. To modify them, add -max_total_time=1800 -timeout=180 after the execution statement below (modify the specific values)

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

- Reproduce the fuzz problem
  When a problem occurs during the fuzz execution, a crash file is generated in the out directory. The fuzz problem can be reproduced with the following command


  ```bash
  python3 infra/helper.py reproduce sleuthkit sleuthkit_fls_hfs_fuzzer  crash-cdff9a3162823e34d63c04591442071ff1a9df72
  ```
- Log interpretation
  ```bash
  #588154 NEW    cov: 263 ft: 484 corp: 219/112Kb lim: 4096 exec/s: 5026 rss: 31Mb L: 526/1048 MS: 1 ChangeASCIIInt-

  cov: the total number of code blocks or edges covered by the current corpus
  ft: libFuzzer uses different signals to evaluate code coverage (edge coverage, edge counters, value profiles, indirect caller/callee). The combination of these signals is the feature ft
  corp: the number of entries in the current in-memory test corpus and their size in bytes
  lim: the current limit on the length of new entries in the corpus. It increases over time until it reaches the maximum length (-max_len)
  exec/s: the number of fuzzer iterations per second
  rss: the current memory consumption. For NEW and REDUCE events, the output line also includes information about the mutation operations that produced the new input
  L: the size of the new input (in bytes)
  MS: the count and list of mutation operations used to generate the input
  ```

### 4.2. syzkaller

**Test Preparation**

- Prepare the syzkaller test suite
  Script and test suite download address: https://gitcode.com/openeuler/test-tools/tree/master/kernel-testsuite/syzkaller

**Environment Setup**

1. Install the dependency services
  Execute `sh syzdelop.sh deploy` to install qemu and syzkaller
2. Compile the kernel
  Execute `sh syzdelop.sh build ubsan` to compile
3. Create the virtual vm
  Execute `sh syzdelop.sh createvm`, then install via the tigervnc page (the same as installing on a physical machine)
4. Configure the config file
  Execute `sh syzdelop.sh config` to configure the configuration file, then check the kernel installation status with `rpm -q kernel`

**Test Case Execution**

- Run the syzkaller service
  Execute `sh syzdelop.sh fuzz` to start the service, and enter ip:1234 in the URL to check the running status of the service

**Result Analysis**

- View the running result
  Enter ip:1234 in the URL to check the running status of the service. It is fine as long as no crash appears and the service is not interrupted
- Failure analysis
  If a crash appears or the service is interrupted, submit an issue.

### 4.3. nmap

The guide for the security testing tool nmap comes from the blog: https://blog.csdn.net/u010142437/article/details/80097869

**Test Installation and Deployment:**

- Install the dependencies

  ```bash
  yum install gcc -y
  yum install g++ -y
  ```

- Download nmap and extract it

  ```bash
  wget http://nmap.org/dist/nmap-7.01.tar.bz2
  tar -xvf nmap-7.01.tar.bz2 
  ```

- Compile and install

  ```bash
  ./configure
  make
  make install
  ```

- Run nmap to perform a port scan task


  Scan a specific host:

  ```bash
  nmap 192.168.1.2 
  ```

  Scan an entire subnet:

  ```bash
  nmap 192.168.1.1/24 
  ```

  Scan multiple targets:

  ```bash
  nmap 192.168.1.2 192.168.1.5 
  ```

  Scan hosts within a range (scan all hosts with IP addresses from 192.168.1.1 to 192.168.1.100)

  ```bash
  nmap 192.168.1.1-100
  ```

### 4.4. mugen/security_test

Refer to section 1.1; security_test is one of the test suites.

## 5. Virtualization Testing

The virtualization testing tool guide comes from the blog: https://www.openeuler.org/zh/blog/kezhiming/2021-01-20-virttest-avocado-vt.html

**Basic Concepts:**

- Avocado: Avocado is a set of tools and libraries that help automate testing, originating from autotest. Its main advantages include the ability to present results in multiple forms, providing multiple practical program modules, and extensibility via plugins. For more information, see the official guide https://avocado-framework.readthedocs.io/en/latest/index.html
- Avocado-VT: Avocado-VT is a virtualization testing plugin that provides atoms related to virtualization testing and provides all the conveniences Avocado offers. For more information, see the official guide https://avocado-vt.readthedocs.io/en/latest/index.html
- Tp (test-providers): mainly provides the component test case set. Currently openEuler already has tp-libvirt/tp-qemu;

**Test Deployment Environment Preparation:**

- Install the base rpm packages

  Install the virtualization component packages: qemu, libvirt, edk2, etc.

  Framework dependency packages: git, gcc, python3-pip, python3-devel, tcpdump, nc, diffutils, iputils, etc.

- pip3 source configuration

  When deploying avocado/avocado-vt, the third-party Python libraries need to be installed via pip3. If not configured, the third-party libraries are fetched from the official Python repository via pip3. Based on the user's actual network conditions, configuring pip3 can improve the download speed and stability to some extent.

  It can be configured with the following command, for example, to configure the Tsinghua source

  ```bash
  pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
  ```

- Other configurations

  Based on the user's actual network environment, if the test environment has relevant network isolation, choose whether to configure a proxy according to the actual situation, including configuring http/https proxy for git and configuring http/https proxy for the network

**Test Installation and Deployment:**

- Download the source code

  Download the framework and test case set code in sequence and switch to the corresponding branch, where branch currently supports openEuler-20.03

  ```bash
  git clone $url
  git checkout -f $branch
  ```

  It includes the following repositories:

  https://gitcode.com/src-openeuler/avocado

  https://gitcode.com/openeuler/avocado-vt

  https://gitcode.com/openeuler/tp-libvirt

  https://gitcode.com/openeuler/tp-qemu

- avocado installation

  Install the dependency packages: pip3 install -r requirements-selftests.txt

  Install the avocado framework: python3 setup.py install

- avocado-vt installation

  Configure the test-providers: configure libvirt and qemu

  Install the dependency packages: pip3 install -r requirements.txt

  Install the avocado-vt plugin: python3 setup.py install

- Test case set bootstrap

  Bootstrap the tp-libvirt and tp-qemu test case sets

  ```bash
  avocado vt-bootstrap --vt-type qemu --vt-skip-verify-download-assets --yes-to-all
  avocado vt-bootstrap --vt-type libvirt --vt-skip-verify-download-assets --yes-to-all
  ```

- The above deployment process is summarized in the following code:

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

**Test Execution Preparation:**

- Virtual machine xml

  The libvirt xml needs to be prepared in advance, and must be defined before executing the tp-libvirt-related test cases

- Test virtual machine image preparation

  For the image naming requirements and the supported image range, see the config /var/lib/avocado/data/avocado-vt/backends/libvirt/cfg/guestos-os.cfg

  The image storage path is /var/lib/avocado/data/avocado-vt/images/. The disk partition space must be large enough, because the image is backed up first during test case execution, so the space needs to be at least twice the image size. For test cases in multi-machine scenarios, multiple image copies are cloned via methods such as virt-clone, so special attention must be paid to the size of the disk partition where the images are located

- libvirt configuration

  Set the user/group fields in /etc/libvirt/qemu.conf to root

- Base configuration of the test framework

  Basic configuration, including the virtual machine name, image name, image login user/password, etc. If a migration two-machine scenario is involved, the configuration information of the migration environment needs to be configured.

  ```text
  /var/lib/avocado/data/avocado-vt/backends/libvirt/cfg/base.cfg
  /var/lib/avocado/data/avocado-vt/backends/libvirt/cfg/guest-os.cfg
  ```

**Test Execution and Result Analysis:**

- View the test cases

  Before executing test cases, use avocado list to view the test cases of the corresponding module, which can also be used to check the correctness of the framework deployment.

  The following commands can respectively view the test case sets of qemu, libvirt, and the qemu_img module filtered by multiple combined conditions. If no filtering is applied, the test case set is large and the command execution takes a little more time (within 1 minute)

  ```bash
  avocado list --vt-type qemu --vt-machine-type arm64-pci
  avocado list --vt-type libvirt --vt-machine-type arm64-pci 
  avocado list qemu_img --vt-type qemu --vt-no-filter non-preallocated --vt-only-filter cluster_size_default --vt-machine-type arm64-pci
  ```

- qemu test case execution

  qemu test cases can be executed directly, without depending on the libvirt configuration or using libvirt to define a virtual machine in advance

  Example:

  ```bash
  avocado run type_specific.io-github-autotest-qemu.qemu_img.create.preallocated.cluster_size_default --vt-type qemu --vt-guest-os Guest.Linux.openEuler.20.03 --vt-machine-type arm64-pci
  ```

  ![run-qemu-test-20210120](https://www.openeuler.org/assets/img/run-qemu-test-20210120.1c2ea242.png)

- libvirt test case execution

  Before executing libvirt test cases, ensure that the libvirt service is in the started state, and define a test virtual machine based on the virtual machine xml and image prepared in the previous section

  Example:

  ```bash
  avocado list virsh.reset --vt-type libvirt --vt-no-filter acl_test --vt-only-filter uuid_options --vt-machine-type arm64-pci
  ```

- Result location

  The log of each test case executed by the framework is archived under logs_dir = ~/avocado/job-results (specifically configurable via the logs_dir field in avocado.conf).

  Refer to the execution example figure of the qemu test case above to see the log archives. Pay attention to the JOB LOG file, based on which failure analysis and location can be carried out.

## 6. Kernel Testing

### 6.1. LTP

**Test Preparation**

- Prepare the ltp test suite and scripts
  ltp test suite download address: https://github.com/linux-test-project/ltp
  ltp script download address: https://gitcode.com/openeuler/test-tools/tree/master/kernel-testsuite/ltp

**Test Case Execution**

Execute the following script to run the test cases: `sh start_ltp_test.sh`
> The above command contains the following 3 parts:
> 1). Install the dependency packages (see install_rpm in start_ltp_test.sh);
> 2). Compile the ltp package (see compile_ltp in start_ltp_test.sh);
> 3). Run the test cases (see run_testcases in start_ltp_test.sh).

**Result Analysis**

1. Filter out the failed test cases
  `grep -ir fail results/LTP*.log`
2. Re-execute the failed test cases
  `./runltp -s case_name`
3. Analyze the failed test cases and submmit issues
  After confirming it is an issue, check whether the issue has already been reported in the issue tracker `(https://gitcode.com/openeuler/kernel/issues)`; if not, submit a new issue and track it.

### 6.2. posix

**Test Preparation**

- Prepare the ltp test suite and scripts
  ltp test suite download address: https://github.com/linux-test-project/ltp/archive/refs/tags/20210927.zip
  ltp script download address: https://gitcode.com/openeuler/test-tools/tree/master/kernel-testsuite/ltp

**Test Case Execution**

Execute the following script: `sh posix_test.sh|tee posix_test.log`

**Result Analysis**

It is fine as long as the above script executes successfully and the test case pass rate in the result is >= 97%.

### 6.3. long stress

**Test Preparation**

- Prepare the long_stress test suite
  ltp test suite source code download address: https://github.com/linux-test-project/ltp
  ltpstress script download address: https://gitcode.com/openeuler/test-tools/tree/master/kernel-testsuite/ltpstress

**Test Case Execution**

Run the ltpstress tool suite with the following script: `sh run_ltpstress.sh`
  > The long-duration execution parameters can be modified, for example: sh ltpstress.sh -n -m 512 -t 168

**Result Analysis**

Execute the following script to view the running result: `sh result_check.sh`
  > It is necessary to check whether the service is interrupted and whether core, crash, or large file generation occurs.

### 6.4. syzkaller

**Test Preparation**

- Prepare the image
  Obtain the image package from the official source (official source: http://repo.openeuler.org)

- Prepare the syzkaller test suite
  Script download address: https://gitcode.com/openeuler/test-tools/tree/master/kernel-testsuite/syzkaller

**Environment Setup**

1. Install the dependency services
  Execute `sh syzdelop.sh deploy` to install qemu and syzkaller
2. Compile the kernel
  Execute `sh syzdelop.sh build ubsan` to compile
3. Create the virtual vm
  Execute `sh syzdelop.sh createvm`
> 1). Prepare an iso image of the corresponding version and architecture for installation;
> 2). After starting the script, from the menu bar tigervnc view mount the image via ip:31 for installation (installation and deployment);
> 3). After the installation is complete, keep the window of the installed virtual machine.
4. Configure the config file
  Execute `sh syzdelop.sh config`
> 1). Check the kernel installation on the virtual machine, for example: `rpm -q kernel` to see that the new kernel has been installed;
> 2). After the installation is complete, reboot the virtual machine to make the virtual machine configuration and the newly installed kernel take effect;
> 3). shutdown -h now to shut down the virtual machine.

**Run Test Cases**

- Run the syzkaller service
  Execute `sh syzdelop.sh fuzz` to start the service
> 1. If the IP of the target machine is wrong, manually modify the corresponding machine IP in /home/fuzz.cfg;
> 2. Execute sh syzdelop.sh fuzz to start the syzkaller service and run for 3 days;

**Result Analysis**

- View the running result
  Enter ip:1234 in the URL to view the log information on the web page; there should be no errors such as crash, and the service should not be interrupted
- Failure analysis
  If the log has errors, query and locate the cause in the community issue tracker based on historical issues

### 6.5. mmtests

**Test Preparation**

- mmtests test script and documentation download address: https://gitcode.com/openeuler/test-tools/tree/master/kernel-testsuite/mmtests

**Test Case Execution**

Execute the following script: `sh start_mmtests_test.sh`
> 1. The script contains two parts: installing tools such as mmtests and executing test cases;
> 2. The test case list is defined in cnf-v0.25.txt by default, and can be customized based on the configs directory.

**Result Analysis**

Execute the following script to filter out the passed test cases: `grep -iEl "test exit :: .* 0|143" log/*`
> 1. Use the above command to filter out the passed test cases, then specifically analyze the failed test cases;
> 2. Back up and archive the names of the successfully executed test cases. It is not recommended to back up large log files;
> 3. Failed test cases can exhibit situations such as download failure, compilation failure, and execution failure.


## 7. Interface Testing

### 7.1. api sanity checker: an automatic generator of basic unit tests for a C/C++ library API

**Basic Concepts:**

API Sanity Checker is an automatic generator of basic unit tests for a C/C++ library. This tool quickly generates simple tests ("sanity" or "shallow" quality) for an API based on signatures, data type definitions, and the relationships between functions directly from the library header files ("header-driven generation"). Each test case contains a function call with reasonable input parameters (in most cases, but not all). The tool can introduce highly reusable specialized types for a library to greatly improve the test quality. Users can check whether there are serious errors in simple practical use scenarios based on the quality of the generated tests.

The tool can execute the generated tests and detect crashes, aborts, various emitted signals, non-zero program exit codes, program hangs, and requirement failures (if specified). The tool can be considered an out-of-the-box low-cost sanity check for a library API or an initial template generator for advanced tests as a test development framework. It also supports the universal Template2Code format tests, splint specifications, random test generation mode, and other useful features.

**Usage Example:**

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

**Test Result:**

When the return value after running is 0, the test passes.

**Parameter Description:**

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

## 8. Long-Run Stability Testing

### 8.1. long stress

**Test Preparation**

- Prepare the long_stress test suite
  ltp script and test suite download: https://gitcode.com/openeuler/test-tools/tree/master/kernel-testsuite/ltpstress

**Test Case Execution**

- Run the ltpstress tool suite
  Execute sh run_ltpstress.sh, for example sh run_ltpstress.sh -m 512 -t 48

**Result Analysis**

- View the running result
  It is necessary to check whether the service is interrupted, whether crash files are generated, whether large files are generated, etc. See dfx.txt for the specific check items.


## 9. GUI Testing

### 9.1. openQA

For the openQA testing guide, please read the [openQA](./openQA/openQA.md) document.

## 10. Compiler Testing

### 10.1. dejagnu

**Installation**

1. Download the dejagnu tool

https://mirrors.ustc.edu.cn/gnu/dejagnu/dejagnu-1.6.1.tar.gz

(Download to /home)

2. Build dejagnu (this step is to generate the runtest binary)

(1) Install expect (otherwise it will report an error)
```
dnf install -y expect
```
(2) Extract and build
```
tar -zxf dejagnu-1.6.1.tar.gz

mkdir /home/install_runtest

cd dejagnu-1.6.1/

./configure --prefix=/home/install_runtest

make -j

make install
```
3. Set the environment variable (here setting runtest's)

export PATH=/home/install_runtest/bin:$PATH



**Testing**

1. Set the compiler environment variable

export PATH=/home/install/bin:$PATH

2. Execute the command in the main gcc source directory to test
```
make -j -k check
```
Source code acquisition method 1:
```
git clone https://gitcode.com/openeuler/gcc.git
```
The source code obtained this way contains testsuite, so the test suite can be directly copied for testing.

Source code acquisition method 2:
```
git clone -b branch_name https://gitcode.com/src-openeuler/gcc.git
```
The obtained source code needs to be run through rpmbuild before the real source code can be generated under /root/rpmbuild/BUILD.
```
cd gcc
rpmbuild -bp gcc.spec
```
If there is no rpmbuild command, install it with: yum install -y rpm-build

If there is an error, execute in the current directory (the main source directory): cp ./* /root/rpmbuild/SOURCES/

```
With this method the testsuite is under /root/rpmbuild/BUILD. Copy a test suite to run the full test case set.

cp /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite  /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite-gcc -r

runtest --tool gcc

cp /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite  /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite-g++ -r

runtest --tool g++

cp /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite  /root/rpmbuild/BUILD/gcc-10.3.0/gcc/testsuite-gfortran

runtest --tool gfortran
```

3. The test results are saved in the following log files
```
./host-aarch64-linux-gnu/gcc/testsuite/gcc/gcc.log

./host-aarch64-linux-gnu/gcc/testsuite/g++/g++.log

./host-aarch64-linux-gnu/gcc/testsuite/obj-c++/obj-c++.log

./host-aarch64-linux-gnu/gcc/testsuite/objc/objc.log

./host-aarch64-linux-gnu/gcc/testsuite/gfortran/gfortran.log
```


**Executing a Single Test Case or a Single exp**

For example split-path-10.c, there is an exp file in the same directory: tree-ssa.exp. If not, look in the upper directory.

Execute in the testsuite directory:
```
runtest --tool gcc tree-ssa.exp=split-path-10.c

runtest --tool gcc tree-ssa.exp
```
Run gcc in full:
```
runtest --tool gcc
```
### 10.2. llvmcase

**Basic Concepts:**

The LLVM project is a collection of modular and reusable compiler and toolchain technologies.

**Test Deployment Environment Preparation:**

Install GCC: yum install -y gcc gcc-*

**Test Installation and Deployment:**

- Download the source code
  ```
  git clone https://github.com/llvm/llvm-project.git
  ```
- Compile

  (1). Compile .c files

  ```
  gcc ***.c ${option} -o ***.out
  ```

  (2). Compile .cpp files

  ```
  g++ ***.cpp ${option} -o ***.out
  ```

  (3). Compile .f .F90 .f90 files

  ```
  gfortran ***.f ${option} -o ***.out
  ```

- Run
  ```
  ./***.out
  ```
### 10.3. Anghabench

**Basic Concepts:**

A benchmark suite containing 1 million compilable programs, mined from the largest public C repositories on GitHub.

**Test Deployment Environment Preparation:**

Install GCC:   
`yum install -y gcc gcc-*`
**Test Installation and Deployment:**

- Download the source code
  ```
  git clone https://github.com/brenocfg/AnghaBench.git
  ```
- Compile
  ```
  gcc ***.c ${option} -o ***.out

  An .out file is generated if compilation succeeds.
  ```
- Run
  ```
  ./***.out
  ```
### 10.4. jotai

**Basic Concepts:**

A large collection of executable benchmarks mined from open-source repositories. Each benchmark consists of a function written in C, plus a driver that runs the function.

**Test Deployment Environment Preparation:**

Install GCC: 
```
yum install -y gcc gcc-*
```
**Test Installation and Deployment:**

- Download the source code
  ```
  git clone https://github.com/lac-dcc/jotai-benchmarks.git
  ```
- Compile
  ```
  gcc ***.c ${option} -o ***.out
  ```
  An .out file is generated if compilation succeeds.

- Run
  ```
  ./***.out
  ```
### 10.5. csmith

**Basic Concepts:**

Csmith is a random generator of C programs. Its main purpose is to find compiler errors using random programs while using differential testing as the test oracle.

**Test Deployment Environment Preparation:**

- Install GCC: 
```
yum install -y gcc gcc-*
```
- Install the dependencies: yum install -y cmake m4

- Download the source code
  ```
  git clone https://github.com/csmith-project/csmith.git
  ```
- Compile csmith
  ```
  cd csmith

  cmake -DCMAKE_INSTALL_PREFIX=<INSTALL-PREFIX> .

  make && make install
  ```
- Use csmith to generate .c files
  ```
  export PATH=$PATH:$HOME/csmith/bin

  csmith > random1.c
  ```
- Compile and run
  ```
  gcc random1.c -I$HOME/csmith/include -o random1

  ./random1
  ```
**Other**

View other csmith options: ./csmith -h

Specific usage: verify the compiler by generating millions of test cases in an automated batch.

### 10.6. yarpgen

**Basic Concepts:**

yarpgen is a random program generator that can generate correct and runnable C/C++ and DPC++ (this work is in an early stage) programs. The generator is specifically designed to trigger compiler optimization errors and is used for compiler testing.

**Test Deployment Environment Preparation:**

- Install GCC: 
```
yum install -y gcc gcc-*
```
- Install the dependencies: 
```
yum install -y cmake
```
- Download the source code
  ```
  git clone https://github.com/intel/yarpgen.git
  ```
- Compile yarpgen
  ```
  cd yarpgen
  mkdir build
  cd build
  cmake ..
  make
  ```
- Use yarpgen to generate .cpp files
  ```
  ./yarpgen

  cat init.h func.cpp driver.cpp > random1.cpp

  sed -i 's|#include "init.h"||g' random1.cpp
  ```
- Compile and run
  ```
  g++ random1.cpp -I$HOME/csmith/include -o random1

  ./random1
  ```
**Other**

View other yarpgen options: ./yarpgen -h

Specific usage: verify the compiler by generating millions of test cases in an automated batch.

### 10.7. jdk

**Basic Concepts:**
Open-source test suite for testing OpenJDK 8: https://github.com/openjdk/jdk8u-dev.git<br/>
Open-source test suite for testing OpenJDK 11: https://github.com/openjdk/jdk11u-dev.git<br/>
Open-source test suite for testing OpenJDK 17: https://github.com/openjdk/jdk17u-dev.git<br/>
jtreg is the testing framework open-sourced by the openJDK community. It provides common configuration and methods so that community developers can write and execute test code.<br/>
jtreg download address: https://builds.shipilev.net/jtreg/<br/>
For jdk8: jtreg4.2-b16.zip<br/>
For jdk11: jtreg-6+1.zip<br/>
For jdk17: jtreg-6+1.zip<br/>

**Test Deployment Environment Preparation:**
**1. Download the test suite**<br/>
Select the test cases according to the java-openjdk version.<br/>
Example versions:<br/>
When the version is java-1.8.0-openjdk-1.8.0.382.b05-4.oe2309, download the following version of the test cases.<br/>
```
git config --global http.sslVerify false
git clone -b jdk8u382-ga https://github.com/openjdk/jdk8u-dev.git
```
When the version is java-11-openjdk-11.0.20.8-1.oe2309, download the following version of the test cases.<br/>
```
git config --global http.sslVerify false
git clone -b jdk-11.0.20-ga  https://github.com/openjdk/jdk11u-dev.git
```
When the version is java-17-openjdk-17.0.8.7-1.oe2309, download the following version of the test cases.<br/>
```
git config --global http.sslVerify false
git clone -b jdk-17.0.8-ga https://github.com/openjdk/jdk17u-dev.git
```
After cloning the JDK11 source code, the test cases are under the test directory.<br/>
If git clone reports "fatal: unable to access...", execute git config --global http.sslVerify false before git clone.<br/>

**2. Install the dependencies**<br/>
```
dnf install -y git subversion screen samba samba-client gcc gdb cmake automake lrzsz expect libX11* libxt* libXtst* libXt* libXrender* cache* cups* unzip* zip* freetype* mercurial numactl vim tar dejavu-fonts unix2dos dos2unix bc lsof net-tools
```
**3. Install openjdk and openjdk-devel**<br/>
```
jdk-8 :dnf install -y java-1.8.0-openjdk*
jdk-11:dnf install -y java-11-openjdk*
jdk-17:dnf install -y java-17-openjdk*
```
**4. Set the environment variables**<br/>
```
export JAVA_HOME=path/to/JDK
export PATH=$JAVA_HOME/bin:$PATH
export JT_HOME=path/to/jtreg_home
export PATH=$JT_HOME/bin:$PATH
export LC_ALL=en_US.UTF-8 
touch exclude.txt
```
Example:
```
unzip jtreg*
export JAVA_HOME=$(ls -lr $(ls -lr /usr/bin/java | awk '{print $NF}') |awk '{print $NF}' | awk -F/ '{print $1"/"$2"/"$3"/"$4"/"$5}')
export PATH=$JAVA_HOME/bin:$PATH
export JT_HOME=$(pwd)/jtreg
export PATH=$JT_HOME/bin:$PATH
export LC_ALL=en_US.UTF-8 
export LANG=en_US.UTF-8
touch exclude.txt
```
**5. Execute the test cases**<br/>
Execute a single test case: jtreg -va XXX/YYY.java<br/>
eg: jtreg -va hotspot/test/gc/g1/TestLargePageUseForAuxMemory.java<br/>
**6. Execute the entire test suite**<br/>
```
jdk8u:   
jtreg -va -ignore:quiet -jit -conc:auto -timeout:5 -tl:3590 -exclude:exclude.txt -vmoptions:"$jvmOptions" jdk8u-dev/hotspot/test:hotspot_tier1 jdk8u-dev/langtools/test:langtools_tier1 jdk8u-dev/jdk/test:jdk_tier1 >log 2>&1 &

jdk11u:   
jtreg -va -ignore:quiet -jit -conc:auto -timeout:5 -tl:3590 -exclude:exclude.txt -vmoptions:"$jvmOptions" jdk11u-dev/test/langtools:tier1 jdk11u-dev/test/hotspot/jtreg:tier1 jdk11u-dev/test/jdk:tier1 jdk11u-dev/test/jaxp:tier1 >log 2>&1 &

jdk17u:   
jtreg -va -ignore:quiet -jit -conc:auto -timeout:5 -tl:3590 -exclude:exclude.txt -vmoptions:"$jvmOptions"  jdk17u-dev/test/hotspot/jtreg:tier1 jdk17u-dev/test/langtools:tier1 jdk17u-dev/test/jdk:tier1 jdk17u-dev/test/jaxp:tier1 jdk17u-dev/test/lib-test:tier1 >log 2>&1 &
```
**7. View the execution result**<br/>
The result statistics of the test suite are in JTreport/html/report.html.<br/>
The test case logs are stored in JTwork. The execution log of test case XXX/YYY/ZZZ.java is stored in the JTwork/XXX/YYY/ZZZ.jtr file.<br/>
In the jtr file, there are three test result states: Passed, Failed, and Error, corresponding to the test case executing successfully, failing, and reporting an error respectively.<br/>


## 11. Self-Build Testing

**Tool Introduction**

The community uses [compile-mock](https://gitcode.com/openeuler/test-tools/tree/master/compile_mock) as the self-build testing tool. It verifies the source packages in the source image using a sampling approach. Generally 500 software packages are randomly selected, among which kernel, gcc, and glibc are mandatory packages.

**Environment Deployment**
1.  After the machine is installed successfully, configure the repo source by locally mounting the everything and source images.
2.  Copy the self-build tool compile-mock to the execution machine.
3.  Configure the tool parameters
    * Enter the compile_mock/common directory and obtain source_list.bak containing all the software packages of the source image.

    ```
    cd compile_mock/common
    dnf list --available --repo=source | awk '{print $1}'| awk -F. 'OFS="."{$NF="";print}'| awk '{print substr($0, 1, length($0)-1)}' >source_list.bak
    ```
    * Randomly select 500 packages for testing
    ```
    shuf -n500 source_list.bak >source_list
    ```
    * Add the 3 mandatory packages kernel, gcc, and glibc, paying attention to deduplication
    ```
    sed -i "1i kernel\ngcc\nglibc" source_list
    ```
    * Modify the tool's architecture-specific configuration file openEuler-aarch64.cfg or openEuler-x86_64.cfg, and configure the test source into # repo

**Test Steps**
1.  Enter the ../total_pkg directory and schedule the compile script total_pkg.sh
    ```
    cd ../total_pkg
    Self-build all the packages in source_list together: bash total_pkg.sh all (all means all the packages)
    Self-build the single package abc in source_list: bash total_pkg.sh abc  (abc is the package name)
    ```

**Remarks**
If there are packages that the tool cannot compile, they can be compiled individually with the rpmbuild command.
1.  Download the source package
  ```yumdownloader --source XXX```
2.  Install the source package
  ```rpm -ivh XXX.src.rpm```
3.  Enter the SPEC directory of the compile user test_user and start compiling. If compile dependencies are missing, install them directly.
  ```
  cd /home/test_user/rpmbuild/SPECS/
  rpmbuild -ba XXX.spec
  ```
4.  Check whether there are errors during the compilation


## 12. Northbound Compatibility Testing

From the perspective of the full stack, the operating system is at the middle layer and software is at the upper layer, so northbound compatibility is the software compatibility of the operating system.

To perform software compatibility testing, refer to the following documents, from https://gitcode.com/openeuler/oec-application/blob/master/doc/

[Detailed Guide for Northbound Open-Source Software Package Adaptation and Migration](https://gitcode.com/openeuler/oec-application/blob/master/doc/北向开源软件包适配迁移详细指导.md)

[openEuler Community Open-Source Software Adaptation Process](https://gitcode.com/openeuler/oec-application/blob/master/doc/openEuler社区开源软件适配流程.md)

[rpm Building and Repository Creation Process on ISCAS (Institute of Software, CAS) oepkgs](https://gitcode.com/openeuler/oec-application/blob/master/doc/rpm构建以及建仓流程.md)

[openEuler Software Package Compatibility Grading](https://gitcode.com/openeuler/oec-application/blob/master/doc/compatibility_level.md)

### 12.1 oecp

**Tool Introduction**
This tool aims to
* Detect the differences between the software packages, the files within the packages, the library file interfaces (C/C++), and the kernel KABI of two ISOs (based on RPM).
* Detect the changes and differences of the same software (rpm package) across different versions.

**Execution Method Introduction**
```bash
### Install the preset environment. libabigail requires the everything repository of openEuler-20.03-LTS-SP2 and above.
yum install libabigail createrepo binutils

python3 cli.py [-h] [-n PARALLEL] [-w WORK_DIR] [-p PLAN_PATH] [-c CATEGORY_PATH] [--platform PLATFORM_TEST_PATH] [-f OUTPUT_FORMAT] [-o OUTPUT_FILE] [-d DEBUGINFO] file1 file2
```

**Parameter Explanation**
* **Positional parameters (required)**
  * **`file`**
    Specify the two iso files to compare / the directory (directory) storing rpm packages / rpm packages. Note that file1 is used as the baseline.

* **Optional parameters**

  * **`-n, --parallel`**
    Specify the process-pool concurrency (number of parallel workers), defaults to the number of CPU cores.

  * **`-w, --work-dir`**
    Specify the `working path`, defaults to /tmp/oecp.

  * **`-p, --plan`**
    Specify the `comparison plan`, defaults to oecp/conf/plan/all.json.

  * **`-c, --category`**
    Specify the `package-level information`, defaults to oecp/conf/category/category.json.

  * **`-d, --debuginfo`**
    Specify the `debuginfo iso/rpm path`.

  * **`-f, --format`**
    Specify the `output format`, defaults to csv.

  * **`-o, --output`**
    Specify the `output result path`, defaults to /tmp/oecp.

  * **`--platform`**
    Specify the `address of the json report for platform verification`, defaults to /tmp/oecp; the default baseline file for performance testing is oecp/conf/performance/openEuler-20.03-LTS-aarch64-dvd.iso.performance.json.

* **Example**

  * **` python3 cli.py  /root/openEuler-20.03-LTS-aarch64-dvd.iso /root/openEuler-20.03-LTS-SP1-aarch64-dvd.iso`**

* **Comparison Plan Description**
  * **`all.json`**
    Covers the comparison of all the configuration items below.
  * **`config_file.json`**
    Compares the differences in the configuration file contents in the rpm package, and depends on RPMExtractDumper (the dumper class that extracts and decompresses rpm).
  * **`file_list.json`**
    Compares the file list differences of the rpm package. The rpm file list can be obtained via rpm -pql ${rpm_path}.
  * **`kconfig.json`**
    Compares the kernel configuration files, and depends on RPMExtractDumper (the dumper class that extracts and decompresses rpm).
  * **`package_list.json`**
    Compares the differences in the name, version, and release of the two rpm packages.
  * **`provides_requires.json`**
    Compares the provides and requires differences of the rpm, which can be queried via rpm -pq --provides/requires ${rpm_path}.

## 13. Southbound Compatibility Testing

From the perspective of the full stack, the operating system is at the middle layer and hardware is at the lower layer, so southbound compatibility is the hardware compatibility of the operating system.

### 13.1. oech-ci

**Tool Introduction**

This tool integrates the southbound compatibility testing tool oec-hardware into compass-ci. By specifying the adapter card configuration file, it automatically obtains the machine equipped with the card under test in the compass-ci test machine environment, automatically generates the job yaml file to be submitted, and automatically submits the task, thus implementing automated hardware testing with oec-hardware.

1. For non-NIC testing, a machine that meets the conditions is randomly obtained for testing, or a machine can be specified in the configuration file for testing.

2. For NIC/IB testing, the names of the server-side and client-side test machines need to be specified in the configuration file for testing.

- Note:

  Currently, mixed clusters of virtual machines and physical machines are not supported, because physical machines and virtual machines are not on the same network segment and cannot form a cluster.

- Optimization direction:

  Regarding the acquisition of cluster information, it currently reads the lab library, which can be optimized to read from data-api.

  Read interface: cci hosts

**Test Execution Method Introduction**

    * Debug command, does not actually submit, only checks whether the submission process is correct:
    
            python3 oech_ci.py -o /home/user/tmp \
                                    -j $LKP_SRC/jobs/oech.yaml \
                                    -l /home/user/lab-z9 \
                                    -c ./test_conf.json
    
    * Submit command:
    
            python3 oech_ci.py -j $LKP_SRC/jobs/oech.yaml \
                                    -l /home/user/lab-z9 \
                                    -c ./test_conf.json

**Parameter Explanation**

```
-o 

    Debug path. Does not actually submit, outputs the processed yaml. This parameter can be used for debugging during testing.

-j

    The path of the oech job yaml file.

-l

    The library of the test machine environment.

-c 

    The adapter card configuration file. You can refer to the files under the config directory.
```

**Viewing Results**

Apart from the prints during the submission process, a directory named after the submission time is generated in the current directory, for example:

```
2022-05-05-17-32-23
    - ethernet-SP580-14e4-16d7-1402-14e4-cs-s1-a112-c1-a113.yaml
    - submit_result
```

This submit_result file contains the submission information and the job_id, based on which the execution process and result of the job can be queried.

Note that this file also exists during test submission, but without a job_id.

The other yaml file is the complete submitted job yaml (this file exists both for testing and for real submission).


## 14. Scenario-Based Performance Testing

Networking and environment preparation:
1. The client node and the server node are connected directly through the on-board optical port.
2. The test NIC rate is 25GE.

### 14.1. MySQL-TPCC Testing
**Basic Concepts**

MySQL-TPCC testing is a performance testing method based on the TPC-C (Transaction Processing Performance Council - C) benchmark, used to evaluate the performance of a database system in online transaction processing (OLTP) scenarios.

**Prerequisites**
1. Install the dependencies
```shell
#Server node
yum install -y expect cmake doxygen bison ncurses-devel m4 openssl-devel \
numactl libtool tar rpcgen bison bc unzip git gcc-c++ libaio make libaio-devel \
libtirpc-devel libudev-devel java
#Client node
yum install -y java
```
2. Use an NVMe disk as the data disk.

**Download the Source Code**
1. Server node: MySQL 8.0.35
  https://cdn.mysql.com/archives/mysql-8.0/mysql-boost-8.0.35.tar.gz

2. Client node (load generator): benchmarksql5.0-for-mysql
  https://mirrors.huaweicloud.com/kunpeng/archive/kunpeng_solution/database/patch/benchmarksql5.0-for-mysql.zip


**Compilation and Installation**
1. Server node
```shell
  tar -xvf mysql-boost-8.0.35.tar.gz
  cd mysql-8.0.35
  cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-8.0.35 -DWITH_BOOST=../boost -DDOWNLOAD_BOOST=1
  make -j`nproc`
```
2. Client node
server_ip needs to be replaced with the server IP.
```shell
  unzip benchmarksql5.0-for-mysql.zip
  cd benchmarksql5.0-for-mysql/run
  chmod 777 *.sh
  sed -i "s|jdbc:mysql://[^:]*[0-9]*|jdbc:mysql://$server_ip:3306|" "props.conf"
```
**Configure the Installation Environment**
1. Create the user group and the data directory
disk_name needs to be replaced with the corresponding NVMe disk device name.
```shell
mkfs.xfs $disk_name -f
mkdir /data
mount $disk_name /data
```

2. Create the user, group, and data directories
```shell
  groupadd mysql
  useradd -g mysql mysql

  mkdir -p /data/mysql
  mkdir -p /data/mysql/{data,share,tmp,run,log}
  chown -R mysql:mysql /data
  chown -R mysql:mysql /data/mysql
  touch /data/mysql/log/mysql.log
  chown -R mysql:mysql /data/mysql/log/mysql.log
```

**Start the MySQL Service**
Execute on the server node.
1. Configure my.cnf
```shell
  cat > /etc/my.cnf << EOF
[mysqld_safe]
log-error=/data/mysql/log/mysql.log
pid-file=/data/mysql/run/mysqld.pid

[client]
socket=/data/mysql/run/mysql.sock
default-character-set=utf8

[mysqld]
server-id=1
socket=/data/mysql/run/mysql.sock
tmpdir=/data/mysql/tmp
datadir=/data/mysql/data
default_authentication_plugin=mysql_native_password
port=3306
user=root
EOF
```
2. Initialize MySQL
```shell
  # A random password is generated after initialization. Record the password and use it to log in to MySQL later.
  /usr/local/mysql-8.0.35/bin/mysqld --defaults-file=/etc/my.cnf --initialize
```

3. Start the service
```shell
  /usr/local/mysql-8.0.35/support-files/mysql.server start
```

4. Log in and create the tpcc database
```shell
  # Log in to the database using the random password generated after initialization.
  /usr/local/mysql-8.0.35/bin/mysql -u root -p
  # Change the password and update the root account's accessible domain to % to support remote access.
  alter user 'root'@'localhost' identified by '123456';
  flush privileges;
  use mysql;
  update user set host='%' where user='root';
  flush privileges;
  create database tpcc;
  quit;
```

**Execute the Test**
Execute on the client node.
```shell
#1. Load the test data
cd benchmarksql5.0-for-mysql/run
./runDatabaseBuild.sh props.conf
#2. Execute the MySQL test
./runBenchmark.sh props.conf > result.log
cat result.log|grep
#3. Re-test: delete the data and then reload it
./runDatabaseDestroy.sh props.conf
```

**Viewing Results**

The test result is output to the terminal. The final performance score is the value of Measured tpmC(NewOrders), where tpm (transactions per minute) represents the number of transactions processed per minute.
Run the test three times and average the total scores. Higher is better.

### 14.2. Nginx Testing
**Basic Concepts**

Nginx performance testing refers to the process of evaluating the response capability, stability, resource consumption, and other key metrics of the Nginx server (or a Web service built on Nginx) under scenarios such as high concurrency and high throughput by simulating real or expected user request loads. Its core goal is to verify whether Nginx can meet business performance requirements under specific hardware and configuration conditions, and to discover potential performance bottlenecks.

**Parameter Explanation**
 Parameter | Description |
|------|------|
| `-c <concurrent>` | Number of concurrent connections (for example: 100) |
| `-d <duration>` | Stress testing duration, supporting units such as `s` (seconds) and `m` (minutes) (for example: `30s`) |
| `-t <threads>` | Number of threads used (recommended to be set to the number of CPU cores) |
| `-H "Connection: <alive>"` | Custom HTTP `Connection` request header. `<alive>` is usually `keep-alive` or `close` |
| `--timeout <timeout>` | Request timeout (unit: seconds, for example: `2`) |
| `<protocol>://<server_ip>:<PORT>/<path>` | Target URL, including protocol (`http`/`https`), server IP, port, and request path (for example: `http://192.168.1.10:80/index.html`) |

**Prerequisites**
1. Enable SMMU/IOMMU
  **·** On the Kunpeng platform, the SMMU switch needs to be configured in the BIOS: enter Advanced->MISC Config and enable the Support Smmu and SMMU Workaround configuration items.
  **·** On the Intel platform, add the following parameter to the OS kernel startup items, which takes effect after a reboot.
  ```shell
    grubby --update-kernel=/boot/vmlinuz-`uname -r` --args="intel_iommu=on iommu=pt"
  ```
2. Verify whether SMMU/IOMMU is enabled
  ```shell
    ls /sys/class/iommu
  ```
3. Install the dependencies
  ```shell
    #Server node
    yum install -y tar gcc gcc-c++ make libtool zlib zlib-devel pcre pcre-devel perl \
    openssl openssl-devel perl-ExtUtils-Embed net-tools git
    #Client node
    yum install -y make gcc git tar
  ```

**Download the Source Code**
  1. Server node: nginx 1.22.1
    https://repo.huaweicloud.com/nginx/nginx-1.22.1.tar.gz
  2. Client node: wrk 4.2.0
    https://github.com/wg/wrk/archive/refs/tags/wrk-4.2.0.zip

**Compilation and Installation**
  1. Server node
  ```shell
    tar -xvf nginx-1.22.1.tar.gz
    cd nginx-1.22.1
    ./configure --prefix=/usr/local/nginx --with-http_ssl_module
    make -j && make install
    cp /usr/local/nginx/sbin/nginx /usr/local/bin/
  ```
  2. Client node
  ```shell
    unzip wrk-4.2.0.zip
    cd wrk-4.2.0
    make -j
    cp wrk /usr/local/bin
  ```
**Modify the Configuration File**
  1. Generate the certificate
  ```shell
    cd /usr/local/nginx/
    openssl genrsa -des3 -out server_2048.key 2048
    # Prompt to enter a password and confirm the password; enter 123456 twice. This generates server_2048.key.
    openssl rsa -in server_2048.key -out server_2048.key
    # Enter the password set in the previous step.

    # Create the application file for the server certificate.
    openssl req -new -key server_2048.key -out server_2048.csr
    # Enter CN for CountryName, and press Enter for the rest.

    # Rewrite the key
    openssl rsa -in server_2048.key -out server_2048.key
    
    # Generate the certificate
    spawn openssl x509 -req -days 365 -in server_2048.csr -signkey  server_2048.key -out server_2048.crt
  ```
  2. Modify the core configuration file
  nginx_path should be replaced with the source code path of nginx-1.22.1.
  ```shell
    vi $nginx_path/conf/nginx.conf

    # Set the number of worker processes to 4 and enable automatic CPU affinity binding.
    worker_processes 4;
    worker_cpu_affinity auto;
    worker_rlimit_nofile 1024000;
    events {
        use epoll;
        worker_connections 32768;
        accept_mutex off;
        multi_accept off;
    }

    # Configure http
    http{
      include /usr/local/nginx/conf/mime.types;
      default_type application/octet-stream;
      access_log off;
      sendfile on;
      tcp_nopush on;
      keepalive_timeout 65;

      open_file_cache max=102400 inactive=40s;
      open_file_cache_valid 50s;
      open_file_cache_min_uses 1;
      open_file_cache_errors on;
      server {
        listen 10000;
        location / {
            root /usr/local/nginx/html;
            index index.html index.htm;
        }
        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root htmls;
        }
      }
    # Configure the HTTP server
    server {
      listen 20000 ssl;
      server_name localhost;
      ssl_certificate  /usr/local/nginx/server_2048.crt;
      ssl_certificate_key /usr/local/nginx/server_2048.key;
      ssl_session_cache shared:SSL:1m;
      ssl_session_timeout 5m;
      ssl_ciphers HIGH:!aNULL:!MD5;
      ssl_prefer_server_ciphers on;
      location / {
          root /usr/local/nginx/html;
          index index.html index.htm;
      }
    }
  }
```

**Execute the Test**
1. Start the service on the server node.
  nginx_path should be replaced with the source code path of nginx-1.22.1.
  ```shell
    nginx -c $nginx_path/conf/nginx.conf  
  ```
2. Start the load test on the client node.
server_ip should be replaced with the actual IP of the server node.
 ```shell
  concurrent=2000
  duration=60s
  threads=20
  timeout=5s
  for protocol in "http" "https"; do
    for alive in "close" "keep-alive"; do
      if [ "$protocol" = "http" ]; then
        PORT=10000
      elif [ "$protocol" = "https" ]; then
        PORT=20000
      fi
      echo 3 > /proc/sys/vm/drop_caches
      sleep 5s
      echo "./wrk -c ${concurrent} -d ${duration} -t ${threads} -H "Connection: ${alive}" \
        --timeout ${timeout} ${protocol}://${server_ip}:${PORT}/index.html"
      /usr/local/bin/wrk -c ${concurrent} -d ${duration} -t ${threads} -H "Connection: ${alive}" \
        --timeout ${timeout} ${protocol}://${server_ip}:${PORT}/index.html >> ${protocol}_${alive}.log
    done
  done

  ```
**Viewing Results**
Use the following shell command to view the Requests/sec results.
 ```shell
  echo http_short
  cat http_close.log|grep Requests/sec | awk -F ' ' {'print'}
  echo http_long
  cat http_keep-alive.log|grep Requests/sec | awk -F ' ' {'print'}
  echo https_short
  cat https_close.log|grep Requests/sec | awk -F ' ' {'print'}
  echo https_long
  cat https_keep-alive.log|grep Requests/sec | awk -F ' ' {'print'}
```
Take the geometric mean of http_short, http_long, https_short, and https_long as the final score.
Run the test three times and average the total scores. Higher is better.

### 14.3. Redis Testing
**Basic Concepts**

The basic performance testing of Redis is mainly carried out through the officially provided tool redis-benchmark. It refers to executing typical SET and GET operations on Redis under standard conditions, measuring how many requests it can process per second (QPS) and the response latency, so as to evaluate the basic performance of the Redis instance.

**Parameter Explanation**
| Parameter | Description |
|------|------|
| `-h <host>` | Redis server address (default: `127.0.0.1`) |
| `-p <port>` | Redis service port (default: `6379`) |
| `-c <clients>` | Number of concurrent client connections (default: `50`) |
| `-n <requests>` | Total number of requests (default: `100000`) |
| `-q` | Quiet mode, only shows the QPS (requests per second) of each command |
| `-t <commands>` | Specify the commands to test. Multiple commands are separated by commas, for example: `set,get` |
| `-d <size>` | The data size of value in SET/GET operations (unit: bytes, default: `3`) |
| `--csv` | Output the test results in CSV format for subsequent analysis |

**Prerequisites**
1. Hardware environment
Two physical machines are directly connected via a high-traffic (10GE or above) optical port.
2. Disable the services on the server node.
```shell
  systemctl stop firewalld
  systemctl disable firewalld
  systemctl stop irqbalance
  systemctl disable irqbalance
```
3. Install the dependencies
  ```shell
    #Server node
    yum install -y tar gcc gcc-c++ make libatomic groff
    #Client node
    yum install -y tar gcc gcc-c++ make libatomic
  ```

**Download the Source Code**
  1. Server node: redis 5.0.14
    http://download.redis.io/releases/redis-5.0.14.tar.gz
  2. Client node: redis 6.2.9
    http://download.redis.io/releases/redis-6.2.9.tar.gz

**Compilation and Installation**
1. Server node
  ```shell
    tar -xvf redis-5.0.14.tar.gz
    cd redis-5.0.14
    make -j
  ```
2. Client node
  ```shell
    tar -xvf redis-6.2.9.tar.gz
    cd redis-6.2.9
    make -j
  ```

**Modify the Configuration**
Execute on the server node. server_ip should be replaced with the actual IP of the server node.
  ```shell
  cd redis-5.0.14
  sed -i "/^bind 127.0.0.1/a bind $server_ip" redis.conf
  sed -i "s/^protected-mode yes/protected-mode no/g" redis.conf
  sed -i "s/^daemonize no/daemonize yes/g" redis.conf
  echo 'save ""' >> redis.conf
  ```

**Start the Service**
Execute on the server node. interface should be replaced with the actual NIC name.
  ```shell
# Configure combined interrupt queues
ethtool -L $interface combined 1
taskset -c 1 redis-5.0.14/src/redis-server redis.conf
  ```
**Execute the Test**
Execute on the client node.
  ```shell
   redis-6.2.9/src/redis-benchmark -h ${server_ip} -n 10000000 -c 1000 -r 10000000 -t set,get --threads 20
  ```

**Viewing Results**

The result is output to the terminal. Record the requests per second values of SET and GET respectively, and take the geometric mean of the two as the total score of the result.
Run the test three times and average the total scores. When repeating, the Redis service on the server node must be restarted.
Higher is better.

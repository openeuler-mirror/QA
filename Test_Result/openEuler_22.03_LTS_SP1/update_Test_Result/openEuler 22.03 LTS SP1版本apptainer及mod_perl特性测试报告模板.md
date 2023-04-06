![avatar](../images/openEuler.png)


版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2022.04.04 | 1.0.0            |  测试报告   | @yikunkero |
|      |             |          |      |
|      |             |          |      |

 关键词： 

 

摘要：

 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述
新增Apptainer及mod_perl等OpenHPC依赖的软件包（涉及5个）。
- Apptainer及其依赖fuse-overlayfs、squashfuse: apptainer
    - fuse-overlayfs: FUSE implementation for overlayfs: https://github.com/containers/fuse-overlayfs
    - squashfuse: FUSE filesystem to mount squashfs archives https://github.com/vasi/squashfuse
- mod_perl及其依赖perl-Linux-Pid
    - mod_perl: apache perl module
    - perl-Linux-Pid: Get the native PID and the PPID on Linux

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称              | 测试起始时间 | 测试结束时间 |
| -------------------- | ------------ | ------------ |
| openEuler-22.03-sp1 | 2023/04/04    | 2023/04/04    |

描述特性测试的硬件环境信息

|硬件型号|硬件配置信息|备注|
|:----|:----|:----|
|华为云ECS|Intel Cascade Lake 3.0GHz 8U16G|华为云x86虚拟机、容器|
|华为云ECS|Huawei Kunpeng 920 2.6GHz 8U16G|华为云arm64虚拟机、容器|

# 3     测试结论概述

## 3.1   测试整体结论

- Apptainer特性，共计执行5个用例，主要覆盖了接口测试和功能测试，通过OpenHPC官方CI用例，发现问题已解决，回归通过，无遗留风险，整体质量良好；
    - https://github.com/openhpc/ohpc/tree/3.x/tests/runtimes/singularity
    - [singularity] check for RPM
    - [singularity] pull down $DISTRO docker image
    - [singularity] exec image
    - [singularity] exec image via $rm
- mod_perl特性，共执行用例3个用例，主要覆盖了OpenHPC的端到端测试，通过OpenHPC官方CI用例，发现问题已解决，回归通过，无遗留风险，整体质量良好；
    - httpd加载测试
    - 结合OpenHPC社区的warewulf3端到端测试
    - httpd启动测试

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|          |          |          |                    |          |
|          |          |          |                    |          |

### 3.3.2 问题统计

不涉及

|        | 问题总数 | 严重 | 主要  | 次要  | 不重要 |
| ------ | -------- | ---- | ----- | ----- | ------ |
| 数目   | 0        | 0    | 0     | 0     | 0      |
| 百分比 | -     | -    | - | - | -      |


# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称              | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------------------- | ---------- | ------------ | ------------ |
| openEuler-22.03-sp1 | 8    | 8    | 0 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

建议通过22.03-lts-sp1容器镜像进行端到端测试
```
$ podman run --privileged -ti docker.io/openeuler/openeuler:22.03-lts-sp1 bash
$ yum install -y wget
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/apptainer-1.1.6-2.oe2203.aarch64.rpm
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/apptainer-suid-1.1.6-2.oe2203.aarch64.rpm
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/squashfuse-0.1.105-1.oe2203.aarch64.rpm
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/fuse-overlayfs-1.9-1.oe2203.aarch64.rpm
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/squashfuse-libs-0.1.105-1.oe2203.aarch64.rpm
$ yum install ./*.rpm -y

$ singularity pull ./ubuntu.sif docker://ubuntu:latest
$ singularity exec ubuntu.sif cat /etc/os-release
```

建议通过22.03-lts-sp1容器镜像进行端到端测试
```
$ podman run --privileged -ti docker.io/openeuler/openeuler:22.03-lts-sp1 bash
$ yum install -y wget
wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/mod_perl-2.0.12-1.oe2203.aarch64.rpm 
wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/perl-Linux-Pid-0.04-1.oe2203.aarch64.rpm

yum install ./*.rpm
ll /usr/lib64/httpd/modules/mod_perl.so

httpd

cat /var/log/httpd/error_log | grep mod_perl
[Wed Mar 15 03:41:39.127482 2023] [mpm_event:notice] [pid 435:tid 435] AH00489: Apache/2.4.51 (Unix) mod_perl/2.0.12 Perl/v5.34.0 configured -- resuming normal operations
```

# 5     附件

```
$ podman run --privileged -ti docker.io/openeuler/openeuler:22.03-lts-sp1 bash
$ yum install -y wget
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/apptainer-1.1.6-2.oe2203.aarch64.rpm
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/apptainer-suid-1.1.6-2.oe2203.aarch64.rpm
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/squashfuse-0.1.105-1.oe2203.aarch64.rpm
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/fuse-overlayfs-1.9-1.oe2203.aarch64.rpm
$ wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/squashfuse-libs-0.1.105-1.oe2203.aarch64.rpm
$ yum install ./*.rpm -y

$ singularity pull ./ubuntu.sif docker://ubuntu:latest
$ singularity exec ubuntu.sif cat /etc/os-release

[root@8002afd14840 /]# singularity pull ./ubuntu.sif docker://ubuntu:latest
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
Getting image source signatures
Copying blob cd741b12a7ea done
Copying config bab8ce5c00 done
Writing manifest to image destination
Storing signatures
2023/03/15 03:27:17  info unpack layer: sha256:cd741b12a7eaa64357041c2d3f4590c898313a7f8f65cd1577594e6ee03a8c38
INFO:    Creating SIF file...
[root@8002afd14840 /]# singularity exec ubuntu.sif cat /etc/os-release
INFO:    underlay of /etc/localtime required more than 50 (69) bind mounts
PRETTY_NAME="Ubuntu 22.04.2 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.2 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

```
sed -i "s@repo.openeuler.org@repo.huaweicloud.com/openeuler@g" /etc/yum.repos.d/openEuler.repo
$ podman run --privileged -ti docker.io/openeuler/openeuler:22.03-lts-sp1 bash
$ yum install -y wget
wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/mod_perl-2.0.12-1.oe2203.aarch64.rpm 
wget http://120.46.140.206:82/openEuler:/22.03:/LTS:/Next:/Epol/standard_aarch64/aarch64/perl-Linux-Pid-0.04-1.oe2203.aarch64.rpm

yum install ./*.rpm
ll /usr/lib64/httpd/modules/mod_perl.so

httpd

cat /var/log/httpd/error_log | grep mod_perl
[Wed Mar 15 03:41:39.127482 2023] [mpm_event:notice] [pid 435:tid 435] AH00489: Apache/2.4.51 (Unix) mod_perl/2.0.12 Perl/v5.34.0 configured -- resuming normal operations

# 虚拟机
$ systemctl status httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
     Active: active (running) since Mon 2023-04-03 19:38:31 CST; 4s ago
       Docs: man:httpd.service(8)
   Main PID: 219852 (/usr/sbin/httpd)
     Status: "Processing requests..."
      Tasks: 177 (limit: 3291671)
     Memory: 35.7M
     CGroup: /system.slice/httpd.service
             ├─ 219852 /usr/sbin/httpd -DFOREGROUND
             ├─ 219853 /usr/sbin/httpd -DFOREGROUND
             ├─ 219854 /usr/sbin/httpd -DFOREGROUND
             ├─ 219855 /usr/sbin/httpd -DFOREGROUND
             └─ 219856 /usr/sbin/httpd -DFOREGROUND

Apr 03 19:38:31 sms systemd[1]: Starting The Apache HTTP Server...
Apr 03 19:38:31 sms httpd[219852]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 192.168.1.220. Set the 'ServerName' directive globally to suppress this message
Apr 03 19:38:31 sms systemd[1]: Started The Apache HTTP Server.
```
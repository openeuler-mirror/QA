![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述                  | 作者       |
| ---------- | ----------- | ------------------------- | ---------- |
| 2023-06-15 | V1.0        | 增加初版Jailhouse测试报告 | gaoxingjie |
| 2023-06-20 | V1.1        | 回归测试                  | gaoxingjie |

关键词： openeuler-mcs jailhouse freertos_demo jailhouse-freertos

摘要：对 openeuler-mcs 特性中的 jailhouse 模块进行编译运行、测试


缩略语清单：

| 缩略语        | 英文全名 | 中文解释                            |
| ------------- | -------- | ----------------------------------- |
| openeuler-mcs |          | 混合关键系统特性                    |
| freertos_demo |          | Jailhouse虚拟机所加载的freertos镜像 |

# 1     特性概述

Jailhouse 是一种轻量级虚拟化工具，与传统的全功能虚拟化解决方案（如 KVM 和 Xen）不同，它不提供完整的虚拟机管理和抽象功能， 而是一种基于Linux的静态分区虚拟化方案。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                        | 测试起始时间 | 测试结束时间 |
| ------------------------------- | ------------ | ------------ |
| openEuler-22.03-LTS-SP2-round-2 | 2023-06-15   | 2023-06-15   |
| openEuler-22.03-LTS-SP2-round-3 | 2023-06-20   | 2023-06-20   |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息              | 备注 |
| -------- | ------------------------- | ---- |
| qemu     | qemu-system-aarch64_5.1.0 |      |

# 3     测试结论概述

## 3.1   测试整体结论

jailhouse特性，共计执行1个用例，主要覆盖了功能测试，通过经过jailhouse的编译运行以及 freertos_demo 测试验证，发现问题已解决，回归通过，无遗留风险，整体质量良好；

测试步骤：

1.编译镜像：

```shell
# 初始化 22.03-LTS-SP2 分支
oebuild init jailhouse_rnd2 -b openEuler-22.03-LTS-SP2

# 更新代码
cd ./jailhouse_rnd2
oebuild update

# 添加 mcs 特性
sed -i 's/openamp/jailhouse/g' src/yocto-meta-openeuler/.oebuild/features/openeuler-mcs.yaml
oebuild generate  -p aarch64-std -f openeuler-mcs -d qemu-mcs-jailhouse

# 在编译目录下的compile.yaml文件中添加meta-freertos 层,eg:
layers:
- yocto-meta-openeuler/rtos/meta-freertos

# 添加 freertos_demo 到文件系统
sed -i "s/\${@bb.utils.contains('MCS_FEATURES', 'jailhouse', 'jailhouse', '', d)}/\${@bb.utils.contains('MCS_FEATURES', 'jailhouse', 'jailhouse jailhouse-freertos', '', d)}/g" src/yocto-meta-openeuler/meta-openeuler/recipes-core/packagegroups/packagegroup-mcs.bb

#执行编译
cd ./build/qemu-mcs-jailhouse
oebuild bitbake openeuler-image-mcs
oebuild bitbake openeuler-image-mcs -c do_populate_sdk
```

2.qemu启动镜像：

```shell
# 制作启动磁盘：
## 分配5G空间：
dd if=/dev/zero of=./disk.ext4 bs=1G count=5
## 格式化分区：
mkfs.ext4 ./disk.ext4
## 使用sudo权限挂载分区：
mkdir ./tmp_disk
sudo mount ./disk.ext4 ./tmp_disk
## 将rootfs复制到磁盘镜像：
sudo cp openeuler-image-mcs-qemu-aarch64.rootfs.cpio.gz ./tmp_disk
## 解压rootfs
sudo gunzip openeuler-image-mcs-qemu-aarch64.rootfs.cpio.gz
sudo cpio -idmv < openeuler-image-mcs-qemu-aarch64.rootfs.cpio
## 取消挂载
sudo umount tmp_disk

# 启动镜像：
qemu-system-aarch64 -machine virt,gic-version=3,virtualization=on,its=off -cpu cortex-a53 -nographic -smp 4 -m 2048 -drive format=raw,file=disk.ext4 -kernel Image-5.10.0 -append "noinitrd root=/dev/vda rw console=ttyAMA0 loglevel=8 mem=1G"
```

3.启动jailhouse

```shell
# 加载jailhouse的ko文件
modprobe jailhouse

# 加载jailhouse cell
jailhouse enable /usr/share/jailhouse/cells/qemu-arm64-openeuler-demo.cell
jailhouse cell create /usr/share/jailhouse/cells/qemu-arm64-freertos-demo.cell

# 加载freertos镜像
jailhouse cell load 1 /Jailhouse_FreeRTOS_demo/FreeRTOS.bin -a 0x0

# 启动虚拟机
jailhouse cell start 1
```

4.测试结果

```shell
# 打印以下字样，详细日志查看附件：
Hello World main()!
This is freertos from the openeuler community!
Hello world!
```

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 新增特性测试 | 功能测试编译运行过程完整，无异常 |

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
| 数目   | 0        |      |      |      |        |
| 百分比 | 0        |      |      |      |        |

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | jailhouse | <font color=green>■</font> |   |
| 2 | freertos_demo | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.3 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|          |          |          |

## 4.4 资料测试结论
[轻量级虚拟化工具 Jailhouse](https://openeuler.gitee.io/yocto-meta-openeuler/master/features/jailhouse.html#jailhouse)

[src-openeuler/Jailhouse](https://gitee.com/src-openeuler/Jailhouse)

| 测试类型 | 测试内容                       | 测试结论 |
| -------- | ------------------------------ | -------- |
| 资料测试 | 审查使用说明文档，执行说明步骤 | 通过     |

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称                        | 测试用例数 | 用例执行结果 | 发现问题单数 |
| ------------------------------- | ---------- | ------------ | ------------ |
| openEuler-22.03-LTS-SP2-round-2 | 1          | 通过         | 0            |
| openEuler-22.03-LTS-SP2-round-3 | 1          | 通过         | 0            |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

```
qemu-aarch64 / # jailhouse enable /usr/share/jailhouse/cells/qemu-arm64-openeuler-demo.cell

Initializing Jailhouse hypervisor  on CPU 2
Code location: 0x0000ffffc0200800
Page pool usage after early setup: mem 45/4065, remap 0/131072
Initializing processors:
 CPU 2... OK
 CPU 1... OK
 CPU 3... OK
 CPU 0... OK
Initializing unit: irqchip
Initializing unit: ARM SMMU v3
Initializing unit: ARM SMMU
Initializing unit: PVU IOMMU
Initializing unit: PCI
Adding virtual PCI device 00:00.0 to cell "qemu"
Page pool usage after late setup: mem 63/4065, remap 144/131072
Activating hypervisor
[65380.766763] jailhouse: CONFIG_OF_OVERLAY disabled
[65380.769187] jailhouse: failed to add virtual host controller
[65380.769415] The Jailhouse is opening.
qemu-aarch64 / # jailhouse cell create /usr/share/jailhouse/cells/qemu-arm64-freertos-demo.cell
[65391.670053] CPU1: shutdown
======= 0x0[65391.670597] psci: CPU1 killed (polled 0 ms)
Adding virtual PCI device 00:00.0 to cell "freertos"
Shared memory connection established, peer cells:
 "qemu"
======= 0x0virtual cpuid: 1 -> 0
Created cell "freertos"
Page pool usage after cell creation: mem 76/4065, remap 144/131072
[65391.747377] Created Jailhouse cell "freertos"
qemu-aarch64 / # jailhouse cell load 1 /Jailhouse_FreeRTOS_demo/FreeRTOS.bin -a 0x0
======= 0x0virtual cpuid: 1 -> 0
Cell "freertos" can be loaded
qemu-aarch64 / # jailhouse cell start 1
Started cell "freertos"
======= 0x0virtual cpuid: 1 -> 0
Hello World main()!
This is freertos from the openeuler community!
Hello world!
printf test
(null) is null pointer
5 = qemu-aarch64 / # 5
-2147483647 = - max int
char a = 'a'
hex ff = ff
hex 00 = 00
signed -3 = unsigned 4294967293 = hex fffffffd
0 message(s)
0 message(s) with %
justif: "left      "
justif: "     right"
 3: 0003 zero padded
 3: 3    left justif.
 3:    3 right justif.
-3: -003 zero padded
-3: -3   left justif.
-3:   -3 right justif.
main:68
test_software_timer()
Timer[0]:19410 is set into the Active state.
Timer[1]:195A0 is set into the Active state.
Timer[2]:195F0 is set into the Active state.
Timer[3]:19640 is set into the Active state.
Timer[4]:19690 is set into the Active state.
main:79

```





 



 

 
![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025/6/6 | v1.0 | KAE直通热迁移测试报告 | 鲍超莹 |

关键词： KAE，热迁移

摘要：本报告主要描述基于openEuler 22.03 LTS SP4版本进行的KAE直通热迁移特性的测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。

# 1     特性概述

KAE直通热迁移是指虚拟机在配置KAE直通设备时，进行热迁移的能力，可以为KAE设备的使用提供更强的灵活性和业务不中断的保障。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler 22.03 LTS SP4 | 2025/5/21 | 2025/5/27 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| S920X20 | Kunpeng 920 7280Z@2.9GHz *2 |      |

# 3     测试结论概述

## 3.1   测试整体结论

KAE直通热迁移特性，共计执1个用例，主要覆盖了功能测试和资料测试，功能正常未发现问题。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 不涉及 |
| 功能测试 | 新增特性测试 | <font color=green>■</font> |
| 兼容性测试 |          | 不涉及 |
| DFX专项测试 | 性能测试 | <font color=green>■</font> |
| DFX专项测试 | 可靠性/韧性测试 | 不涉及 |
| DFX专项测试 | 安全测试 | 不涉及 |
| 资料测试 |         | <font color=green>■</font> |
| 其他测试 |         | 不涉及 |

## 3.2   约束说明

| 序号 | 约束说明 |
| --- | --- |
| 1 | 继承原有热迁移的约束 |
| 2 | 不支持KAE设备以外的直通设备热迁移 |
| 3 | 虚拟机内的KAE直通设备位于同一numa节点上时性能最佳 |

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题

### 3.3.2 问题统计

无

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

不涉及

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | KAE直通热迁移 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 次数 | 停机时间 |
| --- | ----------- |
| 1 | 158ms |
| 2 | 147ms |
| 3 | 152ms |
8U16G规格配置三个KAE直通设备时（ZIP、HPRE、SEC设备各一个），热迁移停机时间不大于200ms。

### 4.3.2 可靠性/韧性测试结论

不涉及

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
| 资料测试 | https://gitee.com/openeuler/docs/pulls/15314 | 通过 |

## 4.5 其他测试结论

无

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler 22.03 LTS SP4 | 1 | Pass | 0 |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   测试流程

### 5.2.1 新增特性测试
1. xml中配置ZIP、HPRE、SEC直通设备各一个（三个设备应位于同一numa节点），其中migration参数为“on”，address为VF对应的bdf号。

    ```xml
        <hostdev mode='subsystem' type='pci' migration='on'>
            <driver name='vfio'/>
            <source>
                <address bus='0x31' slot='0x00' function='0x1'/>
            </source>
        </hostdev>
    ```

2. 配置xml，打开“all_vcpus_paused”和“all_vcpus_prepared”两个trace事件。

    ```xml
        <qemu:commandline>
            <qemu:arg value='--trace'/>
            <qemu:arg value="all_vcpus*"/>
        </qemu:commandline>
    ```

3. 设置控制台日志级别，避免KAE设备驱动的日志打印到串口中。

    ```shell
    sudo sysctl -w kernel.printk="4 4 1 7"
    ```
4. 同步迁移源端和目的端的本地时间。

    ```shell
    ntpdate [NTP IP/hostname]
    ```

    可用一下命令查看时间是否一致：

    ```shell
    date +%Y-%m-%d\ %H:%M:%S.%3N
    ```
    
5. 启动虚拟机，设置downtime-limit为100。

    ```shell
    virsh migrate-setmaxdowntime [vmname] 100
    ```

6. 虚拟机中执行KAE压缩业务加压，进行热迁移。
    执行压缩业务：

    ```shell
    ./kaezip_perf -m 6 -l 10240 -n 3000
    ```

    迁移命令：

    ```shell
    virsh migrate --live --unsafe [vmname] qemu+ssh://[IP]/system tcp://[IP]
    ```

7. 在迁移源端的日志中查看all_vcpus_paused事件，目的端的日志中查看all_vcpus_prepared事件，根据时间戳计算热迁移停机时间。
    查看日志：

    ```shell
    less /var/log/libvirt/qemu/[vmname].log
    ```

# 6     附件

NA

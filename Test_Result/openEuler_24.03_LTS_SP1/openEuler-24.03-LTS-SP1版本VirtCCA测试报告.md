关键词：
VirtCCA

摘要：
在openEuler24.03-LTS-SP1版本中提供Libvirt、QEMU版本的RPM安装包，方便用户快速部署VirtCCA。

# 1 特性概述

VirtCCA是一种在可信的硬件基础上，通过隔离、加密、证明等机制，保护使用中数据安全的计算模式机密虚机特性，该特性合入openEuler24.03-LTS-SP1，该版本中提供libvirt、QEMU
版本的RPM安装包，方便用户快速部署VirtCCA。

# 2 特性测试信息

| 版本名称 | 测试起始时间 | 测试结束时间 |
| openEuler24.03-LTS-SP1 | 2024-11-23 | 2024-12-02 |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| NA | NA | 虚拟机 |

# 3 测试结论概述

# 3.1  测试整体结论

VirtCCA特性合入openEuler24.03-LTS-SP1，针对机密虚机场景整体进行了功能、性能、可靠性、兼容性、资料和长稳测试，共执行用例397个，
包括机密虚拟的基本功能测试以及虚拟机注入故障/宿主机注入故障/老化测试/并发测试的可靠性测试；完成了功能、兼容性、可靠性、长稳测试、以及资料测试，用例通过7*
24的长稳测试。该版本共发现问题0个，无遗留风险，整体质量良好。 

# 3.2  约束说明

|机型|Kunpeng920 新型号服务器|
|iBMC|5.5.12.5|
|BIOS|20.40|
|CPU↵|Kunpeng920 7270Z|
|硬盘↵|系统盘：1*T NVME|
|OS|openEuler24.03-LTS-SP1|
|libvirt|9.10.0|
|qemu|8.2.0|
|kernel|6.6|

# 3.3  遗留问题分析

# 3.3.1 遗留问题影响以及规避措施

无

# 3.3.2 问题统计

无

# 4 详细测试结论

# 4.1 功能测试

# 4.1.1 继承特性测试结论

| 序号  | 组件/特性名称    | 特性质量评估 | 备注 |
|-----|------------| -------- | -------- |
| 1   | virtio半虚拟化 | 特性质量良好 | 无 |
| 2   | 中断管理       | 特性质量良好 | 无 |
| 3   | 内存管理       | 特性质量良好 | 无 |
| 4   | 时钟管理       | 特性质量良好 | 无 |
| 5   | 电源管理       | 特性质量良好 | 无 |
| 6   | 资源管理       | 特性质量良好 | 无 |
| 7   | 远程证明       | 特性质量良好 | 无 |
| 8   | 设备直通       | 特性质量良好 | 无 |
| 9   | 国密硬件加速     | 特性质量良好 | 无 |

# 4.1.2 新增特性测试结论

无

# 4.2 兼容性测试结论

针对VirtCCA机密虚机特性，主要验证了OS的兼容性，OS包括openEuler22.03 SP4以及openEuler24.03-LTS-SP1，兼容性测试结论通过。

# 4.3 DFX专项测试结论

# 4.3.1 性能测试结论

| 指标大项 | 指标值 | 实际值 | 测试结论 |
| -------- | -------- | -------- | -------- |
| 机密虚机计算和内存基础性能 | 机密虚机相比于普通虚机CPU、内存性能平均损耗<5%，单项损耗最差<10% | 整体平均损耗在%5以内，单项劣化不超过10% | PASS |
| 机密虚机磁盘IO和网络性能 | 机密虚机相比于普通虚机磁盘IO、网络性能平均损耗<40%，单项损耗最差<45% | 整体平均损耗在%40以内，单项劣化不超过45% | PASS |

# 4.3.2 可靠性/韧性测试结论

| 测试类型  | 测试类容  | 测试结论 |
| -------- | -------- | -------- |
| 并发测试 | 16个虚拟机使用virsh同时创建再同时删除| PASS |
| 故障测试 | 宿主机注入故障、虚拟机注入故障 | PASS |
| 机密虚机长稳 | 多个cvm同时运行各项资源（cpu、内存、磁盘fio、网卡）的满负载压力测试，同时进行新cvm的创建/启动/销毁动作 | 用例持续稳定执行7*24h，无异常发生 |
| 机密虚机长稳 | 多磁盘、网卡设备同时操作压力测试 | 用例持续稳定执行7*24h，无异常发生 |

# 4.3.3 安全测试结论

安全测试用例主要包括开源及第三方软件生命周期与漏洞测试，源码安全审计，安全编译选项，工具静态安全扫描。该特性经过安全测试活动评估，用例均通过，无风险。

# 4.4 资料测试结论

版本特性指南及版本说明书和使用手册已添加VirtCCA机密虚机特性OS兼容openEuler24.03-LTS-SP1操作系统。

# 4.5 其他测试结论

无

# 5 测试执行

# 5.1   测试执行统计数据

|         版本名称         | 测试用例数 | 用例执行结果 | 发现问题单数 |
| ----------------------- |------|--------| ---------  |
|  openEuler24.03-LTS-SP1 | 397  | 通过397个 |     0      |


# 5.2   后续测试建议

N/A

# 6 附件

N/A


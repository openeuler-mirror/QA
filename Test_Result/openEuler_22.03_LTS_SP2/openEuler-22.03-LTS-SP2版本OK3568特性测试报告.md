![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|      |             |          |      |


关键词：OK3568

摘要：本报告主要描述基于openEuler-22.03-LTS-SP2版本进行新合入的特性对OK3568的构建与使用是否有影响的测试过程，报告对测试情况进行说明，对特性的测试充分度进行评估和总结。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |


# 1     特性概述

ok3568硬件特性，目前已支持串口设备，可以访问uart，其他硬件特性目前支持：无线网卡、GPU、TF卡、以太网卡、USB Host、SPI、HDMI。

支持百级嵌入式软件包。

支持部署rt实时内核。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-22.03-LTS-SP2         |  2023/6/25            |   2023/6/27           |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  OK3568-C        |    CPU：4 核 Cortex-A55；内存：2G          |      |


# 3     测试结论概述

## 3.1   测试整体结论

openEuler Embedded中RK3568系列板卡的构建特性，共计执行75个用例，主要覆盖了功能测试，整体质量良好。

| 测试活动    | 活动评价 |
| --------   | ------------ |
| 功能测试    | 测试新合入的特性对OK3568的BSP板载驱动是否有影响，包括HDMI驱动、RTC驱动、Nand Flash驱动、SD Card驱动、原生MAC的千百兆网卡驱动、UART串口驱动。|
| 功能测试    | 测试新合入的特性对OK3568的openAMP构建与使用是否有影响，包括RT-Thread、Intewell的启动、关闭和通信测试。 |
| 功能测试    | 测试新合入的特性是否能在OK3568板上正常使用。 |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号    | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
|          | HDMI驱动因QT5未移植到当前测试版本，暂无法通过qt5-opengles2-test -platform eglfs命令输出图像到显示屏来测试HDMI驱动。         |   主要      |                    |          |
|          |  Intewell的拉起出错，提示【Kernel Offset: disabled”、“end Kernel panic - not syncing: Attempted to kill init!”】        |    主要      |                    |          |
|          |  【mugen嵌入式测试套】/dev/shm挂载项缺少relatime        |    次要      |   openeuler的配置文件本身没有相应设置，即挂载时未把对应的配置参数relatime加上。需要确认该配置项是否需要纳入默认配置范畴。此问题暂时不予处理。                 |          |


### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |     3     |   0   |   2   |   1   |    0    |
| 百分比 |     100%     |  0    |  66.7%    | 33.3%     |   0     |

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| | | <font color=green>■</font> |   |
| | | <font color=blue>▲</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| | | <font color=red>●</font> |   |
| | | <font color=blue>▲</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|         |         |        |         |

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

### 4.3.3 安全测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

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
|  openEuler-22.03-LTS-SP2        |     75       |     通过72个，失败3个         |      3        |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   测试结果


| 序号 | 功能项 | 测试用例 | 执行结果 |
| -------- | ---------- | ------------ | ------------ |
|     1     |  HDMI驱动          |    OK3568开发板通过HDMI连接上显示屏,执行命令：qt5-opengles2-test -platform eglfs,检查显示是否有图像输出           |       失败      |
|     2     |  RTC驱动           |    1.输入 date 命令查看系统时钟。2.用date -s "2023-06-25 10:00:00"指令设置当前系统时间，使用 date 命令查看设置是否成功。3.使用  hwclock -w 命令将系统时钟同步到硬件时钟，并使用 hwclock 命令查看硬件时钟。          |      通过        |
|     3     |  Nand Flash驱动           |    在Nand Flash根文件系统中，使用 dd 命令进行读写测试。          |       通过       |
|     4     |  SD Card驱动           |    1.挂载SD卡。2.使用iozone工具对SD卡文件系统进行IO性能测试。          |       通过       |
|     5     |  原生MAC的千百兆网卡驱动           |    1.通过网口连接上openEuler。2.使用iperf工具进行带宽性能测试           |     通过         |
|     6     |  UART串口驱动           |    通过串口工具连接上OpenEuler系统，执行命令top/free/ps，检查系统是否输出信息。           |     通过         |



| 序号 | 功能项 | 测试用例 | 执行结果 |
| -------- | ---------- | ------------ | ------------ |
|     1     |  openAMP功能：RT-Thread         |    openEuler通过openAMP拉起和关闭RT-Thread，并进行通信测试，包括test echo、send matrix、test ping、test flood-ping 测试。          |       成功      |
|     2     |  openAMP功能：Intewell           |    openEuler通过openAMP拉起和关闭Intewell，并进行通信测试，包括test echo、send matrix、test ping、test flood-ping 测试。          |       失败      |



【mugen嵌入式测试套】embedded_os_basic_test测试套执行47个用例，通过47个，通过率100% 。

| 序号 | 测试套名称 | 用例名 | 执行结果 |
| -------- | ---------- | ------------ | ------------ |
|     1     |  embedded_os_basic_test           |    oe_test_bashrc_umask           |       通过       |
|     2     |  embedded_os_basic_test           |    oe_test_basic_cmd_acl          |      通过        |
|     3     |  embedded_os_basic_test           |    oe_test_basic_cmd_cat          |       通过       |
|     4     |  embedded_os_basic_test           |    oe_test_basic_cmd_cd           |       通过       |
|     5     |  embedded_os_basic_test           |    oe_test_basic_cmd_chmod           |     通过         |
|     6     |  embedded_os_basic_test           |    oe_test_basic_cmd_chown           |     通过         |
|     7     |  embedded_os_basic_test           |    oe_test_basic_cmd_cp           |        通过      |
|     8     |  embedded_os_basic_test           |    oe_test_basic_cmd_date           |      通过        |
|     9     |  embedded_os_basic_test           |    oe_test_basic_cmd_dd             |      通过        |
|     10     |  embedded_os_basic_test           |    oe_test_basic_cmd_df            |      通过        |
|     11     |  embedded_os_basic_test           |    oe_test_basic_cmd_dmesg          |     通过         |
|     12     |  embedded_os_basic_test           |    oe_test_basic_cmd_grep           |      通过        |
|     13     |  embedded_os_basic_test           |     oe_test_basic_cmd_groupadd           |     通过         |
|     14     |  embedded_os_basic_test           |      oe_test_basic_cmd_groupdel          |      通过        |
|     15     |  embedded_os_basic_test           |      oe_test_basic_cmd_groupmod         |       通过       |
|     16     |  embedded_os_basic_test           |      oe_test_basic_cmd_gzip         |     通过         |
|     17     |  embedded_os_basic_test           |      oe_test_basic_cmd_id         |       通过       |
|     18     |  embedded_os_basic_test           |       oe_test_basic_cmd_ln         |       通过       |
|     19     |  embedded_os_basic_test           |       oe_test_basic_cmd_ls         |      通过        |
|     20     |  embedded_os_basic_test           |        oe_test_basic_cmd_lsof        |    通过          |
|     21     |  embedded_os_basic_test           |        oe_test_basic_cmd_mkdir        |    通过          |
|     22     |  embedded_os_basic_test           |         oe_test_basic_cmd_mv       |       通过       |
|     23     |  embedded_os_basic_test           |      oe_test_basic_cmd_pgrep         |     通过         |
|     24     |  embedded_os_basic_test           |        oe_test_basic_cmd_ping        |     通过         |
|     25     |  embedded_os_basic_test           |         oe_test_basic_cmd_ps       |       通过       |
|     26     |  embedded_os_basic_test           |           oe_test_basic_cmd_pwd     |      通过        |
|     27     |  embedded_os_basic_test           |        oe_test_basic_cmd_rm       |      通过        |
|     28     |  embedded_os_basic_test           |         oe_test_basic_cmd_rmdir       |     通过         |
|     29     |  embedded_os_basic_test           |         oe_test_basic_cmd_sort       |      通过        |
|     30     |  embedded_os_basic_test           |         oe_test_basic_cmd_su      |      通过        |
|     31     |  embedded_os_basic_test           |         oe_test_basic_cmd_sysctl      |     通过         |
|     32     |  embedded_os_basic_test           |          oe_test_basic_cmd_tar      |      通过        |
|     33     |  embedded_os_basic_test           |           oe_test_basic_cmd_top     |      通过        |
|     34     |  embedded_os_basic_test           |           oe_test_basic_cmd_touch     |     通过         |
|     35     |  embedded_os_basic_test           |           oe_test_basic_cmd_umask   |      通过        |
|     36     |  embedded_os_basic_test           |           oe_test_basic_cmd_uname    |     通过         |
|     37     |  embedded_os_basic_test           |            oe_test_basic_cmd_wc    |       通过       |
|     38     |  embedded_os_basic_test           |            oe_test_basic_cmd_which  |      通过        |
|     39     |  embedded_os_basic_test           |            oe_test_continuous_100M   |     通过         |
|     40     |  embedded_os_basic_test           |             oe_test_os_release   |        通过      |
|     41     |  embedded_os_basic_test           |             oe_test_system_log_logrotate   |     通过         |
|     42     |  embedded_os_basic_test           |            oe_test_system_monitor_process   |      通过        |
|     43     |  embedded_os_basic_test           |            oe_test_system_service_sshd   |        通过      |
|     44     |  embedded_os_basic_test           |            oe_test_system_user_options_001   |    通过          |
|     45     |  embedded_os_basic_test           |             oe_test_system_user_options_002   |     通过         |
|     46     |  embedded_os_basic_test           |              oe_test_system_user_options_003  |      通过        |
|     47     |  embedded_os_basic_test           |            oe_test_var_log   |        通过      |


【mugen嵌入式测试套】embedded_security_config_test测试套执行20个用例，通过19个，通过率95% 。

| 序号 | 测试套名称 | 用例名 | 执行结果 |
| -------- | ---------- | ------------ | ------------ |
|     1     |   embedded_security_config_test         |   oe_test_check_file_sys_protect_001             |    失败          |
|     2     |    embedded_security_config_test        |   oe_test_check_file_sys_protect_002            |     通过         |
|     3     |    embedded_security_config_test        |    oe_test_check_file_sys_protect_003            |     通过         |
|     4     |    embedded_security_config_test        |    oe_test_check_file_sys_protect_004           |     通过         |
|     5     |    embedded_security_config_test        |    oe_test_check_file_sys_protect_005          |      通过        |
|     6     |    embedded_security_config_test        |    oe_test_check_log_001                       |      通过           |
|     7     |    embedded_security_config_test        |    oe_test_check_network_firewall_001          |      通过        |
|     8     |     embedded_security_config_test       |     oe_test_check_network_firewall_002          |     通过         |
|     9     |     embedded_security_config_test       |     oe_test_check_runtime_security_001         |      通过        |
|     10     |    embedded_security_config_test        |     oe_test_check_ssh_config_001           |      通过        |
|     11     |     embedded_security_config_test       |      oe_test_check_ssh_config_002          |     通过         |
|     12     |     embedded_security_config_test       |      oe_test_check_ssh_config_003         |      通过        |
|     13     |     embedded_security_config_test       |     oe_test_check_user_account_001          |    通过          |
|     14     |     embedded_security_config_test       |       oe_test_check_user_account_002         |   通过           |
|     15     |     embedded_security_config_test       |       oe_test_check_user_account_003         |   通过           |
|     16     |     embedded_security_config_test       |       oe_test_check_user_account_004        |    通过          |
|     17     |     embedded_security_config_test       |       oe_test_check_user_account_005        |    通过          |
|     18     |      embedded_security_config_test      |        oe_test_check_user_account_006        |   通过           |
|     19     |     embedded_security_config_test       |          oe_test_check_user_account_007     |    通过          |
|     20     |     embedded_security_config_test       |          oe_test_check_user_account_008     |   通过           |



## 5.3   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*


N/A

 



 

 
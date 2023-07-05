![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2023-06-20|初稿|安全配置规范框架设计及核心内容构建 测试报告|毛金涛|
|      |             |          |      |

关键词： 安全配置规范框架设计

摘要：


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

openEuler安全配置规范框架设计及核心内容构建。

对齐业界主流OS厂商，提供标准配置规范基线和检查工具，帮助下游OS厂商提升安全配置能力和核查能力，在国内取代CIS等国际规范，成为安全厂商首选openEuler核查规范。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|openEuler-22.03-LTS-SP2-round-4|2023-06-10|2023-06-16|
|openEuler-22.03-LTS-SP2-round-5|2023-06-17|2023-06-23|

# 3     测试结论概述

## 3.1   测试整体结论

本特性，共计执行1个用例，主要覆盖了配置测试，遗留风险小，整体质量良好。

arm:

| 测试活动 | 测试子项                                                     | Severity | 活动评价   | 结论                                      |
| -------- | ------------------------------------------------------------ | -------- | ---------- | ----------------------------------------- |
| 配置测试 | Set the UEFI Boot  Loader Password                           | medium   | pass       |                                           |
| 配置测试 | Ensure SMEP is not  disabled during boot                     | medium   | pass       |                                           |
| 配置测试 | Ensure SMAP is not  disabled during boot                     | medium   | pass       |                                           |
| 配置测试 | Set PAM's Password  Hashing Algorithm                        | medium   | pass       |                                           |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Special Characters | medium   | pass       |                                           |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Lowercase Characters | medium   | pass       |                                           |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Digit Characters | medium   | pass       |                                           |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Length  | medium   | pass       |                                           |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Uppercase Characters | medium   | pass       |                                           |
| 配置测试 | Ensure  PAM Enforces Password Requirements - Authentication Retry Prompts Permitted  Per-Session | medium   | fail       | 未加固，未配置会话认证尝试次数限制        |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Different Categories | medium   | pass       |                                           |
| 配置测试 | Ensure  PAM Enforces Password Requirements - Prevent the Use of Dictionary Words | medium   | fail       | 未配置弱口令字典                          |
| 配置测试 | Limit  Password Reuse                                        | medium   | fail       | 未加固，没有配置历史口令不重复次数        |
| 配置测试 | Set  Deny For Failed Password Attempts                       | medium   | fail       | Pam配置文件中配置项顺序不正确             |
| 配置测试 | Configure the root  Account for Failed Password Attempts     | medium   | pass       |                                           |
| 配置测试 | Set Lockout Time for  Failed Password Attempts               | medium   | pass       |                                           |
| 配置测试 | Accounts Password  Should Be Verified When Changing          | high     | pass       |                                           |
| 配置测试 | Accounts Name Should  Not Be Contained In Password           | high     | pass       |                                           |
| 配置测试 | Set Password Minimum  Age                                    | medium   | pass       |                                           |
| 配置测试 | Set  Password Maximum Age                                    | medium   | fail       | 未加固，用户口令有效期为99999             |
| 配置测试 | Set Password Warning  Age                                    | medium   | pass       |                                           |
| 配置测试 | Verify Only Root Has  UID 0                                  | high     | pass       |                                           |
| 配置测试 | All GIDs referenced  in /etc/passwd must be defined in /etc/group | low      | pass       |                                           |
| 配置测试 | Ensure All Accounts  on the System Have Unique Names         | medium   | pass       |                                           |
| 配置测试 | All  Accounts Are Necessary                                  | medium   | notchecked |                                           |
| 配置测试 | Ensure All Groups on  the System Have Unique Group Names     | medium   | pass       |                                           |
| 配置测试 | All  Login Accounts Are Necessary                            | medium   | notchecked |                                           |
| 配置测试 | Ensure All Groups on  the System Have Unique Group ID        | medium   | pass       |                                           |
| 配置测试 | Ensure All Accounts  on the System Have Unique Master Group IDs | medium   | pass       |                                           |
| 配置测试 | Ensure All Accounts  on the System Have Unique User IDs      | medium   | pass       |                                           |
| 配置测试 | Require  Authentication for Single User Mode                 | medium   | fail       | 未加固                                    |
| 配置测试 | Ensure  the Default Bash Umask is Set Correctly              | unknown  | fail       | 未加固                                    |
| 配置测试 | Set  Interactive Session Timeout                             | medium   | fail       | 未加固                                    |
| 配置测试 | All Interactive Users  Home Directories Must Exist           | medium   | pass       |                                           |
| 配置测试 | Ensure  gpgcheck Enabled for All dnf Package Repositories    | high     | fail       | 虚机环境未配置GPG check，测试环境可以pass |
| 配置测试 | Configure SSH to use  System Crypto Policy                   | medium   | pass       |                                           |
| 配置测试 | Uninstall All Python2  Packages                              | medium   | pass       |                                           |
| 配置测试 | Configure auditd  max_log_file_action Upon Reaching Maximum Log Size | medium   | pass       |                                           |
| 配置测试 | Configure auditd  Number of Logs Retained                    | medium   | pass       |                                           |
| 配置测试 | Enable auditd Service                                        | high     | pass       |                                           |
| 配置测试 | Verify User Who Owns  gshadow File                           | medium   | pass       |                                           |
| 配置测试 | Verify User Who Owns  group File                             | medium   | pass       |                                           |
| 配置测试 | Verify Permissions on  shadow File                           | medium   | pass       |                                           |
| 配置测试 | Verify Permissions on  passwd File                           | medium   | pass       |                                           |
| 配置测试 | Verify User Who Owns  passwd File                            | medium   | pass       |                                           |
| 配置测试 | Verify Group Who Owns  shadow File                           | medium   | pass       |                                           |
| 配置测试 | Verify Permissions on  group File                            | medium   | pass       |                                           |
| 配置测试 | Verify Group Who Owns  gshadow File                          | medium   | pass       |                                           |
| 配置测试 | Verify Permissions on  gshadow File                          | medium   | pass       |                                           |
| 配置测试 | Verify Group Who Owns  passwd File                           | medium   | pass       |                                           |
| 配置测试 | Verify User Who Owns  shadow File                            | medium   | pass       |                                           |
| 配置测试 | Verify Group Who Owns  group File                            | medium   | pass       |                                           |
| 配置测试 | Ensure All Files Are  Owned by a Group                       | medium   | pass       |                                           |
| 配置测试 | Verify that All  World-Writable Directories Have Sticky Bits Set | medium   | pass       |                                           |
| 配置测试 | Ensure All Files Are  Owned by a User                        | medium   | pass       |                                           |
| 配置测试 | Ensure  All Symlink Files Have Canonical Path                | medium   | notchecked |                                           |
| 配置测试 | Ensure  All Executable Files are not hidden                  | medium   | fail       | 误报，ets测试框架文件                     |
| 配置测试 | Enable Randomized  Layout of Virtual Address Space           | medium   | pass       |                                           |
| 配置测试 | Restrict  Exposed Kernel Pointer Addresses Access            | medium   | fail       | 内核参数kernel.kptr_restrict未加固        |
| 配置测试 | Restrict Access to  Kernel Message Buffer                    | medium   | pass       |                                           |
| 配置测试 | Enable rsyslog  Service                                      | medium   | pass       |                                           |
| 配置测试 | Remove tftp Daemon                                           | low      | pass       |                                           |
| 配置测试 | Uninstall tftp-server  Package                               | high     | pass       |                                           |
| 配置测试 | Remove telnet Clients                                        | high     | pass       |                                           |
| 配置测试 | Allow Only SSH  Protocol 2                                   | high     | pass       |                                           |
| 配置测试 | Use Only Strong Key  Exchange algorithms                     | medium   | pass       |                                           |
| 配置测试 | Disable Host-Based  Authentication                           | medium   | pass       |                                           |
| 配置测试 | Disable SSH Access  via Empty Passwords                      | high     | pass       |                                           |
| 配置测试 | Use Only Strong MACs                                         | medium   | pass       |                                           |
| 配置测试 | Disable SSH Support  for .rhosts Files                       | medium   | pass       |                                           |
| 配置测试 | Use Only Strong  Algorithms For Public Key                   | medium   | pass       |                                           |
| 配置测试 | Enable PAM                                                   | medium   | pass       |                                           |
| 配置测试 | Use Only Strong  Ciphers                                     | medium   | pass       |                                           |
| 配置测试 | Remove ftp Client                                            | low      | pass       |                                           |
| 配置测试 | Uninstall net-snmp  Package                                  | unknown  | pass       |                                           |
| 配置测试 | Ensure  All Commands/Bashes In Crontab File Are Not Writeable By Low-privilege Users | medium   | notchecked |                                           |

x86:

| 测试活动 | 测试子项                                                     | Severity | 活动评价   | 结论                                       |
| -------- | ------------------------------------------------------------ | -------- | ---------- | ------------------------------------------ |
| 配置测试 | Configure auditd  Number of Logs Retained                    | medium   | pass       |                                            |
| 配置测试 | Configure auditd  max_log_file_action Upon Reaching Maximum Log Size | medium   | pass       |                                            |
| 配置测试 | Enable auditd Service                                        | high     | pass       |                                            |
| 配置测试 | Configure SSH to use  System Crypto Policy                   | medium   | pass       |                                            |
| 配置测试 | Ensure  gpgcheck Enabled for All dnf Package Repositories    | high     | fail       | 虚机环境未配置GPG  check，测试环境可以pass |
| 配置测试 | Uninstall All Python2  Packages                              | medium   | pass       |                                            |
| 配置测试 | Require  Authentication for Single User Mode                 | medium   | fail       | 未加固                                     |
| 配置测试 | Ensure All Accounts  on the System Have Unique Names         | medium   | pass       |                                            |
| 配置测试 | All GIDs referenced  in /etc/passwd must be defined in /etc/group | low      | pass       |                                            |
| 配置测试 | Set  Password Maximum Age                                    | medium   | fail       | 未加固，用户口令有效期为99999              |
| 配置测试 | Set Password Warning  Age                                    | medium   | pass       |                                            |
| 配置测试 | Set Password Minimum  Age                                    | medium   | pass       |                                            |
| 配置测试 | Verify Only Root Has  UID 0                                  | high     | pass       |                                            |
| 配置测试 | All  Accounts Are Necessary                                  | medium   | notchecked |                                            |
| 配置测试 | Ensure All Accounts  on the System Have Unique Master Group IDs | medium   | pass       |                                            |
| 配置测试 | Ensure All Groups on  the System Have Unique Group ID        | medium   | pass       |                                            |
| 配置测试 | Ensure All Accounts  on the System Have Unique User IDs      | medium   | pass       |                                            |
| 配置测试 | Ensure All Groups on  the System Have Unique Group Names     | medium   | pass       |                                            |
| 配置测试 | All  Login Accounts Are Necessary                            | medium   | notchecked |                                            |
| 配置测试 | Ensure  the Default Bash Umask is Set Correctly              | unknown  | fail       | 未加固                                     |
| 配置测试 | All Interactive Users  Home Directories Must Exist           | medium   | pass       |                                            |
| 配置测试 | Set  Interactive Session Timeout                             | medium   | fail       | 未加固                                     |
| 配置测试 | Configure the root  Account for Failed Password Attempts     | medium   | pass       |                                            |
| 配置测试 | Set  Deny For Failed Password Attempts                       | medium   | fail       | Pam配置文件中配置项顺序不正确              |
| 配置测试 | Limit  Password Reuse                                        | medium   | fail       | 未加固，没有配置历史口令不重复次数         |
| 配置测试 | Set Lockout Time for  Failed Password Attempts               | medium   | pass       |                                            |
| 配置测试 | Set PAM's Password  Hashing Algorithm                        | medium   | pass       |                                            |
| 配置测试 | Ensure  PAM Enforces Password Requirements - Prevent the Use of Dictionary Words | medium   | fail       | 未配置弱口令字典                           |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Digit Characters | medium   | pass       |                                            |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Uppercase Characters | medium   | pass       |                                            |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Lowercase Characters | medium   | pass       |                                            |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Length  | medium   | pass       |                                            |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Special Characters | medium   | pass       |                                            |
| 配置测试 | Ensure  PAM Enforces Password Requirements - Authentication Retry Prompts Permitted  Per-Session | medium   | fail       | 未加固，未配置会话认证尝试次数限制         |
| 配置测试 | Ensure PAM Enforces  Password Requirements - Minimum Different Categories | medium   | pass       |                                            |
| 配置测试 | Accounts Name Should  Not Be Contained In Password           | high     | pass       |                                            |
| 配置测试 | Accounts Password  Should Be Verified When Changing          | high     | pass       |                                            |
| 配置测试 | Enable rsyslog  Service                                      | medium   | pass       |                                            |
| 配置测试 | Set the UEFI Boot  Loader Password                           | medium   | pass       |                                            |
| 配置测试 | Ensure SMAP is not  disabled during boot                     | medium   | pass       |                                            |
| 配置测试 | Ensure SMEP is not  disabled during boot                     | medium   | pass       |                                            |
| 配置测试 | Verify Permissions on  passwd File                           | medium   | pass       |                                            |
| 配置测试 | Verify Group Who Owns  gshadow File                          | medium   | pass       |                                            |
| 配置测试 | Verify User Who Owns  group File                             | medium   | pass       |                                            |
| 配置测试 | Verify Group Who Owns  group File                            | medium   | pass       |                                            |
| 配置测试 | Verify User Who Owns  shadow File                            | medium   | pass       |                                            |
| 配置测试 | Verify Group Who Owns  shadow File                           | medium   | pass       |                                            |
| 配置测试 | Verify User Who Owns  passwd File                            | medium   | pass       |                                            |
| 配置测试 | Verify Permissions on  group File                            | medium   | pass       |                                            |
| 配置测试 | Verify Group Who Owns  passwd File                           | medium   | pass       |                                            |
| 配置测试 | Verify User Who Owns  gshadow File                           | medium   | pass       |                                            |
| 配置测试 | Verify Permissions on  gshadow File                          | medium   | pass       |                                            |
| 配置测试 | Verify Permissions on  shadow File                           | medium   | pass       |                                            |
| 配置测试 | Ensure  All Executable Files are not hidden                  | medium   | fail       | 误报，ets测试框架文件                      |
| 配置测试 | Verify that All  World-Writable Directories Have Sticky Bits Set | medium   | pass       |                                            |
| 配置测试 | Ensure  All Symlink Files Have Canonical Path                | medium   | notchecked |                                            |
| 配置测试 | Ensure All Files Are  Owned by a Group                       | medium   | pass       |                                            |
| 配置测试 | Ensure All Files Are  Owned by a User                        | medium   | pass       |                                            |
| 配置测试 | Enable Randomized  Layout of Virtual Address Space           | medium   | pass       |                                            |
| 配置测试 | Restrict  Exposed Kernel Pointer Addresses Access            | medium   | fail       | 内核参数kernel.kptr_restrict未加固         |
| 配置测试 | Restrict Access to  Kernel Message Buffer                    | medium   | pass       |                                            |
| 配置测试 | Remove ftp Client                                            | low      | pass       |                                            |
| 配置测试 | Uninstall net-snmp  Package                                  | unknown  | pass       |                                            |
| 配置测试 | Disable SSH Support  for .rhosts Files                       | medium   | pass       |                                            |
| 配置测试 | Disable Host-Based  Authentication                           | medium   | pass       |                                            |
| 配置测试 | Disable SSH Access  via Empty Passwords                      | high     | pass       |                                            |
| 配置测试 | Allow Only SSH  Protocol 2                                   | high     | pass       |                                            |
| 配置测试 | Use Only Strong  Algorithms For Public Key                   | medium   | pass       |                                            |
| 配置测试 | Enable PAM                                                   | medium   | pass       |                                            |
| 配置测试 | Use Only Strong Key  Exchange algorithms                     | medium   | pass       |                                            |
| 配置测试 | Use Only Strong  Ciphers                                     | medium   | pass       |                                            |
| 配置测试 | Use Only Strong MACs                                         | medium   | pass       |                                            |
| 配置测试 | Ensure  All Commands/Bashes In Crontab File Are Not Writeable By Low-privilege Users | medium   | notchecked |                                            |
| 配置测试 | Uninstall tftp-server  Package                               | high     | pass       |                                            |
| 配置测试 | Remove tftp Daemon                                           | low      | pass       |                                            |
| 配置测试 | Remove telnet Clients                                        | high     | pass       |                                            |



## 3.2   约束说明

NA

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

NA

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |    0      | 0     |   0   |   0   |  0      |
| 百分比 |     0     |   0   |  0    |   0   |    0    |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

NA

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1|安全配置规范框架设计及核心内容构建 | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

NA

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

NA

### 4.3.2 可靠性/韧性测试结论

NA

### 4.3.3 安全测试结论

NA

## 4.4 资料测试结论
NA

## 4.5 其他测试结论

NA

# 5     测试执行

## 5.1   测试执行统计数据


| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-22.03-LTS-SP2-round-4         |     10       |      失败0个        |      0        |
| openEuler-22.03-LTS-SP2-round-5         |     10       |      失败0个        |      0        |




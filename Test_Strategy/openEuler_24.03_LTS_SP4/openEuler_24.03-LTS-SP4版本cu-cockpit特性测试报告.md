![avatar](../images/openEuler.png)

版权所有 © 2020  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者 |
| ---------- | ----------- | -------- | ---- |
| 2026/06/09 | 1.0         | 初稿     | 石权 |

# 1     特性概述

    cu-cockpit 是一款轻量级、单机部署的 OS 运维管理平台，针对单节点运维效率低、现有工具依赖重且功能冗余的痛点，采用 3 层解耦架构、无特定外部依赖，以"脚本即能力"的方式将底层 Shell/Python 脚本能力转化为易用的 Web 可视化操作入口，覆盖服务管理（状态监控、启停）、资源管理（动态资源实时监控、硬件与存储信息展示）、配置管理（系统与文件配置的查看和修改）、日志管理（系统日志概览、过滤、元数据详情）、终端功能（Linux 终端交互）和认证（登录、登出、用户切换）六大模块，弥补 openEuler 社区在单节点场景下轻量化运维管理工具的能力空缺。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称                | 测试起始时间 | 测试结束时间 |
| ----------------------- | ------------ | ------------ |
| openEuler_24.03-LTS-SP4 | 2026/06/01   | 2026/06/07   |

描述特性测试的硬件环境信息

| 硬件型号   | 硬件配置信息                                             | 备注     |
| ---------- | -------------------------------------------------------- | -------- |
| RH2288H V3 | Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz*2/内存16G*16 | 功能测试 |

# 3     测试结论概述

## 3.1   测试整体结论

    cu-cockpit 共执行 105 个测试用例，主要覆盖了运维过程的全流程，发现问题已解决，回归通过，无遗留风险，整体质量良好。

## 3.2   约束说明

- 需安装requirement.txt 中软件包

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

暂无

# 4     测试执行

## 4.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| 1.0      | 105        | 通过         | 0            |

# 5     附件

测试用例

## 5.1   资源管理模块（动态资源 / 硬件信息）

| **测试场景**                                        | **前提条件**                  | **执行步骤**                                                                                            | **结果** |
| --------------------------------------------------------- | ----------------------------------- | ------------------------------------------------------------------------------------------------------------- | -------------- |
| 测试指标模块（动态资源管理）mode=all 返回所有动态监控信息 | 已安装 cu-cockpit，动态资源脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_monitor_all_mode -v`                                  | 通过           |
| 测试指标模块（动态资源管理）mode=cpu 只返回 CPU 信息      | 已安装 cu-cockpit，动态资源脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_monitor_cpu_mode -v`                                  | 通过           |
| 测试指标模块（动态资源管理）mode=disk 只返回磁盘信息      | 已安装 cu-cockpit，动态资源脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_monitor_disk_mode -v`                                 | 通过           |
| 测试指标模块（动态资源管理）mode=memory 只返回内存信息    | 已安装 cu-cockpit，动态资源脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_monitor_memory_mode -v`                               | 通过           |
| 测试指标模块（动态资源管理）mode=network 只返回网络信息   | 已安装 cu-cockpit，动态资源脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_monitor_network_mode -v`                              | 通过           |
| 测试指标模块传入无效参数                                  | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_monitor_invalid_mode -v`                              | 通过           |
| 测试指标模块缺少参数                                      | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_monitor_missing_mode -v`                              | 通过           |
| 验证不同 mode 产生不同的脚本调用                          | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_monitor_different_modes -v`                           | 通过           |
| 测试系统信息模块返回 BIOS 信息                            | 已安装 cu-cockpit，硬件信息脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_hard_info_bios_mode -v`                               | 通过           |
| 测试系统信息模块返回 CPU 硬件信息                         | 已安装 cu-cockpit，硬件信息脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_hard_info_cpu_mode -v`                                | 通过           |
| 测试系统信息模块返回 system 信息                          | 已安装 cu-cockpit，硬件信息脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_hard_info_system_mode -v`                             | 通过           |
| 测试系统信息模块返回操作系统信息                          | 已安装 cu-cockpit，硬件信息脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_hard_info_os_system_mode -v`                          | 通过           |
| 测试存储模块返回对应的磁盘信息                            | 已安装 cu-cockpit，存储信息脚本可用 | `pytest tests/test_rescrouce_monitor_views.py -k test_hard_info_storage_mode -v`                            | 通过           |
| 测试存储模块传入无效参数                                  | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_hard_info_invalid_mode -v`                            | 通过           |
| 测试硬件模块获取内存槽信息传入参数应该失败                | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_memory_slot_with_extra_mode_fails -v`                 | 通过           |
| 测试硬件模块获取内存槽信息不需要参数                      | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_memory_slot_without_mode -v`                          | 通过           |
| 测试硬件模块获取 PCI 信息不需要 mode 参数                 | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_pci_info_without_mode -v`                             | 通过           |
| 测试资源管理模块脚本返回非 JSON 输出的情况                | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_run_shell_script_api_non_json_output -v`              | 通过           |
| 测试资源管理模块脚本执行失败的情况                        | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_run_shell_script_api_script_execution_failure -v`     | 通过           |
| 测试资源管理模块脚本不存在的情况                          | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_run_shell_script_api_script_not_found -v`             | 通过           |
| 测试资源管理模块脚本执行超时的情况                        | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py -k test_run_shell_script_api_timeout -v`                      | 通过           |
| 测试资源管理模块未登录用户访问被拒绝                      | 已安装 cu-cockpit                   | `pytest tests/test_rescrouce_monitor_views.py::TestAuthentication -k test_unauthenticated_access_denied -v` | 通过           |
| 测试 CPU 资源信息输出且格式为 JSON                        | 已安装 cu-cockpit，监控脚本可用     | `pytest tests/test_monitor_status.py -k test_cpu_output_json -v`                                            | 通过           |
| 测试 memory 资源信息输出且格式为 JSON                     | 已安装 cu-cockpit，监控脚本可用     | `pytest tests/test_monitor_status.py -k test_memory_output_json -v`                                         | 通过           |
| 测试 disk 资源信息输出且格式为 JSON                       | 已安装 cu-cockpit，监控脚本可用     | `pytest tests/test_monitor_status.py -k test_disk_output_json -v`                                           | 通过           |

## 5.2   服务管理模块

| **测试场景**                           | **前提条件**                  | **执行步骤**                                                                     | **结果** |
| -------------------------------------------- | ----------------------------------- | -------------------------------------------------------------------------------------- | -------------- |
| 测试服务管理模块成功获取服务状态             | 已安装 cu-cockpit，目标服务已部署   | `pytest tests/test_service_views.py -k test_get_service_status_success -v`           | 通过           |
| 测试服务管理模块启动服务成功                 | 已安装 cu-cockpit，目标服务已停止   | `pytest tests/test_service_views.py -k test_start_service_success -v`                | 通过           |
| 测试服务管理模块停止服务成功                 | 已安装 cu-cockpit，目标服务正在运行 | `pytest tests/test_service_views.py -k test_stop_service_success -v`                 | 通过           |
| 测试服务管理模块重启服务成功                 | 已安装 cu-cockpit，目标服务正在运行 | `pytest tests/test_service_views.py -k test_restart_service_success -v`              | 通过           |
| 测试服务管理模块缺少必需参数                 | 已安装 cu-cockpit                   | `pytest tests/test_service_views.py -k test_manage_service_missing_parameters -v`    | 通过           |
| 测试服务管理模块无效的操作类型               | 已安装 cu-cockpit                   | `pytest tests/test_service_views.py -k test_manage_service_invalid_operation -v`     | 通过           |
| 测试服务管理模块脚本文件不存在               | 已安装 cu-cockpit                   | `pytest tests/test_service_views.py -k test_get_service_status_script_not_found -v`  | 通过           |
| 测试服务管理模块获取服务状态获取脚本执行失败 | 已安装 cu-cockpit                   | `pytest tests/test_service_views.py -k test_get_service_status_execution_failure -v` | 通过           |
| 测试服务管理模块服务操作执行失败             | 已安装 cu-cockpit                   | `pytest tests/test_service_views.py -k test_manage_service_execution_failure -v`     | 通过           |
| 测试服务管理模块未登录用户访问被拒绝         | 已安装 cu-cockpit                   | `pytest tests/test_service_views.py -k test_unauthenticated_access_denied -v`        | 通过           |

## 5.3   日志管理模块

| **测试场景**                 | **前提条件**                 | **执行步骤**                                                                | **结果** |
| ---------------------------------- | ---------------------------------- | --------------------------------------------------------------------------------- | -------------- |
| 测试解析有效的日志行               | 已安装 cu-cockpit                  | `pytest tests/test_log_script.py -k test_parse_log_line_valid -v`               | 通过           |
| 测试解析无效的日志行               | 已安装 cu-cockpit                  | `pytest tests/test_log_script.py -k test_parse_log_line_invalid -v`             | 通过           |
| 测试日志模块边界情况               | 已安装 cu-cockpit                  | `pytest tests/test_log_script.py -k test_parse_log_line_edge_cases -v`          | 通过           |
| 测试日志模块提取摘要字段           | 已安装 cu-cockpit                  | `pytest tests/test_log_script.py -k test_extract_summary_fields -v`             | 通过           |
| 测试日志模块成功执行 JSON 输出格式 | 已安装 cu-cockpit，journalctl 可用 | `pytest tests/test_log_script.py -k test_main_success_json_output -v`           | 通过           |
| 测试没有日志条目的情况             | 已安装 cu-cockpit，journalctl 可用 | `pytest tests/test_log_script.py -k test_main_no_entries -v`                    | 通过           |
| 测试 journalctl 执行错误           | 已安装 cu-cockpit                  | `pytest tests/test_log_script.py -k test_main_journalctl_error -v`              | 通过           |
| 测试 journalctl 命令不存在         | 已安装 cu-cockpit                  | `pytest tests/test_log_script.py -k test_main_file_not_found -v`                | 通过           |
| 测试日志输入命令行参数解析         | 已安装 cu-cockpit                  | `pytest tests/test_log_script.py -k test_argument_parsing -v`                   | 通过           |
| 测试成功获取引导偏移列表的情况     | 已安装 cu-cockpit，引导脚本可用    | `pytest tests/test_log_views.py -k test_boots_view_success -v`                  | 通过           |
| 测试引导脚本不存在的情况           | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_boots_view_script_not_found -v`         | 通过           |
| 测试引导脚本执行失败的情况         | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_boots_view_script_execution_failure -v` | 通过           |
| 测试引导脚本执行超时的情况         | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_boots_view_timeout -v`                  | 通过           |
| 测试引导脚本文件未找到的情况       | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_boots_view_file_not_found -v`           | 通过           |
| 测试成功查询系统日志的情况         | 已安装 cu-cockpit，日志脚本可用    | `pytest tests/test_log_views.py -k test_logs_view_success -v`                   | 通过           |
| 测试日志脚本不存在的情况           | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_logs_view_script_not_found -v`          | 通过           |
| 测试日志脚本执行失败的情况         | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_logs_view_script_execution_failure -v`  | 通过           |
| 测试日志脚本执行超时的情况         | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_logs_view_timeout -v`                   | 通过           |
| 测试日志脚本文件未找到的情况       | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_logs_view_file_not_found -v`            | 通过           |
| 测试日志脚本返回空输出的情况       | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_logs_view_empty_output -v`              | 通过           |
| 测试日志脚本返回非 JSON 输出的情况 | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_logs_view_non_json_output -v`           | 通过           |
| 测试日志脚本返回字典格式的情况     | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_logs_view_dict_output -v`               | 通过           |
| 测试日志模块使用所有查询参数的情况 | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_logs_view_with_all_parameters -v`       | 通过           |
| 测试从 GET 请求构建命令的情况      | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_build_cmd_from_request_get -v`          | 通过           |
| 测试构建命令调用日志脚本的情况     | 已安装 cu-cockpit                  | `pytest tests/test_log_views.py -k test_build_cmd_from_request_post -v`         | 通过           |
| 测试成功获取 boot 偏移号列表       | 已安装 cu-cockpit                  | `pytest tests/test_boot.py -k test_list_boot_offsets_success -v`                | 通过           |
| 测试 boot 偏移号空输出情况         | 已安装 cu-cockpit                  | `pytest tests/test_boot.py -k test_list_boot_offsets_empty -v`                  | 通过           |
| 测试 boot 偏移号包含无效行的情况   | 已安装 cu-cockpit                  | `pytest tests/test_boot.py -k test_list_boot_offsets_invalid_lines -v`          | 通过           |

## 5.4   认证模块

| **测试场景**                | **前提条件**              | **执行步骤**                                                        | **结果** |
| --------------------------------- | ------------------------------- | ------------------------------------------------------------------------- | -------------- |
| 测试成功登录的情况                | 已安装 cu-cockpit，PAM 服务可用 | `pytest tests/test_auth.py -k test_login_view_success -v`               | 通过           |
| 测试 JSON 格式的登录请求          | 已安装 cu-cockpit，PAM 服务可用 | `pytest tests/test_auth.py -k test_login_view_json_format -v`           | 通过           |
| 测试表单格式的登录请求            | 已安装 cu-cockpit，PAM 服务可用 | `pytest tests/test_auth.py -k test_login_view_form_format -v`           | 通过           |
| 测试缺少用户名的情况              | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_login_view_missing_username -v`      | 通过           |
| 测试缺少密码的情况                | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_login_view_missing_password -v`      | 通过           |
| 测试空用户名的情况                | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_login_view_empty_username -v`        | 通过           |
| 测试空密码的情况                  | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_login_view_empty_password -v`        | 通过           |
| 测试用户名和密码都为空的情况      | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_login_view_empty_credentials -v`     | 通过           |
| 测试无效凭据的情况                | 已安装 cu-cockpit，PAM 服务可用 | `pytest tests/test_auth.py -k test_login_view_invalid_credentials -v`   | 通过           |
| 测试 PAM 服务不可用的情况         | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_login_view_pam_not_available -v`     | 通过           |
| 测试 PAM 认证异常的情况           | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_login_view_pam_auth_error -v`        | 通过           |
| 测试使用 GET 方法请求登录的情况   | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_login_view_get_method -v`            | 通过           |
| 测试登录成功后 session 存储的情况 | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_login_view_session_storage -v`       | 通过           |
| 测试成功登出的情况                | 已安装 cu-cockpit，用户已登录   | `pytest tests/test_auth.py -k test_logout_view_success -v`              | 通过           |
| 测试登出过程中发生异常的情况      | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_logout_view_exception -v`            | 通过           |
| 测试使用 GET 方法请求登出的情况   | 已安装 cu-cockpit               | `pytest tests/test_auth.py -k test_logout_view_get_method -v`           | 通过           |
| 测试完整的登录-登出流程           | 已安装 cu-cockpit，PAM 服务可用 | `pytest tests/test_auth.py -k test_login_logout_flow -v`                | 通过           |
| 测试多次登录尝试的情况            | 已安装 cu-cockpit，PAM 服务可用 | `pytest tests/test_auth.py -k test_multiple_login_attempts -v`          | 通过           |
| 测试用户名包含特殊字符的情况      | 已安装 cu-cockpit，PAM 服务可用 | `pytest tests/test_auth.py -k test_login_with_special_characters -v`    | 通过           |
| 测试长密码的情况                  | 已安装 cu-cockpit，PAM 服务可用 | `pytest tests/test_auth.py -k test_login_with_long_password -v`         | 通过           |
| 测试认证检查成功的情况            | 已安装 cu-cockpit，用户已登录   | `pytest tests/test_web_terminal.py -k test_auth_check_success -v`       | 通过           |
| 测试未登录时的认证检查            | 已安装 cu-cockpit               | `pytest tests/test_web_terminal.py -k test_auth_check_without_login -v` | 通过           |

## 5.5   配置管理模块

| **测试场景**                             | **前提条件**              | **执行步骤**                                                                 | **结果** |
| ---------------------------------------------- | ------------------------------- | ---------------------------------------------------------------------------------- | -------------- |
| 测试成功执行配置脚本的情况                     | 已安装 cu-cockpit，配置脚本可用 | `pytest tests/test_config.py -k test_get_config_api_success -v`                  | 通过           |
| 测试配置脚本不存在的情况                       | 已安装 cu-cockpit               | `pytest tests/test_config.py -k test_get_config_api_script_not_found -v`         | 通过           |
| 测试配置管理缺少必需参数的情况                 | 已安装 cu-cockpit               | `pytest tests/test_config.py -k test_get_config_api_missing_mode -v`             | 通过           |
| 测试配置管理 get 模式缺少 key 参数的情况       | 已安装 cu-cockpit               | `pytest tests/test_config.py -k test_get_config_api_missing_key_for_get_mode -v` | 通过           |
| 测试配置脚本执行失败的情况                     | 已安装 cu-cockpit               | `pytest tests/test_config.py -k test_get_config_api_script_execution_failure -v` | 通过           |
| 测试成功设置时间和主机名的情况                 | 已安装 cu-cockpit，配置脚本可用 | `pytest tests/test_config.py -k test_set_time_hostname_api_success -v`           | 通过           |
| 测试失败设置时间和主机名的情况                 | 已安装 cu-cockpit               | `pytest tests/test_config.py -k test_set_time_hostname_api_script_failure -v`    | 通过           |
| 测试成功写入字节数据到文件                     | 已安装 cu-cockpit               | `pytest tests/test_config.py -k test_write_bytes_to_file_success -v`             | 通过           |
| 测试配置管理修改配置文件缺少文件路径参数的情况 | 已安装 cu-cockpit               | `pytest tests/test_config.py -k test_write_bytes_to_file_missing_path -v`        | 通过           |
| 测试配置文件修改无效数据的情况                 | 已安装 cu-cockpit               | `pytest tests/test_config.py -k test_write_bytes_to_file_invalid_data -v`        | 通过           |

## 5.6   终端模块

| **测试场景**                  | **前提条件**                 | **执行步骤**                                                                        | **结果** |
| ----------------------------------- | ---------------------------------- | ----------------------------------------------------------------------------------------- | -------------- |
| 测试终端连接成功的情况              | 已安装 cu-cockpit，webssh 服务可用 | `pytest tests/test_web_terminal.py -k test_terminal_connect_success -v`                 | 通过           |
| 测试未登录时的终端连接              | 已安装 cu-cockpit                  | `pytest tests/test_web_terminal.py -k test_terminal_connect_without_login -v`           | 通过           |
| 测试带真实 IP 的终端连接            | 已安装 cu-cockpit，webssh 服务可用 | `pytest tests/test_web_terminal.py -k test_terminal_connect_with_real_ip -v`            | 通过           |
| 测试带 X-Forwarded-For 头的终端连接 | 已安装 cu-cockpit，webssh 服务可用 | `pytest tests/test_web_terminal.py -k test_terminal_connect_with_x_forwarded_for -v`    | 通过           |
| 测试 webssh 服务错误的情况          | 已安装 cu-cockpit                  | `pytest tests/test_web_terminal.py -k test_terminal_connect_webssh_error -v`            | 通过           |
| 测试 webssh 服务超时的情况          | 已安装 cu-cockpit                  | `pytest tests/test_web_terminal.py -k test_terminal_connect_webssh_timeout -v`          | 通过           |
| 测试 webssh 连接错误的情况          | 已安装 cu-cockpit                  | `pytest tests/test_web_terminal.py -k test_terminal_connect_webssh_connection_error -v` | 通过           |
| 测试空数据的终端连接                | 已安装 cu-cockpit                  | `pytest tests/test_web_terminal.py -k test_terminal_connect_empty_data -v`              | 通过           |
| 测试使用 GET 方法请求终端连接的情况 | 已安装 cu-cockpit                  | `pytest tests/test_web_terminal.py -k test_terminal_connect_get_method -v`              | 通过           |
| 测试 webssh 返回未授权的情况        | 已安装 cu-cockpit                  | `pytest tests/test_web_terminal.py -k test_terminal_connect_webssh_unauthorized -v`     | 通过           |

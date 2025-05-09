![avatar](../../images/openEuler.png)

# 版权声明

版权所有 © 2025 openEuler 社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

# 修订记录

| 日期       | 修订版本 | 修改描述             | 作者       |
|------------|----------|----------------------|------------|
| 2025-03-18 | 1.0.0    | 创建                | mengchaoming |

# 关键词

SecureGuardian, 安全检查, openEuler, Linux安全

# 摘要

本测试报告详细记录了SecureGuardian在openEuler 24.09-LTS版本上的安全检查功能等测试结果。SecureGuardian是一款专为Linux系统设计的安全评估工具，本次测试主要覆盖了基本功能测试、兼容性测试、性能，以及安全测试。

# 特性概述

SecureGuardian旨在为openEuler操作系统提供全面的安全检查，包括系统配置、服务状态、网络安全等方面。通过对系统的深入扫描和评估，SecureGuardian帮助管理员识别潜在的安全风险。

# 特性测试信息

## 测试版本信息

| 版本名称            | 测试起始时间  | 测试结束时间  |
|---------------------|--------------|--------------|
| 25.03 (RC5)  |      2025/03/18     |  2025/03/20  |

## 硬件环境信息

| 硬件型号     | 硬件配置信息                                          | 备注   |
|--------------|------------------------------------------------------|--------|
| aarch64      | CPU型号：kunpeng920，CPU核数：64，内存：64G，硬盘容量：8T | 华为泰山服务器 |
| x86_64       | CPU 型号：Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz，CPU内核总数：6，内存容量：16G | 联想启天台式机 M425-N000 |

# 测试结论概述

## 测试整体结论

SecureGuardian 在 openEuler-25.03 版本上的测试表现正常，通过了所有设计的测试用例。测试涵盖了功能完整性、系统兼容性等多个方面。具体包括以下几点：

- **功能测试**：SecureGuardian成功执行了所有配置的安全检查项，包括系统文件权限、服务状态检查和网络配置等审核。
- **兼容性测试**：在所有测试的硬件平台上均能正常运行，没有发现兼容性问题。
- **性能测试**：工具运行效率高，对系统性能影响小，满足企业级使用需求。
- **安全测试**：SecureGuardian的设计和实现专注于保障其操作的安全性。严格的文件权限设置和运行时行为控制确保了其在执行安全检查时，不会被未授权的使用或被恶意利用。

## 约束说明

SecureGuardian 需要在具有root权限的环境下运行以进行全面的系统检查。

## 遗留问题分析

### 遗留问题影响以及规避措施

无遗留问题;

### 问题统计

无

# 详细测试结论

## 功能测试

### 新增特性测试结论

安全检查项表现良好，能准确识别和响应测试场景中的各种配置问题。

## 兼容性测试

软件在aarch64和x86_64两种架构上均测试通过，没有发现任何兼容性问题。

## 专项测试

### 性能测试

SecureGuardian的扫描和报告生成过程中，资源占用低，对被测系统影响极小，满足高效性能需求。

### 安全测试

安全性测试主要针对SecureGuardian软件本身的安全性进行。测试的目的是确保软件的操作、存储和权限管理机制足够安全，防止未授权的使用或数据泄露。

#### 文件和目录权限设置

SecureGuardian对关键文件和目录设置了严格的权限，以防止未经授权的用户访问或修改安全检查脚本和报告。测试结果显示：

| 检查项                           | 测试结果 | 备注                                       |
|---------------------------------|----------|-------------------------------------------|
| `/usr/local/secureguardian/reports` 目录权限 | 通过     | 目录权限设置为仅root可读写执行，符合预期。 |
| `/usr/local/secureguardian/tools/*.sh` 脚本权限 | 通过     | 所有工具脚本权限设置为仅root可执行，符合预期。 |
| 所有文件和目录的所有权          | 通过     | 所有关键文件和目录的所有者和组均正确设置为root。 |

# 测试执行

## 测试执行统计数据

| 版本名称            | 测试用例数 | 用例执行结果 | 发现问题单数 |
|---------------------|------------|--------------|--------------|
| openEuler-25.03-RC5 | 201        | 201通过      | 0            |

## 后续测试建议

无

# 附件

无



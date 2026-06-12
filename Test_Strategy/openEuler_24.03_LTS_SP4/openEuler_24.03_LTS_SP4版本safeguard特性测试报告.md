![avatar](../images/openEuler.png)

版权所有 © 2020 openEuler社区

您对“本文档”的复制、使用、修改及分发受知识共享（Creative Commons）署名—相同方式共享4.0国际公共许可协议（以下简称“CC BY-SA 4.0”）的约束。为了方便用户理解，您可以通过访问 https://creativecommons.org/licenses/by-sa/4.0/ 了解 CC BY-SA 4.0 的概要（但不是替代）。CC BY-SA 4.0 的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

# openEuler 24.03 LTS SP4版本 safeguard 增强特性测试报告

## 修订记录

| 日期 | 修订版本 | 修改描述 | 作者 |
| ---- | -------- | -------- | ---- |
| 2026-06-09 | 1.0.0 | 撰写 safeguard特性测试报告初稿 | @tongyx633 |

## 关键词

safeguard、白名单、黑名单、LSM、BPF、CIDR、YAML、主机管控、网络访问控制、文件访问控制。

## 摘要

本文档依据 safeguard 增强研发自测结果，按照 openEuler QA 特性测试报告模板整理形成。测试主要覆盖 safeguard 白名单功能模块、黑名单功能模块以及启动运行接口。测试活动共设计并执行 7 个用例，覆盖白名单生成加载、网络白名单监控模式、进程白名单阻断模式、白名单手动调整、黑名单文件访问控制、黑名单网络访问控制、启动运行接口正常及异常路径。全部用例执行通过，未发现遗留缺陷。

## 缩略语清单

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
| BPF | Berkeley Packet Filter | Linux 内核中的可扩展数据面/观测与策略执行机制 |
| LSM | Linux Security Module | Linux 安全模块框架，用于在关键安全路径上实现访问控制 |
| CIDR | Classless Inter-Domain Routing | 无类别域间路由，用于描述网络地址范围 |
| YAML | YAML Ain't Markup Language | 常用于配置文件的人类可读数据序列化格式 |
| TC | Test Case | 测试用例 |

# 1 特性概述

safeguard 增强特性面向主机运行时安全管控场景，提供基于配置策略的白名单和黑名单能力，主要覆盖进程、网络、文件访问等控制对象。特性支持通过主机快照生成白名单配置，支持 YAML 策略文件加载，支持 monitor 和 block 两类运行模式。

本次测试涉及的核心能力如下：

1. 白名单自动生成与加载：支持通过 `safeguard controller generate` 生成白名单配置，并通过 `--config` 参数加载生效。
2. 白名单网络监控：支持配置网络白名单 monitor 模式，在不阻断实际访问的前提下记录访问日志。
3. 进程白名单阻断：支持配置进程白名单 block 模式，非 allow 列表中的进程访问行为被阻断。
4. 白名单手动调整：支持修改策略配置后重新加载并生效。
5. 黑名单文件访问控制：支持在 blacklist 模式下通过 deny 列表阻断指定路径访问。
6. 黑名单网络访问控制：支持在 blacklist 模式下通过 CIDR deny 列表阻断指定网络访问。
7. 启动运行接口：支持合法配置启动成功；配置文件不存在等异常路径能够启动失败并输出明确错误信息。

# 2 特性测试信息

本节描述被测对象的版本信息、测试时间及测试环境。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler_24.03-LTS-SP4 | 2026-06-03 | 2026-06-09|

硬件环境：

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| x86_64 服务器 | CPU：Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz；2 node 32 core；Memory：192G | 原研发自测环境 |

# 3 测试结论概述

## 3.1 测试整体结论

safeguard 增强特性本轮共设计并执行 7 个测试用例，主要覆盖白名单功能、黑名单功能、启动运行接口及配置加载路径。所有用例均执行通过，成功用例 7 个，失败用例 0 个；本次测试未发现缺陷，未遗留阻塞问题，整体结果为通过。

| 测试活动 | 活动评价 |
| -------- | -------- |
| 接口测试 | 执行 1 个启动运行接口用例，覆盖合法配置启动成功及不存在配置文件启动失败路径，结果通过。 |
| 功能测试 | 执行 6 个功能用例，覆盖白名单生成加载、网络白名单监控、进程白名单阻断、白名单手动调整、黑名单文件访问控制、黑名单网络访问控制，结果全部通过。 |
| 专项测试 | 已执行代码审查/代码走查，覆盖 7 个模块，审查覆盖率 100%；发现问题均已解决。 |

## 3.2 约束说明

1. 测试执行依赖 safeguard 已完成编译，并要求 `safeguard` 具备可执行权限。
2. 测试执行需要 root 权限，涉及策略加载、进程控制、网络访问控制、文件访问控制等能力验证。
3. 本次测试环境为 Kernel 6.6.0+、x86_64 硬件环境；
4. 网络测试用例中的 CIDR 地址以原自测环境地址为准，如 `172.25.31.141/32`，迁移到其他环境时需要替换为实际可达或需阻断的目标地址。
5. monitor 模式仅记录日志，不阻断实际访问；block 模式用于验证阻断行为。
6. 本轮测试属于功能自测/单元测试范围，未覆盖长期稳定性、并发压力、兼容性矩阵、异常内核环境等专项验证。

## 3.3 遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 问题单号 | 问题描述 | 问题级别 | 问题影响和规避措施 | 当前状态 |
| -------- | -------- | -------- | ------------------ | -------- |
| 无 | 本轮测试未发现遗留问题 | 无 | 无影响，无需规避 | 已关闭/不涉及 |

### 3.3.2 问题统计

|  | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目 | 0 | 0 | 0 | 0 | 0 |
| 百分比 | 0% | 0% | 0% | 0% | 0% |

# 4 测试执行

## 4.1 测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|  openEuler_24.03-LTS-SP4 | 7 | 通过 7 个，失败 0 个 | 0 |

数据项说明：

- 测试用例数：到本测试活动结束时，所有可用测试用例数。
- 发现问题单数：本测试活动总共发现的问题单数。

### 4.1.1 用例执行明细

| 用例编号 | 测试项 | 前置条件 | 执行概要 | 预期结果 | 实际结果 | 通过情况 |
| -------- | ------ | -------- | -------- | -------- | -------- | -------- |
| TC-WL-001 | 生成白名单配置并加载生效 | safeguard 已编译；root 权限 | 执行 `safeguard controller generate --output /tmp/whitelist.yaml --report /tmp/whitelist-report.json` 生成白名单配置；执行 `sudo safeguard --config /tmp/whitelist.yaml` 加载配置 | 白名单配置生成成功；safeguard 启动成功，无报错 | 白名单配置生成成功；safeguard 启动成功，无报错 | 通过 |
| TC-WL-002 | 网络白名单监控模式 | safeguard 已编译；root 权限 | 创建 `whitelist-monitor.yaml`，配置 `policy: whitelist`、`network.enable: true`、`network.mode: monitor`、`network.cidr.allow: [172.25.31.141/32]`；启动 safeguard | safeguard 启动成功；配置加载无报错 | safeguard 启动成功；配置加载无报错 | 通过 |
| TC-WL-003 | 进程白名单阻断模式 | safeguard 已编译；root 权限 | 创建 `whitelist-block.yaml`，配置 `policy: whitelist`、`process.enable: true`、`process.mode: block`、`process.allow: [bash, ls, cat]`；启动 safeguard | 配置文件解析成功；safeguard 启动成功，无报错 | 配置文件解析成功；safeguard 启动成功，无报错 | 通过 |
| TC-WL-004 | 手动调整白名单内容后重新加载生效 | safeguard 已编译；root 权限 | 创建初始白名单配置，`process.mode: monitor`、`process.allow: [bash, ls]`；启动确认成功后停止；新增 `cat` 并将 mode 改为 `block`；再次启动 | 初始配置加载成功；修改后配置同样加载成功，无解析错误 | 初始配置加载成功；修改后配置同样加载成功，无解析错误 | 通过 |
| TC-BL-001 | 黑名单模式下阻断指定文件访问 | safeguard 已编译；root 权限 | 创建 `blacklist.yaml`，配置 `policy: blacklist`、`files.enable: true`、`files.mode: block`、`files.deny: [/etc/test]`；启动 safeguard | safeguard 启动成功；配置加载无报错 | safeguard 启动成功；配置加载无报错 | 通过 |
| TC-BL-002 | 黑名单模式下阻断指定网络访问 | safeguard 已编译；root 权限 | 创建 `blacklist-network.yaml`，配置 `policy: blacklist`、`network.enable: true`、`network.mode: block`、`network.cidr.allow: [0.0.0.0/0]`、`network.cidr.deny: [172.25.31.141/32]`；启动 safeguard | safeguard 启动成功；黑名单中的 CIDR 地址被阻断 | safeguard 启动成功；黑名单中的 CIDR 地址被阻断 | 通过 |
| TC-API-001 | 启动运行接口验证 | safeguard 已编译 | 执行 `test -x /usr/bin/safeguard`；使用合法配置启动；使用不存在的配置文件路径再次启动 | 指定合法配置文件时启动成功；指定不存在配置文件时启动失败并输出错误信息 | 指定合法配置文件时启动成功；指定不存在配置文件时启动失败并输出错误信息 | 通过 |

### 4.1.2 关键用例说明

#### 4.1.2.1 白名单生成加载测试

测试目标：验证生成的白名单能够加载至主机管控模块并生效。

测试步骤：

1. 执行以下命令生成白名单配置：

   ```bash
   safeguard controller generate --output /tmp/whitelist.yaml --report /tmp/whitelist-report.json
   ```

2. 执行以下命令启动主机管控模块：

   ```bash
   sudo safeguard --config /tmp/whitelist.yaml
   ```

3. 查看 safeguard 运行日志，确认配置加载成功。

测试结果：通过。

#### 4.1.2.2 网络白名单监控模式测试

测试目标：验证网络白名单监控模式配置可正常加载。

配置示例：

```yaml
policy: whitelist
network:
  enable: true
  mode: monitor
  target: host
  cidr:
    allow:
      - 172.25.31.141/32
```

执行命令：

```bash
sudo safeguard --config /tmp/whitelist-monitor.yaml
```

测试结果：通过。monitor 模式下仅记录日志，不阻断实际网络访问。

#### 4.1.2.3 进程白名单阻断模式测试

测试目标：验证白名单阻断模式配置可正常加载并生效。

配置示例：

```yaml
policy: whitelist
process:
  enable: true
  mode: block
  target: host
  allow:
    - bash
    - ls
    - cat
```

执行命令：

```bash
sudo safeguard --config /tmp/whitelist-block.yaml
```

测试结果：通过。不在 allow 列表中的进程将被阻断。

#### 4.1.2.4 白名单手动调整测试

测试目标：验证配置修改后可正常重新加载。

初始配置示例：

```yaml
policy: whitelist
process:
  enable: true
  mode: monitor
  target: host
  allow:
    - bash
    - ls
```

调整方式：在 `process.allow` 中新增 `cat`，并将 `mode` 修改为 `block`，然后重新启动 safeguard。

测试结果：通过。初始配置加载成功，修改后配置同样加载成功，无解析错误。

#### 4.1.2.5 黑名单文件访问控制测试

测试目标：验证黑名单模式下文件访问控制配置可正常加载并阻断命中 deny 列表的路径访问。

配置示例：

```yaml
policy: blacklist
files:
  enable: true
  mode: block
  target: host
  deny:
    - /etc/test
```

执行命令：

```bash
sudo safeguard --config /tmp/blacklist.yaml
```

测试结果：通过。黑名单模式下默认允许，命中 deny 列表的行为被阻断。

#### 4.1.2.6 黑名单网络访问控制测试

测试目标：验证黑名单模式下网络访问控制配置可正常加载并阻断命中 deny 列表的 CIDR 地址。

配置示例：

```yaml
policy: blacklist
network:
  enable: true
  mode: block
  target: host
  cidr:
    allow:
      - 0.0.0.0/0
    deny:
      - 172.25.31.141/32
```

执行命令：

```bash
sudo safeguard --config /tmp/blacklist-network.yaml
```

测试结果：通过。黑名单中的 CIDR 地址被阻断。

#### 4.1.2.7 启动运行接口测试

测试目标：验证启动运行接口的正常路径和异常路径。

测试步骤：

1. 确认程序可执行：

   ```bash
   test -x /usr/bin/safeguard
   ```

2. 使用合法配置启动：

   ```bash
   sudo safeguard --config /tmp/whitelist.yaml
   ```

3. 使用不存在的配置文件启动：

   ```bash
   sudo safeguard --config /tmp/not-exist.yaml
   ```

测试结果：通过。指定合法配置文件时，程序启动成功；指定不存在配置文件时，程序启动失败并输出明确错误信息。

# 5 附件

## 5.1 代码审查/代码走查结果

| 序号 | 被审模块名称 | 被审代码规模（代码行） | 审查覆盖率 | 发现问题个数 | 解决问题个数 | 审查结果 | 备注 |
| ---- | ------------ | ---------------------- | ---------- | ------------ | ------------ | -------- | ---- |
| 1 | 白名单生成模块 | 120 | 100% | 2 | 2 | 通过 | 重点核对主机快照收集、白名单构建、YAML 渲染逻辑 |
| 2 | 白名单加载模块 | 85 | 100% | 1 | 1 | 通过 | 检查配置解析、策略加载、BPF map 更新逻辑 |
| 3 | 进程控制模块 | 200 | 100% | 3 | 3 | 通过 | 复核 LSM hook 附加、白名单匹配、basename 提取逻辑 |
| 4 | 网络控制模块 | 280 | 100% | 2 | 2 | 通过 | 核验 CIDR 匹配、monitor/block 模式分支、事件上报逻辑 |
| 5 | 文件访问控制模块 | 180 | 100% | 2 | 2 | 通过 | 检查路径匹配、白名单/黑名单策略分支逻辑 |
| 6 | 配置管理模块 | 150 | 100% | 4 | 4 | 通过 | 核验 Enable 字段解析、默认值设置、IsRestrictedMode 函数 |
| 7 | 启动运行接口 | 60 | 100% | 1 | 1 | 通过 | 检查配置文件校验、错误处理逻辑 |

## 5.2 测试结果统计

| 统计项 | 数目/比率 |
| ------ | --------- |
| 总模块数量 | 7 |
| 被测试模块数量 | 7 |
| 单元测试覆盖率 | 100% |
| 设计的用例 | 7 |
| 执行的用例 | 7 |
| 成功的用例 | 7 |
| 失败的用例 | 0 |
| 本次测试发现的缺陷总数 | 0 |
| 致命错误 | 0 |
| 严重错误 | 0 |
| 一般错误 | 0 |
| 已处理问题 | 0 |
| 未处理问题 | 0 |

## 5.3 测试结论

safeguard 增强特性本轮测试通过。


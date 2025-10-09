![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改描述                         | 作者      |
| ---------- | -------- | -------------------------------- | --------- |
| 2025/09/24 | v1       | openEuler 25.09 版本安全测试初版 | SPYFAMILY |
|            |          |                                  |           |

关键词： 版本安全测试 安全扫描 合规检查

摘要：本文根据 [openEuelr社区安全保障策略总纲--发布件安全保障要求](https://gitee.com/openeuler/security-committee/blob/master/security-strategy-overview.md#9-%E5%8F%91%E5%B8%83%E5%AE%89%E5%85%A8%E4%BF%9D%E9%9A%9C%E8%A6%81%E6%B1%82) 、[openEuler 版本发布网络安全质量要求](https://gitee.com/openeuler/security-committee/blob/master/docs/zh/developer-guide/SecureRelease.md) 要求的版本安全测试项目进行相关测试。记录 openEuler 25.09 版本安全测试的相关安全测试数据及安全测试结果分析。


缩略语清单：

| 缩略语 | 英文全名                            | 中文解释       |
| ------ | ----------------------------------- | -------------- |
| TM     | Threat Modeling                     | 威胁建模       |
| LTS    | Long time support                   | 长时间维护     |
| OS     | Operation System                    | 操作系统       |
| CVE    | ommon Vulnerabilities and Exposures | 公共漏洞和暴露 |



# 1     安全测试概述

根据 [openEuelr社区安全保障策略总纲--发布件安全保障要求](https://gitee.com/openeuler/security-committee/blob/master/security-strategy-overview.md#9-%E5%8F%91%E5%B8%83%E5%AE%89%E5%85%A8%E4%BF%9D%E9%9A%9C%E8%A6%81%E6%B1%82) 、[openEuler 版本发布网络安全质量要求](https://gitee.com/openeuler/security-committee/blob/master/docs/zh/developer-guide/SecureRelease.md) 要求的版本安全测试项目进行相关测试。

# 2     安全测试信息

## 2.1   安全测试轮次

| 版本名称                | 测试起始时间 | 测试结束时间 |
| ----------------------- | ------------ | ------------ |
| openEuler 25.09 (Alpha) | 2025/07/25   | 2025/08/07   |
| openEuler 25.09 (RC1)   | 2025/08/08   | 2025/08/14   |
| openEuler 25.09 (RC2)   | 2025/08/15   | 2025/08/21   |
| openEuler 25.09 (RC3)   | 2025/08/22   | 2025/08/28   |
| openEuler 25.09 (RC4)   | 2025/08/29   | 2025/09/04   |
| openEuler 25.09 (RC5)   | 2025/09/05   | 2025/09/11   |
| openEuler 25.09 (RC6)   | 2025/09/12   | 2025/09/18   |
| openEuler 25.09 (RC7)   | 2025/09/19   | 2025/09/24   |

## 2.2   版本安全测试项目

| 版本安全测试项目    | 测试范围                               | 工具                      |
| ------------------- | -------------------------------------- | ------------------------- |
| 病毒扫描            | Everything(包含BaseOS) + EPOL          | majun平台病毒扫描工具     |
| 漏洞扫描            | **非LTS版本不涉及**                    | majun平台二进制扫描工具   |
| 安全编译选项扫描    | BaseOS                                 | majun平台二进制扫描工具   |
| 安全测试基线用例    | **非LTS版本不涉及**                    | openscap、mugen           |
| 安全片段引用扫描    | openEuler社区孵化软件                  | majun平台开源合规扫描工具 |
| 开源合规License检查 | Everything(包含BaseOS) + EPOL          | sbom解析工具              |
| 软件包签名检查      | Everything(包含BaseOS) + EPOL + SOURCE | rpm签名校验               |
| ISO签名及SBOM检查   | ISO镜像                                | sbom解析工具              |



# 3     测试结论概述

openEuler 25.09 版本安全测试已完成 2.2-版本安全测试项目 的所有安全测试。测试发现问题全部已完成修复及评估，无遗留问题无风险。



## 3.1   遗留问题

| 序号 | 问题简述 | 预计完成轮次 |
| --- | ------ | ---------- |
|      |          |              |
|      |          |              |



# 4 版本安全测试详细结果

## 4.1 病毒扫描

测试内容：使用majun平台病毒扫描工具，对aarch64、x86_64架构的Everything(包含BaseOS)、EPOL所提供软件包进行病毒扫描。

测试结果：共计扫描50, 446个rpm包，未有病毒告警，无风险。

| 软件包范围              | 架构    | 扫描软件包数量 | 病毒总量 | 已修复 | 待办中 | 已挂起 |
| ----------------------- | ------- | -------------- | -------- | ------ | ------ | ------ |
| Everything (包含BaseOS) | aarch64 | 18, 464        | 0        | 0      | 0      | 0      |
| Everything (包含BaseOS) | x86_64  | 18, 592        | 0        | 0      | 0      | 0      |
| EPOL                    | aarch64 | 6, 708         | 0        | 0      | 0      | 0      |
| EPOL                    | x86_64  | 6, 682         | 0        | 0      | 0      | 0      |

## 4.2 漏洞扫描

测试内容：使用majun平台漏洞扫描工具，对aarch64、x86_64架构的BaseOS所提供软件包进行漏洞扫描。

测试结果： **非LTS版本，扫描结果已同步openEuler社区安全委员会**

| 漏洞总数 | 已修复 | 已分析 | 已挂起 | 不涉及 |
| -------- | ------ | ------ | ------ | ------ |
| -        | -      | -      | -      | -      |

## 4.3 安全编译扫描

测试说明：使用majun平台二进制扫描工具，对aarch64、x86_64架构的BaseOS所提供软件包进行安全编译选项（包括BIND_NOW、
NX、PIE、RELRO、SP、NO Rpath/Runpath、Strip）扫描。

测试结果：共计扫描5, 065个rpm包，总计问题数问题数42个（排除SP误报），所有问题均已评估或修复，无风险。

| 架构    | 扫描软件包数量 | 问题总量 | 已修复 | 待办中 | 已挂起 |
| ------- | -------------- | -------- | ------ | ------ | ------ |
| aarch64 | 2, 521         | 35       | 35     | 0      | 0      |
| x86_64  | 2, 544         | 37       | 37     | 0      | 0      |

## 4.4 安全测试基线用例

 测试说明：使用openscap、mugen对标准镜像进行用例测试。覆盖初始部署、安全访问、运行服务、日志审计等方面。

 测试结果： **非LTS版本不涉及**

### 4.4.1 openscap测试结果

| 镜像架构 | 用例数 | 问题总数 | 已修复 | 待办中 | 已挂起 |
| -------- | ------ | -------- | ------ | ------ | ------ |
| aarch64  | -      | -        | -      | -      | -      |
| x86_64   | -      | -        | -      | -      | -      |

### 4.4.2 mugen测试结果

| 镜像架构 | 用例数 | 问题总数 | 已修复 | 待办中 | 已挂起 |
| -------- | ------ | -------- | ------ | ------ | ------ |
| aarch64  | -      | -        | -      | -      | -      |
| x86_64   | -      | -        | -      | -      | -      |

## 4.5 安全片段引用扫描

测试说明：对openEuler社区孵化BaseOS范围内软件包仓库使用majun平台开源合规扫描工具进行扫描

 测试结果：共计扫描仓库97个，新增问题758个，所有问题均已评估或修复，无风险。

| 序号 | 仓库范围                      | 新增问题数量 | 总问题数量 | 已完成数量 | 待办中 | 已挂起 |
| ---- | ----------------------------- | ------------ | ---------- | ---------- | ------ | ------ |
| 1    | A-FOT                         | 1            | 1          | 1          | 0      | 0      |
| 2    | A-guard                       | 0            | 4          | 4          | 0      | 0      |
| 3    | AI4C                          | 0            | 8672       | 8672       | 0      | 0      |
| 4    | ANNC                          | 0            | 12         | 12         | 0      | 0      |
| 5    | A-Ops                         | 0            | 0          | 0          | 0      | 0      |
| 6    | aops-apollo                   | 0            | 0          | 0          | 0      | 0      |
| 7    | aops-ceres                    | 0            | 0          | 0          | 0      | 0      |
| 8    | aops-cobbler                  | 0            | 0          | 0          | 0      | 0      |
| 9    | aops-diana                    | 0            | 0          | 0          | 0      | 0      |
| 10   | aops-hermes                   | 0            | 1          | 1          | 0      | 0      |
| 11   | aops-vulcanus                 | 0            | 0          | 0          | 0      | 0      |
| 12   | aops-zeus                     | 0            | 0          | 0          | 0      | 0      |
| 13   | A-Tune                        | 0            | 748        | 748        | 0      | 0      |
| 14   | A-Tune-BPF-Collection         | 0            | 0          | 0          | 0      | 0      |
| 15   | A-Tune-Collector              | 0            | 35         | 35         | 0      | 0      |
| 16   | A-Tune-UI                     | 1            | 14         | 14         | 0      | 0      |
| 17   | BiSheng-Adoptium              | 0            | 0          | 0          | 0      | 0      |
| 18   | BiSheng-Autotuner             | 0            | 1          | 1          | 0      | 0      |
| 19   | BiShengCLanguage              | 0            | 0          | 0          | 0      | 0      |
| 20   | bishengjdk-11                 | 0            | 21724      | 21724      | 0      | 0      |
| 21   | bishengjdk-17                 | 0            | 20143      | 20143      | 0      | 0      |
| 22   | bishengjdk-21                 | 0            | 21266      | 21266      | 0      | 0      |
| 23   | bishengjdk-8                  | 0            | 22393      | 22393      | 0      | 0      |
| 24   | bishengjdk-build              | 0            | 2          | 2          | 0      | 0      |
| 25   | bishengjdk-riscv              | 0            | 20507      | 20507      | 0      | 0      |
| 26   | bishengjdk-test               | 705          | 14462      | 14462      | 0      | 0      |
| 27   | clibcni                       | 0            | 0          | 0          | 0      | 0      |
| 28   | compass-ci-web                | 0            | 0          | 0          | 0      | 0      |
| 29   | cve-manager                   | 0            | 19         | 19         | 0      | 0      |
| 30   | devstation-config             | 0            | 0          | 0          | 0      | 0      |
| 31   | D-FOT                         | 0            | 1          | 1          | 0      | 0      |
| 32   | eagle                         | 0            | 2          | 2          | 0      | 0      |
| 33   | EulerCopilot                  | 0            | 0          | 0          | 0      | 0      |
| 34   | euler-copilot-framework       | 0            | 2          | 2          | 0      | 0      |
| 35   | euler-copilot-rag             | 3            | 13         | 13         | 0      | 0      |
| 36   | euler-copilot-shell           | 0            | 0          | 0          | 0      | 0      |
| 37   | euler-copilot-vectorize-agent | 1            | 3          | 3          | 0      | 0      |
| 38   | euler-copilot-web             | 0            | 3          | 3          | 0      | 0      |
| 39   | euler-copilot-witchaind-web   | 0            | 1          | 1          | 0      | 0      |
| 40   | gala-anteater                 | 0            | 0          | 0          | 0      | 0      |
| 41   | gala-docs                     | 0            | 0          | 0          | 0      | 0      |
| 42   | gala-gopher                   | 0            | 0          | 0          | 0      | 0      |
| 43   | gala-ragdoll                  | 0            | 2          | 2          | 0      | 0      |
| 44   | gala-spider                   | 0            | 0          | 0          | 0      | 0      |
| 45   | gazelle                       | 0            | 0          | 0          | 0      | 0      |
| 46   | gcc-for-openEuler             | 0            | 0          | 0          | 0      | 0      |
| 47   | isula-build                   | 0            | 2621       | 2621       | 0      | 0      |
| 48   | iSulad                        | 0            | 3          | 3          | 0      | 0      |
| 49   | iSulad-img                    | 0            | 1511       | 1511       | 0      | 0      |
| 50   | isula-rust-extensions         | 0            | 13         | 13         | 0      | 0      |
| 51   | isula-transform               | 0            | 704        | 704        | 0      | 0      |
| 52   | KubeOS                        | 0            | 3353       | 3353       | 0      | 0      |
| 53   | lcr                           | 2            | 6          | 6          | 0      | 0      |
| 54   | libkae                        | 0            | 49         | 49         | 0      | 0      |
| 55   | lib-shim-v2                   | 0            | 21         | 21         | 0      | 0      |
| 56   | lxcfs-tools                   | 0            | 586        | 586        | 0      | 0      |
| 57   | mcp-self-service-vue          | 0            | 23         | 23         | 0      | 0      |
| 58   | mcp-servers                   | 0            | 15         | 15         | 0      | 0      |
| 59   | mcp-vue                       | 0            | 12         | 12         | 0      | 0      |
| 60   | numafast                      | 0            | 0          | 0          | 0      | 0      |
| 61   | oeAware-collector             | 1            | 1          | 1          | 0      | 0      |
| 62   | oeAware-manager               | 0            | 0          | 0          | 0      | 0      |
| 63   | oeAware-scenario              | 0            | 0          | 0          | 0      | 0      |
| 64   | oeAware-tune                  | 0            | 0          | 0          | 0      | 0      |
| 65   | oec-application               | 0            | 12         | 12         | 0      | 0      |
| 66   | oeDeploy                      | 0            | 8          | 8          | 0      | 0      |
| 67   | oeDevPlugin                   | 0            | 13         | 13         | 0      | 0      |
| 68   | oeGitExt                      | 0            | 0          | 0          | 0      | 0      |
| 69   | openEuler_chroot              | 0            | 0          | 0          | 0      | 0      |
| 70   | openEuler-Advisor             | 0            | 3          | 3          | 0      | 0      |
| 71   | openeuler-docker-images       | 20           | 174        | 174        | 0      | 0      |
| 72   | openeuler-jenkins             | 0            | 6          | 6          | 0      | 0      |
| 73   | openEuler-lsb                 | 0            | 0          | 0          | 0      | 0      |
| 74   | openEuler-menus               | 0            | 8          | 8          | 0      | 0      |
| 75   | openeuler-obs                 | 3            | 5          | 5          | 0      | 0      |
| 76   | openeuler-os-build            | 7            | 35         | 35         | 0      | 0      |
| 77   | openEuler-portal              | 0            | 0          | 0          | 0      | 0      |
| 78   | openEuler-rpm-config          | 2            | 10         | 10         | 0      | 0      |
| 79   | openeuler-upgrader            | 0            | 0          | 0          | 0      | 0      |
| 80   | pin-for-openEuler             | 0            | 6          | 6          | 0      | 0      |
| 81   | pin-gcc-client                | 0            | 0          | 0          | 0      | 0      |
| 82   | pin-server                    | 0            | 0          | 0          | 0      | 0      |
| 83   | pkgship                       | 0            | 2          | 2          | 0      | 0      |
| 84   | powerapi                      | 0            | 1          | 1          | 0      | 0      |
| 85   | prefetch_tuning               | 0            | 0          | 0          | 0      | 0      |
| 86   | qemu                          | 0            | 5724       | 5724       | 0      | 0      |
| 87   | radiaTest                     | 2            | 26         | 26         | 0      | 0      |
| 88   | sdma-dk                       | 0            | 0          | 0          | 0      | 0      |
| 89   | secGear                       | 0            | 47         | 47         | 0      | 0      |
| 90   | security-tool                 | 0            | 0          | 0          | 0      | 0      |
| 91   | stratovirt                    | 0            | 0          | 0          | 0      | 0      |
| 92   | syscare                       | 0            | 0          | 0          | 0      | 0      |
| 93   | syscontainer-tools            | 0            | 634        | 634        | 0      | 0      |
| 94   | sysHAX                        | 1            | 1          | 1          | 0      | 0      |
| 95   | sysmaster                     | 9            | 135        | 135        | 0      | 0      |
| 96   | sysmonitor                    | 0            | 0          | 0          | 0      | 0      |
| 97   | UNT                           | 0            | 0          | 0          | 0      | 0      |

## 4.6 开源软件License合规检查

测试说明：对于Everything (包含BaseOS)、EPOL提供的软件包，根据SBOM文件扫描License合规情况。

 测试结果：共计扫描软件包50, 446个，发现问题38个，已完成38个。所有问题均已完成修复或评估，无风险。

| 软件包范围              | 扫描软件包数量 | 发现问题数量 | 已完成数量 | 待办中 | 已挂起 |
| ----------------------- | -------------- | ------------ | ---------- | ------ | ------ |
| Everything (包含BaseOS) | 37, 056        | 36           | 36         | 0      | 0      |
| EPOL                    | 13, 390        | 2            | 2          | 0      | 0      |

## 4.7 软件包签名检查

测试说明：对于Everything (包含BaseOS)、EPOL提供的软件包，使用rpm工具进行签名校验

 测试结果：共计验证56, 903个rpm包，均通过签名检查

| 软件包范围              | 架构       | 扫描软件包数量 | 通过签名检查 | 未通过签名检查 |
| ----------------------- | ---------- | -------------- | ------------ | -------------- |
| Everything (包含BaseOS) | aarch64    | 18, 464        | 18, 464      | 0              |
| Everything (包含BaseOS) | x86_64     | 18, 592        | 18, 592      | 0              |
| EPOL                    | aarch64    | 6, 708         | 6, 708       | 0              |
| EPOL                    | x86_64     | 6, 682         | 6, 682       | 0              |
| SOURCE                  | Everything | 4, 615         | 4, 615       | 0              |
| SOURCE                  | EPOL       | 1, 842         | 1, 842       | 0              |



## 4.8 ISO签名及SBOM检查

测试说明：版本发布后对应的ISO镜像存在sha256sum签名文件、SBOM文件、SBOM文件签名

 测试结果：aarch64、x86_64架构的iso镜像均有sha256sum签名文件，且对应架构Everything镜像存在SBOM文件及其签名。无问题。

| 名称                                                         | 架构    | sha256sum | SBOM | SBOM签名 |
| ------------------------------------------------------------ | ------- | --------- | ---- | -------- |
| [openEuler-25.09-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-25.09/ISO/aarch64/openEuler-25.09-aarch64-dvd.iso) | aarch64 | 是        | -    | -        |
| [openEuler-25.09-everything-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-25.09/ISO/aarch64/openEuler-25.09-everything-aarch64-dvd.iso) | aarch64 | 是        | 是   | 是       |
| [openEuler-25.09-everything-debug-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-25.09/ISO/aarch64/openEuler-25.09-everything-debug-aarch64-dvd.iso) | aarch64 | 是        | -    | -        |
| [openEuler-25.09-netinst-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-25.09/ISO/aarch64/openEuler-25.09-netinst-aarch64-dvd.iso) | aarch64 | 是        | -    | -        |
| [openEuler-25.09-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-25.09/ISO/x86_64/openEuler-25.09-x86_64-dvd.iso) | x86_64  | 是        | -    | -        |
| [openEuler-25.09-everything-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-25.09/ISO/x86_64/openEuler-25.09-everything-x86_64-dvd.iso) | x86_64  | 是        | 是   | 是       |
| [openEuler-25.09-everything-debug-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-25.09/ISO/x86_64/openEuler-25.09-everything-debug-x86_64-dvd.iso) | x86_64  | 是        | -    | -        |
| [openEuler-25.09-netinst-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-25.09/ISO/x86_64/openEuler-25.09-netinst-x86_64-dvd.iso) | x86_64  | 是        | -    | -        |
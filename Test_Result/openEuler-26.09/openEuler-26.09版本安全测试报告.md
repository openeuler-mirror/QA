# openEuler-26.09 版本安全测试报告

![avatar](assets/openEuler-20260609100205-ipymvnz.png)

版权所有 © 2023 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改描述                               | 作者      |
| ---------- | -------- | -------------------------------------- | --------- |
| 2026/09/15 | v1       | openEuler-26.09 版本安全测试初版       | SPYFAMILY |
| 2026/10/08 | v2       | openEuler-26.09 版本安全测试发布件检查 | SPYFAMILY |

关键词： 版本安全测试 安全扫描 合规检查

摘要：本文根据 [openEuler社区安全保障策略总纲--发布件安全保障要求](https://atomgit.com/openeuler/security-committee/blob/master/security-strategy-overview.md#9-%E5%8F%91%E5%B8%83%E5%AE%89%E5%85%A8%E4%BF%9D%E9%9A%9C%E8%A6%81%E6%B1%82) 、[版本发布网络安全质量要求](https://atomgit.com/openeuler/security-committee/blob/master/docs/zh/developer-guide/SecureRelease.md) 要求的版本安全测试项目进行相关测试。记录 openEuler-26.09 版本安全测试的相关安全测试数据及安全测试结果分析。

缩略语清单：

| 缩略语 | 英文全名                            | 中文解释       |
| ------ | ----------------------------------- | -------------- |
| TM     | Threat Modeling                     | 威胁建模       |
| LTS    | Long time support                   | 长时间维护     |
| OS     | Operation System                    | 操作系统       |
| CVE    | Common Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 1 安全测试概述

根据 [openEuler社区安全保障策略总纲--发布件安全保障要求](https://atomgit.com/openeuler/security-committee/blob/master/security-strategy-overview.md#9-%E5%8F%91%E5%B8%83%E5%AE%89%E5%85%A8%E4%BF%9D%E9%9A%9C%E8%A6%81%E6%B1%82) 、[版本发布网络安全质量要求](https://atomgit.com/openeuler/security-committee/blob/master/docs/zh/developer-guide/SecureRelease.md) 要求的版本安全测试项目进行相关测试。

# 2 安全测试信息

## 2.1 安全测试轮次

| 版本名称                      | 测试起始时间 | 测试结束时间 |
| ----------------------------- | ------------ | ------------ |
| openEuler-26.09 (Alpha)       | 2026/08/07   | 2026/08/13   |
| openEuler-26.09 (Round1)      | 2026/08/14   | 2026/08/20   |
| openEuler-26.09 (Round2/Beta) | 2026/08/21   | 2026/08/27   |
| openEuler-26.09 (Round3)      | 2026/08/28   | 2026/09/03   |
| openEuler-26.09 (Round4)      | 2026/09/04   | 2026/09/10   |
| openEuler-26.09 (Round5)      | 2026/09/11   | 2026/09/17   |
| openEuler-26.09 (Round6)      | 2026/09/18   | 2026/09/23   |

测试轮次时间及各轮次PR截止时间参照 [openEuler-26.09 发布计划](https://atomgit.com/openeuler/release-management/blob/master/openEuler-26.09/release-plan.zh.md)。

## 2.2 版本安全测试项目

| 版本安全测试项目    | 测试范围                               | 工具                       |
| ------------------- | -------------------------------------- | -------------------------- |
| 病毒扫描            | Everything(包含BaseOS) + EPOL          | openlibing病毒扫描工具     |
| 安全编译选项扫描    | BaseOS                                 | openlibing二进制扫描工具   |
| 安全测试基线用例    | Everything(包含BaseOS) + EPOL          | openscap、mugen            |
| 安全片段引用扫描    | openEuler社区孵化软件                  | openlibing开源合规扫描工具 |
| 开源合规License检查 | Everything(包含BaseOS) + EPOL          | openEuler 貂蝉License检查  |
| 软件包签名检查      | Everything(包含BaseOS) + EPOL + SOURCE | rpm签名校验                |
| ISO签名及SBOM检查   | ISO镜像                                | sbom解析工具               |

# 3 测试结论概述

openEuler-26.09 版本安全测试已完成 2.2-版本安全测试项目 的所有安全测试。测试发现问题均已完成修复及评估，无遗留问题无风险。

## 3.1 遗留问题

无

# 4 版本安全测试详细结果

## 4.1 病毒扫描

测试内容：使用openlibing平台病毒扫描工具，对aarch64、x86_64架构的Everything(包含BaseOS)、EPOL所提供软件包、源码包进行病毒扫描。

测试结果：共计扫描55,124个rpm包（Everything(包含BaseOS) 35,375个、EPOL 13,677个、SOURCE 6,072个）。经3种病毒扫描引擎扫描，仅1种病毒引擎存在告警一项，病毒类型：PUP.Netcat，病毒文件指向nmap的/usr/bin/ncat。经病毒引擎提供方确认，网络扫描工具视为潜在有害程序进行默认进行告警，经openEuler安委会评审无安全风险。

| 软件包范围              | 架构       | 扫描软件包数量 | 病毒总量 | 已修复 | 待办中 | 已挂起 |
| ----------------------- | ---------- | -------------- | -------- | ------ | ------ | ------ |
| Everything (包含BaseOS) | aarch64    | 17,632         | 1        | 1      | 0      | 0      |
| Everything (包含BaseOS) | x86_64     | 17,743         | 1        | 1      | 0      | 0      |
| EPOL                    | aarch64    | 6,851          | 0        | 0      | 0      | 0      |
| EPOL                    | x86_64     | 6,826          | 0        | 0      | 0      | 0      |
| SOURCE                  | Everything | 4,211          | 0        | 0      | 0      | 0      |
| SOURCE                  | EPOL       | 1,861          | 0        | 0      | 0      | 0      |
| 合计                    |            | 55,124         | 2        | 2      | 0      | 0      |

## 4.2 漏洞扫描

测试说明：openEuler-26.09 为创新版本，漏洞扫描不作为版本安全测试项。

## 4.3 安全编译扫描

测试说明：使用openlibing平台二进制扫描工具，对aarch64、x86_64架构的BaseOS所提供软件包进行安全编译选项（包括BIND_NOW、NX、PIE、RELRO、SP、NO Rpath/Runpath、Strip）扫描。

测试结果：共计扫描5,107个rpm包（aarch64 2,545个、x86_64 2,562个），发现问题12个（aarch64 10个、x86_64 2个），均已闭环，无风险。

| 架构    | 扫描软件包数量 | 问题总量 | 已修复 | 待办中 | 已挂起 |
| ------- | -------------- | -------- | ------ | ------ | ------ |
| aarch64 | 2,545          | 10       | 10     | 0      | 0      |
| x86_64  | 2,562          | 2        | 2      | 0      | 0      |
| 合计    | 5,107          | 12       | 12     | 0      | 0      |

## 4.4 安全测试基线用例

测试说明：使用openscap、mugen对标准镜像进行用例测试。覆盖初始部署、安全访问、运行服务、日志审计等方面。

测试结果：mugen用例测试在aarch64与x86_64上分别执行security_guide 49个、security_test 71个用例，用例数及通过数与上一版本保持一致，无遗留问题无风险。openscap为创新版本已评审通过，无需测试。

### 4.4.1 openscap测试结果

openEuler-26.09为创新版本，openscap安全基线已评审通过，无需测试。

### 4.4.2 mugen测试结果

| 镜像架构 | 测试套         | 用例数 | 问题总数 | 已修复 | 待办中 | 已挂起 |
| -------- | -------------- | ------ | -------- | ------ | ------ | ------ |
| aarch64  | security_guide | 49     | 0        | 0      | 0      | 0      |
| aarch64  | security_test  | 71     | 0        | 0      | 0      | 0      |
| x86_64   | security_guide | 49     | 0        | 0      | 0      | 0      |
| x86_64   | security_test  | 71     | 0        | 0      | 0      | 0      |

## 4.5 安全片段引用扫描

测试说明：对openEuler社区孵化软件包仓库使用openlibing平台开源合规扫描工具进行扫描

测试结果：共计扫描代码仓118个，待处理风险数均已清零。

| 序号 | 代码仓                        | 新增处理风险数 | 风险数 | 待处理风险数 | 已处理风险数 |
| ---- | ----------------------------- | -------------- | ------ | ------------ | ------------ |
| 1    | krun                          | 0              | 3      | 0            | 3            |
| 2    | ubs-mem                       | 0              | 7      | 0            | 7            |
| 3    | ubs-comm                      | 0              | 19     | 0            | 19           |
| 4    | ubs-io                        | 0              | 6      | 0            | 6            |
| 5    | ham                           | 0              | 0      | 0            | 0            |
| 6    | ubturbo                       | 0              | 20     | 0            | 20           |
| 7    | ubs-engine                    | 0              | 346    | 0            | 346          |
| 8    | ubs-virt                      | 0              | 0      | 0            | 0            |
| 9    | KubeOS                        | 1              | 4260   | 0            | 4260         |
| 10   | libvirt                       | 564            | 1005   | 0            | 1005         |
| 11   | qemu                          | 0              | 5720   | 0            | 5720         |
| 12   | umdk                          | 10             | 229    | 0            | 229          |
| 13   | itrustee_sdk                  | 0              | 275    | 0            | 275          |
| 14   | ubs-atomic                    | 0              | 0      | 0            | 0            |
| 15   | VMAnalyzer                    | 0              | 0      | 0            | 0            |
| 16   | virtCCA_driver                | 0              | 0      | 0            | 0            |
| 17   | UNT                           | 0              | 0      | 0            | 0            |
| 18   | ummu                          | 0              | 0      | 0            | 0            |
| 19   | ubctl                         | 0              | 0      | 0            | 0            |
| 20   | sysSentry                     | 0              | 1      | 0            | 1            |
| 21   | syscare                       | 0              | 0      | 0            | 0            |
| 22   | sdma-dk                       | 0              | 0      | 0            | 0            |
| 23   | prefetch_tuning               | 0              | 0      | 0            | 0            |
| 24   | powerapi                      | 0              | 0      | 0            | 0            |
| 25   | pin-for-openEuler             | 0              | 0      | 0            | 0            |
| 26   | oeGitExt                      | 0              | 0      | 0            | 0            |
| 27   | oeAware-scenario              | 0              | 0      | 0            | 0            |
| 28   | oeAware-manager               | 0              | 1      | 0            | 1            |
| 29   | oeAware-collector             | 0              | 0      | 0            | 0            |
| 30   | obmm                          | 0              | 0      | 0            | 0            |
| 31   | mem_hot                       | 0              | 0      | 0            | 0            |
| 32   | lib-shim-v2                   | 0              | 35     | 0            | 35           |
| 33   | iSulad                        | 3              | 10     | 0            | 10           |
| 34   | gcc-for-openEuler             | 0              | 0      | 0            | 0            |
| 35   | gala-docs                     | 0              | 0      | 0            | 0            |
| 36   | euler-copilot-witchaind-web   | 0              | 0      | 0            | 0            |
| 37   | EulerCopilot                  | 0              | 0      | 0            | 0            |
| 38   | eagle                         | 0              | 0      | 0            | 0            |
| 39   | D-FOT                         | 0              | 0      | 0            | 0            |
| 40   | clibcni                       | 4              | 4      | 0            | 4            |
| 41   | cache_tuner                   | 0              | 0      | 0            | 0            |
| 42   | A-Tune-Collector              | 0              | 0      | 0            | 0            |
| 43   | A-Tune-BPF-Collection         | 0              | 0      | 0            | 0            |
| 44   | aops-vulcanus                 | 0              | 0      | 0            | 0            |
| 45   | aops-cobbler                  | 0              | 0      | 0            | 0            |
| 46   | llvm-project                  | 0              | 93160  | 0            | 93160        |
| 47   | ubutils                       | 0              | 0      | 0            | 0            |
| 48   | openEuler-Advisor             | 0              | 24     | 0            | 24           |
| 49   | sysmonitor                    | 0              | 0      | 0            | 0            |
| 50   | BiSheng-Autotuner             | 0              | 2      | 0            | 2            |
| 51   | isula-rust-extensions         | 0              | 17     | 0            | 17           |
| 52   | openEuler-lsb                 | 0              | 0      | 0            | 0            |
| 53   | AI4C                          | 0              | 21248  | 0            | 21248        |
| 54   | bishengjdk-8                  | 0              | 46487  | 0            | 46487        |
| 55   | bishengjdk-21                 | 12             | 61627  | 0            | 61627        |
| 56   | bishengjdk-17                 | 32             | 59143  | 0            | 59143        |
| 57   | bishengjdk-11                 | 2497           | 64449  | 0            | 64449        |
| 58   | witty-service                 | 0              | 194    | 0            | 194          |
| 59   | witty-framework               | 69             | 678    | 0            | 678          |
| 60   | uwal                          | 0              | 0      | 0            | 0            |
| 61   | ubs-core                      | 0              | 0      | 0            | 0            |
| 62   | sysHAX                        | 0              | 0      | 0            | 0            |
| 63   | security-tool                 | 3              | 5      | 0            | 5            |
| 64   | polymind                      | 0              | 197    | 0            | 197          |
| 65   | pin-server                    | 0              | 0      | 0            | 0            |
| 66   | pin-gcc-client                | 0              | 1      | 0            | 1            |
| 67   | openEuler-menus               | 0              | 11     | 0            | 11           |
| 68   | openEuler_chroot              | 0              | 0      | 0            | 0            |
| 69   | oeDevPlugin                   | 0              | 1      | 0            | 1            |
| 70   | oeDeploy                      | 1              | 4      | 0            | 4            |
| 71   | numafast                      | 0              | 0      | 0            | 0            |
| 72   | mcp-vue                       | 0              | 22     | 0            | 22           |
| 73   | mcp-testkit                   | 0              | 8      | 0            | 8            |
| 74   | mcp-servers                   | 2              | 3      | 0            | 3            |
| 75   | heolleo                       | 5              | 58     | 0            | 58           |
| 76   | HDagger                       | 0              | 0      | 0            | 0            |
| 77   | euler-copilot-web             | 0              | 3      | 0            | 3            |
| 78   | euler-copilot-vectorize-agent | 0              | 5      | 0            | 5            |
| 79   | euler-copilot-shell           | 0              | 3      | 0            | 3            |
| 80   | euler-copilot-rag             | 0              | 13     | 0            | 13           |
| 81   | euler-copilot-framework       | 0              | 4      | 0            | 4            |
| 82   | ccb                           | 0              | 3      | 0            | 3            |
| 83   | virtCCA_sdk                   | 6              | 2870   | 0            | 2870         |
| 84   | sysmaster                     | 0              | 301    | 0            | 301          |
| 85   | syscontainer-tools            | 2              | 838    | 0            | 838          |
| 86   | stratovirt                    | 12             | 73     | 0            | 73           |
| 87   | secGear                       | 0              | 21     | 0            | 21           |
| 88   | pkgship                       | 0              | 5      | 0            | 5            |
| 89   | openEuler-rpm-config          | 0              | 2      | 0            | 2            |
| 90   | oemaker                       | 0              | 28     | 0            | 28           |
| 91   | oeAware-tune                  | 0              | 1      | 0            | 1            |
| 92   | memlink                       | 0              | 0      | 0            | 0            |
| 93   | lxcfs-tools                   | 2              | 738    | 0            | 738          |
| 94   | libkae                        | 10             | 74     | 0            | 74           |
| 95   | lcr                           | 0              | 6      | 0            | 6            |
| 96   | kunpengsecl                   | 0              | 249    | 0            | 249          |
| 97   | knet                          | 0              | 0      | 0            | 0            |
| 98   | isula-transform               | 0              | 1084   | 0            | 1084         |
| 99   | iSulad-img                    | 0              | 2312   | 0            | 2312         |
| 100  | isula-build                   | 49             | 4749   | 0            | 4749         |
| 101  | hikptool                      | 7              | 9      | 0            | 9            |
| 102  | gazelle                       | 0              | 1      | 0            | 1            |
| 103  | gala-spider                   | 0              | 6      | 0            | 6            |
| 104  | gala-ragdoll                  | 0              | 3      | 0            | 3            |
| 105  | gala-gopher                   | 0              | 13     | 0            | 13           |
| 106  | gala-anteater                 | 0              | 7      | 0            | 7            |
| 107  | devstation-config             | 0              | 0      | 0            | 0            |
| 108  | A-Tune-UI                     | 0              | 23     | 0            | 23           |
| 109  | A-Tune                        | 0              | 1026   | 0            | 1026         |
| 110  | aops-zeus                     | 0              | 6      | 0            | 6            |
| 111  | aops-hermes                   | 0              | 2      | 0            | 2            |
| 112  | aops-diana                    | 0              | 3      | 0            | 3            |
| 113  | aops-ceres                    | 0              | 10     | 0            | 10           |
| 114  | aops-apollo                   | 0              | 8      | 0            | 8            |
| 115  | A-Ops                         | 0              | 0      | 0            | 0            |
| 116  | ANNC                          | 573            | 575    | 0            | 575          |
| 117  | A-FOT                         | 0              | 2      | 0            | 2            |
| 118  | bishengjdk-25                 | 1458           | 62321  | 0            | 62321        |

## 4.6 开源软件License合规检查

测试说明：对于Everything (包含BaseOS)、EPOL提供的软件包，根据SBOM文件扫描License合规情况。

测试结果：共计扫描41,675个rpm包，发现问题40个（Everything 26个、EPOL 14个），闭环38个，新增2个License（均为EPOL范围）合规SIG评审已通过，无风险）。

| 软件包范围              | 扫描软件包数量 | 发现问题数量 | 已完成数量 | 待办中 | 已挂起 |
| ----------------------- | -------------- | ------------ | ---------- | ------ | ------ |
| Everything (包含BaseOS) | 27,662         | 26           | 26         | 0      | 0      |
| EPOL                    | 14,013         | 14           | 14         | 0      | 0      |
| 合计                    | 41,675         | 40           | 40         | 0      | 0      |

## 4.7 软件包签名检查

测试说明：对于Everything (包含BaseOS)、EPOL提供的软件包，使用rpm工具进行签名校验

测试结果：共计验证55,124个rpm包，均通过签名检查。

| 软件包范围              | 架构       | 扫描软件包数量 | 通过签名检查 | 未通过签名检查 |
| ----------------------- | ---------- | -------------- | ------------ | -------------- |
| Everything (包含BaseOS) | aarch64    | 17,632         | 17,632       | 0              |
| Everything (包含BaseOS) | x86_64     | 17,743         | 17,743       | 0              |
| EPOL                    | aarch64    | 6,851          | 6,851        | 0              |
| EPOL                    | x86_64     | 6,826          | 6,826        | 0              |
| SOURCE                  | Everything | 4,211          | 4,211        | 0              |
| SOURCE                  | EPOL       | 1,861          | 1,861        | 0              |
| 合计                    |            | 55,124         | 55,124       | 0              |

## 4.8 ISO签名及SBOM检查

测试说明：版本发布后对应的ISO镜像存在sha256sum签名文件，SBOM文件、SBOM文件签名

测试结果：

| 名称   | 架构    | sha256sum | SBOM | SBOM签名 |
| ------ | ------- | --------- | ---- | -------- |
| [openEuler-26.09-DevStation-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/openEuler-26.09-DevStation-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/) | 不涉及 | 不涉及 |
| [openEuler-26.09-DevStation-everything-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/openEuler-26.09-DevStation-everything-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/) | 不涉及 | 不涉及 |
| [openEuler-26.09-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/openEuler-26.09-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/) | 不涉及 | 不涉及 |
| [openEuler-26.09-everything-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/openEuler-26.09-everything-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/) | [是](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-26.09/ISOs/) | [是](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-26.09/ISOs/) |
| [openEuler-26.09-everything-debug-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/openEuler-26.09-everything-debug-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/) | 不涉及 | 不涉及 |
| [openEuler-26.09-netinst-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/openEuler-26.09-netinst-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/aarch64/) | 不涉及 | 不涉及 |
| [openEuler-26.09-DevStation-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/openEuler-26.09-DevStation-x86_64-dvd.iso) | x86_64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/) | 不涉及 | 不涉及 |
| [openEuler-26.09-DevStation-everything-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/openEuler-26.09-DevStation-everything-x86_64-dvd.iso) | x86_64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/) | 不涉及 | 不涉及 |
| [openEuler-26.09-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/openEuler-26.09-x86_64-dvd.iso) | x86_64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/) | 不涉及 | 不涉及 |
| [openEuler-26.09-everything-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/openEuler-26.09-everything-x86_64-dvd.iso) | x86_64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/) | [是](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-26.09/ISOs/) | [是](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-26.09/ISOs/) |
| [openEuler-26.09-everything-debug-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/openEuler-26.09-everything-debug-x86_64-dvd.iso) | x86_64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/) | 不涉及 | 不涉及 |
| [openEuler-26.09-netinst-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/openEuler-26.09-netinst-x86_64-dvd.iso) | x86_64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-26.09/ISO/x86_64/) | 不涉及 | 不涉及 |

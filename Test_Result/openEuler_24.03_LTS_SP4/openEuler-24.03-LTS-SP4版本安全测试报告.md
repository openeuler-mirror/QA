# openEuler-24.03-LTS-SP4版本安全测试报告

![avatar](assets/openEuler-20260609100205-ipymvnz.png)

版权所有 © 2023 openEuler社区  
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订版本 | 修改描述                                       | 作者      |
| ---------- | -------- | ---------------------------------------------- | --------- |
| 2026/06/09 | v1       | openEuler-24.03-LTS-SP4 版本安全测试初版       | SPYFAMILY |
| 2026/06/24 | v2       | openEuler-24.03-LTS-SP4 版本遗留问题闭环更新   | SPYFAMILY |
| 2026/07/02 | v3       | openEuler-24.03-LTS-SP4 版本发布件签名文件检查 | SPYFAMILY |

关键词： 版本安全测试 安全扫描 合规检查

摘要：本文根据 [openEuelr社区安全保障策略总纲--发布件安全保障要求](https://atomgit.com/openeuler/security-committee/blob/master/security-strategy-overview.md#9-%E5%8F%91%E5%B8%83%E5%AE%89%E5%85%A8%E4%BF%9D%E9%9A%9C%E8%A6%81%E6%B1%82) 、[版本发布网络安全质量要求](https://atomgit.com/openeuler/security-committee/blob/master/docs/zh/developer-guide/SecureRelease.md) 要求的版本安全测试项目进行相关测试。记录 openEuler-24.03-LTS-SP4 版本安全测试的相关安全测试数据及安全测试结果分析。

缩略语清单：

| 缩略语 | 英文全名                            | 中文解释       |
| ------ | ----------------------------------- | -------------- |
| TM     | Threat Modeling                     | 威胁建模       |
| LTS    | Long time support                   | 长时间维护     |
| OS     | Operation System                    | 操作系统       |
| CVE    | ommon Vulnerabilities and Exposures | 公共漏洞和暴露 |

# 1 安全测试概述

根据 [openEuelr社区安全保障策略总纲--发布件安全保障要求](https://atomgit.com/openeuler/security-committee/blob/master/security-strategy-overview.md#9-%E5%8F%91%E5%B8%83%E5%AE%89%E5%85%A8%E4%BF%9D%E9%9A%9C%E8%A6%81%E6%B1%82) 、[版本发布网络安全质量要求](https://atomgit.com/openeuler/security-committee/blob/master/docs/zh/developer-guide/SecureRelease.md) 要求的版本安全测试项目进行相关测试。

# 2 安全测试信息

## 2.1 安全测试轮次

| 版本名称                      | 测试起始时间 | 测试结束时间 |
| ----------------------------- | ------------ | ------------ |
| openEuler-24.03-LTS-SP4 (RC1) | 2026/4/18    | 2026/4/24    |
| openEuler-24.03-LTS-SP4 (RC2) | 2026/4/25    | 2026/5/8     |
| openEuler-24.03-LTS-SP4 (RC3) | 2026/5/9     | 2026/5/15    |
| openEuler-24.03-LTS-SP4 (RC4) | 2026/5/16    | 2026/5/22    |
| openEuler-24.03-LTS-SP4 (RC5) | 2026/5/23    | 2026/5/29    |
| openEuler-24.03-LTS-SP4 (RC6) | 2026/5/30    | 2026/6/5     |
| openEuler-24.03-LTS-SP4 (RC7) | 2026/6/6     | 2026/6/12    |
| openEuler-24.03-LTS-SP4 (RC8) | 2026/6/13    | 2026/6/18    |

## 2.2 版本安全测试项目

| 版本安全测试项目    | 测试范围                               | 工具                       |
| ------------------- | -------------------------------------- | -------------------------- |
| 病毒扫描            | Everything(包含BaseOS) + EPOL          | openlibing病毒扫描工具     |
| 漏洞扫描            | BaseOS                                 | openlibing漏洞感知系统     |
| 安全编译选项扫描    | BaseOS                                 | openlibing二进制扫描工具   |
| 安全测试基线用例    | Everything(包含BaseOS) + EPOL          | openscap、mugen            |
| 安全片段引用扫描    | openEuler社区孵化软件                  | openlibing开源合规扫描工具 |
| 开源合规License检查 | Everything(包含BaseOS) + EPOL          | openEuler 貂蝉License检查  |
| 软件包签名检查      | Everything(包含BaseOS) + EPOL + SOURCE | rpm签名校验                |
| ISO签名及SBOM检查   | ISO镜像                                | sbom解析工具               |

# 3 测试结论概述

openEuler-24.03-LTS-SP4 版本安全测试已完成【2.2-版本安全测试项目】的所有安全测试。扫描项发现问题均已完成修复与评估, 第一次评审遗留问题已闭环。

## 3.1 遗留问题

| 遗留问题                    | 预计闭环时间 | 实际闭环时间 | 闭环状态 |
| --------------------------- | ------------ | ------------ | -------- |
| 致命及高危漏洞17个修复      | 2026/06/16   | 2026/06/22   | 已完成   |
| 开源片段引用合规风险处理    | 2026/06/16   | 2026/06/16   | 已完成   |
| 已挂起漏洞更新issue评论结论 | 2026/06/24   | 2026/06/22   | 已完成   |

# 4 版本安全测试详细结果

## 4.1 病毒扫描

测试内容：使用openlibing平台病毒扫描工具，对aarch64、x86_64架构的Everything(包含BaseOS)、EPOL所提供软件包、源码包进行病毒扫描。

测试结果：共计扫描53, 065个rpm包，未有病毒告警，无风险。

| 软件包范围              | 架构       | 扫描软件包数量 | 病毒总量 | 已修复 | 待办中 | 已挂起 |
| ----------------------- | ---------- | -------------- | -------- | ------ | ------ | ------ |
| Everything (包含BaseOS) | aarch64    | 19, 015        | 0        | 0      | 0      | 0      |
| Everything (包含BaseOS) | x86_64     | 19, 084        | 0        | 0      | 0      | 0      |
| EPOL                    | aarch64    | 4, 372         | 0        | 0      | 0      | 0      |
| EPOL                    | x86_64     | 4, 347         | 0        | 0      | 0      | 0      |
| SOURCE                  | Everything | 4, 952         | 0        | 0      | 0      | 0      |
| SOURCE                  | EPOL       | 1, 295         | 0        | 0      | 0      | 0      |

## 4.2 漏洞扫描

测试内容：使用openlibing平台漏洞感知平台对BaseOS范围软件包进行评估。

测试结果：根据版本发布节奏，版本PR合入截止时间为2026/06/17，致命CVE在版本发布前仍然持续修复，CVE统计时间：2024/01/01 ~ 2026/06/14，统计范围：24.03-LTS-SPx版本。后续新增CVE在update版本修复。截至2026年6月14日，openlibing平台漏洞感知数据如下表。待办漏洞中，中低危32个，0分漏洞160个，在update版本持续修复。已挂起漏洞均为暂无解决方案或补丁，软件包维护者已确认当前版本上游暂无解决方案或补丁。

| 已拒绝漏洞总数 | 有效漏洞总数 | 已修复 | 已挂起 | 待办的 | 待分析（0分漏洞） |
| -------------- | ------------ | ------ | ------ | ------ | ----------------- |
| 2753           | 15417        | 15122  | 103    | 32     | 160               |

> [!NOTE] ✏️ 漏洞状态说明
> 已拒绝漏洞：由软件包维护者判断该CVE不属于该软件包，并评论分析相关理由，并经由commiter确认并手动拒绝CVE。
>
> 有效漏洞数：社区除去已拒绝CVE外，软件包维护者判定与软件包相关的CVE
>
> 已修复漏洞：有效漏洞内，包含软件包维护者分析软件包不受该CVE影响；已合入修复PR，正常修复的CVE
>
> 已挂起漏洞：有效漏洞内，经软件包维护者分析，当前CVE上游社区暂无解决方案或补丁
>
> 待办漏洞：有效漏洞内，经软件包维护者分析，确定应修复的，待合入修复PR的CVE; NVD已有评分，openEuler社区未分析的CVE
>
> 待分析漏洞：有效漏洞内，NVD评分为NA的，openEuler社区未分析的CVE

> [!IMPORTANT] ❗ 特别说明
> 内核存在较多仅分支源码受CVE影响的情况，实际社区构建时相关CONFIG未打开，发布二进制不受影响，均计入已修复状态。
>
> 相关修复数据由Kernel SIG提供。因此统计数据与社区issue状态存在一定差异，属正常现象。

## 4.3 安全编译扫描

测试说明：使用openlibing平台二进制扫描工具，对aarch64、x86_64架构的BaseOS所提供软件包进行安全编译选项（包括BIND_NOW、  
NX、PIE、RELRO、SP、NO Rpath/Runpath、Strip）扫描。

测试结果：共计扫描4, 917个rpm包，总计问题数问题数3个，所有问题均已评估或修复，无风险。

| 架构    | 扫描软件包数量 | 问题总量 | 已修复 | 待办中 | 已挂起 |
| ------- | -------------- | -------- | ------ | ------ | ------ |
| aarch64 | 2, 452         | 3        | 3      | 0      | 0      |
| x86_64  | 2, 465         | 0        | 0      | 0      | 0      |

## 4.4 安全测试基线用例

测试说明：使用openscap、mugen对标准镜像进行用例测试。覆盖初始部署、安全访问、运行服务、日志审计等方面。

测试结果：在aarch64与x86_64上分别测试307个用例，失败项均符合【[openEuler安全配置基线](https://gitee.com/openeuler/security-committee/blob/master/sub-projects/secure-configuration-benchmark/release/openEuler%E5%AE%89%E5%85%A8%E9%85%8D%E7%BD%AE%E5%9F%BA%E7%BA%BF.md)】的openEuler发行版本说明，无遗留问题无风险

### 4.4.1 openscap测试结果

注：存在fail和notchecked项，均已通过手工检查，未通过检查项可参照 【[openEuler安全配置基线](https://gitee.com/openeuler/security-committee/blob/master/sub-projects/secure-configuration-benchmark/release/openEuler%E5%AE%89%E5%85%A8%E9%85%8D%E7%BD%AE%E5%9F%BA%E7%BA%BF.md)】对应检查项的openEuler发行版本说明

| 镜像架构 | 用例数 | 问题总数 | 已修复 | 待办中 | 已挂起 |
| -------- | ------ | -------- | ------ | ------ | ------ |
| aarch64  | 187    | 0        | 0      | 0      | 0      |
| x86_64   | 187    | 0        | 0      | 0      | 0      |

### 4.4.2 mugen测试结果

| 镜像架构 | 测试套         | 用例数 | 问题总数 | 已修复 | 待办中 | 已挂起 |
| -------- | -------------- | ------ | -------- | ------ | ------ | ------ |
| aarch64  | security_guide | 49     | 0        | 0      | 0      | 0      |
| aarch64  | security_test  | 71     | 0        | 0      | 0      | 0      |
| x86_64   | security_guide | 49     | 0        | 0      | 0      | 0      |
| aarch64  | security_test  | 71     | 0        | 0      | 0      | 0      |

## 4.5 安全片段引用扫描

测试说明：对openEuler社区孵化软件包仓库使用openlibing平台开源合规扫描工具进行扫描

测试结果：共计扫描仓库120个。待处理风险数已全部清零。当前版本平台由mujun切换至openlibing，扫描工具及规则有变动，和历史数据存在差异属于正常现象。

| 序号 | 代码仓                        | 风险数 | 待处理风险数 | 已处理风险数 |
| ---- | ----------------------------- | ------ | ------------ | ------------ |
| 1    | krun                          | 3      | 0            | 3            |
| 2    | ubs-mem                       | 11     | 0            | 11           |
| 3    | ubs-comm                      | 20     | 0            | 20           |
| 4    | ubs-io                        | 50     | 0            | 50           |
| 5    | ham                           | 0      | 0            | 0            |
| 6    | ubturbo                       | 23     | 0            | 23           |
| 7    | ubs-engine                    | 1502   | 0            | 1502         |
| 8    | ubs-virt                      | 1      | 0            | 1            |
| 9    | KubeOS                        | 4259   | 0            | 4259         |
| 10   | libvirt                       | 441    | 0            | 441          |
| 11   | qemu                          | 5727   | 0            | 5727         |
| 12   | umdk                          | 219    | 0            | 219          |
| 13   | itrustee_sdk                  | 275    | 0            | 275          |
| 14   | ubs-atomic                    | 0      | 0            | 0            |
| 15   | VMAnalyzer                    | 0      | 0            | 0            |
| 16   | virtCCA_driver                | 0      | 0            | 0            |
| 17   | UNT                           | 0      | 0            | 0            |
| 18   | ummu                          | 2      | 0            | 2            |
| 19   | ubctl                         | 5      | 0            | 5            |
| 20   | sysSentry                     | 1      | 0            | 1            |
| 21   | syscare                       | 0      | 0            | 0            |
| 22   | sdma-dk                       | 0      | 0            | 0            |
| 23   | prefetch_tuning               | 0      | 0            | 0            |
| 24   | powerapi                      | 0      | 0            | 0            |
| 25   | pin-for-openEuler             | 0      | 0            | 0            |
| 26   | oeGitExt                      | 0      | 0            | 0            |
| 27   | oeAware-scenario              | 0      | 0            | 0            |
| 28   | oeAware-manager               | 1      | 0            | 1            |
| 29   | oeAware-collector             | 0      | 0            | 0            |
| 30   | obmm                          | 0      | 0            | 0            |
| 31   | mem_hot                       | 0      | 0            | 0            |
| 32   | lib-shim-v2                   | 35     | 0            | 35           |
| 33   | iSulad                        | 7      | 0            | 7            |
| 34   | gcc-for-openEuler             | 0      | 0            | 0            |
| 35   | gala-docs                     | 0      | 0            | 0            |
| 36   | euler-copilot-witchaind-web   | 0      | 0            | 0            |
| 37   | EulerCopilot                  | 0      | 0            | 0            |
| 38   | eagle                         | 0      | 0            | 0            |
| 39   | D-FOT                         | 0      | 0            | 0            |
| 40   | clibcni                       | 0      | 0            | 0            |
| 41   | cache_tuner                   | 0      | 0            | 0            |
| 42   | A-Tune-Collector              | 0      | 0            | 0            |
| 43   | A-Tune-BPF-Collection         | 0      | 0            | 0            |
| 44   | aops-vulcanus                 | 0      | 0            | 0            |
| 45   | aops-cobbler                  | 0      | 0            | 0            |
| 46   | llvm-project                  | 93160  | 0            | 93160        |
| 47   | ubutils                       | 0      | 0            | 0            |
| 48   | openEuler-Advisor             | 24     | 0            | 24           |
| 49   | sysmonitor                    | 0      | 0            | 0            |
| 50   | BiSheng-Autotuner             | 7      | 0            | 7            |
| 51   | isula-rust-extensions         | 17     | 0            | 17           |
| 52   | openEuler-lsb                 | 0      | 0            | 0            |
| 53   | AI4C                          | 21414  | 0            | 21414        |
| 54   | bishengjdk-8                  | 46541  | 0            | 46541        |
| 55   | bishengjdk-21                 | 61615  | 0            | 61615        |
| 56   | bishengjdk-17                 | 59111  | 0            | 59111        |
| 57   | bishengjdk-11                 | 61952  | 0            | 61952        |
| 58   | witty-service                 | 1920   | 0            | 1920         |
| 59   | witty-framework               | 609    | 0            | 609          |
| 60   | uwal                          | 0      | 0            | 0            |
| 61   | ubs-core                      | 0      | 0            | 0            |
| 62   | sysHAX                        | 0      | 0            | 0            |
| 63   | security-tool                 | 2      | 0            | 2            |
| 64   | polymind                      | 552    | 0            | 552          |
| 65   | pin-server                    | 0      | 0            | 0            |
| 66   | pin-gcc-client                | 1      | 0            | 1            |
| 67   | openEuler-menus               | 11     | 0            | 11           |
| 68   | openEuler_chroot              | 0      | 0            | 0            |
| 69   | oeDevPlugin                   | 1      | 0            | 1            |
| 70   | oeDeploy                      | 3      | 0            | 3            |
| 71   | numafast                      | 0      | 0            | 0            |
| 72   | mcp-vue                       | 22     | 0            | 22           |
| 73   | mcp-testkit                   | 10     | 0            | 10           |
| 74   | mcp-servers                   | 1      | 0            | 1            |
| 75   | mcp-self-service-vue          | 48     | 0            | 48           |
| 76   | heolleo                       | 53     | 0            | 53           |
| 77   | HDagger                       | 0      | 0            | 0            |
| 78   | euler-copilot-web             | 3      | 0            | 3            |
| 79   | euler-copilot-vectorize-agent | 5      | 0            | 5            |
| 80   | euler-copilot-shell           | 3      | 0            | 3            |
| 81   | euler-copilot-rag             | 13     | 0            | 13           |
| 82   | euler-copilot-framework       | 4      | 0            | 4            |
| 83   | ccb                           | 4      | 0            | 4            |
| 84   | yuanrong                      | 102    | 0            | 102          |
| 85   | virtCCA_sdk                   | 2864   | 0            | 2864         |
| 86   | sysmaster                     | 301    | 0            | 301          |
| 87   | syscontainer-tools            | 836    | 0            | 836          |
| 88   | stratovirt                    | 61     | 0            | 61           |
| 89   | secGear                       | 43     | 0            | 43           |
| 90   | pkgship                       | 5      | 0            | 5            |
| 91   | openEuler-rpm-config          | 10     | 0            | 10           |
| 92   | oemaker                       | 28     | 0            | 28           |
| 93   | oeAware-tune                  | 1      | 0            | 1            |
| 94   | memlink                       | 6      | 0            | 6            |
| 95   | lxcfs-tools                   | 736    | 0            | 736          |
| 96   | libkae                        | 64     | 0            | 64           |
| 97   | lcr                           | 6      | 0            | 6            |
| 98   | kunpengsecl                   | 249    | 0            | 249          |
| 99   | knet                          | 5      | 0            | 5            |
| 100  | isula-transform               | 1084   | 0            | 1084         |
| 101  | iSulad-img                    | 2312   | 0            | 2312         |
| 102  | isula-build                   | 4700   | 0            | 4700         |
| 103  | hikptool                      | 2      | 0            | 2            |
| 104  | gazelle                       | 1      | 0            | 1            |
| 105  | gala-spider                   | 6      | 0            | 6            |
| 106  | gala-ragdoll                  | 3      | 0            | 3            |
| 107  | gala-gopher                   | 15     | 0            | 15           |
| 108  | gala-anteater                 | 7      | 0            | 7            |
| 109  | devstation-config             | 0      | 0            | 0            |
| 110  | A-Tune-UI                     | 23     | 0            | 23           |
| 111  | A-Tune                        | 1026   | 0            | 1026         |
| 112  | aops-zeus                     | 6      | 0            | 6            |
| 113  | aops-hermes                   | 2      | 0            | 2            |
| 114  | aops-diana                    | 22     | 0            | 22           |
| 115  | aops-ceres                    | 10     | 0            | 10           |
| 116  | aops-apollo                   | 8      | 0            | 8            |
| 117  | A-Ops                         | 0      | 0            | 0            |
| 118  | ANNC                          | 2      | 0            | 2            |
| 119  | A-FOT                         | 3      | 0            | 3            |
| 120  | bishengjdk-25                 | 60863  | 0            | 60863        |

## 4.6 开源软件License合规检查

测试说明：对于Everything (包含BaseOS)、EPOL提供的软件包，根据SBOM文件扫描License合规情况。

测试结果：共计扫描53, 065个rpm包，发现问题6个，已完成6个。所有问题均已完成修复或评估，无风险。已通过合规SIG评审。

| 软件包范围              | 扫描软件包数量 | 发现问题数量 | 已完成数量 | 待办中 | 已挂起 |
| ----------------------- | -------------- | ------------ | ---------- | ------ | ------ |
| Everything (包含BaseOS) | 43, 051        | 6            | 6          | 0      | 0      |
| EPOL                    | 10, 014        | 0            | 0          | 0      | 0      |

## 4.7 软件包签名检查

测试说明：对于Everything (包含BaseOS)、EPOL提供的软件包，使用rpm工具进行签名校验

测试结果：共计验证53, 065个rpm包，均通过签名检查

| 软件包范围              | 架构       | 扫描软件包数量 | 通过签名检查 | 未通过签名检查 |
| ----------------------- | ---------- | -------------- | ------------ | -------------- |
| Everything (包含BaseOS) | aarch64    | 19, 015        | 19, 015      | 0              |
| Everything (包含BaseOS) | x86_64     | 19, 084        | 19, 084      | 0              |
| EPOL                    | aarch64    | 4, 372         | 4, 372       | 0              |
| EPOL                    | x86_64     | 4, 347         | 4, 347       | 0              |
| SOURCE                  | Everything | 4, 952         | 4, 952       | 0              |
| SOURCE                  | EPOL       | 1, 295         | 1, 295       | 0              |

## 4.8 ISO签名及SBOM检查

测试说明：版本发布后对应的ISO镜像存在sha256sum签名文件，SBOM文件、SBOM文件签名

测试结果：ISO镜像均存在sha256sum文件。[RPM包SBOM集合地址](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-24.03-LTS-SP4/ISOs/)，[RPM包单包SBOM地址](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-24.03-LTS-SP4/rpms/everything/)。

| 名称                                                         | 架构    | sha256sum                                                    | SBOM                                                         | SBOM签名                                                     |
| ------------------------------------------------------------ | ------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [openEuler-24.03-LTS-SP4-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/aarch64/openEuler-24.03-LTS-SP4-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/aarch64/) | 不涉及                                                       | 不涉及                                                       |
| [openEuler-24.03-LTS-SP4-everything-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/aarch64/openEuler-24.03-LTS-SP4-everything-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/aarch64/) | [是](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-24.03-LTS-SP4/ISOs/) | [是](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-24.03-LTS-SP4/ISOs/) |
| [openEuler-24.03-LTS-SP4-everything-debug-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/aarch64/openEuler-24.03-LTS-SP4-everything-debug-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/aarch64/) | 不涉及                                                       | 不涉及                                                       |
| [openEuler-24.03-LTS-SP4-netinst-aarch64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/aarch64/openEuler-24.03-LTS-SP4-netinst-aarch64-dvd.iso) | aarch64 | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/aarch64/) | 不涉及                                                       | 不涉及                                                       |
| [openEuler-24.03-LTS-SP4-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/x86_64/openEuler-24.03-LTS-SP4-x86_64-dvd.iso) | x86_64  | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/x86_64/) | 不涉及                                                       | 不涉及                                                       |
| [openEuler-24.03-LTS-SP4-everything-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/x86_64/openEuler-24.03-LTS-SP4-everything-x86_64-dvd.iso) | x86_64  | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/x86_64/) | [是](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-24.03-LTS-SP4/ISOs/) | [是](https://dl-cdn.openeuler.openatom.cn/security/data/sbom/SPDX2.2/openEuler-24.03-LTS-SP4/ISOs/) |
| [openEuler-24.03-LTS-SP4-everything-debug-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/x86_64/openEuler-24.03-LTS-SP4-everything-debug-x86_64-dvd.iso) | x86_64  | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/x86_64/) | 不涉及                                                       | 不涉及                                                       |
| [openEuler-24.03-LTS-SP4-netinst-x86_64-dvd.iso](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/x86_64/openEuler-24.03-LTS-SP4-netinst-x86_64-dvd.iso) | x86_64  | [是](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP4/ISO/x86_64/) | 不涉及                                                       | 不涉及                                                       |

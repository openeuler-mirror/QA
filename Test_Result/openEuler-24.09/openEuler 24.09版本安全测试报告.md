![avatar](../../images/openEuler.png)

版权所有 © 2024 openEuler社区 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订版本 | 修改章节 | 修改描述 |
| ---- | -------- | -------- | -------- |
|   2024/05/13   |     1.0.0     |     初稿     |     sevenjj     |
|   2024/05/30   |     1.0.1     |     刷新章节结构     |     sevenjj     |
|   2024/06/06   |     1.0.2     |   刷新章节内容     |     sevenjj     |

关键词：

安全测试 网络安全 安全加固 脆弱性
 

摘要：

本文档详细描述了安全测试人员在openEuler24.09版本安全测试工作的开展情况，对产品的安全状况进行全面的分析以及整体评估


缩略语清单：
 
| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|   TM   |            Threat Modeling            |     威胁建模       |
|  LTS   |           Long time support           |    长时间维护      |
|  OS    |           Operation System            |     操作系统       |
|  CVE   |  ommon Vulnerabilities and Exposures  |  公共漏洞和暴露    |

 



***
# 1   安全测试概述

本文档详细描述了安全测试人员在 openEuler24.09 版本安全测试工作的开展情况，对产品的安全状况进行全面的分析以及整体评估。

# 2   安全测试版本说明

本次测试主要是对 openEuler24.09 版本的安全整体情况进行评估，通过安全测试，验证产品安全质量，发现系统中存在的安全脆弱性与风险，为产品的安全提供切实的依据，推动产品完成安全问题整改，从而提高产品安全性。

描述被测对象的版本信息和测试的时间及测试轮次。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| 24.09 (RC1)  |      2024/08/13        |       2024/08/19      |
| 24.09 (RC2)  |      2024/08/20        |       2024/08/26     |
| 24.09 (RC3)  |      2024/08/29        |       2024/09/04      |
| 24.09 (RC4)  |      2024/09/05        |       2024/09/11      |
| 24.09 (RC5)  |      2024/09/12        |       2024/09/19      |

描述本次测试的测试环境（包括环境软硬件版本信息，环境组网配置信息等）。

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|   NA     |      NA      |  虚拟机  |

 描述本次测试的主要测试内容和对应工具

| 安全测试活动            | 工具 |
| ----------------------- | ---- |
| 病毒扫描                |   majun平台病毒扫描工具   |
| 安全编译选项扫描        |   majun平台二进制扫描工具   |
| 安全片段引用扫描        |   majun平台开源合规扫描工具 |
| 开源合规license检查    |         sbom解析工具        |
| 签名和完整性校验测试    |   majun平台签名校验工具     |
| SBOM校验测试            |         sbom解析工具        |



# 3   版本安全测试总体结论

24.09版本测试阶段完成了安全测试，包括病毒扫描、安全编译选项扫描（PIE、RPath、Strip）安全片段引用扫描、开源license合规检查、签名和完整性性校验、SBOM校验；测试发现的主要问题都得到了修正，回归测试结果正常。


# 4   版本详细安全测试内容

## 4.1   安全需求及功能安全测试
本次测试过程中，共覆盖了病毒扫描、安全编译选项扫描、安全片段引用扫描、开源合规license检查、签名和完整性校验、SBOM校验，其中主要问题均已解决，回归测试正常，整体质量良好，风险可控。

### 4.1.1   病毒扫描

对于产品提供的镜像中的aarch64架构与x86_64架构rpm软件包，使用majun平台病毒扫描工具进行在线扫描分析，扫描结果中未出现病毒报警，无风险。

| 软件包范围 | 架构 | 扫描软件包数量 | 发现病毒数量 | 已完成数量 | 待办中 | 已挂起 |
| ---------- | ------ | -------------- | ------------ | ---------- | ------ | ------ |
| baseos |  aarch64 |    2446      |      0       |     0      |    0   |    0   |
| baseos |  x86_64 |   2547      |      0       |     0      |    0   |    0   |
| everything |  aarch64 |    18653      |      0       |     0      |    0   |    0   |
| everything |  x86_64 |   18733      |      0       |     0      |    0   |    0   |
| EPOL       |  aarch64 |   5599       |      0       |     0      |    0   |    0   | 
| EPOL       |  x86_64 |    5577       |      0       |     0      |    0   |    0   |

### 4.1.2   安全编译选项扫描

对于产品提供的标准镜像中的aarch64架构与x86_64架构中的rpm软件包，使用majun平台二进制扫描工具扫描安全编译选项，对于baseos软件包范围内的扫描结果未实行必选安全编译选项的项进行确认(包括rpath、pie、strip)，所有问题均已修复或评估，无风险。

| 软件包范围 |  架构 |扫描软件包数量 | 问题总量 | 已修复 | 待办中 | 已挂起 |
| ---------- |----- |-------------- | ------------ | ---------- | ------ | ------ |
| baseos     |  aarch64 |    2446       |       3       |     3      |    0   |    0   |
| baseos     |  x86_64 |    2547      |       3       |     3      |    0   |    0   |

### 4.1.3   开源片段引用扫描

目前对于openeler社区孵化的baseos范围内的57个软件包仓库，使用majun平台的开源片段扫描工具扫描，对于扫描结果中识别出的片段引用进行分析，所有问题均已修复或评估，无风险。

|    仓库范围     | 发现问题数量 | 已完成数量 | 待办中 | 已挂起 | 
|  -------------  | -------------| ---------- | ------ | ------ |
|   A-FOT   |      0       |      0     |   0    |    0   |
|   A-guard   |      4       |      4     |   0    |    0   |
|   A-Ops   |      0       |      0     |   0    |    0   |
|   aops-apollo   |      0       |      0     |   0    |    0   |
|   aops-ceres   |      0       |      0     |   0    |    0   |
|   aops-diana   |      0       |      0     |   0    |    0   |
|   aops-zeus   |      14       |      14     |   0    |    0   |
|   A-Tune   |      781       |      781     |   0    |    0   |
|   A-Tune-BPF-Collection   |      0       |      0     |   0    |    0   |
|   A-Tune-Collector   |      35       |      351     |   0    |    0   |
|   A-Tune-UI   |      13       |      13     |   0    |    0   |
|   bishengjdk-11   |      60655       |      60655     |   0    |    0   |
|   bishengjdk-17   |      60588       |      60588     |   0    |    0   |
|   bishengjdk-21   |      60213       |      60213     |   0    |    0   |
|   bishengjdk-8   |      41770       |      41770     |   0    |    0   |
|   bishengjdk-build   |      2       |      2     |   0    |    0   |
|   bishengjdk-riscv   |      57629       |      57629     |   0    |    0   |
|   bishengjdk-test   |      24       |      24     |   0    |    0   |
|   cbs   |      11       |      11     |   0    |    0   |
|   clibcni   |      0       |      0     |   0    |    0   |
|   compass-ci-web   |      0       |      0     |   0    |    0   |
|   cve-manager   |      20       |      20     |   0    |    0   |
|   EulerCopilot   |      0       |      0     |   0    |    0   |
|   euler-copilot-framework   |      0       |      0     |   0    |    0   |
|   euler-copilot-rag   |      0       |      0     |   0    |    0   |
|   euler-copilot-shell   |      0       |      0     |   0    |    0   |
|   euler-copilot-vectorize-agent   |      0       |      0     |   0    |    0   |
|   euler-copilot-web   |      0       |      0     |   0    |    0   |
|   isula-build   |      2658       |      2658     |   0    |    0   |
|   iSulad   |      11       |      11     |   0    |    0   |
|   iSulad-img   |      1547       |      1547     |   0    |    0   |
|   isula-rust-extensions   |      2       |      2     |   0    |    0   |
|   isula-transform   |      741       |      741     |   0    |    0   |
|   kernel   |      53831       |      53831     |   0    |    0   |
|   KubeOS   |      4102       |      4102     |   0    |    0   |
|   lcr   |      8       |      0     |   0    |    0   |
|   libkae   |      49       |      49     |   0    |    0   |
|   lib-shim-v2   |      20       |      20     |   0    |    0   |
|   lxcfs-tools   |      621       |      621     |   0    |    0   |
|   mcp-self-service-vue   |      33       |      33     |   0    |    0   |
|   mcp-vue   |      34       |      34     |   0    |    0   |
|   oeAware-collector   |      0       |      0     |   0    |    0   |
|   oeAware-scenario   |      0       |      0     |   0    |    0   |
|   openEuler-rpm-config   |      8       |      8     |   0    |    0   |
|   PilotGo-plugin-a-tune   |      1407       |      1407     |   0    |    0   |
|   PilotGo-plugin-container   |      0       |      0     |   0    |    0   |
|   PilotGo-plugin-gala-ops   |      24       |      24     |   0    |    0   |
|   PilotGo-plugin-grafana   |      1221       |      1221     |   0    |    0   |
|   PilotGo-plugin-MFD   |      0       |      0     |   0    |    0   |
|   PilotGo-plugin-prometheus   |      1344       |      1344     |   0    |    0   |
|   PilotGo-plugin-redis   |      1559       |      1559     |   0    |    0   |
|   prefetch_tuning   |      0       |      0     |   0    |    0   |
|   qemu   |      8181       |      8181     |   0    |    0   |
|   sdma-dk   |      0       |      0     |   0    |    0   |
|   security-tool   |      0       |      0     |   0    |    0   |
|   stratovirt   |      0       |      0     |   0    |    0   |
|   syscontainer-tools   |      684       |      684     |   0    |    0   |

### 4.1.4  开源合规license检查

对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，验证了48562个rpm软件包，共有11806个rpm软件包的license不在openEuler合规license准入列表中，其中，已经审阅并评审通过11428个rpm软件包的license，剩下378个rpm软件包的license由于涉及到的license数量较多，评审时间跨度长，暂时遗留，已根据社区处理策略创建issue进行跟踪。

| 软件包范围 |  架构 |扫描软件包数量 | 发现问题数量 | 已完成数量 | 待办中 | 已挂起 |
| ---------- | ------ |-------------- | ------------ | ---------- | ------ | ------ |
| everything |  aarch64 |    18653       |      5823       |     5672      |    151   |    0   |
| everything |  x86_64 |   18733      |      5819       |     5668      |    151   |    0   | 
| EPOL       |  aarch64 |   5599       |      81       |     42      |    39   |    0   | 
| EPOL       |  x86_64 |    5577       |      83       |     46      |    37   |    0   |

### 4.1.5   签名和完整性校验

对于产品提供的镜像中的aarch64架构与x86_64架构中的所有rpm软件包，使用shell命令对69379个rpm软件包进行了签名和完整性校验，所有rpm包均有签名。
| 软件包范围| 架构 | 检查对象 | 数量 |是否提供签名 | 
| ------------ | ------------ | ---------- | ------ | ------ |
| everything | aarch64 | rpm包 | 18653 | 是 |
| everything | x86_64 | rpm包 | 18733 | 是 |
| everything | riscv64 | rpm包 | 18261 | 是 |
| EPOL | aarch64  | rpm包 | 5599 | 是 |
| EPOL | x86_64  | rpm包 | 5577 | 是 |
| EPOL | riscv64  | rpm包 | 2556 | 是 |

对于产品提供的aarch64架构、x86_64架构、riscv64架构中的所有iso镜像，9个iso镜像均具有sha256sum签名文件。
| 架构  | 名称 |是否提供签名文件 | 
| ---- | ---- | ------------ |
| aarch64 | openEuler-24.09-aarch64-dvd.isoo | 是 |
| aarch64 | openEuler-24.09-everything-aarch64-dvd.iso | 是 |
| aarch64 | openEuler-24.09-netinst-aarch64-dvd.iso | 是 |
| x86_64 | openEuler-24.09-x86_64-dvd.iso | 是 |
| x86_64 | openEuler-24.09-everything-x86_64-dvd.iso | 是 |
| x86_64 | openEuler-24.09-netinst-x86_64-dvd.iso | 是 |
| riscv64 | openEuler-24.09-riscv64-dvd.iso | 是 |
| riscv64 | openEuler-24.09-everything-riscv64-dvd.iso | 是 |
| riscv64 | openEuler-24.09-netinst-riscv64-dvd.iso | 是 |

### 4.1.6   SBOM校验

对于产品提供的aarch64架构、x86_64架构，2种架构的iso镜像均具有SBOM文件及SBOM文件签名。

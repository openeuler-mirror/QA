![avatar](../../images/openEuler.png)


版权所有 © 2026  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。


# 1     特性概述

提供OS层性能分析调优skills，TopDown性能瓶颈自动化识别

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|  openEuler 24.03-LTS-SP4   |    2026/5/23          |     2026/6/1         |
|          |              |              |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
| kvm             | 虚拟机           | arm/x86 |
| TaiShan 2280 V2 | Kunpeng-920-6426 | arm      

# 3     测试结论概述

## 3.1   测试整体结论

topDown性能瓶颈自动化分析特性，共计执行29个用例，主要覆盖了功能测试，压力场景测试，可靠性测试和资料测试。
重点覆盖AgentOS场景下，自动化数据收集分析模式下的skill对于数据级别判断，流程执行的遵从情况。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 交付件检查 | 通过 |
| 功能测试 | skill技能加载 | 通过 |
| 功能测试 | skill技能调用 | 通过 |
| 功能测试 | 静态数据收集脚本执行 | 通过|
| 功能测试 | 远程自动模式 | 通过 |
| 功能测试 | 本地数据手动模式 | 通过 |
| 场景测试 | 低负载无瓶颈场景 | 通过 |
| 场景测试 | IO压力场景-数据库写入 | 通过 |
| 场景测试 | CPU压力场景 | 通过 |
| 场景测试 | 内存压力场景 | 通过 |
| 场景测试 | 锁压力场景 | 通过 |
| 场景测试 | 网络压力场景 | 通过 |
| 资料测试 | AI静态分析资料 | 通过 |


## 3.2   约束说明

特性使用时涉及到的约束及限制条件
1、target测依赖安装系统性能分析工具，sysstat util-linux iproute bc numactl ethtool iotop strace perf net-tools
2、依赖强模型能力，推荐使用 GLM-4.7 或 Minimax-M2.7 以上能力的模型（一般需要上下文长度>80K）


## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- | 

无遗留问题


### 3.3.2 问题统计

#### 3.3.2.1 问题数量

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |    12    |  4    |  4   | 4    |   0    |
| 百分比 |    100   | 33.4% | 33.3% | 33.3% |   0% |

#### 3.3.2.2 发现问题

| 序号 | 问题单号 | 问题简述 | 优先级 | 当前状态 |
| --- | ------- | ------ | ------- | ------- |
| 1 |  https://gitcode.com/openeuler/witty-opentunex/issues/2  | skill配合xiaoo agent使用，在手动收集数据场景下，易用性差，难以复制提供的数据收集代码 | 主要 | 已解决
| 2 |  https://gitcode.com/openeuler/witty-opentunex/issues/3  | 配套phase3.1脚本在AI调用执行时提示存在截断问题 | 主要 | 已解决
| 3 |  https://gitcode.com/openeuler/witty-opentunex/issues/4  | stress-ng 内存加压场景，skill 允许AI 自行修改系统配置后收集数据 | 严重   |  已解决
| 4 |  https://gitcode.com/openeuler/witty-opentunex/issues/5  | skill rpm包中存在多余文件  | 严重 | 已解决
| 5 |  https://gitcode.com/openeuler/witty-opentunex/issues/6  | skill 规则不严谨，概率性漏触发下行子技能 | 严重 | 已解决
| 6 |  https://gitcode.com/openeuler/witty-opentunex/issues/7  | SKILL.md通过AI分析发现存在语义，逻辑缺陷，需要排查修复 | 次要 | 已解决
| 7 |  https://gitcode.com/openeuler/witty-opentunex/issues/8  | skill 可能概率性跳过phase3.2 流程 | 主要   | 已解决
| 8 |  https://gitcode.com/openeuler/witty-opentunex/issues/9  | skill 配套的数据收集脚本缺少pid防呆机制 | 次要 | 已解决
| 9 |  https://gitcode.com/openeuler/witty-opentunex/issues/10  | skill 瓶颈分析后的输出不符合模板文件 | 次要   | 已解决
| 10 |  https://gitcode.com/openeuler/witty-opentunex/issues/11  | phase 1和phase2 阶段数据收集脚本存在错误的函数使用，造成command not found错误 | 次要 | 已解决
| 11 |  https://gitcode.com/openeuler/witty-opentunex/issues/12  |  topdown skill.md中关于cross-SCCL的计算公式和phase4脚本中的实际实现不一致 | 严重 | 已解决
| 12 |  https://gitcode.com/openeuler/witty-opentunex/issues/13  |  net瓶颈数据收集概率性没有带上phase2 识别pid | 主要 | 已解决

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

不涉及

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1 | skill技能加载  | <font color=green>■</font> |   |
|2 | skill技能调用 | <font color=green>■</font> |   |
|3 | 静态数据收集脚本执行 | <font color=green>■</font> |  |
|4 | 远程自动模式 | <font color=green>■</font> |  |
|5 | 本地数据手动模式 | <font color=green>■</font> |  |
|6 | 低负载无瓶颈场景 | <font color=green>■</font>|   |
|7 | mysql io内存综合压力场景 | <font color=green>■</font> |   |
|8 | CPU压力场景 | <font color=green>■</font> |  |
|9 | 内存压力场景 | <font color=green>■</font> |   |
|10 | 锁压力场景 | <font color=green>■</font>|   |
|11 | net压力场景 | <font color=green>■</font>|  |
|12 | mysql io内存综合压力场景重复分析 | <font color=green>■</font>|  |


<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论s

Agent：兼容AgentOS和opencode

待性能分析环境：虚拟机/物理机
待性能分析环境环境架构 ：arm/x86

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

不涉及

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|  中断测试  |  任务执行过程中中断，重新命令AI执行   |    AgentOS暂不支持/opencode功能正常      |

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|  资料测试  | AI分析SKILL文件   | 通过 |

## 4.5 其他测试结论

不涉及

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| witty-opentunex-0.1.2-1  |   29   |    部分通过      |       9       |
| witty-opentunex-0.1.2-4  |   29   |    部分通过      |       3       |
| witty-opentunex-0.1.2-6  |   29   |    通过          |       0       |



## 5.2   后续测试建议

AI行为可能存在不可控情况，不同Agent，不同模型，可能分析结果存在差异。重点关注skill的执行，不会修改目标机器配置，执行流程符合skill的定义。

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 
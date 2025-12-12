![avatar](../../images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|   2025-12-02   |      1.0.0       |    openEuler-24.03-LTS-SP3版本PolyMind特性测试      |   富焘   |
|      |             |          |      |

关键词：Agent、AI助手、AI 


# 1     特性概述

DevStation增强AI助手，实现AI助手上的Agent创建与执行

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|     openEuler-24.03-LTS-SP3     |     2025-12-01         |       2025-12-09      |
|          |              |              |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|    TaiShan 200(Model 2280)      |     Kunpeng 920-4826,96核,2.6GHz         |   aarch64   |
|    虚拟机      |      Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz        |   x86_64   |

# 3     测试结论概述

## 3.1   测试整体结论

DevStation AI助手特性，共计执行21个用例，主要覆盖了功能测试和可靠性测试，发现7个问题，解决后回归通过，无遗留风险，整体质量良好

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 |   不涉及   |
| 功能测试 | 新增特性测试 |   <font color=green>■</font>   |
| 兼容性测试 |          |  不涉及    |
| DFX专项测试 | 性能测试 |  不涉及    |
| DFX专项测试 | 可靠性/韧性测试 |<font color=green>■</font> |
| DFX专项测试 | 安全测试 |  不涉及    |
| 资料测试 |         |     不涉及    |
| 其他测试 |         |     不涉及    |

## 3.2   约束说明

特性使用时涉及到的约束及限制条件

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及

### 3.3.2 问题统计

#### 3.3.2.1 问题数量

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |     7     |   0   |  2    |   4   |   1     |
| 百分比 |      100%    |   0   |   28.6%   |  57.1%    |    14.3%    |

#### 3.3.2.2 发现问题

| 序号 | 问题单号 | 问题简述 | 优先级 | 当前状态 |
| --- | ------- | ------ | ------- | ------- |
| 1 | https://gitee.com/openeuler/polymind/issues/ID9IR9  |  创建的智能体无法删除 | 次要 | 已验收   |    
| 2 | https://gitee.com/openeuler/polymind/issues/ID96OD  |  如果删除user会话中内置工具的提示词，工具调用会失败 | 主要 |  已完成  |    
| 3 | https://gitee.com/openeuler/polymind/issues/ID8ZA3  |  内置工具循环执行| 主要  |  已验收  |    
| 4 | https://gitee.com/openeuler/polymind/issues/ID9IRI  |  同一个会话二次添加智能体失败|次要 |   已验收  |  
| 5 | https://gitee.com/openeuler/polymind/issues/ID98EE  |  点击回答中的链接跳转失败|  次要  |  已验收  |  
| 6 | https://gitee.com/openeuler/polymind/issues/ID8WKJ  |  调用内置工具时，前端UI调用显示block显示异常|  次要|   已验收  |  
| 7 | https://gitee.com/openeuler/polymind/issues/ID7MV3  |  当点击智能体选择智能体时，聊天窗口没有跟着缩放| 不重要  |  已验收  |  


# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

不涉及

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1 |点击AI Script按钮，验证是否能够总结单轮会话中的关键信息，并生成快照脚本 |<font color=green>■</font> |   |
|2 |点击AI Script按钮，验证是否能够总结多轮会话中的关键信息，并生成快照脚本 |<font color=green>■</font> |   |
|3 |根据生成的脚本执行指导，验证是否可以在其他环境执行成功 |<font color=green>■</font> |   |
|4 |提供A2A Server URL，进行agent card解析，验证是否可以正常加载 |<font color=green>■</font> |   |
|5 |验证能否通过A2A Server导入第三方Agent |<font color=green>■</font> |   |
|6 |验证导入的Agent能否正常注册到工具Agent列表 |<font color=green>■</font> |   |
|7 |验证安装的Agent能否被工具调用，并正常触发 |<font color=green>■</font> |   |
|8 |验证提示词输入，能够插入到当前会话中 |<font color=green>■</font> |   |
|9 |验证能够动态添加内置工具提示词 |<font color=green>■</font> |   |
|10 |验证执行工具的思维链是否添加 |<font color=green>■</font> |   |
|11 |验证同功能的内置工具和mcp，内置工具优先级更高 |<font color=green>■</font> |   |
|12 |验证内置工具调用正常 |<font color=green>■</font> |   |
|13 |手动创建Agent，验证创建成功 |<font color=green>■</font> |   |
|14 |测试能否支持外部API、MCP工具配置 |<font color=green>■</font> |   |
|15 |测试agent的技能提示词能否点击后自动加载 |<font color=green>■</font> |   |
|16 |配置持久化测试 |<font color=green>■</font> |   |
|17 |创建相同名称Agent的处理 |<font color=green>■</font> |   |
|18 |数据一致性加测，增删改查后，前端显示刷新 |<font color=green>■</font> |   |


<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

不涉及

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论
不涉及

### 4.3.2 可靠性/韧性测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|    容错测试     |   多轮会话中，增加非相关对话来造成上下文污染，验证生成的快照脚本是否准确      |    <font color=green>■</font>      |
|    构造异常     |    测试每个必填字段为空或其它不合规场景下的错误处理     |     <font color=green>■</font>     |
|    故障注入     |    网络异常时的配置保存     |      <font color=green>■</font>    |

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论
不涉及

## 4.5 其他测试结论

不涉及

# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|   openEuler-24.03-LTS-SP3       |      21     |       21 passed       |       7       |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议


# 6     附件

 



 

 
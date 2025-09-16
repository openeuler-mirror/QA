![img](https://gitee.com/openeuler/QA/raw/79f0d49e58e0684367b8f53e9d866a01be93c4c6/images/openEuler.png)


版权所有 © 2025  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述 | 作者                   |
| ---------- | ----------- | -------- | ---------------------- |
| 2025.09.16 | 1.0         | 初稿     | 丁嘉辉 dingjiahuichina |

关键词： DevStore，软件商店，MCP，oeDeploy，部署，

摘要：这份DevStore测试报告主要涉及功能、性能、可靠性、安全、兼容性方面的测试。报告指出，总计执行测试用例184个，发现问题5个，所有问题均已修复。



# 1     特性概述

DevStore 是 openEuler 桌面版本的应用商店，是面向开发者的软件分发平台，支持MCP服务、oeDeploy 插件的检索与快捷部署功能。在 DevStation 平台上实现开箱即用。

MCP 服务一键安装：DevStore 借助 openEuler 社区丰富的软件生态，以 rpm 软件包的形式处理 MCP 运行所需的软件依赖，并通过内置的服务管理工具，在智能体应用中快速部署 MCP 服务。自动帮助用户解决软件依赖与 MCP 配置问题，大幅提升用户体验。目前已支持 80+ MCP 服务。

oeDeploy 插件快速部署：DevStore 借助 oeDeploy 工具实现主流软件的快速部署，大幅度降低开发者部署软件的时间成本。包括 Kubernetes、Kuberay、Pytorch、TenserFlow、DeepSeek 等AI 软件，EulerMaker、openEuler Intelligence 等社区工具链，以及 RagFlow、Dify、AnythingLLM 等主流的 RAG 工具。

DevStore 作为 openEuler 桌面端的软件商店，帮助开发者与初学者快速获取主流开发工具、AI 软件、MCP 服务等等，在详情页提供了丰富的用户文档与操作入口。所有复杂软件的部署操作都可以在一个操作界面完成，大幅降低学习成本、提升用户体验。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称        | 测试起始时间 | 测试结束时间 |
| --------------- | ------------ | ------------ |
| dev-store-1.0.0 | 2025.08.29   | 2025.09.04   |
| dev-store-1.0.1 | 2025.09.05   | 2025.09.11   |
| dev-store-1.0.2 | 2025.09.12   | 2025.09.16   |

描述特性测试的硬件环境信息

| 硬件型号                          | 硬件配置信息 | 备注                                                 |
| --------------------------------- | ------------ | ---------------------------------------------------- |
| 华为云虚拟机 DevStation 25.09     | x86_64 4U8G  |                                                      |
| 华为云虚拟机 DevStation 25.09     | aarch64 4U8G |                                                      |
| 华为云虚拟机 DevStation 24.03 SP2 | x86_64 4U8G  | 25.09以前的版本需要预装python3-django-rest-framework |
| 华为云虚拟机 DevStation 24.03 SP2 | aarch64 4U8G | 25.09以前的版本需要预装python3-django-rest-framework |

# 3     测试结论概述

## 3.1   测试整体结论

DevStore 软件商店特性，共计执行184个用例，覆盖功能、可靠性、性能、安全、兼容性等测试。共发现5个问题，均已解决，回归通过，无遗留风险，整体质量良好。

| 测试活动 | 测试子项 | 活动评价 |
| ------- | -------- | ------- |
| 功能测试 | 继承特性测试 | 不涉及 |
| 功能测试 | 新增特性测试 | 测试通过，预期功能全部实现 |
| 兼容性测试 | 跨OS版本测试 | 测试通过，在 24.03sp2 和 25.09 版本上运行正常 |
| DFX专项测试 | 性能测试 | 测试通过，性能符合预期 |
| DFX专项测试 | 可靠性/韧性测试 | 测试通过，压力测试下功能正常 |
| DFX专项测试 | 安全测试 | 测试通过，构造危险输入无异常、无敏感信息泄露 |
| 资料测试 |         | 不涉及 |
| 其他测试 |         | 不涉及 |

## 3.2   约束说明

DevStore 必须基于 DevStation 开展测试，通常要求规格大于4U8G。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题。

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 5        | 1    | 2    | 2    | 0      |
| 百分比 | 100%     | 20%  | 40%  | 40%  | 0      |

# 4 详细测试结论

## 4.1 功能测试
### 4.1.1 继承特性测试结论

DevStore 首次发布，不涉及继承特性

### 4.1.2 新增特性测试结论

| 用例特性             | 用例名称                                   | 测试类型 | 预置条件                                                     | 操作步骤                                                     | 预期结果                                                     | 测试结论                   |
| -------------------- | ------------------------------------------ | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------- |
| 安装部署与初始化     | 软件安装                                   | 功能     | 25.09以前的版本需要预装python3-django-rest-framework         | yum安装dev-store软件包                                       | 安装成功，应用的菜单栏中可以找到DevStore的图标               | <font color=green>■</font> |
| 安装部署与初始化     | 软件卸载                                   | 功能     | dev-store软件包已安装                                        | yum卸载dev-store软件包                                       | 卸载成功，图标消失，无文件残留                               | <font color=green>■</font> |
| 安装部署与初始化     | 服务自启动                                 | 功能     | dev-store软件包已安装                                        | systemctl status dev-store                                   | 服务已启动，且设置为自启动                                   | <font color=green>■</font> |
| 安装部署与初始化     | 服务启停                                   | 功能     | dev-store软件包已安装                                        | 反复执行：<br>systemctl stop dev-store<br>systemctl start dev-store | 服务启停正常，无报错                                         | <font color=green>■</font> |
| 安装部署与初始化     | 顶部菜单栏功能                             | 功能     | dev-store软件包已安装，打开DevStore软件页面                  | 点击用户文档、代码仓、日志等按钮                             | 跳转到正确的文档、代码仓地址，正确显示工具后台日志（当前版本允许开发文档、反馈意见的按钮不生效） | <font color=green>■</font> |
| 安装部署与初始化     | 页面尺寸调整                               | 功能     | dev-store软件包已安装，打开DevStore软件页面                  | 用鼠标反复拉扯页面边框到各种尺寸                             | 页面在一定尺寸范围内自适应，未出现页面奔溃、乱序等问题       | <font color=green>■</font> |
| 数据同步与查询       | 数据同步（正常）                           | 功能     | dev-store软件包已安装，服务启动，repo源和oeDeploy插件源正确配置，更新yum缓存，打开DevStore软件页面 | 点击右上角刷新按钮                                           | 一段时间后界面刷新，MCP和oeDeploy数量正常显示，图标、版本、简介正常显示 | <font color=green>■</font> |
| 数据同步与查询       | 数据同步（服务停止）                       | 功能     | dev-store软件包已安装，服务停止，打开DevStore软件页面        | 点击右上角刷新按钮                                           | 刷新失败，有错误弹窗提示                                     | <font color=green>■</font> |
| 数据同步与查询       | 数据同步（仅MCP服务）                      | 功能     | dev-store软件包已安装，服务启动，repo源正确配置，更新yum缓存，关闭oeDeploy插件源，打开DevStore软件页面 | 点击右上角刷新按钮                                           | 一段时间后界面刷新，MCP数量正常显示，图标、版本、简介正常显示，oeDeploy插件所有信息为空 | <font color=green>■</font> |
| 数据同步与查询       | 数据同步（仅oeDeploy插件）                 | 功能     | dev-store软件包已安装，服务启动，oeDeploy插件源正确配置，删除repo源中包含MCP的源，更新yum缓存，打开DevStore软件页面 | 点击右上角刷新按钮                                           | 一段时间后界面刷新，oeDeploy插件数量正常显示，图标、版本、简介正常显示，MCP服务所有信息为空 | <font color=green>■</font> |
| 数据同步与查询       | 排序功能                                   | 功能     | DevStore页面启动，数据同步正常                               | 在MCP和oeDeploy插件列表观察组件的排序                        | 推荐插件：字母序或者自定义排序都正确<br>最新发布：按照时间排序 | <font color=green>■</font> |
| 数据同步与查询       | 翻页功能                                   | 功能     | DevStore页面启动，数据同步正常                               | 随机翻页，随机调整每页的数量                                 | 组件罗列正常                                                 | <font color=green>■</font> |
| 数据同步与查询       | 检索功能                                   | 功能     | DevStore页面启动，数据同步正常                               | 搜索框随机输入关键词，回车                                   | 检索结果符合预期，数量正确，排序正确                         | <font color=green>■</font> |
| 数据同步与查询       | 检索重置功能                               | 功能     | DevStore页面启动，数据同步正常                               | 搜索框随机输入关键词，回车，点击X，回车                      | 检索结果重置，罗列所有组件，排序正确                         | <font color=green>■</font> |
| 数据同步与查询       | 详情页信息展示                             | 功能     | DevStore页面启动，数据同步正常                               | 随机点击进入MCP服务或者oeDeploy插件的详情页                  | 名称、标签、版本、日期、用户文档正确显示，允许少量组件的用户文档缺失（旧版本） | <font color=green>■</font> |
| MCP服务快速安装      | MCP服务一键安装                            | 功能     | DevStore页面启动，数据同步正常                               | 随机选择MCP，在详情页右侧点击安装                            | 安装成功，出现添加MCP的按钮与下拉菜单，可以通过rpm -q查询到对应的mcp-severs-xxxx软件包 | <font color=green>■</font> |
| MCP服务快速安装      | MCP服务一键卸载                            | 功能     | DevStore页面启动，数据同步正常，某个MCP软件包已安装          | 在详情页右侧底部点击卸载                                     | 卸载成功，添加MCP的按钮与下拉菜单消失，无法通过rpm -q查询到对应的mcp-severs-xxxx软件包 | <font color=green>■</font> |
| MCP服务快速安装      | MCP服务快速添加                            | 功能     | DevStore页面启动，数据同步正常，某个MCP软件包已安装          | 选择任意智能体应用，点击添加，刷新智能体应用                 | 添加成功，已添加的列表中出现对应的智能体应用名称。智能体应用成功识别到这个MCP。 | <font color=green>■</font> |
| MCP服务快速安装      | MCP服务快速删除                            | 功能     | DevStore页面启动，数据同步正常，某个MCP软件包已安装且添加到某个智能体应用 | 在已添加的列表中点击删除按钮，刷新智能体                     | 删除成功，已添加的列表中对应的智能体应用名称消失。智能体应用中对应的MCP服务消失。 | <font color=green>■</font> |
| MCP服务快速安装      | Roo Code上运行快速添加的MCP（git-mcp）     | 功能     | DevStore页面启动，数据同步正常，Roo Code配置大模型API（能力不低于DeepSeek） | 安装git-mcp的MCP服务，加到Roo Code，刷新Roo Code的MCP配置，根据用户文档，用自然语言触发git操作 | Roo Code可以根据提示完成对应的git操作（MCP执行的具体准确率不在测试用例的看护范围） | <font color=green>■</font> |
| MCP服务快速安装      | Roo Code上运行快速添加的MCP（oeDeploy）    | 功能     | DevStore页面启动，数据同步正常，Roo Code配置大模型API（能力不低于DeepSeek） | 安装oeDeploy的MCP服务，添加到Roo Code，刷新Roo Code的MCP配置，根据用户文档，用自然语言触发oeDeploy的部署操作 | Roo Code可以根据提示完成对应的oeDeploy的部署操作（MCP执行的具体准确率不在测试用例的看护范围） | <font color=green>■</font> |
| MCP服务快速安装      | Roo Code上运行快速添加的MCP（oeGitExt）    | 功能     | DevStore页面启动，数据同步正常，Roo Code配置大模型API（能力不低于DeepSeek） | 安装oeGitExt的MCP服务，添加到Roo Code，刷新Roo Code的MCP配置，根据用户文档，用自然语言完成gitee信息获取 | Roo Code可以根据提示获取gitee账号的相关信息（MCP执行的具体准确率不在测试用例的看护范围） | <font color=green>■</font> |
| MCP服务快速安装      | Roo Code上运行快速添加的MCP（rpm-builder） | 功能     | DevStore页面启动，数据同步正常，Roo Code配置大模型API（能力不低于DeepSeek） | 安装rpm-builder的MCP服务，添加到Roo Code，刷新Roo Code的MCP配置，根据用户文档，用自然语言完成基础的rpm打包 | Roo Code可以根据提示完成基础的rpm打包操作（MCP执行的具体准确率不在测试用例的看护范围） | <font color=green>■</font> |
| MCP服务快速安装      | DeepChat上运行快速添加的MCP（git-mcp）     | 功能     | DevStore页面启动，数据同步正常，DeepChat配置大模型API（能力不低于DeepSeek） | 安装git-mcp的MCP服务，加到DeepChat，刷新DeepChat的MCP配置，根据用户文档，用自然语言触发git操作 | DeepChat可以根据提示完成对应的git操作（MCP执行的具体准确率不在测试用例的看护范围） | <font color=green>■</font> |
| MCP服务快速安装      | DeepChat上运行快速添加的MCP（oeDeploy）    | 功能     | DevStore页面启动， data同步正常，DeepChat配置大模型API（能力不低于DeepSeek） | 安装oeDeploy的MCP服务，添加到DeepChat，刷新DeepChat的MCP配置，根据用户文档，用自然语言触发oeDeploy的部署操作 | DeepChat可以根据提示完成对应的oeDeploy的部署操作（MCP执行的具体准确率不在测试用例的看护范围） | <font color=green>■</font> |
| MCP服务快速安装      | DeepChat上运行快速添加的MCP（oeGitExt）    | 功能     | DevStore页面启动，数据同步正常，DeepChat配置大模型API（能力不低于DeepSeek） | 安装oeGitExt的MCP服务，添加到DeepChat，刷新DeepChat的MCP配置，根据用户文档，用自然语言完成gitee信息获取 | DeepChat可以根据提示获取gitee账号的相关信息（MCP执行的具体准确率不在测试用例的看护范围） | <font color=green>■</font> |
| MCP服务快速安装      | DeepChat上运行快速添加的MCP（rpm-builder） | 功能     | DevStore页面启动，数据同步正常，DeepChat配置大模型API（能力不低于DeepSeek） | 安装rpm-builder的MCP服务，添加到DeepChat，刷新DeepChat的MCP配置，根据用户文档，用自然语言完成基础的rpm打包 | DeepChat可以根据提示完成基础的rpm打包操作（MCP执行的具体准确率不在测试用例的看护范围） | <font color=green>■</font> |
| MCP服务快速安装      | MCP服务手动下载                            | 功能     | DevStore页面启动，数据同步正常                               | 随机进入任意MCP详情页，在命令行安装标签页中复制命令行并执行  | 安装成功，可以通过rpm -q查询到对应的mcp-severs-xxxx软件包    | <font color=green>■</font> |
| MCP服务快速安装      | MCP服务手动添加                            | 功能     | DevStore页面启动，数据同步正常，某个MCP软件包已安装          | 复制MCP的json，手动配置到任意智能体应用中                    | 配置刷新后，能被智能体应用识别                               | <font color=green>■</font> |
| MCP服务快速安装      | MCP服务状态记录                            | 功能     | DevStore页面启动，数据同步正常                               | 安装任意MCP服务，加到任意智能体应用，删除MCP配置，卸载MCP服务。在上述过程中任意步骤，退出详情页，再次进入，观察MCP服务的状态是否正确。 | MCP服务的状态自动刷新，始终保持正确                          | <font color=green>■</font> |
| oeDeploy插件快速部署 | oeDeploy插件一键下载                       | 功能     | DevStore页面启动，数据同步正常                               | 随机进入任意oeDeploy插件详情页，点击下载                     | 下载成功，页面上出现插件所支持的对应部署操作                 | <font color=green>■</font> |
| oeDeploy插件快速部署 | oeDeploy插件一键卸载                       | 功能     | DevStore页面启动，数据同步正常，某个oeDeploy插件已经下载     | 进入这个oeDeploy插件详情页，点击卸载                         | 卸载成功，页面恢复下载前的状态                               | <font color=green>■</font> |
| oeDeploy插件快速部署 | oeDeploy插件快速部署功能                   | 功能     | DevStore页面启动，数据同步正常，某个oeDeploy插件已经下载     | 点击任意部署操作                                             | 部署操作触发（部署操作是否执行成功不在本用例看护范围）       | <font color=green>■</font> |
| oeDeploy插件快速部署 | oeDeploy插件部署过程日志刷新               | 功能     | DevStore页面启动，数据同步正常，某个oeDeploy插件已经下载     | 点击任意部署操作，点击查看日志                               | 日志随着部署操作的进行不断刷新，并可查看历史记录             | <font color=green>■</font> |
| oeDeploy插件快速部署 | oeDeploy高级配置更新                       | 功能     | DevStore页面启动，数据同步正常，某个oeDeploy插件已经下载     | 在高级配置页面中修改配置文件并保存，点击任意部署操作         | 本地的配置文件被修改，oeDeploy插件根据最新的配置文件执行部署操作 | <font color=green>■</font> |
| oeDeploy插件快速部署 | oeDeploy插件手动部署                       | 功能     | DevStore页面启动，数据同步正常                               | 随机进入任意oeDeploy插件详情页，在命令行部署页签中逐一复制命令行并执行 | 部署操作触发（部署操作是否执行成功不在本用例看护范围）       | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

DevStore 在 24.03sp2 和 25.09 版本的 DevStation 平台（x86_64和aarch64）上测试，未发现兼容性问题。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

| 用例特性        | 用例名称            | 测试类型 | 预置条件                                                     | 操作步骤                                                     | 预期结果                                                     | 测试结论                   |
| --------------- | ------------------- | -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------- |
| 数据同步与查询  | 数据同步（性能）    | 性能     | dev-store软件包已安装，服务启动，repo源和oeDeploy插件源正确配置，更新yum缓存，打开DevStore软件页面 | 点击右上角刷新按钮，记录数据刷新所需时间                     | 更新时间少于10s（当前版本不做强制要求）                      | <font color=green>■</font> |
| 数据同步与查询  | 检索效率            | 性能     | DevStore页面启动，数据同步正常                               | 搜索框随机输入关键词，回车，记录检索耗时（组件总数不超过200） | 平均检索时间小于1s，单次检索最高时间小于3s                   | <font color=green>■</font> |
| 数据同步与查询  | 详情页加载效率      | 性能     | DevStore页面启动，数据同步正常                               | 随机点击进入MCP服务或者oeDeploy插件的详情页，记录详情页的加载时间 | 平均加载时间小于3s，单次最高加载时间小于9s                   | <font color=green>■</font> |
| MCP服务快速安装 | MCP服务添加删除效率 | 性能     | DevStore页面启动，数据同步正常，某个MCP软件包已安装          | 选择任意智能体应用，记录添加和删除MCP配置的耗时              | 添加/删除操作平均耗时小于2s（2s是页面刷新频率），最大单次耗时小于6s。 | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.2 可靠性/韧性测试结论

| 用例特性             | 用例名称                         | 测试类型 | 预置条件                                                 | 操作步骤                                                     | 预期结果                                                     | 测试结论                   |
| -------------------- | -------------------------------- | -------- | -------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------- |
| 安装部署与初始化     | 服务频繁启停                     | 可靠性   | dev-store软件包已安装                                    | 用脚本快速循环执行，重复20次以上<br>systemctl stop dev-store<br>systemctl start dev-store | 服务启停正常，无报错，服务启动后软件正常工作                 | <font color=green>■</font> |
| 数据同步与查询       | 列表页与详情页频繁进出           | 可靠性   | DevStore页面启动，数据同步正常                           | 快速重复如下操作，重复20次以上：<br>随机点击进入MCP服务或者oeDeploy插件的详情页，再点击左上角的上层目录返回列表页 | 列表页组件罗列正常。详情页名称、标签、版本、日期、用户文档正确显示，允许少量组件的用户文档缺失（旧版本）。 | <font color=green>■</font> |
| MCP服务快速安装      | MCP服务频繁添加删除              | 可靠性   | DevStore页面启动，数据同步正常，某个MCP软件包已安装      | 选择任意智能体应用，高频率往复点击添加与删除按钮，重复至少20次 | 添加删除都成功，无任何报错                                   | <font color=green>■</font> |
| oeDeploy插件快速部署 | oeDeploy插件频繁下载卸载         | 可靠性   | DevStore页面启动，数据同步正常                           | 随机进入任意oeDeploy插件详情页，交替点击下载和卸载按钮，重复20次异常 | 下载卸载都成功                                               | <font color=green>■</font> |
| oeDeploy插件快速部署 | oeDeploy插件快速部署按钮多次点击 | 可靠性   | DevStore页面启动，数据同步正常，某个oeDeploy插件已经下载 | 点击任意部署操作，再次点击同个部署操作，或者点击其他部署操作 | 同时只能触发一个部署操作，其他操作被拒绝                     | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.3.3 安全测试结论

| 用例特性       | 用例名称             | 测试类型 | 预置条件                       | 操作步骤                                                     | 预期结果                             | 测试结论                   |
| -------------- | -------------------- | -------- | ------------------------------ | ------------------------------------------------------------ | ------------------------------------ | -------------------------- |
| 数据同步与查询 | 检索功能危险字段测试 | 安全     | DevStore页面启动，数据同步正常 | 搜索框中输入单引号、双引号、分号、半括号，以及常用的危险关键词：'; DROP TABLE users; --，admin'--，\<script\>alert('XSS')\</script\>，javascript:alert('XSS')，; whoami，; cat /etc/passwd，file:///etc/passwd，等等 | 检索结果正常，程序无报错，无敏感信息 | <font color=green>■</font> |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称 | 测试用例数              | 用例执行结果   | 发现问题单数 |
| :------- | ----------------------- | -------------- | ------------ |
| 1.0.0    | 78（仅24.03sp2）        | 70 pass 8 fail | 4            |
| 1.0.1    | 92（仅24.03sp2）        | 90 pass 2 fail | 1            |
| 1.0.2    | 184（24.03sp2 + 25.09） | 184 pass       | 0            |

##  5.2   问题记录

| 链接                                               | 问题描述                                                     | 严重程度 | 状态   |
| -------------------------------------------------- | ------------------------------------------------------------ | -------- | ------ |
| https://gitee.com/openeuler/DevStore/issues/ICVSSW | DevStore检索功能不可用                                       | 严重     | 已修复 |
| https://gitee.com/openeuler/DevStore/issues/ICVSZ6 | DevStore从详情页返回主页时，概率出现主页列表内无数据         | 次要     | 已修复 |
| https://gitee.com/openeuler/DevStore/issues/ICW4H4 | DevStore快速添加MCP后，配置文件数组变成root，导致其他用户写入失败 | 主要     | 已修复 |
| https://gitee.com/openeuler/DevStore/issues/ICWZRC | DevStore软件包安装之后，服务没有自启动，用户体验不佳         | 主要     | 已修复 |
| https://gitee.com/openeuler/DevStore/issues/ICX8NB | MCP详情页的json一键复制功能异常                              | 次要     | 已修复 |



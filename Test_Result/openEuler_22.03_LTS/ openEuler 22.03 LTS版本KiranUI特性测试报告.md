![openEuler ico](../../images/openEuler.png)

版权所有 © 2020  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2022/03/21      |V1.0             |  创建        | 杨敬婷     |
|2022/03/23      |V1.1             |  修改特性概述、测试硬件环境        | 杨敬婷     |
|2022/03/28      |V1.2             |  去掉了注释信息，增加了测试策略描述        | 杨敬婷     |

 关键词：KiranUI测试报告 

 

摘要：按照测试要求，对openEuler_22.03_LTS版本进行KiranUI的安装、主要功能、组件的测试。测试结果良好，基本支持KiranUI基本功能的测试。

 


# 1     特性概述
kiranUI桌面是湖南麒麟信安团队以用户和市场需求为导向，研发的一个安全、稳定、高效、易用的桌面环境，具有良好的用户体验。kiranUI可以支持x86_64和aarch64架构。

# 2     特性测试信息
测试策略概述：  
KiranUI特性测试需要测试2轮，主要采用手工测试的方式来测试功能和性能，并分别在x86_64和aarch64架构下进行验证，测试内容包括了安装、控制中心、系统面板、基础组件、文件管理器、通知区域和性能稳定性测试，测试用例覆盖范围全面，测试周期完整。
 
测试周期如下所示：

| 版本名称 | 测试起始时间 | 测试结束时间 |备注|
| -------- | ------------ | ------------ |---------|
|  KiranUI        |       2022/03/07       |    2022/03/10         |第一轮测试|
|  KiranUI        |       2022/03/21       |    2022/03/23         |第二轮测试|

本测试报告适用于openEuler-22.03_LTS（arm和x86）版本操作系统，测试硬件平台如下：

|环境| 硬件型号 | 硬件配置信息 | 数量 |
|-------| -------- | ------------ | ---- |
|x86_64|  DELL OptiPlex 3050        | CPU型号: Intel(R) Core(TM) i5-7500 CPU @3.40GHz<br>CPU核数：4<br>内存:16G             |  1    |
|aarch64|  虚拟机       | BIOS：virt-rhel7.6.0<br>CPU核数：2<br>内存:2G             |  1    |

# 3     测试结论概述

## 3.1   测试整体结论
KiranUI特性测试，共执行了67个测试用例，主要覆盖了系统面板、控制中心、基础组件、文件管理器caja、通知区域测试，同时进行了性能测试和LTP7*24小时的稳定性测试。经测试发现的问题都已解决，回归通过，无遗留风险，整体质量良好：
| 测试活动 | 活动评价 |
| -------- | -------- |
| 功能测试 |  基本功能均已实现，测试结果良好        |
| 性能测试 |  系统在极限情况下性能良好，无卡顿情况        |
| 稳定性测试 | 系统在LTP压力测试情况下稳定性良好，无卡死情况       |

## 3.2   约束说明

无。

## 3.3   问题分析

### 3.3.1 问题列表

|  序号  | 问题描述 | gitee链接 | 当前状态 |
|----------| -------- | -------- | -------- |
|1| 使用源2203 LTS_epol_round2安装kiran-desktop相关包后，因缺少依赖包无法安装         | https://gitee.com/src-openeuler/kiran-desktop/issues/I4VESX?from=project-issue          |   已解决       |
|2|深色主题无法完全应用程序窗口          | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WLMK?from=project-issue         |  已解决        |
|3| 光标主题和深浅色主题无法在自研组件上生效         | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WLSQ?from=project-issue         |  已解决       |
|4 |快捷键设置内的“系统”和“辅助”分组下内容为空  | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WLZE?from=project-issue |  已解决  |
|5|打开《Traceroute》和《终端》窗口，在任务栏中使用的是同一个图标 |https://gitee.com/src-openeuler/kiran-desktop/issues/I4WM37?from=project-issue | 已解决         |
|6|root登录桌面后任务栏中《文件管理器》无法启动  |https://gitee.com/src-openeuler/kiran-desktop/issues/I4WM54?from=project-issue  | 已解决         |
|7|任务栏右侧没有输入法图标 | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WMVA?from=project-issue         | 已解决         |
|8|开始菜单内的《caja》程序无法启动  |https://gitee.com/src-openeuler/kiran-desktop/issues/I4WN0A?from=project-issue          | 已解决         |
|9|开始菜单内的《File Management》程序无法启动 | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WN6W?from=project-issue |  已解决        |
|10|开始菜单内的《Fcitx》程序无法启动          | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WN8E?from=project-issue         | 已解决         |
|11|启动《运行命令》程序，勾选“在终端中运行”后运行，终端窗口和运行命令窗口闪退|https://gitee.com/src-openeuler/kiran-desktop/issues/I4WNB8?from=project-issue          |  已解决        |
|12|《搜索文件》程序无法启动          |https://gitee.com/src-openeuler/kiran-desktop/issues/I4WNDR?from=project-issue          | 已解决          |
|13|开始菜单左侧面板的《主目录》图标程序，无法启动  |https://gitee.com/src-openeuler/kiran-desktop/issues/I4WO7L?from=project-issue          | 已解决         |
|14| root登录桌面，更换图标主题后无法立即生效，需要重启系统生效  |https://gitee.com/src-openeuler/kiran-desktop/issues/I4WOFG?from=project-issue |    已解决      |
|15| 终端内的输入光标与文本内容位置错开，光标下移  |https://gitee.com/src-openeuler/kiran-desktop/issues/I4WON7?from=project-issue  | 已解决         |
|16|快捷键“屏幕抓图”无效，更改后依然无法生效  | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WOQM?from=project-issue |  延后        |
|17|快捷键“窗口抓图”无效，更改后依旧无法生效 | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WORW?from=project-issue  | 延后         |
|18|使用源2203 LTS_epol_round2安装以及卸载kiran-desktop相关包后，出现”failed to commit changes to dconf“        | https://gitee.com/src-openeuler/kiran-desktop/issues/I4XJZK?from=project-issue         | 已解决          |
### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 18         |   0   |    1  | 17     |      0  |
| 百分比 |   100%       |   0   |  5.6%    |  94.4%    |  0      |

# 4     测试执行

## 4.1   测试执行统计数据

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| KiranUI         |   67         |    测试通过          |    18          |


## 4.2   后续测试建议

建议后续测试时多关注KiranUI的基础组件功能测试，多关注用户体验度。

# 5     附件

遗留问题
|  序号  | 问题描述 | gitee链接 | 当前状态 |
|----------| -------- | -------- | -------- |
|1|快捷键“屏幕抓图”无效，更改后依然无法生效  | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WOQM?from=project-issue |  延后         |
|2|快捷键“窗口抓图”无效，更改后依旧无法生效 | https://gitee.com/src-openeuler/kiran-desktop/issues/I4WORW?from=project-issue  | 延后         |
 



 

 

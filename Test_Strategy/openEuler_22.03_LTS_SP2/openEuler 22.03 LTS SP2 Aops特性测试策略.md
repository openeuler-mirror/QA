



![avatar](../../images/openEuler.png)

版权所有 © 2023 openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[https://creativecommons.org/licenses/by-sa/4.0/](https://gitee.com/link?target=https%3A%2F%2Fcreativecommons.org%2Flicenses%2Fby-sa%2F4.0%2F)了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[https://creativecommons.org/licenses/by-sa/4.0/legalcode](https://gitee.com/link?target=https%3A%2F%2Fcreativecommons.org%2Flicenses%2Fby-sa%2F4.0%2Flegalcode)。

修订记录

| 日期 | 修订版本     | 修改章节 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- | ---- |
| 2023/06/17 |    V1.0         |          | 初稿 | yangshicheng/dingjiao |

**Keywords 关键词**：

Aops 漏洞管理 资产管理 热补丁修复 CICD

Abstract 摘要：

本文是openEuler 22.03 LTS SP2 Aops特性的测试策略，按照测试策略，对A-ops项目下的漏洞管理、资产管理、热补丁修复、CICD支持热补丁等功能进行接口、web页面功能、文档以及易用性测试。

缩略语清单：

| 缩略语 | 英文全名                                         | 中文解释           |
| ------ | ------------------------------------------------ | ------------------ |
| CVE    | Common Vulnerabilities and Exposures             | 公共漏洞和暴露     |
| CICD   | Continuous Integration and Continuous Deployment | 持续集成和持续交付 |

# 特性描述
AOps本次需求通过制作热补丁支持集群、单机的缺陷修复；集群、单机回退热补丁的功能；CICD支持热补丁的功能

# 需求清单
/vulnerability/task/cve-rollback/generate
/vulnerability/task/callback/cve/rollback
/vulnerability/cve/list/get
/vulnerability/cve/host/get
/vulnerability/host/list/get
/vulnerability/host/cve/get
/vulnerability/host/info/get
/vulnerability/task/callback/cve/scan
/vulnerability/cve/task/host/get
/vulnerability/task/cve/generate
/manage/vulnerability/cve/rollback
/manage/vulnerability/cve/fix
aops-ceres apollo --rollback <ARGS>
CICD支持热补丁

## 风险项

# 测试分层策略(*基于继承特性策略刷新*)
# 测试分析设计策略

## 新增feature测试设计策略

| *序号* | *Feature*             | *测试设计策略* | *测试重点* |
| ------ | --------------------- | ------------  | --------- |
| 1 | 系统缺陷巡检和告警通知 | 通过定时巡检和自定义巡检，验证巡检结果 | 定义巡检规则，检查巡检结果是否正确 |
|  2| 系统缺陷支持热补丁修复 | 设计单机/集群进行热/冷顶部修复和检查修复状态 | 检查修复过程和修复结果 |
|  3| 单机支持使用dnf管理热补丁 | 设计热补丁本地状态查询、修复、回退、自动激活测试场景 | 重点关注各个动作的结果是否正确 |
| 4 | 热补丁回退 | 设计集群/单机、不同状态下热补丁的回退场景 | 检查热补丁是否正确回退 |
| 5 | 社区：CICD流水线支持热补丁  | 通过门禁自动触发热补丁制作 | 重点关注热补丁能否正常制作，并检查最终发布在官网的热补丁信息 |




## 继承feature/组件测试设计策略重点

从老版本继承的功能特性的测试策略如下：

| Feature/组件 |  策略                           |
| ----------- | ------------------------------- |
| Aops-zeus         | 直接继承已有测试能力，重点关注本次版本发布特性涉及接口参数修改后，是否对原有功能功能有影响,前端界面显示是否合理清晰 |
| Aops-apollo         | 直接继承已有测试能力，重点关注本次版本发布特性涉及接口参数修改后，是否对原有功能功能有影响,前端界面显示是否合理清晰 |
| Aops-ceres         | 直接继承已有测试能力，重点关注本次版本发布特性涉及命令参数，是否对原有功能功能有影响,前端界面显示是否合理清晰 |
| Aops-diana         | 直接继承已有测试能力，关注基本功能正常运行，前端界面显示是否合理清晰 |


## 专项测试策略
### 可靠性测试

| 场景描述 | 具体测试内容|
| -------- | --------------|
| 操作系统长稳  | 系统在各种压力背景下，通过构造资源类和服务类等异常，随机执行LTP、系统管理操作等测试；过程中关注系统重要进程/服务，日志等异常情况；建议稳定性测试时长7*24性能测试  |

### 兼容性测试

| 专项测试类型 | 设计思路 | 测试重点 | 备注 |
| ------------ | -------- | -------- | ---- |
| 兼容性   | web端页面能否稳定显示| 常见浏览器和分辨率兼容    |      |

### UI界面测试

| 专项测试类型 | 设计思路 | 测试重点 | 备注 |
| ------------ | -------- | -------- | ---- |
| UI测试   |  前端基础功能稳定   |    按钮、下拉框、筛选框、组合查询、分页显示、排序功能可以正常使用 |      |

### 性能测试
| 专项测试类型 | 设计思路 | 测试重点 | 备注 |
| ------------ | -------- | -------- | ---- |
| web端性能   | 页面能正常响应| 启动3s，响应1-2s，数据响应3s内    |      |


# 特性测试环境描述

| 硬件型号 | 硬件配置信息                            |  数量   | 备注   |
| -------- | --------------------------------------- | ----- |------ |
| aarch64  | CPU核数：8<br>内存：8G<br>硬盘容量：50G |  3 |  虚拟机 |
| x86_64   | CPU核数：8<br>内存：8G<br>硬盘容量：50G |  3 |  虚拟机 |

# 特性测试执行策略

## 测试计划
| Stange name  | Begin time | End time   | Days | 测试执行策略                   | 备注 |
| :----------- | :--------- | :--------- | ---- | ------------------------------ | --------------- |
| Test round 3 | 2023-06-03 | 2023-06-09 | 7    | 全量SIT验证       |
| Test round 4 | 2023-06-10 | 2023-06-16 | 7    | 全量SIT验证，新增部分接口测试                  |      |
| Test round 5 | 2023-06-17 | 2023-06-23 | 7    | 回归测试，CICD门禁制作热补丁流程功能测试 |      |
| Test round 6 | 2023-06-24 | 2023-06-30 | 7    | 回归测试                       |      |

# 入口标准

1. 上个阶段无block问题遗留
2. 转测版本可以在openEuler 22.03 LTS SP2上成功运行无阻塞性问题

# 出口标准

1. 策略规划的测试活动涉及用例100%执行完毕
2. 版本无安全问题遗留

# 附件
无
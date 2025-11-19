![avatar](../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
| 2025-11-06 | 1.0.0    | 草稿     | 郑紫阳、刘庆涛     |

关键词： snappy


摘要：本文介绍说明了snappy的测试内容和测试方法


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |


# 特性描述


优化riscv架构下snappy压缩性能

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
| 2 | [ICW4C5](https://gitee.com/openeuler/release-management/issues/ICW4C5?from=project-issue) | Accepted | Base-service | @QingtaoLiu | ISO | snappy |
|     |    |    |   |     |     |     |

## 特性应用场景分析


## 特性实现流程描述


## 与其他特性交互描述


## 风险项


# 特性分层策略
## 总体测试策略

- 测试目标：本次测试主要覆盖功能测试,验证引入snappy优化后，snappy能够正常解压缩
- 时间进度：待评估
- 风险评估：NA
- 重点事项：同测试目标
- 争议事项：NA

## 接口/功能测试

| 接口描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
| snappy功能测试 | 测试snappy压缩解压缩功能 | 能够正常压缩解压缩 |      |
|         |         |         |      |

## 场景测试
参考功能场景，可以利用lzbench测试工具辅助测试snappy压缩和解压缩的功能

## 专项测试

参考功能场景，可以利用zbench测试工具辅助测试snappy的压缩性能

# 特性测试执行策略

## 特性测试依赖描述
3. 不涉及特殊硬件

## 特性测试约束
3. 无

## 特性测试环境描述
无
## 测试计划
参照lzbench测试说明
## 入口标准
1.snappy压缩解压缩功能正常，snappy压缩性能有提升

## 出口标准
1. 测试完毕，无严重问题遗留

# 附件
![avatar](../images/openEuler.png)

版权所有 © 2022  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

 修订记录

| 日期 | 修订版本     | 修改描述  | 作者 |
| ---- | ----------- | -------- | ---- |
|2025-11-13|1.0.0|初稿|胡芳刚|

关键词： URPC UMQ

 
摘要：本文从特性介绍、测试目标、测试内容、测试计划等说明URPC特性测试策略。


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|URPC|Unified Remote Procedure Call|统一远程过程调用|
|UMQ|Unified Message Queue|统一消息队列|


# 特性描述
<!-- 主要介绍特性实现的背景、功能以及作用 -->
支持灵衢原生高性能设备间RPC通信

## 需求清单
|no|feature|status|sig|owner|发布方式|涉及软件包列表|
|:----|:---|:---|:--|:----|:----|:----|
|[ID3WJO](https://gitee.com/openeuler/release-management/issues/ID3WJO?from=project-issue)|URPC：URPC支持UB|Developing|sig-UnifiedBus|@nemeiju|ISO|liburpc|


## 特性应用场景分析
<!-- 主要描述特性的应用场景分析，指导后面场景测试的测试策略制定 -->
1. 提供URPC基础建链、远程通信、远程调用能力


## 特性实现流程描述
<!-- 主要描述特性实现的流程，可使用流程图等方式描述 -->
1、URPC功能实现流程
```mermaid
%% 时序图例子,-> 直线，-->虚线，->>实线箭头
sequenceDiagram
    participant Client as 应用client
    participant Server as 应用server

    Note over Client,Server: 1. 初始化阶段
    Client->>Client: urpc_init 初始化urpc
    Server->>Server: urpc_init 初始化urpc
    Client->>Client: 内存注册，创建chanel和queue
    Server->>Server: 内存注册，创建chanel和queue

    Note over Client,Server: 2. 建链
    Client->>Server: client 向 server 发送建链请求，发送内存信息
    Server->>Client: sever回复响应，并建立长链接
    Client->>Server: channel add local queue
    Client->>Server: channel add remote queue
    Client->>Server: local queue pair remote queue

    Note over Client,Server: URPC建链完成

    Note over Client,Server: 3. 数据面传输阶段开始

    loop 持续数据传输
        Note over Client: 应用准备数据
        Client->>Server: 调用 urpc_func_call 发送请求报文
        Server->>Server: 接收请求报文并上报
        Server->>Server: 调用 urpc_func_exec 调用指定函数
        Server->>Client: 调用 urpc_func_return 回复远程调用结果
        Client->>Client: 接收远程调用结果，释放内存。
    end

    Note over Client,Server: 4. 断链阶段
    Client->>Server: local queue unpair remote queue
    Client->>Server: remove local/remote queue
    Client->>Server: detach 结束长链接

    Note over Client,Server: 5. 去初始化阶段

    Client->>Client: 排空local queue，并销毁 queue，channel
    Server->>Server: 排空local queue，并销毁 queue，channel
    Client->>Client: urpc_uninit 去初始化
    Server->>Server: urpc_uninit 去初始化

```

2、UMQ功能实现流程
```mermaid
%% 时序图例子,-> 直线，-->虚线，->>实线箭头
sequenceDiagram
    participant Client as 应用client
    participant Server as 应用server

    Note over Client,Server: 1. 初始化阶段
    Client->>Client: umq_init 初始化umq
    Server->>Server: umq_init 初始化umq

    Note over Client,Server: 2. 创建句柄阶段
    Client->>Client: umq_create 创建umqh
    Client->>Client: umq_bind_info_get 获取本端bindinfo信息
    Server->>Server: umq_create 创建umqh
    Server->>Server: umq_bind_info_get 获取本端bindinfo信息

    Note over Client,Server: 3. 信息交换阶段
    Client->>Server: 发送bindinfo信息<br/>并请求对端bindinfo信息
    Server-->>Client: 发送bindinfo信息

    Note over Client,Server: 4. 绑定阶段
    Client->>Client: umq_bind
    Server->>Server: umq_bind

    Note over Client,Server: UMQ连接建立完成

    Note over Client,Server: 5. 数据面传输阶段开始

    loop 持续数据传输
        Note over Client: 应用准备数据
        Client->>Client: umq_buf_alloc 申请内存，准备发送数据
        Client->>Client: umq_post 方向UMQ_IO_TX准备发送数据

        Client->>Server: 数据包(无确认)

        Note over Server: 应用轮询等待数据
        loop 直到umq_poll返回值大于0
            Server->>Server: umq_poll(UMQ_IO_RX)轮询接收数据
        end
        Server->>Server: 处理数据
        Server->>Server: umq_buf_free释放数据
        Server->>Server: umq_buf_alloc申请新的buf
        Server->>Server: umq_post方向UMQ_IO_RX
    end

    Note over Client,Server: 6. 断链阶段
    Client->>Client: umq_unbind解绑
    Server->>Server: umq_unbind解绑
    Client->>Client: umq_destroy 销毁umqh
    Server->>Server: umq_destroy 销毁umqh
    Client->>Client: umq_uninit 去初始化
    Server->>Server: umq_uninit 去初始化

```
## 与其他特性交互描述
<!-- 主要描述特性与其他特性或功能的交互 -->
无

## 风险项
<!-- 主要描述特性已知风险项 -->
无

# 特性分层策略
## 总体测试策略
<!-- 主要描述特性的整体测试策略，主要开展哪些测试(接口/功能/场景/专项) -->
功能方面覆盖对用户呈现的接口测试、URPC初始化、管理面建链、数据面收发等功能测试，对资源不足、对端进程异常退出等可靠性场景开展测试，并开展正常使用流程的长稳压测。

## 接口/功能测试
<!-- 主要描述接口级测试策略及测试设计思路 -->
| 接口描述 | 设计思路 | 测试重点 | 备注 |
| ------- | ------- | ------- | ---- |
|初始化|不同初始化参数配置|针对不同配置遍历测试|无|
|管理面建链|单链接、多链接|client端、server端多连接测试|无|
|数据面收发|围绕数据面资源、链接数量测试|多链接收发测试|无|

## 场景测试
<!-- 主要描述对特性使用的主要场景的测试策略及测试思路 -->
同功能测试


## 专项测试
<!-- 主要描述其他专项测试,如安全测试 可靠性、韧性测试 性能测试 兼容性测试等 -->
| 专项测试类型 | 专项测试描述 | 测试预期结果 | 备注 |
| ----------- | ----------- | ----------- | ---- |
|可靠性测试|构造数据面资源不足，对端进程异常退出测试|不会出现崩溃、资源无法释放等问题，故障恢复后使用正常|无|
|安全测试|病毒/安全编译选项/敏感信息/代码片段引用扫描，开源合规license检查|无安全问题|无|
|长稳测试|正常使用流的长时间压测|系统运行正常，无崩溃、资源泄露等问题|无|

# 特性测试执行策略

## 特性测试依赖描述
<!-- 主要描述特性测试所依赖的执行环境、软件包、环境变量等依赖 -->
1. 目前只支持UB硬件使用，依赖UB连接正常通信


## 特性测试约束
<!-- 主要描述特性测试的约束条件 -->
1. 现阶段不支持Queue异常处理，如果出现Queue异常，需要销毁Queue重新建链即可


## 特性测试环境描述
<!-- 主要描述执行测试的硬件信息 -->
| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|MatrixServer服务器|典型配置|NA|

## 测试计划
<!-- 测试执行策略主要描述该轮次执行的分层策略中的测试项 -->
| Stange name   | Begin time | End time   | Days | 测试执行策略                   | 备注   |
| :------------ | :--------- | :--------- | ---- | ----------------------------- | ------ |
|Test round 4/5/6/7|2025/11/14|2025/12/11|28|全量测试|NA|
|Test round 8/9|2025/12/12|2025/12/25|14|回归测试|NA|

## 入口标准
<!-- 描述整个测试执行阶段的入口条件，包括前个阶段的检查、用例执行、问题修复等情况-->
1. 功能开发已完成
2. 上阶段无block问题遗留
3. 基础功能验证正常

## 出口标准
<!-- 本节描述整个测试执行阶段的出口 -->
1. 策略规划的测试活动涉及测试用例100%执行完毕
2. 性能基线、功能基线等满足特性规划目标
3. 无block问题遗留，其它严重问题要有相应规避措施或说明


# 附件
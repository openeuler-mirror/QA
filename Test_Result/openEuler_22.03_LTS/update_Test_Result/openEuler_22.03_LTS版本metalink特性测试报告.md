![openEuler ico](../../images/openEuler.png)

版权所有 © 2020  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2023/9/4      |v1.0             |添加metalink测试报告          |鞠方群      |
|      |             |          |      |
|      |             |          |      |

 关键词： metalink

 

摘要：为 openEuler-22.03-LTS 添加 metalink 支持，以提高下载速度。

 

缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

dnf客户端访问metalink链接地址，metalink服务器会根据主机ip地址、镜像站点出口带宽、运营商等参数进行运算，从所有镜像站中选择主机访问最快的若干镜像站，按照优先级排序，然后将该镜像站列表返回给dnf客户端，dnf将该列表文件缓存到本地。之后dnf根据特定的算法从站点列表下载软件包，以提高下载速度。

# 2     特性测试信息

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|openEuler-22.03-LTS          |2023.9.4              |2023.9.4              |


| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|虚拟机          |              |Ubuntu 22.04.2 LTS     |

# 3     测试结论概述

## 3.1   测试整体结论

使用 metalink 方式下载软件包，在大多数情况下下载速度比原方式更快，少数情况与原方式相当，部分地域加速效果显著。

## 3.2   约束说明

若升级前未更改 /etc/yum.repos.d/openEuler.repo 文件，则升级后会正常配置 metalink；若升级前更改过 /etc/yum.repos.d/openEuler.repo 文件，则升级后的配置文件被保存为 /etc/yum.repos.d/openEuler.repo.rpmnew，不会覆盖用户的自定义配置，但需人工配置此文件才可使用。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

无遗留问题

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |0          |0      |0      |0      |0        |
| 百分比 |          |      |      |      |        |

# 4     测试执行

## 4.1   测试执行统计数据

选定不同地域的宿主机，每次初始化一个容器，分别采用 baseurl 和 metalink 方式安装 golang 包。每个地域安装5次，记录下载时间并去除最大值和最小值。

<h4>测试结果:</h4>
<table>
    <tr>
        <td>IP地址</td>
        <td>IP所在地</td>
        <td>安装方式</td>
        <td>第一次</td>
        <td>第二次</td>
        <td>第三次</td>
    </tr>
    <tr>
        <td rowspan="2">123.60.156.36</td>
        <td rowspan="2">上海</td>
        <td>baseurl</td>
        <td>1m20s</td>
        <td>1m19s</td>
        <td>1m21s</td>
    </tr>
    <tr>
        <td>metalink</td>
        <td>1m04s</td>
        <td>1m14s</td>
        <td>1m28s</td>
    </tr>
    <tr>
        <td rowspan="2">140.210.203.154</td>
        <td rowspan="2">贵阳</td>
        <td>baseurl</td>
        <td>4m42s</td>
        <td>4m24s</td>
        <td>4m01s</td>
    </tr>
    <tr>
        <td>metalink</td>
        <td>1m52s</td>
        <td>1m45s</td>
        <td>1m56s</td>
    </tr>
    <tr>
        <td rowspan="2">101.44.33.110 </td>
        <td rowspan="2">土耳其</td>
        <td>baseurl</td>
        <td>30m+</td>
        <td>30m+</td>
        <td>30m+</td>
    </tr>
    <tr>
        <td>metalink</td>
        <td>1m46s</td>
        <td>1m52s</td>
        <td>1m54s</td>
    </tr>
    <tr>
        <td rowspan="2">35.181.8.199</td>
        <td rowspan="2">巴黎</td>
        <td>baseurl</td>
        <td>33s</td>
        <td>22s</td>
        <td>26s</td>
    </tr>
    <tr>
        <td>metalink</td>
        <td>6s</td>
        <td>8s</td>
        <td>20s</td>
    </tr>
    <tr>
        <td rowspan="2">3.79.2.65</td>
        <td rowspan="2">德国</td>
        <td>baseurl</td>
        <td>21s</td>
        <td>22s</td>
        <td>17s</td>
    </tr>
    <tr>
        <td>metalink</td>
        <td>7s</td>
        <td>7s</td>
        <td>27s</td>
    </tr>
</table>


## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

无



 

 
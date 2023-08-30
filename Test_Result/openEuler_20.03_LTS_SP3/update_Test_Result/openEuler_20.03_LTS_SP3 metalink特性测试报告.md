![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
|2023.8.29      |1.0.0             |配置metalink          |鞠方群      |
|      |             |          |      |

关键词： metalink

摘要：为 openEuler-20.03-LTS-SP3 添加 metalink 支持。


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
|openEuler-20.03-LTS-SP3          |2023.8.28              |2023.8.29              |
|          |              |              |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|          |              |      |
|          |              |      |

# 3     测试结论概述

若升级前未更改 /etc/yum.repos.d/openEuler.repo 文件，则升级后会正常配置 metalink；
若升级前更改过 /etc/yum.repos.d/openEuler.repo 文件，则升级后的配置文件被保存为 /etc/yum.repos.d/openEuler.repo.rpmnew，不会覆盖用户的自定义配置，但需人工配置此文件才可使用。
升级后默认启动 metalink 下载软件包，并且下载功能正常。

# 4 详细测试结论

### 4.1.1 继承特性测试结论

升级后从每个仓库下载软件包：

OS：
![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/OS1.PNG)
![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/OS2.PNG)

everything：
![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/everything1.PNG)
![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/everything2.PNG)

EPOL：
![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/EPOL.PNG)

debuginfo：
![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/debuginfo.PNG)

source：
![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/source.PNG)

update：
![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/update.PNG)

update-source：
![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/update-source.PNG)

均从指定仓库下载成功。
### 4.1.2 新增特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1 |metalink | <font color=green>■</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

升级后文件 /etc/yum.repos.d/openEuler.repo 中的每个软件仓会增加 metalink 配置，以 OS 软件仓为例：
```
[OS]
name=OS
baseurl=http://repo.openeuler.org/openEuler-20.03-LTS-SP3/OS/$basearch/
metalink=https://mirrors.openeuler.org/metalink?repo=$releasever/OS&arch=$basearch
metadata_expire=1h
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-20.03-LTS-SP3/OS/$basearch/RPM-GPG-KEY-openEuler
```

验证 metalink 生效：
```
sudo dnf clean all
sudo dnf makecache
sudo find /var/ -name "*metalink*"
```

输出如下结果代表 metalink 已生效：

![输入图片说明](./images/openEuler_20.03_LTS_SP3%20metalink特性/find%20metalink.PNG)

## 4.2 兼容性测试结论

若未修改过 /etc/yum.repos.d/openEuler.repo 文件，则升级后会正常配置此文件；
若曾经修改过 /etc/yum.repos.d/openEuler.repo 文件，则升级后此文件不变，新的配置文件被保存为 /etc/yum.repos.d/openEuler.repo.rpmnew，此时 metalink 的配置不会生效，需人工配置此文件才可生效。如将新增内容添加到 openEuler.repo 文件中，或删除 openEuler.repo 文件并将 openEuler.repo.rpmnew 改为 openEuler.repo。


# 5     测试执行

## 5.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|          |            |              |              |
|          |            |              |              |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*

 



 

 
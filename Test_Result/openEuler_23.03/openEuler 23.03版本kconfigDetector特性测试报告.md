![avatar](../../images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2023/03/22  |   1.0          | 创建         | 孙滢     |


 关键词： 
kconfigDetector  
 

摘要：  
本报告主要描述基于 openEuler 23.03 版本 kconfigDetector 特性基本功能测试结果。
 


# 1     特性概述

kconfigDetector是内核配置项错误值检查工具，检查内核配置文件中不满足内核源码kconfig依赖限制约束的错误值，以满足用户在内核开发及裁剪中的错误检测需求，辅助修改和配置内核。

# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
| openEuler-23.03-rc2         | 2023/03/06             |   2023/03/07           |
| openEuler-23.03-rc3         | 2023/03/11             | 2023/03/11             |


描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|  X86_64        | 虚拟机             | CPU核数：4   内存：4G   硬盘容量：20G     |
|  AARCH64       | 虚拟机             | CPU核数：4   内存：4G   硬盘容量：20G     |

# 3     测试结论概述

## 3.1   测试整体结论

kconfigDetector on openEuler 23.03 特性，共计执行 16 个用例，主要覆盖了在 openEuler 23.03 中安装部署、卸载、 check_kconfig_dep命令的功能测试，x86 架构和 aarch64 架构均测试通过。

| 测试活动 | 活动评价                                                     |
| -------- | ------------------------------------------------------------ |
| 功能测试 | 对 kconfigDetector 包展开安装、卸载和check_kconfig_dep指令功能测试，结果符合预期。 |
| 专项测试 | 对 kconfigDetector 包稳定性测试，安装和卸载功能可重复，结果符合预期。 |

## 3.2   约束说明

测试环境已安装安装依赖包python3 python3-devel python3-setuptools python-ply。

## 3.3   遗留问题分析

无。

# 4     测试执行

## 4.1   测试执行统计数据

*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
| openEuler-23.03-rc2         |      16      |     通过         |      0        |
| openEuler-23.03-rc3         |      16      |     通过         |      0        |


*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 4.2   后续测试建议

后续测试需要关注点(可选)

# 5     附件

测试用例及结果  

<table>
  <tr>
    <td>测试方案</td>
    <td>用例编号</td>
    <td>用例名称</td>
    <td>结果</td>
  </tr>
  <tr>
    <tr>
      <td rowspan="8">X86_64</td>
      <td>001</td>
      <td>安装kconfigDetector软件包</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>002</td>
      <td>测试check_kconfig_dep命令参数</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>003</td>
      <td>检查depends error类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>004</td>
      <td>检查range error类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>005</td>
      <td>检查lack config类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>006</td>
      <td>检查unmet dependences类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>007</td>
      <td>检查restrict warning类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>008</td>
      <td>卸载kconfigDetector软件包</td>
      <td>通过</td>
    </tr>
    <tr>
      <td rowspan="8">AARCH64</td>
      <td>009</td>
      <td>安装kconfigDetector软件包</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>010</td>
      <td>测试check_kconfig_dep命令参数</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>011</td>
      <td>检查depends error类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>012</td>
      <td>检查range error类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>013</td>
      <td>检查lack config类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>014</td>
      <td>检查unmet dependences类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>015</td>
      <td>检查restrict warning类型错误值</td>
      <td>通过</td>
    </tr>
    <tr>
      <td>016</td>
      <td>卸载kconfigDetector软件包</td>
      <td>通过</td>
    </tr>
  </tr>
</table>

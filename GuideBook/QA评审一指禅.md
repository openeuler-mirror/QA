# QA评审一指禅


## 1. LTS版本
### 1.1 LTS及SP - 发布周期内
**策略**：发布周期内，默认接受在`Test round 1`前已被release-management sig（下文简称为RM-sig）接纳，即已经在release-plan中接纳。默认拒绝`Test round 3`未完成开发的特性，默认拒绝`Test round 1`后接纳的版本需求，默认拒绝`Test round 2`前未提交测试策略的需求。

release-plan可参考 [22.03 LTS SP2 release-plan](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP2/release-plan.md)

1. 需求提交与接纳(RM-sig)：
    * 需求提交：由需求归属-sig，在openEuler的[RM-sig](https://gitee.com/openeuler/release-management/blob/master/openEuler-22.03-LTS-SP2/release-plan.md)通过issue的方式提交需求(可参考[该需求](https://gitee.com/openeuler/release-management/issues/I7TZ9C?from=project-issue))
    * 需求接纳：由RM-sig进行评审，releae-plan的需求状态为最终状态（接纳/拒绝）
2. 需求开发(需求归属-sig):
    * 仓库与分支创建：由需求归属-sig在[community仓库](https://gitee.com/openeuler/community)提交pr进行仓库与分支创建(可参考[PR](https://gitee.com/openeuler/community/pulls/5037))
    * 开发交付：由需求归属-sig在src-openEuler对应开发(master或LTS-Next分支)及版本分支(LTS-SPx)进行开发
3. 需求构建(RM-sig):
    * 加入版本构建：由需求归属-sig在[RM仓库](https://gitee.com/openeuler/release-management)提交版本工程增加pr(可参考[PR](https://gitee.com/openeuler/release-management/pulls/1312)), 新加入社区的软件包先进入Factory，构建功能稳定后进入mainline再进入版本分支。
    * 构建系统跟踪：[EulerMaker](https://eulermaker.compass-ci.openeuler.openatom.cn/)、[OBS](https://build.openeuler.openatom.cn/) 22年9月后版本构建以EulerMaker为主干。
    * 每日构建结果获取：每日构建结果见[链接](http://121.36.84.172/dailybuild/)
4. 测试策略(需求归属-sig):
    * 测试策略制定: 基于社区[测试策略模板](https://gitee.com/openeuler/QA/blob/master/Test_Delivery_Templates/openEuler%20xx%E7%89%88%E6%9C%ACxx%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E7%AD%96%E7%95%A5%E6%A8%A1%E6%9D%BF.md)制定特性测试策略模板，应在社区`Test round 2`转测前提交PR至[QA仓库测试策略目录](https://gitee.com/openeuler/QA/tree/master/Test_Strategy)。
    * 测试策略要求：对于在社区孵化的特性，至少需覆盖3轮及以上测试；对于各企业组织开源的成熟需求，至少覆盖2轮及以上测试；测试轮次需要和社区测试轮次匹配。测试策略需覆盖功能测试(新增/继承)、兼容性、DFX(性能/可靠性/安全)、资料测试
5. 测试执行(需求归属-sig)：
    * 由需求归属-sig基于测试策略完成测试执行
6. 测试结果出口评审(QA-sig):
    * 测试报告编写：基于社区[测试报告模板](https://gitee.com/openeuler/QA/blob/master/Test_Result/openEuler_22.03_LTS_SP2/openEuler%20XX%E7%89%88%E6%9C%ACXX%E7%89%B9%E6%80%A7%E6%B5%8B%E8%AF%95%E6%8A%A5%E5%91%8A%E6%A8%A1%E6%9D%BF.md)进行结果编写，并在社区RC5转测前提交PR至[QA仓库测试报告目录](https://gitee.com/openeuler/QA/tree/master/Test_Result)

### 1.2 LTS及SP - 维护周期内
**策略**：维护周期内，接纳CVE修复、bugfix相关的软件patch修复。对于软件包版本变更、加包删包，应保证前向兼容性，需通过RM、兼容性sig的例外评审，否则QA不接受任何变更且不接纳评审。

### 1.3 LTS及SP - 维护周期外
**策略**：维护周期外，应先通过RM的例外评审，否则QA不接受任何变更且不接纳评审。

## 2. 创新版本
### 2.1 创新版本 - 发布周期内
**策略**：整体策略同1.1，仅质量要求与LTS版本有差异。

### 2.2 创新版本 - 维护周期内
**策略**：维护周期内外，均应先通过RM的例外评审，否则QA不接受任何变更且不接纳评审。

### 2.3 创新版本 - 维护周期外
**策略**：维护周期内外，均应先通过RM的例外评审，否则QA不接受任何变更且不接纳评审。

## 3. 相关链接
[社区QA仓库](https://gitee.com/openeuler/QA)
[社区测试策略](https://gitee.com/openeuler/QA/tree/master/Test_Strategy)
[社区测试报告](https://gitee.com/openeuler/QA/tree/master/Test_Result)
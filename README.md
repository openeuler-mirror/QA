
# QA SIG
QA(质量保障)项目团队对openEuler社区发布软件进行测试，目标是不断提升openEuler社区的发布质量和社区测试能力
主要活动包括：
- 构建社区测试能力，让更多的社区开发者参与、使用和贡献
- 开发测试工具以提升代码开发效率和测试覆盖度
- 根据版本计划制定测试计划和规划相应测试活动
- 制定、发布和维护管理版本发布标准
- 运作测试开放日活动，聚焦在新特性和重要组件的测试

# 组织会议
- 公开会议时间：北京时间每双周三 下午，4点~5点，请订阅qa@openeuler.org获取会议相关信息

# 成员
### Maintainer列表
- wu_fengguang
- charlie_li(@charlie_li), since October 2019
- wubodong(@walkingwalk), since November 2019
- kuhnchen(@kuhnchen18), since December 2019
- speacher
- rigorous
- lemon-higgins
- lutianxiong
- disnight, since December 2021

### Committer列表
- Air9(@air9),since january 2020
- wsf0824(@wsf0824),since December 2019
- panny060(@panny060),since December 2019
- jiuhanjiu(@jiuhanjiu),since December 2019


# maintainer/committer竞选&退出规则
### 基础规则
1. 竞选人责任心强、对QA sig有过可追溯的贡献
2. maintainer对sig发展的全局有清晰的了解并可提供建设性的意见，committer对负责的仓库/特性等有专业化的能力
3. 人数要求：maintainer [5, 9]; committer视社区的开发类sig定，暂不设上限，不建议超过15个
4. 竞选过程公开民主，尽快有结论，针对遗留问题有具体动作能够快速闭环
5. committer竞选每季度一次，maintainer竞选每半年一次，每半年进行已有成员的贡献审视

### maintainer竞选规则(每年1月/7月)：
1. 成为commiter时间超一个季度以上，且持续半年参与QA-sig例会（与会率>=75%）
2. 作为特性测试owener参与社区版本发布测试，按流程在社区和测试平台记录全流程信息（过程数据/测试策略/测试报告/问题数据等）(QA所属仓库pr+社区缺陷类issue 总数大于 40)
3. 作为测试专家，为社区从零构建1项及以上的专项测试能力且纳入版本运作
4. 其余一系列为QA带来较大影响的贡献（流程变更/工程能力等）
PS：除1为必选项外，其余满足一项即可，最终结论以例会评审结论为准

### committer竞选规则(每年1月/4月/7月/10月)：
1. 持续一个季度参与QA-sig例会（与会率>=75%）
2. 作为社区特性测试人员参与一个特性的测试，并在社区和测试平台有一定的贡献(QA所属仓库pr+社区缺陷类issue 总数大于 20)
3. 作为测试工程师，参与1项及以上的社区专项测试的构建、贡献及维护(pr及issue数量要求同2)
4. 其余一系列为QA带来的贡献（流程变更/工程能力等）
PS：除1为必选项外，其余满足一项即可，最终结论以例会评审结论为准

### maintainer/committer退出规则
1. 近6个月没有在QA-sig没有贡献
2. 将历史贡献记录在QA和community的文档中

### maintainer/committer交接机制
1. 需在committer竞选例会前一个月，以社区邮件主送[qa邮箱](qa@openeuler.org)提出交接请求，并于最近一次committer竞选例会评审
2. 交接人员的贡献最低需达到committer的要求(qa参与时长可酌情放宽)

# 联系方式
- qa@openeuler.org

# 项目清单

项目名称：QA
repository地址：
  - https://gitee.com/openeuler/avocado
  - https://gitee.com/openeuler/avocado-vt
  - https://gitee.com/openeuler/tp-libvirt
  - https://gitee.com/openeuler/tp-qemu
  - https://gitee.com/openeuler/QA
  - https://gitee.com/openeuler/EulerRobot
  - https://gitee.com/openeuler/compiler-test
  - https://gitee.com/openeuler/package-reinforce-test
  - https://gitee.com/openeuler/integration-test
  - https://gitee.com/openeuler/container-test
  - https://gitee.com/openeuler/test-tools
  - https://gitee.com/openeuler/mugen

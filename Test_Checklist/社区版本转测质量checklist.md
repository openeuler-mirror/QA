| 序号 | 领域 | 检查项 | 执行 | 达成 | 选项 | 责任团队 | R1 | R2 | R3 | R4 | R5 | LTS | LTS-SPx | 创新 | 说明 |
| ---- | ---- | ----- | ---- | ---- | --- | -------| -- | -- | -- | -- | -- | --- | -------- | --- | ---- |
| 1 | issue解决 | 上版本遗留问题100%按原计划解决 | | | 必选 | 归属sig | <font color="00dd00">✔</font> | | | | | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | |
| 2 | | 严重/致命版本问题解决率达100% | | | 必选 | 归属sig | | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | (1) |
| 3 | | 版本问题解决率>80% | | | 必选 | 归属sig | | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | |
| 4 | | 版本问题解决率达100% | | | 必选 | 归属sig | | | | | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | |
| 5 | 需求管理 | 完成社区继承需求开发自验，并提供验证报告 | | | 可选 | 归属sig | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | | | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | |
| 6 | | 完成社区新增需求开发自验，并提供验证报告 | | | 可选 | 归属sig | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | |
| 8 | 构建及AT冒烟 | 满足构建健康度指标 | | | 必选 | infra | <font color="00dd00">✔</font> | | | | | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | (3) |
| 9 | | rpm包check通过率100% | | | 必选 | infra | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | (4) |
| 10 | | AT通过率100% | | | 必选 | QA | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | (5) |
| 11 | | 周防护网通过率100% | | | 必选 | QA | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | (6) |
| 12 | 包管理DT | 包管理功能(编译/安装/卸载) | | | 必选 | 归属sig | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | |
| 13 | | 包管理功能(升降级) | | | 必选 | 归属sig | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | | <font color="00dd00">✔</font> | | |
| 14 | | 软件包功能测试(命令/服务) | | | 可选 | 归属sig | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | <font color="00dd00">✔</font> | | |


* (1) 社区版本相关团队(RM/QA/归属sig等)达成一致意见版本遗留的问题(状态为已挂起)，也计入checklist的版本问题解决率。
* (3) 构建健康度指标：R1版本发布前有连续三天构建出全量镜像并通过AT可用。
* (4) rpm build中的```%check```阶段需打开并100%通过。如存在问题需解决或进行明确解释，并在合区以issue的形式呈现归档。
* (5) openqa对应版本用例通过率即AT通过率。
* (6) 结合compass-ci和radiaTest平台构建周防护网，进行全量集成用例自动化测试(截至2022/4/24仍在开发中)
* 表格首行R1~R5，指代社区版本转测过程中的转测轮次（转测轮次根据测试情况不同会进行增加）。
* RM指代社区[sig-release-management](https://gitee.com/openeuler/release-management)


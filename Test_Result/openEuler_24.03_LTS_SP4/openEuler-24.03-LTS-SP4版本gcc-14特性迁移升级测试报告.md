![avatar](../../images/openEuler.png)

版权所有 © 2026  openEuler社区

 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。



修订记录

| 日期       | 修订版本 | 修改描述                     | 作者   |
| ---------- | -------- | ---------------------------- | ------ |
| 2026/11/13 | v1.0     | gcc-14特性迁移升级测试报告   | 林涵杰 |



关键词： GCC 14、特性迁移、编译器优化、DejaGnu、SPEC CPU 2017



摘要：本报告描述 openEuler 24.03 LTS SP4 增强副版本 GCC 14 特性迁移升级（PR !396）的整体测试过程，覆盖继承特性回归测试、新增特性测试、升级兼容性核查、SPEC CPU 2017 性能测试及资料测试，对升级版本整体质量进行评估和总结。



缩略语清单：

| 缩略语   | 英文全名                             | 中文解释             |
| -------- | ------------------------------------ | -------------------- |
| GCC      | GNU Compiler Collection              | GNU 编译器套件       |
| PGO      | Profile-Guided Optimization          | 反馈导向优化         |
| AutoFDO  | Automatic Feedback-Directed Optimizer| 自动反馈导向优化     |
| AutoBOLT | Automatic Binary Optimization and Layout Tool | 自动二进制布局优化 |
| IPA      | Interprocedural Analysis             | 过程间分析           |
| ICP      | Indirect Call Promotion              | 间接调用提升         |
| SVE      | Scalable Vector Extension            | 可伸缩向量扩展       |
| SLP      | Superword-Level Parallelism          | 超字级并行向量化     |
| SFC      | Static Field Compression             | 静态结构体字段压缩   |
| DFC      | Dynamic Field Compression            | 动态结构体字段压缩   |



# 1     特性概述

openEuler 在主版本编译器 GCC 12.3.1 上以补丁形式维护了一批性能优化特性，`gcc-14` 分支此前尚未包含。本次升级通过 `openeuler/gcc` 仓库 PR !396（合入提交 `91d224b53`，升级基线为 `src-openeuler/gcc-14` 14.3.1-19 同步点 `e3382e03e`，生成制品仓补丁 `0132–0160`）将 **29 个特性提交**（涉及 688 个文件，+80,595 / −533 行，含 382 个新增测试文件）迁移至 `gcc-14`，使能增强副版本在 SPEC CPU 2017 Intrate 上对比开源社区版本实现 ≥15% 的性能提升。



# 2     特性测试信息

| 版本名称                                    | 测试起始时间 | 测试结束时间 |
| ------------------------------------------- | ------------ | ------------ |
| openEuler 24.03 LTS SP4（功能与性能测试）   | 2026/09/09   | 2026/09/15   |
| openEuler 24.03 LTS SP4（迁移前后对比验证） | 2026/11/11   | 2026/11/11   |

| 硬件型号             | 硬件配置信息             | 备注                                   |
| -------------------- | ------------------------ | -------------------------------------- |
| aarch64 容器         |                          | DejaGnu 功能测试及特性迁移前后对比验证 |
| Kunpeng 920 (docker) | openEuler 24.03 LTS SP4  | 基础功能测试                           |
| Kunpeng 950          | openEuler 24.03 LTS SP3  | SPEC CPU 2017 性能测试                 |



# 3     测试结论概述

## 3.1   测试整体结论

继承特性测试：使用 DejaGnu 中与上游保持不变的既有测试集验证编译器原有功能。合入特性后的单版本回归测试覆盖 9 个上游测试集（278,104 PASS）；特性迁移前后双版本对比验证在相同环境下分别构建未合入迁移特性的原版本（提交 `e3382e03e`）与合入 29 个迁移特性后的新版本（提交 `91d224b53`），覆盖 12 个上游测试集（279,563 PASS），迁移前后两个版本逐个测试文件比对结果完全一致（唯一失败项 `sve-memcall-inline.c` 在迁移前后均因测试源码缺失头文件报错，非本次迁移引入）；同时完成 `bstest`、`llvmcase`、`Anghabench`、`jotai`、`codedb`、`fuzz` 基础回归测试，确认本次迁移未引入既有功能回归。

新增特性测试：针对 PR !396 新增的 7 个 openEuler DejaGnu 测试集（382 个新增测试文件，共 1,152 PASS / 43 XFAIL / 1 FAIL / 1 UNRESOLVED / 6 UNSUPPORTED），对 29 个迁移特性进行专项验证；其中 22 个特性通过新增专用用例验证，其余受测试环境缺失插件或尚无专用用例影响（详见 4.1.2 节与第 6 章附件）。

性能测试：覆盖 SPEC CPU 2017 Intrate 负载测试，对比开源 GCC 14.3.0 综合性能提升 **15.96%**（`570 → 661`），符合 ≥15% 的性能提升需求，无遗留代码缺陷，整体质量良好。

| 测试活动    | 测试子项        | 活动评价                 |
| ----------- | --------------- | ------------------------ |
| 功能测试    | 继承特性测试    | 测试通过                 |
| 功能测试    | 新增特性测试    | 基本通过（部分待补测）   |
| 兼容性测试  | 升级兼容性测试  | 测试通过（见约束说明）   |
| DFX专项测试 | 性能测试        | 测试通过                 |
| DFX专项测试 | 可靠性/韧性测试 | 不涉及                   |
| DFX专项测试 | 安全测试        | 不涉及                   |
| 资料测试    | 外部文档测试    | 测试通过                 |
| 其他测试    | /               | 不涉及                   |

## 3.2   约束说明

1. **Pass 重编号引起的既有调试/控制选项变化**：提交 `b2c1e11fa` 在优化管线中新增了 `ccp`、`cd_dce`、`early_vrp`、`forwprop` 实例，导致同类 pass 编号顺延。升级后使用 `-fdisable-tree-evrp` 或 `-fenable-tree-evrp` 会报错退出（`unknown pass tree-evrp`），需改用 **`evrp1`**；`-fdump-tree-evrp` 仍被接受，但生成的 dump 文件后缀变为 `.evrp1`（`ccp`、`cd_dce`、`forwprop` 的 dump 编号同样顺延）。该行为与 openEuler `gcc-12` 一致。
2. **废弃实验性选项显式退役**：`-falias-analysis-expand-ssa` 与 `-fchrec-mul-fold-strict-overflow` 已在本次迁移中正式退役，编译时传入上述选项会报错退出。

## 3.3   遗留问题分析

### 3.3.1 遗留问题影响以及规避措施

不涉及（未发现新增软件功能缺陷；测试容器环境缺失外部插件及基线历史测试缺头文件的分析见 4.1 节与第 6 章附件）。

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   | 0        | 0    | 0    | 0    | 0      |
| 百分比 | 0%       | 0%   | 0%   | 0%   | 0%     |



# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 继承特性测试结论

继承特性测试聚焦 DejaGnu 中与上游保持不变的既有测试集及基础回归集，通过对比未合入迁移特性的原版本（提交 `e3382e03e`）与合入 29 个迁移特性后的新版本（提交 `91d224b53`），验证 GCC 14 原有编译与运行时功能无回归。各继承子模块质量评估如下：

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | C 前端与中端优化回归（`gcc.dg`、`tree-ssa`、`vect`） | <font color=green>■</font> | 单版本回归测试通过 55,581 条、失败 0 条；与迁移前原版本（`e3382e03e`）逐个测试文件对比，结果完全一致 |
| 2 | C++ 前端与中端优化回归（`g++.dg`、`g++.dg/vect`） | <font color=green>■</font> | `g++.dg` 通过 151,448 条、失败 0 条，含 `g++.dg/vect` 共通过 152,070 条；与迁移前原版本逐个测试文件对比，结果完全一致 |
| 3 | Fortran 前端与中端优化回归（`gfortran.dg`、`gfortran.dg/vect`） | <font color=green>■</font> | `gfortran.dg` 通过 54,762 条、失败 0 条，含 `gfortran.dg/vect` 共通过 54,882 条；与迁移前原版本逐个测试文件对比，结果完全一致 |
| 4 | AArch64 后端代码生成回归（`aarch64.exp`） | <font color=green>■</font> | C 测试集通过 5,561 条，含 C++ 测试集共通过 6,276 条；唯一失败项为迁移前已存在的测试源码缺头文件问题，迁移前后对比结果完全一致 |
| 5 | OpenMP / OpenACC 与事务内存运行时库回归（`libgomp`、`libitm`） | <font color=green>■</font> | 共通过 10,752 条、失败 0 条；与迁移前原版本逐个测试文件对比，结果完全一致 |
| 6 | 补充基础回归测试套（`bstest`、`llvmcase`、`Anghabench`、`jotai`、`codedb`、`fuzz`） | <font color=green>■</font> | 在 `Kunpeng 920 (docker)` 环境执行通过 |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题

<font color=green>■</font>： 表示特性质量良好

DejaGnu 上游既有测试集两项测试的详细统计如下：

1. **合入迁移特性后的单版本回归测试结果（2026/09/09，9 个上游测试集）**：对合入 PR !396 后的编译器执行 9 个上游测试集，共执行 **278,104 PASS / 2,230 XFAIL / 1 FAIL / 6 UNRESOLVED / 11,477 UNSUPPORTED / 0 XPASS**。唯一未通过项 `gcc.target/aarch64/sve-memcall-inline.c`（1 FAIL + 6 UNRESOLVED）因测试源码缺少 `#include <stddef.h>` 导致，由迁移前已合入的历史提交 `ce9fd5f93` 引入，与本次特性迁移无关。

| 测试集 | PASS | XFAIL | FAIL | UNRESOLVED | UNSUPPORTED |
| :--- | ---: | ---: | ---: | ---: | ---: |
| `gcc.dg/dg.exp` | 37,566 | 533 | 0 | 0 | 327 |
| `gcc.dg/tree-ssa/tree-ssa.exp` | 8,236 | 73 | 0 | 0 | 47 |
| `gcc.dg/vect/vect.exp` | 9,779 | 257 | 0 | 0 | 55 |
| `gcc.target/aarch64/aarch64.exp` | 5,561 | 20 | 1 | 6 | 12 |
| `g++.dg/dg.exp` | 151,448 | 1,070 | 0 | 0 | 10,633 |
| `gfortran.dg/dg.exp` | 54,762 | 44 | 0 | 0 | 124 |
| `libgomp.fortran/fortran.exp` | 4,441 | 18 | 0 | 0 | 102 |
| `libgomp.oacc-fortran/fortran.exp` | 6,293 | 214 | 0 | 0 | 176 |
| `libitm.c++/c++.exp` | 18 | 1 | 0 | 0 | 1 |
| **合计** | **278,104** | **2,230** | **1** | **6** | **11,477** |

2. **特性迁移前后双版本对比验证结果（2026/11/11，12 个上游测试集）**：在同一容器与相同构建配置下，分别构建未合入迁移特性的原版本（提交 `e3382e03e`）与合入迁移特性后的新版本（提交 `91d224b53`），运行同一组 `.exp` 驱动。除上述 9 个测试集外，`vect.exp` 与 `aarch64.exp` 同时匹配执行了 `g++.dg/vect`（622 PASS）、`g++.target/aarch64`（715 PASS）、`gfortran.dg/vect`（120 PASS）（另含 Git 源码树中的 `pr124138.c` 2 PASS），合计覆盖 12 个上游测试集。迁移前原版本与迁移后新版本的结果完全相同，均为 **279,563 PASS / 2,243 XFAIL / 1 FAIL / 6 UNRESOLVED / 11,507 UNSUPPORTED**，逐个测试文件对比各状态条数无任何差异。PR !396 对 181 个上游测试文件的修改均为适配性调整（180 个同步调整 pass 重编号后的 dump 文件名，1 个在 `completion-1.c` 补充新选项 `-fipa-ic`），未新增 `xfail`。

### 4.1.2 新增特性测试结论

新增特性测试聚焦 PR !396 新增的 7 个 openEuler DejaGnu 测试集（共 382 个新增测试文件，分布为 `gcc.dg/openeuler/` 309 个、`gcc.target/aarch64/` 41 个、`gfortran.dg/openeuler/` 18 个、`g++.dg/openeuler/` 13 个、`lib/oeaware.exp` 1 个），专项验证迁移特性的优化变换触发（dump 扫描）、运行结果正确性（`dg-do run`）、AArch64 指令生成（`scan-assembler`）、不安全输入反例拦截以及新旧选项界面行为：

| 测试集 | PASS | XFAIL | FAIL | UNRESOLVED | UNSUPPORTED |
| :--- | ---: | ---: | ---: | ---: | ---: |
| `gcc.dg/openeuler/openeuler.exp` | 366 | 13 | 0 | 0 | 2 |
| `gcc.dg/openeuler/prof/openeuler-prof.exp` | 2 | 0 | 1 | 1 | 0 |
| `gcc.dg/openeuler/struct/struct-reorg.exp` | 586 | 24 | 0 | 0 | 0 |
| `gcc.target/aarch64/openeuler/openeuler.exp` | 103 | 4 | 0 | 0 | 0 |
| `g++.dg/openeuler/openeuler.exp` | 29 | 0 | 0 | 0 | 3 |
| `g++.dg/openeuler/struct/struct-reorg.exp` | 21 | 0 | 0 | 0 | 0 |
| `gfortran.dg/openeuler/openeuler.exp` | 45 | 2 | 0 | 0 | 1 |
| **合计** | **1,152** | **43** | **1** | **1** | **6** |

> 说明：
> - **43 条 XFAIL（0 XPASS）**：Struct-Reorg / DFC / SFC 共 24 条（12 个文件，与 `gcc-12` 原测试集逐文件比对 12/12 一致）；`localize-array-*`（5 条）与 `alignprop-*`（3 条）采用“扫描变换信息 + `xfail`”编写安全反例，XFAIL 代表预期未变换；其余 11 条分布于 `if-split-3/-5`（4 条）、`mul-widen128-*`（3 条）、`awiden-compare-unsafe-1`（1 条）、`kernel-pgo-3`（1 条）、`simdmath-link-2/-3.f90`（2 条），测试源码内均有注释记录对应已知边界。
> - **6 条 UNSUPPORTED**：均为 `simdmath` 链接类用例（`simdmath-link-c-1/-2.c`、`simdmath-modules-1.C` ×3、`simdmath-link-1.f90`），探测到环境无 `-lmathlib` 后自动跳过。
> - **1 FAIL + 1 UNRESOLVED**：`auto-bolt-1.c` 在 `-fprofile-generate` 编译与运行均 PASS，`-fprofile-use -fauto-bolt` 阶段因容器缺少 `libbolt_plugin.so` 按设计报错退出。

PR !396 全部 29 个迁移特性在新增测试集下的逐项质量评估如下：

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| 1 | `-fsimdmath`、`-ffp-model=`、`-mdaz-ftz`（`fa6ea8268`） | <font color=green>■</font> | 新增 92 个测试文件：198 PASS / 2 XFAIL（另有 6 条链接用例因容器环境未安装 `libmathlib` 标记为 UNSUPPORTED） |
| 2 | `-mmul-widen128`（`946510c20`） | <font color=green>■</font> | 新增 34 个测试文件：87 PASS / 3 XFAIL |
| 3 | `-fkernel-pgo`（`e2975d204`） | <font color=green>■</font> | 新增 3 个测试文件：6 PASS / 1 XFAIL |
| 4 | `-mcpu=tsv110` 调优（`a266a9a31`） | <font color=blue>▲</font> | 代码已合入，尚未编写专用 DejaGnu 用例 |
| 5 | `libgomp` 启用 `-moutline-atomics`（`b3afec08a`） | <font color=green>■</font> | 未新增专用测试文件，由上游 `libgomp` 两个回归测试集（共 10,734 PASS / 0 FAIL）间接覆盖验证 |
| 6 | `-fbuiltin-will-return`（`9e6740ade`） | <font color=green>■</font> | 新增 4 个测试文件：8 PASS |
| 7 | `-farray-widen-compare`（`cc6d896af`） | <font color=green>■</font> | 新增 14 个测试文件：32 PASS / 1 XFAIL |
| 8 | AutoBOLT：`-fauto-bolt`、`-fbolt-use`（`9b4fe732b`） | <font color=blue>▲</font> | 新增 2 个测试文件：2 PASS / 1 FAIL / 1 UNRESOLVED（容器环境未安装 `libbolt_plugin.so`，待补充插件环境复测） |
| 9 | AutoFDO 扩展（`c9457b14e`） | <font color=blue>▲</font> | 代码已合入，尚未编写专用 DejaGnu 用例 |
| 10 | AES 模式匹配：`-fcrypto-accel-aes`（`88b5bcdbf`） | <font color=green>■</font> | 新增 2 个测试文件：10 PASS |
| 11 | GIMPLE if-conversion：`-fif-conversion-gimple`（`826ab0419`） | <font color=green>■</font> | 新增 2 个测试文件：10 PASS |
| 12 | `-fuaddsub-overflow-match-all`（`1402c8735`） | <font color=green>■</font> | 新增 2 个测试文件：5 PASS |
| 13 | 间接调用提升 ICP：`-ficp`、`-ficp-speculatively`（`913124aab`） | <font color=green>■</font> | 新增 7 个测试文件：31 PASS |
| 14 | 退役 `-falias-analysis-expand-ssa`（`bc990017c`） | <font color=green>■</font> | 新增 2 个测试文件：3 PASS（验证传入废弃选项时按预期报错退出） |
| 15 | 退役 `-fchrec-mul-fold-strict-overflow`（`4d98c530a`） | <font color=green>■</font> | 新增 2 个测试文件：3 PASS（验证传入废弃选项时按预期报错退出） |
| 16 | `-floop-crc`（`8d85000c0`） | <font color=green>■</font> | 新增 5 个测试文件：14 PASS |
| 17 | `-floop-sve-mode-opt`（`efd851ecd`） | <font color=green>■</font> | 新增 7 个测试文件：14 PASS |
| 18 | `-fipa-prefetch`、`-fipa-ic` 及预取参数（`d24b19883`） | <font color=green>■</font> | 新增 2 个测试文件：10 PASS |
| 19 | Struct-Reorg 系列：`-fipa-struct-reorg`、`-fipa-reorder-fields`、`-fipa-struct-sfc*`（`98b0b1f05`） | <font color=green>■</font> | 新增 134 个测试文件：553 PASS / 20 XFAIL（其中 11 个 `struct_reorg-*.c` 未被 `.exp` 通配规则收录，与 openEuler `gcc-12` 分支保持一致） |
| 20 | `-ffind-with-sve`（`3e72ae894`） | <font color=green>■</font> | 新增 2 个测试文件：4 PASS |
| 21 | `-floop-elim`（`5cd4cbb88`） | <font color=green>■</font> | 新增 4 个测试文件：9 PASS |
| 22 | RTL ifcvt 复杂比较与寄存器重命名：`-fifcvt-allow-complicated-cmps` 等（`5a7c5d124`） | <font color=green>■</font> | 新增 4 个测试文件：8 PASS |
| 23 | `-ftree-slp-late`（`f40cce1ab`） | <font color=blue>▲</font> | 代码已合入，尚未编写专用 DejaGnu 用例 |
| 24 | `-fif-split` 与 3 个向量化参数（`4c7fed43f`） | <font color=green>■</font> | 新增 13 个测试文件：33 PASS / 4 XFAIL |
| 25 | CFGO、CSPGO、oeAware（`5e1318885`） | <font color=green>■</font> | 新增 12 个测试文件：30 PASS |
| 26 | `-march=native` 查找修复（`d37cea4e3`） | <font color=blue>▲</font> | 新增 2 个测试文件位于 `cpunative/` 目录，本次执行未包含该目录 |
| 27 | `hip10a`、`hip10c`、`hip11` 核支持（`95c5ef6d1`） | <font color=blue>▲</font> | 代码已合入，尚未编写专用 DejaGnu 用例 |
| 28 | 动态结构体字段压缩 DFC：`-fipa-struct-dfc*`（`727ec21e6`） | <font color=green>■</font> | 新增 14 个测试文件：54 PASS / 4 XFAIL |
| 29 | `-fipa-alignment-propagation`、`-fipa-localize-array`、`-fipa-array-dse`（`b2c1e11fa`） | <font color=green>■</font> | 新增 17 个测试文件：28 PASS / 8 XFAIL |

<font color=red>●</font>： 表示特性不稳定，风险高

<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题（或待补测验证）

<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论

针对 `gcc-14` 从升级前基线（`14.3.1-19` / `e3382e03e`）到合入迁移特性后（`91d224b53`）的自身升级兼容性结论如下：

1. **默认编译行为与二进制 ABI 兼容**：本次迁移中涉及结构体内存布局改写的优化（如 `-fipa-struct-reorg`、`-fipa-struct-sfc`、`-fipa-struct-dfc`）以及激进推测优化均默认关闭，仅在显式指定对应编译选项时生效。在常规 `-O0` / `-O2` / `-O3` 编译选项下不改变既有 ABI，上游 12 个测试集 279,563 条用例逐文件一致以及 `Kunpeng 920 (docker)` 环境上 SPEC CPU 2017 Intrate 10/10 基准在 `-O3 -march=native` 下零修补构建与运行出分，确认默认路径完全兼容。
2. **命令行选项兼容性**：除 3.2 节约束说明中列出的 `-fdisable-tree-evrp` / `-fenable-tree-evrp` 需改用 `evrp1` 以及 2 个显式退役选项报错退出外，其余既有编译选项保持兼容。

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论

性能指标达成情况汇总如下：

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
| SPEC CPU 2017 Intrate | `SPECrate2017_int_base` 对比开源 GCC 14.3.0 性能提升比例 | 目标 ≥ 15%（实测 **15.96%**） | 测试通过 |

在 Kunpeng 950（openEuler 24.03 LTS SP3）环境下执行的 SPEC CPU 2017 Intrate 各子项详细得分如下：

| 子项                  | gcc14.3.0 | openEuler/gcc-14 | 性能提升 |
| --------------------- | --------- | ---------------- | -------- |
| 500.perlbench_r       | 540       | 560              | 3.70%    |
| 502.gcc_r             | 534       | 545              | 2.06%    |
| 505.mcf_r             | 407       | 1030             | 153.07%  |
| 520.omnetpp_r         | 279       | 324              | 16.13%   |
| 523.xalancbmk_r       | 419       | 485              | 15.75%   |
| 525.x264_r            | 1350      | 1310             | -2.96%   |
| 531.deepsjeng_r       | 611       | 667              | 9.17%    |
| 541.leela_r           | 573       | 677              | 18.15%   |
| 548.exchange2_r       | 1580      | 1560             | -1.27%   |
| 557.xz_r              | 353       | 349              | -1.13%   |
| SPECrate2017_int_base | 570       | 661              | 15.96%   |

**结论**：在 SPEC CPU 2017 Intrate 上对比开源社区版本 GCC 14.3.0 综合性能提升 **15.96%**，达成 ≥15% 的需求目标。其中内存密集型基准 `505.mcf_r`（+153.07%）及 4 个 C++ 基准（+9.17% ~ +18.15%）提升显著；`525.x264_r`、`548.exchange2_r`、`557.xz_r` 存在 -1.13% ~ -2.96% 的小幅波动（剔除 `505.mcf_r` 后其余 9 项几何平均提升约为 6.36%）。

### 4.3.2 可靠性/韧性测试结论

不涉及

### 4.3.3 安全测试结论

不涉及

## 4.4 资料测试结论

| 测试类型 | 测试内容     | 文档链接                                                     | 测试结论 |
| -------- | ------------ | ------------------------------------------------------------ | -------- |
| 文档测试 | 外部文档测试 | https://gitcode.com/openeuler/gcc/pull/396<br/>https://gitcode.com/openeuler/compiler-docs/pull/108<br/>https://gitcode.com/openeuler/compiler-docs/pull/113 | 测试通过 |

## 4.5 其他测试结论

不涉及



# 5     测试执行

## 5.1   测试执行统计数据

| 版本名称                                                                    | 测试用例数                      | 用例执行结果                                                 | 发现问题单数 |
| --------------------------------------------------------------------------- | ------------------------------- | ------------------------------------------------------------ | ------------ |
| openEuler 24.03 LTS SP4（继承特性：9 个上游 DejaGnu 测试集回归）            | 291,818                         | 278,104 PASS / 2,230 XFAIL / 11,477 UNSUPPORTED / 1 FAIL / 6 UNRESOLVED | 0            |
| openEuler 24.03 LTS SP4（继承特性：12 个上游 DejaGnu 测试集迁移前后对比）   | 293,320                         | 279,563 PASS / 2,243 XFAIL / 11,507 UNSUPPORTED / 1 FAIL / 6 UNRESOLVED（与未合入特性的原版本 `e3382e03e` 逐文件结果完全一致） | 0            |
| openEuler 24.03 LTS SP4（新增特性：7 个新增 openEuler DejaGnu 测试集）      | 1,203（对应 382 个新增测试文件） | 1,152 PASS / 43 XFAIL / 6 UNSUPPORTED / 1 FAIL / 1 UNRESOLVED | 0            |
| openEuler 24.03 LTS SP4（性能测试：SPEC CPU 2017 Intrate）                  | 11（10 个基准子项 + specrand）  | 测试通过                                                     | 0            |

## 5.2   后续测试建议

1. **选项变更处理**：确认是否为 `-fdisable-tree-evrp` / `-fenable-tree-evrp` 保留兼容别名，或在版本发行说明中明确提示用户改用 `evrp1`。
2. **补充上游关联测试集与实机验证**：在 openEuler 24.03 LTS SP4 + Kunpeng 实机（启用 bootstrap 的 RPM 制品构建）上补跑 `gcc.dg/ipa`、`gcc.dg/tree-prof`、`gcc.dg/lto`、`gcc.c-torture`、`gcc.dg/torture` 及 `libstdc++-v3` 测试套。
3. **闭环待补测特性**：在包含 `libbolt_plugin.so` 与 `libmathlib` 的完整环境中补测 `AutoBOLT` 与 `simdmath` 链接用例（并为 `auto-bolt-1.c` 增加插件探测）；将 `gcc.target/aarch64/cpunative/` 纳入执行；为 `tsv110`、`hip10a/hip10c/hip11`、`-ftree-slp-late`、`AutoFDO 扩展` 补充专用验证用例。



# 6     附件

1. **被测代码变更范围**
   - 源码仓库与 PR：`https://gitcode.com/openeuler/gcc/pull/396`（分支 `gcc-14`，未合入迁移特性的原版本提交 `e3382e03e`，合入迁移特性后的版本提交 `91d224b53`，共 29 个特性提交 `fa6ea8268..b2c1e11fa`，对应 `src-openeuler/gcc-14` 补丁 `0132–0160`）

2. **DejaGnu 构建与执行配置**
   - 构建 `configure` 参数：`--disable-bootstrap --disable-multilib --enable-languages=c,c++,fortran --enable-checking=release --with-system-zlib`（被测编译器版本 `14.3.1 20250523`，单用例超时 `300s`）
   - 特性迁移前后双版本对比验证执行的测试驱动：`check-gcc`（`RUNTESTFLAGS="dg.exp openeuler.exp openeuler-prof.exp struct-reorg.exp tree-ssa.exp vect.exp aarch64.exp"`）、`libitm`（`c++.exp`）、`libgomp`（`fortran.exp`）

3. **异常与边界项复核记录**

| 复核项 | 复核方法 | 复核结果 |
| :--- | :--- | :--- |
| `sve-memcall-inline.c` 失败原因 | 分别在基线 `e3382e03e` 与外部 GCC 13.3.0 上编译测试源码同一声明 | 均报 `unknown type name 'size_t'`（源码缺 `#include <stddef.h>`），确认为基线既有缺陷 |
| `auto-bolt-1.c` 失败原因 | 检查测试日志并在容器内全盘查找 `libbolt_plugin.so` | 容器内不存在该插件，驱动按预期报错退出 |
| `simdmath` UNSUPPORTED 原因 | 检查 `gcc.log` 并在容器内查找 `libmathlib` | 链接探测步骤 `cannot find -lmathlib`，容器内无该库，按设计跳过 |
| `Struct-Reorg` XFAIL 来源 | 将新增测试中 12 个含 `xfail` 的文件与 `gcc-12` 分支 `gcc/testsuite/gcc.dg/struct/` 逐文件比对 | 12/12 一致，继承自源特性已知边界 |
| `-fdisable-tree-evrp` 行为变化 | 使用升级后编译器分别验证 `-fdisable-tree-evrp` 与 `-fdisable-tree-evrp1` | `-fdisable-tree-evrp` / `-fenable-tree-evrp` 报错退出码 1；改用 `evrp1` 正常通过 |

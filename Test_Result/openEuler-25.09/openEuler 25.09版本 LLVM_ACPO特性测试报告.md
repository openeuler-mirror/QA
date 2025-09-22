![avatar](../../images/openEuler.png)

版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期       | 修订   版本 | 修改描述                 | 作者       |
| ---------- | ----------- | ------------------------ | ---------- |
| 2025/09/11 | v 0.0.1     | 新增ACPO继承特性测试结果 | xiongyikun |

关键词： ACPO，软件包引入

摘要：针对新增ACPO特性, 检查版本使能ACPO后的构建, 模型训练,模型推理, 并基于Cbench中部分用例做功能测试, 当前测试目标为达成功能正常且性能不劣化, 暂不做性能优化指标。

缩略语清单：

| 缩略语  | 英文全名                                            | 中文解释            |
| ---- | ----------------------------------------------- | --------------- |
| ACPO | AI-Enabled Compiler-driven Program Optimization | 基于AI的编译器驱动的程序优化 |

# 1     特性概述

ACPO(AI-Enabled Compiler Driven Program Optimization)是致力于将编译器与AI能力融合的开发框架，在编译优化中基于AI模型决策，提升程序执行性能。  
主要工具特点：  

- 框架具有训练、推理、特征质量控制（FQC）等工具，可简化在编译器中使用ML模型

- 模型与框架解耦，用户可以根据任务类型设计相应模型进行训练。 

- 工具提供一组标准接口，只要输入/输出格式匹配，即可将模型适配到编译器中进行推理。

- 提供两种模型示例，Function Inline与Loop Unroll。

# 2     特性测试信息

本章节描述被测对象的版本信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称        | 测试起始时间 | 测试结束时间 |
| --------------- | ------------ | ------------ |
| openEuler 25.09 | 2025/08/13   | 2025/08/20   |

描述特性测试的硬件环境信息

| 硬件型号      | 硬件配置信息 | 备注      |
| --------- | ------ | ------- |
| 鲲鹏 920 主机 | NA     | aarch64 |

# 3     测试结论概述

## 3.1   测试整体结论

共进行两轮测试，执行测试benchmark（CBench）用例，主要测试内容包括以下四部分,其中包括了功能测试、性能测试和可靠性测试，共发现0个问题，遗留问题数0,整体质量良好。

| 测试活动 | 测试子项                      | 活动评价         |
| ---- | ------------------------- | ------------ |
| 功能测试 | 使能ACPO并构建编译器              | 测试通过         |
| 功能测试 | 使用提供的ACPO源代码进行模型训练        | 测试通过         |
| 功能测试 | 使用训练好的模型进行推理,使用perf统计执行时间 | 测试通过,性能表现无劣化 |
| 功能测试 | YUM安装方式使能ACPO             | 测试通过,性能表现无劣化 |

# 4 详细测试结论

## 4.1 功能测试

### 4.1.1 编译器构建

- 下载[llvm-project](https://gitee.com/openeuler/llvm-project)源码(dev_17.0.6分支), 在llvm-project/llvm/CMakeLists.txt中添加ACPO使能选项``add_definitions( -DENABLE_ACPO )``, 并执行``bash build.sh -E -i -f -j 100``, 编译器可以构建成功

| 测试子项             | 测试结论                          | 备注  |
| ---------------- |:-----------------------------:| --- |
| 使能ACPO构建编译器      | <font color=green>PASS</font> | -   |
| 使能ACPO编译器构建后安装测试 | <font color=green>PASS</font> | -   |

### 4.1.2 模型训练测试

下载[ACPO](https://gitee.com/src-openeuler/ACPO)源码包, 解压zip包,进入ACPO/ACPO-model/src路径下执行, 具体参数可参考train.py同级目录下``settings.py``参数描述:

```shell
python train.py --root-path . --user-config ../test/config/user_train_config.json --save-model --epochs 1 --task classification --algorithm nn --cv kfold --folds 2 --loss cross_entropy --batch-size 16 --test-batch-size 16 --lr 0.001
```

| 测试子项    | 测试结论                          | 备注  |
| ------- |:-----------------------------:| --- |
| 小样本模型训练 | <font color=green>PASS</font> | -   |

### 4.1.3 数据推理测试(使用自训练模型)

- 测试运行脚本:

```shell
# Scripts Name: acpocaserun.sh
Clang="/home/featuretest/tmp_test/llvm-project/build/bin/clang"
SRC_DIR="$1/src"
export ACPO_DIR=/home/featuretest/tmp_test/llvm-project/ACPO-master
cd $SRC_DIR
if [ "$2" = "ACPO" ]; then
  $Clang -O3 -mllvm -enable-acpo-fi -mllvm -acpo-verbose-fi -lm *.c
else
  $Clang -O3 -lm *.c
fi
numactl --localalloc --physcpubind=1 perf stat -r5 bash ./__run 1
```

- 使能ACPO推理:
  
  - 下载cbench后,执行``bash acpocaserun.sh security_sha ACPO``运行security_sha用例,对比执行时间无劣化

| 测试子项       |           测试结论            | 备注                               |
| -------------- | :---------------------------: | ---------------------------------- |
| 自训练模型推理 | <font color=green>PASS</font> | 推理结果正确, 使能ACPO后性能提升8% |

### 4.1.4 数据推理测试(AOT模式, 使用预训练模型)

- 将4.1.3中的测试脚本替换为下列内容

```shell
# Scripts Name: acpocaserun_aot.sh
Clang="/home/featuretest/tmp_test/llvm-project/build/bin/clang"
SRC_DIR="$1/src"
export ACPO_DIR=/home/featuretest/tmp_test/llvm-project/ACPO-master
cd $SRC_DIR
if [ "$2" = "ACPO" ]; then
  $Clang -O3 -mllvm -enable-acpo-fi-aot -mllvm -acpo-verbose-fi -lm *.c
else
  $Clang -O3 -lm *.c
fi
numactl --localalloc --physcpubind=1 perf stat -r5 bash ./__run 1
```

| 测试子项                |           测试结论            | 备注                                 |
| ----------------------- | :---------------------------: | ------------------------------------ |
| 预训练模型(AOT模式)推理 | <font color=green>PASS</font> | 推理结果正确, 使能ACPO后性能基本持平 |

### 4.1.5 YUM安装方式使能ACPO

#### 4.1.5.1 安装ACPO和CLANG

| 测试子项       | 测试结论                          | 备注  |
| ---------- |:-----------------------------:| --- |
| YUM安装ACPO  | <font color=green>PASS</font> | -   |
| YUM安装CLANG | <font color=green>PASS</font> | -   |

#### 4.1.5.2 模型训练

进入ACPO安装目录(默认路径为``/usr/lib/python3.xx/site-packages/ACPO``), 解压zip包,进入ACPO/ACPO-model/src路径下执行, 具体参数可参考train.py同级目录下`settings.py`参数描述:

```shell
python train.py --root-path . --user-config ../test/config/user_train_config.json --save-model --epochs 1 --task classification --algorithm nn --cv kfold --folds 2 --loss cross_entropy --batch-size 16 --test-batch-size 16 --lr 0.001
```

| 测试子项    | 测试结论                          | 备注  |
| ------- |:-----------------------------:| --- |
| 小样本模型训练 | <font color=green>PASS</font> | -   |

#### 4.1.5.3 数据推理测试(使用自训练模型)

- 测试运行脚本:

```shell
# Scripts Name: acpocaserun.sh
Clang="/usr/bin/clang"
SRC_DIR="$1/src"
export ACPO_DIR=/usr/lib/python3.11/site-packages/ACPO
cd $SRC_DIR
if [ "$2" = "ACPO" ]; then
  $Clang -O3 -mllvm -enable-acpo-fi -mllvm -acpo-verbose-fi -lm *.c
else
  $Clang -O3 -lm *.c
fi
numactl --localalloc --physcpubind=1 perf stat -r5 bash ./__run 1
```

- 使能ACPO推理:
  
  - 下载cbench后,执行`bash acpocaserun.sh security_sha ACPO`运行security_sha用例,对比执行时间无劣化

| 测试子项    | 测试结论                          | 备注                      |
| ------- |:-----------------------------:| ----------------------- |
| 自训练模型推理 | <font color=green>PASS</font> | 推理结果正确, 使能ACPO后性能提升7.8% |

#### 4.1.5.4 数据推理测试(AOT模式, 使用预训练模型)

- 将4.1.5.3中的测试脚本替换为下列内容

```shell
# Scripts Name: acpocaserun.sh
Clang="/usr/bin/clang"
SRC_DIR="$1/src"
export ACPO_DIR=/usr/lib/python3.11/site-packages/ACPO
cd $SRC_DIR
if [ "$2" = "ACPO" ]; then
  $Clang -O3 -mllvm -enable-acpo-fi-aot -mllvm -acpo-verbose-fi -lm *.c
else
  $Clang -O3 -lm *.c
fi
numactl --localalloc --physcpubind=1 perf stat -r5 bash ./__run 1
```

| 测试子项           | 测试结论                          | 备注                    |
| -------------- |:-----------------------------:| --------------------- |
| 预训练模型(AOT模式)推理 | <font color=green>PASS</font> | 推理结果正确, 使能ACPO后性能提升1% |

# 5 测试执行

| 版本名称        | 测试用例数 | 用例执行结果 | 发现问题单数 |
| --------------- | ---------- | ------------ | ------------ |
| openEuler 25.09 | 8          | 100% 通过    | 0            |

性能测试结果总结:

| 测试子项                            |           测试结论            | 备注                                   |
| ----------------------------------- | :---------------------------: | -------------------------------------- |
| 自训练模型推理                      | <font color=green>PASS</font> | 推理结果正确, 使能ACPO后性能提升8%     |
| 预训练模型(AOT模式)推理             | <font color=green>PASS</font> | 推理结果正确, 使能ACPO前后性能基本持平 |
| YUM安装方式使能ACPO(自训练模型推理) | <font color=green>PASS</font> | 推理结果正确, 使能ACPO后性能提升7.9%   |
| YUM安装方式使能ACPO(AOT模式推理)    | <font color=green>PASS</font> | 推理结果正确, 使能ACPO后性能提升1%     |

综上，特性质量评估如下：

| 特性名称          | 特性质量评估                     | 备注  |
| ------------- |:--------------------------:| --- |
| 使能ACPO构建编译器   | <font color=green>■</font> | -   |
| ACPO模型训练      | <font color=green>■</font> | -   |
| ACPO模型推理(自训练) | <font color=green>■</font> | -   |
| ACPO模型推理(预训练) | <font color=green>■</font> | -   |
| YUM方式使能ACPO   | <font color=green>■</font> | -   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好
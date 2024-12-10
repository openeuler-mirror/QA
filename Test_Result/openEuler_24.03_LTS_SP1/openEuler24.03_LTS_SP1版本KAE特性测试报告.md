![avatar](./images/openEuler.png)


版权所有 © 2023  openEuler社区
 您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问https://creativecommons.org/licenses/by-sa/4.0/ 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：https://creativecommons.org/licenses/by-sa/4.0/legalcode。

修订记录

| 日期 | 修订   版本 | 修改描述 | 作者 |
| ---- | ----------- | -------- | ---- |
| 2024-12-03     |             |          |  林意翔    |
|      |             |          |      |

关键词： 

摘要：


缩略语清单：

| 缩略语 | 英文全名 | 中文解释 |
| ------ | -------- | -------- |
|        |          |          |
|        |          |          |

# 1     特性概述

鲲鹏加速引擎KAE（Kunpeng Accelerator Engine）是基于鲲鹏920处理器提供的硬件加速解决方案，包含了KAE加解密和KAEzip。KAE加解密  和 KAEzip  分别用于加速SSL（Secure Sockets Layer）/TLS（Transport Layer Security）应用和数据压缩，可以显著降低处理器消耗，提高处理器效率。此外，加速引擎对应用层屏蔽了其内部实现细节，用户通过OpenSSL、zlib标准接口即可以实现快速迁移现有业务。
# 2     特性测试信息

本节描述被测对象的版本信息和测试的时间及测试轮次，包括依赖的硬件。

| 版本名称 | 测试起始时间 | 测试结束时间 |
| -------- | ------------ | ------------ |
|    kae-2.0.3| 2024-12-03    |2024-12-03         |
|          |              |              |

描述特性测试的硬件环境信息

| 硬件型号 | 硬件配置信息 | 备注 |
| -------- | ------------ | ---- |
|     鲲鹏920     |              |      |
|          |              |      |

# 3     测试结论概述

## 3.1   测试整体结论
测试KAE的加解密和压缩解压缩功能正常。


## 3.2   约束说明

不涉及

## 3.3   遗留问题分析
不涉及

### 3.3.1 遗留问题影响以及规避措施

| 序号 | 问题单号 | 问题简述 | 问题级别 | 影响分析 | 规避措施 | 历史发现场景 |
| --- | ------- | ------ | ------- | ------- | ------- | ---------- | 
|     |         |        |         |         |         |            |
|     |         |        |         |         |         |            |

### 3.3.2 问题统计

|        | 问题总数 | 严重 | 主要 | 次要 | 不重要 |
| ------ | -------- | ---- | ---- | ---- | ------ |
| 数目   |          |      |      |      |        |
| 百分比 |          |      |      |      |        |

# 4 详细测试结论

## 4.1 功能测试
*开源软件：主要关注开源软件升级后的变动点，继承特性由开源软件自带用例保证（需额外关注软件包提供可执行命令、库、服务功能）*
*社区孵化软件：主要参考以下列表*

### 4.1.1 继承特性测试结论

| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
|1 | KAE | <font color=green>■</font> |   |


<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

### 4.1.2 新增特性测试结论
不涉及
| 序号 | 组件/特性名称 | 特性质量评估 | 备注 |
| --- | ----------- | :--------: | --- |
| | | <font color=red>●</font> |   |
| | | <font color=blue>▲</font> |   |

<font color=red>●</font>： 表示特性不稳定，风险高
<font color=blue>▲</font>： 表示特性基本可用，遗留少量问题
<font color=green>■</font>： 表示特性质量良好

## 4.2 兼容性测试结论
不涉及
*针对应用软件，主要考虑OS版本兼容性(在不同LTS SPx上的兼容性)、升降级兼容性、上层以来软件兼容性（如升级mysql后，对版本内已发布的使用mysql的软件的兼容性）*

## 4.3 DFX专项测试结论

### 4.3.1 性能测试结论
(1) 测试同步RSA性能(sign/s)
| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|   3187    |3187    |   3187     | 正常  |

```
[root@localhost ~]# openssl speed -elapsed -engine kae rsa2048
Engine "kae" set.
You have chosen to measure elapsed time instead of user CPU time.
Doing 2048 bits private rsa's for 10s: 31835 2048 bits private RSA's in 10.00s
Doing 2048 bits public rsa's for 10s: 499436 2048 bits public RSA's in 10.00s
version: 3.0.12
built on: Thu May 23 12:50:57 2024 UTC
options: bn(64,64)
compiler: gcc -fPIC -pthread -Wa,--noexecstack -Wall -O3 -O2 -g -grecord-gcc-switches -pipe -fstack-protector-strong -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/generic-hardened-cc1 -fasynchronous-unwind-tables -fstack-clash-protection -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -specs=/usr/lib/rpm/generic-hardened-ld -DOPENSSL_USE_NODELETE -DOPENSSL_PIC -DOPENSSL_BUILDING_OPENSSL -DZLIB -DNDEBUG -DPURIFY -DDEVRANDOM="\"/dev/urandom\""
CPUINFO: OPENSSL_armcap=0xbd
                  sign    verify    sign/s verify/s
rsa 2048 bits 0.000314s 0.000020s   3183.5  49943.6

```

(2) 测试异步RSA性能(sign/s)
| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|   53831    |53831    |   53831     | 正常  |

```
[root@localhost ~]# openssl speed -engine kae -elapsed -async_jobs 36 rsa2048
Engine "kae" set.
You have chosen to measure elapsed time instead of user CPU time.
Doing 2048 bits private rsa's for 10s: 535861 2048 bits private RSA's in 10.00s
Doing 2048 bits public rsa's for 10s: 1748056 2048 bits public RSA's in 10.00s
version: 3.0.12
built on: Thu May 23 12:50:57 2024 UTC
options: bn(64,64)
compiler: gcc -fPIC -pthread -Wa,--noexecstack -Wall -O3 -O2 -g -grecord-gcc-switches -pipe -fstack-protector-strong -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/generic-hardened-cc1 -fasynchronous-unwind-tables -fstack-clash-protection -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -specs=/usr/lib/rpm/generic-hardened-ld -DOPENSSL_USE_NODELETE -DOPENSSL_PIC -DOPENSSL_BUILDING_OPENSSL -DZLIB -DNDEBUG -DPURIFY -DDEVRANDOM="\"/dev/urandom\""
CPUINFO: OPENSSL_armcap=0xbd
                  sign    verify    sign/s verify/s
rsa 2048 bits 0.000019s 0.000006s  53586.1 174805.6

```


(3) 测试SM4 CBC模式性能
| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|       |    |        | 正常  |

```
[root@localhost ~]# openssl speed -elapsed -engine kae -evp sm4-cbc 
Engine "kae" set.
You have chosen to measure elapsed time instead of user CPU time.
Doing SM4-CBC for 3s on 16 size blocks: 7765217 SM4-CBC's in 3.00s
Doing SM4-CBC for 3s on 64 size blocks: 2770273 SM4-CBC's in 3.00s
Doing SM4-CBC for 3s on 256 size blocks: 1517105 SM4-CBC's in 3.00s
Doing SM4-CBC for 3s on 1024 size blocks: 819125 SM4-CBC's in 3.00s
Doing SM4-CBC for 3s on 8192 size blocks: 154861 SM4-CBC's in 3.00s
Doing SM4-CBC for 3s on 16384 size blocks: 80355 SM4-CBC's in 3.00s
version: 3.0.12
built on: Thu May 23 12:50:57 2024 UTC
options: bn(64,64)
compiler: gcc -fPIC -pthread -Wa,--noexecstack -Wall -O3 -O2 -g -grecord-gcc-switches -pipe -fstack-protector-strong -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/generic-hardened-cc1 -fasynchronous-unwind-tables -fstack-clash-protection -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -specs=/usr/lib/rpm/generic-hardened-ld -DOPENSSL_USE_NODELETE -DOPENSSL_PIC -DOPENSSL_BUILDING_OPENSSL -DZLIB -DNDEBUG -DPURIFY -DDEVRANDOM="\"/dev/urandom\""
CPUINFO: OPENSSL_armcap=0xbd
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes  16384 bytes
SM4-CBC          41414.49k    59099.16k   129459.63k   279594.67k   422873.77k   438845.44k


```


(4) 测试SM3模式性能
| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|       |    |        | 正常  |

```
[root@localhost ~]# openssl speed -elapsed -engine kae -evp sm3 
Engine "kae" set.
You have chosen to measure elapsed time instead of user CPU time.
Doing sm3 for 3s on 16 size blocks: 1660822 sm3's in 3.00s
Doing sm3 for 3s on 64 size blocks: 1465604 sm3's in 3.00s
Doing sm3 for 3s on 256 size blocks: 1083333 sm3's in 3.00s
Doing sm3 for 3s on 1024 size blocks: 797725 sm3's in 3.00s
Doing sm3 for 3s on 8192 size blocks: 257914 sm3's in 3.00s
Doing sm3 for 3s on 16384 size blocks: 145110 sm3's in 3.00s
version: 3.0.12
built on: Thu May 23 12:50:57 2024 UTC
options: bn(64,64)
compiler: gcc -fPIC -pthread -Wa,--noexecstack -Wall -O3 -O2 -g -grecord-gcc-switches -pipe -fstack-protector-strong -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/generic-hardened-cc1 -fasynchronous-unwind-tables -fstack-clash-protection -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -specs=/usr/lib/rpm/generic-hardened-ld -DOPENSSL_USE_NODELETE -DOPENSSL_PIC -DOPENSSL_BUILDING_OPENSSL -DZLIB -DNDEBUG -DPURIFY -DDEVRANDOM="\"/dev/urandom\""
CPUINFO: OPENSSL_armcap=0xbd
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes  16384 bytes
sm3               8857.72k    31266.22k    92444.42k   272290.13k   704277.16k   792494.08k


```

(5) 测试AES算法CBC模式异步性能
| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|       |    |        | 正常  |

```
[root@localhost ~]# openssl speed -elapsed -evp aes-128-cbc -async_jobs 4 -engine kae
Engine "kae" set.
You have chosen to measure elapsed time instead of user CPU time.
Doing AES-128-CBC for 3s on 16 size blocks: 19932177 AES-128-CBC's in 3.00s
Doing AES-128-CBC for 3s on 64 size blocks: 17607949 AES-128-CBC's in 3.00s
Doing AES-128-CBC for 3s on 256 size blocks: 1319102 AES-128-CBC's in 3.00s
Doing AES-128-CBC for 3s on 1024 size blocks: 1362695 AES-128-CBC's in 3.00s
Doing AES-128-CBC for 3s on 8192 size blocks: 923788 AES-128-CBC's in 3.00s
Doing AES-128-CBC for 3s on 16384 size blocks: 604363 AES-128-CBC's in 3.00s
version: 3.0.12
built on: Thu May 23 12:50:57 2024 UTC
options: bn(64,64)
compiler: gcc -fPIC -pthread -Wa,--noexecstack -Wall -O3 -O2 -g -grecord-gcc-switches -pipe -fstack-protector-strong -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/generic-hardened-cc1 -fasynchronous-unwind-tables -fstack-clash-protection -Wa,--noexecstack -Wa,--generate-missing-build-notes=yes -specs=/usr/lib/rpm/generic-hardened-ld -DOPENSSL_USE_NODELETE -DOPENSSL_PIC -DOPENSSL_BUILDING_OPENSSL -DZLIB -DNDEBUG -DPURIFY -DDEVRANDOM="\"/dev/urandom\""
CPUINFO: OPENSSL_armcap=0xbd
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes  16384 bytes
AES-128-CBC     106304.94k   375636.25k   112563.37k   465133.23k  2522557.10k  3300627.80k


```

(6) 测试zlib功能
[kaezip_perf工具获取](https://www.hikunpeng.com/document/detail/zh/kunpengaccel/compress/devg-kaezip/kunpengaccel_kaezip_0011.html)

| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|       |    |        | 正常  |

```
[root@localhost perftest]#  ./kaezip_perf -m 8 -l 10240 -n 1000 
kaezip perf parameter: multi process 8, stream length: 10240(KB), loop times: 1000, windowBits : 15, level : 6
input_size is 10485760B
compress_size is 11053224B = 10.541MB, compress_rate is 105.412%
compress_size is 11053224B = 10.541MB, compress_rate is 105.412%
compress_size is 11053224B = 10.541MB, compress_rate is 105.412%
compress_size is 11053224B = 10.541MB, compress_rate is 105.412%
compress_size is 11053224B = 10.541MB, compress_rate is 105.412%
compress_size is 11053224B = 10.541MB, compress_rate is 105.412%
compress_size is 11053224B = 10.541MB, compress_rate is 105.412%
compress_size is 11053224B = 10.541MB, compress_rate is 105.412%
kaezip compress perf result:
     time used: 16977878 us, speed = 4.602 GB/s


```

(7) KAEzip测试解压缩性能
（解压缩命令中的“itemdata.zlib”为已压缩的文件，可以通过在压缩命令中添加-o itemdata.zlib来指定。）
| 指标大项 | 指标小项 | 指标值 | 测试结论 |
| ------- | ------- | ------ | ------- |
|       |    |        | 正常  |

```
[root@localhost perftest]#  ./kaezip_perf -d -m 8 -f itemdata.zlib -n 1000
kaezip perf parameter: multi process 8, stream length: 1024(KB), loop times: 1000, windowBits : 15, level : 6
uncompress filename : itemdata.zlib
input_size is 11053348B
uncompress_size is 10485760B = 10.000MB
uncompress_size is 10485760B = 10.000MB
uncompress_size is 10485760B = 10.000MB
uncompress_size is 10485760B = 10.000MB
uncompress_size is 10485760B = 10.000MB
uncompress_size is 10485760B = 10.000MB
uncompress_size is 10485760B = 10.000MB
uncompress_size is 10485760B = 10.000MB
kaezip decompress perf result:
     time used: 20688319 us, speed = 31.846 GB/s


```
### 4.3.2 可靠性/韧性测试结论
不涉及

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

### 4.3.3 安全测试结论
不涉及

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

## 4.4 资料测试结论
不涉及
*建议附加资料PR链接*
| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

## 4.5 其他测试结论

| 测试类型 | 测试内容 | 测试结论 |
| ------- | ------- | -------- |
|         |         |          |

# 5     测试执行

## 5.1   测试执行统计数据
*本节内容根据测试用例及实际执行情况进行特性整体测试的统计，可根据第二章的测试轮次分开进行统计说明。*

| 版本名称 | 测试用例数 | 用例执行结果 | 发现问题单数 |
| -------- | ---------- | ------------ | ------------ |
|   KAE-2.0       |     71       | 通过             |    0          |
|          |            |              |              |

*数据项说明：*

*测试用例数－－到本测试活动结束时，所有可用测试用例数；*

*发现问题单数－－本测试活动总共发现的问题单数。*

## 5.2   后续测试建议

后续测试需要关注点(可选)

# 6     附件

*此处可粘贴各类专项测试数据或报告*
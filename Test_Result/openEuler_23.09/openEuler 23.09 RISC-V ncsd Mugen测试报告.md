![openEuler ico](https://gitee.com/openeuler/QA/raw/master/images/openEuler.png)

版权所有 © 2023 openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节 | 修改描述         | 作者     |
| ---------- | -------- | -------- | ---------------- | -------- |
| 2023/10/20 | 1.0.0    |          | 初稿             | 朱旭昌   |
| 2023/10/20 | 1.0.1    |          | 格式更正         | 桜風の狐 |

## ncsd Mugen 测试用例清单

Mugen 的 ncsd 测试套为glibc共 2 个测试用例，在 rc7 上有一个为非问题测试用例，其余全部通过

| 测试套/软件包名 | 测试用例名 | 状态 | 日志文件 | 备注 |
|:-:|:-:|:-:|:-:|:-:|
| glibc | oe_test_service_nscd | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/glibc/oe_test_service_nscd/2023-10-17-22_21_48.log) | None |
|       | oe_test_socket_nscd  | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/glibc/oe_test_socket_nscd/2023-10-17-22_23_20.log)  | None |


![openEuler ico](https://gitee.com/openeuler/QA/raw/master/images/openEuler.png)

版权所有 © 2023 openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节 | 修改描述         | 作者     |
| ---------- | -------- | -------- | ---------------- | -------- |
| 2023/10/20 | 1.0.0    |          | 初稿             | 朱旭昌   |
| 2023/10/20 | 1.0.1    |          | 格式更正         | 桜風の狐 |

## ceph Mugen 测试用例清单

Mugen 的 ceph 测试套共 9 个测试用例，在 rc7 全部通过

| 测试套/软件包名 | 测试用例名 | 状态 | 日志文件 | 备注 |
|:-:|:-:|:-:|:-:|:-:|
| ceph | oe_test_target_ceph-mon        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/ceph/oe_test_target_ceph-mon/2023-10-19-11_40_26.log)        | None |
|      | oe_test_target_ceph            | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/ceph/oe_test_target_ceph/2023-10-19-11_54_48.log)            | None |
|      | oe_test_target_ceph-radosgw    | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/ceph/oe_test_target_ceph-radosgw/2023-10-19-11_47_47.log)    | None |
|      | oe_test_target_ceph-rbd-mirror | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/ceph/oe_test_target_ceph-rbd-mirror/2023-10-19-11_51_22.log) | None |
|      | oe_test_target_ceph-mgr        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/ceph/oe_test_target_ceph-mgr/2023-10-19-11_30_25.log)        | None |
|      | oe_test_service_rbdmap         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/ceph/oe_test_service_rbdmap/2023-10-19-11_23_29.log)         | None |
|      | oe_test_target_ceph-mds        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/ceph/oe_test_target_ceph-mds/2023-10-19-11_26_56.log)        | None |
|      | oe_test_target_ceph-osd        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/ceph/oe_test_target_ceph-osd/2023-10-19-11_44_08.log)        | None |
|      | oe_test_target_ceph-fuse       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/ceph/oe_test_target_ceph-fuse/2023-10-19-11_25_40.log)       | None |


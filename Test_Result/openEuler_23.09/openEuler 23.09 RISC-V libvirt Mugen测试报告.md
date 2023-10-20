![openEuler ico](https://gitee.com/openeuler/QA/raw/master/images/openEuler.png)

版权所有 © 2023 openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节 | 修改描述         | 作者     |
| ---------- | -------- | -------- | ---------------- | -------- |
| 2023/10/20 | 1.0.0    |          | 初稿             | 桜風の狐 |
| 2023/10/20 | 1.0.1    |          | 格式更正         | 桜風の狐 |

## libvirt Mugen 测试用例清单

Mugen 的 libvirt 测试套共 48 个测试用例，在 rc7 上全部通过

| 测试套/软件包名 | 测试用例名 | 状态 | 日志文件 | 备注 |
|:-:|:-:|:-:|:-:|:-:|
| libvirt | oe_test_socket_virtsecretd-ro       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtsecretd-ro/2023-10-18-00_03_49.log)       | None |
|         | oe_test_socket_virtinterfaced-admin | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtinterfaced-admin/2023-10-17-23_24_40.log) | None |
|         | oe_test_socket_virtlogd             | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtlogd/2023-10-17-23_33_42.log)             | None |
|         | oe_test_socket_virtstoraged         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtstoraged/2023-10-18-00_10_09.log)         | None |
|         | oe_test_socket_libvirtd-tcp         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_libvirtd-tcp/2023-10-17-23_21_39.log)         | None |
|         | oe_test_socket_virtproxyd-admin     | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd-admin/2023-10-17-23_49_52.log)     | None |
|         | oe_test_service_virtqemud           | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtqemud/2023-10-17-23_12_25.log)           | None |
|         | oe_test_target_virt-guest-shutdown  | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_target_virt-guest-shutdown/2023-10-18-00_11_43.log)  | None |
|         | oe_test_service_virtnodedevd        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtnodedevd/2023-10-17-23_07_47.log)        | None |
|         | oe_test_socket_virtstoraged-admin   | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtstoraged-admin/2023-10-18-00_06_58.log)   | None |
|         | oe_test_socket_virtproxyd-tcp       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd-tcp/2023-10-17-23_54_21.log)       | None |
|         | oe_test_socket_virtnodedevd-admin   | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtnodedevd-admin/2023-10-17-23_40_44.log)   | None |
|         | oe_test_socket_virtnodedevd-ro      | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtnodedevd-ro/2023-10-17-23_42_14.log)      | None |
|         | oe_test_service_virtnetworkd        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtnetworkd/2023-10-17-23_05_57.log)        | None |
|         | oe_test_socket_virtqemud            | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtqemud/2023-10-18-00_00_38.log)            | None |
|         | oe_test_socket_virtnetworkd-ro      | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtnetworkd-ro/2023-10-17-23_36_58.log)      | None |
|         | oe_test_socket_virtnwfilterd-admin  | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtnwfilterd-admin/2023-10-17-23_45_15.log)  | None |
|         | oe_test_service_virtsecretd         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtsecretd/2023-10-17-23_14_10.log)         | None |
|         | oe_test_socket_virtlockd            | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtlockd/2023-10-17-23_30_45.log)            | None |
|         | oe_test_socket_libvirtd-ro          | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_libvirtd-ro/2023-10-17-23_18_47.log)          | None |
|         | oe_test_socket_virtproxyd-tls       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd-tls/2023-10-17-23_55_52.log)       | None |
|         | oe_test_socket_virtnetworkd         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtnetworkd/2023-10-17-23_38_51.log)         | None |
|         | oe_test_socket_virtinterfaced       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtinterfaced/2023-10-17-23_27_45.log)       | None |
|         | oe_test_service_libvirtd            | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_libvirtd/2023-10-17-22_58_00.log)            | None |
|         | oe_test_service_virtlockd           | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtlockd/2023-10-17-23_03_05.log)           | None |
|         | oe_test_socket_virtsecretd-admin    | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtsecretd-admin/2023-10-18-00_02_16.log)    | None |
|         | oe_test_socket_virtproxyd           | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd/2023-10-17-23_52_51.log)           | None |
|         | oe_test_service_virtnwfilterd       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtnwfilterd/2023-10-17-23_09_20.log)       | None |
|         | oe_test_service_virtlogd            | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtlogd/2023-10-17-23_04_30.log)            | None |
|         | oe_test_socket_virtnodedevd         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtnodedevd/2023-10-17-23_43_44.log)         | None |
|         | oe_test_service_virtproxyd          | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtproxyd/2023-10-17-23_10_53.log)          | None |
|         | oe_test_service_libvirt-guests      | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_libvirt-guests/2023-10-17-22_59_47.log)      | None |
|         | oe_test_socket_virtsecretd          | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtsecretd/2023-10-18-00_05_25.log)          | None |
|         | oe_test_socket_libvirtd-admin       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_libvirtd-admin/2023-10-17-23_17_22.log)       | None |
|         | oe_test_socket_virtproxyd-ro        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtproxyd-ro/2023-10-17-23_51_23.log)        | None |
|         | oe_test_socket_virtnetworkd-admin   | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtnetworkd-admin/2023-10-17-23_35_08.log)   | None |
|         | oe_test_socket_virtqemud-admin      | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtqemud-admin/2023-10-17-23_57_24.log)      | None |
|         | oe_test_socket_virtqemud-ro         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtqemud-ro/2023-10-17-23_59_00.log)         | None |
|         | oe_test_service_virtinterfaced      | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtinterfaced/2023-10-17-23_01_25.log)      | None |
|         | oe_test_socket_virtnwfilterd-ro     | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtnwfilterd-ro/2023-10-17-23_46_47.log)     | None |
|         | oe_test_socket_virtlogd-admin       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtlogd-admin/2023-10-17-23_32_13.log)       | None |
|         | oe_test_socket_virtnwfilterd        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtnwfilterd/2023-10-17-23_48_20.log)        | None |
|         | oe_test_socket_virtlockd-admin      | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtlockd-admin/2023-10-17-23_29_18.log)      | None |
|         | oe_test_socket_virtinterfaced-ro    | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtinterfaced-ro/2023-10-17-23_26_14.log)    | None |
|         | oe_test_socket_libvirtd             | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_libvirtd/2023-10-17-23_20_14.log)             | None |
|         | oe_test_socket_virtstoraged-ro      | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_virtstoraged-ro/2023-10-18-00_08_35.log)      | None |
|         | oe_test_service_virtstoraged        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_service_virtstoraged/2023-10-17-23_15_46.log)        | None |
|         | oe_test_socket_libvirtd-tls         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/libvirt/oe_test_socket_libvirtd-tls/2023-10-17-23_23_08.log)         | None |


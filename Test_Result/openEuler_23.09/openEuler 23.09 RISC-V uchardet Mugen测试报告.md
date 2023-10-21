![openEuler ico](https://gitee.com/openeuler/QA/raw/master/images/openEuler.png)

版权所有 © 2023 openEuler社区
您对“本文档”的复制、使用、修改及分发受知识共享(Creative Commons)署名—相同方式共享4.0国际公共许可协议(以下简称“CC BY-SA 4.0”)的约束。为了方便用户理解，您可以通过访问[*https://creativecommons.org/licenses/by-sa/4.0/*](https://creativecommons.org/licenses/by-sa/4.0/) 了解CC BY-SA 4.0的概要 (但不是替代)。CC BY-SA 4.0的完整协议内容您可以访问如下网址获取：[*https://creativecommons.org/licenses/by-sa/4.0/legalcode*](https://creativecommons.org/licenses/by-sa/4.0/legalcode)。

修订记录

| 日期       | 修订版本 | 修改章节 | 修改描述         | 作者     |
| ---------- | -------- | -------- | ---------------- | -------- |
| 2023/10/20 | 1.0.0    |          | 初稿             | 朱旭昌   |
| 2023/10/20 | 1.0.1    |          | 格式更正         | 桜風の狐 |

## uchardet Mugen 测试用例清单

Mugen 的 uchardet 测试套共 16 个测试用例，在rc7全部通过

| 测试套/软件包名 | 测试用例名 | 状态 | 日志文件 | 备注 |
|:-:|:-:|:-:|:-:|:-:|
| tidy | oe_test_tidy_xml                         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_xml/2023-10-18-17_09_07.log)                         | None |
|      | oe_test_tidy_file_input-output_options   | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_file_input-output_options/2023-10-18-17_11_40.log)   | None |
|      | oe_test_tidy_teaching_tidy_options       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_teaching_tidy_options/2023-10-18-17_16_58.log)       | None |
|      | oe_test_tidy_file_manipulation           | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_file_manipulation/2023-10-18-17_04_59.log)           | None |
|      | oe_test_tidy_encoding_options            | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_encoding_options/2023-10-18-17_13_08.log)            | None |
|      | oe_test_tidy_diagnostics_options         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_diagnostics_options/2023-10-18-17_12_24.log)         | None |
|      | oe_test_tidy_entities_options            | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_entities_options/2023-10-18-17_14_38.log)            | None |
|      | oe_test_tidy_document_in_and_out_options | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_document_in_and_out_options/2023-10-18-17_10_49.log) | None |
|      | oe_test_tidy_cleanup_options             | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_cleanup_options/2023-10-18-17_13_53.log)             | None |
|      | oe_test_tidy_repair_options              | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_repair_options/2023-10-18-17_15_24.log)              | None |
|      | oe_test_tidy_pretty_print_options        | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_pretty_print_options/2023-10-18-17_17_43.log)        | None |
|      | oe_test_tidy_miscellaneous               | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_miscellaneous/2023-10-18-17_08_16.log)               | None |
|      | oe_test_tidy_character_encodings         | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_character_encodings/2023-10-18-17_06_48.log)         | None |
|      | oe_test_tidy_transformation_options      | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_transformation_options/2023-10-18-17_16_11.log)      | None |
|      | oe_test_tidy_document_display_options    | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_document_display_options/2023-10-18-17_09_57.log)    | None |
|      | oe_test_tidy_processing_directives       | success | [log](https://gitee.com/yunxiangluo/openeuler-riscv-23.09-test/tree/master/Round7/Mugen/mugen-riscv/logs/tidy/oe_test_tidy_processing_directives/2023-10-18-17_05_54.log)       | None |


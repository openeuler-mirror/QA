#ifndef __CSV3_TEST_INTERFACE_H__
#define __CSV3_TEST_INTERFACE_H__

#ifdef __cplusplus
extern "C" {
#endif

#ifdef USER_CMD_TEST
typedef unsigned char      u8;
typedef unsigned short     u16;
typedef unsigned int       u32;
typedef unsigned long long u64;
#define __packed __attribute__((packed))
#endif /* USER_CMD_TEST */

enum {
    CSV3_TEST_RW_MEM,
    CSV3_TEST_OP_SIZE,
};

struct csv3_test_rw_mem {
    u16 rw_flag;
    u64 phys_addr;
    u64 size;
    u64 data_buffer;
} __packed;

#define CSV3_IOC_TYPE     'S'
#define CSV3_CMD_RW_MEM   _IOWR(CSV3_IOC_TYPE, CSV3_TEST_RW_MEM, struct csv3_test_rw_mem)

#ifdef __cplusplus
}
#endif

#endif /* __CSV3_TEST_INTERFACE_H__ */

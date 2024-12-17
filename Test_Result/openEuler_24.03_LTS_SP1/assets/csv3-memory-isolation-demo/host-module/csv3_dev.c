#include <linux/miscdevice.h>
#include <linux/module.h>
#include <linux/pagemap.h>
#include <linux/slab.h>
#include <linux/types.h>
#include <linux/uaccess.h>
#include <linux/psp-sev.h>
#include <asm/csv.h>
#include <asm/set_memory.h>
#include "include/csv3_test_interface.h"

static int csv3_test_rwmem(void __user *argp)
{
    u64 copy_size   = 0;
    u64 phys_addr   = 0;
    void * vaddr    = NULL;
    int  ret = 0;
    struct csv3_test_rw_mem rw_mem;

    if (copy_from_user(&rw_mem, argp, sizeof(rw_mem))) {
        ret = -EFAULT;
        pr_err("%s fail to copy from argp user data\n", __func__);
        return ret;
    }

    phys_addr = rw_mem.phys_addr;
    copy_size = rw_mem.size;
    if ((phys_addr & (4096 - 1)) != 0) {
        pr_err("%s phys_addr = 0x%llx, not align with 4096!!!\n", __func__, phys_addr);
        return -EINVAL;
    }
    if (copy_size > 4096) {
        pr_err("%s copy_size = 0x%llx, more than 4096!!!\n", __func__, copy_size);
        return -EINVAL;
    }
    pr_info("%s phys_addr=0x%llx,size=0x%llx\n", __func__,phys_addr,copy_size);

    vaddr = kmap(pfn_to_page(phys_addr>>12));
    if (vaddr == NULL) {
        pr_err("%s fail to ioremap wt, phys_addr = 0x%llx size = 0x%llx\n", __func__, phys_addr, copy_size);
        return -EFAULT;
    }

    wbinvd_on_all_cpus();
    //rw_flag: 1-write_memory 0-read_memory
    if (rw_mem.rw_flag & 0x01) {
        ret = copy_from_user(vaddr, (void __user*)rw_mem.data_buffer, copy_size);
    }
    else {
        ret = copy_to_user((void __user*)rw_mem.data_buffer, vaddr, copy_size);
    }
    wbinvd_on_all_cpus();

    kunmap(vaddr);

    return ret;
}

static long csv3_ioctl(struct file* file, unsigned int ioctl, unsigned long arg)
{
    int  ret            = 0;
    void __user*   argp = (void __user*)arg;
    unsigned int   cmd_id, len;

    if (_IOC_TYPE(ioctl) != CSV3_IOC_TYPE) {
        pr_err("%s ioctl 0x%08x is invalid\n", __func__, ioctl);
        return -EINVAL;
    }

    cmd_id = _IOC_NR(ioctl);
    if (cmd_id >= (u32)CSV3_TEST_OP_SIZE) {
        pr_err("%s cmd_id %u is invalid\n", __func__, cmd_id);
        return -EINVAL;
    }

    len = _IOC_SIZE(ioctl);
    if (len == 0) {
        pr_err("%s cmd len 0x%x is invalid\n", __func__, len);
        return -EINVAL;
    }

    switch(cmd_id) {
        case CSV3_TEST_RW_MEM:
            ret = csv3_test_rwmem(argp);
            break;
        default:
            pr_err("%s cmd_id 0x%x is not implemented\n", __func__, cmd_id);
            break;
    }

    return ret;
}

static const struct file_operations csv3_fops = {
    .owner          = THIS_MODULE,
    .unlocked_ioctl = csv3_ioctl,
};

static struct miscdevice misc = {
    .minor = MISC_DYNAMIC_MINOR,
    .name = "csv3",
    .fops = &csv3_fops,
};

static int __init csv3_module_init(void)
{

    printk("%s csv3 module init\n", "csv3_dev");

    return misc_register(&misc);
}

static void __exit csv3_module_exit(void)
{
    misc_deregister(&misc);
}

MODULE_LICENSE("GPL");

module_init(csv3_module_init);
module_exit(csv3_module_exit);

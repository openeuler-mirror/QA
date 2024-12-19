#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/highmem.h>
#include <linux/uaccess.h>
#include <linux/io.h>
#include <linux/slab.h>

#define PHYS_ADDR 0x10000000UL  // 指定的物理地址
#define MAP_SIZE  0x20000000UL  // 映射大小，例如1MB

static bool req_init = false;
module_param_named(init, req_init, bool, 0444);

static void *mapped_base;

static int __init my_module_init(void)
{
    printk(KERN_INFO "Trying to map physical memory...\n");

    void *ptr = ioremap_encrypted(PHYS_ADDR, MAP_SIZE);
    if (!ptr) {
        printk(KERN_ERR "Failed to ioremap physical memory\n");
        return -ENOMEM;
    }

    mapped_base = ptr;

    printk(KERN_INFO "Physical memory mapped at virtual address %p:", ptr);

    {
        int i = 0;

        if (req_init == true) {
	    memset(mapped_base, 0x5A, MAP_SIZE);
        }

	for (; i < 256; i++) {
            if (i % 16 == 0) printk("\n%016lx: ", PHYS_ADDR + i);
	    printk(KERN_CONT " %02x", ((unsigned char *)ptr)[i]);
	}
	printk("\n");
    }

    iounmap(mapped_base);
    printk(KERN_INFO "Physical memory unmapped\n");
    return -1; // no need return success
}

static void __exit my_module_exit(void)
{
}

module_init(my_module_init);
module_exit(my_module_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your Name");
MODULE_DESCRIPTION("A simple Linux kernel module to map physical memory");
MODULE_VERSION("1.0");

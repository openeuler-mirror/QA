# 指定内核源代码树的路径（根据你的实际情况修改）
# 如果你已经安装了内核开发包（如 linux-headers-xxx），则可能不需要这个路径
# 但在某些情况下，你可能需要指定内核源代码的位置，例如 /usr/src/linux-headers-$(uname -r)
# 或者如果你从源代码编译了内核，那么就是内核源代码的顶级目录
KDIR ?= /lib/modules/$(shell uname -r)/build

# 编译目标（内核模块的名称）
obj-m += guest-test.o

guest-test-y += guest.o

# 清理目标文件和模块
clean:
	make -C $(KDIR) M=$(PWD) clean

# 默认目标：编译模块
all:
	make -C $(KDIR) M=$(PWD) modules

# 安装模块（可选，通常不需要在开发过程中执行）
install:
	make -C $(KDIR) M=$(PWD) modules_install

# 卸载模块（不是通过Makefile执行的，但在这里提及以供参考）
# 你需要使用 rmmod 命令来卸载模块，例如：rmmod my_module

# make LOCAL_KERDIR=kernel code path
LOCAL_KERDIR=/lib/modules/`uname -r`/build/

PWD	:= $(shell pwd)
obj-m	:= csv3_dev.o
KERNELDIR = $(LOCAL_KERDIR)

default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

clean:
	-rm -rf $(shell find -L . -name "*.o.cmd" \
		-o -name "*.o" \
		-o -name "*.ko" \
		-o -name "*.o.d" \
		-o -name "*.mod.c" \
		-o -name "*.ko.cmd" \
		-o -name ".tmp_versions")
	-rm -f modules.order Module.symvers

distclean: clean
	-rm -rf $(shell find -L . -name "*.ko")

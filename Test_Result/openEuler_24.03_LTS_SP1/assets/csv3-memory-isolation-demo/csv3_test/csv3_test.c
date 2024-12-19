#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
#include <ctype.h>
#include <getopt.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include "csv3_test_interface.h"

#define array_len(x) (sizeof(x)/sizeof(*(x)))
static volatile u8 data[4096] __attribute__((aligned(4096)));

struct option opts[] = {
	{"read_mem",   1, 0, 'r' },
	{"write_mem",  1, 0, 'w' },
	{"value",      1, 0, 'v' },
	{"size",       1, 0, 's' },
	{"help",       0, 0, 'h' },
	{ 0, 0, 0, 0 }
};

void usage(void)
{
	fprintf(stderr,
		"usage: csv3_test: \n"
		"csv3_test --read_mem  addr --size size \n"
		"csv3_test --write_mem addr --size size --value value \n");
	exit(1);
}

void usage_msg(char *msg, ...)
{
	va_list ap;
	va_start(ap,msg);
	fprintf(stderr, "csv3_test: ");
	vfprintf(stderr, msg, ap);
	putchar('\n');
	usage();
	va_end(ap);
}

void get_short_opts(struct option *o, char *s)
{
	*s++ = '+';
	while (o->name) {
		if (isprint(o->val)) {
			*s++ = o->val;
			if (o->has_arg)
				*s++ = ':';
		}
		o++;
	}
	*s = '\0';
}

#define __is_print(ch) ((unsigned int)((ch) - ' ') < 127u - ' ')
static void dump_hex(unsigned char *ptr, int buflen, u64 phys_addr)
{
    unsigned char *buf = (unsigned char*)ptr;
    int i, j;

    for (i=0; i<buflen; i+=16)
    {
        printf("%016llX  ", phys_addr+i);

        for (j=0; j<8; j++)
            if (i+j < buflen)
                printf("%02X ", buf[i+j]);
            else
                printf("   ");
        printf(" ");
        for (j=8; j<16; j++)
            if (i+j < buflen)
                printf("%02X ", buf[i+j]);
            else
                printf("   ");

        printf(" |");

        for (j=0; j<16; j++)
            if (i+j < buflen)
                printf("%c", __is_print(buf[i+j]) ? buf[i+j] : '.');
        printf("|\n");
    }
}

void read_write_mem(u16 is_write, u64 address, u64 value, u64 size)
{
    int fd;
    u64 remain_size;
    u64 write_size;
    struct csv3_test_rw_mem rw_mem;

    printf("%s, addr=0x%llx, size=0x%llx", (is_write?"write_mem":"read_mem"), address, size);
    if(is_write)
        printf(", value=0x%llx\n", value);
    else
        printf(" \n");

    if(size <= sizeof(u64)){
        memcpy((void*)data, (void*)&value, size);
    }
    else{
        memset((void*)data, value, sizeof(data));
    }
    remain_size = size;
    write_size = 0;

    fd = open("/dev/csv3", O_RDWR);
    if (fd < 0) {
        printf("open /dev/csv3 fail! errno=%d, %s\n", errno, strerror(errno));
        return;
    }

    while(remain_size > 0){
        rw_mem.rw_flag = is_write; //1:write_mem  0:read_mem
        rw_mem.data_buffer = (u64)data;
        if(remain_size <= sizeof(data)){
            rw_mem.size = remain_size;
            remain_size  = 0;
        }
        else{
            rw_mem.size = sizeof(data);
            remain_size -= sizeof(data);
        }
        rw_mem.phys_addr = address + write_size;
        write_size += rw_mem.size;
        if (ioctl(fd, CSV3_CMD_RW_MEM, &rw_mem) != 0) {
            printf("fail to read/write mem, errno=%d, %s\n", errno, strerror(errno));
            goto end;
        }

        if (!is_write)
            dump_hex((unsigned char*)data, rw_mem.size, rw_mem.phys_addr);
    }

end:
    close(fd);
}

int main(int ac, char **av)
{
	int c;
	char shortopts[array_len(opts)*2 + 1];
	char *end;
	int is_write = 0;
	int read = 0, write = 0;
	unsigned long address = 0;
	unsigned long size = sizeof(u64);
	unsigned long value = 0;

	get_short_opts(opts,shortopts);
	while ((c = getopt_long(ac, av, shortopts, opts, NULL)) != -1) {
		switch (c) {
		case 'r':
			is_write = 0; //read_mem
			read = 1;
			address = strtoul(optarg, &end, 0);
			if (address == 0) {
				printf("address in null\n");
				return 0;
			}
			printf("read address = 0x%lx\n", address);
			break;
		case 'w':
			is_write = 1; //write_mem
			write = 1;
			address = strtoul(optarg, &end, 0);
			if (address == 0) {
				printf("address is null\n");
				return 0;
			}
			printf("write address = 0x%lx\n", address);
			break;
		case 'v':
			value = strtol(optarg, &end, 0);
			printf("value = 0x%lx\n", value);
			break;
		case 's':
			size = strtoul(optarg, &end, 0);
			printf("size = 0x%lx\n", size);
			break;
		case 'h':
		default:
			usage();
			break;
		}
	}
	if(read || write){
		read_write_mem(is_write, address, value, size);
        }
	return 0;
}

#ifndef __PRINTK_H__
#define __PRINTK_H__

#include "stddef.h"
#include "stdint.h"

#define bool _Bool
#define true 1
#define false 0

int printk(const char *, ...);
void printk_binary_64(uint64_t value);
void printk_binary_64_1s_pos(uint64_t value);

#endif
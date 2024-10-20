#include "printk.h"
#include "stdint.h"

void printk_binary_64(uint64_t value) {
    char binary[65];
    for (int i = 0; i < 64; i++) {
        binary[63 - i] = (value & (1UL << i)) ? '1' : '0';
    }
    binary[64] = '\0';
    printk("%s\n", binary);
}

void printk_binary_64_1s_pos(uint64_t value) {
    printk("Positions: ");
    for (int i = 0; i < 64; i++) {
        if (value & (1UL << i)) {
            printk("%d ", i);
        }
    }
    printk("\n");
}
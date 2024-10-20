# 0 "arch/riscv/kernel/trap.c"
# 1 "/root/os24fall-stu/src/lab1//"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "arch/riscv/kernel/trap.c"
# 1 "/root/os24fall-stu/src/lab1/include/stdint.h" 1



typedef signed char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef long long int64_t;

typedef int8_t int_fast8_t;
typedef int16_t int_fast16_t;
typedef int32_t int_fast32_t;
typedef int64_t int_fast64_t;

typedef int8_t int_least8_t;
typedef int16_t int_least16_t;
typedef int32_t int_least32_t;
typedef int64_t int_least64_t;

typedef int64_t intmax_t;

typedef int64_t intptr_t;

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;

typedef uint8_t uint_fast8_t;
typedef uint16_t uint_fast16_t;
typedef uint32_t uint_fast32_t;
typedef uint64_t uint_fast64_t;

typedef uint8_t uint_least8_t;
typedef uint16_t uint_least16_t;
typedef uint32_t uint_least32_t;
typedef uint64_t uint_least64_t;

typedef uint64_t uintmax_t;

typedef uint64_t uintptr_t;
# 2 "arch/riscv/kernel/trap.c" 2
# 1 "/root/os24fall-stu/src/lab1/include/printk.h" 1



# 1 "/root/os24fall-stu/src/lab1/include/stddef.h" 1



typedef long int ptrdiff_t;
typedef long unsigned int size_t;
typedef int wchar_t;




typedef __builtin_va_list va_list;
# 5 "/root/os24fall-stu/src/lab1/include/printk.h" 2
# 1 "/root/os24fall-stu/src/lab1/include/stdint.h" 1
# 6 "/root/os24fall-stu/src/lab1/include/printk.h" 2





int printk(const char *, ...);
void printk_binary_64(uint64_t value);
void printk_binary_64_1s_pos(uint64_t value);
# 3 "arch/riscv/kernel/trap.c" 2
# 1 "/root/os24fall-stu/src/lab1/arch/riscv/include/defs.h" 1
# 4 "arch/riscv/kernel/trap.c" 2

extern void clock_set_next_event();






void trap_handler(uint64_t scause, uint64_t sepc) {

    uint64_t is_interrupt = (scause >> 63) & 1;



    uint64_t sstatus_value = ({ uint64_t __v; asm volatile("csrr %0, " "sstatus" : "=r"(__v)); __v; });
    printk("sstatus in trap_handler: ");

    printk_binary_64_1s_pos(sstatus_value);


    ({ uint64_t __v = (uint64_t)(0x3220104982); asm volatile("csrw " "sscratch" ", %0" : : "r"(__v) : "memory"); });
    uint64_t sscratch_value = ({ uint64_t __v; asm volatile("csrr %0, " "sscratch" : "=r"(__v)); __v; });
    printk("sscratch in trap_handler: %lx\n", sscratch_value);



    if (is_interrupt) {
        int exception_code = scause & ((1UL << 63) - 1);
        if (exception_code == 5) {


            printk("[S] Supervisor Mode Timer Interrupt\n");

            clock_set_next_event();
        }
    }


}

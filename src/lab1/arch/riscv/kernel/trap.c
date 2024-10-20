#include "stdint.h"
#include "printk.h"
#include "defs.h"

extern void clock_set_next_event();

#define MACHINE_TIMER_INT 7
#define SUPERVISOR_TIMER_INT 5



void trap_handler(uint64_t scause, uint64_t sepc) {
    // 通过 `scause` 判断 trap 类型
    uint64_t is_interrupt = (scause >> 63) & 1;
    // printk("scause: %lx, sepc: %lx\n", scause, sepc);

    // 思考题 3：用 csr_read 宏读取 sstatus 寄存器的值，对照 RISC-V 手册解释其含义并截图
    uint64_t sstatus_value = csr_read(sstatus);
    printk("sstatus in trap_handler: ");
    // printk_binary_64(sstatus_value);
    printk_binary_64_1s_pos(sstatus_value);

    // 思考题 4: 用 csr_write 宏向 sscratch 寄存器写入数据，并验证是否写入成功并截图
    csr_write(sscratch, 0x3220104982);
    uint64_t sscratch_value = csr_read(sscratch);
    printk("sscratch in trap_handler: %lx\n", sscratch_value);

    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    if (is_interrupt) {
        int exception_code = scause & ((1UL << 63) - 1);
        if (exception_code == SUPERVISOR_TIMER_INT) {
            // 时钟中断
            // 打印输出信息
            printk("[S] Supervisor Mode Timer Interrupt\n");
            // 设置下一次时钟中断
            clock_set_next_event();
        }
    }
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
}
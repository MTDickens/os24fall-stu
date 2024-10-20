.extern start_kernel
.include "../entry.S"

.section .text.init
.globl _start
_start:
    # 设置栈指针
    la sp, boot_stack_top

    # 设置 stvec = _traps
    la t1, _traps
    csrw stvec, t1

    # 设置 sie[STIE] = 1
    csrr t1, sie
    li t2, 0x20
    or t1, t1, t2
    csrs sie, t1

    # 设置第一个时钟中断
    li t1, 0x100000
    csrw stimecmp, t1

    # 设置 sstatus[SIE] = 1
    csrr t1, sstatus
    li t2, 0x2
    or t1, t1, t2
    csrw sstatus, t1

    # 跳转到 start_kernel 函数
    la t0, start_kernel
    jalr ra, 0(t0)

.section .bss.stack
.globl boot_stack
boot_stack:
    .space 4096 # 设置栈大小为 4KiB

# .globl boot_stack_top
# boot_stack_top = boot_stack + 4096
.equ boot_stack_top, boot_stack + 4096
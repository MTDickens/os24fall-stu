#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    struct sbiret ret;
    asm volatile (
        "addi a7, %[eid], 0\n"
        "addi a6, %[fid], 0\n"
        "addi a0, %[arg0], 0\n"
        "addi a1, %[arg1], 0\n"
        "addi a2, %[arg2], 0\n"
        "addi a3, %[arg3], 0\n"
        "addi a4, %[arg4], 0\n"
        "addi a5, %[arg5], 0\n"
        "ecall\n"
        "addi %[error], a0, 0\n"
        "addi %[value], a1, 0\n"
        : [error] "=r" (ret.error), [value] "=r" (ret.value)
        : [eid] "r" (eid), [fid] "r" (fid),
          [arg0] "r" (arg0), [arg1] "r" (arg1), [arg2] "r" (arg2),
          [arg3] "r" (arg3), [arg4] "r" (arg4), [arg5] "r" (arg5)
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7"
    );
    return ret;
}

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    return sbi_ecall(0x4442434E, 0x2, byte, 0, 0, 0, 0, 0);
}

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    return sbi_ecall(0x53525354, 0x0, reset_type, reset_reason, 0, 0, 0, 0);
}

struct sbiret sbi_set_timer(uint64_t stime_value) {
    return sbi_ecall(0x54494d45, 0x0, stime_value, 0, 0, 0, 0, 0);
}
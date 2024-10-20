
../../vmlinux:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_skernel>:

.section .text.init
.globl _start
_start:
    # 设置栈指针
    la sp, boot_stack_top
    80200000:	00003117          	auipc	sp,0x3
    80200004:	01013103          	ld	sp,16(sp) # 80203010 <_GLOBAL_OFFSET_TABLE_+0x8>

    # 设置 stvec = _traps
    la t1, _traps
    80200008:	00003317          	auipc	t1,0x3
    8020000c:	01833303          	ld	t1,24(t1) # 80203020 <_GLOBAL_OFFSET_TABLE_+0x18>
    csrw stvec, t1
    80200010:	10531073          	csrw	stvec,t1

    # 设置 sie[STIE] = 1
    csrr t1, sie
    80200014:	10402373          	csrr	t1,sie
    li t2, 0x20
    80200018:	02000393          	li	t2,32
    or t1, t1, t2
    8020001c:	00736333          	or	t1,t1,t2
    csrs sie, t1
    80200020:	10432073          	csrs	sie,t1

    # 设置第一个时钟中断
    li t1, 0x100000
    80200024:	00100337          	lui	t1,0x100
    csrw stimecmp, t1
    80200028:	14d31073          	csrw	stimecmp,t1

    # 设置 sstatus[SIE] = 1
    csrr t1, sstatus
    8020002c:	10002373          	csrr	t1,sstatus
    li t2, 0x2
    80200030:	00200393          	li	t2,2
    or t1, t1, t2
    80200034:	00736333          	or	t1,t1,t2
    csrw sstatus, t1
    80200038:	10031073          	csrw	sstatus,t1

    # 跳转到 start_kernel 函数
    la t0, start_kernel
    8020003c:	00003297          	auipc	t0,0x3
    80200040:	fdc2b283          	ld	t0,-36(t0) # 80203018 <_GLOBAL_OFFSET_TABLE_+0x10>
    jalr ra, 0(t0)
    80200044:	000280e7          	jalr	t0

0000000080200048 <_traps>:
.align 2
.globl _traps 

_traps:
    # Save 32 registers and sepc to stack
    addi sp, sp, -33*8       # Allocate space for 32 registers + sepc
    80200048:	ef810113          	addi	sp,sp,-264
    sd ra, 0*8(sp)
    8020004c:	00113023          	sd	ra,0(sp)
    sd t0, 1*8(sp)
    80200050:	00513423          	sd	t0,8(sp)
    sd t1, 2*8(sp)
    80200054:	00613823          	sd	t1,16(sp)
    sd t2, 3*8(sp)
    80200058:	00713c23          	sd	t2,24(sp)
    sd t3, 4*8(sp)
    8020005c:	03c13023          	sd	t3,32(sp)
    sd t4, 5*8(sp)
    80200060:	03d13423          	sd	t4,40(sp)
    sd t5, 6*8(sp)
    80200064:	03e13823          	sd	t5,48(sp)
    sd t6, 7*8(sp)
    80200068:	03f13c23          	sd	t6,56(sp)
    sd a0, 8*8(sp)
    8020006c:	04a13023          	sd	a0,64(sp)
    sd a1, 9*8(sp)
    80200070:	04b13423          	sd	a1,72(sp)
    sd a2, 10*8(sp)
    80200074:	04c13823          	sd	a2,80(sp)
    sd a3, 11*8(sp)
    80200078:	04d13c23          	sd	a3,88(sp)
    sd a4, 12*8(sp)
    8020007c:	06e13023          	sd	a4,96(sp)
    sd a5, 13*8(sp)
    80200080:	06f13423          	sd	a5,104(sp)
    sd a6, 14*8(sp)
    80200084:	07013823          	sd	a6,112(sp)
    sd a7, 15*8(sp)
    80200088:	07113c23          	sd	a7,120(sp)
    sd s0, 16*8(sp)
    8020008c:	08813023          	sd	s0,128(sp)
    sd s1, 17*8(sp)
    80200090:	08913423          	sd	s1,136(sp)
    sd s2, 18*8(sp)
    80200094:	09213823          	sd	s2,144(sp)
    sd s3, 19*8(sp)
    80200098:	09313c23          	sd	s3,152(sp)
    sd s4, 20*8(sp)
    8020009c:	0b413023          	sd	s4,160(sp)
    sd s5, 21*8(sp)
    802000a0:	0b513423          	sd	s5,168(sp)
    sd s6, 22*8(sp)
    802000a4:	0b613823          	sd	s6,176(sp)
    sd s7, 23*8(sp)
    802000a8:	0b713c23          	sd	s7,184(sp)
    sd s8, 24*8(sp)
    802000ac:	0d813023          	sd	s8,192(sp)
    sd s9, 25*8(sp)
    802000b0:	0d913423          	sd	s9,200(sp)
    sd s10, 26*8(sp)
    802000b4:	0da13823          	sd	s10,208(sp)
    sd s11, 27*8(sp)
    802000b8:	0db13c23          	sd	s11,216(sp)
    sd gp, 28*8(sp)
    802000bc:	0e313023          	sd	gp,224(sp)
    sd tp, 29*8(sp)
    802000c0:	0e413423          	sd	tp,232(sp)
    sd fp, 30*8(sp)
    802000c4:	0e813823          	sd	s0,240(sp)
    csrr t0, sepc
    802000c8:	141022f3          	csrr	t0,sepc
    sd t0, 31*8(sp)
    802000cc:	0e513c23          	sd	t0,248(sp)
    csrr a0, scause
    802000d0:	14202573          	csrr	a0,scause
    csrr a1, sepc
    802000d4:	141025f3          	csrr	a1,sepc

    # Call trap_handler
    call trap_handler
    802000d8:	38c000ef          	jal	80200464 <trap_handler>

    # Restore sepc and 32 registers from stack
    ld t0, 31*8(sp)
    802000dc:	0f813283          	ld	t0,248(sp)
    csrw sepc, t0
    802000e0:	14129073          	csrw	sepc,t0
    ld ra, 0*8(sp)
    802000e4:	00013083          	ld	ra,0(sp)
    ld t0, 1*8(sp)
    802000e8:	00813283          	ld	t0,8(sp)
    ld t1, 2*8(sp)
    802000ec:	01013303          	ld	t1,16(sp)
    ld t2, 3*8(sp)
    802000f0:	01813383          	ld	t2,24(sp)
    ld t3, 4*8(sp)
    802000f4:	02013e03          	ld	t3,32(sp)
    ld t4, 5*8(sp)
    802000f8:	02813e83          	ld	t4,40(sp)
    ld t5, 6*8(sp)
    802000fc:	03013f03          	ld	t5,48(sp)
    ld t6, 7*8(sp)
    80200100:	03813f83          	ld	t6,56(sp)
    ld a0, 8*8(sp)
    80200104:	04013503          	ld	a0,64(sp)
    ld a1, 9*8(sp)
    80200108:	04813583          	ld	a1,72(sp)
    ld a2, 10*8(sp)
    8020010c:	05013603          	ld	a2,80(sp)
    ld a3, 11*8(sp)
    80200110:	05813683          	ld	a3,88(sp)
    ld a4, 12*8(sp)
    80200114:	06013703          	ld	a4,96(sp)
    ld a5, 13*8(sp)
    80200118:	06813783          	ld	a5,104(sp)
    ld a6, 14*8(sp)
    8020011c:	07013803          	ld	a6,112(sp)
    ld a7, 15*8(sp)
    80200120:	07813883          	ld	a7,120(sp)
    ld s0, 16*8(sp)
    80200124:	08013403          	ld	s0,128(sp)
    ld s1, 17*8(sp)
    80200128:	08813483          	ld	s1,136(sp)
    ld s2, 18*8(sp)
    8020012c:	09013903          	ld	s2,144(sp)
    ld s3, 19*8(sp)
    80200130:	09813983          	ld	s3,152(sp)
    ld s4, 20*8(sp)
    80200134:	0a013a03          	ld	s4,160(sp)
    ld s5, 21*8(sp)
    80200138:	0a813a83          	ld	s5,168(sp)
    ld s6, 22*8(sp)
    8020013c:	0b013b03          	ld	s6,176(sp)
    ld s7, 23*8(sp)
    80200140:	0b813b83          	ld	s7,184(sp)
    ld s8, 24*8(sp)
    80200144:	0c013c03          	ld	s8,192(sp)
    ld s9, 25*8(sp)
    80200148:	0c813c83          	ld	s9,200(sp)
    ld s10, 26*8(sp)
    8020014c:	0d013d03          	ld	s10,208(sp)
    ld s11, 27*8(sp)
    80200150:	0d813d83          	ld	s11,216(sp)
    ld gp, 28*8(sp)
    80200154:	0e013183          	ld	gp,224(sp)
    ld tp, 29*8(sp)
    80200158:	0e813203          	ld	tp,232(sp)
    ld fp, 30*8(sp)
    8020015c:	0f013403          	ld	s0,240(sp)
    addi sp, sp, 33*8       # Deallocate stack space
    80200160:	10810113          	addi	sp,sp,264

    # Return from trap
    80200164:	10200073          	sret

0000000080200168 <get_cycles>:
#include "printk.h"

// QEMU 中时钟的频率是 10MHz，也就是 1 秒钟相当于 10000000 个时钟周期
uint64_t TIMECLOCK = 10000000;

uint64_t get_cycles() {
    80200168:	fe010113          	addi	sp,sp,-32
    8020016c:	00813c23          	sd	s0,24(sp)
    80200170:	02010413          	addi	s0,sp,32
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中（也就是 mtime 寄存器）的值并返回
    uint64_t cycles;
    asm volatile("rdtime %[cycles]" : [cycles]"=r"(cycles));
    80200174:	c01027f3          	rdtime	a5
    80200178:	fef43423          	sd	a5,-24(s0)
    return cycles;
    8020017c:	fe843783          	ld	a5,-24(s0)
}
    80200180:	00078513          	mv	a0,a5
    80200184:	01813403          	ld	s0,24(sp)
    80200188:	02010113          	addi	sp,sp,32
    8020018c:	00008067          	ret

0000000080200190 <clock_set_next_event>:

void clock_set_next_event() {
    80200190:	fe010113          	addi	sp,sp,-32
    80200194:	00113c23          	sd	ra,24(sp)
    80200198:	00813823          	sd	s0,16(sp)
    8020019c:	02010413          	addi	s0,sp,32
    // 下一次时钟中断的时间点
    
    uint64_t next = get_cycles() + TIMECLOCK;
    802001a0:	fc9ff0ef          	jal	80200168 <get_cycles>
    802001a4:	00050713          	mv	a4,a0
    802001a8:	00003797          	auipc	a5,0x3
    802001ac:	e5878793          	addi	a5,a5,-424 # 80203000 <TIMECLOCK>
    802001b0:	0007b783          	ld	a5,0(a5)
    802001b4:	00f707b3          	add	a5,a4,a5
    802001b8:	fef43423          	sd	a5,-24(s0)
    // 使用 sbi_set_timer 来完成对下一次时钟中断的设置
    sbi_set_timer(next);
    802001bc:	fe843503          	ld	a0,-24(s0)
    802001c0:	218000ef          	jal	802003d8 <sbi_set_timer>
    802001c4:	00000013          	nop
    802001c8:	01813083          	ld	ra,24(sp)
    802001cc:	01013403          	ld	s0,16(sp)
    802001d0:	02010113          	addi	sp,sp,32
    802001d4:	00008067          	ret

00000000802001d8 <sbi_ecall>:
#include "stdint.h"
#include "sbi.h"

struct sbiret sbi_ecall(uint64_t eid, uint64_t fid,
                        uint64_t arg0, uint64_t arg1, uint64_t arg2,
                        uint64_t arg3, uint64_t arg4, uint64_t arg5) {
    802001d8:	f8010113          	addi	sp,sp,-128
    802001dc:	06813c23          	sd	s0,120(sp)
    802001e0:	06913823          	sd	s1,112(sp)
    802001e4:	07213423          	sd	s2,104(sp)
    802001e8:	07313023          	sd	s3,96(sp)
    802001ec:	08010413          	addi	s0,sp,128
    802001f0:	faa43c23          	sd	a0,-72(s0)
    802001f4:	fab43823          	sd	a1,-80(s0)
    802001f8:	fac43423          	sd	a2,-88(s0)
    802001fc:	fad43023          	sd	a3,-96(s0)
    80200200:	f8e43c23          	sd	a4,-104(s0)
    80200204:	f8f43823          	sd	a5,-112(s0)
    80200208:	f9043423          	sd	a6,-120(s0)
    8020020c:	f9143023          	sd	a7,-128(s0)
    struct sbiret ret;
    asm volatile (
    80200210:	fb843e03          	ld	t3,-72(s0)
    80200214:	fb043e83          	ld	t4,-80(s0)
    80200218:	fa843f03          	ld	t5,-88(s0)
    8020021c:	fa043f83          	ld	t6,-96(s0)
    80200220:	f9843283          	ld	t0,-104(s0)
    80200224:	f9043483          	ld	s1,-112(s0)
    80200228:	f8843903          	ld	s2,-120(s0)
    8020022c:	f8043983          	ld	s3,-128(s0)
    80200230:	000e0893          	mv	a7,t3
    80200234:	000e8813          	mv	a6,t4
    80200238:	000f0513          	mv	a0,t5
    8020023c:	000f8593          	mv	a1,t6
    80200240:	00028613          	mv	a2,t0
    80200244:	00048693          	mv	a3,s1
    80200248:	00090713          	mv	a4,s2
    8020024c:	00098793          	mv	a5,s3
    80200250:	00000073          	ecall
    80200254:	00050e93          	mv	t4,a0
    80200258:	00058e13          	mv	t3,a1
    8020025c:	fdd43023          	sd	t4,-64(s0)
    80200260:	fdc43423          	sd	t3,-56(s0)
        : [eid] "r" (eid), [fid] "r" (fid),
          [arg0] "r" (arg0), [arg1] "r" (arg1), [arg2] "r" (arg2),
          [arg3] "r" (arg3), [arg4] "r" (arg4), [arg5] "r" (arg5)
        : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7"
    );
    return ret;
    80200264:	fc043783          	ld	a5,-64(s0)
    80200268:	fcf43823          	sd	a5,-48(s0)
    8020026c:	fc843783          	ld	a5,-56(s0)
    80200270:	fcf43c23          	sd	a5,-40(s0)
    80200274:	fd043703          	ld	a4,-48(s0)
    80200278:	fd843783          	ld	a5,-40(s0)
    8020027c:	00070313          	mv	t1,a4
    80200280:	00078393          	mv	t2,a5
    80200284:	00030713          	mv	a4,t1
    80200288:	00038793          	mv	a5,t2
}
    8020028c:	00070513          	mv	a0,a4
    80200290:	00078593          	mv	a1,a5
    80200294:	07813403          	ld	s0,120(sp)
    80200298:	07013483          	ld	s1,112(sp)
    8020029c:	06813903          	ld	s2,104(sp)
    802002a0:	06013983          	ld	s3,96(sp)
    802002a4:	08010113          	addi	sp,sp,128
    802002a8:	00008067          	ret

00000000802002ac <sbi_debug_console_write_byte>:

struct sbiret sbi_debug_console_write_byte(uint8_t byte) {
    802002ac:	fc010113          	addi	sp,sp,-64
    802002b0:	02113c23          	sd	ra,56(sp)
    802002b4:	02813823          	sd	s0,48(sp)
    802002b8:	03213423          	sd	s2,40(sp)
    802002bc:	03313023          	sd	s3,32(sp)
    802002c0:	04010413          	addi	s0,sp,64
    802002c4:	00050793          	mv	a5,a0
    802002c8:	fcf407a3          	sb	a5,-49(s0)
    return sbi_ecall(0x4442434E, 0x2, byte, 0, 0, 0, 0, 0);
    802002cc:	fcf44603          	lbu	a2,-49(s0)
    802002d0:	00000893          	li	a7,0
    802002d4:	00000813          	li	a6,0
    802002d8:	00000793          	li	a5,0
    802002dc:	00000713          	li	a4,0
    802002e0:	00000693          	li	a3,0
    802002e4:	00200593          	li	a1,2
    802002e8:	44424537          	lui	a0,0x44424
    802002ec:	34e50513          	addi	a0,a0,846 # 4442434e <_skernel-0x3bddbcb2>
    802002f0:	ee9ff0ef          	jal	802001d8 <sbi_ecall>
    802002f4:	00050713          	mv	a4,a0
    802002f8:	00058793          	mv	a5,a1
    802002fc:	fce43823          	sd	a4,-48(s0)
    80200300:	fcf43c23          	sd	a5,-40(s0)
    80200304:	fd043703          	ld	a4,-48(s0)
    80200308:	fd843783          	ld	a5,-40(s0)
    8020030c:	00070913          	mv	s2,a4
    80200310:	00078993          	mv	s3,a5
    80200314:	00090713          	mv	a4,s2
    80200318:	00098793          	mv	a5,s3
}
    8020031c:	00070513          	mv	a0,a4
    80200320:	00078593          	mv	a1,a5
    80200324:	03813083          	ld	ra,56(sp)
    80200328:	03013403          	ld	s0,48(sp)
    8020032c:	02813903          	ld	s2,40(sp)
    80200330:	02013983          	ld	s3,32(sp)
    80200334:	04010113          	addi	sp,sp,64
    80200338:	00008067          	ret

000000008020033c <sbi_system_reset>:

struct sbiret sbi_system_reset(uint32_t reset_type, uint32_t reset_reason) {
    8020033c:	fc010113          	addi	sp,sp,-64
    80200340:	02113c23          	sd	ra,56(sp)
    80200344:	02813823          	sd	s0,48(sp)
    80200348:	03213423          	sd	s2,40(sp)
    8020034c:	03313023          	sd	s3,32(sp)
    80200350:	04010413          	addi	s0,sp,64
    80200354:	00050793          	mv	a5,a0
    80200358:	00058713          	mv	a4,a1
    8020035c:	fcf42623          	sw	a5,-52(s0)
    80200360:	00070793          	mv	a5,a4
    80200364:	fcf42423          	sw	a5,-56(s0)
    return sbi_ecall(0x53525354, 0x0, reset_type, reset_reason, 0, 0, 0, 0);
    80200368:	fcc46603          	lwu	a2,-52(s0)
    8020036c:	fc846683          	lwu	a3,-56(s0)
    80200370:	00000893          	li	a7,0
    80200374:	00000813          	li	a6,0
    80200378:	00000793          	li	a5,0
    8020037c:	00000713          	li	a4,0
    80200380:	00000593          	li	a1,0
    80200384:	53525537          	lui	a0,0x53525
    80200388:	35450513          	addi	a0,a0,852 # 53525354 <_skernel-0x2ccdacac>
    8020038c:	e4dff0ef          	jal	802001d8 <sbi_ecall>
    80200390:	00050713          	mv	a4,a0
    80200394:	00058793          	mv	a5,a1
    80200398:	fce43823          	sd	a4,-48(s0)
    8020039c:	fcf43c23          	sd	a5,-40(s0)
    802003a0:	fd043703          	ld	a4,-48(s0)
    802003a4:	fd843783          	ld	a5,-40(s0)
    802003a8:	00070913          	mv	s2,a4
    802003ac:	00078993          	mv	s3,a5
    802003b0:	00090713          	mv	a4,s2
    802003b4:	00098793          	mv	a5,s3
}
    802003b8:	00070513          	mv	a0,a4
    802003bc:	00078593          	mv	a1,a5
    802003c0:	03813083          	ld	ra,56(sp)
    802003c4:	03013403          	ld	s0,48(sp)
    802003c8:	02813903          	ld	s2,40(sp)
    802003cc:	02013983          	ld	s3,32(sp)
    802003d0:	04010113          	addi	sp,sp,64
    802003d4:	00008067          	ret

00000000802003d8 <sbi_set_timer>:

struct sbiret sbi_set_timer(uint64_t stime_value) {
    802003d8:	fc010113          	addi	sp,sp,-64
    802003dc:	02113c23          	sd	ra,56(sp)
    802003e0:	02813823          	sd	s0,48(sp)
    802003e4:	03213423          	sd	s2,40(sp)
    802003e8:	03313023          	sd	s3,32(sp)
    802003ec:	04010413          	addi	s0,sp,64
    802003f0:	fca43423          	sd	a0,-56(s0)
    return sbi_ecall(0x54494d45, 0x0, stime_value, 0, 0, 0, 0, 0);
    802003f4:	00000893          	li	a7,0
    802003f8:	00000813          	li	a6,0
    802003fc:	00000793          	li	a5,0
    80200400:	00000713          	li	a4,0
    80200404:	00000693          	li	a3,0
    80200408:	fc843603          	ld	a2,-56(s0)
    8020040c:	00000593          	li	a1,0
    80200410:	54495537          	lui	a0,0x54495
    80200414:	d4550513          	addi	a0,a0,-699 # 54494d45 <_skernel-0x2bd6b2bb>
    80200418:	dc1ff0ef          	jal	802001d8 <sbi_ecall>
    8020041c:	00050713          	mv	a4,a0
    80200420:	00058793          	mv	a5,a1
    80200424:	fce43823          	sd	a4,-48(s0)
    80200428:	fcf43c23          	sd	a5,-40(s0)
    8020042c:	fd043703          	ld	a4,-48(s0)
    80200430:	fd843783          	ld	a5,-40(s0)
    80200434:	00070913          	mv	s2,a4
    80200438:	00078993          	mv	s3,a5
    8020043c:	00090713          	mv	a4,s2
    80200440:	00098793          	mv	a5,s3
    80200444:	00070513          	mv	a0,a4
    80200448:	00078593          	mv	a1,a5
    8020044c:	03813083          	ld	ra,56(sp)
    80200450:	03013403          	ld	s0,48(sp)
    80200454:	02813903          	ld	s2,40(sp)
    80200458:	02013983          	ld	s3,32(sp)
    8020045c:	04010113          	addi	sp,sp,64
    80200460:	00008067          	ret

0000000080200464 <trap_handler>:
#define MACHINE_TIMER_INT 7
#define SUPERVISOR_TIMER_INT 5



void trap_handler(uint64_t scause, uint64_t sepc) {
    80200464:	fa010113          	addi	sp,sp,-96
    80200468:	04113c23          	sd	ra,88(sp)
    8020046c:	04813823          	sd	s0,80(sp)
    80200470:	06010413          	addi	s0,sp,96
    80200474:	faa43423          	sd	a0,-88(s0)
    80200478:	fab43023          	sd	a1,-96(s0)
    // 通过 `scause` 判断 trap 类型
    uint64_t is_interrupt = (scause >> 63) & 1;
    8020047c:	fa843783          	ld	a5,-88(s0)
    80200480:	03f7d793          	srli	a5,a5,0x3f
    80200484:	fef43423          	sd	a5,-24(s0)
    // printk("scause: %lx, sepc: %lx\n", scause, sepc);

    // 思考题 3：用 csr_read 宏读取 sstatus 寄存器的值，对照 RISC-V 手册解释其含义并截图
    uint64_t sstatus_value = csr_read(sstatus);
    80200488:	100027f3          	csrr	a5,sstatus
    8020048c:	fef43023          	sd	a5,-32(s0)
    80200490:	fe043783          	ld	a5,-32(s0)
    80200494:	fcf43c23          	sd	a5,-40(s0)
    printk("sstatus in trap_handler: ");
    80200498:	00002517          	auipc	a0,0x2
    8020049c:	b6850513          	addi	a0,a0,-1176 # 80202000 <_srodata>
    802004a0:	7b1000ef          	jal	80201450 <printk>
    // printk_binary_64(sstatus_value);
    printk_binary_64_1s_pos(sstatus_value);
    802004a4:	fd843503          	ld	a0,-40(s0)
    802004a8:	0d0010ef          	jal	80201578 <printk_binary_64_1s_pos>

    // 思考题 4: 用 csr_write 宏向 sscratch 寄存器写入数据，并验证是否写入成功并截图
    csr_write(sscratch, 0x3220104982);
    802004ac:	00002797          	auipc	a5,0x2
    802004b0:	bbc78793          	addi	a5,a5,-1092 # 80202068 <_srodata+0x68>
    802004b4:	0007b783          	ld	a5,0(a5)
    802004b8:	fcf43823          	sd	a5,-48(s0)
    802004bc:	fd043783          	ld	a5,-48(s0)
    802004c0:	14079073          	csrw	sscratch,a5
    uint64_t sscratch_value = csr_read(sscratch);
    802004c4:	140027f3          	csrr	a5,sscratch
    802004c8:	fcf43423          	sd	a5,-56(s0)
    802004cc:	fc843783          	ld	a5,-56(s0)
    802004d0:	fcf43023          	sd	a5,-64(s0)
    printk("sscratch in trap_handler: %lx\n", sscratch_value);
    802004d4:	fc043583          	ld	a1,-64(s0)
    802004d8:	00002517          	auipc	a0,0x2
    802004dc:	b4850513          	addi	a0,a0,-1208 # 80202020 <_srodata+0x20>
    802004e0:	771000ef          	jal	80201450 <printk>

    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    if (is_interrupt) {
    802004e4:	fe843783          	ld	a5,-24(s0)
    802004e8:	02078663          	beqz	a5,80200514 <trap_handler+0xb0>
        int exception_code = scause & ((1UL << 63) - 1);
    802004ec:	fa843783          	ld	a5,-88(s0)
    802004f0:	faf42e23          	sw	a5,-68(s0)
        if (exception_code == SUPERVISOR_TIMER_INT) {
    802004f4:	fbc42783          	lw	a5,-68(s0)
    802004f8:	0007871b          	sext.w	a4,a5
    802004fc:	00500793          	li	a5,5
    80200500:	00f71a63          	bne	a4,a5,80200514 <trap_handler+0xb0>
            // 时钟中断
            // 打印输出信息
            printk("[S] Supervisor Mode Timer Interrupt\n");
    80200504:	00002517          	auipc	a0,0x2
    80200508:	b3c50513          	addi	a0,a0,-1220 # 80202040 <_srodata+0x40>
    8020050c:	745000ef          	jal	80201450 <printk>
            // 设置下一次时钟中断
            clock_set_next_event();
    80200510:	c81ff0ef          	jal	80200190 <clock_set_next_event>
        }
    }
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试
    80200514:	00000013          	nop
    80200518:	05813083          	ld	ra,88(sp)
    8020051c:	05013403          	ld	s0,80(sp)
    80200520:	06010113          	addi	sp,sp,96
    80200524:	00008067          	ret

0000000080200528 <start_kernel>:
#include "printk.h"

extern void test();

int start_kernel() {
    80200528:	ff010113          	addi	sp,sp,-16
    8020052c:	00113423          	sd	ra,8(sp)
    80200530:	00813023          	sd	s0,0(sp)
    80200534:	01010413          	addi	s0,sp,16
    printk("2024");
    80200538:	00002517          	auipc	a0,0x2
    8020053c:	b3850513          	addi	a0,a0,-1224 # 80202070 <_srodata+0x70>
    80200540:	711000ef          	jal	80201450 <printk>
    printk(" ZJU Operating System\n");
    80200544:	00002517          	auipc	a0,0x2
    80200548:	b3450513          	addi	a0,a0,-1228 # 80202078 <_srodata+0x78>
    8020054c:	705000ef          	jal	80201450 <printk>

    test();
    80200550:	01c000ef          	jal	8020056c <test>
    return 0;
    80200554:	00000793          	li	a5,0
}
    80200558:	00078513          	mv	a0,a5
    8020055c:	00813083          	ld	ra,8(sp)
    80200560:	00013403          	ld	s0,0(sp)
    80200564:	01010113          	addi	sp,sp,16
    80200568:	00008067          	ret

000000008020056c <test>:
//     __builtin_unreachable();
// }

#include "printk.h"

void test() {
    8020056c:	fe010113          	addi	sp,sp,-32
    80200570:	00113c23          	sd	ra,24(sp)
    80200574:	00813823          	sd	s0,16(sp)
    80200578:	02010413          	addi	s0,sp,32
    int i = 0;
    8020057c:	fe042623          	sw	zero,-20(s0)
    while (1) {
        if ((++i) % 200000000 == 0) {
    80200580:	fec42783          	lw	a5,-20(s0)
    80200584:	0017879b          	addiw	a5,a5,1
    80200588:	fef42623          	sw	a5,-20(s0)
    8020058c:	fec42783          	lw	a5,-20(s0)
    80200590:	00078713          	mv	a4,a5
    80200594:	0bebc7b7          	lui	a5,0xbebc
    80200598:	2007879b          	addiw	a5,a5,512 # bebc200 <_skernel-0x74343e00>
    8020059c:	02f767bb          	remw	a5,a4,a5
    802005a0:	0007879b          	sext.w	a5,a5
    802005a4:	fc079ee3          	bnez	a5,80200580 <test+0x14>
            printk("kernel is running!\n");
    802005a8:	00002517          	auipc	a0,0x2
    802005ac:	ae850513          	addi	a0,a0,-1304 # 80202090 <_srodata+0x90>
    802005b0:	6a1000ef          	jal	80201450 <printk>
            i = 0;
    802005b4:	fe042623          	sw	zero,-20(s0)
        if ((++i) % 200000000 == 0) {
    802005b8:	fc9ff06f          	j	80200580 <test+0x14>

00000000802005bc <putc>:
// credit: 45gfg9 <45gfg9@45gfg9.net>

#include "printk.h"
#include "sbi.h"

int putc(int c) {
    802005bc:	fe010113          	addi	sp,sp,-32
    802005c0:	00113c23          	sd	ra,24(sp)
    802005c4:	00813823          	sd	s0,16(sp)
    802005c8:	02010413          	addi	s0,sp,32
    802005cc:	00050793          	mv	a5,a0
    802005d0:	fef42623          	sw	a5,-20(s0)
    sbi_debug_console_write_byte(c);
    802005d4:	fec42783          	lw	a5,-20(s0)
    802005d8:	0ff7f793          	zext.b	a5,a5
    802005dc:	00078513          	mv	a0,a5
    802005e0:	ccdff0ef          	jal	802002ac <sbi_debug_console_write_byte>
    return (char)c;
    802005e4:	fec42783          	lw	a5,-20(s0)
    802005e8:	0ff7f793          	zext.b	a5,a5
    802005ec:	0007879b          	sext.w	a5,a5
}
    802005f0:	00078513          	mv	a0,a5
    802005f4:	01813083          	ld	ra,24(sp)
    802005f8:	01013403          	ld	s0,16(sp)
    802005fc:	02010113          	addi	sp,sp,32
    80200600:	00008067          	ret

0000000080200604 <isspace>:
    bool sign;
    int width;
    int prec;
};

int isspace(int c) {
    80200604:	fe010113          	addi	sp,sp,-32
    80200608:	00813c23          	sd	s0,24(sp)
    8020060c:	02010413          	addi	s0,sp,32
    80200610:	00050793          	mv	a5,a0
    80200614:	fef42623          	sw	a5,-20(s0)
    return c == ' ' || (c >= '\t' && c <= '\r');
    80200618:	fec42783          	lw	a5,-20(s0)
    8020061c:	0007871b          	sext.w	a4,a5
    80200620:	02000793          	li	a5,32
    80200624:	02f70263          	beq	a4,a5,80200648 <isspace+0x44>
    80200628:	fec42783          	lw	a5,-20(s0)
    8020062c:	0007871b          	sext.w	a4,a5
    80200630:	00800793          	li	a5,8
    80200634:	00e7de63          	bge	a5,a4,80200650 <isspace+0x4c>
    80200638:	fec42783          	lw	a5,-20(s0)
    8020063c:	0007871b          	sext.w	a4,a5
    80200640:	00d00793          	li	a5,13
    80200644:	00e7c663          	blt	a5,a4,80200650 <isspace+0x4c>
    80200648:	00100793          	li	a5,1
    8020064c:	0080006f          	j	80200654 <isspace+0x50>
    80200650:	00000793          	li	a5,0
}
    80200654:	00078513          	mv	a0,a5
    80200658:	01813403          	ld	s0,24(sp)
    8020065c:	02010113          	addi	sp,sp,32
    80200660:	00008067          	ret

0000000080200664 <strtol>:

long strtol(const char *restrict nptr, char **restrict endptr, int base) {
    80200664:	fb010113          	addi	sp,sp,-80
    80200668:	04113423          	sd	ra,72(sp)
    8020066c:	04813023          	sd	s0,64(sp)
    80200670:	05010413          	addi	s0,sp,80
    80200674:	fca43423          	sd	a0,-56(s0)
    80200678:	fcb43023          	sd	a1,-64(s0)
    8020067c:	00060793          	mv	a5,a2
    80200680:	faf42e23          	sw	a5,-68(s0)
    long ret = 0;
    80200684:	fe043423          	sd	zero,-24(s0)
    bool neg = false;
    80200688:	fe0403a3          	sb	zero,-25(s0)
    const char *p = nptr;
    8020068c:	fc843783          	ld	a5,-56(s0)
    80200690:	fcf43c23          	sd	a5,-40(s0)

    while (isspace(*p)) {
    80200694:	0100006f          	j	802006a4 <strtol+0x40>
        p++;
    80200698:	fd843783          	ld	a5,-40(s0)
    8020069c:	00178793          	addi	a5,a5,1
    802006a0:	fcf43c23          	sd	a5,-40(s0)
    while (isspace(*p)) {
    802006a4:	fd843783          	ld	a5,-40(s0)
    802006a8:	0007c783          	lbu	a5,0(a5)
    802006ac:	0007879b          	sext.w	a5,a5
    802006b0:	00078513          	mv	a0,a5
    802006b4:	f51ff0ef          	jal	80200604 <isspace>
    802006b8:	00050793          	mv	a5,a0
    802006bc:	fc079ee3          	bnez	a5,80200698 <strtol+0x34>
    }

    if (*p == '-') {
    802006c0:	fd843783          	ld	a5,-40(s0)
    802006c4:	0007c783          	lbu	a5,0(a5)
    802006c8:	00078713          	mv	a4,a5
    802006cc:	02d00793          	li	a5,45
    802006d0:	00f71e63          	bne	a4,a5,802006ec <strtol+0x88>
        neg = true;
    802006d4:	00100793          	li	a5,1
    802006d8:	fef403a3          	sb	a5,-25(s0)
        p++;
    802006dc:	fd843783          	ld	a5,-40(s0)
    802006e0:	00178793          	addi	a5,a5,1
    802006e4:	fcf43c23          	sd	a5,-40(s0)
    802006e8:	0240006f          	j	8020070c <strtol+0xa8>
    } else if (*p == '+') {
    802006ec:	fd843783          	ld	a5,-40(s0)
    802006f0:	0007c783          	lbu	a5,0(a5)
    802006f4:	00078713          	mv	a4,a5
    802006f8:	02b00793          	li	a5,43
    802006fc:	00f71863          	bne	a4,a5,8020070c <strtol+0xa8>
        p++;
    80200700:	fd843783          	ld	a5,-40(s0)
    80200704:	00178793          	addi	a5,a5,1
    80200708:	fcf43c23          	sd	a5,-40(s0)
    }

    if (base == 0) {
    8020070c:	fbc42783          	lw	a5,-68(s0)
    80200710:	0007879b          	sext.w	a5,a5
    80200714:	06079c63          	bnez	a5,8020078c <strtol+0x128>
        if (*p == '0') {
    80200718:	fd843783          	ld	a5,-40(s0)
    8020071c:	0007c783          	lbu	a5,0(a5)
    80200720:	00078713          	mv	a4,a5
    80200724:	03000793          	li	a5,48
    80200728:	04f71e63          	bne	a4,a5,80200784 <strtol+0x120>
            p++;
    8020072c:	fd843783          	ld	a5,-40(s0)
    80200730:	00178793          	addi	a5,a5,1
    80200734:	fcf43c23          	sd	a5,-40(s0)
            if (*p == 'x' || *p == 'X') {
    80200738:	fd843783          	ld	a5,-40(s0)
    8020073c:	0007c783          	lbu	a5,0(a5)
    80200740:	00078713          	mv	a4,a5
    80200744:	07800793          	li	a5,120
    80200748:	00f70c63          	beq	a4,a5,80200760 <strtol+0xfc>
    8020074c:	fd843783          	ld	a5,-40(s0)
    80200750:	0007c783          	lbu	a5,0(a5)
    80200754:	00078713          	mv	a4,a5
    80200758:	05800793          	li	a5,88
    8020075c:	00f71e63          	bne	a4,a5,80200778 <strtol+0x114>
                base = 16;
    80200760:	01000793          	li	a5,16
    80200764:	faf42e23          	sw	a5,-68(s0)
                p++;
    80200768:	fd843783          	ld	a5,-40(s0)
    8020076c:	00178793          	addi	a5,a5,1
    80200770:	fcf43c23          	sd	a5,-40(s0)
    80200774:	0180006f          	j	8020078c <strtol+0x128>
            } else {
                base = 8;
    80200778:	00800793          	li	a5,8
    8020077c:	faf42e23          	sw	a5,-68(s0)
    80200780:	00c0006f          	j	8020078c <strtol+0x128>
            }
        } else {
            base = 10;
    80200784:	00a00793          	li	a5,10
    80200788:	faf42e23          	sw	a5,-68(s0)
        }
    }

    while (1) {
        int digit;
        if (*p >= '0' && *p <= '9') {
    8020078c:	fd843783          	ld	a5,-40(s0)
    80200790:	0007c783          	lbu	a5,0(a5)
    80200794:	00078713          	mv	a4,a5
    80200798:	02f00793          	li	a5,47
    8020079c:	02e7f863          	bgeu	a5,a4,802007cc <strtol+0x168>
    802007a0:	fd843783          	ld	a5,-40(s0)
    802007a4:	0007c783          	lbu	a5,0(a5)
    802007a8:	00078713          	mv	a4,a5
    802007ac:	03900793          	li	a5,57
    802007b0:	00e7ee63          	bltu	a5,a4,802007cc <strtol+0x168>
            digit = *p - '0';
    802007b4:	fd843783          	ld	a5,-40(s0)
    802007b8:	0007c783          	lbu	a5,0(a5)
    802007bc:	0007879b          	sext.w	a5,a5
    802007c0:	fd07879b          	addiw	a5,a5,-48
    802007c4:	fcf42a23          	sw	a5,-44(s0)
    802007c8:	0800006f          	j	80200848 <strtol+0x1e4>
        } else if (*p >= 'a' && *p <= 'z') {
    802007cc:	fd843783          	ld	a5,-40(s0)
    802007d0:	0007c783          	lbu	a5,0(a5)
    802007d4:	00078713          	mv	a4,a5
    802007d8:	06000793          	li	a5,96
    802007dc:	02e7f863          	bgeu	a5,a4,8020080c <strtol+0x1a8>
    802007e0:	fd843783          	ld	a5,-40(s0)
    802007e4:	0007c783          	lbu	a5,0(a5)
    802007e8:	00078713          	mv	a4,a5
    802007ec:	07a00793          	li	a5,122
    802007f0:	00e7ee63          	bltu	a5,a4,8020080c <strtol+0x1a8>
            digit = *p - ('a' - 10);
    802007f4:	fd843783          	ld	a5,-40(s0)
    802007f8:	0007c783          	lbu	a5,0(a5)
    802007fc:	0007879b          	sext.w	a5,a5
    80200800:	fa97879b          	addiw	a5,a5,-87
    80200804:	fcf42a23          	sw	a5,-44(s0)
    80200808:	0400006f          	j	80200848 <strtol+0x1e4>
        } else if (*p >= 'A' && *p <= 'Z') {
    8020080c:	fd843783          	ld	a5,-40(s0)
    80200810:	0007c783          	lbu	a5,0(a5)
    80200814:	00078713          	mv	a4,a5
    80200818:	04000793          	li	a5,64
    8020081c:	06e7f863          	bgeu	a5,a4,8020088c <strtol+0x228>
    80200820:	fd843783          	ld	a5,-40(s0)
    80200824:	0007c783          	lbu	a5,0(a5)
    80200828:	00078713          	mv	a4,a5
    8020082c:	05a00793          	li	a5,90
    80200830:	04e7ee63          	bltu	a5,a4,8020088c <strtol+0x228>
            digit = *p - ('A' - 10);
    80200834:	fd843783          	ld	a5,-40(s0)
    80200838:	0007c783          	lbu	a5,0(a5)
    8020083c:	0007879b          	sext.w	a5,a5
    80200840:	fc97879b          	addiw	a5,a5,-55
    80200844:	fcf42a23          	sw	a5,-44(s0)
        } else {
            break;
        }

        if (digit >= base) {
    80200848:	fd442783          	lw	a5,-44(s0)
    8020084c:	00078713          	mv	a4,a5
    80200850:	fbc42783          	lw	a5,-68(s0)
    80200854:	0007071b          	sext.w	a4,a4
    80200858:	0007879b          	sext.w	a5,a5
    8020085c:	02f75663          	bge	a4,a5,80200888 <strtol+0x224>
            break;
        }

        ret = ret * base + digit;
    80200860:	fbc42703          	lw	a4,-68(s0)
    80200864:	fe843783          	ld	a5,-24(s0)
    80200868:	02f70733          	mul	a4,a4,a5
    8020086c:	fd442783          	lw	a5,-44(s0)
    80200870:	00f707b3          	add	a5,a4,a5
    80200874:	fef43423          	sd	a5,-24(s0)
        p++;
    80200878:	fd843783          	ld	a5,-40(s0)
    8020087c:	00178793          	addi	a5,a5,1
    80200880:	fcf43c23          	sd	a5,-40(s0)
    while (1) {
    80200884:	f09ff06f          	j	8020078c <strtol+0x128>
            break;
    80200888:	00000013          	nop
    }

    if (endptr) {
    8020088c:	fc043783          	ld	a5,-64(s0)
    80200890:	00078863          	beqz	a5,802008a0 <strtol+0x23c>
        *endptr = (char *)p;
    80200894:	fc043783          	ld	a5,-64(s0)
    80200898:	fd843703          	ld	a4,-40(s0)
    8020089c:	00e7b023          	sd	a4,0(a5)
    }

    return neg ? -ret : ret;
    802008a0:	fe744783          	lbu	a5,-25(s0)
    802008a4:	0ff7f793          	zext.b	a5,a5
    802008a8:	00078863          	beqz	a5,802008b8 <strtol+0x254>
    802008ac:	fe843783          	ld	a5,-24(s0)
    802008b0:	40f007b3          	neg	a5,a5
    802008b4:	0080006f          	j	802008bc <strtol+0x258>
    802008b8:	fe843783          	ld	a5,-24(s0)
}
    802008bc:	00078513          	mv	a0,a5
    802008c0:	04813083          	ld	ra,72(sp)
    802008c4:	04013403          	ld	s0,64(sp)
    802008c8:	05010113          	addi	sp,sp,80
    802008cc:	00008067          	ret

00000000802008d0 <puts_wo_nl>:

// puts without newline
static int puts_wo_nl(int (*putch)(int), const char *s) {
    802008d0:	fd010113          	addi	sp,sp,-48
    802008d4:	02113423          	sd	ra,40(sp)
    802008d8:	02813023          	sd	s0,32(sp)
    802008dc:	03010413          	addi	s0,sp,48
    802008e0:	fca43c23          	sd	a0,-40(s0)
    802008e4:	fcb43823          	sd	a1,-48(s0)
    if (!s) {
    802008e8:	fd043783          	ld	a5,-48(s0)
    802008ec:	00079863          	bnez	a5,802008fc <puts_wo_nl+0x2c>
        s = "(null)";
    802008f0:	00001797          	auipc	a5,0x1
    802008f4:	7b878793          	addi	a5,a5,1976 # 802020a8 <_srodata+0xa8>
    802008f8:	fcf43823          	sd	a5,-48(s0)
    }
    const char *p = s;
    802008fc:	fd043783          	ld	a5,-48(s0)
    80200900:	fef43423          	sd	a5,-24(s0)
    while (*p) {
    80200904:	0240006f          	j	80200928 <puts_wo_nl+0x58>
        putch(*p++);
    80200908:	fe843783          	ld	a5,-24(s0)
    8020090c:	00178713          	addi	a4,a5,1
    80200910:	fee43423          	sd	a4,-24(s0)
    80200914:	0007c783          	lbu	a5,0(a5)
    80200918:	0007871b          	sext.w	a4,a5
    8020091c:	fd843783          	ld	a5,-40(s0)
    80200920:	00070513          	mv	a0,a4
    80200924:	000780e7          	jalr	a5
    while (*p) {
    80200928:	fe843783          	ld	a5,-24(s0)
    8020092c:	0007c783          	lbu	a5,0(a5)
    80200930:	fc079ce3          	bnez	a5,80200908 <puts_wo_nl+0x38>
    }
    return p - s;
    80200934:	fe843703          	ld	a4,-24(s0)
    80200938:	fd043783          	ld	a5,-48(s0)
    8020093c:	40f707b3          	sub	a5,a4,a5
    80200940:	0007879b          	sext.w	a5,a5
}
    80200944:	00078513          	mv	a0,a5
    80200948:	02813083          	ld	ra,40(sp)
    8020094c:	02013403          	ld	s0,32(sp)
    80200950:	03010113          	addi	sp,sp,48
    80200954:	00008067          	ret

0000000080200958 <print_dec_int>:

static int print_dec_int(int (*putch)(int), unsigned long num, bool is_signed, struct fmt_flags *flags) {
    80200958:	f9010113          	addi	sp,sp,-112
    8020095c:	06113423          	sd	ra,104(sp)
    80200960:	06813023          	sd	s0,96(sp)
    80200964:	07010413          	addi	s0,sp,112
    80200968:	faa43423          	sd	a0,-88(s0)
    8020096c:	fab43023          	sd	a1,-96(s0)
    80200970:	00060793          	mv	a5,a2
    80200974:	f8d43823          	sd	a3,-112(s0)
    80200978:	f8f40fa3          	sb	a5,-97(s0)
    if (is_signed && num == 0x8000000000000000UL) {
    8020097c:	f9f44783          	lbu	a5,-97(s0)
    80200980:	0ff7f793          	zext.b	a5,a5
    80200984:	02078663          	beqz	a5,802009b0 <print_dec_int+0x58>
    80200988:	fa043703          	ld	a4,-96(s0)
    8020098c:	fff00793          	li	a5,-1
    80200990:	03f79793          	slli	a5,a5,0x3f
    80200994:	00f71e63          	bne	a4,a5,802009b0 <print_dec_int+0x58>
        // special case for 0x8000000000000000
        return puts_wo_nl(putch, "-9223372036854775808");
    80200998:	00001597          	auipc	a1,0x1
    8020099c:	71858593          	addi	a1,a1,1816 # 802020b0 <_srodata+0xb0>
    802009a0:	fa843503          	ld	a0,-88(s0)
    802009a4:	f2dff0ef          	jal	802008d0 <puts_wo_nl>
    802009a8:	00050793          	mv	a5,a0
    802009ac:	2a00006f          	j	80200c4c <print_dec_int+0x2f4>
    }

    if (flags->prec == 0 && num == 0) {
    802009b0:	f9043783          	ld	a5,-112(s0)
    802009b4:	00c7a783          	lw	a5,12(a5)
    802009b8:	00079a63          	bnez	a5,802009cc <print_dec_int+0x74>
    802009bc:	fa043783          	ld	a5,-96(s0)
    802009c0:	00079663          	bnez	a5,802009cc <print_dec_int+0x74>
        return 0;
    802009c4:	00000793          	li	a5,0
    802009c8:	2840006f          	j	80200c4c <print_dec_int+0x2f4>
    }

    bool neg = false;
    802009cc:	fe0407a3          	sb	zero,-17(s0)

    if (is_signed && (long)num < 0) {
    802009d0:	f9f44783          	lbu	a5,-97(s0)
    802009d4:	0ff7f793          	zext.b	a5,a5
    802009d8:	02078063          	beqz	a5,802009f8 <print_dec_int+0xa0>
    802009dc:	fa043783          	ld	a5,-96(s0)
    802009e0:	0007dc63          	bgez	a5,802009f8 <print_dec_int+0xa0>
        neg = true;
    802009e4:	00100793          	li	a5,1
    802009e8:	fef407a3          	sb	a5,-17(s0)
        num = -num;
    802009ec:	fa043783          	ld	a5,-96(s0)
    802009f0:	40f007b3          	neg	a5,a5
    802009f4:	faf43023          	sd	a5,-96(s0)
    }

    char buf[20];
    int decdigits = 0;
    802009f8:	fe042423          	sw	zero,-24(s0)

    bool has_sign_char = is_signed && (neg || flags->sign || flags->spaceflag);
    802009fc:	f9f44783          	lbu	a5,-97(s0)
    80200a00:	0ff7f793          	zext.b	a5,a5
    80200a04:	02078863          	beqz	a5,80200a34 <print_dec_int+0xdc>
    80200a08:	fef44783          	lbu	a5,-17(s0)
    80200a0c:	0ff7f793          	zext.b	a5,a5
    80200a10:	00079e63          	bnez	a5,80200a2c <print_dec_int+0xd4>
    80200a14:	f9043783          	ld	a5,-112(s0)
    80200a18:	0057c783          	lbu	a5,5(a5)
    80200a1c:	00079863          	bnez	a5,80200a2c <print_dec_int+0xd4>
    80200a20:	f9043783          	ld	a5,-112(s0)
    80200a24:	0047c783          	lbu	a5,4(a5)
    80200a28:	00078663          	beqz	a5,80200a34 <print_dec_int+0xdc>
    80200a2c:	00100793          	li	a5,1
    80200a30:	0080006f          	j	80200a38 <print_dec_int+0xe0>
    80200a34:	00000793          	li	a5,0
    80200a38:	fcf40ba3          	sb	a5,-41(s0)
    80200a3c:	fd744783          	lbu	a5,-41(s0)
    80200a40:	0017f793          	andi	a5,a5,1
    80200a44:	fcf40ba3          	sb	a5,-41(s0)

    do {
        buf[decdigits++] = num % 10 + '0';
    80200a48:	fa043703          	ld	a4,-96(s0)
    80200a4c:	00a00793          	li	a5,10
    80200a50:	02f777b3          	remu	a5,a4,a5
    80200a54:	0ff7f713          	zext.b	a4,a5
    80200a58:	fe842783          	lw	a5,-24(s0)
    80200a5c:	0017869b          	addiw	a3,a5,1
    80200a60:	fed42423          	sw	a3,-24(s0)
    80200a64:	0307071b          	addiw	a4,a4,48
    80200a68:	0ff77713          	zext.b	a4,a4
    80200a6c:	ff078793          	addi	a5,a5,-16
    80200a70:	008787b3          	add	a5,a5,s0
    80200a74:	fce78423          	sb	a4,-56(a5)
        num /= 10;
    80200a78:	fa043703          	ld	a4,-96(s0)
    80200a7c:	00a00793          	li	a5,10
    80200a80:	02f757b3          	divu	a5,a4,a5
    80200a84:	faf43023          	sd	a5,-96(s0)
    } while (num);
    80200a88:	fa043783          	ld	a5,-96(s0)
    80200a8c:	fa079ee3          	bnez	a5,80200a48 <print_dec_int+0xf0>

    if (flags->prec == -1 && flags->zeroflag) {
    80200a90:	f9043783          	ld	a5,-112(s0)
    80200a94:	00c7a783          	lw	a5,12(a5)
    80200a98:	00078713          	mv	a4,a5
    80200a9c:	fff00793          	li	a5,-1
    80200aa0:	02f71063          	bne	a4,a5,80200ac0 <print_dec_int+0x168>
    80200aa4:	f9043783          	ld	a5,-112(s0)
    80200aa8:	0037c783          	lbu	a5,3(a5)
    80200aac:	00078a63          	beqz	a5,80200ac0 <print_dec_int+0x168>
        flags->prec = flags->width;
    80200ab0:	f9043783          	ld	a5,-112(s0)
    80200ab4:	0087a703          	lw	a4,8(a5)
    80200ab8:	f9043783          	ld	a5,-112(s0)
    80200abc:	00e7a623          	sw	a4,12(a5)
    }

    int written = 0;
    80200ac0:	fe042223          	sw	zero,-28(s0)

    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80200ac4:	f9043783          	ld	a5,-112(s0)
    80200ac8:	0087a703          	lw	a4,8(a5)
    80200acc:	fe842783          	lw	a5,-24(s0)
    80200ad0:	fcf42823          	sw	a5,-48(s0)
    80200ad4:	f9043783          	ld	a5,-112(s0)
    80200ad8:	00c7a783          	lw	a5,12(a5)
    80200adc:	fcf42623          	sw	a5,-52(s0)
    80200ae0:	fd042783          	lw	a5,-48(s0)
    80200ae4:	00078593          	mv	a1,a5
    80200ae8:	fcc42783          	lw	a5,-52(s0)
    80200aec:	00078613          	mv	a2,a5
    80200af0:	0006069b          	sext.w	a3,a2
    80200af4:	0005879b          	sext.w	a5,a1
    80200af8:	00f6d463          	bge	a3,a5,80200b00 <print_dec_int+0x1a8>
    80200afc:	00058613          	mv	a2,a1
    80200b00:	0006079b          	sext.w	a5,a2
    80200b04:	40f707bb          	subw	a5,a4,a5
    80200b08:	0007871b          	sext.w	a4,a5
    80200b0c:	fd744783          	lbu	a5,-41(s0)
    80200b10:	0007879b          	sext.w	a5,a5
    80200b14:	40f707bb          	subw	a5,a4,a5
    80200b18:	fef42023          	sw	a5,-32(s0)
    80200b1c:	0280006f          	j	80200b44 <print_dec_int+0x1ec>
        putch(' ');
    80200b20:	fa843783          	ld	a5,-88(s0)
    80200b24:	02000513          	li	a0,32
    80200b28:	000780e7          	jalr	a5
        ++written;
    80200b2c:	fe442783          	lw	a5,-28(s0)
    80200b30:	0017879b          	addiw	a5,a5,1
    80200b34:	fef42223          	sw	a5,-28(s0)
    for (int i = flags->width - __MAX(decdigits, flags->prec) - has_sign_char; i > 0; i--) {
    80200b38:	fe042783          	lw	a5,-32(s0)
    80200b3c:	fff7879b          	addiw	a5,a5,-1
    80200b40:	fef42023          	sw	a5,-32(s0)
    80200b44:	fe042783          	lw	a5,-32(s0)
    80200b48:	0007879b          	sext.w	a5,a5
    80200b4c:	fcf04ae3          	bgtz	a5,80200b20 <print_dec_int+0x1c8>
    }

    if (has_sign_char) {
    80200b50:	fd744783          	lbu	a5,-41(s0)
    80200b54:	0ff7f793          	zext.b	a5,a5
    80200b58:	04078463          	beqz	a5,80200ba0 <print_dec_int+0x248>
        putch(neg ? '-' : flags->sign ? '+' : ' ');
    80200b5c:	fef44783          	lbu	a5,-17(s0)
    80200b60:	0ff7f793          	zext.b	a5,a5
    80200b64:	00078663          	beqz	a5,80200b70 <print_dec_int+0x218>
    80200b68:	02d00793          	li	a5,45
    80200b6c:	01c0006f          	j	80200b88 <print_dec_int+0x230>
    80200b70:	f9043783          	ld	a5,-112(s0)
    80200b74:	0057c783          	lbu	a5,5(a5)
    80200b78:	00078663          	beqz	a5,80200b84 <print_dec_int+0x22c>
    80200b7c:	02b00793          	li	a5,43
    80200b80:	0080006f          	j	80200b88 <print_dec_int+0x230>
    80200b84:	02000793          	li	a5,32
    80200b88:	fa843703          	ld	a4,-88(s0)
    80200b8c:	00078513          	mv	a0,a5
    80200b90:	000700e7          	jalr	a4
        ++written;
    80200b94:	fe442783          	lw	a5,-28(s0)
    80200b98:	0017879b          	addiw	a5,a5,1
    80200b9c:	fef42223          	sw	a5,-28(s0)
    }

    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200ba0:	fe842783          	lw	a5,-24(s0)
    80200ba4:	fcf42e23          	sw	a5,-36(s0)
    80200ba8:	0280006f          	j	80200bd0 <print_dec_int+0x278>
        putch('0');
    80200bac:	fa843783          	ld	a5,-88(s0)
    80200bb0:	03000513          	li	a0,48
    80200bb4:	000780e7          	jalr	a5
        ++written;
    80200bb8:	fe442783          	lw	a5,-28(s0)
    80200bbc:	0017879b          	addiw	a5,a5,1
    80200bc0:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits; i < flags->prec - has_sign_char; i++) {
    80200bc4:	fdc42783          	lw	a5,-36(s0)
    80200bc8:	0017879b          	addiw	a5,a5,1
    80200bcc:	fcf42e23          	sw	a5,-36(s0)
    80200bd0:	f9043783          	ld	a5,-112(s0)
    80200bd4:	00c7a703          	lw	a4,12(a5)
    80200bd8:	fd744783          	lbu	a5,-41(s0)
    80200bdc:	0007879b          	sext.w	a5,a5
    80200be0:	40f707bb          	subw	a5,a4,a5
    80200be4:	0007871b          	sext.w	a4,a5
    80200be8:	fdc42783          	lw	a5,-36(s0)
    80200bec:	0007879b          	sext.w	a5,a5
    80200bf0:	fae7cee3          	blt	a5,a4,80200bac <print_dec_int+0x254>
    }

    for (int i = decdigits - 1; i >= 0; i--) {
    80200bf4:	fe842783          	lw	a5,-24(s0)
    80200bf8:	fff7879b          	addiw	a5,a5,-1
    80200bfc:	fcf42c23          	sw	a5,-40(s0)
    80200c00:	03c0006f          	j	80200c3c <print_dec_int+0x2e4>
        putch(buf[i]);
    80200c04:	fd842783          	lw	a5,-40(s0)
    80200c08:	ff078793          	addi	a5,a5,-16
    80200c0c:	008787b3          	add	a5,a5,s0
    80200c10:	fc87c783          	lbu	a5,-56(a5)
    80200c14:	0007871b          	sext.w	a4,a5
    80200c18:	fa843783          	ld	a5,-88(s0)
    80200c1c:	00070513          	mv	a0,a4
    80200c20:	000780e7          	jalr	a5
        ++written;
    80200c24:	fe442783          	lw	a5,-28(s0)
    80200c28:	0017879b          	addiw	a5,a5,1
    80200c2c:	fef42223          	sw	a5,-28(s0)
    for (int i = decdigits - 1; i >= 0; i--) {
    80200c30:	fd842783          	lw	a5,-40(s0)
    80200c34:	fff7879b          	addiw	a5,a5,-1
    80200c38:	fcf42c23          	sw	a5,-40(s0)
    80200c3c:	fd842783          	lw	a5,-40(s0)
    80200c40:	0007879b          	sext.w	a5,a5
    80200c44:	fc07d0e3          	bgez	a5,80200c04 <print_dec_int+0x2ac>
    }

    return written;
    80200c48:	fe442783          	lw	a5,-28(s0)
}
    80200c4c:	00078513          	mv	a0,a5
    80200c50:	06813083          	ld	ra,104(sp)
    80200c54:	06013403          	ld	s0,96(sp)
    80200c58:	07010113          	addi	sp,sp,112
    80200c5c:	00008067          	ret

0000000080200c60 <vprintfmt>:

int vprintfmt(int (*putch)(int), const char *fmt, va_list vl) {
    80200c60:	f4010113          	addi	sp,sp,-192
    80200c64:	0a113c23          	sd	ra,184(sp)
    80200c68:	0a813823          	sd	s0,176(sp)
    80200c6c:	0c010413          	addi	s0,sp,192
    80200c70:	f4a43c23          	sd	a0,-168(s0)
    80200c74:	f4b43823          	sd	a1,-176(s0)
    80200c78:	f4c43423          	sd	a2,-184(s0)
    static const char lowerxdigits[] = "0123456789abcdef";
    static const char upperxdigits[] = "0123456789ABCDEF";

    struct fmt_flags flags = {};
    80200c7c:	f8043023          	sd	zero,-128(s0)
    80200c80:	f8043423          	sd	zero,-120(s0)

    int written = 0;
    80200c84:	fe042623          	sw	zero,-20(s0)

    for (; *fmt; fmt++) {
    80200c88:	7a40006f          	j	8020142c <vprintfmt+0x7cc>
        if (flags.in_format) {
    80200c8c:	f8044783          	lbu	a5,-128(s0)
    80200c90:	72078e63          	beqz	a5,802013cc <vprintfmt+0x76c>
            if (*fmt == '#') {
    80200c94:	f5043783          	ld	a5,-176(s0)
    80200c98:	0007c783          	lbu	a5,0(a5)
    80200c9c:	00078713          	mv	a4,a5
    80200ca0:	02300793          	li	a5,35
    80200ca4:	00f71863          	bne	a4,a5,80200cb4 <vprintfmt+0x54>
                flags.sharpflag = true;
    80200ca8:	00100793          	li	a5,1
    80200cac:	f8f40123          	sb	a5,-126(s0)
    80200cb0:	7700006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == '0') {
    80200cb4:	f5043783          	ld	a5,-176(s0)
    80200cb8:	0007c783          	lbu	a5,0(a5)
    80200cbc:	00078713          	mv	a4,a5
    80200cc0:	03000793          	li	a5,48
    80200cc4:	00f71863          	bne	a4,a5,80200cd4 <vprintfmt+0x74>
                flags.zeroflag = true;
    80200cc8:	00100793          	li	a5,1
    80200ccc:	f8f401a3          	sb	a5,-125(s0)
    80200cd0:	7500006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == 'l' || *fmt == 'z' || *fmt == 't' || *fmt == 'j') {
    80200cd4:	f5043783          	ld	a5,-176(s0)
    80200cd8:	0007c783          	lbu	a5,0(a5)
    80200cdc:	00078713          	mv	a4,a5
    80200ce0:	06c00793          	li	a5,108
    80200ce4:	04f70063          	beq	a4,a5,80200d24 <vprintfmt+0xc4>
    80200ce8:	f5043783          	ld	a5,-176(s0)
    80200cec:	0007c783          	lbu	a5,0(a5)
    80200cf0:	00078713          	mv	a4,a5
    80200cf4:	07a00793          	li	a5,122
    80200cf8:	02f70663          	beq	a4,a5,80200d24 <vprintfmt+0xc4>
    80200cfc:	f5043783          	ld	a5,-176(s0)
    80200d00:	0007c783          	lbu	a5,0(a5)
    80200d04:	00078713          	mv	a4,a5
    80200d08:	07400793          	li	a5,116
    80200d0c:	00f70c63          	beq	a4,a5,80200d24 <vprintfmt+0xc4>
    80200d10:	f5043783          	ld	a5,-176(s0)
    80200d14:	0007c783          	lbu	a5,0(a5)
    80200d18:	00078713          	mv	a4,a5
    80200d1c:	06a00793          	li	a5,106
    80200d20:	00f71863          	bne	a4,a5,80200d30 <vprintfmt+0xd0>
                // l: long, z: size_t, t: ptrdiff_t, j: intmax_t
                flags.longflag = true;
    80200d24:	00100793          	li	a5,1
    80200d28:	f8f400a3          	sb	a5,-127(s0)
    80200d2c:	6f40006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == '+') {
    80200d30:	f5043783          	ld	a5,-176(s0)
    80200d34:	0007c783          	lbu	a5,0(a5)
    80200d38:	00078713          	mv	a4,a5
    80200d3c:	02b00793          	li	a5,43
    80200d40:	00f71863          	bne	a4,a5,80200d50 <vprintfmt+0xf0>
                flags.sign = true;
    80200d44:	00100793          	li	a5,1
    80200d48:	f8f402a3          	sb	a5,-123(s0)
    80200d4c:	6d40006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == ' ') {
    80200d50:	f5043783          	ld	a5,-176(s0)
    80200d54:	0007c783          	lbu	a5,0(a5)
    80200d58:	00078713          	mv	a4,a5
    80200d5c:	02000793          	li	a5,32
    80200d60:	00f71863          	bne	a4,a5,80200d70 <vprintfmt+0x110>
                flags.spaceflag = true;
    80200d64:	00100793          	li	a5,1
    80200d68:	f8f40223          	sb	a5,-124(s0)
    80200d6c:	6b40006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == '*') {
    80200d70:	f5043783          	ld	a5,-176(s0)
    80200d74:	0007c783          	lbu	a5,0(a5)
    80200d78:	00078713          	mv	a4,a5
    80200d7c:	02a00793          	li	a5,42
    80200d80:	00f71e63          	bne	a4,a5,80200d9c <vprintfmt+0x13c>
                flags.width = va_arg(vl, int);
    80200d84:	f4843783          	ld	a5,-184(s0)
    80200d88:	00878713          	addi	a4,a5,8
    80200d8c:	f4e43423          	sd	a4,-184(s0)
    80200d90:	0007a783          	lw	a5,0(a5)
    80200d94:	f8f42423          	sw	a5,-120(s0)
    80200d98:	6880006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt >= '1' && *fmt <= '9') {
    80200d9c:	f5043783          	ld	a5,-176(s0)
    80200da0:	0007c783          	lbu	a5,0(a5)
    80200da4:	00078713          	mv	a4,a5
    80200da8:	03000793          	li	a5,48
    80200dac:	04e7f663          	bgeu	a5,a4,80200df8 <vprintfmt+0x198>
    80200db0:	f5043783          	ld	a5,-176(s0)
    80200db4:	0007c783          	lbu	a5,0(a5)
    80200db8:	00078713          	mv	a4,a5
    80200dbc:	03900793          	li	a5,57
    80200dc0:	02e7ec63          	bltu	a5,a4,80200df8 <vprintfmt+0x198>
                flags.width = strtol(fmt, (char **)&fmt, 10);
    80200dc4:	f5043783          	ld	a5,-176(s0)
    80200dc8:	f5040713          	addi	a4,s0,-176
    80200dcc:	00a00613          	li	a2,10
    80200dd0:	00070593          	mv	a1,a4
    80200dd4:	00078513          	mv	a0,a5
    80200dd8:	88dff0ef          	jal	80200664 <strtol>
    80200ddc:	00050793          	mv	a5,a0
    80200de0:	0007879b          	sext.w	a5,a5
    80200de4:	f8f42423          	sw	a5,-120(s0)
                fmt--;
    80200de8:	f5043783          	ld	a5,-176(s0)
    80200dec:	fff78793          	addi	a5,a5,-1
    80200df0:	f4f43823          	sd	a5,-176(s0)
    80200df4:	62c0006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == '.') {
    80200df8:	f5043783          	ld	a5,-176(s0)
    80200dfc:	0007c783          	lbu	a5,0(a5)
    80200e00:	00078713          	mv	a4,a5
    80200e04:	02e00793          	li	a5,46
    80200e08:	06f71863          	bne	a4,a5,80200e78 <vprintfmt+0x218>
                fmt++;
    80200e0c:	f5043783          	ld	a5,-176(s0)
    80200e10:	00178793          	addi	a5,a5,1
    80200e14:	f4f43823          	sd	a5,-176(s0)
                if (*fmt == '*') {
    80200e18:	f5043783          	ld	a5,-176(s0)
    80200e1c:	0007c783          	lbu	a5,0(a5)
    80200e20:	00078713          	mv	a4,a5
    80200e24:	02a00793          	li	a5,42
    80200e28:	00f71e63          	bne	a4,a5,80200e44 <vprintfmt+0x1e4>
                    flags.prec = va_arg(vl, int);
    80200e2c:	f4843783          	ld	a5,-184(s0)
    80200e30:	00878713          	addi	a4,a5,8
    80200e34:	f4e43423          	sd	a4,-184(s0)
    80200e38:	0007a783          	lw	a5,0(a5)
    80200e3c:	f8f42623          	sw	a5,-116(s0)
    80200e40:	5e00006f          	j	80201420 <vprintfmt+0x7c0>
                } else {
                    flags.prec = strtol(fmt, (char **)&fmt, 10);
    80200e44:	f5043783          	ld	a5,-176(s0)
    80200e48:	f5040713          	addi	a4,s0,-176
    80200e4c:	00a00613          	li	a2,10
    80200e50:	00070593          	mv	a1,a4
    80200e54:	00078513          	mv	a0,a5
    80200e58:	80dff0ef          	jal	80200664 <strtol>
    80200e5c:	00050793          	mv	a5,a0
    80200e60:	0007879b          	sext.w	a5,a5
    80200e64:	f8f42623          	sw	a5,-116(s0)
                    fmt--;
    80200e68:	f5043783          	ld	a5,-176(s0)
    80200e6c:	fff78793          	addi	a5,a5,-1
    80200e70:	f4f43823          	sd	a5,-176(s0)
    80200e74:	5ac0006f          	j	80201420 <vprintfmt+0x7c0>
                }
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    80200e78:	f5043783          	ld	a5,-176(s0)
    80200e7c:	0007c783          	lbu	a5,0(a5)
    80200e80:	00078713          	mv	a4,a5
    80200e84:	07800793          	li	a5,120
    80200e88:	02f70663          	beq	a4,a5,80200eb4 <vprintfmt+0x254>
    80200e8c:	f5043783          	ld	a5,-176(s0)
    80200e90:	0007c783          	lbu	a5,0(a5)
    80200e94:	00078713          	mv	a4,a5
    80200e98:	05800793          	li	a5,88
    80200e9c:	00f70c63          	beq	a4,a5,80200eb4 <vprintfmt+0x254>
    80200ea0:	f5043783          	ld	a5,-176(s0)
    80200ea4:	0007c783          	lbu	a5,0(a5)
    80200ea8:	00078713          	mv	a4,a5
    80200eac:	07000793          	li	a5,112
    80200eb0:	30f71263          	bne	a4,a5,802011b4 <vprintfmt+0x554>
                bool is_long = *fmt == 'p' || flags.longflag;
    80200eb4:	f5043783          	ld	a5,-176(s0)
    80200eb8:	0007c783          	lbu	a5,0(a5)
    80200ebc:	00078713          	mv	a4,a5
    80200ec0:	07000793          	li	a5,112
    80200ec4:	00f70663          	beq	a4,a5,80200ed0 <vprintfmt+0x270>
    80200ec8:	f8144783          	lbu	a5,-127(s0)
    80200ecc:	00078663          	beqz	a5,80200ed8 <vprintfmt+0x278>
    80200ed0:	00100793          	li	a5,1
    80200ed4:	0080006f          	j	80200edc <vprintfmt+0x27c>
    80200ed8:	00000793          	li	a5,0
    80200edc:	faf403a3          	sb	a5,-89(s0)
    80200ee0:	fa744783          	lbu	a5,-89(s0)
    80200ee4:	0017f793          	andi	a5,a5,1
    80200ee8:	faf403a3          	sb	a5,-89(s0)

                unsigned long num = is_long ? va_arg(vl, unsigned long) : va_arg(vl, unsigned int);
    80200eec:	fa744783          	lbu	a5,-89(s0)
    80200ef0:	0ff7f793          	zext.b	a5,a5
    80200ef4:	00078c63          	beqz	a5,80200f0c <vprintfmt+0x2ac>
    80200ef8:	f4843783          	ld	a5,-184(s0)
    80200efc:	00878713          	addi	a4,a5,8
    80200f00:	f4e43423          	sd	a4,-184(s0)
    80200f04:	0007b783          	ld	a5,0(a5)
    80200f08:	01c0006f          	j	80200f24 <vprintfmt+0x2c4>
    80200f0c:	f4843783          	ld	a5,-184(s0)
    80200f10:	00878713          	addi	a4,a5,8
    80200f14:	f4e43423          	sd	a4,-184(s0)
    80200f18:	0007a783          	lw	a5,0(a5)
    80200f1c:	02079793          	slli	a5,a5,0x20
    80200f20:	0207d793          	srli	a5,a5,0x20
    80200f24:	fef43023          	sd	a5,-32(s0)

                if (flags.prec == 0 && num == 0 && *fmt != 'p') {
    80200f28:	f8c42783          	lw	a5,-116(s0)
    80200f2c:	02079463          	bnez	a5,80200f54 <vprintfmt+0x2f4>
    80200f30:	fe043783          	ld	a5,-32(s0)
    80200f34:	02079063          	bnez	a5,80200f54 <vprintfmt+0x2f4>
    80200f38:	f5043783          	ld	a5,-176(s0)
    80200f3c:	0007c783          	lbu	a5,0(a5)
    80200f40:	00078713          	mv	a4,a5
    80200f44:	07000793          	li	a5,112
    80200f48:	00f70663          	beq	a4,a5,80200f54 <vprintfmt+0x2f4>
                    flags.in_format = false;
    80200f4c:	f8040023          	sb	zero,-128(s0)
    80200f50:	4d00006f          	j	80201420 <vprintfmt+0x7c0>
                    continue;
                }

                // 0x prefix for pointers, or, if # flag is set and non-zero
                bool prefix = *fmt == 'p' || (flags.sharpflag && num != 0);
    80200f54:	f5043783          	ld	a5,-176(s0)
    80200f58:	0007c783          	lbu	a5,0(a5)
    80200f5c:	00078713          	mv	a4,a5
    80200f60:	07000793          	li	a5,112
    80200f64:	00f70a63          	beq	a4,a5,80200f78 <vprintfmt+0x318>
    80200f68:	f8244783          	lbu	a5,-126(s0)
    80200f6c:	00078a63          	beqz	a5,80200f80 <vprintfmt+0x320>
    80200f70:	fe043783          	ld	a5,-32(s0)
    80200f74:	00078663          	beqz	a5,80200f80 <vprintfmt+0x320>
    80200f78:	00100793          	li	a5,1
    80200f7c:	0080006f          	j	80200f84 <vprintfmt+0x324>
    80200f80:	00000793          	li	a5,0
    80200f84:	faf40323          	sb	a5,-90(s0)
    80200f88:	fa644783          	lbu	a5,-90(s0)
    80200f8c:	0017f793          	andi	a5,a5,1
    80200f90:	faf40323          	sb	a5,-90(s0)

                int hexdigits = 0;
    80200f94:	fc042e23          	sw	zero,-36(s0)
                const char *xdigits = *fmt == 'X' ? upperxdigits : lowerxdigits;
    80200f98:	f5043783          	ld	a5,-176(s0)
    80200f9c:	0007c783          	lbu	a5,0(a5)
    80200fa0:	00078713          	mv	a4,a5
    80200fa4:	05800793          	li	a5,88
    80200fa8:	00f71863          	bne	a4,a5,80200fb8 <vprintfmt+0x358>
    80200fac:	00001797          	auipc	a5,0x1
    80200fb0:	11c78793          	addi	a5,a5,284 # 802020c8 <upperxdigits.1>
    80200fb4:	00c0006f          	j	80200fc0 <vprintfmt+0x360>
    80200fb8:	00001797          	auipc	a5,0x1
    80200fbc:	12878793          	addi	a5,a5,296 # 802020e0 <lowerxdigits.0>
    80200fc0:	f8f43c23          	sd	a5,-104(s0)
                char buf[2 * sizeof(unsigned long)];

                do {
                    buf[hexdigits++] = xdigits[num & 0xf];
    80200fc4:	fe043783          	ld	a5,-32(s0)
    80200fc8:	00f7f793          	andi	a5,a5,15
    80200fcc:	f9843703          	ld	a4,-104(s0)
    80200fd0:	00f70733          	add	a4,a4,a5
    80200fd4:	fdc42783          	lw	a5,-36(s0)
    80200fd8:	0017869b          	addiw	a3,a5,1
    80200fdc:	fcd42e23          	sw	a3,-36(s0)
    80200fe0:	00074703          	lbu	a4,0(a4)
    80200fe4:	ff078793          	addi	a5,a5,-16
    80200fe8:	008787b3          	add	a5,a5,s0
    80200fec:	f8e78023          	sb	a4,-128(a5)
                    num >>= 4;
    80200ff0:	fe043783          	ld	a5,-32(s0)
    80200ff4:	0047d793          	srli	a5,a5,0x4
    80200ff8:	fef43023          	sd	a5,-32(s0)
                } while (num);
    80200ffc:	fe043783          	ld	a5,-32(s0)
    80201000:	fc0792e3          	bnez	a5,80200fc4 <vprintfmt+0x364>

                if (flags.prec == -1 && flags.zeroflag) {
    80201004:	f8c42783          	lw	a5,-116(s0)
    80201008:	00078713          	mv	a4,a5
    8020100c:	fff00793          	li	a5,-1
    80201010:	02f71663          	bne	a4,a5,8020103c <vprintfmt+0x3dc>
    80201014:	f8344783          	lbu	a5,-125(s0)
    80201018:	02078263          	beqz	a5,8020103c <vprintfmt+0x3dc>
                    flags.prec = flags.width - 2 * prefix;
    8020101c:	f8842703          	lw	a4,-120(s0)
    80201020:	fa644783          	lbu	a5,-90(s0)
    80201024:	0007879b          	sext.w	a5,a5
    80201028:	0017979b          	slliw	a5,a5,0x1
    8020102c:	0007879b          	sext.w	a5,a5
    80201030:	40f707bb          	subw	a5,a4,a5
    80201034:	0007879b          	sext.w	a5,a5
    80201038:	f8f42623          	sw	a5,-116(s0)
                }

                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    8020103c:	f8842703          	lw	a4,-120(s0)
    80201040:	fa644783          	lbu	a5,-90(s0)
    80201044:	0007879b          	sext.w	a5,a5
    80201048:	0017979b          	slliw	a5,a5,0x1
    8020104c:	0007879b          	sext.w	a5,a5
    80201050:	40f707bb          	subw	a5,a4,a5
    80201054:	0007871b          	sext.w	a4,a5
    80201058:	fdc42783          	lw	a5,-36(s0)
    8020105c:	f8f42a23          	sw	a5,-108(s0)
    80201060:	f8c42783          	lw	a5,-116(s0)
    80201064:	f8f42823          	sw	a5,-112(s0)
    80201068:	f9442783          	lw	a5,-108(s0)
    8020106c:	00078593          	mv	a1,a5
    80201070:	f9042783          	lw	a5,-112(s0)
    80201074:	00078613          	mv	a2,a5
    80201078:	0006069b          	sext.w	a3,a2
    8020107c:	0005879b          	sext.w	a5,a1
    80201080:	00f6d463          	bge	a3,a5,80201088 <vprintfmt+0x428>
    80201084:	00058613          	mv	a2,a1
    80201088:	0006079b          	sext.w	a5,a2
    8020108c:	40f707bb          	subw	a5,a4,a5
    80201090:	fcf42c23          	sw	a5,-40(s0)
    80201094:	0280006f          	j	802010bc <vprintfmt+0x45c>
                    putch(' ');
    80201098:	f5843783          	ld	a5,-168(s0)
    8020109c:	02000513          	li	a0,32
    802010a0:	000780e7          	jalr	a5
                    ++written;
    802010a4:	fec42783          	lw	a5,-20(s0)
    802010a8:	0017879b          	addiw	a5,a5,1
    802010ac:	fef42623          	sw	a5,-20(s0)
                for (int i = flags.width - 2 * prefix - __MAX(hexdigits, flags.prec); i > 0; i--) {
    802010b0:	fd842783          	lw	a5,-40(s0)
    802010b4:	fff7879b          	addiw	a5,a5,-1
    802010b8:	fcf42c23          	sw	a5,-40(s0)
    802010bc:	fd842783          	lw	a5,-40(s0)
    802010c0:	0007879b          	sext.w	a5,a5
    802010c4:	fcf04ae3          	bgtz	a5,80201098 <vprintfmt+0x438>
                }

                if (prefix) {
    802010c8:	fa644783          	lbu	a5,-90(s0)
    802010cc:	0ff7f793          	zext.b	a5,a5
    802010d0:	04078463          	beqz	a5,80201118 <vprintfmt+0x4b8>
                    putch('0');
    802010d4:	f5843783          	ld	a5,-168(s0)
    802010d8:	03000513          	li	a0,48
    802010dc:	000780e7          	jalr	a5
                    putch(*fmt == 'X' ? 'X' : 'x');
    802010e0:	f5043783          	ld	a5,-176(s0)
    802010e4:	0007c783          	lbu	a5,0(a5)
    802010e8:	00078713          	mv	a4,a5
    802010ec:	05800793          	li	a5,88
    802010f0:	00f71663          	bne	a4,a5,802010fc <vprintfmt+0x49c>
    802010f4:	05800793          	li	a5,88
    802010f8:	0080006f          	j	80201100 <vprintfmt+0x4a0>
    802010fc:	07800793          	li	a5,120
    80201100:	f5843703          	ld	a4,-168(s0)
    80201104:	00078513          	mv	a0,a5
    80201108:	000700e7          	jalr	a4
                    written += 2;
    8020110c:	fec42783          	lw	a5,-20(s0)
    80201110:	0027879b          	addiw	a5,a5,2
    80201114:	fef42623          	sw	a5,-20(s0)
                }

                for (int i = hexdigits; i < flags.prec; i++) {
    80201118:	fdc42783          	lw	a5,-36(s0)
    8020111c:	fcf42a23          	sw	a5,-44(s0)
    80201120:	0280006f          	j	80201148 <vprintfmt+0x4e8>
                    putch('0');
    80201124:	f5843783          	ld	a5,-168(s0)
    80201128:	03000513          	li	a0,48
    8020112c:	000780e7          	jalr	a5
                    ++written;
    80201130:	fec42783          	lw	a5,-20(s0)
    80201134:	0017879b          	addiw	a5,a5,1
    80201138:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits; i < flags.prec; i++) {
    8020113c:	fd442783          	lw	a5,-44(s0)
    80201140:	0017879b          	addiw	a5,a5,1
    80201144:	fcf42a23          	sw	a5,-44(s0)
    80201148:	f8c42703          	lw	a4,-116(s0)
    8020114c:	fd442783          	lw	a5,-44(s0)
    80201150:	0007879b          	sext.w	a5,a5
    80201154:	fce7c8e3          	blt	a5,a4,80201124 <vprintfmt+0x4c4>
                }

                for (int i = hexdigits - 1; i >= 0; i--) {
    80201158:	fdc42783          	lw	a5,-36(s0)
    8020115c:	fff7879b          	addiw	a5,a5,-1
    80201160:	fcf42823          	sw	a5,-48(s0)
    80201164:	03c0006f          	j	802011a0 <vprintfmt+0x540>
                    putch(buf[i]);
    80201168:	fd042783          	lw	a5,-48(s0)
    8020116c:	ff078793          	addi	a5,a5,-16
    80201170:	008787b3          	add	a5,a5,s0
    80201174:	f807c783          	lbu	a5,-128(a5)
    80201178:	0007871b          	sext.w	a4,a5
    8020117c:	f5843783          	ld	a5,-168(s0)
    80201180:	00070513          	mv	a0,a4
    80201184:	000780e7          	jalr	a5
                    ++written;
    80201188:	fec42783          	lw	a5,-20(s0)
    8020118c:	0017879b          	addiw	a5,a5,1
    80201190:	fef42623          	sw	a5,-20(s0)
                for (int i = hexdigits - 1; i >= 0; i--) {
    80201194:	fd042783          	lw	a5,-48(s0)
    80201198:	fff7879b          	addiw	a5,a5,-1
    8020119c:	fcf42823          	sw	a5,-48(s0)
    802011a0:	fd042783          	lw	a5,-48(s0)
    802011a4:	0007879b          	sext.w	a5,a5
    802011a8:	fc07d0e3          	bgez	a5,80201168 <vprintfmt+0x508>
                }

                flags.in_format = false;
    802011ac:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'x' || *fmt == 'X' || *fmt == 'p') {
    802011b0:	2700006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    802011b4:	f5043783          	ld	a5,-176(s0)
    802011b8:	0007c783          	lbu	a5,0(a5)
    802011bc:	00078713          	mv	a4,a5
    802011c0:	06400793          	li	a5,100
    802011c4:	02f70663          	beq	a4,a5,802011f0 <vprintfmt+0x590>
    802011c8:	f5043783          	ld	a5,-176(s0)
    802011cc:	0007c783          	lbu	a5,0(a5)
    802011d0:	00078713          	mv	a4,a5
    802011d4:	06900793          	li	a5,105
    802011d8:	00f70c63          	beq	a4,a5,802011f0 <vprintfmt+0x590>
    802011dc:	f5043783          	ld	a5,-176(s0)
    802011e0:	0007c783          	lbu	a5,0(a5)
    802011e4:	00078713          	mv	a4,a5
    802011e8:	07500793          	li	a5,117
    802011ec:	08f71063          	bne	a4,a5,8020126c <vprintfmt+0x60c>
                long num = flags.longflag ? va_arg(vl, long) : va_arg(vl, int);
    802011f0:	f8144783          	lbu	a5,-127(s0)
    802011f4:	00078c63          	beqz	a5,8020120c <vprintfmt+0x5ac>
    802011f8:	f4843783          	ld	a5,-184(s0)
    802011fc:	00878713          	addi	a4,a5,8
    80201200:	f4e43423          	sd	a4,-184(s0)
    80201204:	0007b783          	ld	a5,0(a5)
    80201208:	0140006f          	j	8020121c <vprintfmt+0x5bc>
    8020120c:	f4843783          	ld	a5,-184(s0)
    80201210:	00878713          	addi	a4,a5,8
    80201214:	f4e43423          	sd	a4,-184(s0)
    80201218:	0007a783          	lw	a5,0(a5)
    8020121c:	faf43423          	sd	a5,-88(s0)

                written += print_dec_int(putch, num, *fmt != 'u', &flags);
    80201220:	fa843583          	ld	a1,-88(s0)
    80201224:	f5043783          	ld	a5,-176(s0)
    80201228:	0007c783          	lbu	a5,0(a5)
    8020122c:	0007871b          	sext.w	a4,a5
    80201230:	07500793          	li	a5,117
    80201234:	40f707b3          	sub	a5,a4,a5
    80201238:	00f037b3          	snez	a5,a5
    8020123c:	0ff7f793          	zext.b	a5,a5
    80201240:	f8040713          	addi	a4,s0,-128
    80201244:	00070693          	mv	a3,a4
    80201248:	00078613          	mv	a2,a5
    8020124c:	f5843503          	ld	a0,-168(s0)
    80201250:	f08ff0ef          	jal	80200958 <print_dec_int>
    80201254:	00050793          	mv	a5,a0
    80201258:	fec42703          	lw	a4,-20(s0)
    8020125c:	00f707bb          	addw	a5,a4,a5
    80201260:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201264:	f8040023          	sb	zero,-128(s0)
            } else if (*fmt == 'd' || *fmt == 'i' || *fmt == 'u') {
    80201268:	1b80006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == 'n') {
    8020126c:	f5043783          	ld	a5,-176(s0)
    80201270:	0007c783          	lbu	a5,0(a5)
    80201274:	00078713          	mv	a4,a5
    80201278:	06e00793          	li	a5,110
    8020127c:	04f71c63          	bne	a4,a5,802012d4 <vprintfmt+0x674>
                if (flags.longflag) {
    80201280:	f8144783          	lbu	a5,-127(s0)
    80201284:	02078463          	beqz	a5,802012ac <vprintfmt+0x64c>
                    long *n = va_arg(vl, long *);
    80201288:	f4843783          	ld	a5,-184(s0)
    8020128c:	00878713          	addi	a4,a5,8
    80201290:	f4e43423          	sd	a4,-184(s0)
    80201294:	0007b783          	ld	a5,0(a5)
    80201298:	faf43823          	sd	a5,-80(s0)
                    *n = written;
    8020129c:	fec42703          	lw	a4,-20(s0)
    802012a0:	fb043783          	ld	a5,-80(s0)
    802012a4:	00e7b023          	sd	a4,0(a5)
    802012a8:	0240006f          	j	802012cc <vprintfmt+0x66c>
                } else {
                    int *n = va_arg(vl, int *);
    802012ac:	f4843783          	ld	a5,-184(s0)
    802012b0:	00878713          	addi	a4,a5,8
    802012b4:	f4e43423          	sd	a4,-184(s0)
    802012b8:	0007b783          	ld	a5,0(a5)
    802012bc:	faf43c23          	sd	a5,-72(s0)
                    *n = written;
    802012c0:	fb843783          	ld	a5,-72(s0)
    802012c4:	fec42703          	lw	a4,-20(s0)
    802012c8:	00e7a023          	sw	a4,0(a5)
                }
                flags.in_format = false;
    802012cc:	f8040023          	sb	zero,-128(s0)
    802012d0:	1500006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == 's') {
    802012d4:	f5043783          	ld	a5,-176(s0)
    802012d8:	0007c783          	lbu	a5,0(a5)
    802012dc:	00078713          	mv	a4,a5
    802012e0:	07300793          	li	a5,115
    802012e4:	02f71e63          	bne	a4,a5,80201320 <vprintfmt+0x6c0>
                const char *s = va_arg(vl, const char *);
    802012e8:	f4843783          	ld	a5,-184(s0)
    802012ec:	00878713          	addi	a4,a5,8
    802012f0:	f4e43423          	sd	a4,-184(s0)
    802012f4:	0007b783          	ld	a5,0(a5)
    802012f8:	fcf43023          	sd	a5,-64(s0)
                written += puts_wo_nl(putch, s);
    802012fc:	fc043583          	ld	a1,-64(s0)
    80201300:	f5843503          	ld	a0,-168(s0)
    80201304:	dccff0ef          	jal	802008d0 <puts_wo_nl>
    80201308:	00050793          	mv	a5,a0
    8020130c:	fec42703          	lw	a4,-20(s0)
    80201310:	00f707bb          	addw	a5,a4,a5
    80201314:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201318:	f8040023          	sb	zero,-128(s0)
    8020131c:	1040006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == 'c') {
    80201320:	f5043783          	ld	a5,-176(s0)
    80201324:	0007c783          	lbu	a5,0(a5)
    80201328:	00078713          	mv	a4,a5
    8020132c:	06300793          	li	a5,99
    80201330:	02f71e63          	bne	a4,a5,8020136c <vprintfmt+0x70c>
                int ch = va_arg(vl, int);
    80201334:	f4843783          	ld	a5,-184(s0)
    80201338:	00878713          	addi	a4,a5,8
    8020133c:	f4e43423          	sd	a4,-184(s0)
    80201340:	0007a783          	lw	a5,0(a5)
    80201344:	fcf42623          	sw	a5,-52(s0)
                putch(ch);
    80201348:	fcc42703          	lw	a4,-52(s0)
    8020134c:	f5843783          	ld	a5,-168(s0)
    80201350:	00070513          	mv	a0,a4
    80201354:	000780e7          	jalr	a5
                ++written;
    80201358:	fec42783          	lw	a5,-20(s0)
    8020135c:	0017879b          	addiw	a5,a5,1
    80201360:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201364:	f8040023          	sb	zero,-128(s0)
    80201368:	0b80006f          	j	80201420 <vprintfmt+0x7c0>
            } else if (*fmt == '%') {
    8020136c:	f5043783          	ld	a5,-176(s0)
    80201370:	0007c783          	lbu	a5,0(a5)
    80201374:	00078713          	mv	a4,a5
    80201378:	02500793          	li	a5,37
    8020137c:	02f71263          	bne	a4,a5,802013a0 <vprintfmt+0x740>
                putch('%');
    80201380:	f5843783          	ld	a5,-168(s0)
    80201384:	02500513          	li	a0,37
    80201388:	000780e7          	jalr	a5
                ++written;
    8020138c:	fec42783          	lw	a5,-20(s0)
    80201390:	0017879b          	addiw	a5,a5,1
    80201394:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    80201398:	f8040023          	sb	zero,-128(s0)
    8020139c:	0840006f          	j	80201420 <vprintfmt+0x7c0>
            } else {
                putch(*fmt);
    802013a0:	f5043783          	ld	a5,-176(s0)
    802013a4:	0007c783          	lbu	a5,0(a5)
    802013a8:	0007871b          	sext.w	a4,a5
    802013ac:	f5843783          	ld	a5,-168(s0)
    802013b0:	00070513          	mv	a0,a4
    802013b4:	000780e7          	jalr	a5
                ++written;
    802013b8:	fec42783          	lw	a5,-20(s0)
    802013bc:	0017879b          	addiw	a5,a5,1
    802013c0:	fef42623          	sw	a5,-20(s0)
                flags.in_format = false;
    802013c4:	f8040023          	sb	zero,-128(s0)
    802013c8:	0580006f          	j	80201420 <vprintfmt+0x7c0>
            }
        } else if (*fmt == '%') {
    802013cc:	f5043783          	ld	a5,-176(s0)
    802013d0:	0007c783          	lbu	a5,0(a5)
    802013d4:	00078713          	mv	a4,a5
    802013d8:	02500793          	li	a5,37
    802013dc:	02f71063          	bne	a4,a5,802013fc <vprintfmt+0x79c>
            flags = (struct fmt_flags) {.in_format = true, .prec = -1};
    802013e0:	f8043023          	sd	zero,-128(s0)
    802013e4:	f8043423          	sd	zero,-120(s0)
    802013e8:	00100793          	li	a5,1
    802013ec:	f8f40023          	sb	a5,-128(s0)
    802013f0:	fff00793          	li	a5,-1
    802013f4:	f8f42623          	sw	a5,-116(s0)
    802013f8:	0280006f          	j	80201420 <vprintfmt+0x7c0>
        } else {
            putch(*fmt);
    802013fc:	f5043783          	ld	a5,-176(s0)
    80201400:	0007c783          	lbu	a5,0(a5)
    80201404:	0007871b          	sext.w	a4,a5
    80201408:	f5843783          	ld	a5,-168(s0)
    8020140c:	00070513          	mv	a0,a4
    80201410:	000780e7          	jalr	a5
            ++written;
    80201414:	fec42783          	lw	a5,-20(s0)
    80201418:	0017879b          	addiw	a5,a5,1
    8020141c:	fef42623          	sw	a5,-20(s0)
    for (; *fmt; fmt++) {
    80201420:	f5043783          	ld	a5,-176(s0)
    80201424:	00178793          	addi	a5,a5,1
    80201428:	f4f43823          	sd	a5,-176(s0)
    8020142c:	f5043783          	ld	a5,-176(s0)
    80201430:	0007c783          	lbu	a5,0(a5)
    80201434:	84079ce3          	bnez	a5,80200c8c <vprintfmt+0x2c>
        }
    }

    return written;
    80201438:	fec42783          	lw	a5,-20(s0)
}
    8020143c:	00078513          	mv	a0,a5
    80201440:	0b813083          	ld	ra,184(sp)
    80201444:	0b013403          	ld	s0,176(sp)
    80201448:	0c010113          	addi	sp,sp,192
    8020144c:	00008067          	ret

0000000080201450 <printk>:

int printk(const char* s, ...) {
    80201450:	f9010113          	addi	sp,sp,-112
    80201454:	02113423          	sd	ra,40(sp)
    80201458:	02813023          	sd	s0,32(sp)
    8020145c:	03010413          	addi	s0,sp,48
    80201460:	fca43c23          	sd	a0,-40(s0)
    80201464:	00b43423          	sd	a1,8(s0)
    80201468:	00c43823          	sd	a2,16(s0)
    8020146c:	00d43c23          	sd	a3,24(s0)
    80201470:	02e43023          	sd	a4,32(s0)
    80201474:	02f43423          	sd	a5,40(s0)
    80201478:	03043823          	sd	a6,48(s0)
    8020147c:	03143c23          	sd	a7,56(s0)
    int res = 0;
    80201480:	fe042623          	sw	zero,-20(s0)
    va_list vl;
    va_start(vl, s);
    80201484:	04040793          	addi	a5,s0,64
    80201488:	fcf43823          	sd	a5,-48(s0)
    8020148c:	fd043783          	ld	a5,-48(s0)
    80201490:	fc878793          	addi	a5,a5,-56
    80201494:	fef43023          	sd	a5,-32(s0)
    res = vprintfmt(putc, s, vl);
    80201498:	fe043783          	ld	a5,-32(s0)
    8020149c:	00078613          	mv	a2,a5
    802014a0:	fd843583          	ld	a1,-40(s0)
    802014a4:	fffff517          	auipc	a0,0xfffff
    802014a8:	11850513          	addi	a0,a0,280 # 802005bc <putc>
    802014ac:	fb4ff0ef          	jal	80200c60 <vprintfmt>
    802014b0:	00050793          	mv	a5,a0
    802014b4:	fef42623          	sw	a5,-20(s0)
    va_end(vl);
    return res;
    802014b8:	fec42783          	lw	a5,-20(s0)
}
    802014bc:	00078513          	mv	a0,a5
    802014c0:	02813083          	ld	ra,40(sp)
    802014c4:	02013403          	ld	s0,32(sp)
    802014c8:	07010113          	addi	sp,sp,112
    802014cc:	00008067          	ret

00000000802014d0 <printk_binary_64>:
#include "printk.h"
#include "stdint.h"

void printk_binary_64(uint64_t value) {
    802014d0:	f9010113          	addi	sp,sp,-112
    802014d4:	06113423          	sd	ra,104(sp)
    802014d8:	06813023          	sd	s0,96(sp)
    802014dc:	07010413          	addi	s0,sp,112
    802014e0:	f8a43c23          	sd	a0,-104(s0)
    char binary[65];
    for (int i = 0; i < 64; i++) {
    802014e4:	fe042623          	sw	zero,-20(s0)
    802014e8:	0540006f          	j	8020153c <printk_binary_64+0x6c>
        binary[63 - i] = (value & (1UL << i)) ? '1' : '0';
    802014ec:	fec42783          	lw	a5,-20(s0)
    802014f0:	00078713          	mv	a4,a5
    802014f4:	00100793          	li	a5,1
    802014f8:	00e79733          	sll	a4,a5,a4
    802014fc:	f9843783          	ld	a5,-104(s0)
    80201500:	00f777b3          	and	a5,a4,a5
    80201504:	00078663          	beqz	a5,80201510 <printk_binary_64+0x40>
    80201508:	03100793          	li	a5,49
    8020150c:	0080006f          	j	80201514 <printk_binary_64+0x44>
    80201510:	03000793          	li	a5,48
    80201514:	03f00713          	li	a4,63
    80201518:	fec42683          	lw	a3,-20(s0)
    8020151c:	40d7073b          	subw	a4,a4,a3
    80201520:	0007071b          	sext.w	a4,a4
    80201524:	ff070713          	addi	a4,a4,-16
    80201528:	00870733          	add	a4,a4,s0
    8020152c:	faf70c23          	sb	a5,-72(a4)
    for (int i = 0; i < 64; i++) {
    80201530:	fec42783          	lw	a5,-20(s0)
    80201534:	0017879b          	addiw	a5,a5,1
    80201538:	fef42623          	sw	a5,-20(s0)
    8020153c:	fec42783          	lw	a5,-20(s0)
    80201540:	0007871b          	sext.w	a4,a5
    80201544:	03f00793          	li	a5,63
    80201548:	fae7d2e3          	bge	a5,a4,802014ec <printk_binary_64+0x1c>
    }
    binary[64] = '\0';
    8020154c:	fe040423          	sb	zero,-24(s0)
    printk("%s\n", binary);
    80201550:	fa840793          	addi	a5,s0,-88
    80201554:	00078593          	mv	a1,a5
    80201558:	00001517          	auipc	a0,0x1
    8020155c:	ba050513          	addi	a0,a0,-1120 # 802020f8 <lowerxdigits.0+0x18>
    80201560:	ef1ff0ef          	jal	80201450 <printk>
}
    80201564:	00000013          	nop
    80201568:	06813083          	ld	ra,104(sp)
    8020156c:	06013403          	ld	s0,96(sp)
    80201570:	07010113          	addi	sp,sp,112
    80201574:	00008067          	ret

0000000080201578 <printk_binary_64_1s_pos>:

void printk_binary_64_1s_pos(uint64_t value) {
    80201578:	fd010113          	addi	sp,sp,-48
    8020157c:	02113423          	sd	ra,40(sp)
    80201580:	02813023          	sd	s0,32(sp)
    80201584:	03010413          	addi	s0,sp,48
    80201588:	fca43c23          	sd	a0,-40(s0)
    printk("Positions: ");
    8020158c:	00001517          	auipc	a0,0x1
    80201590:	b7450513          	addi	a0,a0,-1164 # 80202100 <lowerxdigits.0+0x20>
    80201594:	ebdff0ef          	jal	80201450 <printk>
    for (int i = 0; i < 64; i++) {
    80201598:	fe042623          	sw	zero,-20(s0)
    8020159c:	0400006f          	j	802015dc <printk_binary_64_1s_pos+0x64>
        if (value & (1UL << i)) {
    802015a0:	fec42783          	lw	a5,-20(s0)
    802015a4:	00078713          	mv	a4,a5
    802015a8:	00100793          	li	a5,1
    802015ac:	00e79733          	sll	a4,a5,a4
    802015b0:	fd843783          	ld	a5,-40(s0)
    802015b4:	00f777b3          	and	a5,a4,a5
    802015b8:	00078c63          	beqz	a5,802015d0 <printk_binary_64_1s_pos+0x58>
            printk("%d ", i);
    802015bc:	fec42783          	lw	a5,-20(s0)
    802015c0:	00078593          	mv	a1,a5
    802015c4:	00001517          	auipc	a0,0x1
    802015c8:	b4c50513          	addi	a0,a0,-1204 # 80202110 <lowerxdigits.0+0x30>
    802015cc:	e85ff0ef          	jal	80201450 <printk>
    for (int i = 0; i < 64; i++) {
    802015d0:	fec42783          	lw	a5,-20(s0)
    802015d4:	0017879b          	addiw	a5,a5,1
    802015d8:	fef42623          	sw	a5,-20(s0)
    802015dc:	fec42783          	lw	a5,-20(s0)
    802015e0:	0007871b          	sext.w	a4,a5
    802015e4:	03f00793          	li	a5,63
    802015e8:	fae7dce3          	bge	a5,a4,802015a0 <printk_binary_64_1s_pos+0x28>
        }
    }
    printk("\n");
    802015ec:	00001517          	auipc	a0,0x1
    802015f0:	b2c50513          	addi	a0,a0,-1236 # 80202118 <lowerxdigits.0+0x38>
    802015f4:	e5dff0ef          	jal	80201450 <printk>
    802015f8:	00000013          	nop
    802015fc:	02813083          	ld	ra,40(sp)
    80201600:	02013403          	ld	s0,32(sp)
    80201604:	03010113          	addi	sp,sp,48
    80201608:	00008067          	ret

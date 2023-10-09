/*
 * interrupts.S
 *
 *  Created on: 19. sep. 2023
 *      Author: tomaz
 */
.section .text

.option norvc       # disables the generation of compressed instructions.

.balign 64
.global vector_table
.type vector_table, @function

vector_table:
    j default_handler
    j default_handler
    j default_handler
    j swi_handler
    j default_handler
    j default_handler
    j default_handler
    j mtime_int_handler     // bp
    j default_handler
    j default_handler
    j default_handler
    j exti_handler
    j default_handler

.balign 4
.weak default_handler
.global default_handler //
.type default_handler, @function

default_handler:
    mret


.balign 4
.weak swi_handler
.global swi_handler //
.type swi_handler, @function

swi_handler:
    mret


.balign 4
.weak exti_handler
.global exti_handler //
.type exti_handler, @function

exti_handler:
    mret


.balign 4
.weak mtime_int_handler
.global mtime_int_handler //
.type mtime_int_handler, @function

mtime_int_handler:
    # Decode interrupt cause:
    csrr t0, mcause                 # read exception cause
    bgez t0, 1f                     # exit if not an interrupt

    # Increment timer compare by MS100 cycles
    li t0, 0x0200BFF8             # load the mtime address
    lw t1, 0(t0)                    # load mtime (LO)
    lw t2, 4(t0)                    # load mtime (HI)
    li t3, 16384
    add t3, t1, t3                  # increment lower bits by DELAY cycles
    sltu t1, t3, t1                 # generate carry-out
    add t2, t2, t1                  # add carry to upper bits

    li t0, 0x02004000
    sw t3, 0(t0)                    # update mtimecmp (LO)
    sw t2, 4(t0)                    # update mtimecmp (HI)

    addi a0, zero, 22
    jal gpio_toggle_pin


1:
    mret



.balign 4
.global enable_global_interrupts
.type enable_global_interrupts, @function
enable_global_interrupts:
    # prologue (save three saved registers and the return address)
    addi sp, sp, -16                # Allocate the routine stack frame
    sw ra, 12(sp)                   # Save the return address
    sw fp, 8(sp)                    # Save the frame pointer
    sw s1, 4(sp)
    sw s2, 0(sp)
    addi fp, sp, 16                 # Set the framepointer

    li t0, 0x00000008       # load the mask for MIE
    csrs mstatus, t0                #  set the MIE bit in mstatus

    # epilogue (restore three saved registers and the return address):
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw fp, 8(sp)                    # restore the frame pointer
    lw ra, 12(sp)                   # restore the return address from the stack frame
    addi sp, sp, 16                 # de-allocate the routine stack frame
    ret


.balign 4
.global enable_timer_interrupts
.type enable_timer_interrupts, @function
enable_timer_interrupts:
    # prologue (save three saved registers and the return address)
    addi sp, sp, -16                # Allocate the routine stack frame
    sw ra, 12(sp)                   # Save the return address
    sw fp, 8(sp)                    # Save the frame pointer
    sw s1, 4(sp)
    sw s2, 0(sp)
    addi fp, sp, 16                 # Set the framepointer

    li t0, 0x00000080               # ste MTIE bit in mie
    csrs mie, t0                    #

    # epilogue (restore three saved registers and the return address):
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw fp, 8(sp)                    # restore the frame pointer
    lw ra, 12(sp)                   # restore the return address from the stack frame
    addi sp, sp, 16                 # de-allocate the routine stack frame
    ret



.balign 4
.global register_handler
.type register_handler, @function
register_handler:
    # prologue (save three saved registers and the return address)
    addi sp, sp, -16                # Allocate the routine stack frame
    sw ra, 12(sp)                   # Save the return address
    sw fp, 8(sp)                    # Save the frame pointer
    sw s1, 4(sp)
    sw s2, 0(sp)
    addi fp, sp, 16                 # Set the framepointer

    or a0, a0, a1                   # OR base address with mode
    csrw mtvec, a0                  # and save into mtvec

    # epilogue (restore three saved registers and the return address):
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw fp, 8(sp)                    # restore the frame pointer
    lw ra, 12(sp)                   # restore the return address from the stack frame
    addi sp, sp, 16                 # de-allocate the routine stack frame
    ret


.balign 4
.global set_time_cmp
.type set_time_cmp, @function
set_time_cmp:
    # prologue (save three saved registers and the return address)
    addi sp, sp, -16                # Allocate the routine stack frame
    sw ra, 12(sp)                   # Save the return address
    sw fp, 8(sp)                    # Save the frame pointer
    sw s1, 4(sp)
    sw s2, 0(sp)
    addi fp, sp, 16                 # Set the framepointer

    #csrw mtimecmp, a0                  # and save into mtvec
    li t0, 0x0200bff8              # load the mtime address
    lw t1, 0(t0)                    # load mtime (LO)
    lw t2, 4(t0)                    # load mtime (HI)

    add t3, t1, a0                  # increment lower bits by DELAY cycles
    sltu t1, t3, t1                 # generate carry-out
    add t2, t2, t1                  # add carry to upper bits

    li t0, 0x02004000
    sw t3, 0(t0)
    sw t2, 4(t0)


    # epilogue (restore three saved registers and the return address):
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw fp, 8(sp)                    # restore the frame pointer
    lw ra, 12(sp)                   # restore the return address from the stack frame
    addi sp, sp, 16                 # de-allocate the routine stack frame
    ret

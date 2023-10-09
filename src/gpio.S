/*
 * gpio.S
 *
 *  Created on: 18. sep. 2023
 *      Author: tomaz

 */

 .section .text

 .option norvc       # disables the generation of compressed instructions.

.equ GPIO_BASE, 0x10012000
.equ GPIO_OE, 0x08
.equ GPIO_OV, 0x0C


/*

*/

.balign 4                            // Align to 4(2^2) bytes boundary
.global gpio_output_enable               // Emit functgion_name to symbol table (scope GLOBAL)
.type gpio_output_enable, @function
gpio_output_enable:
    # prologue (save three saved registers and the return address)
    addi sp, sp, -16                # Allocate the routine stack frame
    sw ra, 12(sp)                   # Save the return address
    sw fp, 8(sp)                    # Save the frame pointer
    sw s1, 4(sp)
    sw s2, 0(sp)
    addi fp, sp, 16                 # Set the framepointer


    // Put ypur code here. If you use saved regiasters other than s1, s2,
    // you should save them onto stack first!
    la t0, GPIO_BASE
    lw t1, GPIO_OE(t0)

    li t3, 0x01
    sll t3, t3, a0
    or t1, t1, t3
    sw t1, GPIO_OE(t0)

    # epilogue (restore three saved registers and the return address):
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw fp, 8(sp)                    # restore the frame pointer
    lw ra, 12(sp)                   # restore the return address from the stack frame
    addi sp, sp, 16                 # de-allocate the routine stack frame
    ret


.balign 4                            // Align to 4(2^2) bytes boundary
.global gpio_set_pin               // Emit functgion_name to symbol table (scope GLOBAL)
.type gpio_set_pin, @function
gpio_set_pin:
    # prologue (save three saved registers and the return address)
    addi sp, sp, -16                # Allocate the routine stack frame
    sw ra, 12(sp)                   # Save the return address
    sw fp, 8(sp)                    # Save the frame pointer
    sw s1, 4(sp)
    sw s2, 0(sp)
    addi fp, sp, 16                 # Set the framepointer


    // Put ypur code here. If you use saved regiasters other than s1, s2,
    // you should save them onto stack first!
    la t0, GPIO_BASE
    lw t1, GPIO_OV(t0)
    li t3, 0x01
    sll t3, t3, a0
    or t1, t1, t3
    sw t1, GPIO_OV(t0)

    # epilogue (restore three saved registers and the return address):
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw fp, 8(sp)                    # restore the frame pointer
    lw ra, 12(sp)                   # restore the return address from the stack frame
    addi sp, sp, 16                 # de-allocate the routine stack frame
    ret


.balign 4                            // Align to 4(2^2) bytes boundary
.global gpio_clear_pin               // Emit functgion_name to symbol table (scope GLOBAL)
.type gpio_clear_pin, @function
gpio_clear_pin:
    # prologue (save three saved registers and the return address)
    addi sp, sp, -16                # Allocate the routine stack frame
    sw ra, 12(sp)                   # Save the return address
    sw fp, 8(sp)                    # Save the frame pointer
    sw s1, 4(sp)
    sw s2, 0(sp)
    addi fp, sp, 16                 # Set the framepointer


    // Put ypur code here. If you use saved regiasters other than s1, s2,
    // you should save them onto stack first!
    la t0, GPIO_BASE
    lw t1, GPIO_OV(t0)
    li t3, 0x01
    sll t3, t3, a0
    not t3, t3
    and t1, t1, t3
    sw t1, GPIO_OV(t0)

    # epilogue (restore three saved registers and the return address):
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw fp, 8(sp)                    # restore the frame pointer
    lw ra, 12(sp)                   # restore the return address from the stack frame
    addi sp, sp, 16                 # de-allocate the routine stack frame
    ret


.balign 4
.global gpio_toggle_pin
.type gpio_toggle_pin, @function
gpio_toggle_pin:
    # prologue (save three saved registers and the return address)
    addi sp, sp, -16                # Allocate the routine stack frame
    sw ra, 12(sp)                   # Save the return address
    sw fp, 8(sp)                    # Save the frame pointer
    sw s1, 4(sp)
    sw s2, 0(sp)
    addi fp, sp, 16                 # Set the framepointer


    li t0, GPIO_BASE
    lw t1, GPIO_OV(t0)
    li t2, 0x01
    sll t2, t2, a0                  # shift 1 to pin position
    xor  t1, t1, t2                 # toggle pin
    sw t1, GPIO_OV(t0)

    # epilogue (restore three saved registers and the return address):
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw fp, 8(sp)                    # restore the frame pointer
    lw ra, 12(sp)                   # restore the return address from the stack frame
    addi sp, sp, 16                 # de-allocate the routine stack frame
    ret



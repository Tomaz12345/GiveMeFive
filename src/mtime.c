/*
 * mtime.c
 *
 *  Created on: 19. sep. 2023
 *      Author: tomaz
 */

#include "mtime.h"
#include "gpio.h"

#define MTIME_REG	0x0200bff8
#define MTIME_CMP_REG	0x02004000

__attribute__ ((interrupt)) void mtime_int_handler() {

	unsigned int mcause_value;

	unsigned long *mtime_reg = MTIME_REG;		// bp
	unsigned long *mtime_cmp_reg = MTIME_CMP_REG;

	__asm__ volatile ("csrr %0, mcause"
	                   : "=r" (mcause_value) /* output */
	                   : /* input : none */
	                   : /* clobbers: none */);
	//unsigned long mtime_cmp_val;

	if (mcause_value >> 31) {
		*mtime_cmp_reg = *(mtime_reg) + 15000;
		gpio_toggle_pin(19);
	}
}

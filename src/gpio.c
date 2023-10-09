/*
 * gpio.c
 *
 *  Created on: 18. sep. 2023
 *      Author: tomaz
 */

#include "gpio.h"

void gpio_output_en(gpio_registers_t *GPIO, unsigned int pin) {
	GPIO->output_en |= 0x01 << pin;
}

void gpio_set_output(gpio_registers_t *GPIO, unsigned int pin) {
	GPIO->output_val |= 0x01 << pin;
}

void gpio_clear_output(gpio_registers_t *GPIO, unsigned int pin) {
	GPIO->output_val &= ~(0x01 << pin);
	/*unsigned int mask;
	mask = 0x01 << pin;
	GPIO->output_val &= ~mask;*/
}

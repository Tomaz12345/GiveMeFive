/*
 * gpio.h
 *
 *  Created on: 18. sep. 2023
 *      Author: tomaz
 */

#ifndef GPIO_H_
#define GPIO_H_

#define GPIO_BASE 0x10012000

typedef struct {
	volatile unsigned int input_val;
	volatile unsigned int input_en;
	volatile unsigned int output_en;
	volatile unsigned int output_val;
	//volatile int GPIO_INPUT_VAL;
	//volatile int GPIO_INPUT_EN;
	//volatile int GPIO_OUTPUT_EN;
	//volatile int GPIO_OUTPUT_VAL;
	volatile int GPIO_PUE;
	volatile int GPIO_DS;
	volatile int GPIO_RISE_IE;
	volatile int GPIO_RISE_IP;
	volatile int GPIO_FALL_IE;
	volatile int GPIO_FALL_IP;
	volatile int GPIO_HIGH_IE;
	volatile int GPIO_HIGH_IP;
	volatile int GPIO_LOW_IE;
	volatile int GPIO_LOW_IP;
	volatile int GPIO_IOF_EN;
	volatile int GPIO_IOF_SEL;
	volatile int GPIO_OUT_XOR;
} gpio_registers_t;

void gpio_output_en(gpio_registers_t *GPIO, unsigned int pin);
void gpio_set_output(gpio_registers_t *GPIO, unsigned int pin);
void gpio_clear_output(gpio_registers_t *GPIO, unsigned int pin);

#endif /* GPIO_H_ */

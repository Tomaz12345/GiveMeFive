/*
 * main.c
 *
 *  Created on: 18. sep. 2023
 *      Author: tomaz
 */

#include "main.h"
#include "gpio.h"
#include "uart.h"

gpio_registers_t *GPIO = (gpio_registers_t *) GPIO_BASE;
UART_Registers_t *UART0 = (UART_Registers_t *) 0x10013000;

char niz[] = "Patricio nima pojma!";
//extern void* vector_table;

int main() {

	gpio_output_enable(LED_RED);
	gpio_output_enable(LED_GREEN);
	GPIO->GPIO_IOF_EN |= 0x00030000;
	GPIO->GPIO_IOF_SEL &= 0xfffcffff;

	init_uart(UART0);

	register_handler((void*) vector_table, 0x01);
	enable_timer_interrupts();
	enable_global_interrupts();
	set_time_cmp(5000);

	uart_printf(UART0, niz);
	uart_printf(UART0, niz);
	uart_printf(UART0, niz);
	uart_printf(UART0, niz);
	uart_printf(UART0, niz);
	uart_printf(UART0, niz);
	uart_printf(UART0, niz);

	//gpio_output_enable(LED_GREEN);
	//set_time_cmp(35000);
	//gpio_clear_pin(LED_RED);
	//gpio_set_pin(LED_RED);
	//gpio_set_output(GPIO, LED_RED);

	//gpio_set_output(GPIO, LED_GREEN);
	//gpio_output_en(GPIO, LED_GREEN);
	//gpio_clear_output(GPIO, LED_GREEN);
	//while (1) {
	//	__asm__ volatile ("nop":::);
		//gpio_set_pin(LED_RED);
	//}



//gpio_output_enable(LED_GREEN);

	return 0;
}

/*
 * uart.c
 *
 *  Created on: 19. sep. 2023
 *      Author: tomaz
 */

#include "uart.h"

void uart_set_baud(UART_Registers_t *uart){
	uart->UART_DIV = 139;
}


void init_uart(UART_Registers_t *uart){
	uart->UART_TXCTRL |= 0x00000001;	// enable transmitter - 1 bit
	uart->UART_TXCTRL &= 0xfffffffd;	// stop bit

	uart_set_baud(uart);
}


void uart_put_char(UART_Registers_t *uart, unsigned char data){
	unsigned int txdata_reg;
	// Reading from txdata returns the current value of
	// the full flag and zero in the data field
	// wait untul ready to accept new data.
	do {
		txdata_reg = uart->UART_TXDATA;
	}
	while (txdata_reg & 0x80000000);

	// transmit FIFO able to accept new entry
	uart->UART_TXDATA = data;
}


void uart_printf(UART_Registers_t *uart, unsigned char *string){

	unsigned char data = string[0];
	int i = 0;

	while (data != '\0'){
		uart_put_char(uart, data);
		i++;
		data = string[i];
	}
}

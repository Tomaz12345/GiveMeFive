/*
 * uart.h
 *
 *  Created on: 19. sep. 2023
 *      Author: tomaz
 */

#ifndef UART_H_
#define UART_H_


#define UART0_RX_PIN           16
#define UART0_TX_PIN           17
#define UART0_PINS_SEL         0xfffcffff  // pins 16 and 17
#define UART0_PINS_EN          0x00030000  // pins 16 and 17
#define UART1_TX_PIN           18
#define UART1_RX_PIN           23
#define UART1_PINS_SEL         0xff7bffff  // pins 18 and 23
#define UART1_PINS_EN          0x00840000  // pins 18 and 23




typedef struct
{
	volatile int UART_TXDATA;
	volatile int UART_RXDATA;
	volatile int UART_TXCTRL;
	volatile int UART_RXCTRL;
	volatile int UART_IE;
	volatile int UART_IP;
	volatile int UART_DIV;
}UART_Registers_t;


void uart_printf(UART_Registers_t *uart, unsigned char *string);

void uart_set_baud(UART_Registers_t *uart);
void init_uart(UART_Registers_t *uart);
void uart_put_char(UART_Registers_t *uart, unsigned char data);
void uart_printf(UART_Registers_t *uart, unsigned char *string);



#endif /* UART_H_ */

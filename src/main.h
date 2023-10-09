/*
 * main.h
 *
 *  Created on: 18. sep. 2023
 *      Author: tomaz
 */

#ifndef MAIN_H_
#define MAIN_H_

#define LED_GREEN 19
#define LED_BLUE 21
#define LED_RED 22

void gpio_output_enable(unsigned int pin_num);
void gpio_set_pin(unsigned int pin_num);
void gpio_clear_pin(unsigned int pin_num);

void register_handler(void* vec_tab, unsigned int mode);
void enable_global_interrupts();
void enable_timer_interrupts();
void set_time_cmp(unsigned int snooze);

void vector_table();


#endif /* MAIN_H_ */

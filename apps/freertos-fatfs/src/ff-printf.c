/*
 * Copyright 2021 Patrick Paul
 * SPDX-License-Identifier: MIT-0
 */

#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdarg.h>

extern void PSP_Console_Write(char *buffer);

char bsp_ff_buffer[100];
void BSP_FF_PRINTF(char *format, ...){
    va_list va;
    va_start(va, format);
    vsprintf(bsp_ff_buffer, format, va);
    va_end(va);
    PSP_Console_Write(bsp_ff_buffer);
}
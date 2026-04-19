#include <stddef.h>
#include "FreeRTOS.h"
#include "task.h"

volatile unsigned int counter1 = 0;
volatile unsigned int counter2 = 0;

void *memcpy(void *dest, const void *src, size_t n)
{
    unsigned char *d = (unsigned char *)dest;
    const unsigned char *s = (const unsigned char *)src;
    size_t i;

    for (i = 0; i < n; i++)
    {
        d[i] = s[i];
    }

    return dest;
}

void *memset(void *dest, int value, size_t n)
{
    unsigned char *d = (unsigned char *)dest;
    size_t i;

    for (i = 0; i < n; i++)
    {
        d[i] = (unsigned char)value;
    }

    return dest;
}

void vApplicationMallocFailedHook(void)
{
    taskDISABLE_INTERRUPTS();
    for (;;)
    {
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName)
{
    (void)xTask;
    (void)pcTaskName;

    taskDISABLE_INTERRUPTS();
    for (;;)
    {
    }
}

static void task1(void *arg)
{
    volatile unsigned int i;
    (void)arg;

    for (;;)
    {
        counter1++;
        for (i = 0; i < 2000; i++) { }
    }
}

static void task2(void *arg)
{
    volatile unsigned int i;
    (void)arg;

    for (;;)
    {
        counter2++;
        for (i = 0; i < 5000; i++) { }
    }
}



int main(void)
{
    xTaskCreate(task1, "T1", 256, 0, 2, 0);
    xTaskCreate(task2, "T2", 256, 0, 2, 0);

    vTaskStartScheduler();

    for (;;)
    {
    }
}

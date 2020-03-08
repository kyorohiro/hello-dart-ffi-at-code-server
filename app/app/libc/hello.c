#include <stdio.h>
#include <malloc.h>

void print_hello(void) {
    puts("Hello, I am a shared library");
}

int sum(int a, int b) {
    return a+b;
}

char* new_buffer(int size) {
    char* ret = malloc(sizeof(char)*size);
    return ret;
}

char* init_buffer(char *src, int size) {
    // 0, 2, 3, 4, ...., size-1
    for(int i=0;i<size;i++) {
        *(src+i) = i;
    }
    return src;
} 
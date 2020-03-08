#include <stdio.h>
#include <malloc.h>

struct _Hello {
    int x;
    int y;
    // https://github.com/dart-lang/sdk/issues/35763
    // char name[128];
};

typedef struct _Hello Hello;

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

Hello* create_hello(int x, int y){//, char*name) {
    Hello *hello = (Hello*)malloc(sizeof(Hello));
    //snprintf(hello->name, 128, "%s", name);
    hello->x = x;
    hello->y = y;
    return hello;
}
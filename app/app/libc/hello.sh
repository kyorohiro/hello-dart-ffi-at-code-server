#!/bin/sh
# create lib
gcc -c -Wall -Werror -fpic hello.c
gcc -shared -o libhello.so hello.o
# execute 
#gcc -Wall -o main_hello.exe main_hello.c -L. -lhello
#LD_LIBRARY_PATH=. ./main_hello.exe


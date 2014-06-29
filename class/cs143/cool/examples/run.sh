#!/bin/bash

g++ -w scanner.cpp lex.yy.c -I../include/PA2 -L../assignments/PA2 ../assignments/PA2/utilities.cc ../assignments/PA2/stringtab.cc -o scanner
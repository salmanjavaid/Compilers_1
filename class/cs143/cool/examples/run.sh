#!/bin/bash 

if flex tflex.lex; then
    if g++ -w scanner.cpp lex.yy.c -I../include/PA2 -L../assignments/PA2 ../assignments/PA2/utilities.cc ../assignments/PA2/stringtab.cc -o scanner; then
	if ./scanner < hello_world.cl; then
	    echo 'scanner execuation.'
	else 
	    echo 'scanner execution passed.'
	fi   
    else 
	echo 'scanner compiled.'
    fi
else
   echo 'flex compilation failed.'
fi

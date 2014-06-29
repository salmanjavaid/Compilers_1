#include "cool-parse.h"
#include <stdio.h>
#include "utilities.h"

extern int yylex();
extern char* yytext;
extern int num_lines;

char *Database[] = {"CLASS", "INHERITS"};
int main(){
  int ntoken;

  ntoken = yylex();
  while(ntoken){   
    if (ntoken !=32){
      printf("%s   :     %s    %s    %s    :    %d\n", cool_token_to_string(ntoken), "     ", yytext,
	     "      ", num_lines);
    }
    ntoken = yylex();
  }

  return 1;
}

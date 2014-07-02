/* sample simple scanner 

compile with
flex  sample.flex
g++ -I/afs/ir/class/cs143/cool/sp12/include/PA2 -I/afs/ir/class/cs143/cool/sp12/src/PA2 lex.yy.c -lfl

run witih
./a.out < input

*/
%{
int num_lines = 0;
#define CLASS 10
#define LAMBDA 1
#define DOT    2
#define PLUS   3
#define OPEN   4
#define CLOSE  5
#define NUM    6
#define ID     7
#define INVALID 8
%}
%x COMMENT
%%
"class"  {return CLASS;}
[a-z][a-zA-Z0-9_]+  {return ID;}
\n  { num_lines++; }
"+" { return(PLUS); }
"\\" { return(LAMBDA); }
"." { return(DOT); }
"(" { return(OPEN); }
")"  { return(CLOSE); }
[ \t]+
[0-9]+ { return(NUM); }
. { return(INVALID); }
"//" { BEGIN(COMMENT); }
<COMMENT>.*  /* discard line */
<COMMENT>\n  { num_lines++; BEGIN(INITIAL); }
%%

main(int argc, char **argv) {
  int res;
  yyin = stdin;
  while(res = yylex()) {
    printf("class: %d lexeme: %s line: %d\n", res, yytext, num_lines);
  }
} 


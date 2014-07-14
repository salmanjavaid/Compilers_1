/* sample simple scanner 

compile with
flex  sample.flex
g++ -I/afs/ir/class/cs143/cool/sp12/include/PA2 -I/afs/ir/class/cs143/cool/sp12/src/PA2 lex.yy.c -lfl

run witih
./
a.out < input

*/
%{
int num_lines = 0;
char string_buf[256];
char *string_buf_ptr;

#define CLASS 10
#define LAMBDA 1
#define DOT    2
#define PLUS   3
#define OPEN   4
#define CLOSE  5
#define NUM    6
#define ID     7
#define INVALID 8
#define MAX_STR_CONST 256;

char string_buf[256];
char *string_buf_ptr;
 int size = 0;
%}
<<<<<<< HEAD
%x str

%%

\"     { string_buf_ptr = string_buf; BEGIN(str);}

<str>\"        { /* saw closing quote - all done */
  yyrestart(yyin);
=======
%x COMMENT
%x str
%%

<str>\"        { /* saw closing quote - all done */
>>>>>>> c_string
  BEGIN(INITIAL);
  *string_buf_ptr = '\0';
  /* return string constant token type and
   * value to parser
   */
<<<<<<< HEAD
  int i = 0;
  
  string_buf_ptr-=size;  
  for (; i < size; i++){
    printf("%c", *(string_buf_ptr + i));
    yytext[i]=*(string_buf_ptr + i);
    printf("%c",yytext[i]);
  }
  yytext[i]='\0';
  printf("\n");
  return ID;
=======
>>>>>>> c_string
 }

<str>\n        {
  /* error - unterminated string constant */
  /* generate error message */
 }

<<<<<<< HEAD


=======
>>>>>>> c_string
<str>\\[0-7]{1,3} {
  /* octal escape sequence */
  int result;

<<<<<<< HEAD

  (void) sscanf( yytext + 1, "%o", &result );
 

  if (result == 0x00){
     *string_buf_ptr++ = '0';
  } else {
	    if ( result > 0xff )
	      /* error, constant is out-of-bounds */

	      *string_buf_ptr++ = result;
  }
       size++;
=======
  (void) sscanf( yytext + 1, "%o", &result );

  if ( result > 0xff )
    /* error, constant is out-of-bounds */

    *string_buf_ptr++ = result;
>>>>>>> c_string
 }

<str>\\[0-9]+ {
  /* generate error - bad escape sequence; something
   * like '\48' or '\0777777'
   */
<<<<<<< HEAD
  printf("Error\n");
 }

<str>\\n  *string_buf_ptr++ = '\n';  size++;
<str>\\t  *string_buf_ptr++ = '\t';  size++;
<str>\\r  *string_buf_ptr++ = '\r';  size++;
<str>\\b  *string_buf_ptr++ = '\b';  size++;
<str>\\f  *string_buf_ptr++ = '\f';  size++;
<str>\\a  *string_buf_ptr++ = '\a';  size++;
<str>\\(.|\n)  *string_buf_ptr++ = yytext[1];  size++;
=======
 }

<str>\\n  *string_buf_ptr++ = '\n';
<str>\\t  *string_buf_ptr++ = '\t';
<str>\\r  *string_buf_ptr++ = '\r';
<str>\\b  *string_buf_ptr++ = '\b';
<str>\\f  *string_buf_ptr++ = '\f';

<str>\\(.|\n)  *string_buf_ptr++ = yytext[1];
>>>>>>> c_string

<str>[^\\\n\"]+        {
  char *yptr = yytext;

<<<<<<< HEAD
  int i = 0;
  while ( *yptr )
    {
      *string_buf_ptr++ = *yptr++;
      yytext[i] = *(string_buf_ptr-1);
      /* printf("%c", yytext[i]);  */
      size++;
      i++;
    }
  
 }


%%

main(int argc, char **argv) {
  int res;
  yyin = stdin;

  while(res = yylex()) {
    
     printf("class: %d lexeme: %s line: %d\n", res, yytext, num_lines); 
  }
/*
=======
  while ( *yptr )
    *string_buf_ptr++ = *yptr++;
 }


"class"  {return CLASS;}
[a-z][a-zA-Z0-9_]+  {return ID;}
\n  { num_lines++; }
>>>>>>> c_string
"+" { return(PLUS); }
"\\" { return(LAMBDA); }
"." { return(DOT); }
"(" { return(OPEN); }
")"  { return(CLOSE); }
[ \t]+   ;
[0-9]+ { return(NUM); }
"//" { BEGIN(COMMENT); }
<COMMENT>.*  /* discard line 
<COMMENT>\n  { num_lines++; BEGIN(INITIAL); }
*/

} 


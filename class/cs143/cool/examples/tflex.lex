%{
  #include "cool-parse.h"

  int num_lines = 0;
  char string_buf[256];
  char *string_buf_ptr;
  int size = 0;

%}
%x str


%%


"class"	        return CLASS;
"else"		return ELSE;
"fi"		return FI;
"if"		return IF;
"inherits"	return INHERITS;
"let"		return LET;
"loop"		return LOOP;
"pool"		return POOL;
"then"		return THEN;
"while"		return WHILE;
"case"		return CASE;
"esac"		return ESAC;
"of"		return OF;
"darrow"	return DARROW;
"new"		return NEW;
"isvoid"	return ISVOID;
"assign"	return ASSIGN;
"not"		return NOT;
"{"             return 123;
"}"             return 125;
"("             return 40;
")"             return 41;
"in"			return IN;
[ \t]+            ;
\"     { string_buf_ptr = string_buf; BEGIN(str);}

<str>\"        { /* saw closing quote - all done */
  yyrestart(yyin);
  BEGIN(INITIAL);
  *string_buf_ptr = '\0';
  /* return string constant token type and
   * value to parser
   */
  int i = 0;
  
  string_buf_ptr-=size;  
  for (; i < size; i++){
    yytext[i]=*(string_buf_ptr + i);
  }
  yytext[i]='\0';
  return STR_CONST;
 }

<str>\n        {
  /* error - unterminated string constant */
  /* generate error message */
 }



<str>\\[0-7]{1,3} {
  /* octal escape sequence */
  int result;


  (void) sscanf( yytext + 1, "%o", &result );
 

  if (result == 0x00){
     *string_buf_ptr++ = '0';
  } else {
	    if ( result > 0xff )
	      /* error, constant is out-of-bounds */

	      *string_buf_ptr++ = result;
  }
       size++;
 }

<str>\\[0-9]+ {
  /* generate error - bad escape sequence; something
   * like '\48' or '\0777777'
   */
 
 }

<str>\\n  *string_buf_ptr++ = '\n';  size++;
<str>\\t  *string_buf_ptr++ = '\t';  size++;
<str>\\r  *string_buf_ptr++ = '\r';  size++;
<str>\\b  *string_buf_ptr++ = '\b';  size++;
<str>\\f  *string_buf_ptr++ = '\f';  size++;
<str>\\a  *string_buf_ptr++ = '\a';  size++;
<str>\\(.|\n)  *string_buf_ptr++ = yytext[1];  size++;

<str>[^\\\n\"]+        {
  char *yptr = yytext;

  int i = 0;
  while ( *yptr )
    {
      *string_buf_ptr++ = *yptr++;
      yytext[i] = *(string_buf_ptr-1);
      size++;
      i++;
    }
  
 }
"SELF_TYPE"     	return TYPEID;
"main" 			return OBJECTID;
[A-Z][a-zA-Z0-9_]*	return TYPEID; 
[a-z][a-zA-Z0-9_]*      return OBJECTID;
";"             	return 59;
[0-9]+			return INT_CONST;
":"			return 58;
\n             		{num_lines++;};
%%

int yywrap(void){
  return 1;
}

#ifdef yylex
#   undef yylex
extern "C" int yylex() { return cool_yylex(); 
  /*\b[Ss][Ee][Ll][Ff][_][Tt][Yy][Pp][Ee]*/
}
#endif







%{
  #include "cool-parse.h"
  int num_lines = 0;
%}



%%


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
[ \t]+            ;
\b"in"			return IN;
\"([^\\\"]|\\.)*\" 	return STR_CONST;
"SELF_TYPE"     	return TYPEID;
"main" 			return OBJECTID;
[A-Z][a-zA-Z0-9]*	return TYPEID; 
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
extern "C" int yylex() { return cool_yylex(); }
#endif







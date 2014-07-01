%{
  #include "cool-parse.h"
  int num_lines = 0;
%}



%%
\"([^\"]+)\" 	return STR_CONST;
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







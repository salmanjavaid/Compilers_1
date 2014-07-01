%{
  #include "cool-parse.h"

  int num_lines = 0;
%}



%%

\b[Cc][Ll][Aa][Ss][Ss]	        	return CLASS;
\b[Ee][Ll][Ss][Ee]			return ELSE;
\b[Ff][Ii]				return FI;
\b[Ii][Ff]	       			return IF;
\b[Ii][Nn][Hh][Ee][Rr][Ii][Tt][Ss]	return INHERITS;
\b[Ll][Ee][Tt]				return LET;
\b[Ll][Oo][Oo][Pp]			return LOOP;
\b[Pp][Oo][Oo][Ll]			return POOL;
\b[Tt][Hh][Ee][Nn]			return THEN;
\b[Ww][Hh][Ii][Ll][Ee]			return WHILE;
\b[Cc][Aa][Ss][Ee]			return CASE;
\b[Ee][Ss][Aa][Cc]			return ESAC;
\b[Oo][Ff]				return OF;
==>					return DARROW;
\b[Nn][Ee][Ww]				return NEW;
\b[Ii][Ss][Vv][Oo][Ii][Dd]		return ISVOID;
\b[Aa][Ss][Ss][Ii][Nn]			return ASSIGN;
\b[Nn][Oo][Tt]				return NOT;
\{			                return 123;
\}			                return 125;
\(             				return 40;
\)             				return 41;
[ \t]+            			;
\b[Ii][nN]				return IN;
\"([^\\\"]|\\.)*\"		 	return STR_CONST;
\b'self_type'				return TYPEID;
\b[Mm][Aa][Ii][Nn]			return OBJECTID;
[A-Z][a-zA-Z0-9]*			return TYPEID; 
[a-z][a-zA-Z0-9_]*      		return OBJECTID;
\;	             			return 59;
[0-9]+					return INT_CONST;
\:					return 58;
\n             				{num_lines++;};
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







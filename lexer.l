%{
/* ---Imports--- */

/* Generated parser header file */
#include "parser.tab.h"

/* Keep track of actual line number */
int countln;
%}

/* Creates a scanner that stores a line number */
%option yylineno

/* ---Regular expressions--- */

ALPHA                   [a-zA-Z]
NUMBER                  [0-9]
UNARY                   "++"|"--"

/* ---Token specifications (Pattern -> Action)--- */

%%
"{"	{startScope(); return '{';}
"}"	{endScope(); return '}';}
"main"                          { return MAIN; }
"print"                         { return PRINT; }
"int"                           { yylval.ival = INT; return INT; }
"double"                        { yylval.ival = DOUBLE; return DOUBLE; }
"return"                        { return RETURN; }
"if"	                        { return IF; }
"else"	                        { return ELSE; }
[-]?{NUMBER}+                   { yylval.str=strdup(yytext); return INT_NUM; }
[-]?{NUMBER}+\.{NUMBER}{1,15}   { yylval.str=strdup(yytext); return DOUBLE_NUM; }
{ALPHA}({ALPHA}|{NUMBER})*      { yylval.str=strdup(yytext); return IDENT; }
{UNARY}                         { return UNARY; }
"<="                            { return LE; }
">="                            { return GE; }
"=="                            { return EQ; }
"!="                            { return NE; }
">"	                            { return GT; }
"<"	                            { return LT; }
"&&"	                        { return AND; }
"||"	                        { return OR; }
"!"                             { return NOT; }
"+"                             { return ADD; }
"-"                             { return SUBTRACT; }
"/"                             { return DIVIDE; }
"*"                             { return MULTIPLY; }
"%"                             { return MODULUS; }
\/\/.*                          { ; }
\/\*(.*\n)*.*\*\/               { ; } 
[ \t]*                          { ; }
[\n]                            { countln++; }
.	                            { return *yytext; }
["].*["]                        { return STR; }
%%

/* ---Functions for manipulating tokens--- */

/* Function for wrapping up all */
int yywrap() {
    return 1;
}
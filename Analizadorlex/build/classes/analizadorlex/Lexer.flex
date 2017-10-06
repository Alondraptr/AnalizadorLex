package analizadorlex;

import javax.swing.*;
import java.util.*;
import static analizadorlex.Token.*;

%% 
%class Lexer
%unicode
%{
public String lexeme;
%}

/*NUMEROS Y DE MAS*/
texto = [a-zA-Z_]
entero = [0-9]
/* Caracteres */
TerminadorLinea =   \r |\n |\r\n
Caracter =   [^\r\n]
Espacio =   [ \t\f]
/* Comentario */
Comentario  =   {ComentarioMultilinea} | {ComentarioLinea}
ComentarioMultilinea =   "/*" [^*] ~"*/" | "/*" "*"+ "/"
ComentarioLinea =   "//" {Caracter}*
/* Identificador */
Identificador  =   [:jletter:][:jletterdigit:]*

/* Literales Numericas Flotantes */
Flot1 =   [0-9]+\. [0-9]*
Flot2 = \. [0-9]+
Flot3 =   [0-9]+
Exponente  =   [eE] [+ - ]? [0-9]+
NumeroFlotante  =   ({Flot1}|{Flot2}|{Flot3}) {Exponente}?

%% /* -----------------------------------------------------------------------------------------*/
<YYINITIAL>
{
/* Palabras Reservadas -Programa */
"INICIO"  { return INICIO;}
"FIN"  { return FIN; }
"PRINCIPAL"  { return PRINCIPIO; }
"ENTRADA" { return ENTRADA; }
"IMPRIME" { return IMPRIME; }
public String lexeme;

/* Palabras Reservadas -Tipos de Datos */
{texto}({texto}|{texto})* {lexeme=yytext(); return TEXTO;}

 ("(-"{entero}+")")|{entero}+ {lexeme=yytext(); return ENTERO;}
"float"         { return FLOTANTE; }
"bool"         { return BOOL; }
/* Palabras Reservadas -Sentencias Selectivas */
"si"           { return SI ; }
"entonces"     { return ENTONCES; }
"sino"         { return SINO; }
"en_caso"      { return ENCASO; }

/* Palabras Reservadas - Sentencias Repetitivas */
"mientras"     { return MIENTRAS; }
"hacer"        { return HACER; }
"repetir"      { return REPETIR; }
"hasta"        { return HASTA; }
"para"       { return PARA; }

/* Palabras Reservadas -Literales Booleanas */
"true"       { return TRUE; }
"false"        { return FALSE; }
/* Simbolos */
"("            { return PARENT; }
")"        { return PAREND; }
"{"            { return LLAVEI; }
"}"            { return LLAVEND; }
"["            { return CORI; }
"]"            { return CORE; }
","            { return COMA; }
":"            { return DOSPUNTOS; }
";"  { return PUNTOCOMA; }
/* Operadores Aritmeticos */
"="            { return IGUAL; }
"++"           { return MASMAS; }
"--"           { return MENMEN; }
"+"            { return MAS; }
"-"            { return MEN; }
"*"            { return MUL; }
"/"            { return DIV; }
".mod."        { return MOD; }
"+="           { return MASI; }
"-="            { return MENI; }
"*="           { return MULI; }
"/="           { return DIVI; }
".mod.="       { return MODI; }
/* Operadores Relacionales */
">"            { return MAYQ; }
"<"            { return MENQ; }
"!"            { return NO; }
"=="           { return IGUALIGUAL; }

">="           { return MAYORI; }
"<="           { return MENORI; }
"!="           { return NOI; }
".y."          { return Y; }
".o."          { return O; }
/* Operadores Cadenas */
"."            {return PUNTO; }


/* Fin de Linea */
{TerminadorLinea} { return FINLINEA; }
/* Comentarios */
{Comentario}   { /* No se procesa */ }
/* Espacios */
{Espacio}    { /* No se procesa */ }
}
/* Error */
. {return ERROR;}
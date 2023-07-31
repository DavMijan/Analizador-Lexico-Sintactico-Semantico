package Analizador;
import java_cup.runtime.Symbol;
import java.util.LinkedList;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char

N = [0-9]
A = [a-zA-Z_]
Esp = [ \t\r\n]
AlfaNumerico=({A}+|{A}+{N}+)+
LU={AlfaNumerico} | [/.#=?-]
Correo={AlfaNumerico}"@"{AlfaNumerico}"."({A}+|{A}+"."{A}+)
Pagina="www."{AlfaNumerico}"." ({A}+ | ({A}+ "/" {LU}+))

%{
    public static LinkedList<String> ErroresLexicos=new LinkedList<String>();
    private Symbol symbol (int type, Object value){
        return new Symbol (type, yyline, yycolumn, value);
    }

    private Symbol symbol (int type){
        return new Symbol (type, yyline, yycolumn);
    }
%}
%%
<YYINITIAL> {Esp}       {/*Ignore*/}
<YYINITIAL> "\""        {return new Symbol(sym.Sign_Comillas, yychar, yyline, yytext());}
<YYINITIAL> "="         {return new Symbol(sym.Sign_Igual, yychar, yyline, yytext());}
<YYINITIAL> "("         {return new Symbol(sym.Abrir_LLave, yychar, yyline, yytext());}
<YYINITIAL> ")"         {return new Symbol(sym.Cerrar_LLave, yychar, yyline, yytext());}
<YYINITIAL> ","         {return new Symbol(sym.Sign_Coma, yychar, yyline, yytext());}
<YYINITIAL> ";"         {return new Symbol(sym.Punto_Coma, yychar, yyline, yytext());}
<YYINITIAL> ":"         {return new Symbol(sym.Dos_puntos, yychar, yyline, yytext());}
<YYINITIAL> "+"         {return new Symbol(sym.Op_Suma, yychar, yyline, yytext());}
<YYINITIAL> "-"         {return new Symbol(sym.Op_Resta, yychar, yyline, yytext());}
<YYINITIAL> "*"         {return new Symbol(sym.Op_Producto, yychar, yyline, yytext());}
<YYINITIAL> "/"         {return new Symbol(sym.Op_Division, yychar, yyline, yytext());}

<YYINITIAL> INI_HTML        {return new Symbol(sym.Inicio_Html, yychar, yyline, yytext());}
<YYINITIAL> FIN_HTML        {return new Symbol(sym.Fin_Html, yychar, yyline, yytext());}
<YYINITIAL> ENCABEZADO_INI  {return new Symbol(sym.Inicio_Encabezado, yychar, yyline, yytext());}
<YYINITIAL> ENCABEZADO_FIN  {return new Symbol(sym.Fin_Encabezado, yychar, yyline, yytext());}
<YYINITIAL> TIT             {return new Symbol(sym.Et_Titulo, yychar, yyline, yytext());}
<YYINITIAL> CUERPO_INI      {return new Symbol(sym.Inicio_Cuerpo, yychar, yyline, yytext());}
<YYINITIAL> CUERPO_FIN      {return new Symbol(sym.Fin_Cuerpo, yychar, yyline, yytext());}
<YYINITIAL> BORDE           {return new Symbol(sym.Tab_Borde, yychar, yyline, yytext());}
<YYINITIAL> TABLA_IN        {return new Symbol(sym.Inicio_Tabla, yychar, yyline, yytext());}
<YYINITIAL> TABLA_FIN       {return new Symbol(sym.Fin_Tabla, yychar, yyline, yytext());}
<YYINITIAL> FILA            {return new Symbol(sym.Inicio_Fila, yychar, yyline, yytext());}
<YYINITIAL> FILA_FIN        {return new Symbol(sym.Fin_Fila, yychar, yyline, yytext());}
<YYINITIAL> COLUMNA         {return new Symbol(sym.Nue_Columna, yychar, yyline, yytext());}
<YYINITIAL> NEGRITA         {return new Symbol(sym.Fuent_Negrita, yychar, yyline, yytext());}
<YYINITIAL> IMPRIMIR        {return new Symbol(sym.Ins_Imprimir, yychar, yyline, yytext());}
<YYINITIAL> SALTOLINEA      {return new Symbol(sym.Salto_Linea, yychar, yyline, yytext());}
<YYINITIAL> LISTA_IN        {return new Symbol(sym.Inicio_Lista, yychar, yyline, yytext());}
<YYINITIAL> LISTA_FIN       {return new Symbol(sym.Fin_Lista, yychar, yyline, yytext());}
<YYINITIAL> ENLACE          {return new Symbol(sym.Et_Enlace, yychar, yyline, yytext());}
<YYINITIAL> IMAGEN_IN       {return new Symbol(sym.Inicio_Imagen, yychar, yyline, yytext());}
<YYINITIAL> NOMBRE          {return new Symbol(sym.Nombre_Imagen, yychar, yyline, yytext());}
<YYINITIAL> ANCHO           {return new Symbol(sym.Et_Ancho, yychar, yyline, yytext());}
<YYINITIAL> ALTURA          {return new Symbol(sym.Et_Alto, yychar, yyline, yytext());}
<YYINITIAL> IMAGEN_FIN      {return new Symbol(sym.Fin_Imagen, yychar, yyline, yytext());}

<YYINITIAL> {N}+                                                    {return new Symbol(sym.Num_Int, yychar, yyline, yytext());}
<YYINITIAL> {N}+ "." {N}+                                           {return new Symbol(sym.Num_Float, yychar, yyline, yytext());}
<YYINITIAL> {Pagina}|{Pagina}("/"{AlfaNumerico})+".html"            {return new Symbol(sym.Webpage, yychar, yyline, yytext());}
<YYINITIAL> {AlfaNumerico}                                          {return new Symbol(sym.Datos, yychar, yyline, yytext());}
<YYINITIAL> {Correo}                                                {return new Symbol(sym.Correo, yychar, yyline, yytext());}
<YYINITIAL> . {
    ErroresLexicos.add("Este es un error lexico: "+yytext()+", en la linea: "+yyline+", en la columna: "+yychar);
}


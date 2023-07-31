package Generador;

import java.io.File;

public class GLexico 
{
    public static void main(String[] args) 
    {
        String path2="src/Analizador/LexerCup.flex";
        generarLexer(path2);
    } 
    
    public static void generarLexer(String path2)
    {
        File file2=new File(path2);
        jflex.Main.generate(file2);  
    } 
}

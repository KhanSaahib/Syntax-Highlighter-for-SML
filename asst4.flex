
%{
    FILE* outFile;
    void printKeyword(const char* s) {
        fprintf(outFile, "<span style=\"color:#a0a000;\">%s</span>", s);
    }
    void printKeyword1(const char* s, const char* c) {
        fprintf(outFile, "<span style=\"color:%s;\">%s</span>",c, s);
    }
    

%}
           
%%



    /* Rules for keywords */
datatype|of|val|fun|let|in|end|if|then|else|orelse|andalso|case            printKeyword1(yytext,"a0a000");




    /* Rules for built-in types */

int|bool|string                                printKeyword1(yytext,"00c000");



    /* Rule for integer and boolean literals */

[0-9]+                                         printKeyword1(yytext,"ff0000");
true|false                                     printKeyword1(yytext,"ff0000");


    /* Rule for identifiers */

[A-Z_$][a-zA-Z_$0-9]*                          printKeyword1(yytext,"ff00ff");
[a-zA-Z_$][a-zA-Z_$0-9]*                       printKeyword1(yytext,"000000");



    /* Rules for operators and separators*/
"+"|"-"|"*"|"|"|"=>"|"<="|">="|"="|"<"|">"|"::"|":"|"."|"["|"]"|","|"("|")"|";"            printKeyword1(yytext,"0000ff");




    /* Rule for string literal */
    /* Hint: you can call input() to read the next character in the stream */

\".*\"                                          printKeyword1(yytext,"ff0000");









    /* Rule for comment */
    /* Hint: you can call input() to read the next character in the stream */
    /* Hint: you can call unput(char) to return a character to the stream after reading it */

"(*"|"(*".*                                     printKeyword1(yytext,"00aaff");
"*)"                                            printKeyword1(yytext,"00aaff");

    /* Rule for whitespace */

"\t"                                           {fprintf(outFile, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");}
[ ]                                             {fprintf(outFile, "&nbsp;");}
"\n"                                            {fprintf(outFile, "<br>");}







               




    /* Catch unmatched tokens */
.               fprintf(stderr, "INVALID TOKEN: %s\n", yytext);

%%

int main(int argc, char** argv) {
    const char* inFileName = (argc > 1)?argv[1]:"test.sml";
    const char* outFileName = (argc > 2)?argv[2]:"test.html";
    yyin = fopen(inFileName, "r");
    outFile = fopen(outFileName, "w");
    fprintf(outFile, "<html>\n<body><tt>\n");
    yylex();
    fprintf(outFile, "</body>\n</html></tt>\n");
    fclose(yyin);
    fclose(outFile);
    return 0;
}
int yywrap() {
    return 1;
}


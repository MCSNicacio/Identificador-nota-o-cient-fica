/*	EA550 - Introdução a Software de Sistema
 	Nicácio de Mattos (218335)
	Reconhecedor de números em notação científica
*/

/*	Seção 1: DEFINIÇÕES */

%{	

#define     IDN  258
#define     INT  259
#define     REAL  260
#define     SIMB_ATR  261
#define     SIMB_PA1  262
#define     SIMB_PA2  263
#define     SIMB_MUL  264
#define     SIMB_DIV  265
#define     SIMB_SOM  266
#define     SIMB_SUB  267
#define     SIMB_POT  268
#define     SIMB_END  269
#define     INVALIDO  270

char alerta[]="Reconhecedor de números em notação científica\n\t";

%}	

%%  

[E]\+[0-9]+ |
[E][0-9]+ 		    {/* Ação */
					printf("%s %s ==> token da classe <Expoente positivo> \n", alerta, yytext);
					return INT;
					}

[E]\-[0-9]+  		{/* Ação */
					printf("%s %s ==> token da classe <Expoente negativo> \n", alerta, yytext);
					return INT;
					}

[E]([0-9]*\.[0-9]+)	|
[E]([0-9]+\.[0-9]*) {/* Ação */
					printf("%s %s ==> token da classe <Expoente positivo fracionário ***INVÁLIDO***> \n", alerta, yytext);
					return INVALIDO;
					}

[E]\-([0-9]*\.[0-9]+)	|
[E]\-([0-9]+\.[0-9]*) {/* Ação */
					printf("%s %s ==> token da classe <Expoente negativo fracionário ***INVÁLIDO***> \n", alerta, yytext);
					return INVALIDO;
					}
    

[0-9]+		  		{/* Ação */
					printf("%s %s ==>  token da classe <Mantissa inteira positiva> \n", alerta, yytext);
					return INT;
					}

\-[0-9]+		  	{/* Ação */
					printf("%s %s ==>  token da classe <Mantissa inteira negativa> \n", alerta, yytext);
					return INT;
					}                    

([0-9]*\.[0-9]+)	|
([0-9]+\.[0-9]*)  	{/* Ação */
					printf("%s %s ==> token da classe <Mantissa fracionária positiva> \n", alerta, yytext);
					return REAL;
					}

(\-[0-9]*\.[0-9]+)	|
(\-[0-9]+\.[0-9]*)  	{/* Ação */
					printf("%s %s ==> token da classe <Mantissa fracionária negativa> \n", alerta, yytext);
					return REAL;
					}

.|;|\^|\-|\+|\/|\*|= {/* Ação para qualquer outro elemento de entrada */
					printf("%s %s ==> elemento não reconhecido \n", alerta, yytext);
					return INVALIDO;
					}

%%  


int main() 
{
	int	val;

	printf("Atenção:a função main() vai chamar o analisador léxico em um laço infinito.\n\
	Entre com qualquer tipo de entrada e veja como a mesma é reconhecida.\n\
	Use CTRL-C para encerrar o programa.\n\n");

	while((val = yylex()))
		printf("Função main: código recebido do analisador léxico = %d \n", val);

	return 0;
}


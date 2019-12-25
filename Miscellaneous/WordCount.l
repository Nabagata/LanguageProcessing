

%{
	int words = 0;
	int chars = 0;
	int lines = 0;
%}

%%

[a-zA-Z]+ { words++ ; chars+=strlen(yytext); }
\n {lines++;chars++;}
. {chars++;}

%%

int main(int argc,char* argv[])
{
	yylex();
	printf("Words = %d\nLines = %d\nChars = %d\n",words,lines,chars);
	return 0;
}
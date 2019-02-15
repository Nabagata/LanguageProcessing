/* encryption of text */

%option noyywrap nodefault
%{
	void rotate_special(char* word);
	void encrypt_normal(char* word);
	void encrypt_num(char* word);
	void encrypt_white(char* word);
	void encrypt_newline(char* word);
%}

%%

a |
an |
are |
is |
was |
were |
in |
the |
up |
at |
on |
am |
down |
there |
this |
that |
those |
these |
between |
near |
by |
and |
or |
of |
I |
you |
to 		{	rotate_special(yytext);}
[a-zA-Z]+(\'(s|t))? { encrypt_normal(yytext); }
[0-9]+ { encrypt_num(yytext);}
[ \t]+ { encrypt_white(yytext);}
[ \t\n]+ { encrypt_newline(yytext);}
. { fprintf(yyout,"%s",yytext);}

%%

void rotate_special(char* word)
{
	if(strlen(word)<=2)
	{
		fprintf(yyout,"%s",word);
	}
	else
	{
		int n = strlen(word);
		for(int i=1,j=0;j<n;i = (i-1+n)%n,j++)
		{
			fprintf(yyout,"%c",word[i]);
		}
	}
}

void encrypt_normal(char* word)
{
	int n = strlen(word);
	for(int i=n-1;i>=0;i--)
	{
		word[i] = (char)(((int)word[i]+5)%26+'a');
		fprintf(yyout,"%c",word[i]);
	}
}

void encrypt_num(char* word)
{
	int n = strlen(word),m = (n+1)/2;
	if(n==1)
	{
		fprintf(yyout,"%s",word);
		return;
	}
	for(int i=m;i<n;i++)
	{
		fprintf(yyout,"%c",word[i]);
	}
	if(n%2==1)
	{
		fprintf(yyout,"%c",word[n/2]);
		m = (n-2)/2;
	}
	else
	m = (n-1)/2;
	for(int i=0;i<=m;i++)
	{
		fprintf(yyout,"%c",word[i]);
	}
}

void encrypt_white(char* word)
{
	fprintf(yyout," ");
}

void encrypt_newline(char* word)
{
	fprintf(yyout,"\n");
}

int main(int argc,char* argv[])
{
	if(argc>1)
	{
		yyin = fopen(argv[1],"r");
		if(yyin==NULL)
		{
			perror("File not opened");
			exit(0);
		}
	}
	yylex();
	printf("Completed successfully\n");
	return 0;
}
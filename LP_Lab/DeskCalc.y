/* an initial implementation of desk calculator */

%{
	#include <stdio.h>	
	#include <math.h>
	struct ast
	{
		int nodetype;
		struct ast* l,*r;
	};
	struct num
	{
		int nodetype;
		double val;
	};
	struct ast* t;
	struct ast* newast(int nodetype,struct ast* l,struct ast* r);
	struct ast* newnum(int nodetype,double f);
	double eval(struct ast* t);
%}
%union{
	struct ast* a;
	double d;
}
%left SUB
%left ADD
%left MUL
%left DIV
%right EXP
%right ABS
%right UM
%token <d> NUM
%type <a> expr factor exponent term

%token EOL

%%

calclist: /* the initial match */
	| calclist expr EOL {printf("Result: %.5f\n",eval((struct ast*)$2));}
	;
expr: factor
	| expr ADD factor { $$ = newast(ADD,(struct ast*)$1,(struct ast*)$3);}
	| expr SUB factor { $$ = newast(SUB,(struct ast*)$1,(struct ast*)$3);}
	;
factor: exponent
	  | factor MUL exponent { $$ = newast(MUL,(struct ast*)$1,(struct ast*)$3);}
	  | factor DIV exponent { $$ = newast(DIV,(struct ast*)$1,(struct ast*)$3);}
	  ;
exponent: term
	| term EXP exponent {$$ = newast(EXP,(struct ast*)$1,(struct ast*)$3);}
term: NUM { $$ = newnum(NUM,$1);}
	| UM term { $$ = newast(UM,(struct ast*)$2,NULL);}
	| ABS term { $$ = newast(ABS,(struct ast*)$2,NULL);}
	;

%%
struct ast* newast(int nodetype,struct ast* l,struct ast* r)
{
	struct ast* rtn;
	rtn = NULL;
	rtn = (struct ast*)malloc(sizeof(struct ast));
	rtn->nodetype = nodetype;
	rtn->l = l;
	rtn->r = r;
	return rtn;
}
struct ast* newnum(int nodetype,double f)
{
	struct num* rtn;
	rtn = NULL;
	rtn = (struct num*)malloc(sizeof(struct num));
	rtn->nodetype = nodetype;
	rtn->val = f;
	return (struct ast*)rtn;
}
double eval(struct ast* t)
{
	double r;
	switch(t->nodetype)
	{
		case NUM:
		return ((struct num*)t)->val;
		break;
		case ADD:
		return eval(t->l)+eval(t->r);
		break;
		case SUB:
		return eval(t->l)-eval(t->r);
		break;
		case MUL:
		return eval(t->l)*eval(t->r);
		break;
		case DIV:
		return eval(t->l)/eval(t->r);
		break;
		case EXP:
		return pow(eval(t->l),eval(t->r));
		break;
		case ABS:
		r = eval(t->l);
		return (r>0)?r:-r;
		break;
		case UM:
		r = eval(t->l);
		return -r;
		break;
		default:
		printf("Bad operator\n");
		break;
	}
}
int main()
{
	//yydebug = 1;
	yyparse();
	return 0;
}

yyerror(char *s)
{
	fprintf(stderr,"ERROR: %s\n",s);
}

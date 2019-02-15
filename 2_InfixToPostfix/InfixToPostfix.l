%option noyywrap nodefault yylineno case-insensitive
/* the symbol table */
%{
	
	struct etree{
		char* data;
		struct etree *l,*r;
	};
	
	struct stack1{
		int data[100];
		int t;
	};
	
	struct stack2{
		struct etree* t[100];
		int top;
	};
	
	struct stack1 s1;
	struct stack2 s2;
	
	
	void push1(char);
	void push2(struct etree*);
	char pop1();
	struct etree* pop2();
	int isEmpty1();
	int isEmpty2();
	void operator(char*);
	void operand(char*);
	void postorder(struct etree*);
	void make();
	int prec(char);
	
%}

%%
um[0-9]+			{operand(yytext);}
[0-9]+				{operand(yytext);}
[+\-*/@]			{operator(yytext);}
[\n \t]
%%

main()
{
	s1.t = -1;
	s2.top = -1;
	yylex();
	
	while(s2.top>0){
		make();
	}
	postorder(s2.t[s2.top]);
}

void push1(char x) 
{ 
	++s1.t;
    s1.data[s1.t] = x; 
    printf("[ %c ] was pushed1\n",x);
} 
  
char pop1() 
{ 
    if (s1.t < 0) { 
        //cout << "Stack Underflow"; 
        return 0; 
    } 
    else { 
        char x = s1.data[s1.t];
        printf("[ %c ] was popped1\n",x);
        s1.t--; 
        return x; 
    } 
} 
  
int isEmpty1() 
{ 
    return (s1.t < 0); 
} 

void push2(struct etree* x) 
{ 
	++s2.top;
    s2.t[s2.top] = x; 
    printf("[");
    postorder(s2.t[s2.top]);
    printf("] pushed2\n");
} 
  
struct etree* pop2() 
{ 
    if (s2.top < 0) { 
        //cout << "Stack Underflow"; 
        return 0; 
    } 
    else { 
        struct etree* t1 = s2.t[s2.top--]; 
        printf("[");
        postorder(t1);
        printf("] popped2\n");
        return t1; 
    } 
} 
  
int isEmpty2() 
{ 
    return (s2.top < 0); 
} 

void operand(char* wrd){
	printf("***(%s)",wrd);
	struct etree *t1 = malloc(sizeof(struct etree));
	t1->data = strdup(wrd);
	t1->l = t1->r = NULL;
	push2(t1);
}

int prec(char ch){
	if(ch=='+'||ch=='-')
		return 1;
	else if(ch=='*'||ch=='/')
		return 2;
	else
		return 3;
}

void make(){

	char ch = pop1();
	char *ch1 = malloc(sizeof(char));
	ch1[0] = ch;
	struct etree *t = malloc(sizeof(struct etree));
	t->data = ch1;
	t->r = pop2();
	t->l = pop2();
	push2(t);
	//printf("New tree : ");
	//postorder(t);
	//printf("\n");
}

void postorder(struct etree* t){
	if(t!=NULL){
		postorder(t->l);
		postorder(t->r);
		printf("%s ",t->data);
	}
}

void operator(char* ch){
	printf("(%s)",ch);
	
	int p1;
	if(s1.t>=0)
		p1 = prec(s1.data[s1.t]);
	else
		p1 = -1;
	int p2 = prec(ch[0]);
	
	while(p1>=p2){
		if(s1.t>=0){
			p1 = prec(s1.data[s1.t]);
			if(p1==3 && p1==p2)
				break;
			make();
		}
		else
			p1 = -1;
		//p2 = prec(ch[0]);
	}
	push1(ch[0]);
	
}
	

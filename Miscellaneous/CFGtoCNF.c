/* program to convert a grammar to CNF form */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct rules
{
	char Var;
	char* Der[100];
	int n;
};

void insert(char* input,struct rules* a,int* sz)
{
	for(int i=0;i<*sz;i++)
	{
		if(input[0]==a[i].Var)
		{
			a[i].Der[a[i].n] = NULL;
			a[i].Der[a[i].n] = (char*)malloc(sizeof(char));
			strcpy(a[i].Der[a[i].n],input+1);
			a[i].n++;
			return;
		}
	}
	a[*sz].Var = input[0];
	a[*sz].Der[0] = (char*)malloc(sizeof(char));
	strcpy(a[*sz].Der[0],input+1);
	a[*sz].n++;
	(*sz)++;
}

int contains_null(struct rules a)
{
	for(int i=0;i<a.n;i++)
	{
		if(strcmp(a.Der[i],"#")==0)
			return i+1;
	}
	return 0;
}

void remove_null(struct rules* a,int i,int m,int k)
{
	for(int j=0;j<m;j++)
	{
		if(j==i)
		{

		}
	}
}

int main(int argc, char const *argv[])
{
	char input[20];
	int n,m,sz;
	printf("How many non-termnals?\n");
	scanf("%d",&m);
	struct rules a[m];sz = 0;
	for(int i=0;i<m;i++)
		a[i].n = 0;
	printf("How many rules?\n");
	scanf("%d",&n);
	printf("Enter the rules, enter # for a null production\n");
	for(int i=0;i<n;i++)
	{
		scanf("%s",input);
		insert(input,a,&sz);
	}
	// for(int i=0;i<m;i++)
	// {
	// 	printf("%c --> ",a[i].Var);
	// 	for(int j=0;j<a[i].n;j++)
	// 	{
	// 		printf("%s | ",a[i].Der[j]);
	// 	}
	// 	printf("\n");
	// }

	// at first e-Productions are to be removed

	for(int i=0;i<m;i++)
	{
		if(contains_null(a[i]))
		{
			remove_null(a,i,m);
		}
	}


	return 0;
}
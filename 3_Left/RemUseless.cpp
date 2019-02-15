#include<bits/stdc++.h>
using namespace std;
int main()
{
	char input[100],tempprod[100];
	char *l,*r,*temp;
	int i=0,j=0,flag=0;
	// printf("Enter the productions: ");
	cout<<"Enter the productions: ";
	cin>>input;
	l = strtok(input,"->");
	r = strtok(NULL,"->");
	temp = strtok(r,"|");
	vector<string> useful;
	string l1(l),r1(r),temp1(temp);
	while(temp){
		int flag=0;

		for(int i=0;i<temp1.length();i++){
			if(!islower(temp1[i])) flag=1;
		}
		if(flag==0) useful.push_back(temp1);
		temp=strtok(NULL,"|");
	}
	for(auto it: useful)
		cout<<it<<endl;
}

#include <stdio.h>
#include <string.h>

int state,operation,validity,rewindcount,memoswitch;
int memo[4][4][6];
int tmpint,tmpint1,tmpint2,tmpint3;
char item[6];
int price[6],quantity[6];
char tmpchar;
int cost;

void eventcheck();
void memowind();
void memorewind();
void place();
void select();
void pay();
void change();
void clear_buffer();
//void displayvalues();//可以注释掉的内容

int main(void)
{
    while(202413456)
    {
        if(state!=3)
        {
            eventcheck();
        }
        if(validity==1)
        {
            switch (state)
            {
                case 0:
                    place();
                    break;
                case 1:
                    select();
                    break;
                case 2:
                    pay();
                    break;
                case 3:
                    change();
                    break;
            }
            if(memoswitch==0)
            {
                memo[0][0][0]=1;
                memo[0][0][1] = 2;
                memoswitch = 1;
            }
            memowind();
        }
        //rewindcount = 0;//需要注释掉的内容
        //displayvalues();//需要注释掉的内容
    }

    return 0;
}

void eventcheck()
{
    char tmp[5];
    validity= 0;
    tmpint,tmpint1,tmpint2,tmpint3 = 0;
    tmpchar = '\0';
    if(state==-1)
        state++;
    if(scanf("%4s",tmp)==1)
    {
        if(!strcmp(tmp,"END"))
        {
            if(state>=2)
                printf("当前步骤不能跳过,");
            else if(!operation)
                printf("操作后才能进行下一步，");
            else
            {
                state++;
                operation = 0;
                validity = 2;
                clear_buffer();
                memowind();
            }
        }
        if(!strcmp(tmp,"BACK"))
        {
            memorewind();
            clear_buffer();
        }
        if(strlen(tmp)==1)
        {
            if((tmp[0]>='A' )&&( tmp[0]<='Z' )&& (state == 0||1))
            {
                tmpchar = tmp[0];
                validity = 1;
            } 
            if((tmp[0]>='0' )&& (tmp[0]<='9')&& (state == 2))
            {
                tmpint = tmp[0]-'0';
                validity = 1;
            }
        }
    }
    if(!validity)
    {
        printf("输入错误，请重新输入。\n");
        clear_buffer();
    }
}

void memowind()
{
    for(int j = 0;j < 4;j++)
    {
        for(int k = 0;k < 6;k++)
        {
            for(int i = 3;i > 0;i--)
                memo[i][j][k] = memo[i-1][j][k];
        }
    }
    memo[0][0][0]=1;
    if(state==3)
        memo[0][0][1] = 1;
    memo[0][0][2] = state;
    memo[0][0][3] = operation;
    memo[0][0][4] = cost;
    memo[1][0][5] = tmpint;
    for(int i = 1;i<6;i++)
        memo[0][1][i] = (int)item[i];
    for(int i = 1;i<6;i++)
        memo[0][2][i] = price[i];
    for(int i = 1;i<6;i++)
        memo[0][3][i] = quantity[i];
}

void memorewind()
{
    if(rewindcount>2)
        printf("回退次数已经达到上限，不能回退。\n");
    else if(memo[1][0][0]==0)
        printf("没有可回退的操作。\n");
    else if(memo[1][0][1]==1)
        printf("该操作不能回退。\n");
    else if(memo[1][0][0]==1)
        {
            if(memo[1][0][1]==1)
            {
                printf("该操作不能回退。\n");
            }
            state = memo[1][0][2];
            operation = memo[1][0][3];
            cost = memo[1][0][4];
            if(memo[1][0][5]!=0)
                printf("%d\n",memo[1][0][5]);
            for(int i = 1;i<6;i++)
                item[i] = (char)memo[1][1][i];
            for(int i = 1;i<6;i++)
                price[i] = memo[1][2][i];
            for(int i = 1;i<6;i++)
                quantity[i] = memo[1][3][i];
        }
        for(int j = 0;j < 4;j++)
        {
            for(int k = 0;k < 6;k++)
            {
                for(int i = 0; i <3;i++)
                    memo[i][j][k] = memo[i+1][j][k];
            }  
        }
        for(int n = 3; n>=0; n--)
        {
            if(memo[n][0][0]==1)
            {
                if(memo[n][0][1]==2)
                    break;
                else
                {
                    memo[n][0][0]=0;
                    break;
                }
            }
        }
    rewindcount++;
    validity = 3;
}

void place()
{
    _Bool validity = 1;
    if(scanf("%d %d %d",&tmpint1,&tmpint2,&tmpint3)!=3)
        validity = 0;
    else
    {
        if(tmpint1<1||tmpint1>5)
        {
            validity = 0;
            printf("通道编号错误，");
        }
        else if(item[tmpint1]!='\0')
        {
            validity = 0;
            printf("该通道已被占用，");
        }

        if(tmpint2<0||tmpint2>9)
        {
            validity = 0;
            printf("价格不在规定范围内，");
        }

        if(tmpint3<1||tmpint3>50)
        {
            validity = 0;
            printf("数量不在规定范围内，");
        }
    }
    if (validity)
    {
        item[tmpint1] = tmpchar;
        price[tmpint1] = tmpint2;
        quantity[tmpint1] = tmpint3;
        operation++;
    }
    else
        printf("请重新输入。\n");
    clear_buffer();
}

void select()
{
    _Bool validity = 1;
    if(scanf("%d %d",&tmpint1,&tmpint2)!=2)
    {
        printf("输入错误，");
        validity = 0;
    }
    else
    {
        if(tmpint1<1||tmpint1>5)
        {
            validity = 0;
            printf("该通道不存在，");
        }
        else if(item[tmpint1]=='\0')
        {
            validity = 0;
            printf("该通道没有商品，");
        }
        else if(tmpchar!=item[tmpint1])
        {
            validity = 0;
            printf("选择的商品与通道内商品不同，");
        }
        
        if(validity==1 && (tmpint2<1||tmpint2>quantity[tmpint1]))
        {
            validity = 0;
            printf("无法购买这一数量的商品，");
        }
    }
    if(validity)
    {
        cost += price[tmpint1]*tmpint2;
        quantity[tmpint1] -= tmpint2; 
        operation++;
        if(quantity[tmpint1]==0)
        {
            item[tmpint1] = 0;
            price[tmpint1] = 0;
        }
    }
    else
        printf("请重新输入。\n");
    clear_buffer();
}

void pay()
{
    if(tmpint==1||tmpint==2||tmpint==5)
    {
        cost-=tmpint;
        operation++;
    }
    else
        printf("%d\n投币面额错误，请重新输入。\n",tmpint);
    if(cost<=0)
    {
        state++;
    }
    clear_buffer();
}

void change()
{
    while(cost<0)
    {
        if(cost<-4)
        {
            printf("%d\n",5);
            cost += 5;
            continue;
        }
        else if(cost<-1)
        {
            printf("%d\n",2);
            cost += 2;
            continue;
        }
        else
        {
            printf("%d\n",1);
            cost += 1;
            break;
        }
    }
    state = 1;
}

void clear_buffer()
{
    while(getchar() != '\n')
        continue;
}

/*void displayvalues()//可以注释掉的内容
{
    printf("\n***\n");
    printf("state = %d, operation = %d, cost = %d,rewindcount = %d\n\n",state,operation,cost,rewindcount);
    printf("%8s\t%d\t%d\t%d\t%d\t%d\n","channel",1,2,3,4,5);
    printf("%8s\t","item");
    for(int i=1;i<6;i++)
        printf("%c\t",item[i]);
    printf("\n");
    printf("%8s\t","price");
    for(int i=1;i<6;i++)
        printf("%d\t",price[i]);
    printf("\n");
    printf("%8s\t","quantity");
    for(int i=1;i<6;i++)
        printf("%d\t",quantity[i]);
    printf("\n\nmemory:\n");
    for(int i = 0;i<4;i++)
    {
        for(int j = 0; j < 4;j++)
        {
            for(int k=0 ; k < 6; k++)
                printf("%d\t",memo[i][j][k]);
            printf("\n");
        }
        printf("\n");
    }
    printf("\n***\n\n");
}
*/
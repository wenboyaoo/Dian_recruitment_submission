#include <stdio.h>
#include <string.h>

int state,operation,validity;
int memo[3][6];
int rewindcount,tmpint,tmpint1,tmpint2,tmpint3;
char item[6];
int price[6],quantity[6];
char tmpchar;
int cost;

void eventcheck();
void memowind(int varstate,int varchannel,int varquantity, int varcost,int varoperation,int varitem);
void memorewind();
void place();
void select();
void pay();
void change();
void clear_buffer();

int main(void)
{
    printf("输入\"BACK\"以回退。\n");
    while(202413456)
    {
        if(state!=3)
            eventcheck();
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
        }
        /*printf("\n***\nstate %d, operation %d, cost %d, rewindcount%d",state,operation,cost,rewindcount);
        printf("\nitem:\n");
        for(int i = 0;i<6;i++)
            printf("%c ",item[i]);
        printf("\nprice:\n");
        for(int i = 0;i<6;i++)
            printf("%d ",price[i]);
        printf("\nquantity:\n");
        for(int i = 0;i<6;i++)
            printf("%d ",quantity[i]);
        printf("\n\n");
       for(int j = 0;j < 3;j++)
            {
                printf("%d ",memo[j][0]);
            }
        printf("\n");*/
        
    }

    return 0;
}

void eventcheck()
{
    char tmp[5];
    validity= 0;
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
                memowind(1,0,0,0,-operation,0);
                operation = 0;
                validity = 2;
                //printf("now proceeds to state %d\n",state);
                clear_buffer();
            }
        }
        if(!strcmp(tmp,"BACK"))
        {
            memorewind();
            clear_buffer();
        }
        if(strlen(tmp)==1)
        {
            //printf("judged as single character\n");
            if((tmp[0]>='A' )&&( tmp[0]<='Z' )&& (state == 0||1))
            {
                tmpchar = tmp[0];
                //printf("tmpchar is assigned the value %c\n",tmpchar);
                validity = 1;
            } 
            if((tmp[0]>='0' )&& (tmp[0]<='9')&& (state == 2))
            {
                tmpint = tmp[0]-'0';
                //printf("tmpint is assigned the value %d\n",tmpint);
                validity = 1;
            }
        }
    }
    if(!validity)
    {
        printf("输入错误，请重新输入。\n");
        //printf("at eventcheck\n");
        clear_buffer();
    }
    //printf("the value of tmp is %s\n",tmp);
}

void memowind(int varstate,int varchannel,int varquantity, int varcost,int varoperation,int varitem)
{
    for(int i = 0;i < 6;i++)
    {
        for(int j = 1;j < 3;j++)
            {
                memo[j][i] = memo[j-1][i];
            }
    }
    memo[0][0] = 1;
    memo[0][1] = varstate;
    memo[0][2] = varchannel;
    memo[0][3] = varquantity;
    memo[0][4] = varcost;
    memo[0][5] = varoperation;
    memo[0][6] = varitem;
}

void memorewind()
{
    if(rewindcount >= 3)
    {
        printf("回退次数过多。\n");
        validity = -1;
    }
    else
    {
        if(memo[0][0] == 0)
        {
            printf("没有可回退的操作。\n");
            validity = -1;
        }
        else if(memo[0][1]==-1)
        {
            printf("该步骤不可回退。\n");
            validity = -1;
        }
        else
        {
            state -= memo[0][1];
            if(item[memo[0][2]]==0)
                item[memo[0][2]] = (char)memo[0][6];
            quantity[memo[0][2]] -= memo[0][3];
            cost -= memo[0][4];
            if(memo[0][4]!=0)
            {
                printf("%d",memo[0][4]);
            }
            operation -=memo[0][5];

            for(int i = 0;i < 6;i++)
            {
                for(int j = 0;j < 2;j++)
                {
                    memo[j][i] = memo[j+1][i];
                }
            }
            for(int i=1;i<6;i++)
                memo[2][i]= 0;
            validity = 2;
            rewindcount++;
        }
    }
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
        memowind(0,tmpint1,tmpint3,0,1,(int)tmpchar);
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
        memowind(0,tmpint1,-tmpint2,price[tmpint1]*tmpint2,1,(int)tmpchar);
        operation++;
        if(quantity[tmpint1]==0)
            item[tmpint1] = 0;
        //printf("cost changed to %d\n",cost);
    }
    else
        printf("请重新输入。\n");
        //printf("at select\n");
    clear_buffer();
}

void pay()
{
    if(tmpint==1||tmpint==2||tmpint==5)
    {
        cost-=tmpint;
        memowind(0,0,0,-tmpint,1,0);
        operation++;
        //printf("cost changed to %d\n",cost);
    }
    else
        printf("%d\n投币面额错误，请重新输入。\n",tmpint);
    if(cost<=0)
    {
        state++;
        printf("now proceeds to state %d\n",state);
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
    cost = 0;
    state = 1;
    memowind(-1,0,0,0,0,0);
    //printf("now proceeds to state %d\n",state);
}

void clear_buffer()
{
    while(getchar() != '\n')
        continue;
}
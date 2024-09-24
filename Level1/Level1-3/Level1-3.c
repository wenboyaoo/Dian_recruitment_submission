#include <stdio.h>
#include <string.h>

int state;
char item;
int channel,price,quantity;
char name;
int amount,choice;
int cash = 0,cost = 0;
_Bool validity;

void eventcheck();
void place();
void select();
void pay();
void change();
void clear_buffer();

int main(void)
{
    place();
    state = 1;
    while(202413456)
    {
        eventcheck();
        while(state!= 2)
        {
            if(state==3)
            {
                printf("请先选择货物。\n");
                clear_buffer();
            }
            eventcheck();
        }

        do
        {
            switch (state)
            {
            case 2:
                select();
                state = 0;
                break;
            
            case 3:
                pay();
                state = 0;
                break;
            }
            if(cost>0)
                eventcheck();
        }while(cost>0);
        change();
    }
    
        return 0;
}

void eventcheck()
{
    char tmp[5];
    state = 0;
    if(scanf("%4s",tmp)==1&&strlen(tmp)==1)
    {
        if(tmp[0]>='A' && tmp[0]<='Z')
        {
            name = tmp[0];
            state = 2;
            //printf("state switched to 2\n");
        } 
        if(tmp[0]>='0' && tmp[0]<='9')
        {
            cash = tmp[0]-'0';
            state = 3;
            //printf("state switched to 3\n");
        }
    }
    else
    {
        printf("输入错误，请重新输入。\n");
        clear_buffer();
        state = -1;
    }
}

void place()
{
    do
    {
        validity = 1;
        while(scanf("%c %d %d %d",&item,&channel,&price,&quantity)!=4)
        {
            printf("输入内容有误，请重新输入。\n");
            clear_buffer();
        }
        if(item<'A'||item>'Z')
        {
            validity = 0;
            printf("商品名称错误，");
        }
        if(channel<1||channel>5)
        {
            validity = 0;
            printf("通道编号错误，");
        }
        if(price<0||price > 9)
        {
            validity = 0;
            printf("价格不在规定范围内，");
        }
        if(quantity<1||quantity>50)
        {
            validity = 0;
            printf("数量不在规定范围内，");
        }
        if(!validity)
        {
            printf("请重新输入。\n");
        }
        clear_buffer();
    }while(!validity);
}

void select()
{
    if(scanf("%d %d",&choice,&amount)==2)
    {
        validity = 1;
        if(name != item)
        {
            printf("商品种类不一致，");
            validity = 0;
        }
        if(choice != channel)
        {
            printf("通道编号不一致，");
            validity = 0;
        }
        if(validity==1 && (amount<1||amount>quantity))
        {
            printf("无法购买这一数量的商品，");
            validity = 0;
        }
        if(validity)
        {
            cost += price*amount;
            quantity -= amount; 
            //printf("cost changed to %d\n",cost);
        }
        else
            printf("请重新输入\n");
    }
    else
    {
        printf("输入错误，请重新输入。\n");
    }
    clear_buffer();
}

void pay()
{
    if(cash==1||cash==2||cash==5)
        cost-=cash;
    else
        printf("%d\n投币面额错误，请重新输入。\n",cash);
    clear_buffer();
    //printf("cost changed to %d\n",cost);
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
}

void clear_buffer()
{
    while(getchar() != '\n')
        continue;
}

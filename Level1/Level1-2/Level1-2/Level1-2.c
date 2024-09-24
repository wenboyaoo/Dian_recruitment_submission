#include <stdio.h>
int cost,cash;
_Bool validity;
void clear_buffer();
int main(void)
{
    validity = 0;
    while(!validity)
    {
        validity = 1;
        while(scanf("%d",&cost)!=1)
        {
            printf("输入内容有误，请重新输入。\n");
            clear_buffer();
        }
        if(cost<0||cost>2250)
        {
            validity = 0;
            printf("总价不在规定范围内，请重新输入。\n");
            clear_buffer();
        }
    }
    validity = 0;
    while(cost>0)
    {
        validity = 0;
        while(!validity)
        {
            validity = 1;
            while(scanf("%d",&cash)!=1)
            {
                printf("输入内容有误，请重新输入。\n");
                clear_buffer();
            }
            if(!(cash==1||cash==2||cash==5))
            {
                validity = 0;
                printf("%d\n投币面额错误。\n",cash);
                clear_buffer();
            }
        }
        cost -= cash;
    }
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
    

    return 0;
}
void clear_buffer()
{
    while(getchar() != '\n')
        continue;
}
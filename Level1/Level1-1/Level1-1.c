#include <stdio.h>
#include <ctype.h>
char item;
int channel,price,quantity;
_Bool validity;
void clear_buffer();
int main(void)
{
    while(!validity)
    {
        validity = 1;
        while(scanf("%c %d %d %d",&item,&channel,&price,&quantity)!=4)
        {
            printf("输入内容有误，请重新输入。\n");
            clear_buffer();
        }
        if(!isupper((int)item))
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
            printf("请重新输入。\n");
        clear_buffer();
    }
    printf("%d:",channel);
    for(int i = 0;i<quantity;i++)
        printf("%c",item);
    printf(" %d",price);

    return 0;
    
}
void clear_buffer()
{
    while(getchar() != '\n')
        continue;
}
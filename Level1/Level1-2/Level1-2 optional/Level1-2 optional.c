#include <stdio.h>
#include <stdlib.h>
int cost,cash;
_Bool validity;
void clear_buffer();
char path[261];
FILE *fp;
int main(void)
{
    printf("请输入.txt文件的路径，如 D:\\input.txt\n");
    while(scanf("%260s",path)!=1)
    {
        printf("输入错误，请重新输入");
        clear_buffer();
    }
    if((fp = fopen(path,"r")) == NULL)
    {
        printf("文件打开错误。\n");
        exit(EXIT_FAILURE);
    }
    if(fscanf(fp,"%d",&cost)!=1)
    {
        printf("总价内容有误。\n");
        fclose(fp);
        exit(0);
    }
    if(cost<0||cost>2250)
    {
        printf("总价不在规定范围内。\n");
        fclose(fp);
        exit(0);
    }
    while(cost>0)
    {
    
        if(fscanf(fp,"%d",&cash)!=1)
        {
            printf("投币内容有误。\n");
            fclose(fp);
        }
        if(!(cash==1||cash==2||cash==5))
        {
            validity = 0;
            printf("%d\n投币面额错误。\n",cash);
            fclose(fp);
            exit(0);
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
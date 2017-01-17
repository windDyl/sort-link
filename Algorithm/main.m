//
//  main.m
//  Algorithm
//
//  Created by Ethank on 16/7/12.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <GLUT/GLUT.h>
////冒泡
//void bubble_sort(int a[], int length);
////选择
//void selection_sort (int a[], int length);
////插入排序
//void insert_sort (int a[], int length);
//void insert (int a[], int length);
////输出
//void printArray (int a[], int length);
//
////快速排序
//void quick_sort (int a[], int length);
//
////堆排序
//void heap_sort (int a[], int length);
//

//冒泡
void bubble_sort(int a[], int length) {
    int temp;
    for (int i = 0; i < length; i++) {
        for (int j = 0; j < length - 1 - i; j++) {
            temp = a[j];
            if (a[j] > a[j+1]) {
                a[j] = a[j+1];
                a[j+1] = temp;
            }
        }
    }
}

//选择
void selection_sort (int a[], int length) {
    int temp;
    for (int i = 0; i < length - 1; i++) {
        int index = i;//最小值对应下标
        for (int j = i + 1; j < length; j++) {
            if (a[j] < a[index]) {
                index = j;
            }
        }
        if (index != i) {
            temp = a[i];
            a[i] = a[index];
            a[index] = temp;
        }
    }
}

//插入排序
void insert_sort (int a[], int length) {
    int temp, j;
    for (int i = 1; i < length; i++) {
        temp = a[i];
        for (j = i; j > 0 && a[j - 1] > temp; j--) {
            a[j] = a[j - 1];
        }
        a[j] = temp;
    }
}

void insert(int a[], int length) {
    int temp;
    for (int i = 1; i < length; i++) {
        for (int j = i; j > 0; j--) {
            if (a[j] < a[j-1]) {
                temp = a[j];
                a[j] = a[j-1];
                a[j-1] = temp;
            }
        }
    }
}

//快速排序
void quick_sort (int a[], int length) {
    void sort (int *a, int left, int right);
    sort(a, 0, length - 1);
}

void sort (int *a, int left, int right) {
    if (left > right) {
        return;
    }
    int i = left;
    int j = right;
    int key = a[left];
    while (i < j) {
        while (i < j && key <= a[j]) {
            j--;
        }
        a[i] = a[j];
        while (i < j && key >= a[i]) {
            i++;
        }
        a[j] = a[i];
    }
    a[i] = key;
    sort(a, left, i-1);
    sort(a, i+1, right);
}

//堆排序
void heapAdjust (int a[], int i, int nLength);
void heap_sort (int a[], int length) {
    int i;
    //调整序列的前半部分元素，调整完之后第一个元素是序列的最大的元素
    //length/2-1是最后一个非叶节点，此处"/"为整除
    for (i = length/2 -1; i >= 0; i--) {
        heapAdjust (a, i, length);
    }
    //从最后一个元素开始对序列进行调整，不断的缩小调整的范围直到第一个元素
    for (i = length - 1; i > 0; i--) {
        //把第一个元素和当前的最后一个元素交换，
        //保证当前的最后一个位置的元素都是在现在的这个序列之中最大的
        a[i] = a[0]^a[i];
        a[0] = a[0]^a[i];
        a[i] = a[0]^a[i];
        //不断缩小调整heap的范围，每一次调整完毕保证第一个元素是当前序列的最大值
        NSLog(@"======== %d =========", i);
        heapAdjust(a, 0, i);
    }
}
/**
 *  如果较大的子结点大于父结点那么把较大的子结点往上移动，替换它的父结点
 */
void heapAdjust (int a[], int i, int nLength) {
    int nChild;
    int nTemp;
    for (; 2*i + 1 < nLength; i = nChild) {
        //子结点的位置=2*（父结点位置）+1
        nChild = 2*i + 1;
        //得到子结点中较大的结点
        if (nChild<nLength-1 && a[nChild + 1] > a[nChild]) {
            nChild++;
        }
        //如果较大的子结点大于父结点那么把较大的子结点往上移动，替换它的父结点
        if (a[i] < a[nChild]) {
            nTemp = a[i];
            a[i] = a[nChild];
            a[nChild] = nTemp;
        }
        else break; //否则退出循环
    }
}

/**
 *  
 */

void printArray (int a[], int length) {
    for (int i = 0; i < length; i++) {
        printf("%d\n", a[i]);
    }
}




/**
 *  链表的基本使用
 */
//=============================链表====================================

#include "stdlib.h"

#define LEN sizeof(struct student)

struct student {
    int num;          //学号
    float score;       //分数，其他信息可以继续在下面增加字段
    struct student *next; //指向下一节点的指针
};

int n;  //节点总数

/**
 *  功能：创建n个节点的链表
 *  返回：指向链表表头的指针
 */
struct student * Create() {
    struct student *head;       //头节点
    struct student *p1 = NULL;  //p1保存创建的新节点的地址
    struct student *p2 = NULL;  //p2保存原链表最后一个节点的地址
    
    n = 0;          //创建前链表的节点总数为0：空链表
    p1 = (struct student *) malloc (LEN);   //开辟一个新节点
    p2 = p1;            //如果节点开辟成功，则p2先把它的指针保存下来以备后用
    
    if(p1==NULL) {//节点开辟不成功
        printf ("\nCann't create it, try it again in a moment!\n");
        return NULL;
    } else {//节点开辟成功
        head = NULL;        //开始head指向NULL
        printf ("Please input %d node -- num,score: ", n + 1);
        scanf ("%d %f", &(p1->num), &(p1->score));    //录入数据
    }
    while(p1->num != 0) {//只要学号不为0，就继续录入下一个节点
        n += 1;         //节点总数增加1个
        if(n == 1) { //如果节点总数是1，则head指向刚创建的节点p1
            head = p1;
            p2->next = NULL;  //此时的p2就是p1,也就是p1->next指向NULL。
        } else {
            p2->next = p1;   //指向上次下面刚刚开辟的新节点
        }
        
        p2 = p1;            //把p1的地址给p2保留，然后p1产生新的节点
        
        p1 = (struct student *) malloc (LEN);
        printf ("Please input %d node -- num,score: ", n + 1);
        scanf ("%d %f", &(p1->num), &(p1->score));
    }
    p2->next = NULL;     //此句就是根据单向链表的最后一个节点要指向NULL
    
    free(p1);           //p1->num为0的时候跳出了while循环，并且释放p1
    p1 = NULL;          //特别不要忘记把释放的变量清空置为NULL,否则就变成"野指针"，即地址不确定的指针
    return head;        //返回创建链表的头指针
}

/**
 *  功能：输出节点
 *  返回： void
 */

void Print(struct student *head) {
    struct student *p;
    printf ("\nNow , These %d records are:\n", n);
    
    p = head;
    if(head != NULL)        //只要不是空链表，就输出链表中所有节点
    {
        printf("head is %p\n\n", head);    //输出头指针指向的地址
        printf ("Address        Num       Score      Next-Address\n");
        do {
            /*
             输出相应的值：当前节点地址、各字段值、当前节点的下一节点地址。
             这样输出便于读者形象看到一个单向链表在计算机中的存储结构，和我们
             设计的图示是一模一样的。
             */
            printf ("%p   %05d      %3.1f      %p\n", p, p->num, p->score, p->next);
            p = p->next;     //移到下一个节点
        }
        while (p != NULL);
        printf("\n");
        
        struct student *q;
        q = head;
        while (q->next != NULL) {
            /*
             输出相应的值：当前节点地址、各字段值、当前节点的下一节点地址。
             这样输出便于读者形象看到一个单向链表在计算机中的存储结构，和我们
             设计的图示是一模一样的。
             */
            printf ("%05d->",q->num);
            q = q->next;     //移到下一个节点
        }
        
        printf("%05d\n", q->num);
    }
}






















/**
 *  返回数组类型时可以用返回指针来替代， 指针指向某元素的地址（一般返回首地址）
 */
int * myArray() {
    int *p;
    int i[10] = {100,200,40,30};
    p = &i[1];
    return p;
}
//=====================OPENGL======================


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
//        int a[] = {13, 11, 35, 10, 3, 8, 26, 50,32, 24,57};
//        int length = sizeof(a)/sizeof(int);
        //冒泡排序
        //        bubble_sort(a, length);
        //        pao(a, length);
        //选择排序
        //        selection_sort(a, length);
        //插入排序
        //        insert_sort(a, length);
        //        insert(a, length);
        //快速排序
        //        quick_sort(a, length);
        
        //堆排序
        //        heap_sort(a, length);
        //        void heapSort (int a[], int length);
        //输出
        //        printArray(a, length);
        
//        //创建链表
//        Print(Create());
        
        //接受返回的指针
//        int *q = myArray();
//        printf("%p\n%d\n", &q, *(q-1));
        
    }
    return 0;
}

//
//  EEEditView.m
//  EJing
//
//  Created by 123 on 16/4/22.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EEEditView.h"
#import "EEWriteView.h"
#import "defineHead.h"
@implementation EEEditView{
    NSString *path;
    NSMutableArray *dataArray;
    UIButton *editButton;
    EEWriteView *write;
    float startPoint;
    float endPoint;
}
+(EEEditView *)shareInstance{
    static EEEditView *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance=[[self alloc] init];
    });
    return instance;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    return self;
}

- (void)createWith:(NSString *)name indexPath:(int)index{
    //获取编辑界面的文件信息
    path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.plist"];
    dataArray=[NSMutableArray arrayWithContentsOfFile:path];
    //用于获取编辑的参数
    indexNum=index;
    UIImageView *backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    backgroundView.frame=CGRectMake(0, 0, screenWidth, screenHeight);
    [self addSubview:backgroundView];

    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(20, 25, 45, 30)];
    back.layer.cornerRadius=4;
    back.backgroundColor=[UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
    [back setTitle:@"Back" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(BackToBack:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:back];
    
    headLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 75, screenWidth-40,100)];
    headLabel.text=name;
    headLabel.numberOfLines=0;
    [headLabel sizeToFit];
    headLabel.backgroundColor=[UIColor redColor];
   
    write=[EEWriteView shareInstance];
    [write setFrame:self.frame];
    //标题的文字，哪一卦的卦辞
    [self addSubview:headLabel];
    [self addShowTextView];

}
-(void)addShowTextView{
//    editTextView=[[EEShowTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headLabel.frame)+30, screenWidth,screenHeight-CGRectGetMinY(editTextView.frame))];
    editTextView=[[EEShowTextView alloc] init];
    editTextView.delegate=self;
    if(dataArray.count!=0){
        editTextView.text=[[dataArray objectAtIndex:indexNum] objectForKey:@"text"];
    }
    editTextView.editable=NO;
    editTextView.font=[UIFont boldSystemFontOfSize:18];
    editTextView.alpha=0.5;
    //定义编辑按钮
    editButton=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-80, self.frame.size.height+80 , 40 , 40)];
    editButton.layer.cornerRadius=10;
    editButton.backgroundColor=[UIColor greenColor];
    [editButton addTarget:self action:@selector(isEditable:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:editTextView];
    [self addSubview: editButton];
    PREPCONSTRAINTS(editTextView);
    STRETCH_VIEW_H(self, editTextView);
    CONSTRAIN_VIEWS(self, @"V:[headLabel]-30-[editTextView]|",NSDictionaryOfVariableBindings(headLabel,editTextView));
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(changeShowText:) name:@"123" object:nil];
    [center addObserver:self selector:@selector(addButton) name:@"touch" object:nil];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    startPoint=editTextView.contentOffset.y;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    endPoint=editTextView.contentOffset.y;
    if(endPoint>startPoint&&endPoint-startPoint>20){
        [self hideButton];
    }else if (endPoint<startPoint&&startPoint-endPoint>20){
        [self addButton];
    }
}
//改变展示编辑的界面
-(void)changeShowText:(NSNotification *)text{
    editTextView.text=[text.userInfo objectForKey:@"text"];
}
//返回显示界面
-(void)BackToBack:(id)sender{
    [self removeFromSuperview];
}
-(void)isEditable:(id)sender{
    [write createWriteView:indexNum];
    [self addSubview:write];
}


-(void)addButton{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.3];
    editButton.frame=CGRectMake(self.frame.size.width-80, self.frame.size.height-80 , 40 , 40);
    [UIView commitAnimations];
}
-(void)hideButton{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.3];
    editButton.frame=CGRectMake(self.frame.size.width-80, self.frame.size.height+80 , 40 , 40);
    [UIView commitAnimations];
    
}
@end

//
//  EEWriteView.m
//  EJing
//
//  Created by 陈海岩 on 16/4/24.
//  Copyright © 2016年 陈海岩. All rights reserved.
//

#import "EEWriteView.h"
#import "defineHead.h"
#import "EESpaceView.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@implementation EEWriteView{
    int writeIndex;
    NSString *path;
    UITextView *writeText;
    NSMutableArray *dataArray;
    float keyboarHeight;

}
+(EEWriteView*)shareInstance{
    static EEWriteView *instance;
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
-(void)createWriteView:(int)index{
    writeIndex=index;
    path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.plist"];
    dataArray=[NSMutableArray arrayWithContentsOfFile:path];
    
    UIView *headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    headView.backgroundColor=[UIColor greenColor];
    UIButton *saveButton=[[UIButton alloc] initWithFrame:CGRectMake(20, 10, 40, 30)];
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    saveButton.backgroundColor=[UIColor redColor];
    [saveButton addTarget:self action:@selector(savaAndBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *doneButton=[[UIButton alloc] initWithFrame:CGRectMake(screenWidth-60, 10, 50, 30)];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    doneButton.backgroundColor=[UIColor redColor];
    [doneButton addTarget:self action:@selector(afterEdit) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:saveButton];
    [headView addSubview:doneButton];
    [self addSubview:headView];
    
    UIView *writeTextParent=[[UIView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, screenHeight-50)];
    writeText=[[UITextView alloc] initWithFrame:writeTextParent.frame];
    writeText.backgroundColor=[UIColor whiteColor];
    writeText.delegate=self;
    writeText.editable=YES;
    
    writeText.tag=101;
    writeText.font=[UIFont boldSystemFontOfSize:25];
    writeText.text=[[dataArray objectAtIndex:writeIndex] objectForKey:@"text"];
   // writeText.contentSize
    
    [writeTextParent addSubview:writeText];
    [self addSubview:writeTextParent];
    //[self addSubview:writeText];
    
    //把writeText的故事版自动约束设置成No，这样可以手动编辑约束。
    PREPCONSTRAINTS(writeText);
    //把writeText充满整个的父视图，建立水平的约束。
    STRETCH_VIEW_H(writeTextParent, writeText);
    //Create a spacer
    EESpaceView *spacer = [EESpaceView installToView:writeTextParent];
    
    //Place the spacer under the text view
    CONSTRAIN_VIEWS(writeTextParent, @"V:|[writeText][spacer]|", NSDictionaryOfVariableBindings(writeText, spacer));
}

-(void)savaAndBack{
    //获取编辑界面的文件
    NSString *numStr=[[dataArray objectAtIndex:writeIndex] objectForKey:@"num"];
    NSMutableDictionary *replaceDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:numStr,@"num",writeText.text,@"text", nil];
    [dataArray replaceObjectAtIndex:writeIndex withObject:replaceDic];
    [dataArray writeToFile:path atomically:YES];
    [self removeFromSuperview];
    NSNotification *notice=[[NSNotification alloc] initWithName:@"123" object:nil userInfo:[NSDictionary dictionaryWithObject:writeText.text forKey:@"text"]];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}
-(void)afterEdit{
    [writeText resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

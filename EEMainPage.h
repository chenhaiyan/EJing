//
//  EEMainPage.h
//  EJing
//
//  Created by 123 on 16/4/7.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EEMainPage : UIView
@property(nonatomic,assign) int up;
@property(nonatomic,assign) int down;
-(void)create;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)removeAnimation; // 删除动画
-(void)addAnimation; // 添加动画
-(void)startAnimation:(int)duration repeat:(int)count; // 重定义动画速度，重复次数
-(void)changePictureUp;  //替换卦图片
-(void)getToCenter; //向中心冲卦象
@end

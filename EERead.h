//
//  EERead.h
//  EJing
//
//  Created by 123 on 16/3/28.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EERead : UIViewController<UIScrollViewDelegate>
@property(nonatomic,strong) UIButton *back;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UILabel *headLabel;
@property(nonatomic,assign) int number;
@end

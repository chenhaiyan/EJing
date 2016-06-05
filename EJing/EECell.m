//
//  EECell.m
//  EJing
//
//  Created by 123 on 16/3/24.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EECell.h"
//+ (UIColor *)blackColor;      // 0.0 white
//+ (UIColor *)darkGrayColor;   // 0.333 white
//+ (UIColor *)lightGrayColor;  // 0.667 white
//+ (UIColor *)whiteColor;      // 1.0 white
//+ (UIColor *)grayColor;       // 0.5 white
//+ (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB
//+ (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB
//+ (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB
//+ (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB
//+ (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB
//+ (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB
//+ (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB
//+ (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
//+ (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB
//+ (UIColor *)clearColor;      // 0.0 white, 0.0 alpha
//

@implementation EECell
- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        UIImageView *imageview=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackground"]];
        imageview.frame=CGRectMake(0, 0, 160,200);
        
        self.label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.label.backgroundColor=[UIColor clearColor];
        self.label.textAlignment=NSTextAlignmentCenter;
        self.label.textColor=[UIColor cyanColor];
        self.label.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.label.font=[UIFont boldSystemFontOfSize:50];
        
        self.numLabel=[[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height-50, frame.size.width, 50)];
        self.numLabel.backgroundColor=[UIColor clearColor];
        self.numLabel.textAlignment=NSTextAlignmentCenter;
        self.numLabel.textColor=[UIColor blueColor];
        self.numLabel.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.numLabel.font=[UIFont boldSystemFontOfSize:20];
        
        
        self.contentView.layer.borderWidth=2.0f;
        self.contentView.layer.borderColor=[UIColor blackColor].CGColor;
        self.layer.cornerRadius=8.0;
        self.layer.masksToBounds=YES;
        
        [self.contentView addSubview:imageview];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.numLabel];

    }
    
    return self;
}

@end

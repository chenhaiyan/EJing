//
//  EEShowTextView.m
//  EJing
//
//  Created by 123 on 16/4/25.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EEShowTextView.h"
#import "defineHead.h"
@implementation EEShowTextView

-(instancetype)init{
    self=[super init];
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSNotification *notice=[NSNotification notificationWithName:@"touch" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    NSLog(@"touch");
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"move");
//}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    CGPoint newPoint=[editTextView convertPoint:point fromView:self];
//    if([editTextView pointInside:newPoint withEvent:event]){
//        return editTextView;
//    }
//    return [super hitTest:point withEvent:event];
//}

@end

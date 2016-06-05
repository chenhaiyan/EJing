//
//  EESpaceView.m
//  EJing
//
//  Created by 陈海岩 on 16/4/24.
//  Copyright © 2016年 陈海岩. All rights reserved.
//

#import "EESpaceView.h"
#import "defineHead.h"
@implementation EESpaceView{
    NSLayoutConstraint *heightConstraint;
}
+ (instancetype)installToView:(UIView *)parent
{
    if (!parent) return nil;
    EESpaceView *view = [[self alloc] init];
    view.backgroundColor=[UIColor redColor];
    [parent addSubview:view];
    
    [view layoutView];
    [view establishNotificationHandlers];
    return view;
}

- (void)establishNotificationHandlers
{
    // Listen for keyboard appearance
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note)
     {
         // Fetch keyboard frame
         NSDictionary *userInfo = note.userInfo;
         NSTimeInterval  duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
         CGRect keyboardEndFrame = [self.superview convertRect:[userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:self.window];
         
         //Adjust to window
         CGRect windowFrame = [self.superview convertRect:self.window.frame fromView:self.window];
         //the height of the keyboard in window
         CGFloat heightOffset = (windowFrame.size.height - keyboardEndFrame.origin.y) - self.superview.frame.origin.y;
         // Update and animate height constraint
         heightConstraint.constant = heightOffset;
         [UIView animateWithDuration:duration animations:^{
             [self.superview layoutIfNeeded];
         }];
     }];
    
    // Listen for keyboard exit
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note)
     {
         // Reset to zero
         NSDictionary *userInfo = note.userInfo;
         NSTimeInterval  duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
         heightConstraint.constant = 0;
         [UIView animateWithDuration:duration animations:^{
             [self.superview layoutIfNeeded];
         }];
         
     }];
}

// Stretch sides and bottom to superview
- (void)layoutView
{
    //自动设置索引禁止，手动的创建索引
    self.translatesAutoresizingMaskIntoConstraints = NO;
    if (!self.superview) return;
    for (NSString *constraintString in @[@"H:|[view]|", @"V:[view]|"])
    {
        NSArray *constraints = [NSLayoutConstraint
                                constraintsWithVisualFormat:constraintString
                                options:0 metrics:nil views:@{@"view":self}];
        [self.superview addConstraints:constraints];
    }
    heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                   multiplier:1.0f constant:0.0f];
    [self addConstraint:heightConstraint];
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

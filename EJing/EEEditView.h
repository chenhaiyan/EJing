//
//  EEEditView.h
//  EJing
//
//  Created by 123 on 16/4/22.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EEShowTextView.h"
@interface EEEditView : UIView<UITextViewDelegate>{
    UILabel *headLabel;
    EEShowTextView *editTextView;
    int indexNum;
}
+(EEEditView *)shareInstance;
- (void)createWith:(NSString *)name indexPath:(int)index;
- (instancetype)initWithFrame:(CGRect)frame;
@end

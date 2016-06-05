//
//  EEWriteView.h
//  EJing
//
//  Created by 陈海岩 on 16/4/24.
//  Copyright © 2016年 陈海岩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EEWriteView : UIView<UITextViewDelegate>
+(EEWriteView*)shareInstance;
-(void)createWriteView:(int)index;
@end

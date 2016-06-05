//
//  ViewController.h
//  EJing
//
//  Created by 123 on 16/3/24.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDSideBarController.h"
@interface EEViewController : UIViewController<CDSideBarControllerDelegate>
{
    CDSideBarController *siderBar;
}
@end


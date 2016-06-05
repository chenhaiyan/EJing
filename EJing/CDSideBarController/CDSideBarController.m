//
//  CDSideBarController.m
//  CDSideBar
//
//  Created by Christophe Dellac on 9/11/14.
//  Copyright (c) 2014 Christophe Dellac. All rights reserved.
//

#import "CDSideBarController.h"

@implementation CDSideBarController

@synthesize menuColor = _menuColor;
@synthesize isOpen = _isOpen;

#pragma mark - 
#pragma mark Init

- (CDSideBarController*)initWithImages:(NSArray*)images
{
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuButton.frame = CGRectMake(0, 0, 40, 40);
    [_menuButton setImage:[UIImage imageNamed:@"menuIcon.png"] forState:UIControlStateNormal];
    [_menuButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _backgroundMenuView = [[UIView alloc] init];
    _menuColor = [UIColor whiteColor];
    _buttonList = [[NSMutableArray alloc] initWithCapacity:images.count];
    
    int index = 0;
    for (UIImage *image in [images copy])
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(20, 40 + (60 * index), 40, 40);
        button.tag = index;
        [button addTarget:self action:@selector(onMenuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonList addObject:button];
        ++index;
    }
    return self;
}

- (void)insertMenuButtonOnView:(UIView*)view atPosition:(CGPoint)position
{
    //设置侧边栏的背景，手势的滑动
    _menuButton.frame = CGRectMake(position.x, position.y, _menuButton.frame.size.width, _menuButton.frame.size.height);
    //_menuButton.tag=111;
    [view addSubview:_menuButton];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu)];
    [view addGestureRecognizer:singleTap];
    
    for (UIButton *button in _buttonList)
    {
        [_backgroundMenuView addSubview:button];
    }

    _backgroundMenuView.frame = CGRectMake(view.frame.size.width, 0, 90, view.frame.size.height);
    _backgroundMenuView.layer.cornerRadius=10;
    _backgroundMenuView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f];
    [view addSubview:_backgroundMenuView];
}
- (void)removeMenuButtonOnView:(UIView*)view{
    [_menuButton removeFromSuperview];
}
- (void)addMenuButtonOnView:(UIView*)view{
    [view addSubview:_menuButton];
}
#pragma mark Menu button action

- (void)dismissMenuWithSelection:(UIButton*)button
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
         usingSpringWithDamping:.3f
          initialSpringVelocity:10.f
                        options:0 animations:^{
                            button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                        }
                     completion:^(BOOL finished) {
                         [self dismissMenu];
                     }];
}

- (void)dismissMenu
{
    if (_isOpen)
    {
        _isOpen = !_isOpen;
       [self performDismissAnimation];
    }
}

- (void)showMenu
{
    if (!_isOpen)
    {
        _isOpen = !_isOpen;
        [self performSelectorInBackground:@selector(performOpenAnimation) withObject:nil];
    }
}

- (void)onMenuButtonClick:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(menuButtonClicked:)])
        [self.delegate menuButtonClicked:(int)button.tag];
    [self dismissMenuWithSelection:button];
}

#pragma mark -
#pragma mark - Animations

- (void)performDismissAnimation
{
    [UIView animateWithDuration:0.4 animations:^{
        _menuButton.alpha = 1.0f;
        _menuButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
        _backgroundMenuView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    }];
}

- (void)performOpenAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //点击的按钮向左移动，并逐渐消失
        [UIView animateWithDuration:0.4 animations:^{
            _menuButton.alpha = 0.0f;
            _menuButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -80, 0);
            _backgroundMenuView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -80, 0);
        }];
    });
    for (UIButton *button in _buttonList)
    {
        [NSThread sleepForTimeInterval:0.1f];
        dispatch_async(dispatch_get_main_queue(), ^{
            button.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 20);
            [UIView animateWithDuration:0.3f
                                  delay:0.0f
                 usingSpringWithDamping:.3f
                  initialSpringVelocity:10.f
                                options:0 animations:^{
                                    button.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
                                }
                             completion:^(BOOL finished) {
                             }];
        });
    }
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

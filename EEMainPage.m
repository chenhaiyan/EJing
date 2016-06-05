//
//  EEMainPage.m
//  EJing
//
//  Created by 123 on 16/4/7.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EEMainPage.h"
#define degree_to_radius(d) (d*M_PI/180)
#define ToCenterCount 200
@interface EEMainPage(){
    CGFloat angle;
    UIView *childView;
    UIImageView *center;
    NSMutableArray *imgArray;
    NSMutableArray *coinArray;//存储200个tag的值
    NSArray *imgNameArr; //黑色1-4
    NSArray *imgNameArr2;//黄色1-4
    NSArray *imgNameArr3; //黄色1-1
    
}
@end
@implementation EEMainPage



-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    return self;
}
-(void)create{
    imgArray=[[NSMutableArray alloc] init];
    coinArray=[[NSMutableArray alloc] init];
    imgNameArr=@[@"1坤.png",@"2震.png",@"3离.png",@"4兑.png",@"5乾.png",@"6巽.png",@"7坎.png",@"8艮.png"];
    imgNameArr2=@[@"11.png",@"22.png",@"33.png",@"44.png",@"55.png",@"66.png",@"77.png",@"88.png"];
    imgNameArr3=@[@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png",@"7.png",@"8.png"];
    angle=degree_to_radius(45);
    childView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    childView.center=self.center;
    [self addSubview:childView];
    for(int i=0;i<8;i++){
        UIImage *image=[UIImage imageNamed:imgNameArr[i]];
        CGFloat yy=image.size.height/3;
        CGFloat xx=image.size.width/3;
        CGRect frame=CGRectMake(150-xx/2, 150-yy/2, xx, yy);
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:frame];
        imgView.image=image;
        imgView.layer.anchorPoint=CGPointMake(0.5, 1);
        CGFloat allAngle=angle*i*1.0;
        imgView.layer.transform=CATransform3DMakeRotation(allAngle, 0, 0, 1);
        [imgArray addObject:imgView];
        [childView addSubview:imgView];
    }
    CGFloat what=100;
    CGRect centerFrame=CGRectMake(0,0,what,what);
    center=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"center.png"]];
    center.frame=centerFrame;
    center.center=self.center;
    [self addSubview:center];
}
-(void)startAnimation:(int)duration repeat:(int)count{
    //由于主界面的停留时间较短，所以只定义了50个重复次数
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue=[NSNumber numberWithFloat:2*M_PI];
    animation.duration=duration;
    animation.repeatCount=count;
   // animation.cumulative=YES;
    [center.layer addAnimation:animation forKey:@"Center"];
    //定义八卦的旋转动画
    CAKeyframeAnimation *anim=[CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.values=[NSArray arrayWithObjects:
                 [NSValue valueWithCATransform3D:childView.layer.transform],
                 [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI/2, 0, 0, 1)],
                 [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI, 0, 0, 1)],
                 [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI*3/2, 0, 0, 1)],
                 [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-2*M_PI, 0, 0, 1)]
                 , nil];
    anim.duration=duration;
    anim.repeatCount=count;
    //anim.cumulative=YES;
    [childView.layer addAnimation:anim forKey:@"this"];
}
-(void)removeAnimation{
    [childView.layer removeAllAnimations];
    [center.layer removeAllAnimations];
    //[childView removeFromSuperview];
    //[center removeFromSuperview];
}
-(void)addAnimation{
    if(_up==_down){
        ((UIImageView *)[imgArray objectAtIndex:_up]).image=[UIImage imageNamed:imgNameArr[_up]];
    }else{
        ((UIImageView *)[imgArray objectAtIndex:_up]).image=[UIImage imageNamed:imgNameArr[_up]];
        ((UIImageView *)[imgArray objectAtIndex:_down]).image=[UIImage imageNamed:imgNameArr[_down]];
    }
    //恢复透明度为1
    self.alpha=1;
    [self startAnimation:6 repeat:500];
}
-(void)changePictureUp{
    if(_up==_down){
        ((UIImageView *)[imgArray objectAtIndex:_up]).image=[UIImage imageNamed:imgNameArr2[_up]];
    }else{
       ((UIImageView *)[imgArray objectAtIndex:_up]).image=[UIImage imageNamed:imgNameArr2[_up]];
        ((UIImageView *)[imgArray objectAtIndex:_down]).image=[UIImage imageNamed:imgNameArr2[_down]];
    }
    [self performSelector:@selector(changeOpacity) withObject:nil afterDelay:0.8];
}
-(void)changeOpacity{
    self.alpha=0.4;
}

#pragma all pictures to center
static int coinCount = 0;
//所有卦冲向中心双鱼图
-(void)getToCenter{
    for (int i = 0; i<ToCenterCount; i++) {
        //延迟调用函数
        coinCount=0;
        [self performSelector:@selector(initCoinViewWithInt:) withObject:[NSNumber numberWithInt:i] afterDelay:i * 0.01];
    }
}
- (void)initCoinViewWithInt:(NSNumber *)i
{
    UIImageView *coin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imgNameArr3 objectAtIndex:[i intValue] % 8]]];
    coin.frame=CGRectMake(0, 0, 20, 20);
    //初始化金币的最终位置
    coin.center = CGPointMake(CGRectGetMidX(self.frame) + arc4random()%40 * (arc4random() %3 - 1) - 20, CGRectGetMidY(self.frame));
    coin.tag = [i intValue] + 1;
    //每生产一个金币,就把该金币对应的tag加入到数组中,用于判断当金币结束动画时和福袋交换层次关系,并从视图上移除
    [coinArray addObject:[NSNumber numberWithInt:(int)coin.tag]];
    [self addSubview:coin];
    [self setAnimationWithLayer:coin];
}
- (void)setAnimationWithLayer:(UIView *)coin
{
    CGFloat duration = 3.0f;
    //绘制从底部到福袋口之间的抛物线
    CGFloat positionX   = coin.layer.position.x;    //终点x
    CGFloat positionY   = coin.layer.position.y;    //终点y
    CGMutablePathRef path = CGPathCreateMutable();
    int fromX       = arc4random() % 320;     //起始位置:x轴上随机生成一个位置
    int height      = [UIScreen mainScreen].bounds.size.height + coin.frame.size.height; //y轴以屏幕高度为准
    int fromY       = arc4random() % (int)positionY; //起始位置:生成位于八卦上方的随机一个y坐标
    
    CGFloat cpx = positionX + (fromX - positionX)/2;    //x控制点
    CGFloat cpy = fromY / 2 - positionY;                //y控制点,确保抛向的最大高度在屏幕内,并且在八卦上方(负数)
    
    //动画的起始位置
    CGPathMoveToPoint(path, NULL, fromX, height);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, positionX, positionY);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:path];
    CFRelease(path);
    path = nil;
    //图像由大到小的变化动画
    CGFloat from3DScale = 1 + arc4random() % 10 *0.1;
    CGFloat to3DScale = from3DScale * 0.5;
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(from3DScale, from3DScale, from3DScale)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(to3DScale, to3DScale, to3DScale)]];
    scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    //动画组合
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.animations = @[scaleAnimation, animation];
    [coin.layer addAnimation:group forKey:@"position and transform"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        
        //动画完成后把金币和数组对应位置上的tag移除
        UIView *coinView = (UIView *)[self viewWithTag:[[coinArray firstObject] intValue]];
        [coinView removeFromSuperview];
        [coinArray removeObjectAtIndex:0];
        //全部金币完成动画后执行的动作
        if (++coinCount == ToCenterCount) {
            [self bagShakeAnimation];
        }
    }
}
//福袋晃动动画
- (void)bagShakeAnimation
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:- 0.2];
    shake.toValue   = [NSNumber numberWithFloat:+ 0.2];
    shake.duration = 0.1;
    shake.autoreverses = YES;
    shake.repeatCount = 4;
    [center.layer addAnimation:shake forKey:@"bagShakeAnimation"];
}

@end

//
//  ViewController.m
//  EJing
//
//  Created by 123 on 16/3/24.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EEViewController.h"
#import "EECollectionViewController.h"
#import "EEflow.h"
#import "EEExplain.h"
#import "EEMainPage.h"
#import "defineHead.h"
#import "EECategray.h"
//#define screenWidth [UIScreen mainScreen].bounds.size.width
//#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface EEViewController (){
    NSArray *allData;
    NSMutableArray *dataArray;
    EEMainPage *mainPage;
    UIImageView *downView;
    UIImageView *upView;
    NSString *readPageName;
    NSString *dataPath;
    int up;
    int down;
}
@end

@implementation EEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray=[[NSMutableArray alloc] init];
    //创建一个存储算出的卦象的文件
    NSString *home=NSHomeDirectory();
    dataPath=[home stringByAppendingPathComponent:@"Documents/data.plist"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        [dataArray writeToFile:dataPath atomically:YES];
    }
    //背景图片
    UIImageView *background=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    background.frame=self.view.frame;
    [self.view addSubview:background];
    //添加主页面中的八卦
    mainPage=[[EEMainPage alloc] initWithFrame:self.view.frame];
    mainPage.center=self.view.center;
    [mainPage create];
    [self.view addSubview:mainPage];
    //侧边栏图标
    NSArray *imgArr=@[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuClose.png"]];
    //卦象文件
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *path=[bundle pathForResource:@"EJ" ofType:@"plist"];
    allData=[[NSArray alloc] initWithContentsOfFile:path];
    //从运行开始出现的卦的数据
    siderBar=[[CDSideBarController alloc] initWithImages:imgArr];
    siderBar.delegate=self;
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    CATransition *transition=[CATransition animation];
    transition.type=@"rippleEffect";
    transition.duration=0.5;
    [self.view.layer addAnimation:transition forKey:@"transition"];
    [super viewWillAppear:animated];
    [siderBar insertMenuButtonOnView:self.view atPosition:CGPointMake(self.view.frame.size.width-80, 50)];
    [mainPage addAnimation];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [mainPage removeAnimation];
    [downView removeFromSuperview];
    [upView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)menuButtonClicked:(int)index{
    if(index==0){
        //选择第一个按钮算卦的时候就把选择的按钮全部禁止，防止动画的多次执行。
        [siderBar removeMenuButtonOnView:self.view];
        up=arc4random()%8;
        down=arc4random()%8;
        NSLog(@"up=%d,down=%d",up,down);
        //找到对应的卦，把卦的序号写入文件，后边编辑界面可以用到。
        readPageName=[[NSString alloc] initWithFormat:@"%d%d",up+1,down+1];
        for(int i=0;i<allData.count;i++){
            if ([[allData[i] objectForKey:@"num"] isEqualToString:readPageName]) {
                [self writeToData:i];
                break;
            }
        }
        [mainPage setDown:down];
        [mainPage setUp:up];
        [mainPage startAnimation:2 repeat:2];
        [mainPage performSelector:@selector(getToCenter) withObject:nil afterDelay:4];
        [mainPage performSelector:@selector(changePictureUp) withObject:nil afterDelay:10];
        [self performSelector:@selector(twoCoinFlyingUp) withObject:nil afterDelay:10.5];
        [self performSelector:@selector(JumpToRead) withObject:nil afterDelay:14];
    }else if(index==1){
        EEflow *layer=[[EEflow alloc] init];
        EECollectionViewController *readCollection=[[EECollectionViewController alloc] initWithCollectionViewLayout:layer];
        readCollection.dataArray=allData;
        [self presentViewController:readCollection animated:YES completion:nil];
    }else if(index==2){
        EECategray *catagray=[[EECategray alloc] init];
        [self presentViewController:catagray animated:YES completion:nil];
    }
}

- (void)writeToData:(int)i{
    dataArray=[[NSMutableArray alloc] initWithContentsOfFile:dataPath];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",i],@"num",@"",@"text",nil];
    if(dataArray.count==0){
        [dataArray addObject:dic];
    }else if(![dataArray containsObject:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%i",i] forKey:@"num"]]){
        int k;
        for(k=0;k<dataArray.count;k++){
            if ([[dataArray[k] objectForKey:@"num"] intValue]>i) {
                [dataArray insertObject:dic atIndex:k];
                break;
            }
        }
        if(k==dataArray.count){
            [dataArray addObject:dic];
        }
    }
    NSLog(@"%@",dataArray);
    if([dataArray writeToFile:dataPath atomically:YES]){
        NSLog(@"插入成功");
    }
}
#pragma other views
-(void)JumpToRead{
    EEExplain *explain=[[EEExplain alloc] init];
    //拼接图片
    UIImage *upImage=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",up+1]];
    UIImage *downImage=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",down+1]];
    CGFloat imageSize=upImage.size.width/2;
    UIImageView *upPicView=[[UIImageView alloc] initWithImage:upImage];
    UIImageView *downPicView=[[UIImageView alloc] initWithImage:downImage];
    upPicView.frame=CGRectMake(0, 0, imageSize, imageSize);
    downPicView.frame=CGRectMake(0, imageSize+5, imageSize, imageSize);
    UIView *addUpDown=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageSize, 2*imageSize+5)];
    [addUpDown addSubview:upPicView];
    [addUpDown addSubview:downPicView];
    explain.imgView=addUpDown;
   // [self.view addSubview:explain.view];
    //获取对应于随机数的卦象
    for(NSDictionary *dic in allData){
        if ([[dic objectForKey:@"num"] isEqualToString:readPageName]) {
            explain.dicData=dic;
            break;
        }
    }
    [self presentViewController:explain animated:NO completion:nil];
    //恢复功能按钮的功能
    [siderBar addMenuButtonOnView:self.view];
}


#pragma two coin fly
-(void)twoCoinFlyingUp{
    //mainPage.alpha=0.5;
    CGFloat duration = 2.0f;
    //绘制从底部到福袋口之间的抛物线
    CGFloat positionX  = self.view.center.x;    //终点x
    CGFloat positionY  = self.view.center.y-30;    //终点y
    CGFloat positionY2 = self.view.center.y+30;
    CGMutablePathRef path = CGPathCreateMutable();
    CGMutablePathRef upPath=CGPathCreateMutable();
    int fromX = arc4random() % 320;     //起始位置:x轴上随机生成一个位置
    int fromY = arc4random() % (int)positionY; //起始位置:生成位于福袋上方的随机一个y坐标
    CGFloat cpx = positionX + (fromX - positionX)/2;    //x控制点
    CGFloat cpy = fromY / 2 - positionY2;                //y控制点,确保抛向的最大高度在屏幕内,并且在福袋上方(负数)
    CGFloat cpy2= self.view.frame.size.height-cpy;
    
    downView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    downView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",down+1]];
    upView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    upView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",up+1]];
    [self.view addSubview:downView];
    [self.view addSubview:upView];
    
    CGPathMoveToPoint(path, NULL, fromX, self.view.frame.size.height);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, positionX, positionY2);
    CGPathMoveToPoint(upPath, NULL, fromX, 0);
    CGPathAddQuadCurveToPoint(upPath, NULL, cpx, cpy2, positionX, positionY);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CAKeyframeAnimation *upAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path=path;
    upAnimation.path=upPath;
    CFRelease(path);
    CFRelease(upPath);
    path = nil;
    upPath=nil;
    
    //图像由大到小的变化动画
    CGFloat from3DScale = 5.5;
    CGFloat to3DScale = from3DScale * 0.5;
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.values = @[
    [NSValue valueWithCATransform3D:CATransform3DMakeScale(to3DScale, to3DScale, to3DScale)]],
    [NSValue valueWithCATransform3D:CATransform3DMakeScale(from3DScale, from3DScale, from3DScale)];
    scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    //动画组合
    CAAnimationGroup *downGroup=[self makeAnimationGroup:duration];
    CAAnimationGroup *upGroup=[self makeAnimationGroup:duration];
    downGroup.animations = @[scaleAnimation, animation];
    upGroup.animations=@[scaleAnimation,upAnimation];
    [downView.layer addAnimation:downGroup forKey:@"position and transform"];
    [upView.layer addAnimation:upGroup forKey:@"up position and transform"];
}
-(CAAnimationGroup*)makeAnimationGroup:(CFTimeInterval)duration{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    return group;
}
@end

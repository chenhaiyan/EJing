//
//  EEExplain.m
//  EJing
//
//  Created by 123 on 16/3/28.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EEExplain.h"
#import "defineHead.h"
@interface EEExplain (){
    UIScrollView *scroll;
}
@end

@implementation EEExplain

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *background=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"solveBackground"]];
    //background.alpha=0.7;
    background.frame=self.view.frame;
    [self.view addSubview:background];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    scroll=[[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview: scroll];
    scroll.scrollEnabled=YES;
    scroll.contentSize=self.view.frame.size;
    scroll.showsVerticalScrollIndicator=NO;
    
    self.back=[[UIButton alloc] initWithFrame:CGRectMake(20, 25, 45, 35)];
    [self.back addTarget:self action:@selector(BackTo) forControlEvents:UIControlEventTouchUpInside];
    [self.back setTitle:@"Back" forState:UIControlStateNormal];
    self.back.backgroundColor=[UIColor colorWithRed:0 green:1 blue:1 alpha:0.5];
    [self.view addSubview:self.back];
    //设置卦的图片
    self.readImage=[[UIImageView alloc] initWithFrame:CGRectMake(80, 40, 70, 100)];
    self.readImage.layer.cornerRadius=10;
   // self.readImage.backgroundColor=[UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
    [self.readImage addSubview:self.imgView];
    
    self.readName=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.readImage.frame)+20,CGRectGetMinY(self.readImage.frame), 100, 100)];
    // self.readName.backgroundColor=[UIColor orangeColor];
    self.readName.text=[self.dicData objectForKey:@"name"];
    self.readName.font=[UIFont boldSystemFontOfSize:50];
    self.readName.textAlignment=NSTextAlignmentCenter;
    self.readName.textColor=[UIColor blueColor];
    
    //设置卦辞的label，自适应卦辞的大小来调整label
    self.readWord=[[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.readImage.frame)+20, screenWidth-40,100)];
    //self.readWord.backgroundColor=[UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
    self.readWord.text=[self.dicData objectForKey:@"word"];
    self.readWord.font=[UIFont boldSystemFontOfSize:20];
    //self.readWord.textColor=[UIColor cyanColor];
    self.readWord.numberOfLines=0;
    [self.readWord sizeToFit];
    //解释卦辞
    self.readDetail=[[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.readWord.frame)+20, screenWidth-40, 100)];
    //self.readDetail.backgroundColor=[UIColor colorWithRed:1 green:0 blue:1 alpha:0.5];
    self.readDetail.text=[self.dicData objectForKey:@"detail"];
    self.readDetail.font=[UIFont boldSystemFontOfSize:20];
    self.readDetail.textColor=[UIColor blueColor];
    self.readDetail.numberOfLines=0;
    [self.readDetail sizeToFit];
    //设置解卦的文字
    self.readText=[[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.readDetail.frame)+20, screenWidth-40, 400)];
    self.readText.layer.cornerRadius=10;
    self.readText.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    self.readText.text=[self.dicData objectForKey:@"text"];
    self.readText.textColor=[UIColor cyanColor];
    self.readText.font=[UIFont boldSystemFontOfSize:20];
    self.readText.numberOfLines=0;
    [self.readText sizeToFit];
    //如果readText对应得纵坐标大于屏幕的高，就调整滚动视图的contentSize
    if(CGRectGetMaxY(self.readText.frame)>scroll.contentSize.height){
        scroll.contentSize=CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.readText.frame));
    }
    [scroll addSubview:self.readImage];
    [scroll addSubview:self.readName];
    [scroll addSubview:self.readWord];
    [scroll addSubview:self.readDetail];
    [scroll addSubview:self.readText];
}
- (void)viewDidAppear:(BOOL)animated{
    CATransition *transition=[CATransition animation];
    transition.type=@"rippleEffect";
    transition.duration=0.4;
    [self.view.layer addAnimation:transition forKey:@"transition"];
   // [self.view exchangeSubviewAtIndex:4 withSubviewAtIndex:1];
    
}
-(void)BackTo{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.view removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

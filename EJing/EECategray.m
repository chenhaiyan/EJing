//
//  EECategray.m
//  EJing
//
//  Created by 123 on 16/3/28.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EECategray.h"
#import "EEEditView.h"
#import "defineHead.h"
@interface EECategray (){
    NSMutableArray *editArray;
    EEEditView *editview;
}

@end

@implementation EECategray
//#define screenWidth [UIScreen mainScreen].bounds.size.width
//#define screenHeight [UIScreen mainScreen].bounds.size.height
- (instancetype)init{
    self=[super init];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //背景图片
    UIImageView *backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    backgroundView.frame=CGRectMake(0, 0, screenWidth, screenHeight);
    [self.view addSubview:backgroundView];
    //返回按钮
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(20, 25, 45, 30)];
    back.layer.cornerRadius=4;
    back.backgroundColor=[UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
    [back setTitle:@"Back" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(BackToFront) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    //编辑页面
    editArray=[[NSMutableArray alloc] init];
    editview=[EEEditView shareInstance];
    [editview setFrame:self.view.frame];
    [self.view addSubview:editview];
    [self.view sendSubviewToBack:editview];


    //设置装载滚动的算出卦的button。
    self.scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, screenWidth, screenHeight-70)];
    //self.scroll.backgroundColor=[UIColor clearColor];
    self.scroll.showsVerticalScrollIndicator=NO;
    [self.scroll setScrollEnabled:YES];
    self.scroll.delegate=self;
    [self.view addSubview:self.scroll];
    //self.scroll.backgroundColor=[UIColor greenColor];
    //self.scroll.contentSize=CGSizeMake(screenWidth, screenHeight);
    [self.scroll setBounces:YES];
    // Do any additional setup after loading the view.
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //NSString *path=[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.plist"];
    NSLog(@"%@",path);
    NSArray *dataArray=[NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@",dataArray);
    NSArray *allData=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EJ" ofType:@"plist"]];
    for(int i=0;i<dataArray.count;i++){
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenWidth/5, 60)];
        button.center=CGPointMake(screenWidth/8+(i%4)*(screenWidth/4), 40+90*(i/4));
        //用于传递不通按钮的tag值，为后来存储编辑的数据找到位置
        button.tag=i;
        button.layer.cornerRadius=10;
        button.backgroundColor=[UIColor blackColor];
        button.alpha=0.5;
        button.showsTouchWhenHighlighted=YES;
        int number=[[[dataArray objectAtIndex:i] objectForKey:@"num"] intValue];
        NSString *name=[[allData objectAtIndex:number] valueForKey:@"name"];
        NSString *word=[[allData objectAtIndex:number] valueForKey:@"word"];
        [editArray addObject:word];
        NSLog(@"%@",name);
        button.titleLabel.font=[UIFont boldSystemFontOfSize:30];
        [button setTitle:name forState:UIControlStateNormal];
        [button addTarget:self action:@selector(jumpToEditPage:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:button];
    }
    UIButton *butn=(UIButton *)[self.scroll viewWithTag:dataArray.count-1];
    if(CGRectGetMaxY(butn.frame)>screenHeight){
        self.scroll.contentSize=CGSizeMake(screenWidth, CGRectGetMaxY(butn.frame)+20);
    }
}
- (void)jumpToEditPage:(id)sender{
    UIButton *bnt=(UIButton *)sender;
    NSString *text=[editArray objectAtIndex:[bnt tag]];
    [self.view addSubview:editview];
    [editview createWith:text indexPath:[bnt tag]];
    
    CATransition *transition=[CATransition animation];
    transition.type=@"rippleEffect";
    transition.duration=0.8;
    [self.view.layer addAnimation:transition forKey:@"transition"];
    [self.view bringSubviewToFront:editview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<0) {
        scrollView.contentOffset=CGPointMake(0, 0);
    }
//    if (scrollView.contentOffset.y>scrollView.contentSize.height){
//        scrollView.contentOffset=CGPointMake(0, 11*100);
//    }
}

- (void)BackToFront{
    [self dismissViewControllerAnimated:YES completion:nil];
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

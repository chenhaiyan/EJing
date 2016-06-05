//
//  EERead.m
//  EJing
//
//  Created by 123 on 16/3/28.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EERead.h"
#import "defineHead.h"
@interface EERead (){
    NSDictionary *readDic;
}

@end

@implementation EERead
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *background=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inCell"]];
    //background.alpha=0.5;
    background.frame=self.view.frame;
    [self.view addSubview:background];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Read" ofType:@"plist"];
    NSArray *readArray=[NSArray arrayWithContentsOfFile:path];
    readDic=[readArray objectAtIndex:self.number];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.back=[[UIButton alloc] init];
    self.back.layer.cornerRadius=5;
    [self.back addTarget:self action:@selector(BackTo) forControlEvents:UIControlEventTouchUpInside];
    [self.back setTitle:@"Back" forState:UIControlStateNormal];
    self.back.frame=CGRectMake(20, 25, 45, 35);
    self.back.backgroundColor=[UIColor colorWithRed:0 green:1 blue:1 alpha:0.5];
    [self.view addSubview:self.back];
    
    self.headLabel=[[UILabel alloc] initWithFrame:CGRectMake((screenWidth-150)/2, 20, 150, 80)];
    self.headLabel.text=[readDic objectForKey:@"name"];
    self.headLabel.textAlignment=NSTextAlignmentCenter;
    self.headLabel.font=[UIFont boldSystemFontOfSize:40];
    self.headLabel.textColor=[UIColor cyanColor];
    [self.view addSubview:self.headLabel];
    
    
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, screenWidth, screenHeight-80)];
    for(int i=1;i<=6;i++){
        //UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 20, screenWidth-20, 100)];
        UILabel *label=[self createLabel:i];
        UILabel *detailLabel=[self createDetailLabel:i upLabel:label];
        UIView *view=[self createView:label anotherLabel:detailLabel andIndex:i];
        [self.scrollView addSubview:view];
       // UILabel *detailLabel=[UILab
    }
    
    self.scrollView.delegate=self;
    self.scrollView.scrollEnabled=YES;
    self.scrollView.contentSize=CGSizeMake(screenWidth,CGRectGetMaxY([self.scrollView viewWithTag:6].frame));
    [self.view addSubview:self.scrollView];
    
    //设置卦辞的label，自适应卦辞的大小来调整label
}
-(UILabel *)createLabel:(int)i{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 20, screenWidth-40, 100)];
    label.text=[readDic objectForKey:[NSString stringWithFormat:@"%d",i]];
    label.numberOfLines=0;
    [label sizeToFit];
    label.backgroundColor=[UIColor orangeColor];
    return label;
}
-(UILabel *)createDetailLabel:(int)i upLabel:(UILabel*)upLabel{
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(CGRectGetMinX(upLabel.frame), CGRectGetMaxY(upLabel.frame)+10, screenWidth-40, 100);
    NSLog(@"%f",CGRectGetMidX(upLabel.frame));
    label.text=[readDic objectForKey:[NSString stringWithFormat:@"%d%d",i,i]];
    if(i==3){
        NSLog(@"%@",label.text);

    }
    label.numberOfLines=0;
    [label sizeToFit];
    label.backgroundColor=[UIColor greenColor];
    return label;
}

-(UIView *)createView:(UILabel*)label anotherLabel:(UILabel *)detailLabel andIndex:(int)i{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 100)];
    [view addSubview:label];
    [view addSubview: detailLabel];
    view.tag=i;
    if(i>1){
        UIView *upView=[self.scrollView viewWithTag:i-1];
        view.frame=CGRectMake(0, CGRectGetMaxY(upView.frame), screenWidth, CGRectGetMaxY(detailLabel.frame));
    }else{
        view.frame=CGRectMake(0, 10, screenWidth, CGRectGetMaxY(detailLabel.frame));
    }
    return view;
}
-(void)BackTo{
    [self dismissViewControllerAnimated:YES completion:nil];
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

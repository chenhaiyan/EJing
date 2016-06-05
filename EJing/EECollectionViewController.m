//
//  EECollectionViewController.m
//  EJing
//
//  Created by 123 on 16/3/24.
//  Copyright (c) 2016年 陈海岩. All rights reserved.
//

#import "EECollectionViewController.h"
#import "EECell.h"
#import "EEflow.h"
#import "EERead.h"
#import "EECategray.h"
@interface EECollectionViewController ()

@end

@implementation EECollectionViewController

static NSString * const reuseIdentifier = @"Cell";
- (instancetype)init{
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Register cell classes
    [self.collectionView registerClass:[EECell class] forCellWithReuseIdentifier:reuseIdentifier];
    //返回按钮
    UIButton *back=[[UIButton alloc]init];
    back.frame=CGRectMake(20, 25, 45, 35);
    back.layer.cornerRadius=4;
    back.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [back setTitle:@"Back" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(BackToFront) forControlEvents:UIControlEventTouchUpInside];
    //编辑按钮
//    UIButton *edit=[[UIButton alloc]init];
//    edit.frame=CGRectMake(100, 25, 45, 35);
//    edit.layer.cornerRadius=4;
//    edit.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
//    [edit setTitle:@"Edit" forState:UIControlStateNormal];
//    [edit addTarget:self action:@selector(GoToEdit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:back];
    //[self.view addSubview:edit];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"readBackground"]];
    self.collectionView.backgroundView=backgroundView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <else hanshu>
- (void)BackToFront{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (void)GoToEdit{
//    EECategray *catagray=[[EECategray alloc] init];
//    [self presentViewController:catagray animated:YES completion:nil];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 64;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EECell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.label.text=[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.numLabel.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    EERead *read=[[EERead alloc] init];
    read.number=indexPath.row;
    [self presentViewController:read animated:YES completion:nil];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

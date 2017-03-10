//
//  LYCHomeViewController.m
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import "LYCHomeViewController.h"
#import "LYCTitleModel.h"

@interface LYCHomeViewController ()
    @property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
    @property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;

@end

@implementation LYCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取本地json数据（标题数据）
    NSArray *array = [self loadTitleData];
    
}
    

- (NSArray *)loadTitleData{
    return [LYCTitleModel getTitleModel];
}

@end

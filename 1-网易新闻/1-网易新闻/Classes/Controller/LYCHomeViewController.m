//
//  LYCHomeViewController.m
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import "LYCHomeViewController.h"
#import "LYCTitleModel.h"
#import "LYCTitleLabel.h"

@interface LYCHomeViewController ()
    @property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
    @property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;

@property (nonatomic, strong) NSArray *titleModelArray;

@end

@implementation LYCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 获取本地json数据（标题数据）
    [self loadTitleData];
    
    
}

// 获取本地Json数据
- (void)loadTitleData{
    self.titleModelArray = [LYCTitleModel getTitleModel];
    
    //  频道label的大小
    CGFloat labelWidth = 80;
    CGFloat labelHeight = 44;
    for (int i = 0; i < self.titleModelArray.count; i++) {
        LYCTitleLabel *titleLabel = [[LYCTitleLabel alloc] initWithFrame:CGRectMake(i * labelWidth, 0, labelWidth, labelHeight)];
        LYCTitleModel *titleModel = self.titleModelArray[i];
        titleLabel.text = titleModel.tname;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.titleScrollView addSubview:titleLabel];
    }
    self.titleScrollView.contentSize = CGSizeMake(self.titleModelArray.count * labelWidth, 0);
    
    // 取出两个滚动指示器
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧效果
    self.titleScrollView.bounces = NO;
    // 设置分页滚动
    self.titleScrollView.pagingEnabled = YES;
    
}

@end

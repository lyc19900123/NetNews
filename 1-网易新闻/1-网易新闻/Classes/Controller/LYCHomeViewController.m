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
#import "LYCWebManager.h"
#import "LYCNewsCollectionViewCell.h"


@interface LYCHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
    @property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
    @property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *newsFlowLayout;

@property (nonatomic, strong) NSArray *titleModelArray;

@end

@implementation LYCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 获取本地json数据（标题数据）
    [self loadTitleData];
    
    // 设置新闻视图
    [self setupNewsCollectionView];
    
    
}

// 设置新闻视图
- (void)setupNewsCollectionView{
    // 设置新闻视图的数据源和代理
    self.newsCollectionView.dataSource = self;
    self.newsCollectionView.delegate = self;
    
    // 设置collectionCell的大小
    self.newsFlowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 64 - 44);
    // collctionCell的两个间距设置为0
    self.newsFlowLayout.minimumLineSpacing = 0;
    self.newsFlowLayout.minimumInteritemSpacing = 0;
    // 设置滚动方向
    self.newsFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //  开启分页效果
    self.newsCollectionView.pagingEnabled = YES;
    //  去掉弹簧效果
    self.newsCollectionView.bounces = NO;
    //  去掉滚动条
    self.newsCollectionView.showsHorizontalScrollIndicator = NO;
    self.newsCollectionView.showsVerticalScrollIndicator = NO;
    
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

#pragma mark 数据源代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LYCNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    LYCTitleModel *model = self.titleModelArray[indexPath.item];
    //  获取频道id
    NSString *tid = model.tid;
    //  计算请求的urlStr
    NSString *urlStr = [NSString stringWithFormat:@"%@/0-20.html", tid];
    cell.urlstr = urlStr;
    
    return cell;

}




@end



















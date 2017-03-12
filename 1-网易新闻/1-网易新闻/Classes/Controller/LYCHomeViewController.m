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

//  记录频道标签的数组
@property (nonatomic, strong) NSMutableArray *channelLabelArray;

@end

@implementation LYCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化channelLabelArray
    self.channelLabelArray = [NSMutableArray array];
    
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
        
        // 开启label的用户交互
        titleLabel.userInteractionEnabled = YES;
        // 添加tap手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAction:)];
        [titleLabel addGestureRecognizer:tapGesture];
        
        //  记录频道label
        [self.channelLabelArray addObject:titleLabel];
        if (i == 0) {// 代表第一个标签
            // 让其变大变红
            titleLabel.changePrecent = 1;
        }
        
    }
    self.titleScrollView.contentSize = CGSizeMake(self.titleModelArray.count * labelWidth, 0);
    
    // 取出两个滚动指示器
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧效果
    self.titleScrollView.bounces = NO;
    // 设置分页滚动
//    self.titleScrollView.pagingEnabled = YES;
}

// 点击title方法
- (void)tapClickAction:(UITapGestureRecognizer *)tap{
    LYCTitleLabel *titleLabel = (LYCTitleLabel *)tap.view;
    // 计算titleLabel滚动中心需要的偏移量
    CGFloat contentOffsetX = titleLabel.center.x - self.view.bounds.size.width * 0.5;
    // 最小偏移量
    CGFloat minContentOffsetX = 0;
    // 最大偏移量
    CGFloat maxContentOffsetX = self.titleScrollView.contentSize.width - self.view.bounds.size.width;
    if (contentOffsetX > maxContentOffsetX) {
        contentOffsetX = maxContentOffsetX;
    }else if (contentOffsetX < minContentOffsetX){
        contentOffsetX = minContentOffsetX;
    }
    [self.titleScrollView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
    
    
    for (LYCTitleLabel *label in self.channelLabelArray) {
        if (titleLabel == label) {
            label.changePrecent = 1;
        }else{
            label.changePrecent = 0;
        }
    }
    // 获取当前点击的label在数组中的下标
    NSInteger index = [self.channelLabelArray indexOfObject:titleLabel];
    // 计算出点击label应该显示的item的下标
    NSIndexPath *showItemIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    [self.newsCollectionView scrollToItemAtIndexPath:showItemIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
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



















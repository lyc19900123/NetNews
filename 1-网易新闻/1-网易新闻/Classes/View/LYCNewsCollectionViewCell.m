//
//  LYCNewsCollectionViewCell.m
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import "LYCNewsCollectionViewCell.h"
#import "LYCNewsTableViewController.h"

@implementation LYCNewsCollectionViewCell{
    LYCNewsTableViewController *_tableViewVC;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI{
    _tableViewVC = [[LYCNewsTableViewController alloc] init];
    [self.contentView addSubview:_tableViewVC.tableView];
    
    // 设置tableView的frame
    _tableViewVC.tableView.frame = self.contentView.bounds;
    
    _tableViewVC.tableView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
}

@end

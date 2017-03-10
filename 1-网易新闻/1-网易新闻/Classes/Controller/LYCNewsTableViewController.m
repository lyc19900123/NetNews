//
//  LYCNewsTableViewController.m
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import "LYCNewsTableViewController.h"
#import "LYCNewsModel.h"
#import <YYModel.h>

@interface LYCNewsTableViewController ()
@property (nonatomic, strong) NSArray<LYCNewsModel *> *newsModelArray;

@end

@implementation LYCNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    
}

- (void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    
    // 开始下载数据
    [LYCNewsModel requestNewsModelArrayWithUrlStr:urlStr andCompletionBlock:^(NSArray *modelArray) {
        self.newsModelArray = modelArray;
//        NSLog(@"%@",self.newsModelArray);
        
        // 刷新数据
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    cell.textLabel.text = self.newsModelArray[indexPath.row].title;
    
    return cell;
    
}



@end












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
#import "LYCBaseCell.h"

@interface LYCNewsTableViewController ()
@property (nonatomic, strong) NSArray<LYCNewsModel *> *newsModelArray;

@end

@implementation LYCNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    [self.tableView registerNib:[UINib nibWithNibName:@"baseCell" bundle:nil] forCellReuseIdentifier:@"baseCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"bigImageCell" bundle:nil] forCellReuseIdentifier:@"bigCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"images" bundle:nil] forCellReuseIdentifier:@"imagesCell"];
    
//    self.tableView.rowHeight = 80;
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
    LYCBaseCell *cell;
    LYCNewsModel *model = self.newsModelArray[indexPath.row];
    if (model.imgType) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"bigCell" forIndexPath:indexPath];
        
    }else if (model.imgextra.count == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"imagesCell" forIndexPath:indexPath];
    } else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell" forIndexPath:indexPath];
    }
    
    cell.newsModel = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYCNewsModel *model = self.newsModelArray[indexPath.row];
    if (model.imgType) {
        //  表示大图
        return 130;
    } else if (model.imgextra.count == 2) {
        //  多图显示
        return 180;
    } else{
        //  基础cell
        return 80;
    }
}


@end












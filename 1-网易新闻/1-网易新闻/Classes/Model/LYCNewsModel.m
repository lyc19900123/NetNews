//
//  LYCNewsModel.m
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import "LYCNewsModel.h"
#import "LYCWebManager.h"
#import <YYModel.h>
#import "LYCPictureModel.h"

@implementation LYCNewsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"imgextra" : [LYCPictureModel class]};
}

//  根据指定请求地址获取新闻数据
+ (void)requestNewsModelArrayWithUrlStr: (NSString *)urlStr andCompletionBlock: (void (^)(NSArray *modelArray))completionBlock{
    LYCWebManager *manager = [LYCWebManager sharedWebManager];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        NSDictionary *dict = responseObject;
        NSString *key = [dict allKeys].firstObject;
        NSArray *dictArray = [dict objectForKey:key];
        
        NSArray *newsModelArray = [NSArray yy_modelArrayWithClass:[LYCNewsModel class] json:dictArray];
        completionBlock(newsModelArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@",error);
    }];

}

@end

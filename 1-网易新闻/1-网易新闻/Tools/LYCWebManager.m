//
//  LYCWebManager.m
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import "LYCWebManager.h"

@implementation LYCWebManager
+ (instancetype)sharedWebManager{
    static LYCWebManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYCWebManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://c.m.163.com/nc/article/list/"]];
    });
    return manager;
}

- (void)requestWithURL:(NSString *)urlStr WithRequestType:(LYCRequestType)requestType andParams: (id)parameters andSuccess: (void (^)(id responseObject))successBlock andFailture: (void (^)(NSError *error))failureBlock{
    if (requestType == LYCRequestTypeGet) {
        [self GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"error: %@" ,error);
            failureBlock(error);
        }];
        
    }else if (requestType == LYCRequestTypePost){
        
    }
}
@end

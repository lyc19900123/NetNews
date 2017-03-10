//
//  LYCWebManager.h
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef enum : NSUInteger {
    LYCRequestTypeGet,
    LYCRequestTypePost,
} LYCRequestType;

@interface LYCWebManager : AFHTTPSessionManager

+ (instancetype)sharedWebManager;

- (void)requestWithURL:(NSString *)urlStr WithRequestType:(LYCRequestType)requestType andParams: (id)parameters andSuccess: (void (^)(id responseObject))successBlock andFailture: (void (^)(NSError *error))failureBlock;
    
@end

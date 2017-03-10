//
//  LYCTitleModel.m
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import "LYCTitleModel.h"
#import <YYModel.h>

@implementation LYCTitleModel
+ (NSArray *)getTitleModel{
    NSString *str = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:str];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *key = [dict allKeys].firstObject;
    NSArray *Array = [dict objectForKey:key];
    
    return [NSArray yy_modelArrayWithClass:[LYCTitleModel class] json:Array];
}

@end

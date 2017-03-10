//
//  LYCTitleModel.h
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYCTitleModel : NSObject
//  频道id
@property (nonatomic, copy) NSString *tid;
//  频道名称
@property (nonatomic, copy) NSString *tname;

+ (NSArray *)getTitleModel;


@end

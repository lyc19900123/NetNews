//
//  LYCTitleLabel.m
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/10.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import "LYCTitleLabel.h"

@implementation LYCTitleLabel

- (void)setChangePrecent:(CGFloat)changePrecent{
    _changePrecent = changePrecent;
    
    // 变大变红
    self.textColor = [UIColor colorWithRed:changePrecent green:0 blue:0 alpha:1.0];
    self.transform = CGAffineTransformMakeScale(1 + changePrecent * 0.3, 1 + changePrecent * 0.3);
}

@end

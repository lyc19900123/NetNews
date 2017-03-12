//
//  LYCBaseCell.m
//  1-网易新闻
//
//  Created by 梁永超 on 17/3/11.
//  Copyright © 2017年 lyc. All rights reserved.
//

#import "LYCBaseCell.h"
#import <UIImageView+WebCache.h>
#import "LYCPictureModel.h"

@interface LYCBaseCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labSource;
@property (weak, nonatomic) IBOutlet UILabel *labReplyCount;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *moreImageView;

@end

@implementation LYCBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //  设置安装图片原始比例显示,但是会有图片超出情况
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    
}

- (void)setNewsModel:(LYCNewsModel *)newsModel{
    _newsModel = newsModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
    self.labTitle.text = newsModel.title;
    self.labSource.text = newsModel.source;
    self.labReplyCount.text = [NSString stringWithFormat:@"%zd",newsModel.replyCount];
    
    for (int i = 0; i < self.moreImageView.count; i++) {
        UIImageView *imageView = self.moreImageView[i];
        LYCPictureModel *pictureModel = newsModel.imgextra[i];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:pictureModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    }
}

@end

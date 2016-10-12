//
//  GPDaRenStepOneCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/3.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDaRenStepOneCell.h"
#import "GPDaRenPicData.h"

@interface GPDaRenStepOneCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *insLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cateImageView;
@property (weak, nonatomic) IBOutlet UILabel *cateNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *fanLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanfanLabel;


@end

@implementation GPDaRenStepOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //毛玻璃视图
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffect.alpha = 0.5;
    visualEffect.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.bgImageView addSubview:visualEffect];
}

- (void)setPicData:(GPDaRenPicData *)picData
{
    NSURL *bgUrl = [NSURL URLWithString:picData.host_pic_s];
    [self.bgImageView sd_setImageWithURL:bgUrl placeholderImage:[UIImage imageNamed:@"3"]];
    NSURL *iconUrl = [NSURL URLWithString:picData.face_pic];
    [self.iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"1"]];
    NSURL *cateUrl = [NSURL URLWithString:picData.cate_pic];
    [self.cateImageView sd_setImageWithURL:cateUrl placeholderImage:[UIImage imageNamed:@"1"]];
    
    self.cateImageView.layer.cornerRadius = 10;
    self.cateImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.cateNameLabel.text = picData.cate_name;
    self.titleLabel.text = picData.subject;
    self.insLabel.text = picData.summary;
    self.fanLabel.text = picData.user_name;
    self.fanfanLabel.text = [NSString stringWithFormat:@"%@人气|%@收藏|%@评论|%@赞",picData.view, picData.collect, picData.comment_num, picData.laud];
}

@end

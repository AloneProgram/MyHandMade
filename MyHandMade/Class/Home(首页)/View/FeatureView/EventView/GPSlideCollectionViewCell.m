//
//  GPSlideCollectionViewCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/22.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPSlideCollectionViewCell.h"
#import "GPSlideShopData.h"

@interface GPSlideCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *shopPic;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *vote;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userPic;
@end

@implementation GPSlideCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.cornerRadius = 5;
    }
    return self;
}
- (void)setShopData:(GPSlideShopData *)shopData
{
    _shopData = shopData;
    NSURL *shopUrl = [NSURL URLWithString:shopData.host_pic];
    NSURL *userUrl = [NSURL URLWithString:shopData.avatar];
    [self.shopPic sd_setImageWithURL:shopUrl placeholderImage:[UIImage imageNamed:@"2"]];
    self.subTitle.text = shopData.subject;
    self.vote.text = shopData.votes;
    [self.userPic sd_setImageWithURL:userUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.userPic.layer.masksToBounds = YES;
    self.userPic.layer.cornerRadius = 5;
    self.userName.text = shopData.uname;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end

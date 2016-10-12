//
//  GPNavigationCell.m
//  MyHandMade
//
//  Created by iKnet on 16/7/28.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPNavigationCell.h"
#import "GPNavigation.h"
@interface GPNavigationCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation GPNavigationCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setNavigationData:(GPNavigation *)navigationData
{
    _navigationData = navigationData;
    NSURL *url = [NSURL URLWithString:navigationData.pic];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1"]];
    self.titleLab.text = navigationData.name;
}

@end

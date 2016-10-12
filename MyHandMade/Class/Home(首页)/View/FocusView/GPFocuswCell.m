//
//  GPFocuswCell.m
//  MyHandMade
//
//  Created by iKnet on 16/7/28.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPFocuswCell.h"

@interface GPFocuswCell()

@property (weak, nonatomic) IBOutlet UIImageView *iocnImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation GPFocuswCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.iocnImageView.layer.cornerRadius = 25;
    self.iocnImageView.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 20;
}

- (void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    self.contentLabel.text = self.contentStr;
}

- (void)setIconStr:(NSString *)iconStr
{
    _iconStr = iconStr;
    self.iocnImageView.image = [UIImage imageNamed:self.iconStr];
}

- (void) setNameStr:(NSString *)nameStr
{
    _nameStr = nameStr;
    self.nameLabel.text = self.nameStr;
}

- (void)setImageStr:(NSString *)imageStr
{
    _imageStr = imageStr;
    self.contentImageView.image = [UIImage imageNamed:self.imageStr];
}

@end

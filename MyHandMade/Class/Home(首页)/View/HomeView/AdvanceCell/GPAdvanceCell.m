//
//  GPAdvanceCell.m
//  MyHandMade
//
//  Created by iKnet on 16/7/28.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPAdvanceCell.h"
#import "GPAdvanceData.h"

@interface GPAdvanceCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@end
@implementation GPAdvanceCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setAdvancedata:(GPAdvanceData *)advancedata
{
    _advancedata = advancedata;
    NSURL *url = [NSURL URLWithString:advancedata.pic];
    [self.iconImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"2"]];
}


@end

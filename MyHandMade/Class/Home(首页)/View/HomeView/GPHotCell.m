//
//  GPHotCell.m
//  MyHandMade
//
//  Created by iKnet on 16/7/28.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPHotCell.h"
#import "GPHotData.h"

@interface GPHotCell()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation GPHotCell

- (void)setHotData:(GPHotData *)hotData
{
    _hotData = hotData;
    
    NSURL *url = [NSURL URLWithString:hotData.pic];
    [self.backgroundImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"2"]];
    
    self.subTitle.text = hotData.subject;
}
@end

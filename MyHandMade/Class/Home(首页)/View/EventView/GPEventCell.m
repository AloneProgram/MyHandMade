//
//  GPEventCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/17.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPEventCell.h"
#import "GPEventData.h"

@interface GPEventCell()

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation GPEventCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setEventData:(GPEventData *)eventData
{
    _eventData = eventData;
    NSURL *url = [NSURL URLWithString:eventData.m_logo];
    [self.contentImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"2"]];
    
    self.eventLabel.text = eventData.c_name;
    self.timeLabel.text = [NSString stringWithFormat:@"征集作品时间:%@",eventData.c_time];
    if ([eventData.c_status isEqualToString:@"1"]) {
        self.statusLabel.text = @"进行中";
        self.statusLabel.textColor = [UIColor blackColor];
    }else {
        self.statusLabel.text = @"已结束";
        self.statusLabel.textColor = [UIColor lightGrayColor];
    }
    
}

@end

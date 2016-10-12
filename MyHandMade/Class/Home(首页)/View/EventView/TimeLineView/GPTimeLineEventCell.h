//
//  GPTimeLineEventCell.h
//  MyHandMade
//
//  Created by iKnet on 16/8/24.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPTimeLineData;
@interface GPTimeLineEventCell : UITableViewCell
@property (nonatomic, strong) GPTimeLineData *timeLineData;
@property (nonatomic, copy) void (^EventClick)();

@end

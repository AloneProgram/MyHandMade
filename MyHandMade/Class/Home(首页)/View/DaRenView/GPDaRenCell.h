//
//  GPDaRenCell.h
//  MyHandMade
//
//  Created by iKnet on 16/8/1.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPDaData;
@interface GPDaRenCell : UITableViewCell

@property (nonatomic, strong) GPDaData *daData;
@property (nonatomic, copy) void(^imageClick)(NSInteger tagImageView);
@end

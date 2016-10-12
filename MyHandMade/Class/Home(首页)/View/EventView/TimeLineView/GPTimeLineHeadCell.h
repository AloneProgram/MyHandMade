//
//  GPTimeLineHeadCell.h
//  MyHandMade
//
//  Created by iKnet on 16/8/23.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPTimeLineData,GPHandeListData;
@interface GPTimeLineHeadCell : UITableViewCell
@property (nonatomic, strong) GPTimeLineData *timeLineData;
@property (nonatomic, strong) GPHandeListData *listData;
@property (nonatomic, strong) NSMutableArray *sizeArray;
@property (nonatomic, strong) NSMutableArray *picUrlArray;
@end

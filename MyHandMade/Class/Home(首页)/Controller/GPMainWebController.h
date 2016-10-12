//
//  GPMainWebController.h
//  MyHandMade
//
//  Created by iKnet on 16/7/28.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPHotData,GPFairBestData,GPFairTopicData;
@interface GPMainWebController : UIViewController
@property (nonatomic, strong) GPHotData *hotData;
@property (nonatomic, strong) GPFairBestData *bestData;
@property (nonatomic, strong) GPFairTopicData *topicData;
@end

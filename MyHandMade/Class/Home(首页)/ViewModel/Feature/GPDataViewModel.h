//
//  GPDataViewModel.h
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPData.h"
@interface GPDataViewModel : NSObject

- (instancetype)initWithGPData:(GPData *)gpData;
@property (nonatomic, readonly) GPData *gpData;
@property (nonatomic, readonly) NSArray *slide; // 轮播图数组
@property (nonatomic, readonly) NSArray *hotTopic; // 热帖数组
@property (nonatomic, readonly) NSArray *navigation; // 直播
@property (nonatomic, readonly) NSArray *advance; // 推荐

@end

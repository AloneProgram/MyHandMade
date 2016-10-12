//
//  GPData.h
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPData : NSObject

- (instancetype)initWithSlide:(NSArray *)slide
                     hotTopic:(NSArray *)hotTopic
                   navigation:(NSArray *)navigation
                      advance:(NSArray *)advance;

@property (nonatomic, strong) NSArray *slide;   //轮播图数组
@property (nonatomic, strong) NSArray *hotTopic;  //热帖数组
@property (nonatomic, strong) NSArray *navigation;  //直播
@property (nonatomic, strong) NSArray *advance;   //推荐


@end

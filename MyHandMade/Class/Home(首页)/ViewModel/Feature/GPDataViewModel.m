//
//  GPDataViewModel.m
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDataViewModel.h"
#import "MJExtension.h"

@implementation GPDataViewModel

- (instancetype)initWithGPData:(GPData *)gpData
{
    self = [super init];
    if (!self) return nil;
    
    _gpData = gpData;
    _slide = gpData.slide;
    _hotTopic = gpData.hotTopic;
    _advance = gpData.advance;
    _navigation = gpData.navigation;
    
    return self;
}

@end

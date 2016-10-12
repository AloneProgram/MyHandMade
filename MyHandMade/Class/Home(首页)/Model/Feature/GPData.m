//
//  GPData.m
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPData.h"
#import "GPslid.h"
#import "GPNavigation.h"
#import "GPAdvanceData.h"
#import "GPHotData.h"

@implementation GPData

- (instancetype)initWithSlide:(NSArray *)slide
                     hotTopic:(NSArray *)hotTopic
                   navigation:(NSArray *)navigation
                      advance:(NSArray *)advance
{
    if (self = [super init]) {
        _slide = slide;
        _hotTopic = hotTopic;
        _navigation = navigation;
        _advance = advance;
    }
    return self;
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"slide" : [GPslid class],
             @"hotTopic" : [GPHotData class],
             @"navigation" : [GPNavigation class],
             @"advance" : [GPAdvanceData class]
             };
}

@end

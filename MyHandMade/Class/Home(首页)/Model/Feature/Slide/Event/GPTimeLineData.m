//
//  GPTimeLineData.m
//  MyHandMade
//
//  Created by iKnet on 16/8/23.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPTimeLineData.h"
#import "GPTimeLinePicData.h"
#import "GPTimeLineLaudData.h"
#import "GPTimeLineCommentData.h"

@implementation GPTimeLineData

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"pic" : [GPTimeLinePicData class],
             @"laud_list" : [GPTimeLineLaudData class],
             @"commnet" : [GPTimeLineCommentData class]
             };
}

@end

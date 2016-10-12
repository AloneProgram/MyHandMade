//
//  GPHandeListData.m
//  MyHandMade
//
//  Created by iKnet on 16/8/23.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPHandeListData.h"
#import "GPHandPicData.h"
#import "GPHandlaudData.h"
#import "GPHandCommentData.h"

@implementation GPHandeListData

+ (NSDictionary *)mj_objectClassInArray
{
  return @{
            @"pic" : [GPHandPicData class],
            @"comment" : [GPHandCommentData class],
            @"laud_list" : [GPHandlaudData class],
            };
}

@end

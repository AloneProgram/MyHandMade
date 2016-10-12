//
//  GPDaRenPicData.m
//  MyHandMade
//
//  Created by iKnet on 16/8/1.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDaRenPicData.h"
#import "GPDaRenMaterialData.h"
#import "GPDaRenStepData.h"
#import "GPDaRenToolsData.h"
@implementation GPDaRenPicData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"tools" : [GPDaRenToolsData class],
             @"material" : [GPDaRenMaterialData class],
             @"step" : [GPDaRenStepData class],
             };
}

@end

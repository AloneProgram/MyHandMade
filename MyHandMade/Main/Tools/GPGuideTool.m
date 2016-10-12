//
//  GPGuideTool.m
//  MyHandMade
//
//  Created by iKnet on 16/7/26.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPGuideTool.h"
#import "GPAdViewController.h"
#import "GPNewFeatureController.h"
#define GPVersionKey @"curVersion"

#define GPUserDefaults [NSUserDefaults standardUserDefaults]
@implementation GPGuideTool

#pragma mark---  启动app时校验版本号,已为最新时加载GPAdViewController(启动页作为广告页),有新版本时为GPNewFeatureController
//加载哪个控制器
+ (id)chooseRootViewController
{
    id rootVc = nil;
    
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    
    //获取最新版本号
    NSString *curVersion = dict[@"CFBundleShortVersionString"];
    //获取上一次的版本号
    NSString *lastVersion = [GPUserDefaults objectForKey:GPVersionKey];
    //之前的最新版本号 lastVersion
    if ([curVersion isEqualToString:lastVersion]) {
        //版本号相等
        rootVc = [[GPAdViewController alloc] init];
    }else { //有最新的版本号
        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:GPVersionKey];
        rootVc = [[GPNewFeatureController alloc] init];
    }
    
    return rootVc;
    
}
@end

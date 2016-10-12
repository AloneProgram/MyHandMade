//
//  GPHomController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/26.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPHomController.h"
#import "GPFeaturedController.h"
#import "GPFocusController.h"
#import "GPDaRenController.h"
#import "GPEventController.h"

@interface GPHomController ()

@end

@implementation GPHomController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   //初始化样式
    [self setupView];
    
    //添加子控制器
    [self adddAllChlidVc];
    
}

- (void)setupView
{
    //设置标题样式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleScrollViewColor = [UIColor whiteColor];
        *norColor = [UIColor darkGrayColor];
        *selColor = [UIColor redColor];
        *titleHeight = GPTitlesViewH;
    }];
    
    //设置下标
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        *isShowUnderLine = YES;
        *underLineColor = [UIColor redColor];
    }];
}

- (void)adddAllChlidVc
{
    GPFeaturedController *featureVC = [[GPFeaturedController alloc] init];
    featureVC.title = @"精选";
    [self addChildViewController:featureVC];
    
    GPFocusController *focusVC = [[GPFocusController alloc] init];
    focusVC.title = @"关注";
    [self addChildViewController:focusVC];
    
    GPDaRenController *daRenVC = [[GPDaRenController alloc] init];
    daRenVC.title = @"达人";
    [self addChildViewController:daRenVC];
    
    GPEventController *eventVC = [[GPEventController alloc] init];
    eventVC.title = @"活动";
    [self addChildViewController:eventVC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

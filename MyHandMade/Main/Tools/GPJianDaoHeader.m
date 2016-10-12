//
//  GPJianDaoHeader.m
//  MyHandMade
//
//  Created by iKnet on 16/7/28.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPJianDaoHeader.h"

/**
 *对MJRefresh下拉刷新视图的自定义封装
 */

@implementation GPJianDaoHeader

- (void)prepare
{
    [super prepare];
    
    //设置普通状态的动画图片
    NSMutableArray *dieImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%zd", i]];
        [dieImages addObject:image];
    }
    
    [self setImages:dieImages forState:MJRefreshStateIdle];
    [self setImages:dieImages forState:MJRefreshStatePulling];
    
    [self setImages:dieImages forState:MJRefreshStateRefreshing];
    
    self.automaticallyChangeAlpha = YES;   //根据拖拽比例改变透明度
    self.lastUpdatedTimeLabel.hidden = YES;    //隐藏上一次刷新的时间
    
    //设置下拉刷新文字
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];  //普通闲置状态
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];   //松开就可进行刷新的状态
    [self setTitle:@"小客正在为您刷新..." forState:MJRefreshStateRefreshing];  //正在刷新状态
    
    //设置文字字体
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    self.stateLabel.textColor = [UIColor darkGrayColor];
}

@end

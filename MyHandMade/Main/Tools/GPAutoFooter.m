//
//  GPAutoFooter.m
//  MyHandMade
//
//  Created by iKnet on 16/8/1.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPAutoFooter.h"

@interface GPAutoFooter()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIActivityIndicatorView *loading;

@end

@implementation GPAutoFooter

- (void)prepare
{
    [super prepare];
    
    self.mj_h = 50;
    
    //添加Label
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:1.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    //loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

//设置子控件的尺寸和位置
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    self.loading.center = CGPointMake(SCREEN_WIDTH *0.2, self.mj_h * 0.5);
    
}

//监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"客官,再加把劲";
            [self.loading stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"小客正在努力加载";
            [self.loading startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"客官,没有数据了呀";
            [self.loading stopAnimating];
            break;
        default:
            break;
    }
}
@end

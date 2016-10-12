//
//  GPEventBtn.m
//  MyHandMade
//
//  Created by iKnet on 16/7/28.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPEventBtn.h"

@implementation GPEventBtn

- (void)showEventButCenter:(CGPoint)centerPoint
{
    self.center = centerPoint;
}
- (void)showAnamEventBtnCenter:(CGPoint)anmPoint
{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.5 options:0 animations:^{
        self.center = anmPoint;
    } completion:nil];
}
@end

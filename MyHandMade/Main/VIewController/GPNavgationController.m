//
//  GPNavgationController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/26.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPNavgationController.h"

@interface GPNavgationController ()

@end

@implementation GPNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UINavigationBar appearance].barTintColor = GPBgColor;
}

//重写push方法,方便统一处理返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断是否为根控制器
    if (self.childViewControllers.count != 0) { //不为根控制器隐藏底部标签栏,添加返回按钮
        
        viewController.hidesBottomBarWhenPushed = YES;  //push页面的时候是否隐藏底部标签栏
        
        //设置导航栏左边的按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Image"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

//
//  GPSuperTopicController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPSuperTopicController.h"

@interface GPSuperTopicController ()

@end

@implementation GPSuperTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    //如果有tabBarController,底部需要添加额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, GPTabBarH, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

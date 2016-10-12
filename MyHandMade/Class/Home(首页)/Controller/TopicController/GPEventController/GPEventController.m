//
//  GPEventController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPEventController.h"
#import "GPEventData.h"
#import "GPJianDaoHeader.h"
#import "GPAutoFooter.h"
#import "GPHttpTool.h"
#import "GPSlideEventController.h"
#import "XWCoolAnimator.h"
#import "GPEventCell.h"

static NSString *const EventId = @"eventCell";
@interface GPEventController ()
@property (nonatomic, strong) NSMutableArray *eventDatas;
@property (nonatomic, copy) NSString *lastId;
@end

@implementation GPEventController

#pragma mark --懒加载
- (NSMutableArray *)eventDatas
{
    if (!_eventDatas) {
        _eventDatas = [NSMutableArray array];
    }
    return _eventDatas;
}

#pragma makr---初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self regitCell];
    [self addHeadAndFoot];
}

- (void)regitCell
{
    self.tableView.rowHeight = SCREEN_HEIGHT * 0.35;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPEventCell class]) bundle:nil] forCellReuseIdentifier:EventId];
}

- (void)addHeadAndFoot
{
    //添加下拉刷新
    self.tableView.mj_header = [GPJianDaoHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [GPAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

//下拉
- (void)loadNewData
{
    //1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Course";
    params[@"a"] = @"activityList";
    params[@"vid"] = @"18";
    //2.发起请求
    [self loadData:params];
}
//上拉
- (void)loadMoreData
{
    //1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Course";
    params[@"a"] = @"activityList";
    params[@"vid"] = @"18";
     params[@"id"] = self.lastId;
    //2.发起请求
    [self loadData:params];
}

- (void)loadData:(NSMutableDictionary *)params
{
    __weak typeof(self) weakSelf = self;
    
    [GPHttpTool get:HomeBaseURL param:params success:^(id responseObj) {
        weakSelf.eventDatas = [GPEventData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        GPEventData *eventData = [weakSelf.eventDatas lastObject];
        weakSelf.lastId = eventData.lastId;
        [self.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
    }];
    
}

#pragma mark --- UITableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.eventDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //已注册cell用如下方法进行复用,用dequeueReusableCellWithIdentifier方法需先进行判断cell是否为nill
    GPEventCell *eventCell = [tableView dequeueReusableCellWithIdentifier:EventId forIndexPath:indexPath];
    eventCell.eventData = self.eventDatas[indexPath.row];
    return eventCell;
}
#pragma mark --UItableView代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPEventData *eventData = self.eventDatas[indexPath.row];
    GPSlideEventController *slidVC = [[GPSlideEventController alloc] init];
    slidVC.handId = eventData.c_id;
    [self.navigationController pushViewController:slidVC animated:YES];
}

@end

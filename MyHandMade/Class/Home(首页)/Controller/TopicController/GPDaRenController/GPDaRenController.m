//
//  GPDaRenController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDaRenController.h"
#import "GPJianDaoHeader.h"
#import "GPAutoFooter.h"
#import "GPHttpTool.h"
#import "GPDaData.h"
#import "GPDarenCell.h"
#import "XWCoolAnimator.h"
#import "GPDarRenPicController.h"

static NSString *const GPDaCellID = @"GPDaRenCell";
@interface GPDaRenController ()
@property (nonatomic, strong) NSMutableArray *daRenArray;
@property (nonatomic, copy) NSString *lastTimeId;

@end

@implementation GPDaRenController

#pragma mark---
- (NSMutableArray*)daRenArray
{
    if (!_daRenArray) {
        _daRenArray = [[NSMutableArray alloc] init];
    }
    return _daRenArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self registCell];
    [self loadData];
}
#pragma mark  ---内部方法
- (void)registCell
{
    self.tableView.rowHeight = 200;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenCell class]) bundle:nil] forCellReuseIdentifier:GPDaCellID];
}

- (void)loadData
{
    //添加下拉刷新
    GPJianDaoHeader *header = [GPJianDaoHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)]; //[self addRefreshHead];
    [header beginRefreshing];
    self.tableView.mj_header = header;
    //添加上啦刷新
    self.tableView.mj_footer = [GPAutoFooter footerWithRefreshingTarget:self
                                                       refreshingAction:@selector(loadMoreData)];
}

//下拉
- (void)loadNewData
{
    //1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"act"] = @"up";
    params[@"vid"] = @"18";
    [self.daRenArray removeAllObjects];
    
    __weak typeof(self) weakSelf = self;
    //2.发起请求
    [GPHttpTool post:@"http://m.shougongke.com/index.php?&c=Index&a=daren" param:params success:^(id responder) {
        NSArray *tempArr = responder[@"data"];
        weakSelf.daRenArray = [GPDaData mj_objectArrayWithKeyValuesArray:tempArr];
        GPDaData *data = weakSelf.daRenArray.lastObject;
        weakSelf.lastTimeId = data.course_time;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError * error) {
        NSLog(@"%@",error);
        [weakSelf.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"跪了"];
    }];
    
}

//上拉
- (void)loadMoreData
{
    //1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"act"] = @"down";
    params[@"vid"] = @"18";
    params[@"last_id"] = self.lastTimeId;
    __weak typeof(self) weakSelf= self;
    
    //2.发起请求
    [GPHttpTool post:@"http://m.shougongke.com/index.php?&c=Index&a=daren" param:params success:^(id responseObj) {
        NSArray *moreNewArray = [GPDaData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        GPDaData *data = moreNewArray.lastObject;
        weakSelf.lastTimeId = data.course_time;
        [weakSelf.daRenArray addObjectsFromArray:moreNewArray];
        [self.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
         NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
    }];
}

#pragma mark ---UITableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.daRenArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.daRenArray.count == 0) {
        return nil;
    }
    GPDaRenCell *daRenCell = [tableView dequeueReusableCellWithIdentifier:GPDaCellID];
    daRenCell.daData = self.daRenArray[indexPath.row];
    daRenCell.imageClick = ^(NSInteger tagCount) {
        [self imageViewClick:tagCount];
    };
    return daRenCell;
}

#pragma mark ---内部方法
- (void)imageViewClick:(NSInteger)tagCount
{
    XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeScanningFromLeft];
    GPDarRenPicController *picVC = [[GPDarRenPicController alloc] init];
    picVC.tagCpunt = [NSString stringWithFormat:@"%ld",tagCount];
    [self xw_presentViewController:picVC withAnimator:animator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

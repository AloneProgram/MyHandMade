//
//  GPDaRenStepTwoCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/3.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDaRenStepTwoCell.h"
#import "GPStepTableViewCell.h"

@interface GPDaRenStepTwoCell()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *stepTableView;

@end

@implementation GPDaRenStepTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup
{
    self.stepTableView.delegate = self;
    self.stepTableView.dataSource = self;
    self.stepTableView.rowHeight = 50;
    self.stepTableView.sectionHeaderHeight = 40;
    self.stepTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.stepTableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPStepTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"stepCell"];
    self.stepTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.stepTableView.tableFooterView = [UIView new];
}
#pragma mark ---懒加载
- (void)setToolArray:(NSArray *)toolArray
{
    _toolArray = toolArray;
    [self.stepTableView reloadData];
}

- (void)setMetariaArray:(NSArray *)metariaArray
{
    _metariaArray = metariaArray;
    [self.stepTableView reloadData];
}

#pragma mark ---UITabelView DataSources
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = self.toolArray.count;
    if (section == 0) {
        rowCount = self.metariaArray.count;
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stepCell"];
    if (indexPath.section == 0) {
        cell.materialData = self.metariaArray[indexPath.row];
    }else {
        cell.toolsData = self.toolArray[indexPath.row];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headLabel = nil;
    if (section == 0) {
        headLabel = [self addHeadView:@"所需材料"];
    }else {
        headLabel = [self addHeadView:@"所需工具"];
    }
    return  headLabel;
}

- (UILabel *)addHeadView:(NSString *)str
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    label.backgroundColor = GPCommonBgColor;
    label.text = str;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
@end

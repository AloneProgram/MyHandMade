//
//  GPDarRenPicController.m
//  MyHandMade
//
//  Created by iKnet on 16/8/3.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDarRenPicController.h"
#import "GPDaRenStepOneCell.h"
#import "GPDaRenStepTwoCell.h"
#import "GPDaRenStepThreeCell.h"
#import "GPHttpTool.h"
#import "GPDaRenPicData.h"
#import "XWCoolAnimator.h"
#import "GPDaRenPicsController.h"


@interface GPDarRenPicController ()
@property (nonatomic, strong) GPDaRenPicData *picData;
@property (nonatomic, strong) NSArray *stepArray;
@property (nonatomic, strong) NSArray *stepToolsArray;
@property (nonatomic, strong) NSArray *stepMaetasArray;
@property (nonatomic, strong) NSArray *stepPicArray;
@end

@implementation GPDarRenPicController

static NSString * const OneIdentifier = @"StepOneCell";
static NSString * const TwoIdentifier = @"StepTwoCell";
static NSString * const TheerIdentifier = @"StepThreenCell";

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self regisCell];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scroolCollection:) name:DaRenStepNotice object:nil];
}

#pragma mark--初始化
- (instancetype)init
{
    //flowLayout布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [self initWithCollectionViewLayout:flowLayout];
}
- (void)setupNav
{
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(5, 25, 30, 30);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:btn];
    
}

- (void)regisCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenStepOneCell class]) bundle:nil] forCellWithReuseIdentifier:OneIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenStepTwoCell class]) bundle:nil] forCellWithReuseIdentifier:TwoIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenStepThreeCell class]) bundle:nil] forCellWithReuseIdentifier:TheerIdentifier];

}
- (void)loadData
{
    //1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Course";
    params[@"a"] = @"CourseDetial";
    params[@"vid"] = @"18";
    params[@"id"] = self.tagCpunt;
    
    __weak typeof(self) weakSelf =self;
    //2.发起请求
    [GPHttpTool get:HomeBaseURL param:params success:^(id responseObj) {
        weakSelf.picData = [GPDaRenPicData mj_objectWithKeyValues:responseObj[@"data"]];
        
        weakSelf.stepArray = weakSelf.picData.step;
        weakSelf.stepToolsArray = weakSelf.picData.tools;
        weakSelf.stepPicArray = weakSelf.picData.step;
        weakSelf.stepMaetasArray = weakSelf.picData.material;
        
        [weakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"跪了"];
    }];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger row = 1;
    if (section == 2) {
        row = self.stepArray.count;
    }
    return row;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *collectionCell = nil;
    if (indexPath.section == 0) {
        GPDaRenStepOneCell *oneCell = [collectionView dequeueReusableCellWithReuseIdentifier:OneIdentifier forIndexPath:indexPath];
        oneCell.picData = self.picData;
        collectionCell = oneCell;
    }else if (indexPath.section == 1) {
        GPDaRenStepTwoCell *twoCell = [collectionView dequeueReusableCellWithReuseIdentifier:TwoIdentifier forIndexPath:indexPath];
        twoCell.toolArray = self.stepToolsArray;
        twoCell.metariaArray = self.stepMaetasArray;
        collectionCell = twoCell;
    }else {
        GPDaRenStepThreeCell *threeCell = [collectionView dequeueReusableCellWithReuseIdentifier:TheerIdentifier forIndexPath:indexPath];
        threeCell.sunNum = self.stepPicArray.count;
        threeCell.cureentNum = indexPath.row + 1;
        threeCell.stepData = self.stepPicArray[indexPath.row];
        threeCell.stepBntClick = ^{
            [self stepPicBtnClick];
        };
        collectionCell = threeCell;
    }
    
    return collectionCell;
}

#pragma mark <UICollectionViewDelegate>

#pragma mark --通知方法
- (void)scroolCollection:(NSNotification *)ifno
{
    NSIndexPath *indexPath = ifno.userInfo[@"pic"];
    CGPoint point = CGPointMake((indexPath.row + 2) * SCREEN_WIDTH, 0);
    [self.collectionView setContentOffset:point];
}

#pragma mark ---- 内部方法
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)btnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)stepPicBtnClick
{
    XWCoolAnimator *animatr = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePageFlip];
    GPDaRenPicsController *picsVC = [[GPDaRenPicsController alloc] init];
    picsVC.stepDataArray = self.stepPicArray;
    //picsVC.picData = self.picData;
    [self xw_presentViewController:picsVC withAnimator:animatr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

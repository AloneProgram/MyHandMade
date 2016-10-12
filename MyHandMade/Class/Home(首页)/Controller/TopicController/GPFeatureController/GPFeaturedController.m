//
//  GPFeaturedController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPFeaturedController.h"
#import "SDCycleScrollView.h"
#import "GPDataViewModel.h"
#import "GPData.h"
#import "GPslid.h"
#import "GPHotData.h"
#import "GPWebViewController.h"
#import "GPHotCell.h"
#import "GPNavigationCell.h"
#import "GPAdvanceCell.h"
#import "GPSectionHeadView.h"
#import "GPJianDaoHeader.h"
#import "GPSlideHeadViewView.h"
#import "GPHttpTool.h"
#import "GPNavigation.h"
#import "GPSlideEventController.h"
#import "XWCoolAnimator.h"
#import "XWDrawerAnimator.h"
#import "GPMainWebController.h"

@interface GPFeaturedController ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSlideArray; //轮播图片数组
@property (nonatomic, strong) NSMutableArray *dataSlideS;      //轮播图数组
@property (nonatomic, strong) NSMutableArray *dataHotArray;    //热帖数组
@property (nonatomic, strong) NSMutableArray *dataAdvanceArray;  //推荐数组
@property (nonatomic, strong) NSMutableArray *dataNavigationArray; //图标数组

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) GPDataViewModel *dataViewModel;
@property (nonatomic, strong) GPData *data;
@property (nonatomic, weak) GPWebViewController *webVC;
@end


static NSString * const GPAdvance = @"AdvanceCell";
static NSString * const GPHot = @"HotCell";
static NSString * const GPNaviga = @"NavigationCell";
static NSString * const GPSlideHead = @"SlideHeadView";
static NSString * const GPSectionHead = @"HotSectionCell";

@implementation GPFeaturedController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configNav];
    
    [self loadData];
    
    [self registCell];
    
}
#pragma mark----懒加载
- (NSMutableArray *)dataSlideArray
{
    if (!_dataSlideArray) {
        _dataSlideArray = [NSMutableArray array];
    }
    return _dataSlideArray;
}
- (NSMutableArray *)dataHotArray
{
    if (!_dataHotArray) {
        _dataHotArray = [NSMutableArray array];
    }
    return _dataHotArray;
}
- (NSMutableArray *)dataSlideS
{
    if (!_dataSlideS) {
        _dataSlideS = [NSMutableArray array];
    }
    return _dataSlideS;
}
- (NSMutableArray *)dataAdvanceArray
{
    if (!_dataAdvanceArray) {
        _dataAdvanceArray = [NSMutableArray array];
    }
    return _dataAdvanceArray;
}
- (NSMutableArray *)dataNavigationArray
{
    if (!_dataNavigationArray) {
        _dataNavigationArray = [NSMutableArray array];
    }
    return _dataNavigationArray;
}

#pragma mark----初始化
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return [self initWithCollectionViewLayout:layout];
}

- (void)configNav
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, GPTabBarH, 0);
}
- (void)registCell
{
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"GPNavigationCell" bundle:nil]forCellWithReuseIdentifier:GPNaviga];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GPAdvanceCell" bundle:nil] forCellWithReuseIdentifier:GPAdvance];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GPHotCell" bundle:nil] forCellWithReuseIdentifier:GPHot];
    
    // 注册 headView
    [self.collectionView registerClass:[GPSlideHeadViewView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GPSlideHead];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPSectionHeadView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GPSectionHead];
}

- (void)loadData
{
    GPJianDaoHeader *header = [GPJianDaoHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
   
    [header beginRefreshing];
    
    self.collectionView.mj_header = header;
}

- (void)loadNewData
{
    //1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"index";
    params[@"a"] = @"indexNewest";
    params[@"vid"] = @"19";
    
    __weak typeof(self) weakSelf = self;

    //发起请求
    [GPHttpTool get:HomeBaseURL param:params success:^(id responseObj) {
        //移除原来数据
        [self.dataSlideS removeAllObjects];
        [self.dataHotArray removeAllObjects];
        [self.dataSlideArray removeAllObjects];
        [self.dataAdvanceArray removeAllObjects];
        [self.dataNavigationArray removeAllObjects];
        
        //字典转模型
        self.data = [GPData mj_objectWithKeyValues:responseObj[@"data"]];
        //轮播图数组
        for (GPslid *slide in self.data.slide) {
            [weakSelf.dataSlideArray addObject:slide.host_pic];
            [weakSelf.dataSlideS addObject:slide];
        }
        //添加轮播图
        [self addSDCycleView];
        //热帖数组
        for (GPHotData *hotData in self.data.hotTopic) {
            [weakSelf.dataHotArray addObject:hotData];
        }
        //图标数组
        for (GPNavigation *navigationData in self.data.navigation) {
            [weakSelf.dataNavigationArray addObject:navigationData];
        }
        //添加签到模型
        [weakSelf.dataNavigationArray addObject:[self addQianDaoData]];
        //推荐数组
        for (GPAdvanceData *advanceData in self.data.advance) {
            [weakSelf.dataAdvanceArray addObject:advanceData];
        }
        [weakSelf.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"&@",error);
        [weakSelf.collectionView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"失败了,再来一次"];
    }];
}


#pragma mark---内部方法
//添加签到模型
- (GPNavigation *)addQianDaoData
{
    GPNavigation *qianDaoData = [[GPNavigation alloc] init];
    qianDaoData.pic = @"http://image.shougongke.com/app/index/navigation/appIndexNav12.png";
    qianDaoData.name = @"签到";
    return qianDaoData;
}
-(void)addSDCycleView
{
    CGFloat cycleX = 0;
    CGFloat cycleY = 0;
    CGFloat cycleW = SCREEN_WIDTH;
    CGFloat cycleH = SCREEN_HEIGHT * 0.25;
    CGRect rect = CGRectMake(cycleX, cycleY, cycleW, cycleH);
    SDCycleScrollView *sycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:[UIImage imageNamed:@"2"]];
    self.cycleScrollView = sycleScrollView;
    self.cycleScrollView.imageURLStringsGroup = self.dataSlideArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --- 轮播图代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    GPslid *slide = self.dataSlideS[index];
    if ([slide.itemtype isEqualToString:@"class_special"] || [slide.itemtype isEqualToString:@"topic_detail_h5"]) {
        GPHotData *hotData = [[GPHotData alloc] init];
        hotData.pic = slide.host_pic;
        NSString *urlString ;
        if ([slide.itemtype isEqualToString:@"class_special"]) {
            urlString = [NSString stringWithFormat:@"http://www.shougongke.com/index.php?m=HandClass&a=%@&spec_id=%@",slide.itemtype,slide.hand_id];
        }else if([slide.itemtype isEqualToString:@"topic_detail_h5"]) {
            urlString = slide.hand_id;
        }
        hotData.mob_h5_url = urlString;
        GPMainWebController *webVC = [UIStoryboard storyboardWithName:NSStringFromClass([GPMainWebController class]) bundle:nil].instantiateInitialViewController;
        webVC.hotData = hotData;
        XWCoolAnimator *animotor = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePortal];
        [self xw_presentViewController:webVC withAnimator:animotor];

    }else if ([slide.itemtype isEqualToString:@"event"]){
        GPSlideEventController *slideVC = [[GPSlideEventController alloc] init];
        slideVC.handId = slide.hand_id;
        [self.navigationController pushViewController:slideVC animated:YES];
    }else if ([slide.itemtype isEqualToString:@"web_out"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:slide.hand_id]];
    }else {  //课程页面
       
    }
}


#pragma mark ----UICollectionView布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat W = SCREEN_WIDTH / (self.dataNavigationArray.count + 0.8);
        return CGSizeMake(W, W);
    }else if(indexPath.section == 1)
    {
        return CGSizeMake(SCREEN_WIDTH * 0.48,SCREEN_WIDTH * 0.4);
    }else{
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * 0.5);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark ---UICollectionView代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        XWCoolAnimator *animotor = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePortal];
        GPMainWebController *webVC = [UIStoryboard storyboardWithName:NSStringFromClass([GPMainWebController class]) bundle:nil].instantiateInitialViewController;
        webVC.hotData = self.dataHotArray[indexPath.row];
        [self xw_presentViewController:webVC withAnimator:animotor];
    }else if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            GPWebViewController *webVc = [UIStoryboard storyboardWithName:NSStringFromClass([GPWebViewController class]) bundle:nil].instantiateInitialViewController;
            webVc.navigationData = self.dataNavigationArray[indexPath.row];
            [self.navigationController pushViewController:webVc animated:YES];
        }else {
            //具体控制器还未创建,先给个跳转
            XWCoolAnimator *animotor = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePortal];
            GPMainWebController *webVC = [UIStoryboard storyboardWithName:NSStringFromClass([GPMainWebController class]) bundle:nil].instantiateInitialViewController;
            webVC.hotData = self.dataHotArray[indexPath.row];
            [self xw_presentViewController:webVC withAnimator:animotor];
        }
    }else if (indexPath.section == 1) {
        //具体控制器还未创建,先给个跳转
        XWCoolAnimator *animotor = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePortal];
        GPMainWebController *webVC = [UIStoryboard storyboardWithName:NSStringFromClass([GPMainWebController class]) bundle:nil].instantiateInitialViewController;
        webVC.hotData = self.dataHotArray[indexPath.row];
        [self xw_presentViewController:webVC withAnimator:animotor];
    }
}

#pragma mark -UICollectionView 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return NumberSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataNavigationArray.count;   //图标
    }else if (section == 1){
        return self.dataAdvanceArray.count;    //推荐
    }else {
        return self.dataHotArray.count;      //热点
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GPNavigationCell *navigationCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPNaviga forIndexPath:indexPath
                                            ];
        navigationCell.navigationData = self.dataNavigationArray[indexPath.row];
        return navigationCell;
    }else if (indexPath.section == 1) {
        GPAdvanceCell *advanceCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPAdvance forIndexPath:indexPath];
        advanceCell.advancedata = self.dataAdvanceArray[indexPath.row];
        return advanceCell;
    }else {
        GPHotCell *hotCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPHot forIndexPath:indexPath];
        hotCell.hotData = self.dataHotArray[indexPath.row];
        return hotCell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headView = nil;
    if (indexPath.section == 0) {
        headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GPSlideHead forIndexPath:indexPath];
        [headView addSubview:self.cycleScrollView];
    }else if (indexPath.section == 2) {
        headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GPSectionHead forIndexPath:indexPath];
    }
    return headView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeZero;
    if (section == 0) {
        size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT *0.25);
    }else if (section == 2){
        size = CGSizeMake(SCREEN_WIDTH, GPTitlesViewH);
    }
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CATransform3D rotation;//3D旋转
    rotation = CATransform3DMakeRotation(M_PI_4, 0.0, 0.7, 0.4);
    rotation = CATransform3DScale(rotation, 0.8, 0.8, 1);
    rotation.m34 = 1.0/1000;
    
    cell.layer.shadowColor = [UIColor redColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:NULL];
    
    //旋转时间
    [UIView setAnimationDuration:0.6];
    
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

@end

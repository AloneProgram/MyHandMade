//
//  GPSlideSuperController.m
//  MyHandMade
//
//  Created by iKnet on 16/8/22.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPSlideSuperController.h"
#import "GPslid.h"
#import "GPHttpTool.h"
#import "GPJianDaoHeader.h"
#import "GPAutoFooter.h"
#import "GPSlideShopData.h"
#import "GPSlideCollectionViewCell.h"

@interface GPSlideSuperController ()
@property (nonatomic, copy) NSString *lastId;  //标记
@property (nonatomic, strong) NSMutableArray *dataS;
@end

static NSString *const GPShopCell = @"shopCell";

@implementation GPSlideSuperController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    //flowLayout布局
    UICollectionViewFlowLayout *flowlayout= [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = SCREEN_WIDTH * 0.43;
    flowlayout.itemSize = CGSizeMake(W, W*1.25);
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [self initWithCollectionViewLayout:flowlayout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registCell];
    [self addHeadAndFoot];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)dataS
{
    if (!_dataS) {
        _dataS = [[NSMutableArray alloc] init];
    }
    return _dataS;
}

- (void)registCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPSlideCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:GPShopCell];
}

- (void)setSlide:(GPslid *)slide
{
    _slide = slide;
    self.handID = _slide.hand_id;
}

- (void)addHeadAndFoot
{
    GPJianDaoHeader *header = [GPJianDaoHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewdata)];
    [header beginRefreshing];
    self.collectionView.mj_header = header;
    
    self.collectionView.mj_footer = [GPAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

 -(void)loadNewdata
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Competition";
    params[@"a"] = @"getOpus";
    params[@"cid"] = self.handID;
    params[@"order"] = self.paramA;
    params[@"vid"] = @"16";
    
    [self loadData:params withTag:1];
}

- (void)loadMoreData
{
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Competition";
    params[@"a"] = @"getOpus";
    params[@"cid"] = self.handID;
    params[@"order"] = self.paramA;
    params[@"vid"] = @"16";
    params[@"last_opus_id"] = self.lastId;
    
    [self loadData:params withTag:2];
}
- (void)loadData:(NSMutableDictionary *)params withTag:(NSInteger )tag
{
    __weak typeof(self) weakSelf = self;
    
    [GPHttpTool get:HomeBaseURL param:params success:^(id responseObj) {
        if (tag == 1) {  //下拉刷新
            weakSelf.dataS = [GPSlideShopData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            GPSlideShopData *eventData = [weakSelf.dataS lastObject];
            self.lastId = eventData.last_id;
            [weakSelf.collectionView.mj_header endRefreshing];
        }else if (tag == 2){
            NSArray *moreNewArray = [GPSlideShopData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            GPSlideShopData *eventData = [moreNewArray lastObject];
            self.lastId = eventData.last_id;
            [weakSelf.dataS addObjectsFromArray:moreNewArray];
            [weakSelf.collectionView.mj_footer endRefreshing];
            
        }
        [self.collectionView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (tag == 2) {
            [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
        }
    }];
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataS.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPSlideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPShopCell forIndexPath:indexPath];
    cell.shopData = self.dataS[indexPath.row];
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CATransform3D rotation;  //3D旋转
//    rotation = CATransform3DMakeTranslation(0, 50, 20);
//    rotation = CATransform3DScale(rotation, 0.6, 0.6, 0.1);
//    rotation.m34 = 1.0/1000;
//    
//    cell.layer.shadowColor = [UIColor redColor].CGColor;
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    
//    cell.layer.transform = rotation;
//    [UIView beginAnimations:@"rotation" context:NULL];
//    
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1.0;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
//}



#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击第%@个cell",indexPath.row);
}

#pragma mark ---UIScrollview代理
static int _lastPosition;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPosition = scrollView.contentOffset.y;
    if (currentPosition - _lastPosition > 60) {
        _lastPosition = currentPosition;
        [[NSNotificationCenter defaultCenter] postNotificationName:SnowUP object:nil];
    }else if (_lastPosition - currentPosition > 60)
    {
        _lastPosition = currentPosition;
        [[NSNotificationCenter defaultCenter] postNotificationName:SnowDown object:nil];
    }
}

@end

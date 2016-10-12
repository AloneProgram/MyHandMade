//
//  GPFocusController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPFocusController.h"
#import "GPLayout.h"
#import "GPFocuswCell.h"

static NSString *const fouceCell = @"focusCell";
@interface GPFocusController ()
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *contentImageArray;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *contentArray;

@end

@implementation GPFocusController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registCell];
    [self loadData];
    self.collectionView.backgroundColor = GPCommonBgColor;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, GPTabBarH, 0);
}

- (instancetype)init
{
    GPLayout *layout = [[GPLayout alloc] init];
    CGFloat W = SCREEN_WIDTH - 20;
    CGFloat H = SCREEN_HEIGHT * 0.3;
    layout.itemSize = CGSizeMake(W, H);
    return [self initWithCollectionViewLayout:layout];
}

- (void)registCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPFocuswCell class]) bundle:nil] forCellWithReuseIdentifier:fouceCell];
    
}

- (void)loadData
{
    //登陆后获取的数据,暂时用假数据
    NSArray *iconArray = @[@"001",@"002",@"003",@"004",@"005"];
    self.iconArray = iconArray;
    NSArray *contentImgArray = @[@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg"];
    self.contentImageArray = contentImgArray;
    NSArray *nameArray = @[@"我是小菜蛋对你点赞了",@"我是小菜蛋关注了你",@"我是小菜蛋求你赏个赞呗",@"我是小菜蛋求你给个关注呗",@"我是小菜蛋祝你发大财"];
    self.nameArray = nameArray;
    NSArray *contenArray = @[@"哈哈哈哈,下拉&点击有惊喜呀,要不要试一试呢",@"暗恋的女孩告诉我，如果我喜欢她就别说出来，因为愿望说出来就不灵了。这道理我懂!",@"你现在不喜欢我，我告诉你，过了这个村，我在下一个村等你!!",@"我姓黄，又在秋天出生，所以我叫黄天出",@"哈哈哈,上拉&点击也有惊喜"];
    self.contentArray = contenArray;
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    GPFocuswCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:fouceCell forIndexPath:indexPath];
    cell.iconStr = self.iconArray[indexPath.section];
    cell.imageStr = self.contentImageArray[indexPath.section];
    cell.nameStr = self.nameArray[indexPath.section];
    cell.contentStr = self.contentArray[indexPath.section];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 3) {
        [self openUrl:Blog];
    }else {
        [self openUrl:Github];
    }
}

- (void)openUrl:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end

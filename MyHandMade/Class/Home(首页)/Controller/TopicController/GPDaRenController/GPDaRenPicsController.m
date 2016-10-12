//
//  GPDaRenPicsController.m
//  MyHandMade
//
//  Created by iKnet on 16/8/1.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDaRenPicsController.h"
#import "GPDaRenStepData.h"
#import "GPDaRenPicsCell.h"

@interface GPDaRenPicsController ()

@end

@implementation GPDaRenPicsController

static NSString * const reuseIdentifier = @"PicsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenPicsCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (instancetype)init
{
    CGFloat margin = 10;
    //layout布局
    CGFloat W = (SCREEN_WIDTH - 4*margin) / 3;
    CGFloat H = W * 1.5;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(W, H);
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return [self initWithCollectionViewLayout:layout];
    
}

#pragma mark ---数据处理
- (void)setStepDataArray:(NSArray *)stepDataArray
{
    _stepDataArray = stepDataArray;
    [self.collectionView reloadData];
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stepDataArray.count;;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    GPDaRenPicsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.picData = self.picData;
    cell.stepData = self.stepDataArray[indexPath.row];
    cell.currtNum = indexPath.row + 1;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:DaRenStepNotice object:nil userInfo:@{@"pic":indexPath}];
}

@end

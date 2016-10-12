//
//  GPDaRenPicsCell.h
//  MyHandMade
//
//  Created by iKnet on 16/8/1.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPDaRenStepData,GPDaRenPicData;
@interface GPDaRenPicsCell : UICollectionViewCell
@property (nonatomic, strong) GPDaRenStepData *stepData;
@property (nonatomic, strong) GPDaRenPicData *picData;
@property (nonatomic, assign) NSInteger currtNum;

@end

//
//  GPDaRenStepThreeCell.h
//  MyHandMade
//
//  Created by iKnet on 16/8/8.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPDaRenStepData;
@interface GPDaRenStepThreeCell : UICollectionViewCell
@property (nonatomic, strong) GPDaRenStepData *stepData;
@property (nonatomic, assign) NSInteger sunNum;
@property (nonatomic, assign) NSInteger cureentNum;
@property (nonatomic, copy) void (^stepBntClick)();
@end

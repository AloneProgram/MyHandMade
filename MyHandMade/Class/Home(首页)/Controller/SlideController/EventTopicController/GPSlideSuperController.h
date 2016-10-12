//
//  GPSlideSuperController.h
//  MyHandMade
//
//  Created by iKnet on 16/8/22.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPslid;
@interface GPSlideSuperController : UICollectionViewController
@property (nonatomic, strong) GPslid *slide;
@property (nonatomic, copy) NSString *handID;  //记录点击轮播的参数

- (NSString *)paramA;
@end

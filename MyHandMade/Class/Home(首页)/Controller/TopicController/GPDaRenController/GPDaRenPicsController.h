//
//  GPDaRenPicsController.h
//  MyHandMade
//
//  Created by iKnet on 16/8/1.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  GPDaRenPicData;
@interface GPDaRenPicsController : UICollectionViewController
@property (nonatomic, strong) GPDaRenPicData *picData;
@property (nonatomic, strong) NSArray *stepDataArray;
@end

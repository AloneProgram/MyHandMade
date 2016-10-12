//
//  GPStepTableViewCell.h
//  MyHandMade
//
//  Created by iKnet on 16/8/3.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPDaRenToolsData,GPDaRenMaterialData;
@interface GPStepTableViewCell : UITableViewCell
@property (nonatomic, strong) GPDaRenToolsData *toolsData;
@property (nonatomic, strong) GPDaRenMaterialData *materialData;
@end

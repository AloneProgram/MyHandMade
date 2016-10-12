//
//  GPStepTableViewCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/3.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPStepTableViewCell.h"
#import "GPDaRenMaterialData.h"
#import "GPDaRenToolsData.h"

@interface GPStepTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation GPStepTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setMaterialData:(GPDaRenMaterialData *)materialData
{
    _materialData = materialData;
    self.nameLabel.text =  materialData .name;
    self.countLabel.text = materialData.num;
}
- (void)setToolsData:(GPDaRenToolsData *)toolsData
{
    _toolsData = toolsData;
    self.nameLabel.text =  toolsData.name;
    self.countLabel.text = toolsData.num;
}

@end

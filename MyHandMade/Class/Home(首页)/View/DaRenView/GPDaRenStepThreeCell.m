//
//  GPDaRenStepThreeCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/8.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDaRenStepThreeCell.h"
#import "GPDaRenStepDaTa.h"

@interface GPDaRenStepThreeCell()
@property (weak, nonatomic) IBOutlet UIButton *stepBtn;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *intLabel;


@end

@implementation GPDaRenStepThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.stepBtn.layer.borderWidth = 1;
    self.stepBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.stepBtn.layer.masksToBounds = YES;
    self.stepBtn.layer.cornerRadius = 12;
}

- (void)setStepData:(GPDaRenStepData *)stepData
{
    _stepData = stepData;
    NSURL *picUrl = [NSURL URLWithString:_stepData.pic];
    [self.contentImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"3"]];
    self.intLabel.text = stepData.content;
    [self.stepBtn setImage:[UIImage imageNamed:@"ic_course_sort_all"] forState:UIControlStateNormal];
    NSString *stepStr = [NSString stringWithFormat:@"步骤%ld/%ld",self.cureentNum,self.sunNum];
    [self.stepBtn setTitle:stepStr forState:UIControlStateNormal];
}

- (IBAction)stepBtnClick:(id)sender {
    if (self.stepBntClick) {
        self.stepBntClick();
    }
}


@end

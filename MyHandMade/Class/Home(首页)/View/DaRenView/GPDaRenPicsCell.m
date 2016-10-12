//
//  GPDaRenPicsCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/1.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDaRenPicsCell.h"
#import "GPDaRenStepData.h"
#import "GPDaRenPicData.h"

@interface GPDaRenPicsCell ()
@property (weak, nonatomic) IBOutlet UILabel *currtentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation GPDaRenPicsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 5;
    self.currtentLabel.layer.masksToBounds = YES;
    self.currtentLabel.layer.cornerRadius = 3;
}

- (void)setStepData:(GPDaRenStepData *)stepData
{
    _stepData = stepData;
    NSURL *url = [NSURL URLWithString:stepData.pic_s];
    [self.contentImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"2"]];
    self.subTitleLabel.text = stepData.content;
}

- (void)setCurrtNum:(NSInteger)currtNum
{
    _currtNum = currtNum;
    self.currtentLabel.text = [NSString stringWithFormat:@"%ld",currtNum];
}

//- (void)setPicData:(GPDaRenPicData *)picData
//{
//    _picData = picData;
//    self.subTitleLabel.text = picData.subject;
//}

@end

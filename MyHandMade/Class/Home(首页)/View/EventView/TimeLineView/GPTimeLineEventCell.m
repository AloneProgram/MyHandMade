//
//  GPTimeLineEventCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/24.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPTimeLineEventCell.h"
#import "GPTimeLineData.h"
#import "UIView+SDAutoLayout.h"

@interface GPTimeLineEventCell()
@property (nonatomic, strong) UIButton *eventBtn;
@property (nonatomic, strong) UIButton *voteBtn;
@property (nonatomic, strong) UIButton *countBtn;
@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation GPTimeLineEventCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUp
{
    self.eventBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.eventBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.eventBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.eventBtn addTarget:self action:@selector(eventBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.arrowImageView = [UIImageView new];
    self.arrowImageView.image = [UIImage imageNamed:@"jiantou_right"];
    
    self.countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.countBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.countBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.countBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.countBtn.layer.borderWidth = 1;
    
    self.voteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.voteBtn setBackgroundColor:[UIColor orangeColor]];
    [self.voteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.voteBtn setTitle:@"投票" forState:UIControlStateNormal];
    [self.voteBtn addTarget:self action:@selector(voteBtnClick) forControlEvents:UIControlEventTouchUpInside];

    NSArray *childS = @[self.eventBtn,self.countBtn,self.arrowImageView,self.voteBtn];
    [self.contentView sd_addSubviews:childS];
    
    [self addLayout];
}

- (void)addLayout
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  GPTimeLineHeadCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/23.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPTimeLineHeadCell.h"
#import "UIView+SDAutoLayout.h"
#import "GPTimeLineData.h"
#import "GPHandeListData.h"
#import "GPPhotoContainerView.h"

@interface GPTimeLineHeadCell()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) GPPhotoContainerView *photoView;

@end

@implementation GPTimeLineHeadCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return  self;
}

- (void)setUp
{
    self.iconImageView = [[UIImageView alloc] init];
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = GPNameColor;
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = [UIColor lightGrayColor];
    
    self.photoView = [[GPPhotoContainerView alloc] init];
    
    NSArray *chlidS = @[self.iconImageView,self.timeLabel,self.contentLabel,self.photoView];
    [self.contentView sd_addSubviews:chlidS];
    
    //添加约束
    [self addLayout];
    
}

- (void)addLayout
{
    CGFloat margin = 10;
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin)
    .widthIs(40)
    .heightIs(40);
    self.iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    self.nameLabel.sd_layout
    .topEqualToView(self.iconImageView)
    .leftSpaceToView(self.iconImageView, margin)
    .heightIs(18);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.iconImageView,margin)
    .bottomEqualToView(self.iconImageView)
    .heightIs(10);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.contentLabel.sd_layout
    .leftEqualToView(self.iconImageView)
    .topSpaceToView(self.iconImageView,10)
    .rightSpaceToView(self.contentView,margin)
    .autoHeightRatio(0);
    
    self.photoView.sd_layout
    .leftEqualToView(self.iconImageView)
    .topSpaceToView(self.contentLabel,margin);
    
    [self setupAutoHeightWithBottomViewsArray:@[self.contentLabel,self.photoView] bottomMargin:margin];
    
    
}

- (void)setTimeLineData:(GPTimeLineData *)timeLineData
{
    _timeLineData = timeLineData;
    
    NSURL *picUrl = [NSURL URLWithString:_timeLineData.avatar];
    [self.iconImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.contentLabel.text = _listData.subject;
    self.timeLabel.text = _listData.add_time;
    self.nameLabel.text = _listData.uname;
}

- (void)setListData:(GPHandeListData *)listData
{
    _listData = listData;
    
    NSURL *picUrl = [NSURL URLWithString:_listData.avatar];
    [self.iconImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.contentLabel.text = _listData.subject;
    self.timeLabel.text = _listData.add_time;
    self.nameLabel.text = _listData.uname;
}

- (void)setPicUrlArray:(NSMutableArray *)picUrlArray
{
    _picUrlArray = picUrlArray;
    
    self.photoView.picPathStringsArray = picUrlArray;
}

- (void)setSizeArray:(NSMutableArray *)sizeArray
{
    _sizeArray = sizeArray;
    
    self.photoView.sizeArray = sizeArray;
}

@end

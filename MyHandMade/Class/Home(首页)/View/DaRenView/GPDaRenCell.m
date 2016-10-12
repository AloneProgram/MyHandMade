//
//  GPDaRenCell.m
//  MyHandMade
//
//  Created by iKnet on 16/8/1.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPDaRenCell.h"
#import "GPDaData.h"

@interface GPDaRenCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *guanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageview;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (nonatomic, strong) NSArray *picArray;
@property (nonatomic, strong) NSMutableArray *handArray;
@end

@implementation GPDaRenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.picArray = @[self.oneImageView,self.twoImageview,self.threeImageView];
    
}

#pragma mark---懒加载
- (NSMutableArray *)handArray
{
    if (!_handArray) {
        _handArray = [NSMutableArray array];
    }
    return _handArray;
}

- (IBAction)guanBtnClick:(UIButton *)sender {
    sender.selected = YES;
    self.guanBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setDaData:(GPDaData *)daData
{
    _daData = daData;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.guanBtn.layer.cornerRadius = 5;
    self.guanBtn.layer.borderWidth = 1;
    self.guanBtn.layer.masksToBounds = YES;
    if (self.guanBtn.selected != YES) {
        self.guanBtn.selected = NO;
        self.guanBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
    
    NSURL *url = [NSURL URLWithString:daData.avatar];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1"]];
    self.nameLabel.text = daData.nick_name;
    NSString *str = [NSString stringWithFormat:@"%@图文教程|%@视频教程|%@手工圈",daData.course_count,daData.video_count,daData.opus_count];
    self.subTitleLabel.text = str;
    
    int i =0;
    for (NSDictionary *dic in daData.list) {
        [self addImage:dic[@"host_pic"] iamgeView:self.picArray[i] tag:dic[@"hand_id"]];
        [self addTapGesture:self.picArray[i]];
        
        i++;
    }
}

#pragma mark --内部方法
- (void)addImage:(NSString *)picUrl iamgeView:(UIImageView *)imageView tag:(NSString *)tapStr
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"2"]];
    imageView.tag = [tapStr intValue];
}
- (void)addTapGesture:(UIImageView *)imageView
{
    UITapGestureRecognizer *tapGs = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    [imageView addGestureRecognizer:tapGs];
}

- (void)imageViewClick:(UITapGestureRecognizer *)gesture
{
    UIImageView *imageView = (UIImageView *)[gesture view];
    if (self.imageClick) {
        self.imageClick(imageView.tag);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

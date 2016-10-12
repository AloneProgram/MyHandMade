//
//  GPWebViewController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPWebViewController.h"
#import "GPslid.h"
#import "GPNavigation.h"
#import "GPTopListData.h"
#import "GPFairHotData.h"

@interface GPWebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
//@property (weak, nonatomic) IBOutlet UINavigationItem *itemTitle;

@end

@implementation GPWebViewController

- (void)viewWillAppear:(BOOL)animated
{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
}

#pragma mark----初始化设置
- (void)configNav
{
    self.loadWebView.scalesPageToFit = YES;
    self.loadWebView.backgroundColor = [UIColor whiteColor];
    self.loadWebView.scrollView.delegate = self;
}

#pragma mark -----数据处理
- (void) setHotData:(GPFairHotData *)fairHotData
{
    _fairHotData = fairHotData;
    if (fairHotData.special_id.length) {
        [self loadSlidDataType:fairHotData.special_id title:@"专题详情"];
    }
}
//市集
- (void)setListData:(GPTopListData *)listData
{
    _listData = listData;
    if (listData.mob_h5_url.length) {
        [self loadSlidDataType:listData.mob_h5_url title:@"专题详情"];
    }
}
//秒杀
- (void)setNavigationData:(GPNavigation *)navigationData
{
    _navigationData = navigationData;
    if (navigationData.mob_h5_url.length) {
        [self loadSlidDataType:navigationData.mob_h5_url title:@"专题详情"];
    }
}
//活动
- (void)setHandId:(NSString *)handId
{
    _handId = handId;
    NSString *urlString = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?c=Competition&cid=%@",self.handId];
    [self loadSlidDataType:urlString title:nil];
}
//轮播图
- (void)setSlide:(GPslid *)slide
{
    _slide = slide;
    if ([slide.itemtype isEqualToString:@"class_special"]) {
        NSString *urlString = [NSString stringWithFormat:@"http://www.shougongke.com/index.php?m=HandClass&a=%@&spec_id=%@",slide.itemtype,slide.hand_id];
        [self loadSlidDataType:urlString title:@"课堂专题"];
        
    }else if([slide.itemtype isEqualToString:@"topic_detail_h5"]) {
        
        NSString *urlString = slide.hand_id;
        [self loadSlidDataType:urlString title:@"专题详情"];
    }else if([slide.itemtype isEqualToString:@"event"]){
        //http://m.shougongke.com/index.php?c=Competition&cid=110
        NSString *urlString = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?c=Competition&cid=%@",slide.hand_id];
        [self loadSlidDataType:urlString title:nil];
    }
}

- (void)loadSlidDataType:(NSString *)urlString title:(NSString *)title
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.view addSubview:self.loadWebView];
    [self.loadWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.navigationItem.title = title;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark----UIScrollView代理
static int _lastPosition;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPosition = scrollView.contentOffset.y;
    if (currentPosition - _lastPosition > 25) {
        _lastPosition = currentPosition;
        [[NSNotificationCenter defaultCenter] postNotificationName:SnowUP object:nil];
    }else if (_lastPosition - currentPosition > 25) {
        _lastPosition = currentPosition;
        [[NSNotificationCenter defaultCenter] postNotificationName:SnowDown object:nil];
    }
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

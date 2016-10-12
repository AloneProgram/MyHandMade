//
//  GPMainWebController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/28.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPMainWebController.h"
#import "GPHotData.h"
#import "GPFairBestData.h"
#import "GPFairTopicData.h"

@interface GPMainWebController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UINavigationItem *itemTitle;

@end

@implementation GPMainWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//市集
- (void)setTopicData:(GPFairTopicData *)topicData
{
    _topicData = topicData;
    NSString *str = [NSString stringWithFormat:@"http://www.shougongke.com/index.php?m=Topic&a=topicDetail&topic_id=%@&topic_type=shiji",topicData.topic_id];
    [self loadSlidDataType:str title:@"专题详情"];
}
//购买
- (void)setBestData:(GPFairBestData *)bestData
{
    _bestData = bestData;
    NSString *str = [NSString stringWithFormat:@"http://market.shougongke.com//index.php?c=index&a=shop&open_iid=%@",bestData.open_iid];
    [self loadSlidDataType:str title:nil];
}
//热帖
- (void)setHotData:(GPHotData *)hotData
{
    _hotData = hotData;
    if (hotData.mob_h5_url.length) {
        [self loadSlidDataType:hotData.mob_h5_url title:@"专题详情"];
    }
}

- (void)loadSlidDataType:(NSString *)urlString title:(NSString *)title
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.itemTitle.title = title;
}

- (IBAction)back:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 50) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end

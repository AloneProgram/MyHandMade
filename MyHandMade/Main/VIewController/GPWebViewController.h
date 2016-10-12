//
//  GPWebViewController.h
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPslid,GPHotData,GPNavigation,GPTopListData,GPFairHotData;

@interface GPWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *loadWebView;
@property (nonatomic, strong) GPslid *slide;
@property (nonatomic, strong) NSString *handId;
@property (nonatomic, strong) GPNavigation *navigationData;
@property (nonatomic, strong) GPTopListData *listData;
@property (nonatomic, strong) GPFairHotData *fairHotData;

@end

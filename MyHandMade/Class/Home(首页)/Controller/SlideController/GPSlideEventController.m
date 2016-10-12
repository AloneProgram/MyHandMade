//
//  GPSlideEventController.m
//  MyHandMade
//
//  Created by iKnet on 16/7/28.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import "GPSlideEventController.h"
#import "GPslid.h"
#import "GPWebViewController.h"
#import "GPEventBtn.h"
#import "HYBBubbleTransition.h"
#import "GPEventNewController.h"
#import "GPEventVoteController.h"

@interface GPSlideEventController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) HYBBubbleTransition *bubbleTransition;
@property (nonatomic, weak) GPEventBtn *eventBtn;
@end

@implementation GPSlideEventController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Image"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self addAllChildVC];
    [self addEventBar];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(snowUp) name:SnowUP object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(snowDown) name:SnowDown object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginVc) name:EventBarClick object:nil];
}

- (void)setupView
{
    self.title = @"活动作品";
    self.view.backgroundColor = [UIColor whiteColor];
    //设置标题样式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleScrollViewColor = [UIColor whiteColor];
        *norColor = [UIColor darkGrayColor];
        *selColor = [UIColor redColor];
        *titleHeight = GPTitlesViewH;
    }];
    
    //设置下标
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        *isShowUnderLine = YES;
        *underLineColor = [UIColor redColor];
    }];
}
- (void)addAllChildVC
{
    GPWebViewController *webVC = [UIStoryboard storyboardWithName:NSStringFromClass([GPWebViewController class]) bundle:nil].instantiateInitialViewController;
    webVC.title = @"活动介绍";
    webVC.slide = self.slide;
    webVC.handId = self.handId;
    [self addChildViewController:webVC];
    
    GPEventNewController *newVC = [[GPEventNewController alloc] init];
    newVC.title = @"最新作品";
    newVC.slide = self.slide;
    newVC.handID = self.handId;
    [self addChildViewController:newVC];
    
    GPEventVoteController *voteVC = [[GPEventVoteController alloc] init];
    voteVC.title = @"投票最多";
    voteVC.slide = self.slide;
    voteVC.handID = self.handId;
    [self addChildViewController:voteVC];
}
- (void)addEventBar
{
    GPEventBtn *eventBtn = [[GPEventBtn alloc]init];
    [eventBtn setImage:[UIImage imageNamed:@"activity"] forState:UIControlStateNormal];
    [eventBtn sizeToFit];
    eventBtn.transform = CGAffineTransformMakeScale(2, 2);
    [eventBtn showEventButCenter:CGPointMake(SCREEN_WIDTH * 0.5 , SCREEN_HEIGHT - GPEventScale * eventBtn.width)];
    [eventBtn addTarget:self action:@selector(loginVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventBtn];
    [self.view bringSubviewToFront:eventBtn];
    self.eventBtn = eventBtn;
    
}

#pragma mark - 通知回调
- (void)snowUp
{
    [self.eventBtn showAnamEventBtnCenter:CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT + GPEventScale * self.eventBtn.width)];
    
}
- (void)snowDown
{
    [self.eventBtn showAnamEventBtnCenter:CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT - GPEventScale * self.eventBtn.width)];
}
- (void)loginVc
{
//    GPLoginController *loginVc = [UIStoryboard storyboardWithName:NSStringFromClass([GPLoginController class]) bundle:nil].instantiateInitialViewController;
//    
//    loginVc.modalPresentationStyle = UIModalPresentationCustom;
//    
//    self.bubbleTransition = [[HYBBubbleTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
//        
//        HYBBubbleTransition *bubble = (HYBBubbleTransition *)transition;
//        
//        bubble.bubbleColor = presented.view.backgroundColor;
//        
//        // 由于一个控制器有导航，一个没有，导致会有64的误差，所以要记得处理这种情况
//        CGPoint center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT - GPEventScale * self.eventBtn.height);
//        bubble.bubbleStartPoint = center;
//    } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
//        transition.transitionMode = kHYBTransitionDismiss;
//    }];
//    loginVc.transitioningDelegate = self.bubbleTransition;
//    [self presentViewController:loginVc animated:YES completion:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

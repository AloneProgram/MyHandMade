//
//  GPHandeListData.h
//  MyHandMade
//
//  Created by iKnet on 16/8/23.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPHandeListData : NSObject
@property (nonatomic,copy) NSString *uname;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic, strong) NSArray *pic;
@property (nonatomic,copy) NSString *subject;
@property (nonatomic, strong) NSArray *comment;
@property (nonatomic,copy) NSString *comment_num;
@property (nonatomic, strong) NSArray *laud_list;
@property (nonatomic,copy) NSString *laud_num;
@property (nonatomic,copy) NSString *add_time;
@end

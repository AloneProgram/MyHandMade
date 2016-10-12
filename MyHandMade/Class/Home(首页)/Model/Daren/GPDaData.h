//
//  GPDaData.h
//  MyHandMade
//
//  Created by iKnet on 16/8/1.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPDaData : NSObject

@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *course_count;
@property (nonatomic,copy) NSString *video_count;
@property (nonatomic,copy) NSString *opus_count;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic,copy) NSString *tb_url;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *course_time;

@end

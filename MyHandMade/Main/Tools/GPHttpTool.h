//
//  GPHttpTool.h
//  MyHandMade
//
//  Created by iKnet on 16/7/27.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPHttpTool : NSObject

+(void)get:(NSString *)url param:(NSDictionary *)param success:(void(^)(id))success failure:(void(^)(NSError *))failure;

+(void)post:(NSString *)url param:(NSDictionary *)param success:(void(^)(id))success failure:(void(^)(NSError *))failure;

@end

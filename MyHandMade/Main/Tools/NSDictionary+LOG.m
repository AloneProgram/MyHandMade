//
//  NSDictionary+LOG.m
//  MyHandMade
//
//  Created by iKnet on 16/7/26.
//  Copyright © 2016年 zzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (LOG)

//只要答应一个数组或字典，系统就会自动调用该方法
- (NSString *)descriptionWithLocale:(id)locale
{
    //定义一个可变的字符串，保存拼接结果
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"{\n"];
    //迭代字典中所有的键值对,拼接到字符串中
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    [strM appendString:@"}"];
    
    //删除最后一个逗号
    if (self.allKeys.count > 0) {
        NSRange range = [strM rangeOfString:@"," options:NSBackwardsSearch];
        [strM deleteCharactersInRange:range];
    }
    
    return strM;
}

@end

@implementation NSArray (LOG)

- (NSString *)descriptionWithLocale:(id)locale
{
    //定义一个可变字符串,保存拼接结果
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"(\n"];
    //迭代字典所有的键值对,拼接到字符串中
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@,\n",obj];
    }];
    [strM appendString:@")\n"];
    
    //删除最后一个逗号
    if (self.count > 0) {
        NSRange range = [strM rangeOfString:@"," options:NSBackwardsSearch];
        [strM deleteCharactersInRange:range];
    }
    
    return strM;
}

@end

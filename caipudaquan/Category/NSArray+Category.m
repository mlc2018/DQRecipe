//
//  NSArray+Category.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/27.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)

+ (NSArray *)arrayNamed:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:path];
}


@end

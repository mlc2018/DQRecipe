//
//  NSArray+Category.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/27.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)

//通过Plist名取到Plist文件中的数组
+(NSArray *)arrayNamed:(NSString *)name;

@end

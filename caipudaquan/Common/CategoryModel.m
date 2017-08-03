//
//  CategoryModel.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/27.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel
+(instancetype)CategoryWithDict:(NSDictionary *)dict
{
    CategoryModel *category =[[self alloc]init];
    [category setValuesForKeysWithDictionary:dict];
    return category;
}

@end

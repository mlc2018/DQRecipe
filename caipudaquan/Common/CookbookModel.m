//
//  CookbookModel.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/31.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "CookbookModel.h"

@implementation CookbookModel

+(instancetype)CookbookWithDict:(NSDictionary *)dict
{
    CookbookModel *cookbook =[[self alloc]init];
    [cookbook setValuesForKeysWithDictionary:dict];
    return cookbook;
}

@end

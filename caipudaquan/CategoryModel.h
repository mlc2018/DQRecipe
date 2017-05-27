//
//  CategoryModel.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/27.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *appurl;

+(instancetype)CategoryWithDict:(NSDictionary *)dict;
@end

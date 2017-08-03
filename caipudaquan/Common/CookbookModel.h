//
//  CookbookModel.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/31.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookbookModel : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *appurl;
@property(nonatomic,strong) NSString *all_click;
@property(nonatomic,strong) NSString *favorites;
@property(nonatomic,strong) NSString *img;
@property(nonatomic,strong) NSString *burdens;
@property(nonatomic,assign) BOOL *isStore;

+(instancetype)CookbookWithDict:(NSDictionary *)dict;

@end

//
//  SearchViewController.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/22.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface SearchViewController : UIViewController

@property(nonatomic,strong)CategoryModel *category;

-(instancetype)initWithCategoryModel:(CategoryModel *)model;

@end

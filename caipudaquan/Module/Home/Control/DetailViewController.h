//
//  DetailViewController.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/1.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CookbookModel.h"

@interface DetailViewController : UIViewController

@property(nonatomic,strong)CookbookModel *cookbook;

-(instancetype)initWithCookbookModel:(CookbookModel *)model;
@end

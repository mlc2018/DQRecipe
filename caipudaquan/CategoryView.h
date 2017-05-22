//
//  CategoryView.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/22.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifyProtocol.h"
@interface CategoryView : UIView

@property(nonatomic,weak) id<ClassifyDelegate> delegate;

@end

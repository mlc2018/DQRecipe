//
//  ClassifyProtocol.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/22.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"

@protocol ClassifyDelegate<NSObject>
-(void)SearchClick;
-(void)CollectionCellSelected:(CategoryModel *)model;
@end

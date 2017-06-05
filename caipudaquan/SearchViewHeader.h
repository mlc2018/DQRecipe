//
//  SearchViewHeader.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/2.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewHeader : UIView

@property(nonatomic,strong) NSArray *keywords;  // 热门搜索

@property(nonatomic,copy) void (^searchCallBack)(NSUInteger);//点击按钮回调


@end

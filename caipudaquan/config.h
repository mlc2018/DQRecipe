//
//  config.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/23.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#ifndef config_h
#define config_h


#endif /* config_h */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//适配屏幕 设计图宽度与屏幕宽度比例
#define SCALE WIDTH/375
//16进制颜色
#define UIColorFromHex(s,a)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:a]

CG_INLINE CGRect
GS_CGRectMake(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    CGFloat autoSizeScaleX,autoSizeScaleY;
    autoSizeScaleX = SCALE;
    autoSizeScaleY = autoSizeScaleX;
    
    //计算返回
    return CGRectMake(x * autoSizeScaleX, y * autoSizeScaleY, width * autoSizeScaleX, height * autoSizeScaleY);
}


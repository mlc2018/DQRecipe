//
//  UIBarButtonItem+Extension.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/1.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (instancetype)barButtonLeftItemWithImageName:(NSString *)imageName
                                        target:(id)target
                                        action:(SEL)action;
+ (instancetype)barButtonRightItemWithImageName:(NSString *)imageName
                                         target:(id)target
                                         action:(SEL)action;
+ (instancetype)barButtonItemWithImageName:(NSString *)imageName
                           imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                                    target:(id)target
                                    action:(SEL)action;


+ (instancetype)barButtonItemWithTitle:(NSString *)title
                            titleColor:(UIColor *)color
                                target:(id)target
                                action:(SEL)action;
+ (instancetype)barButtonItemWithTitle:(NSString *)title
                                titleColor:(UIColor *)color
                         selectedTitle:(NSString *)selTitle
                                target:(id)target
                                action:(SEL)action;
@end

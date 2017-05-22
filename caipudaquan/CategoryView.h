//
//  CategoryView.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/22.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategorySearchDelegate<NSObject>

-(void)CategorySearch;
-(void)CollectionCellSelected:(NSString *)url;

@end

@interface CategoryView : UIView

@property(nonatomic,weak) id<CategorySearchDelegate> delegate;

@end

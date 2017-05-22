//
//  ClassifyProtocol.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/22.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ClassifyDelegate<NSObject>
-(void)SearchClick;
-(void)CollectionCellSelected:(NSString *)url;
@end

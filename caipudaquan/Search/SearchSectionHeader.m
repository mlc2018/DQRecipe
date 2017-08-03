//
//  SearchSectionHeader.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/5.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "SearchSectionHeader.h"

@implementation SearchSectionHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height - 30 , self.frame.size.width, 30)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,0 , 100, view.frame.size.height)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.text = @"最近搜索";
        [view addSubview:titleLabel];
        
        UIButton *clearAllButton = [[UIButton alloc] init];
        [clearAllButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [clearAllButton addTarget:self
                           action:@selector(clearAllSearchHistory)
                 forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:clearAllButton];
        
        [clearAllButton setFrame:CGRectMake(self.frame.size.width - 30, 5, 20, 20)];
    }
    
    return self;
}

- (void)clearAllSearchHistory {
    !self.clearBlock ? : self.clearBlock();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

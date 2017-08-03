//
//  SearchViewHeader.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/2.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "SearchViewHeader.h"

@interface SearchViewHeader()

@property(nonatomic,strong) UIView *buttonView;

@end

@implementation SearchViewHeader

static NSInteger const kButtonCount = 10;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width - 20, 20)];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.text = @"热门搜索";
        [view addSubview:titleLabel];
        
        _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 31, self.frame.size.width, 80)];
        _buttonView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_buttonView];
        
        NSInteger lineCount = 5;
        CGFloat width = (WIDTH-4) / lineCount;
        CGFloat height = (80-2) / 2;
        
        CGFloat margin = 1;
        CGFloat x = 0;
        CGFloat y = 0;
        
        for (NSInteger index=0; index<kButtonCount; index++) {
            NSInteger line = index / lineCount;
            NSInteger colunms = index % lineCount;
            x = (width + margin) * colunms;
            y = margin + (height + margin) * line;
            
            UIButton *button = [[UIButton alloc] init];
            button.frame = CGRectMake(x, y, width, height);
            button.backgroundColor = [UIColor whiteColor];
            button.tag = index;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonView addSubview:button];
            [button addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)search:(UIButton *)sender {
    !self.searchCallBack ? : self.searchCallBack(sender.tag);
}

- (void)setKeywords:(NSArray *)keywords {
    _keywords = keywords;
    for (NSInteger index=0; index<kButtonCount; index++) {
        UIButton *button = self.buttonView.subviews[index];
        [button setTitle:keywords[index] forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

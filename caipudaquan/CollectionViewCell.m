//
//  CollectionViewCell.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/21.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CollectionCategoryModel.h"

@interface CollectionViewCell ()

@property (nonatomic, strong) UILabel *name;

@end

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
       // self.backgroundColor = [UIColor redColor];
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, 20)];
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.backgroundColor = [UIColor clearColor];
        self.name.textColor =rgba(160, 160, 160, 1);
        [self.contentView addSubview:self.name];
    }
    return self;
}

- (void)setModel:(SubCategoryModel *)model
{
    self.name.text = model.name;
}


@end

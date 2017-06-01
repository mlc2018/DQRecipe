//
//  HomeCollectionViewCell.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/25.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface HomeCollectionViewCell()

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *click;




@end

@implementation HomeCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self addSubview:self.imgView];
        
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame) + 8, CGRectGetWidth(self.frame), 15)];
        //self.text.backgroundColor = [UIColor brownColor];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.name];
        
        self.click = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.name.frame) + 5, CGRectGetWidth(self.frame), 10)];
        [self.click setFont:[UIFont systemFontOfSize:10]];
        [self.click setTextColor:[UIColor lightGrayColor]];
        //self.text.backgroundColor = [UIColor brownColor];
        self.click.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.click];
        
    }
    return self;
}

- (void)setCookModel:(CookbookModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.name.text = model.name;
    NSString *click = [NSString stringWithFormat:@"%@%@  %@%@",model.all_click,@"浏览",model.favorites,@"收藏"];
    self.click.text = click;
}


@end

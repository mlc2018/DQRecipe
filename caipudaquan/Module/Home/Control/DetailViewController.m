//
//  DetailViewController.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/1.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "DetailViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController ()

@property(nonatomic,strong) UIScrollView *contentV;

@end

@implementation DetailViewController
{
    CGFloat origHeight;
}

-(instancetype)initWithCookbookModel:(CookbookModel *)model
{
    if(self = [super init])
    {
        self.cookbook = model;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = self.cookbook.name;
    [self addBackItem];
    self.view.backgroundColor =rgba(238, 238, 238, 1);
    
    origHeight = 0.0;
    _contentV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
    [self.view addSubview:_contentV];
    [self CreateUI];
}

- (void)addBackItem {
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonRightItemWithImageName:@"share" target:self  action:@selector(popNav)];
}

-(void)CreateUI
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cookstep" ofType:@"plist"];
    
    NSDictionary *infoDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *name = infoDic[@"name"];
    NSString *img = infoDic[@"img"];
    NSString *code = infoDic[@"code"];
    NSString *remark = infoDic[@"name"];
    NSString *allClick = infoDic[@"all_click"];
    NSString *favorites = infoDic[@"favorites"];
    NSString *info = infoDic[@"info"];
    NSString *healthStr = infoDic[@"health_str"];
    NSArray *makeArray = infoDic[@"makes"];
    NSArray *burdenArray = infoDic[@"burden"];
    
    self.navigationItem.title = name;
    
    UIImageView *topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
    [topImage sd_setImageWithURL:[NSURL URLWithString:img]];
    topImage.contentMode = UIViewContentModeScaleAspectFill;
    [_contentV addSubview:topImage];
    
    origHeight += 180;
    
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, origHeight, WIDTH, 150)];
    infoView.backgroundColor = [UIColor whiteColor];
    [_contentV addSubview:infoView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, WIDTH, 30)];
    nameLabel.font = [UIFont systemFontOfSize:28];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = name;
    [infoView addSubview:nameLabel];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, WIDTH, 20)];
    countLabel.font = [UIFont systemFontOfSize:14];
    countLabel.textColor = [UIColor lightGrayColor];
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.text = [NSString stringWithFormat:@"%@%@%@%@",allClick,@"浏览/",favorites,@"收藏"];
    [infoView addSubview:countLabel];
    
    UIButton *btnCreate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCreate setFrame:CGRectMake(0, 0, 150, 40)];
    [btnCreate setTitle:@"收藏" forState:UIControlStateNormal];
    [btnCreate setBackgroundColor:[UIColor colorWithRed:253/255.0 green:108.0/255.0 blue:33/255.0 alpha:1.0]];
    [btnCreate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnCreate.layer.cornerRadius = 5.0;
    [btnCreate.layer setMasksToBounds:YES];
    btnCreate.showsTouchWhenHighlighted = YES;
    [infoView addSubview:btnCreate];
    btnCreate.center = CGPointMake(WIDTH/2, 110);
    origHeight += 150;
}

-(UILabel *)CreateTitleLabel:(NSString *)title frame:(CGRect)frame
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.numberOfLines = 1;
    titleLabel.frame = frame;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    return titleLabel;
}

-(UILabel *)CreateContentLabel:(NSString *)content width:(CGFloat)width
{
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = content;
    contentLabel.textColor = [UIColor lightGrayColor];
    UIFont *font = [UIFont systemFontOfSize:18];
    contentLabel.numberOfLines = 0;
    contentLabel.font = font;
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    
    CGSize actualsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    contentLabel.frame = CGRectMake(0, 0, actualsize.width, actualsize.height);
    return contentLabel;
    
}

-(void)popNav
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

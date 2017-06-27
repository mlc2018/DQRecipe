//
//  ClassifyViewController.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/21.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "ClassifyViewController.h"
#import "SearchViewController.h"

#import "DVSwitch.h"
#import "CategoryView.h"
#import "FoodView.h"

#import "NSObject+Property.h"

@interface ClassifyViewController ()<UIScrollViewDelegate,ClassifyDelegate>


@property(nonatomic,strong) DVSwitch *segment;

@end

@implementation ClassifyViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = self.segment;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT )];
    scroll.contentSize = CGSizeMake(WIDTH * 2,0);
    scroll.bounces = NO;
    //scroll.scrollEnabled = NO;
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.backgroundColor = [UIColor blueColor];
    scroll.delegate = self;
    [self.view addSubview:scroll];
    
    CategoryView *category = [[CategoryView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, scroll.frame.size.height)];
    category.delegate = self;
    [scroll addSubview:category];
    
    FoodView *food = [[FoodView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, scroll.frame.size.height)];
    food.delegate = self;
    [scroll addSubview:food];
    
    [_segment setPressedHandler:^(NSUInteger index) {
        if(index == 0)
        {
            [scroll setContentOffset:CGPointMake(0.0, 0) animated:YES];
        }else
        {
            [scroll setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
        }
    
    }];
    
}

-(DVSwitch *)segment
{
    if(!_segment)
    {
        NSArray *titles = @[@"分类",@"食材"];
        _segment = [[DVSwitch alloc]initWithStringsArray:titles];
        [_segment setFrame:CGRectMake(0, 0, 200*SCALE, 30)];
        _segment.labelTextColorInsideSlider = [UIColor colorWithRed:253/255.0 green:108.0/255.0 blue:33/255.0 alpha:1.0];
        _segment.backgroundColor = [UIColor clearColor];
    }
    
    return _segment;
}

#pragma mark -CategorySearch Delegate
-(void)SearchClick
{
    NSLog(@"123123");
    SearchViewController *search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}

-(void)CollectionCellSelected:(CategoryModel *)model
{

    SearchViewController *search = [[SearchViewController alloc]initWithKeyword:model.name];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark -scrollview Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if((int)scrollView.contentOffset.x == 0)
    {
        [_segment forceSelectedIndex:0 animated:YES];
    }else
    {
        [_segment forceSelectedIndex:1 animated:YES];
    }
}

#pragma mark - Getters



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

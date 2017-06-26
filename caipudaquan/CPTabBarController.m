//
//  CPTabBarController.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/26.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "CPTabBarController.h"
#import "HomeViewController.h"
#import "ClassifyViewController.h"
#import "MoreViewController.h"

#import "CPNavigationController.h"

@interface CPTabBarController ()

@end

@implementation CPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HomeViewController *home = [[HomeViewController alloc]init];
    [self addChildController:home title:@"菜谱大全" image:@"home_Recipe" selectedImage:@"home_Recipe_selected"];
    
    ClassifyViewController *class = [[ClassifyViewController alloc]init];
    [self addChildController:class title:@"菜谱分类" image:@"home_classify" selectedImage:@"home_classify_selected"];
    
    MoreViewController *more = [[MoreViewController alloc]init];
    [self addChildController:more title:@"更多" image:@"home_more" selectedImage:@"home_more_selected"];
    
}

-(void)addChildController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    /*
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //正常状态下的颜色
    textAttrs[NSForegroundColorAttributeName] =[UIColor colorWithRed:253/255.0 green:108.0/255.0 blue:33/255.0 alpha:1.0];
    
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
     */
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    //正常状态下的颜色
    selectedTextAttrs[NSForegroundColorAttributeName] =[UIColor colorWithRed:253/255.0 green:108.0/255.0 blue:33/255.0 alpha:1.0];
    
    [childController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    CPNavigationController *nv = [[CPNavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nv];

}

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

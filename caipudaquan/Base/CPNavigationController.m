//
//  CPNavigationController.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/26.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "CPNavigationController.h"

@interface CPNavigationController ()

@end

@implementation CPNavigationController

+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    bar.barTintColor =[UIColor colorWithRed:253/255.0 green:108.0/255.0 blue:33/255.0 alpha:1.0];
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 当第一个子控件为scrollView时，顶部限制压缩64
    viewController.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.viewControllers.count > 0) {
        /* 当push的时候自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        
        self.interactivePopGestureRecognizer.delegate = (id)self;
    }
    // 必须super
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
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

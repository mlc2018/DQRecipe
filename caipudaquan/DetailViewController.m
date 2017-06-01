//
//  DetailViewController.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/1.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "DetailViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    self.tabBarController.tabBar.hidden = YES;
    self.title = self.cookbook.name;
    [self addBackItem];
}

- (void)addBackItem {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonLeftItemWithImageName:@"nav_back_button" target:self action:@selector(popNav)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonRightItemWithImageName:@"share" target:self  action:@selector(popNav)];
}

-(void)popNav
{
    [self.navigationController popViewControllerAnimated:YES];
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

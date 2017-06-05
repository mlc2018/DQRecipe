//
//  SearchViewController.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/22.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "SearchViewController.h"
#import "UIBarButtonItem+Extension.h"

#import "SearchViewHeader.h"
#import "SearchSectionHeader.h"

@interface SearchViewController ()

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong) NSArray *hotSearchWords;

@property(nonatomic,strong) NSArray *historySearch;

@end

@implementation SearchViewController

-(instancetype)initWithCategoryModel:(CategoryModel *)model
{
    if(self = [super init])
    {
        self.category = model;
    }
    
    return self;
}

-(NSArray *)hotSearchWords{
    if(!_hotSearchWords){
        
        _hotSearchWords = @[@"冰糖雪梨",@"煎饼",@"鸡蛋饼",@"鸡翅",@"茄子",@"辣子鸡",@"四季豆",@"粤菜",@"面条",@"水煮肉片"];
    }
    
    return _hotSearchWords;
}

-(NSArray *)historySearch
{
    if(!_historySearch){
        _historySearch = @[@"冰糖雪梨",@"煎饼",@"鸡蛋饼",@"鸡翅",@"茄子",@"辣子鸡",@"四季豆",@"粤菜",@"面条",@"水煮肉片"];
    }
    return _historySearch;
}


-(void)viewWillAppear:(BOOL)animated
{
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIView *view = [self.navigationController.view viewWithTag:102];
    for(UIView *sub in view.subviews)
    {
        [sub removeFromSuperview];
    }
    
    [view removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    [self addBackItem];
    
    self.view.backgroundColor =rgba(238, 238, 238, 1);
    
    [self setupHeader];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)addBackItem {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonLeftItemWithImageName:@"nav_back_button" target:self action:@selector(popNav)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"搜索" titleColor:[UIColor whiteColor] target:self action:@selector(popNav)];
    
    /*
    UIButton *search= [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(0, 0, 40, 15);
    [search addTarget:self action:@selector(popNav) forControlEvents:UIControlEventTouchUpInside];
    [search setTitle:@"搜索" forState:UIControlStateNormal];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:search];
    self.navigationItem.rightBarButtonItem = item2;
     */
    
    UIView* view1 = [[UIView alloc]initWithFrame:CGRectMake(55*SCALE, 25, WIDTH - 130*SCALE, 34)];
    view1.tag = 102;
    [view1 setBackgroundColor:rgba(228, 87, 28, 1)];
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 5;
    [self.view addSubview:view1];
    
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, (34-16)/2, 16, 16)];
    [imgView setImage:[UIImage imageNamed:@"showSearch_white"]];
    [view1 addSubview:imgView];
    
    [self.textField setFrame:CGRectMake(40, 0, WIDTH - 130 - 45, 34)];
    [view1 addSubview:self.textField];
    
    [self.navigationController.view addSubview:view1];
    

}

- (UITextField*)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"想吃什么搜这里，如川菜";
        [_textField setBackgroundColor:[UIColor clearColor]];
        [_textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _textField.textColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:13];
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
       // _textField.delegate = self;
        if(self.category)
        {
            _textField.text = self.category.name; 
        }
    }
    return _textField;
}


-(void)popNav
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.historySearch count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.category != nil)
    {
        return 0;
    }
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        SearchSectionHeader *header = [[SearchSectionHeader alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
         return header;
    }

   
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    line.backgroundColor = rgba(238, 238, 238, 1);
    [cell.contentView addSubview:line];
    cell.textLabel.text = [self.historySearch objectAtIndex:indexPath.row];
    return cell;
}

-(void)setupHeader
{
    if(self.category != nil)
    {
      self.tableView.tableHeaderView = nil;
        
    }else
    {
        SearchViewHeader *header = [[SearchViewHeader alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 111)];
        header.keywords = self.hotSearchWords;
        self.tableView.tableHeaderView = header;
    }
    
    // self.tableView.tableHeaderView = nil;
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

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
#import "SearchResultCell.h"


#import "MJRefresh.h"

@interface SearchViewController ()

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong) NSArray *hotSearchWords;

@property(nonatomic,strong) NSArray *historySearch;

@property(nonatomic,assign) NSInteger page;

@property(nonatomic,strong) NSMutableArray *resultArray;

@end

@implementation SearchViewController

static NSString *const searchCellIdentifier = @"search";
static NSString *const resultCellIdentifier = @"result";

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

-(NSMutableArray *)resultArray{
    if(!_resultArray){
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}

-(NSArray *)historySearch
{
    if(!_historySearch){
        _historySearch = @[@"冰糖雪梨",@"煎饼",@"鸡蛋饼",@"鸡翅",@"茄子",@"辣子鸡",@"四季豆",@"粤菜",@"面条",@"水煮肉片"];
    }
    return _historySearch;
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
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    [self addBackItem];
    self.view.backgroundColor =rgba(238, 238, 238, 1);
    [self setupHeader];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:resultCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 0;
    
    if(self.category != nil)
    {
        [self doSearch:self.category.url];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [self updateDate];
            
        }];

    }
    
}

- (void)addBackItem {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"搜索" titleColor:[UIColor whiteColor] target:self action:@selector(searchClick:)];
    
    
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

-(void)searchClick:(id)sender
{
    [self doSearch:@"123"];
}

-(void)doSearch:(NSString *)urlString
{
    /*
    NSURL *url = [NSURL URLWithString:urlString];
     网络请求数据
     */
    self.page = 0;
    [self.resultArray removeAllObjects];
    [self updateDate];
    
}



-(void)updateDate
{
    if(self.page >= 3)
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"searchlist" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *dataSource = dict[@"data"];
    for(NSInteger i=self.page*10;i<10*(self.page+1);i++)
    {
        CookbookModel *model = [[CookbookModel alloc]init];
        model.appurl = [dataSource[i] objectForKey:@"uri"];
        model.img = [dataSource[i] objectForKey:@"img"];
        model.all_click = [dataSource[i] objectForKey:@"all_click"];
        model.favorites = [dataSource[i] objectForKey:@"favorites"];
        model.burdens = [dataSource[i] objectForKey:@"burdens"];
        model.name = [dataSource[i] objectForKey:@"name"];
        [self.resultArray addObject:model];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        self.page++;
    });

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
    if([self.resultArray count])
    {
        return [self.resultArray count];
    }else
    {
        if(self.category != nil)
        {
            return 1;
        }
        
        return [self.historySearch count];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.category != nil || [self.resultArray count] > 0)
    {
        return 0;
    }else
    {
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.resultArray count])
    {
        return 120;
    }else
    {
        return 44;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0 && self.category == nil)
    {
        SearchSectionHeader *header = [[SearchSectionHeader alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
         return header;
    }

   
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell;
    
    if([self.resultArray count])
    {
        //有搜索内容
        SearchResultCell *cell = [SearchResultCell cellWithTableView:tableView];
        cell.cookModel = [self.resultArray objectAtIndex:indexPath.row];
        return cell;
        
    }else
    {
        if(self.category != nil)
        {
            UITableViewCell *cell;
            cell = [tableView dequeueReusableCellWithIdentifier:searchCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
            line.backgroundColor = rgba(238, 238, 238, 1);
            [cell.contentView addSubview:line];
            cell.textLabel.text = @"aaa";
            
            return cell;
            
            
        }else
        {
            UITableViewCell *cell;
           
            cell = [tableView dequeueReusableCellWithIdentifier:searchCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            /*
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
             */
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
            line.backgroundColor = rgba(238, 238, 238, 1);
            [cell.contentView addSubview:line];
            cell.textLabel.text = [self.historySearch objectAtIndex:indexPath.row];
            
            return cell;
        }
        
    }
    
    
    
}

- (SearchViewHeader *)extracted {
    SearchViewHeader *header = [[SearchViewHeader alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 111)];
    return header;
}

-(void)setupHeader
{
    
    
    if(self.category != nil)
    {
      self.tableView.tableHeaderView = nil;
        
    }else
    {
        SearchViewHeader * header = [self extracted];
        header.keywords = self.hotSearchWords;
        self.tableView.tableHeaderView = header;
    }
    
    // self.tableView.tableHeaderView = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

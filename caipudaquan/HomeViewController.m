//
//  HomeViewController.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/21.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "HomeCollectionViewCell.h"

#import "SearchViewController.h"
#import "DetailViewController.h"

#import "CategoryModel.h"
#import "CategoryButton.h"

#import "CookbookModel.h"

#import "NSArray+Category.h"
#import "UIImageView+WebCache.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSMutableArray *hotArray;

@property(nonatomic,strong)NSMutableArray *loopArray;

@property(nonatomic,strong)NSMutableArray *fineArray;


@end

@implementation HomeViewController
{
    UIView *_headView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


-(NSMutableArray *)hotArray
{
    if(_hotArray == nil)
    {
        _hotArray = [NSMutableArray array];
        NSArray *array = [NSArray arrayNamed:@"category_hot"];
        
        for (NSDictionary *dic in array) {
            /*
            CategoryModel *model = [[CategoryModel alloc]init];
            model.name =[dic objectForKey:@"name"];
            model.appurl =[dic objectForKey:@"appurl"];
             */
            CategoryModel *model = [CategoryModel CategoryWithDict:dic];
            [_hotArray addObject:model];
        }
        
    }
    return _hotArray;
}

-(NSMutableArray *)loopArray
{
    if(_loopArray == nil)
    {
        _loopArray = [NSMutableArray array];
        NSMutableSet *randomSet = [self getRandomSet];
        
        for (id obj in randomSet) {
            CookbookModel *model = [CookbookModel CookbookWithDict:obj];
            [_loopArray addObject:model];
        }
    }
    
    return _loopArray;
}

-(NSMutableArray *)fineArray
{
    if(_fineArray == nil)
    {
        _fineArray = [NSMutableArray array];
        NSMutableSet *randomSet = [self getRandomSet];
        
        for (id obj in randomSet) {
            CookbookModel *model = [CookbookModel CookbookWithDict:obj];
            [_fineArray addObject:model];
        }
    }
    
    return _fineArray;
    
}

-(NSMutableSet *)getRandomSet
{
    NSArray *array = [NSArray arrayNamed:@"cookbook"];
    
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];
    while ([randomSet count] < 6) {
        int r = arc4random() % [array count];
        [randomSet addObject:[array objectAtIndex:r]];
    }

    return randomSet;
}

-(NSMutableArray *)getValuesWithCookBookArray:(NSArray *)array ForKeys:(NSString *)key
{
    NSMutableArray *values = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        NSString *value = [dic valueForKey:key];
        [values addObject:value];
    }
    return values;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"菜谱大全";
    self.view.backgroundColor =rgba(238, 238, 238, 1);
    
    [self CreateHeader];
    
    [self CreateView];
    
    
}

-(void)CreateView
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.headerReferenceSize = CGSizeMake(WIDTH, 200 + (90 + 120 + 45 ) *SCALE );//头部大小
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:flowLayout];
    //定义每个UICollectionView 的大小
    flowLayout.itemSize = CGSizeMake((WIDTH-20)/2, (WIDTH-20)/2+50);
    //定义每个UICollectionView 横向的间距
    flowLayout.minimumLineSpacing = 5;
    //定义每个UICollectionView 纵向的间距
    flowLayout.minimumInteritemSpacing = 0;
    //定义每个UICollectionView 的边距距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);//上左下右
    
    //注册cell和ReusableView（相当于头部）
    [collection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    
    //设置代理
    collection.delegate = self;
    collection.dataSource = self;
    
    //背景颜色
    collection.backgroundColor = [UIColor clearColor];
    //自适应大小
    collection.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:collection];
}

-(void)CreateHeader
{
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200 + 90 *SCALE +120 * SCALE + 45 * SCALE)];
    
    NSArray *imagesUrl = [self getValuesWithCookBookArray:self.loopArray ForKeys:@"img"];
    
    // 情景三：图片配文字
    NSArray *titles = [self getValuesWithCookBookArray:self.loopArray ForKeys:@"name"];
    
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
   // cycleScrollView2.localizationImageNamesGroup = imageNames;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.titleLabelBackgroundColor = rgba(10, 10, 10, 0.3);
    cycleScrollView2.titleLabelHeight = 50;
    cycleScrollView2.currentPageDotColor = rgba(250, 128, 74, 1); // 自定义分页控件小圆标颜色
    cycleScrollView2.pageDotColor = [UIColor whiteColor];
    cycleScrollView2.pageControlBottomOffset = 10;
    [_headView addSubview:cycleScrollView2];
    cycleScrollView2.imageURLStringsGroup = imagesUrl;
    
    
    
    
    /*
     block监听点击方式
     
     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
     NSLog(@">>>>>  %ld", (long)index);
     };
     
     */
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:rgba(255, 255, 255, 1)];
    [btn setFrame:CGRectMake(15*SCALE,190, WIDTH - 30*SCALE, 45*SCALE)];
    [btn setTitle:@"想吃什么搜这里，如川菜" forState:UIControlStateNormal];
    [btn setTitleColor:rgba(200, 200, 200, 1) forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setImage:[UIImage imageNamed:@"showSearch"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = rgba(250, 128, 74, 1).CGColor;
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:btn];
    
    UIView *TitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 200 + 45 *SCALE,WIDTH , 45 * SCALE )];
    TitleView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10 * SCALE, 200, 25 * SCALE)];
    titleLabel.text = @"热门分类";
    titleLabel.textColor =rgba(200, 200, 200, 1);
    [TitleView addSubview:titleLabel];
    
    [_headView addSubview:TitleView];
    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 200 + 90 * SCALE, WIDTH, 120 * SCALE)];
    [_headView addSubview:btnView];
    
    CGFloat xHeight = (120 * SCALE - 3)/3;
    CGFloat xWidth = (WIDTH - 3) / 4;
    
    for(int i = 0; i < [self.hotArray count];i++)
    {
        CategoryButton *btnC = [CategoryButton buttonWithType:UIButtonTypeCustom];
        [btnC setBackgroundColor:[UIColor whiteColor]];
        [btnC setFrame:CGRectMake((xWidth + 1)*(i%4),1 + (xHeight + 1) *(i/4), xWidth, xHeight)];
        [btnC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        CategoryModel *model = [_hotArray objectAtIndex:i];
        btnC.category = model;
        [btnC setTitle:model.name forState:UIControlStateNormal];
        [btnC addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btnC];
    }
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,200 + 210 * SCALE, 200, 45 * SCALE)];
    priceLabel.text = @"精品好菜";
    priceLabel.textColor =rgba(200, 200, 200, 1);
    [_headView addSubview:priceLabel];
    
}

-(void)searchClick:(id)sender
{
    SearchViewController *search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}

-(void)btnClick:(id)sender
{
    CategoryButton *btn = (CategoryButton *)sender;
    if([btn.category.url isEqualToString:@""])
    {
        self.tabBarController.selectedIndex = 1;
        return;
    }
    
    SearchViewController *search = [[SearchViewController alloc]initWithCategoryModel:btn.category];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    CookbookModel *model = [self.loopArray objectAtIndex:index];
    DetailViewController *detailC = [[DetailViewController alloc]initWithCookbookModel:model];
    [self.navigationController pushViewController:detailC animated:YES];
    
}

#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.fineArray count];
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    [headerView addSubview:_headView];//头部广告栏
    return headerView;
}


#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    
    //cell.imgView.image = [UIImage imageNamed:_cellArray[indexPath.item]];
    cell.cookModel =self.fineArray[indexPath.item];
    //按钮事件就不实现了……
    return cell;
}

#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"选择%ld",indexPath.item);
    CookbookModel *model = [self.fineArray objectAtIndex:indexPath.row];
    DetailViewController *detailC = [[DetailViewController alloc]initWithCookbookModel:model];
    [self.navigationController pushViewController:detailC animated:YES];
    
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

//
//  CategoryView.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/22.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "CategoryView.h"
#import "CollectionViewFlowLayout.h"
#import "CollectionViewCell.h"
#import "CollectionCategoryModel.h"

#import "LeftTableViewCell.h"

@interface CategoryView()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *dataSource;

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *collectionDates;
@property(nonatomic,strong) CollectionViewFlowLayout *flowLayout;

@end

@implementation CategoryView
{
@private
    NSInteger _selectIndex;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        [self createView];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self initData];
    }
    
    return self;
}



-(void)initData
{
    _selectIndex = 0;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fenlei" ofType:@"txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    _dataSource = dict[@"data"];
    NSLog(@"%ld",[_dataSource count]);
    [_tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

}

-(void)createView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:rgba(238, 238, 238, 1)];
    [btn setFrame:CGRectMake(15, 20, self.frame.size.width - 30, 45)];
    [btn setTitle:@"想吃什么搜这里，如川菜" forState:UIControlStateNormal];
    [btn setTitleColor:rgba(200, 200, 200, 1) forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setImage:[UIImage imageNamed:@"showSearch"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, btn.frame.origin.y + btn.frame.size.height + 15, WIDTH, 1.0)];
    [line setBackgroundColor:rgba(238, 238, 238, 1)];
    [self addSubview:line];
    
    [self addSubview:self.tableView];
    [self addSubview:self.collectionView];
    
    

    
}

-(void)btnClick:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(CategorySearch)])
    {
        [_delegate CategorySearch];
    }
}

#pragma mark - Getters
-(NSMutableArray *)dataSource
{
    if(!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 81, 80,HEIGHT - 81 - 64 - 49)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.rowHeight = 55;
        // _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_left];
        
    }
    
    return _tableView;
}

#pragma mark - UITableView DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_left forIndexPath:indexPath];
    //CollectionCategoryModel *model = self.dataSource[indexPath.row];
    NSString *name = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.name.text = name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    _collectionDates = [[[self.dataSource[indexPath.row] objectForKey:@"list"] objectAtIndex:0] objectForKey:@"list"];
    
    [self.collectionView reloadData];
}

-(NSMutableArray *)collectionDates
{
    if(!_collectionDates)
    {
        //_collectionDates = [NSMutableArray array];
        _collectionDates = [[[self.dataSource[0] objectForKey:@"list"] objectAtIndex:0] objectForKey:@"list"];
    }
    
    return _collectionDates;
}



-(CollectionViewFlowLayout *)flowLayout
{
    if(!_flowLayout)
    {
        _flowLayout = [[CollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = 2;
        _flowLayout.minimumLineSpacing = 2;
    }
    
    return _flowLayout;
}
 


- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 + 80, 81, WIDTH - 80 - 4, HEIGHT - 81  - 49 - 44 - 20) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionView];
        
    }
    return _collectionView;
}

#pragma mark - UICollectionView DataSource Delegate


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  //  return  [[[[self.dataSource[section] objectForKey:@"list"] objectAtIndex:0] objectForKey:@"list"] count];
    
    return [self.collectionDates count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];
    
    NSLog(@"%@",self.collectionDates[indexPath.row]);
    //SubCategoryModel *model = self.collectionDates[indexPath.row];
    
    SubCategoryModel *model = [[SubCategoryModel alloc]init];
    model.name =[self.collectionDates[indexPath.row] objectForKey:@"name"];
    model.url =[self.collectionDates[indexPath.row] objectForKey:@"url"];
    
    
    cell.model = model;
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WIDTH - 80 - 4 - 4) / 3,
                       40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(WIDTH, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([_delegate respondsToSelector:@selector(CollectionCellSelected:)])
    {
        NSString *url = [self.collectionDates[indexPath.row] objectForKey:@"url"];
        [_delegate CollectionCellSelected:url];
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

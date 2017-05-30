//
//  FoodView.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/22.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "FoodView.h"

#import "CollectionViewFlowLayout.h"
#import "CollectionViewCell.h"
#import "CollectionViewHeaderView.h"

#import "LeftTableViewCell.h"
#import "CategoryModel.h"

@interface FoodView()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *dataSource;

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *collectionDates;
@property(nonatomic,strong) CollectionViewFlowLayout *flowLayout;

@end

@implementation FoodView
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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shicai" ofType:@"txt"];
    
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
    [btn setFrame:CGRectMake(15*SCALE, 15*SCALE, self.frame.size.width - 30*SCALE, 45*SCALE)];
    [btn setTitle:@"想吃什么搜这里，如川菜" forState:UIControlStateNormal];
    [btn setTitleColor:rgba(200, 200, 200, 1) forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setImage:[UIImage imageNamed:@"showSearch"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, btn.frame.origin.y + btn.frame.size.height + 15*SCALE, WIDTH, 1.0)];
    [line setBackgroundColor:rgba(238, 238, 238, 1)];
    [self addSubview:line];
    
    [self addSubview:self.tableView];
    [self addSubview:self.collectionView];
    
    
    
    
}

-(void)btnClick:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(SearchClick)])
    {
        [_delegate SearchClick];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 75*SCALE + 1, 80,HEIGHT - 75*SCALE - 1 - 64 - 49)];
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
    
    _collectionDates = [self.dataSource[indexPath.row] objectForKey:@"list"] ;
    
    [self.collectionView reloadData];
}

-(NSMutableArray *)collectionDates
{
    if(!_collectionDates)
    {
        //_collectionDates = [NSMutableArray array];
        _collectionDates = [self.dataSource[0] objectForKey:@"list"];
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 + 80, 75*SCALE+1, WIDTH - 80 - 4, HEIGHT - SCALE*75 - 1 - 49 - 44 - 20) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionView];
        //注册分区头标题
        [_collectionView registerClass:[CollectionViewHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"CollectionViewHeaderView"];
        
    }
    return _collectionView;
}

#pragma mark - UICollectionView DataSource Delegate
- (CGRect)frameForHeaderForSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect frameForFirstCell = attributes.frame;
    CGFloat headerHeight = [self collectionView:_collectionView layout:self.flowLayout referenceSizeForHeaderInSection:section].height;
    return CGRectOffset(frameForFirstCell, 0, -headerHeight);
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.collectionDates count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //  return  [[[[self.dataSource[section] objectForKey:@"list"] objectAtIndex:0] objectForKey:@"list"] count];
    
    return [[[self.collectionDates objectAtIndex:section] objectForKey:@"list"] count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];
    
    //SubCategoryModel *model = self.collectionDates[indexPath.row];
    
    CategoryModel *model = [[CategoryModel alloc]init];
    
    NSDictionary *dic =[[self.collectionDates[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row];
    
    
    
    model.name =[dic objectForKey:@"name"];
    model.url =[dic objectForKey:@"url"];
    
    
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    { // header
        reuseIdentifier = @"CollectionViewHeaderView";
    }
    CollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:reuseIdentifier
                                                                               forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        view.title.text = [self.collectionDates[indexPath.section] objectForKey:@"name"];
        //view.title.text = model.name;
    }
    return view;
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
    return CGSizeMake(WIDTH, 30*SCALE);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([_delegate respondsToSelector:@selector(CollectionCellSelected:)])
    {
        NSDictionary *dic =[[self.collectionDates[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row];
    
        NSString *url =[dic objectForKey:@"url"];

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

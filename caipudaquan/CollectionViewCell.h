//
//  CollectionViewCell.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/5/21.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier_CollectionView @"CollectionViewCell"

@class CategoryModel;

@interface CollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) CategoryModel *model;

@end

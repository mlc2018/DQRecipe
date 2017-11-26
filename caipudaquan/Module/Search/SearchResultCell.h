//
//  SearchResultCell.h
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/7.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CookbookModel.h"

@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *materialLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property(nonatomic,strong) CookbookModel *cookModel;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end

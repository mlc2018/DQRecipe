//
//  SearchResultCell.m
//  caipudaquan
//
//  Created by guoruiqing on 2017/6/7.
//  Copyright © 2017年 xhhl. All rights reserved.
//

#import "SearchResultCell.h"
#import "UIImageView+WebCache.h"

@implementation SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"SearchResultCell";
    SearchResultCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
       cell = [[NSBundle mainBundle]loadNibNamed:@"SearchResultCell" owner:nil options:nil][0];
    }
    
    return cell;
}

-(void)setCookModel:(CookbookModel *)cookModel
{
    self.nameLabel.text = cookModel.name;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:cookModel.img]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

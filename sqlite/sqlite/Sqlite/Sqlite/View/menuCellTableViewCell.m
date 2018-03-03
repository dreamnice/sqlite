//
//  menuCellTableViewCell.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/16.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "menuCellTableViewCell.h"

@implementation menuCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake (20, 15, 35 ,35)];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, 100, 25)];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if(!_subtitleLabel){
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 34, 100, 20)];
        [_subtitleLabel setFont:[UIFont systemFontOfSize:12]];
        [_subtitleLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}

@end

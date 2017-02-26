//
//  BeePhotoGropTableViewCell.m
//  FDR
//
//  Created by Ji_YuFeng on 17/2/16.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeePhotoGropTableViewCell.h"


@implementation BeePhotoGropTableViewCell


- (UIImageView *)img
{
    if (!_img) {
        _img = [[UIImageView alloc]init];
        _img.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _img;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
//        [_titleLabel beeSetNormalBlack];
    }
    return _titleLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
//        [_countLabel beeSetNormalBlack];
    }
    return _countLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configSubView];
        [self configAutoLayout];
        
    }
    return self;
}

- (void)configSubView
{
    [self addSubview:self.img];
    [self addSubview:self.titleLabel];
    [self addSubview:self.countLabel];
}

- (void)configAutoLayout
{
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(self.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(15);
        make.bottom.mas_equalTo(self.img.mas_centerY).offset(-5);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(15);
        make.top.mas_equalTo(self.img.mas_centerY).offset(5);
    }];
    
}



@end

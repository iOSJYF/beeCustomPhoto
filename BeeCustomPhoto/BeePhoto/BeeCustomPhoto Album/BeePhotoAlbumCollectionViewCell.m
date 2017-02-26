//
//  BeePhotoAlbumCollectionViewCell.m
//  FDR
//
//  Created by Ji_YuFeng on 17/2/17.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeePhotoAlbumCollectionViewCell.h"

@interface BeePhotoAlbumCollectionViewCell()


@end

@implementation BeePhotoAlbumCollectionViewCell

- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        _imageV.backgroundColor = [UIColor redColor];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        WS(weakSelf);
        [_imageV whenTapped:^{
            if (weakSelf.tapblock) {
                [weakSelf imageTap];
                weakSelf.tapblock();
            }
        }];
    }
    return _imageV;
}

- (UIImageView *)selectImg
{
    if (!_selectImg) {
        _selectImg = [[UIImageView alloc]init];
        _selectImg.hidden = YES;
        [_selectImg setImage:[UIImage imageNamed:@"checkbox_pic"]];
    }
    return _selectImg;
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imageV];
        [self addSubview:self.selectImg];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        [self.selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(3);
            make.right.mas_equalTo(-3);
            make.height.width.mas_equalTo(17);
        }];
    }
    return self;
}

- (void)imageTap
{
    if (self.selectImg.hidden == YES) {
        self.selectImg.hidden = NO;
    }else{
        self.selectImg.hidden = YES;
    }
    
}


@end

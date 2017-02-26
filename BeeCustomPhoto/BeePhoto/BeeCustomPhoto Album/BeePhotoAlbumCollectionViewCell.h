//
//  BeePhotoAlbumCollectionViewCell.h
//  FDR
//
//  Created by Ji_YuFeng on 17/2/17.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapBlock)();

@interface BeePhotoAlbumCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UIImageView *selectImg;

@property (nonatomic,copy) TapBlock tapblock;

@end

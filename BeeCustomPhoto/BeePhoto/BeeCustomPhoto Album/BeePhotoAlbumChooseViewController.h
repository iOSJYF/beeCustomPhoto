//
//  BeePhotoAlbumChooseViewController.h
//  FDR
//
//  Created by Ji_YuFeng on 17/2/16.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeeBaseNavigationViewController.h"
#import <Photos/Photos.h>

typedef void (^SelectBlock)(UIImage *image);
typedef void (^SelectArrayBlock)(NSArray *imgArr);

@interface BeePhotoAlbumChooseViewController : BeeBaseNavigationViewController

@property (nonatomic,strong) PHAssetCollection *assetCollection;
@property (nonatomic,assign) BOOL gotoEdit;
@property (nonatomic,assign) BOOL selectMore;
@property (nonatomic,assign) NSInteger maxCount;

@property (nonatomic,copy) SelectBlock selectBlock;
@property (nonatomic,copy) SelectArrayBlock imgArrBlock;


@end

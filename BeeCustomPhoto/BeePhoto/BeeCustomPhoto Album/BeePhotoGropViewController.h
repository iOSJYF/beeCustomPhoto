//
//  BeePhotoGropViewController.h
//  FDR
//
//  Created by Ji_YuFeng on 17/2/16.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeeBaseNavigationViewController.h"

typedef void(^OriginBlock)(UIImage *img);
typedef void(^GetTheImgArrBlock)(NSArray *arr); // 返回多选图片数组

@interface BeePhotoGropViewController : BeeBaseNavigationViewController

@property (nonatomic,copy) OriginBlock originblock;
@property (nonatomic,copy) GetTheImgArrBlock getImgArrBlock;
@property (nonatomic,assign) BOOL selectMore;
@property (nonatomic,assign) NSInteger maxcount;

//+ (BeePhotoGropViewController *)sharePhotoGropVIew;

//- (void)initWithThePicNum:(NSInteger)picNum;

@end

//
//  BeeEditPicViewController.h
//  FDR
//
//  Created by Ji_YuFeng on 17/1/12.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeeBaseNavigationViewController.h"

@protocol BeeEditDelegate <NSObject>

- (void)theReturnImage:(UIImage *)finallyImage;

@end

@interface BeeEditPicViewController : BeeBaseNavigationViewController

@property (nonatomic,weak) id <BeeEditDelegate> beeEditDelegate;
@property (nonatomic,copy) NSString *scaleString;

- (id)initWithTheImage:(UIImage *)image Size:(CGSize)cropSize;

@end

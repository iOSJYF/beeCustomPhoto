//
//  BeePicCutViewController.h
//  FDR
//
//  Created by Ji_YuFeng on 17/1/13.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeeBaseNavigationViewController.h"

typedef void(^BeeCutBlock)(UIImage *img);

@interface BeePicCutViewController : BeeBaseNavigationViewController

@property (nonatomic,copy) BeeCutBlock beeCutBlock;

- (id)initWithTheImage:(UIImage *)theImage andScale:(NSString *)scale;

@end

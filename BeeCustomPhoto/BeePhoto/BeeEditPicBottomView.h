//
//  BeeEditPicBottomView.h
//  FDR
//
//  Created by Ji_YuFeng on 17/1/13.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TheButtonActionBlock)(int buttonTag);

@interface BeeEditPicBottomView : UIView

@property (nonatomic,copy) TheButtonActionBlock buttonActionBlock;

@end

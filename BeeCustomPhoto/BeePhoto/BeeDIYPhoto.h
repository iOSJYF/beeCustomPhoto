//
//  BeeDIYPhoto.h
//  FDR
//
//  Created by Ji_YuFeng on 17/1/12.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import <Foundation/Foundation.h>

// 宏定义，外面直接调用
#define BeeDIYPhotoImage [BeeDIYPhoto shareBeeDIYPhoto]

// 代理方法
@protocol BeeDIYPhotoDelegate <NSObject>

- (void)beeDiyTheImage:(UIImage *)image;

@end

@interface BeeDIYPhoto : NSObject

@property (nonatomic,weak) id <BeeDIYPhotoDelegate> beeDIYdelegate;
@property (nonatomic,strong) UIViewController *fatherVC;

+ (BeeDIYPhoto *)shareBeeDIYPhoto;

#pragma mark - 显示ActionSheet方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC andScale:(NSString *)scale delegate:(id<BeeDIYPhotoDelegate>)aDelegate;

@end

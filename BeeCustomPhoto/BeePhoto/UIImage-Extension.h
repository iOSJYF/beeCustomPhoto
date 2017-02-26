//
//  UIImage-Extension.h
//  HXPictureClippingRotation
//
//  Created by 黄轩 on 16/3/15.
//  Copyright © 2016年 黄轩 blog.libuqing.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (CS_Extensions)

//- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
//- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians andMirror:(BOOL)Mirror;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees andMirror:(BOOL)Mirror;


- (UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;
- (UIImage*)resizedImageToSize:(CGSize)dstSize;
- (UIImage *)cropImage:(CGRect) rect;
- (UIImage *)fixOrientation;

//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

//指定宽度按比例缩放
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end



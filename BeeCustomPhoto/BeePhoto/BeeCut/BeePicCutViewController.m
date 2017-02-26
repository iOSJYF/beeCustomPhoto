//
//  BeePicCutViewController.m
//  FDR
//
//  Created by Ji_YuFeng on 17/1/13.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeePicCutViewController.h"
#import "CYCropView.h"
#import "UIImageView+CYCrop.h"




@interface BeePicCutViewController ()

@property (nonatomic,strong) UIImageView *theImageView;
@property (nonatomic,copy) NSString *scale;

@end

@implementation BeePicCutViewController

- (id)initWithTheImage:(UIImage *)theImage andScale:(NSString *)scale
{
    if (self = [super init]) {
        
        self.scale = scale;
        self.theImageView.image = theImage;
        [self.view addSubview:self.theImageView];
        
//        if (theImage.size.height < theImage.size.width || theImage.size.width > ScreenWidth) {
            [self.theImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                if (theImage.size.height > ScreenHeight-64) {
//                    make.centerX.mas_equalTo(0);
//                    make.top.mas_equalTo(0);
//                    make.bottom.mas_equalTo(0);
//                    make.width.mas_equalTo((ScreenHeight-64)*theImage.size.width/theImage.size.height);
//                    //
//                    
//                }else{
//                    make.center.mas_equalTo(0);
//                    make.left.right.mas_equalTo(0);
//                    make.height.mas_equalTo(ScreenWidth*theImage.size.height/theImage.size.width);
//                }
                make.centerX.mas_equalTo(0);
                make.centerY.mas_equalTo(0);
                make.left.right.mas_equalTo(0);
                //            make.top.equalTo(self.view).offset(0);
                make.height.mas_equalTo(ScreenWidth*theImage.size.height/theImage.size.width);
                
                
            }];
//        }else{
//            [self.theImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.mas_equalTo(0);
//                make.top.mas_equalTo(0);
//                make.bottom.mas_equalTo(0);
//                make.width.mas_equalTo((ScreenHeight-64)*theImage.size.width/theImage.size.height);
//                
//            }];
//        }
        
        
        float theBeeImageViewHeight = ScreenWidth*theImage.size.height/theImage.size.width;
        float theRadio = (ScreenHeight-64)/theBeeImageViewHeight;
        if (theBeeImageViewHeight > (ScreenHeight-64)) {
            self.theImageView.transform = CGAffineTransformScale(self.theImageView.transform,theRadio, theRadio);
        }
        
        
        
//        if ([self.scale isEqualToString:@"46to35"]) {
//            [self.theImageView cy_showCropViewWithType:CYCropScaleType46To35];
//        }
//        if ([self.scale isEqualToString:@"1to1"]) {
            [self.theImageView cy_showCropViewWithType:[self.scale intValue]];
//        }
        
        
//        [self.theImageView cy_setComplectionHandler:^{
//            NSLog(@"实际裁剪区域: %@", NSStringFromCGRect(self.theImageView.cy_cropFrameRatio));
//        }];
        
        
        
    }
    return self;
}

- (UIImageView *)theImageView
{
    if (!_theImageView) {
        _theImageView = [[UIImageView alloc]init];
    }
    return _theImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"修剪图片";
 
    [self.rightbtn setTitle:@"完成" forState:0];
    
}

- (void)rightButtonAction:(UIButton *)sender
{
    
    NSMutableArray * VCArray = [[NSMutableArray alloc]init];
    for (UIViewController* v in [UIApplication sharedApplication].windows) {
        [VCArray addObject:v];
    }
    
    UIImage *newImage = [self cropImg];
    if (self.beeCutBlock) {
        self.beeCutBlock(newImage);
    }
    
    
    int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];

    
    
}

-(UIImage *)cropImg
{
    CGRect cropFrame = CGRectMake(self.theImageView.image.size.width * _theImageView.cy_cropFrameRatio.origin.x, self.theImageView.image.size.height * _theImageView.cy_cropFrameRatio.origin.y, self.theImageView.image.size.width * _theImageView.cy_cropFrameRatio.size.width, self.theImageView.image.size.height * _theImageView.cy_cropFrameRatio.size.height);
    CGFloat orgX = cropFrame.origin.x * (self.theImageView.image.size.width / self.theImageView.image.size.width);
    CGFloat orgY = cropFrame.origin.y * (self.theImageView.image.size.height / self.theImageView.image.size.height);
    CGFloat width = cropFrame.size.width * (self.theImageView.image.size.width / self.theImageView.image.size.width);
    CGFloat height = cropFrame.size.height * (self.theImageView.image.size.height / self.theImageView.image.size.height);
    CGRect cropRect = CGRectMake(orgX, orgY, width, height);
    CGImageRef imgRef = CGImageCreateWithImageInRect(self.theImageView.image.CGImage, cropRect);
    
    CGFloat deviceScale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(cropFrame.size, 0, deviceScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, cropFrame.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, cropFrame.size.width, cropFrame.size.height), imgRef);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imgRef);
    UIGraphicsEndImageContext();
    
    return newImg;
}

@end

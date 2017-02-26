//
//  BeeEditPicViewController.m
//  FDR
//
//  Created by Ji_YuFeng on 17/1/12.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeeEditPicViewController.h"
#import "BeeEditPicBottomView.h"
#import "BeePicCutViewController.h"
#import "CYCropView.h"
#import "UIImageView+CYCrop.h"
#import "UIImage-Extension.h"

@interface BeeEditPicViewController ()

@property (nonatomic,strong) UIImageView *BeeimageView;
@property (nonatomic,strong) BeeEditPicBottomView *bottomView;
@property (nonatomic,strong) UIImage *finallyImage;

@property (nonatomic,assign)BOOL Mirror;

@end

@implementation BeeEditPicViewController

- (id)initWithTheImage:(UIImage *)image Size:(CGSize)cropSize
{
    if (self = [super init]) {
        
        [self.BeeimageView setImage:image];
        [self.view addSubview:self.BeeimageView];
        [self.BeeimageView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-25);
            make.left.right.mas_equalTo(0);
                //            make.top.equalTo(self.view).offset(0);
            make.height.mas_equalTo(ScreenWidth*image.size.height/image.size.width);

            
        }];
        
        int thePicMaxHeight = ScreenHeight - 120;
        float theBeeImageViewHeight = ScreenWidth*image.size.height/image.size.width;
        float theRadio = thePicMaxHeight/theBeeImageViewHeight;
        if (theBeeImageViewHeight > thePicMaxHeight) {
            self.BeeimageView.transform = CGAffineTransformScale(self.BeeimageView.transform,theRadio, theRadio);
        }

        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        
    }
    return self;
}

- (BeeEditPicBottomView *)bottomView
{
    WS(weakSelf);
    if (!_bottomView) {
        _bottomView = [[BeeEditPicBottomView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.buttonActionBlock = ^(int theButtonTag){
            NSLog(@"thetag = %d",theButtonTag);
            if (theButtonTag == 0) {
                [weakSelf theViewTurn:M_PI/2];
            }
            else if (theButtonTag == 1) {
                [weakSelf theViewTurn:-M_PI/2];
            }
            else if (theButtonTag == 2) {
                [weakSelf theViewScale:NO];
            }
            else{
                [weakSelf theViewScale:YES];
            }
                
        };
    }
    return _bottomView;
}

- (UIImageView *)BeeimageView
{
    if (!_BeeimageView) {
        _BeeimageView = [[UIImageView alloc]init];
    }
    return _BeeimageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Mirror = NO;
    
    self.title = @"编辑图片";
    [self.rightbtn setTitle:@"完成" forState:0];
    self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)rightButtonAction:(UIButton *)sender
{
    WS(weakSelf);
    self.finallyImage = [self getCroppedImage];
    BeePicCutViewController *beeCutVC = [[BeePicCutViewController alloc]initWithTheImage:self.finallyImage andScale:self.scaleString];

    beeCutVC.beeCutBlock = ^(UIImage *img){
        
        if (weakSelf.beeEditDelegate && [weakSelf.beeEditDelegate respondsToSelector:@selector(theReturnImage:)]) {
            [weakSelf.beeEditDelegate theReturnImage:img];
        }
    };
    [self.navigationController pushViewController:beeCutVC animated:YES];
    
}

- (void)doTheScore
{
    if (self.BeeimageView.frame.size.width > ScreenWidth) {
        float scale = ScreenWidth/self.BeeimageView.frame.size.width;
        self.BeeimageView.transform = CGAffineTransformScale(self.BeeimageView.transform,scale, scale);
    }else{
        float scale = ScreenWidth/self.BeeimageView.frame.size.width;
        self.BeeimageView.transform = CGAffineTransformScale(self.BeeimageView.transform,scale, scale);
        
        int thePicMaxHeight = ScreenHeight - 120;
        float theBeeImageViewHeight = ScreenWidth*self.BeeimageView.frame.size.height/self.BeeimageView.frame.size.width;
        float theRadio = thePicMaxHeight/theBeeImageViewHeight;
        if (theBeeImageViewHeight > thePicMaxHeight) {
            self.BeeimageView.transform = CGAffineTransformScale(self.BeeimageView.transform,theRadio, theRadio);
        }
        
    }
    
    
}

- (void)theViewTurn:(float)theTurn
{
    [UIView animateWithDuration:0.15 animations:^{
        
//        self.BeeimageView.transform = CGAffineTransformRotate(self.BeeimageView.transform,-M_PI/2);
        self.BeeimageView.transform = CGAffineTransformRotate(self.BeeimageView.transform,theTurn);
        
        [self doTheScore];
    }];
}

- (void)theViewScale:(BOOL)leftRight
{
    if (self.Mirror == YES) {
        self.Mirror = NO;
    }else{
        self.Mirror = YES;
    }
    
    
    [UIView animateWithDuration:0.15 animations:^{

        if (leftRight == 1) {
            self.BeeimageView.transform = CGAffineTransformScale(self.BeeimageView.transform, -1, 1);
        }else{
            self.BeeimageView.transform = CGAffineTransformScale(self.BeeimageView.transform, 1, -1);
        }
        [self doTheScore];
    }];

}

#pragma mark - 获取裁剪后的图片
- (UIImage*) getCroppedImage {
    double rotationZ = [[self.BeeimageView.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
    
    UIImage *rotInputImage = [[self.BeeimageView.image fixOrientation] imageRotatedByRadians:rotationZ andMirror:self.Mirror];
    
    return rotInputImage;
}




@end

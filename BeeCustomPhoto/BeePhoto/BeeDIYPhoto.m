//
//  BeeDIYPhoto.m
//  FDR
//
//  Created by Ji_YuFeng on 17/1/12.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeeDIYPhoto.h"
#import "BeeEditPicViewController.h"
#import "BeePhotoGropViewController.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "BeePhotoModel.h"

static BeeDIYPhoto * beeDIYPhoto = nil;

@interface BeeDIYPhoto()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,BeeEditDelegate>

//@property (nonatomic,assign) LGShowImageType showType;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,copy) NSString *scale;

@end

@implementation BeeDIYPhoto

#pragma mark - 单例
+ (BeeDIYPhoto *)shareBeeDIYPhoto
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beeDIYPhoto = [[BeeDIYPhoto alloc] init];
    });
    return beeDIYPhoto;
}

#pragma mark -
#pragma mark - 显示ActionSheet方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC andScale:(NSString *)scale delegate:(id<BeeDIYPhotoDelegate>)aDelegate{
    beeDIYPhoto.beeDIYdelegate = aDelegate;
    self.fatherVC = fatherVC;
    self.scale = scale;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * TakePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self presentCameraSingle];
        
    }];
    
    UIAlertAction * Camera = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self presentPhotoPickerViewControllerWithStyle];
        
    }];
    [alertController addAction:cancel];
    [alertController addAction:TakePhoto];
    [alertController addAction:Camera];
    
    [self.fatherVC presentViewController:alertController animated:YES completion:nil];
    

}

/**
 *  初始化相机
 */
- (void)presentCameraSingle {

    // ** 设置相机模式
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        imagePC.sourceType  = UIImagePickerControllerSourceTypeCamera;
        imagePC.delegate = self;
        imagePC.allowsEditing = NO;
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未授权相机访问" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancel];
            [self.fatherVC presentViewController:alertController animated:YES completion:nil];
        }else{
            [self.fatherVC presentViewController:imagePC animated:YES completion:nil];
        }
        
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备没有照相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancel];
        [self.fatherVC presentViewController:alertController animated:YES completion:nil];
        
    }
}

/**
 *  初始化相册选择器
 */
- (void)presentPhotoPickerViewControllerWithStyle{
    
    BeePhotoGropViewController *vc = [[BeePhotoGropViewController alloc]init];;
    vc.maxcount = 1;
    vc.selectMore = NO;
    WS(weakSelf);
    vc.originblock = ^(BeePhotoModel *imgModel){
        UIImage *img = imgModel.bigImg;
        [weakSelf gotoCutPhotoViewController:img];
    };
    UINavigationController *nVC = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.fatherVC presentViewController:nVC animated:YES completion:nil];
    
}


#pragma mark - 拍照后拿到的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    
//    if (self.beeDIYdelegate && [self.beeDIYdelegate respondsToSelector:@selector(beeDiyTheImage:)]) {
//        [self.beeDIYdelegate beeDiyTheImage:image];
//    }
    [self gotoCutPhotoViewController:image];
    [self.fatherVC dismissViewControllerAnimated:NO completion:nil];

}



//去图片裁剪页面
- (void)gotoCutPhotoViewController:(UIImage *)image {
    
    BeeEditPicViewController *beeEditVC = [[BeeEditPicViewController alloc]initWithTheImage:image Size:image.size];
    beeEditVC.scaleString = self.scale;
    beeEditVC.beeEditDelegate = self;
    [self.fatherVC.navigationController pushViewController:beeEditVC animated:YES];
    
}

#pragma mark - beeEditDelegate
- (void)theReturnImage:(UIImage *)finallyImage
{
    if (self.beeDIYdelegate && [self.beeDIYdelegate respondsToSelector:@selector(beeDiyTheImage:)]) {
        [self.beeDIYdelegate beeDiyTheImage:finallyImage];
    }
}



@end

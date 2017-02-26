//
//  BeeViewController.m
//  BeeCustomPhoto
//
//  Created by Ji_YuFeng on 17/2/26.
//  Copyright © 2017年 Bee. All rights reserved.
//

#import "BeeViewController.h"
#import "BeeDIYPhoto.h"
#import "BeePhotoGropViewController.h"


//typedef NS_ENUM(NSInteger, CYCropScaleType) {
//    CYCropScaleTypeCustom,
//    CYCropScaleTypeOriginal,
//    CYCropScaleType1To1,
//    CYCropScaleType3To2,
//    CYCropScaleType2To3,
//    CYCropScaleType4To3,
//    CYCropScaleType3To4,
//    CYCropScaleType16To9,
//    CYCropScaleType9To16,
//    CYCropScaleType46To35,
//};

#define scare_1_1   @"2" // 根据上枚举第几个。。。可以自己前往定义CYCropView增加自定义比例

@interface BeeViewController ()<BeeDIYPhotoDelegate>

@property (nonatomic,strong) UIImageView *img;
@property (nonatomic,strong) UIButton *moreSelect;
@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;

@end

@implementation BeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *thelabel = [[UILabel alloc]init];
    thelabel.text = @"单选";
    thelabel.textColor = [UIColor blackColor];
    [self.view addSubview:thelabel];
    [thelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
    _img = [[UIImageView alloc]init];
    _img.backgroundColor = [UIColor redColor];
    [self.view addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.height.width.mas_equalTo(100);
    }];
    WS(weakSelf);
    [_img whenTapped:^{
        [weakSelf beePhoto];
    }];
    
    _moreSelect = [[UIButton alloc]init];
    [_moreSelect setTitle:@"多选" forState:0];
    [_moreSelect setTitleColor:[UIColor blackColor] forState:0];
//    _moreSelect.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_moreSelect];
    [_moreSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.img.mas_bottom).offset(50);
        make.height.width.mas_equalTo(50);
    }];
    [_moreSelect addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    _img1 = [[UIImageView alloc]init];
    _img1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_img1];
    [_img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_moreSelect.mas_bottom).offset(10);
        make.height.width.mas_equalTo(100);
    }];
    _img2 = [[UIImageView alloc]init];
    _img2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_img2];
    [_img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_img1.mas_bottom).offset(10);
        make.height.width.mas_equalTo(100);
    }];
    
    
    
}

- (void)beePhoto
{
    [BeeDIYPhotoImage showActionSheetInFatherViewController:self andScale:scare_1_1 delegate:self];
}

- (void)beeDiyTheImage:(UIImage *)image
{
    [self.img setImage:image];
}

- (void)moreAction
{
    BeePhotoGropViewController *vc = [[BeePhotoGropViewController alloc]init];
    vc.selectMore = YES;
    vc.maxcount = 2;  // 最多两张图片
    WS(weakSelf);
    vc.getImgArrBlock = ^(NSArray *arr){
//        NSLog(@"多选的图片data数组：imgdata = %@",arr);
        if (arr.count > 0) {
            if (arr[0]) {
                [weakSelf.img1 setImage:[UIImage imageWithData:arr[0]]];
            }
        }
        if (arr.count == 2) {
            if (arr[1]) {
                [weakSelf.img2 setImage:[UIImage imageWithData:arr[1]]];
            }
        }
        
        
    };
    UINavigationController *nvc =  [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}





@end

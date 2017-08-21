//
//  BeePhotoAlbumChooseViewController.m
//  FDR
//
//  Created by Ji_YuFeng on 17/2/16.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeePhotoAlbumChooseViewController.h"
#import "BeePhotoAlbumCollectionViewCell.h"
#import "BeePhotoModel.h"

@interface BeePhotoAlbumChooseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) NSMutableArray *array; // 展示图片的数组
@property (nonatomic,strong) UIImage *originImg;
@property (nonatomic,strong) NSMutableArray *selectMoreArr; // 多选 imagedata数组
@property (nonatomic,strong) NSMutableArray *picArray; //用于判断是否选中
//@property (strong, nonatomic) NSMutableArray *alubmsArr; //相册数组

@property (nonatomic,strong) BeePhotoModel *model;

@end

@implementation BeePhotoAlbumChooseViewController

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 设置列间距
        _layout.minimumInteritemSpacing = 3;
        // 设置行间距
        _layout.minimumLineSpacing = 3;
        // 设置布局方向
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        [_collectionView registerClass:[BeePhotoAlbumCollectionViewCell class] forCellWithReuseIdentifier:@"BeePhotoAlbumCollectionViewCell"];
        
        _collectionView.hidden = YES;
        
    }
    return _collectionView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.selectMoreArr = nil;
    self.picArray = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
//    [self.view addSubview:hud];
//    [hud show:YES];
    
    self.model = [[BeePhotoModel alloc]init];
    
    self.array = [[NSMutableArray alloc]init];
    self.selectMoreArr = [[NSMutableArray alloc]init];
    self.picArray = [[NSMutableArray alloc]init];
    
    self.title = @"选择照片";
    [self.rightbtn setTitle:@"完成" forState:0];
    self.rightbtn.hidden = self.selectMore?NO:YES;
    
    // 遍历相册获取asset照片
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:nil];
        PHAsset *asset = nil;
  
        for (int i = 0; i < fetchResult.count; i++) {
            asset = fetchResult[i];
            PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
            opt.synchronous = YES;
            
            PHImageManager *imageManager = [[PHImageManager alloc] init];
            [imageManager requestImageForAsset:asset targetSize:CGSizeMake((ScreenWidth-19)/4, (ScreenWidth-19)/4) contentMode:PHImageContentModeAspectFit options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if (result) {
                    [self.array addObject:result];
                    [self.picArray addObject:@1];
                }
                
            }];
   
            if (i == fetchResult.count - 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_collectionView reloadData];
//                    [hud hide:YES];
                });
            }
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_collectionView.contentSize.height > ScreenHeight - 64) {
                [self.collectionView setContentOffset:CGPointMake(0, _collectionView.contentSize.height - _collectionView.frame.size.height) animated:NO];
            }
            _collectionView.hidden = NO;
        });
        
    });
    

    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView delegate & datasource

//设置分区数（必须实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BeePhotoAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BeePhotoAlbumCollectionViewCell" forIndexPath:indexPath];
    cell.imageV.image = self.array[indexPath.row];
    
    if (self.selectMore == NO) {
        cell.imageV.userInteractionEnabled = NO;
    }
    else{
        NSInteger ifHidden = [self.picArray[indexPath.row] intValue];
        if (ifHidden == 1) {
            cell.selectImg.hidden = YES;
        }else{
            cell.selectImg.hidden = NO;
        }
        
        WS(weakSelf);
        cell.tapblock = ^(){
            [weakSelf addTheSelectArr:indexPath.row];
        };
        
    }
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-19)/4, (ScreenWidth-19)/4);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectMore == NO) {
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:nil];
        PHAsset *asset = fetchResult[indexPath.row];
        PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
        opt.synchronous = YES;
        
        PHImageManager *imageManager = [[PHImageManager alloc] init];
//        [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//            UIImage *myImage = [[UIImage alloc]initWithData:imageData];
//            
//            if (self.selectBlock) {
//                self.selectBlock(myImage);
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }
//        }];
        
        [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            self.model.smallImg = self.array[indexPath.row];
            self.model.bigImg = result;
            if (self.selectBlock) {
                self.selectBlock(self.model);
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
        
    }
    
}

#pragma mark - 
// 多选选中
- (void)addTheSelectArr:(NSInteger)index
{
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:nil];
    PHAsset *asset = fetchResult[index];
    PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
    opt.synchronous = YES;
    
    PHImageManager *imageManager = [[PHImageManager alloc] init];
//    [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
////        if ([self.selectMoreArr containsObject:imageData]) {
//        if ([self.picArray[index]  isEqual: @0]) {
//            [self.selectMoreArr removeObject:imageData];
//            [self.picArray replaceObjectAtIndex:index withObject:@1];
//        }
//        else{
//            [self.selectMoreArr addObject:imageData];
//            [self.picArray replaceObjectAtIndex:index withObject:@0];
//        }
//        if (self.selectMoreArr.count > self.maxCount) {
//            [self.selectMoreArr removeObject:imageData];
//            [self.picArray replaceObjectAtIndex:index withObject:@1];
//            NSString *string = [NSString stringWithFormat:@"最多只能选择%d张图片",(int)self.maxCount];
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
//            [alertController addAction:cancel];
//            [self presentViewController:alertController animated:YES completion:nil];
//            [self.collectionView reloadData];
//
//        }
//        
//    }];
    
    
    [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        self.model = [[BeePhotoModel alloc]init];
        
        self.model.bigImg = result;
        self.model.smallImg = self.array[index];
        self.model.theID = index;
        
        if ([self.picArray[index]  isEqual: @0]) {
//            [self.selectMoreArr removeObject:self.model];
//            for (BeePhotoModel *themodel in self.selectMoreArr) {
//                if (themodel.theID == index) {
//                    [self.selectMoreArr removeObject:themodel];
//                }
//            }
            
            for (int i = 0 ; i < self.selectMoreArr.count; i++) {
                self.model = self.selectMoreArr[i];
                if (self.model.theID == index) {
                    [self.selectMoreArr removeObjectAtIndex:i];
                }
            }
            
            
            [self.picArray replaceObjectAtIndex:index withObject:@1];
            return ;
        }
        else{
            [self.selectMoreArr addObject:self.model];
            [self.picArray replaceObjectAtIndex:index withObject:@0];
        }
        if (self.selectMoreArr.count > self.maxCount) {
            [self.selectMoreArr removeObject:self.model];
            [self.picArray replaceObjectAtIndex:index withObject:@1];
            NSString *string = [NSString stringWithFormat:@"最多只能选择%d张图片",(int)self.maxCount];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancel];
            [self presentViewController:alertController animated:YES completion:nil];
            [self.collectionView reloadData];
            
        }
        
        
    }];
    
    
    
    
}


// 完成
- (void)rightButtonAction:(UIButton *)sender
{
    if (self.selectMoreArr.count == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请至少选择一张图片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        if (self.imgArrBlock) {
            self.imgArrBlock(self.selectMoreArr);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
    
}




@end

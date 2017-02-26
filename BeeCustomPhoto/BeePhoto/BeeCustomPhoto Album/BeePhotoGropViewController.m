//
//  BeePhotoGropViewController.m
//  FDR
//
//  Created by Ji_YuFeng on 17/2/16.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeePhotoGropViewController.h"
#import <Photos/Photos.h>
#import "BeePhotoGropTableViewCell.h"
#import "BeePhotoAlbumChooseViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

static BeePhotoGropViewController * gropViewVC = nil;

@interface BeePhotoGropViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *alubmsArr; //相册数组


@end

@implementation BeePhotoGropViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        
        [_tableView registerClass:[BeePhotoGropTableViewCell class] forCellReuseIdentifier:@"BeePhotoGropTableViewCell"];
        
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}] ;
    self.leftbtn.hidden = YES;
    [self.rightbtn setTitle:@"Cancel" forState:0];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择相册";
    self.alubmsArr = [[NSMutableArray alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    
//    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//        switch (status) {
//            case PHAuthorizationStatusAuthorized:
//                NSLog(@"a");
//                break;
//            case PHAuthorizationStatusRestricted:
//                NSLog(@"b");
//                break;
//            case PHAuthorizationStatusDenied:
//                NSLog(@"c");
//                break;
//            default:
//                break;
//        }
//    }];
    
    
    
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未授权相册访问" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            if (*stop) {
                
                // TODO:...
                PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
                //获取系统相册
                PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
                if (fetchResult.count > 0) {
                    [_alubmsArr addObject:fetchResult[0]];
                }
                PHFetchResult *userAlbumsFetchResult = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:fetchOptions];
                for (PHAssetCollection *sub in userAlbumsFetchResult) {
                    [self.alubmsArr addObject:sub];
                }
                [self.tableView reloadData];
                if (_alubmsArr.count > 0) {
                    BeePhotoAlbumChooseViewController *vc = [[BeePhotoAlbumChooseViewController alloc]init];
                    vc.assetCollection = self.alubmsArr[0];
                    vc.selectMore = self.selectMore;
                    vc.maxCount = self.maxcount;
                    WS(weakSelf);
                    vc.selectBlock = ^(UIImage *img){
                        if (weakSelf.originblock) {
                            weakSelf.originblock(img);
                        }
                    };
                    vc.imgArrBlock = ^(NSArray *arr){
                        if (weakSelf.getImgArrBlock) {
                            weakSelf.getImgArrBlock(arr);
                        }
                    };
                    [self.navigationController pushViewController:vc animated:NO];
                }
                
                return;
            }
            *stop = TRUE;//不能省略
            
        } failureBlock:^(NSError *error) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未授权相册访问" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancel];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }];
    }else{
    
    
        PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
        //获取系统相册
        PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
        if (fetchResult.count > 0) {
            [_alubmsArr addObject:fetchResult[0]];
        }
        //获取用户相册
        PHFetchResult *userAlbumsFetchResult = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:fetchOptions];
        for (PHAssetCollection *sub in userAlbumsFetchResult) {
            [self.alubmsArr addObject:sub];
        }
        [self.tableView reloadData];

        if (_alubmsArr.count > 0) {
            BeePhotoAlbumChooseViewController *vc = [[BeePhotoAlbumChooseViewController alloc]init];
            vc.assetCollection = self.alubmsArr[0];
            vc.selectMore = self.selectMore;
            vc.maxCount = self.maxcount;
            WS(weakSelf);
            vc.selectBlock = ^(UIImage *img){
                if (weakSelf.originblock) {
                    weakSelf.originblock(img);
                }
            };
            vc.imgArrBlock = ^(NSArray *arr){
                if (weakSelf.getImgArrBlock) {
                    weakSelf.getImgArrBlock(arr);
                }
            };
            
            [self.navigationController pushViewController:vc animated:NO];
        }
    
    }

    
    
}


#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.alubmsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeePhotoGropTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeePhotoGropTableViewCell" forIndexPath:indexPath];
    
    PHFetchResult *group = [PHAsset fetchAssetsInAssetCollection:_alubmsArr[indexPath.row] options:nil];
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    [[PHImageManager defaultManager] requestImageForAsset:group.lastObject targetSize:CGSizeMake(70, 70) contentMode:PHImageContentModeDefault options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.img.image = result;
        cell.img.layer.masksToBounds = YES;
    }];
    PHAssetCollection *titleAsset = _alubmsArr[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",titleAsset.localizedTitle];
    cell.countLabel.text = [NSString stringWithFormat:@"共%lu张",(unsigned long)group.count];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeePhotoAlbumChooseViewController *vc = [[BeePhotoAlbumChooseViewController alloc]init];
    vc.assetCollection = self.alubmsArr[indexPath.row];
    vc.selectMore = self.selectMore;
    vc.maxCount = self.maxcount;
    WS(weakSelf);
    vc.selectBlock = ^(UIImage *img){
        if (weakSelf.originblock) {
            weakSelf.originblock(img);
        }
    };
    vc.imgArrBlock = ^(NSArray *arr){
        if (weakSelf.getImgArrBlock) {
            weakSelf.getImgArrBlock(arr);
        }
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 
- (void)rightButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

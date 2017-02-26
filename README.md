###单选 （选择图片-图片编辑-图片裁剪）<br>
首先导入BeeDIYPhoto.h ，继承\<UIBeeDIYPhototDelegate\><br> 
直接初始化后传入一个裁剪的比例，然后就可以在代理方法拿到返回的图片<br>
```object-c
- (void)beePhoto
{
    [BeeDIYPhotoImage showActionSheetInFatherViewController:self andScale:scare_1_1 delegate:self];
}

- (void)beeDiyTheImage:(UIImage *)image
{
    [self.img setImage:image];
}
```
这里的比例是由一个枚举决定的，大家如果有想自己定义的可以自行添加上去<br>
```object-c
typedef NS_ENUM(NSInteger, CYCropScaleType) {
    CYCropScaleTypeCustom,
    CYCropScaleTypeOriginal,
    CYCropScaleType1To1,
    CYCropScaleType3To2,
    CYCropScaleType2To3,
    CYCropScaleType4To3,
    CYCropScaleType3To4,
    CYCropScaleType16To9,
    CYCropScaleType9To16,
    CYCropScaleType46To35,
};
```
我在调用方法的类里定义了宏<br>
```object-c
#define scare_1_1   @"2" // 根据上枚举第几个。。。可以自己前往定义CYCropView增加自定义比例
```
<br>

###多选 (选择图片-返回图片数组)<br>
这里我们直接导入BeePhotoGropViewController，初始化把selectmore设置为yes，maxcount为你选择图片的最大数量，之后再getimageblock回调里可以得到返回的图片数组，注意这里返回的是data<br>
这里的相册也做了一点小优化，进入后会直接刷新到底部。图片700多张的时候可能会加载几秒，可以考虑加上风火轮优化效果<br>
```object-c
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
```
<br>
效果演示如下:<br>
![gif](https://github.com/iOSJYF/beeCustomPhoto/raw/master/beeCustomPhoto.gif)<br>

//
//  BeeBaseNavigationViewController.m
//  FDR
//
//  Created by Ji_YuFeng on 17/1/10.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeeBaseNavigationViewController.h"
//#import "BeeStatusBar.h"

@interface BeeBaseNavigationViewController ()

@property (nonatomic,strong) UIView *statusBarCoverView;

@end

@implementation BeeBaseNavigationViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 设置导航栏背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;  // 取消导航栏push的过程中的透明效果
    
//    UIView *statusView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, 20)];
//    [self.navigationController.navigationBar addSubview:statusView];
//    statusView.backgroundColor = FDR_LightBlueColor;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    self.navigationItem.titleView = self.titleLabel;
    
    [self setTheLeftButton];
    [self setTheRightButton];
    
//     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:[UIFont systemFontOfSize:15]],NSForegroundColorAttributeName:[UIColo]}] ;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
//    [BeeStatusBar setBackgroundColorToStatusBar:FDR_YellowColor];
    

    
    
    

    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - 导航栏左右按钮创建
- (void)setTheLeftButton
{
    //将leftItem设置为自定义按钮
    self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_leftbtn setImage:[UIImage imageNamed:@"icon_back_1"] forState:UIControlStateNormal];
    [self.leftbtn setTitle:@"返回" forState:0];
    self.leftbtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.leftbtn setTitleColor:[UIColor blackColor] forState:0];
    [self.leftbtn addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftbtn.frame = CGRectMake(0, 0, 40, 35);
    [_leftbtn setImageEdgeInsets:UIEdgeInsetsMake(10, -5, 10, 25)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftbtn];
    [leftItem setTitle:@""];
    [leftItem setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setTheRightButton
{
    
    //自定义rightButton
    self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightbtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.rightbtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.rightbtn setTitleColor:[UIColor blackColor] forState:0];
    [self.rightbtn addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightbtn.frame = CGRectMake(0, 0, 80, 64);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightbtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.rightbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

}



- (void)leftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonAction:(UIButton *)sender
{
    
}


//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{

}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
}



@end

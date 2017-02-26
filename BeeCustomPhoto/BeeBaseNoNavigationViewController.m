//
//  BeeBaseNoNavigationViewController.m
//  FDR
//
//  Created by Ji_YuFeng on 17/1/10.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeeBaseNoNavigationViewController.h"
//#import "BeeStatusBar.h"

@interface BeeBaseNoNavigationViewController ()

@end

@implementation BeeBaseNoNavigationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [BeeStatusBar setBackgroundAlphaToStatusBar:0];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.hidesBackButton = YES;
//    [BeeStatusBar setBackgroundColorToStatusBar:FDR_LightBlueColor];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false; // 因为隐藏了导航栏
    
    
    

    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
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

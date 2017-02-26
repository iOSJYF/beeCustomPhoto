//
//  BeeBaseNavigationViewController.h
//  FDR
//
//  Created by Ji_YuFeng on 17/1/10.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "ViewController.h"

@interface BeeBaseNavigationViewController : UIViewController

@property (nonatomic,strong) UIButton *leftbtn;
@property (nonatomic,strong) UIButton *rightbtn;


- (void)leftButtonAction;                          //左按钮点击事件
- (void)rightButtonAction:(UIButton *)sender;      //右按钮点击事件
- (void)keyboardWasShown:(NSNotification*)aNotification;
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;

@end

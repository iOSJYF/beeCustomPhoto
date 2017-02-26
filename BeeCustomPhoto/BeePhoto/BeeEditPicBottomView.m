//
//  BeeEditPicBottomView.m
//  FDR
//
//  Created by Ji_YuFeng on 17/1/13.
//  Copyright © 2017年 QSYS. All rights reserved.
//

#import "BeeEditPicBottomView.h"

@implementation BeeEditPicBottomView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        NSArray *picArray = @[@"icon_rotate_right",@"icon_rotate_left.png",@"icon_flipud",@"icon_fliplr"];
        
        for (int i = 0; i < 4 ; i ++) {
            UIView *theButtonView = [[UIView alloc]init];
            theButtonView.frame = CGRectMake(i*ScreenWidth/4, 0, ScreenWidth/4, 50);
            [self addSubview:theButtonView];
            UIButton *theButton = [[UIButton alloc]init];
            [theButton setImage:[UIImage imageNamed:picArray[i]] forState:0];
            [theButtonView addSubview:theButton];
            [theButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(0);
                make.height.width.mas_equalTo(50);
            }];
            theButton.tag = 100+i;
            [theButton addTarget:self action:@selector(theButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    return self;
}

- (void)theButtonAction:(UIButton *)sender
{
    int theTag = sender.tag - 100;
    if (self.buttonActionBlock) {
        self.buttonActionBlock(theTag);
    }
}


@end

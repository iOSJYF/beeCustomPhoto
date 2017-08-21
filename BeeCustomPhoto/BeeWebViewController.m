//
//  BeeWebViewController.m
//  BeeCustomPhoto
//
//  Created by Ji_YuFeng on 2017/8/18.
//  Copyright © 2017年 Bee. All rights reserved.
//

#import "BeeWebViewController.h"

@interface BeeWebViewController ()

@end

@implementation BeeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIWebView *webv = [[UIWebView alloc]init];
    [self.view addSubview:webv];
    webv.backgroundColor = [UIColor yellowColor];
    [webv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    webv.scrollView.bounces = NO;
    
//    NSURL *theurl = [NSURL URLWithString:@"http://esports.net.cn:6323/yongshun/app/about.php"];
//    [webv loadRequest:[NSURLRequest  requestWithURL:theurl]];
    
    NSString *string1 = @"\r\n\t\"\" \r\n</p>\r\n\r\n\t上海勇顺电气（集团）有限公司是专业生产高低压成套开关柜，高、低元件及电力工程总承包、安装、型式试验等产品的高新技术企业。 公司注册在上海嘉定区金宝工业区，占地面积3万平方米，各类专业技术管理人才占总人数30%。公司拥有ISO质量认证、CCC强制认证、PCC专业认证、安全认证、建交委送变电叁级资质，国家电监会的四级承、装、修、试电力施工资质及精良的结构数控机床设备、完善的工艺流程；并致力于技术创新和责任，时刻秉承想用户所想；同时，公司连续10年被工商局评为重合同守信用单位，并获全国售后服务先进单位。 因此，我们坚持以质量取胜，竭诚为顾客提供先进、安全、可靠、低成本的满意产品；并打造中国唯一在电力设备产品中“保修三年，终身维护”的高品质品牌；今天的勇顺已跳出地域、面向全国，在集约化、规范化的基础上进一步品牌化，积极跻身世界一流电气行列；同时，坚持与“巨人同行，与世界同步”的发展战略，先后与日本三菱、ABB等国外优秀企业建立了合作关系。在勇顺独到的客户服务理念之下，针对产品的特点，建立了直销的营销模式，同时，扩展了产品的应用领域，直接运用到：汽车制造业，钢铁治金、造纸印刷、石油化工、食品医药、烟草酒业、工厂酒店、发电站、船舶、机场车站、学校医院、购物中心、仓储中心等国家重点工程；赢得了越来越多客户的信赖。\r\n</p>\r\n\r\n\t\"\"\"\"\r\n</p>\r\n\r\n\t\r\n</p>\r\n\r\n\t\"企业介绍\" \r\n</p>\r\n\r\n\r\n\t\r\n</p>\"";
    
    
    
    [webv loadHTMLString:string1 baseURL:nil];
    
}



@end

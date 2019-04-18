//
//  CoinGoodDetailViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.

#import "CoinGoodDetailViewController.h"
#import "CarouselView.h"
#import "BCCouponView.h"
#import "BCDivideView.h"
#import "BCGoodView.h"
#import "CoinConfirmOrderViewController.h"
#import "CoinLoginViewController.h"
#import "CoinChangePhoneViewController.h"
#import "CoinMemberBuyViewController.h"
#import "CoinCertifyViewController.h"
#import "CoinLoginViewController.h"
@interface CoinGoodDetailViewController ()<UIScrollViewDelegate>
{
    UIImageView *backImageView;//滑竿
    UIButton *selectedBtn;
    NSDictionary *dataDic;
    UIScrollView *_scView;//显示图片详情
    NSArray *divideArr;
    NSArray *sizeArr;
    NSString *price;//商品价格
    NSString * phone;
    BCDivideView *diviV;
    NSArray *goodHistoryArr;
    NSDictionary *orderDict;
}
@property (nonatomic, strong) UIScrollView *backScrollView;//底部scrollview
@property (nonatomic, strong) UIView *headView;//头部标签

@end

@implementation CoinGoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
 
   
    [self.view addSubview:self.backScrollView];
   
     [self.view addSubview: self.headView];
    
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(LEFT_Margin, BCNaviHeight - 35, 25, 25);
    
    
    [btn setImage:[UIImage imageNamed:@"Back"] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"Back"] forState:(UIControlStateHighlighted)];
    [self.view addSubview:btn];
    [btn setEnlargeEdge:10];
    [btn addtargetBlock:^(UIButton *button) {
    
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    
    
    [self initView];
    
    [self initSecondView];
    
    [self initBottomView];
    
    [self initBottomButton];
    
    [self getData];
    [self requestPhone];
    
    
  
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    if (![self.navigationController.viewControllers containsObject:self]) {
        [diviV removeFromSuperview];
    }
    
}

- (void)initView {
    
    //    轮播图
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, 358)];
    
    [self.backScrollView addSubview:view];
    
   
    
    
//    价格
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"¥ 5399"];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular16Font};
    [str setAttributes:firstAttributes range:NSMakeRange(0,1)];
    
    UILabel *priceL = [[UILabel alloc] init];
    priceL.tag = 200;
    priceL.textColor = COLOR(254, 36, 72);
    priceL.font = Regular(17);
    priceL.attributedText = str;
    [self.backScrollView addSubview:priceL];
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(LEFT_Margin);
        make.top.equalTo(view.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
    }];
    
//    中划线
    NSDictionary * firstAttributes1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName:Regular(9)};
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"¥6288" attributes:firstAttributes1];
    UILabel *segLabel = [[UILabel alloc] init];
    segLabel.attributedText = str1;
    segLabel.textColor = COLOR(153, 153, 153);
    segLabel.font = Regular(11);
    segLabel.tag = 300;
    [self.backScrollView addSubview:segLabel];
    [segLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(priceL.mas_right).offset(2);
        make.bottom.equalTo(priceL.mas_bottom);
        make.height.mas_equalTo(11);
    }];
    
    
//    分期
    UILabel *titleL = [[UILabel alloc] init];
    titleL.text = @"分期：￥1100*6期";
    titleL.tag = 500;
    titleL.textColor = COLOR(166, 166, 166);
    titleL.textAlignment = NSTextAlignmentRight;
    titleL.font = Regular(12);
    titleL.hidden = ![Tool AuditState];
    [self.backScrollView addSubview:titleL];
    [titleL addTapGestureWithBlock:^{
       
       

        
        //    点击打开分期
        
        [UIView animateWithDuration:.25 animations:^{//评论页从底部显示动画
            
           diviV.top = 0;
        }];
        
        diviV.backBlock = ^(id  _Nonnull result) {
          
            NSLog(@"]]]]%@",result);
            
            if ([result objectNilForKey:@"cancel"]) {//点击取消按钮
                
                 NSDictionary *dic = [dataDic objectNilForKey:@"goods_info"];
                  UILabel *titleL = [self.backScrollView viewWithTag:500];
                
                NSDictionary *newDic = [dic objectNilForKey:@"fenqi_info"];
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"分期 ¥%.2f*%@期",[[newDic objectNilForKey:@"per_money"] floatValue],[newDic objectNilForKey:@"periods"]]];
                NSDictionary * firstAttributes = @{ NSForegroundColorAttributeName:COLOR(242,48,48)};
                NSString *priceS = [NSString stringWithFormat:@"%.2f",[[newDic objectNilForKey:@"per_money"] floatValue]];
                [str setAttributes:firstAttributes range:NSMakeRange(3,priceS.length + 1)];
                titleL.attributedText = str;
                
                
                 divideArr = [result objectNilForKey:@"lixi"];
                
            }else{
            if ([[result objectForKey:@"isfenqi"]isEqualToString:@"1"]) {
                UILabel *titleL = [self.backScrollView viewWithTag:500];
              
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"分期 ¥%.2f*%@期",[[result objectNilForKey:@"money"] floatValue],[result objectNilForKey:@"period"]]];
                NSDictionary * firstAttributes = @{ NSForegroundColorAttributeName:COLOR(242,48,48)};
                NSString *priceS = [NSString stringWithFormat:@"%.2f",[[result objectNilForKey:@"money"] floatValue]];
                [str setAttributes:firstAttributes range:NSMakeRange(3,priceS.length + 1)];
                titleL.attributedText = str;
//
                divideArr = [result objectNilForKey:@"lixi"];
            } else {
                 UILabel *titleL = [self.backScrollView viewWithTag:500];
                titleL.text = @"不分期";
                divideArr = nil;
            }
            }
        };
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BCWidth - 150 - 15);
        make.bottom.equalTo(priceL.mas_bottom);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(12);
        
    }];
    
    
    
//    商品标题
    NSArray *titleA = @[@"二手",@"自营"];
    for (int i = 0; i < 2 ; i++) {
        UIButton *activityBtn = [UIButton new];
        [activityBtn setTitleColor:COLOR(254, 36, 72) forState:UIControlStateNormal];
        [activityBtn setTitle:titleA[i] forState:UIControlStateNormal];
        [activityBtn.titleLabel setFont:Regular(12)];
        activityBtn.layer.borderWidth = 1;
        activityBtn.layer.borderColor = COLOR(254, 36, 72).CGColor;
        
        activityBtn.layer.cornerRadius = 5;
        [self.backScrollView addSubview:activityBtn];
        
        
        [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceL.mas_bottom).offset(15);
            make.left.mas_equalTo(LEFT_Margin + i*(35 + 5));
            
            make.size.mas_equalTo(CGSizeMake(35, 15));
        }];
        
    }
 
    
    
    
    
   UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = Regular(16);
    nameLabel.attributedText = [self setLabelIndent:14*titleA.count text:@"华为(HUAWEI) mate20pro手机樱粉金 8G+128G 全网通"];
  
    nameLabel.tag = 100;
    nameLabel.numberOfLines = 2;
    [self.backScrollView addSubview:nameLabel];
   
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceL.mas_bottom).offset(12);
        make.left.mas_equalTo(LEFT_Margin);
        make.width.mas_equalTo(320);
    }];
    
    
//    快递
    NSArray *arr = @[@"月销3409笔",@"快递:包邮",@"江苏南京"];
    for (int i = 0; i < arr.count; i++) {
        
        UILabel *titleL1 = [[UILabel alloc] init];
        titleL1.text = arr[i];
        titleL1.textColor = COLOR(166, 166, 166);
        titleL1.tag = 400 + i;
        titleL1.font = Regular(12);
        [self.backScrollView addSubview:titleL1];
        
        [titleL1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(LEFT_Margin + i*((BCWidth - 30 - 100*3)/2 + 100));
            make.top.equalTo(nameLabel.mas_bottom).offset(TOP_Margin);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(13);
            
        }];
        
        
        if (i == 1) {
            titleL1.textAlignment = NSTextAlignmentCenter;
        }
        
        
        if (i == 2) {
            titleL1.textAlignment = NSTextAlignmentRight;
        }
    }
    
    
    

}


#pragma  mark 底部view

- (void)initBottomView {
    
    
    //    分割区
    
    UILabel *nameLabel = [self.backScrollView viewWithTag:100];
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.backScrollView addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(nameLabel.mas_bottom).offset(40);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(TOP_Margin);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
  
    
    
    
//    查看优惠券
    
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"查看优惠券：";
    leftL.textColor = COLOR(166, 166, 166);
    leftL.font = Regular(12);
    [self.backScrollView addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(36);
        make.top.mas_equalTo(divideView.mas_bottom);
        
    }];
    
    
//    优惠券标题
    UIView *easeView = [[UIView alloc] init];
    easeView.tag = 600;
    [self.backScrollView addSubview:easeView];
    [easeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(leftL.mas_right);
        make.top.equalTo(leftL.mas_top);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(BCWidth - 85);
    }];
    
    
//    点击打开优惠券
    
    [easeView addTapGestureWithBlock:^{
        
        if (![Tool isLogin]) {
           
            VCToast(@"请先登录才能查看优惠券", 1);
            return ;
        }
       
        
        BCCouponView *vv = [[BCCouponView alloc] initWithFrame:CGRectMake(0, BCHeight, BCWidth, BCHeight) andUserID:_goodID withPrice:price];
        [self.view addSubview:vv];
        [UIView animateWithDuration:.25 animations:^{//评论页从底部显示动画
            
            vv.top = 0;
        }];
        
    }];
    
    
    UIImageView *rightImage = [[UIImageView alloc] init];
    rightImage.image = BCImage(Back---Icon-);
    [easeView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(BCWidth - 85 - 25);
        make.centerY.equalTo(easeView);
    }];
    
    
   
//    规格
    
    UILabel *leftL1 = [[UILabel alloc] init];
    leftL1.text = @"规格：";
    leftL1.textColor = COLOR(166, 166, 166);
    leftL1.font = Regular(12);
    [self.backScrollView addSubview:leftL1];
    [leftL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(36);
        make.top.mas_equalTo(leftL.mas_bottom);
        
    }];
    
    
//   规格
    UIView *easeView1 = [[UIView alloc] init];
    [self.backScrollView addSubview:easeView1];
    [easeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(leftL1.mas_right);
        make.top.equalTo(leftL1.mas_top);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(BCWidth - 85);
    }];
    
    
    
    //    点击打开规格
    
    [easeView1 addTapGestureWithBlock:^{
        
        NSDictionary *dic;
        if (divideArr.count <= 0) {//如果没选择分期
            dic = @{@"q_fenqi":@"0",@"shou_pay":@"0",@"period":@"0"};
        } else {//如果选择了分期
            
            
          
            NSString *stage = [divideArr firstObject];
            if ([stage isEqualToString:@"零首付"]) {
                stage = @"0";
            } else {
                
                NSString *newStr = [stage substringToIndex:1];
                stage = [NSString stringWithFormat:@"%.1f",[newStr floatValue]/10];
            }
             dic = @{@"q_fenqi":@"1",@"shou_pay":stage,@"period":[divideArr lastObject]};
            
        }
        BCGoodView *vv = [[BCGoodView alloc] initWithFrame:CGRectMake(0, BCHeight, BCWidth, BCHeight) andGoodID:_goodID withPara:dic buyNum:[[goodHistoryArr objectAtIndexCheck:0] integerValue] color:[[goodHistoryArr objectAtIndexCheck:1] integerValue] size:[[goodHistoryArr objectAtIndexCheck:2] integerValue]];
        [self.view addSubview:vv];
        [UIView animateWithDuration:.25 animations:^{//评论页从底部显示动画
            
            vv.top = 0;
        }];
        
        vv.backBlock = ^(id  _Nonnull result) {
            
              NSLog(@")))%@",result);
            if ([result objectNilForKey:@"cancel"]) {
              
                 UILabel *sizeL = [self.backScrollView viewWithTag:700];
                 NSDictionary *dic1 = [dataDic objectNilForKey:@"spec_info"];
                   sizeL.text = [dic1 objectNilForKey:@"spec_param"];
                sizeArr = nil;
                goodHistoryArr = nil;
                
                
                UILabel *priceL = [self.backScrollView viewWithTag:200];
                NSDictionary *dic2 = [dataDic objectNilForKey:@"goods_info"];
                NSDictionary *dic11 = [dataDic objectNilForKey:@"spec_info"];
                
                
                
                if (BCStringIsEmpty([dic11 objectNilForKey:@"spec_price"])) {//先判断有没有规格价，有则显示，无则显示shop价格
                    
                    price = [dic2 objectNilForKey:@"shop_price"];
                    
                } else {
                    
                    price = [dic11 objectNilForKey:@"spec_price"];
                    
                }
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %ld",[price integerValue]]];
                NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular14Font};
                [str setAttributes:firstAttributes range:NSMakeRange(0,1)];
                
                priceL.attributedText = str;
                
                
            } else {
            
          
            sizeArr = [result objectForKey:@"arr"];
             UILabel *sizeL = [self.backScrollView viewWithTag:700];
            sizeL.text = [result objectForKey:@"size"];
            goodHistoryArr = [result objectForKey:@"history"];
              
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[result objectForKey:@"price"]];
                NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular14Font};
                [str setAttributes:firstAttributes range:NSMakeRange(0,1)];
                UILabel *priceL = [self.backScrollView viewWithTag:200];
                priceL.attributedText = str;
            }
        };
    }];
    
    
    UILabel *rightL = [[UILabel alloc] init];
    
    rightL.textColor = COLOR(103, 103, 103);
    rightL.font = Regular(13);
    rightL.tag = 700;
    [easeView1 addSubview:rightL];
    [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(TOP_Margin);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(36);
    }];
    
    UIImageView *rightImage1 = [[UIImageView alloc] init];
    rightImage1.image = BCImage(Back---Icon-);
    [easeView1 addSubview:rightImage1];
    [rightImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(rightImage.mas_left);
        make.centerY.equalTo(easeView1);
    }];
    
    

//    服务
    UILabel *leftL2 = [[UILabel alloc] init];
    leftL2.text = @"服务：";
    leftL2.textColor = COLOR(166, 166, 166);
    leftL2.font = Regular(12);
    [self.backScrollView addSubview:leftL2];
    [leftL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(36);
        make.top.mas_equalTo(leftL1.mas_bottom);
        
    }];
    
    
    
    UIView *easeView2 = [[UIView alloc] init];
    [self.backScrollView addSubview:easeView2];
    [easeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(leftL2.mas_right);
        make.top.equalTo(leftL2.mas_top);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(BCWidth - 85);
    }];
    
    
   
    
    UILabel *rightL1 = [[UILabel alloc] init];
    rightL1.text = @"由商城自营发货并提供售后服务，不支持7天无理由退货，支持换货";
    rightL1.textColor = COLOR(103, 103, 103);
    rightL1.numberOfLines = 0;
    rightL1.font = Regular(13);
    [easeView2 addSubview:rightL1];
    [rightL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(TOP_Margin);
        make.top.mas_equalTo(9);

        make.width.mas_equalTo(260);
    }];
    
   
    
  //    分割线
    for (int i = 0; i < 2; i ++) {
        UIImageView *lineImage = [[UIImageView alloc] init];
        lineImage.backgroundColor = COLOR(242, 242, 242);
        
        [self.backScrollView addSubview:lineImage];
        [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.top.equalTo(divideView.mas_bottom).offset((i + 1) * 36);
            make.width.mas_equalTo(BCWidth);
            make.height.mas_equalTo(1);
        }];
    }
    
  
}

#pragma mark 底部按钮
- (void)initBottomButton {
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = White;
    [self.backScrollView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.backScrollView.height - 50);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    
    UIButton *backBtn= [[UIButton alloc] init];
    
    [backBtn setTitle:@"客服" forState:UIControlStateNormal];
    [backBtn setTitleColor:COLOR(183, 183, 183) forState:UIControlStateNormal];
    backBtn.titleLabel.font = Regular11Font;
    backBtn.contentHorizontalAlignment = 1;
    [backBtn setImage:BCImage(联系客服) forState:UIControlStateNormal];
    [bottomView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    [backBtn imagePositionStyle:ImagePositionStyleTop spacing:7];
    
    [backBtn addtargetBlock:^(UIButton *button) {
       
        NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",[[dataDic objectNilForKey:@"goods_info"] objectNilForKey:@"customer_mobile"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    
    
//    立即购买
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(17);
    [backBtn1 setTitle:@"立即购买" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.backgroundColor = COLOR(255, 56, 85);
    [bottomView addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(BCWidth - 120);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(120);
    }];
    [backBtn1 addTarget:self action:@selector(GoBuy) forControlEvents:(UIControlEventTouchUpInside)];
}



- (BOOL)disposeStatus:(int)status{
    //status:1成功 0:未登录 -1:请先购买会员卡 -2:不符合分期条件 -3:会员卡到期 -4:请先验证身份信息 -5:请先绑卡 -6:请先评估您的信用/您的信用评分已过期,请重新评估 -7:请先设置交易密码 -8:库存不足 -9:剩余额度不足,请调整首付比例
   
    UIViewController * PushVC;
    if (status == 1) {
        return YES;
    }
    if (status == 0) {
        PushVC = [CoinLoginViewController new];
    }
    if (status == -1 || status == -3) {
        
            CoinMemberBuyViewController * VC = [CoinMemberBuyViewController new];
            VC.type  = BRPayBuyMember;
        PushVC = VC;
      
        
    }
    if (status == -2) {
      
        
    }
    if (status == -3) {
       
    }
    if (status == -4) {
        CoinCertifyViewController * vc = [CoinCertifyViewController new];
        vc.indexType = 1;
        vc.isFenqi = YES;
        PushVC = vc;
    }
    if (status == -5) {
        CoinCertifyViewController * vc = [CoinCertifyViewController new];
        vc.indexType = 2;
        vc.isFenqi = YES;
        PushVC = vc;
    }
    if (status == -6) {
        CoinCertifyViewController * vc = [CoinCertifyViewController new];
        vc.indexType = 3;
        vc.isFenqi = YES;
        PushVC = vc;
    }
    if (status == -7) {
        CoinChangePhoneViewController * vc = [CoinChangePhoneViewController new];
        vc.isSetPay = YES;
        vc.phoneNum = phone;
        PushVC = vc;
    }
    
    
    if (status==-11) {
        CoinCertifyViewController * vc = [CoinCertifyViewController new];
        vc.indexType = 1;
        vc.isFenqi = YES;
        PushVC = vc;
    }
    if (status==-12) {
        CoinCertifyViewController * vc = [CoinCertifyViewController new];
        vc.indexType = 4;
        vc.IDName = orderDict[@"name"];
        vc.IDCard = orderDict[@"idcard"];
        vc.isFenqi = YES;
        PushVC = vc;
    }
        if (PushVC) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:PushVC animated:YES];
            });
        }
    return NO;
    
}

- (void)requestPhone{
     [KTooL HttpPostWithUrl:@"UserCenter/index" parameters:nil loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            phone = responseObject[@"data"][@"mobile"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


#pragma mark 购买商品
- (void)GoBuy{
    
    if (![Tool isLogin]) {
        

        
             [self.navigationController pushViewController:[CoinLoginViewController new] animated:YES];
        
       
        return;
    }
    
   if (sizeArr.count <= 0) {//如果规则页没选过则购买的时候弹出来
        
        NSDictionary *dic;
        if (divideArr.count <= 0) {//如果没选择分期
            dic = @{@"q_fenqi":@"0",@"shou_pay":@"0",@"period":@"0"};
        } else {//如果选择了分期
            
            NSString *stage = [divideArr firstObject];
            if ([stage isEqualToString:@"零首付"]) {
                stage = @"0";
            } else {
                
                NSString *newStr = [stage substringToIndex:1];
                stage = [NSString stringWithFormat:@"%.1f",[newStr floatValue]/10];
            }
            dic = @{@"q_fenqi":@"1",@"shou_pay":stage,@"period":[divideArr lastObject]};
            
        }
        
        BCGoodView *vv = [[BCGoodView alloc] initWithFrame:CGRectMake(0, BCHeight, BCWidth, BCHeight) andGoodID:_goodID withPara:dic buyNum:[[goodHistoryArr objectAtIndexCheck:0] integerValue] color:[[goodHistoryArr objectAtIndexCheck:1] integerValue] size:[[goodHistoryArr objectAtIndexCheck:2] integerValue]];
        [self.view addSubview:vv];
        [UIView animateWithDuration:.25 animations:^{//评论页从底部显示动画
            
            vv.top = 0;
        }];
        
        vv.backBlock = ^(id  _Nonnull result) {
            
            NSLog(@")))%@",result);
            
            if ([result objectNilForKey:@"cancel"]) {
                
                UILabel *sizeL = [self.backScrollView viewWithTag:700];
                NSDictionary *dic1 = [dataDic objectNilForKey:@"spec_info"];
                sizeL.text = [dic1 objectNilForKey:@"spec_param"];
                sizeArr = nil;
                goodHistoryArr = nil;
                
                
                UILabel *priceL = [self.backScrollView viewWithTag:200];
                NSDictionary *dic2 = [dataDic objectNilForKey:@"goods_info"];
                NSDictionary *dic11 = [dataDic objectNilForKey:@"spec_info"];
                
                
                
                if (BCStringIsEmpty([dic11 objectNilForKey:@"spec_price"])) {//先判断有没有规格价，有则显示，无则显示shop价格
                    
                    price = [dic2 objectNilForKey:@"shop_price"];
                    
                } else {
                    
                    price = [dic11 objectNilForKey:@"spec_price"];
                    
                }
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %ld",[price integerValue]]];
                NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular14Font};
                [str setAttributes:firstAttributes range:NSMakeRange(0,1)];
                
                priceL.attributedText = str;
                
                
                
            } else {
            
            sizeArr = [result objectForKey:@"arr"];
            UILabel *sizeL = [self.backScrollView viewWithTag:700];
            sizeL.text = [result objectForKey:@"size"];
            
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[result objectForKey:@"price"]];
                NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular14Font};
                [str setAttributes:firstAttributes range:NSMakeRange(0,1)];
                UILabel *priceL = [self.backScrollView viewWithTag:200];
                priceL.attributedText = str;
                
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            dict[@"q_fenqi"] = divideArr.count<=0?@"0":@"1";
            dict[@"goods_id"] = _goodID;
            dict[@"item_id"] = [sizeArr lastObject];
            dict[@"num"] = [sizeArr firstObject];
            
            if (divideArr.count > 0) {
                
                if (!BCStringIsEmpty([divideArr lastObject])) {
                    NSCharacterSet * nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
                    int remainSecond =[[[divideArr lastObject] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    dict[@"periods"] = [NSString stringWithFormat:@"%d",remainSecond];
                }
          dict[@"stages"]  = [divideArr firstObject];
        if ([dict[@"stages"] isEqualToString:@"零首付"]) {
            dict[@"stages"]  = @"0";
            } else {
               NSString *newStr = [dict[@"stages"] substringToIndex:1];
            dict[@"stages"]  = [NSString stringWithFormat:@"%.1f",[newStr floatValue]/10];
            }
                
            }
            
          [KTooL HttpPostWithUrl:@"Order/confirm_order" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
              
              NSLog(@"11111=====");
              
              orderDict = [responseObject objectForKey:@"data"];
                if (![self disposeStatus:[responseObject[@"status"] intValue]]) {
                    
                    VCToast(BCMsg, 1);
                }
                if ([responseObject[@"status"] intValue] == 1) {
                    CoinConfirmOrderViewController * VC = [CoinConfirmOrderViewController new];
                    VC.q_fenqi = divideArr.count<=0?@"0":@"1";
                    VC.goods_id = _goodID;
                    VC.num = [sizeArr firstObject];
                    VC.item_id = [sizeArr lastObject];
                    
                    if (divideArr.count > 0) {
                        VC.periods = [divideArr lastObject];
                        NSString *stage = [divideArr firstObject];
                        if ([stage isEqualToString:@"零首付"]) {
                            VC.stages = @"0";
                        } else {
                            
                            NSString *newStr = [stage substringToIndex:1];
                            VC.stages = [NSString stringWithFormat:@"%.1f",[newStr floatValue]/10];
                        }
                        
                    }
                    [self.navigationController pushViewController:VC animated:YES];
                    
                    sizeArr = nil;
//                    goodHistoryArr = nil;
                
                }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                }];
                
                //
                
            
            }
        };
        
        
        
        
    }else {
        
       
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"q_fenqi"] = divideArr.count<=0?@"0":@"1";
        dict[@"goods_id"] = _goodID;
        dict[@"item_id"] = [sizeArr lastObject];
        dict[@"num"] = [sizeArr firstObject];
        
        if (divideArr.count > 0) {
            
            if (!BCStringIsEmpty([divideArr lastObject])) {
                NSCharacterSet * nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
                int remainSecond =[[[divideArr lastObject] stringByTrimmingCharactersInSet:nonDigits] intValue];
                dict[@"periods"] = [NSString stringWithFormat:@"%d",remainSecond];
            }
            
            
            dict[@"stages"]  = [divideArr firstObject];
            if ([dict[@"stages"] isEqualToString:@"零首付"]) {
                dict[@"stages"]  = @"0";
            } else {
                
                NSString *newStr = [dict[@"stages"] substringToIndex:1];
                dict[@"stages"]  = [NSString stringWithFormat:@"%.1f",[newStr floatValue]/10];
            }
            
        }
        
        
        
        [KTooL HttpPostWithUrl:@"Order/confirm_order" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
             orderDict = [responseObject objectForKey:@"data"];
            if (![self disposeStatus:[responseObject[@"status"] intValue]]) {
                
                VCToast(BCMsg, 1);
            }
            if ([responseObject[@"status"] intValue]) {
                CoinConfirmOrderViewController * VC = [CoinConfirmOrderViewController new];
                VC.q_fenqi = divideArr.count<=0?@"0":@"1";
                VC.goods_id = _goodID;
                VC.num = [sizeArr firstObject];
                VC.item_id = [sizeArr lastObject];
                
                if (divideArr.count > 0) {
                    VC.periods = [divideArr lastObject];
                    NSString *stage = [divideArr firstObject];
                    if ([stage isEqualToString:@"零首付"]) {
                        VC.stages = @"0";
                    } else {
                        
                        NSString *newStr = [stage substringToIndex:1];
                        VC.stages = [NSString stringWithFormat:@"%.1f",[newStr floatValue]/10];
                    }
                    
                }
                [self.navigationController pushViewController:VC animated:YES];
                
                sizeArr = nil;
//                goodHistoryArr = nil;
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        //
        
        
    }
    
   
}

#pragma mark 商品详情页
- (void)initSecondView {
    
    
    _scView = [[UIScrollView alloc] initWithFrame:CGRectMake(BCWidth, BCNaviHeight, BCWidth, BCHeight - BCNaviHeight)];

    _scView.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
    _scView.showsVerticalScrollIndicator = NO;//
    [self.backScrollView addSubview:_scView];
    
}

#pragma mark 点击顶部按钮
- (void)clickTopButton:(UIButton *)btn {
    
    if (btn!= selectedBtn) {
        
        selectedBtn.selected = NO;
        btn.selected = YES;
        selectedBtn = btn;
        
    }else{
        
        selectedBtn.selected = YES;
    }
    
    [self.backScrollView setContentOffset:CGPointMake(BCWidth * (btn.tag - 200), 0) animated:YES];
    [backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(btn);
       make.top.equalTo(btn.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
        
    }];
}

#pragma mark 网络请求
- (void)getData {
    
    [KTooL HttpPostWithUrl:@"Goods/goodsinfo" parameters:@{@"goods_id":_goodID} loadString:@"正在加载" success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (BCStatus) {
            NSLog(@"==%@",responseObject);
            dataDic = [responseObject objectNilForKey:@"data"];
            [self refreshView];
            
        } else {
            
            VCToast(responseObject[@"error"], 2);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        VCToast(error.description, 1);
    }];
    
}


- (void)refreshView {
    
    NSArray *imageArr = [dataDic objectNilForKey:@"image_urls"];
    
    CarouselView *view = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, 358) displayImages:imageArr andClickEnable:NO];
    
    [self.backScrollView addSubview:view];
    
    
//    商品信息
    NSDictionary *dic = [dataDic objectNilForKey:@"goods_info"];
    UILabel *nameLabel = [self.backScrollView viewWithTag:100];
    nameLabel.attributedText = [self setLabelIndent:14*2 text:[NSString stringWithFormat:@"%@，%@",[dic objectNilForKey:@"goods_name"],[dic objectNilForKey:@"goods_remark"]]];
    
//    价格
    
    UILabel *priceL = [self.backScrollView viewWithTag:200];
   
     NSDictionary *dic1 = [dataDic objectNilForKey:@"spec_info"];
    
    
    
    if (BCStringIsEmpty([dic1 objectNilForKey:@"spec_price"])) {//先判断有没有规格价，有则显示，无则显示shop价格
        
        price = [dic objectNilForKey:@"shop_price"];
        
    } else {
        
        price = [dic1 objectNilForKey:@"spec_price"];
        
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %ld",[price integerValue]]];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular14Font};
    [str setAttributes:firstAttributes range:NSMakeRange(0,1)];
    
    priceL.attributedText = str;
    
    
    UILabel *marketL = [self.backScrollView viewWithTag:300];
    NSDictionary * firstAttributes1 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName:Regular(9)};
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[dic objectNilForKey:@"market_price"]] attributes:firstAttributes1];
    marketL.attributedText = str1;
    
    
//    销量
    
    for (int i = 0; i < 2; i ++) {
        
        UILabel *label = [self.backScrollView viewWithTag:400 + i];
        if (i == 0) {//销量
            
            label.text = [NSString stringWithFormat:@"月销%@笔",[dic objectNilForKey:@"sales_sum"]];
            
        } else {
            
            if ([[dic objectNilForKey:@"is_free_shipping"] integerValue] == 1) {//是否包邮
                
                label.text = @"快递:包邮";
            } else {
                
                
                label.text = [NSString stringWithFormat:@"快递:%@元",[dic objectNilForKey:@"freight"]];
            }
            
            
            
        }
    }
    
    
//    是否可以分期
    UILabel *titleL = [self.backScrollView viewWithTag:500];
    if ([[dic objectNilForKey:@"is_fenqi"] integerValue] != 1) {
        titleL.hidden = YES;
    } else {
        
        NSDictionary *newDic = [dic objectNilForKey:@"fenqi_info"];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"分期 ¥%.2f*%@期",[[newDic objectNilForKey:@"per_money"] floatValue],[newDic objectNilForKey:@"periods"]]];
        NSDictionary * firstAttributes = @{ NSForegroundColorAttributeName:COLOR(242,48,48)};
        NSString *priceS = [NSString stringWithFormat:@"%.2f",[[newDic objectNilForKey:@"per_money"] floatValue]];
        [str setAttributes:firstAttributes range:NSMakeRange(3,priceS.length + 1)];
        titleL.attributedText = str;
        
        
        //    默认是分期
        if ([Tool AuditState]) {
            divideArr = @[@"零首付",[NSString stringWithFormat:@"%@",[newDic objectNilForKey:@"periods"]] ];
        }
       
        
    }


    
//    优惠券
    UIView *easeView = [self.backScrollView viewWithTag:600];
    
     NSArray * tagsArray = [[dataDic objectNilForKey:@"coupons_info"] componentsSeparatedByString:@" "];
  
   
    
    for (int i = 0; i < tagsArray.count - 1 ; i++) {
        UIButton *activityBtn = [UIButton new];
        [activityBtn setTitleColor:COLOR(254, 36, 72) forState:UIControlStateNormal];
        [activityBtn setTitle:tagsArray[i] forState:UIControlStateNormal];
        [activityBtn.titleLabel setFont:Regular(12)];
        activityBtn.layer.borderWidth = 1;
        activityBtn.layer.borderColor = COLOR(254, 36, 72).CGColor;
        
        activityBtn.layer.cornerRadius = 5;
        [easeView addSubview:activityBtn];
        
        
        [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(easeView);
            make.left.mas_equalTo(i*(88 + 10) + 10);
            
            make.size.mas_equalTo(CGSizeMake(88, 20));
        }];
        
    }
    
    
//  规格
    UILabel *sizeL = [self.backScrollView viewWithTag:700];
    sizeL.text = [dic1 objectNilForKey:@"spec_param"];
    
    
//    图片详情
   NSArray *images = [dic objectNilForKey:@"goods_content"];
    CGFloat tmpHeight = 0;
    for (int i = 0; i < images.count; i ++) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:images[i] ]];
        UIImage *img = [UIImage imageWithData:data];
       
        if (!img) {
            
            continue;
        }
        CGFloat imgHeight = img.size.height;
        CGFloat imgWidth = img.size.width;
        
        CGFloat imgH = imgHeight * (BCWidth / imgWidth);
        
        UIImageView *_showImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, tmpHeight,BCWidth , imgH)];
        
        //设置imageView的背景图
        [_showImg setImage:img];
        //给imageView设置区域
        _showImg.contentMode = UIViewContentModeScaleAspectFill;
        //把视图添加到当前的滚动视图中
        [_scView addSubview:_showImg];
        _scView.contentSize = CGSizeMake(0,imgH + tmpHeight);//设置滚动视图的大小
        
        tmpHeight = imgH + tmpHeight;
    }
    
    
//    分期view
    diviV = [[BCDivideView alloc] initWithFrame:CGRectMake(0, BCHeight, BCWidth, BCHeight) andGoodID:_goodID withPrice:price];
    [self.view addSubview:diviV];
   
}
#pragma mark 懒加载加载需要的视图
- (UIView *)headView {
    if (!_headView) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , BCWidth , BCNaviHeight)];
      
        _headView.backgroundColor = ThemeColor;
        
        
        NSArray *titleArr1 = @[@"商品",@"详情"];
        for(int i = 0; i < titleArr1.count; i++) {
            UIButton *segmentButton1 = [[UIButton alloc] init];
            
            segmentButton1.titleLabel.font = Regular(17);
            [segmentButton1 setTitle:titleArr1[i] forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:COLOR(102, 102, 102) forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
            
            
            segmentButton1.tag = 200 + i;
            [segmentButton1 addTarget:self action:@selector(clickTopButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [_headView addSubview:segmentButton1];
            [segmentButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo( i*(BCWidth - 170 - 100 + 50) + 85);
                make.top.mas_equalTo(BCNaviHeight - 45);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(40);
            }];
            
            if (i == 0) {
                backImageView = [[UIImageView alloc] init];
                backImageView.backgroundColor = TITLE_COLOR;
                [_headView addSubview:backImageView];
                [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.width.equalTo(segmentButton1);
                    make.top.equalTo(segmentButton1.mas_bottom).offset(1);
                    make.height.mas_equalTo(1);
                    
                }];
                
                segmentButton1.selected = YES;
                selectedBtn = segmentButton1;
            }
            
        }
        
        
        
        
        
        
        
        //           滑竿
        
        
        
    }
    
    return _headView;
}

- (UIScrollView *)backScrollView {
    if (!_backScrollView) {
      
        _backScrollView = [[UIScrollView alloc] initWithFrame:BCBound];
        
        _backScrollView.backgroundColor = White;
    _backScrollView.showsHorizontalScrollIndicator=NO;
        _backScrollView.showsVerticalScrollIndicator=NO;
        _backScrollView.pagingEnabled=YES;
        _backScrollView.bounces=NO;
       
        _backScrollView.delegate = self;
      
        _backScrollView.contentSize=CGSizeMake(BCWidth * 2, 0);
        
        
        
    }
    
    
    return _backScrollView;
}
- (NSAttributedString *)setLabelIndent:(CGFloat)indent text:(NSString *)text {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.firstLineHeadIndent = indent * 3;
    NSDictionary *attributeDic = @{NSParagraphStyleAttributeName : paragraphStyle};
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:attributeDic];
    return attrText;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //     点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
    UIButton *btn = [self.headView viewWithTag:200 + index];
    
    [self clickTopButton:btn];
    
}

@end

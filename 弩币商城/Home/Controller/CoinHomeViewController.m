//
//  CoinHomeViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinHomeViewController.h"
#import "CarouselView.h"
#import "CoinGoodDetailViewController.h"

@interface CoinHomeViewController ()

@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) UIView *navView;//导航栏
@end

@implementation CoinHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
     
     [self.view addSubview:self.backScrollView];
    
    
    
    
    [self initView];
    
    [self initSecondView];
    
    [self initThridView];
    
    [self initFourView];
    
    
    [self initNavView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
  
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
    
}

#pragma mark 初始化导航栏
-(void)initNavView {
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCNaviHeight)];
    _navView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_navView];
    
    
    UIButton *topBtn = [[UIButton alloc] initWithFrame:CGRectMake(LEFT_Margin, BCNaviHeight - 40, BCWidth - 60 - LEFT_Margin, 30)];
    topBtn.backgroundColor = White;
    topBtn.layer.cornerRadius = 10;
    topBtn.clipsToBounds = YES;
    [_navView addSubview:topBtn];
    
    
    
    UIImageView *seachImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_Margin, 2.5, 17, 25)];
    seachImageView.image = BCImage(搜索框logo);
    
    [topBtn addSubview:seachImageView];
    
    
    UIImageView *seachImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(seachImageView.right + 15, 8, 14, 14)];
    seachImageView1.image = BCImage(放大镜);
    
    [topBtn addSubview:seachImageView1];
    
    
    
    
//    登录按钮
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(BCWidth - 60, topBtn.top, 60, 30)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:White forState:UIControlStateNormal];
    loginBtn.titleLabel.font = Regular(15);
    [_navView addSubview:loginBtn];
    
}
- (void)initView {
    
    
//    轮播图
  
    CarouselView *view = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, 170) displayImages:@[BCImage(首页banner),BCImage(首页banner),BCImage(首页banner)] andClickEnable:YES];
   
    [self.backScrollView addSubview:view];
    
    
    
    
//    3c产品
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.backScrollView addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(view.mas_bottom);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(TOP_Margin);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    
//    头部标题
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"3C产品";
    leftL.textColor = TITLE_COLOR;
    leftL.font = Regular(15);
    [self.backScrollView addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(divideView.mas_bottom);
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(40);
        
    }];
    
   
    UIButton *backBtn= [[UIButton alloc] init];
    
    [backBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [backBtn setTitleColor:COLOR(167, 167, 167) forState:UIControlStateNormal];
    backBtn.titleLabel.font = Regular11Font;
    backBtn.contentHorizontalAlignment = 2;
    [backBtn setImage:BCImage(查看更多) forState:UIControlStateNormal];
    [self.backScrollView addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(divideView.mas_bottom);
       make.left.mas_equalTo(BCWidth - 100 - LEFT_Margin);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
     [backBtn imagePositionStyle:ImagePositionStyleRight spacing:7];
    
    
//    商品图片
    for (int i = 0; i < 2; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.backgroundColor = ImageColor;
        [self.backScrollView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.top.equalTo(leftL.mas_bottom).offset(5);
            make.left.mas_equalTo(LEFT_Margin + i *((BCWidth - 30 - 10)/2 + 10));
            make.width.mas_equalTo((BCWidth - 30 - 10)/2);
            make.height.mas_equalTo(110);
            
        }];
        
        
//        商品标题
        UILabel *titleL = [[UILabel alloc] init];
        titleL.text = @"HUAWEI Mate 20 Pro";
        titleL.textColor = TITLE_COLOR;
        titleL.font = Regular(12);
        [self.backScrollView addSubview:titleL];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(imageV.mas_bottom).offset(3);
            make.left.equalTo(imageV.mas_left).offset(8);
            make.height.mas_equalTo(12);
            
        }];
        
//        商品价格
        UILabel *moneyL = [[UILabel alloc] init];
        
        moneyL.text = @"¥";
        moneyL.textColor = COLOR(251, 82, 24);
        moneyL.font = Regular(10);
        [self.backScrollView addSubview:moneyL];
        [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(titleL.mas_left);
            make.top.equalTo(titleL.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"5399起"];
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular12Font};
        [str setAttributes:firstAttributes range:NSMakeRange(str.length - 1,1)];
        
        UILabel *priceL = [[UILabel alloc] init];
      
        priceL.textColor = COLOR(251, 82, 24);
        priceL.font = Regular(18);
        priceL.attributedText = str;
        [self.backScrollView addSubview:priceL];
        [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(moneyL.mas_right).offset(2);
            make.top.equalTo(moneyL.mas_top);
            make.height.mas_equalTo(16);
        }];
        
        
        
//        分期
        UILabel *moneyL1 = [[UILabel alloc] init];
        
        moneyL1.text = @"¥";
        moneyL1.textColor = COLOR(153, 153, 153);
        moneyL1.font = Regular(8);
        [self.backScrollView addSubview:moneyL1];
        [moneyL1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(priceL.mas_right).offset(2);
            make.top.equalTo(moneyL.mas_top).offset(2);
            make.height.mas_equalTo(8);
        }];
        
     
        
        
//        下划线
        
       
        NSDictionary * firstAttributes1 = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"1000*6期" attributes:firstAttributes1];
        UILabel *segLabel = [[UILabel alloc] init];
        segLabel.attributedText = str1;
        segLabel.textColor = COLOR(153, 153, 153);
        segLabel.font = Regular(12);
        [self.backScrollView addSubview:segLabel];
        [segLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(moneyL1.mas_right).offset(2);
            make.top.mas_equalTo(moneyL1.mas_top);
            make.height.mas_equalTo(15);
        }];
    }
    
    
    
}

#pragma 严选专区

- (void)initSecondView {
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.backScrollView addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(365);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(TOP_Margin);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    
    
//    严选标题
    NSArray *title = @[@"严选专区",@"奢侈品专区"];
    NSArray *title1 = @[@"精选商品",@"海外直购"];
    NSArray *imageArr = @[@"严选",@"奢侈品"];
    
    for (int i = 0; i < 2; i ++) {
        
        UIView *backV = [[UIView alloc] init];
        backV.backgroundColor = COLOR(242, 242, 242);
        [self.backScrollView addSubview:backV];
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(divideView.mas_bottom).offset(TOP_Margin);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo((BCWidth - 30 - 10)/2);
            make.left.mas_equalTo(LEFT_Margin + i*((BCWidth - 30 - 10)/2 + 10));
        }];
        
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.text = title[i];
        titleL.textColor = TITLE_COLOR;
        titleL.font = Regular(15);
        [backV addSubview:titleL];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(8);
            make.height.mas_equalTo(15);
            
        }];

        
        
        UILabel *titleL1 = [[UILabel alloc] init];
        titleL1.text = title1[i];
        titleL1.textColor = COLOR(153, 153, 153);
        
        titleL1.font = Regular(13);
        [backV addSubview:titleL1];
        
        [titleL1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(8);
            make.height.mas_equalTo(15);
            
        }];
        
        
        
//        图片
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[i]]];
        [backV addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.mas_equalTo(-5);
            make.centerY.equalTo(backV);
            make.width.mas_equalTo(80);
        }];
        
    }
    
    
    
//    两个商品
    for (int i = 0; i < 2; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.backgroundColor = ImageColor;
        [self.backScrollView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(divideView.mas_bottom).offset(80);
            make.left.mas_equalTo(LEFT_Margin + i *((BCWidth - 30 - 10)/2 + 10));
            make.width.mas_equalTo((BCWidth - 30 - 10)/2);
            make.height.mas_equalTo(140);
            
        }];
        
        
        //        商品标题
        UILabel *titleL = [[UILabel alloc] init];
        titleL.text = @"秋冬保暖加厚澳洲羊毛被";
        titleL.textColor = TITLE_COLOR;
        titleL.font = Regular(12);
        [self.backScrollView addSubview:titleL];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(imageV.mas_bottom).offset(3);
            make.left.equalTo(imageV.mas_left).offset(8);
            make.height.mas_equalTo(12);
            
        }];
        
        //        商品价格
        UILabel *moneyL = [[UILabel alloc] init];
        
        moneyL.text = @"¥";
        moneyL.textColor = COLOR(251, 82, 24);
        moneyL.font = Regular(10);
        [self.backScrollView addSubview:moneyL];
        [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(titleL.mas_left);
            make.top.equalTo(titleL.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"5399起"];
        NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular12Font};
        [str setAttributes:firstAttributes range:NSMakeRange(str.length - 1,1)];
        
        UILabel *priceL = [[UILabel alloc] init];
        
        priceL.textColor = COLOR(251, 82, 24);
        priceL.font = Regular(18);
        priceL.attributedText = str;
        [self.backScrollView addSubview:priceL];
        [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(moneyL.mas_right).offset(2);
            make.top.equalTo(moneyL.mas_top);
            make.height.mas_equalTo(16);
        }];
        
        
        
      
    }
    
    
}


#pragma mark 努库银票

- (void)initThridView {
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.backScrollView addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(645);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(TOP_Margin);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    //    头部标题
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"帑库银票";
    leftL.textColor = TITLE_COLOR;
    leftL.font = Regular(15);
    [self.backScrollView addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(divideView.mas_bottom);
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(40);
        
    }];
    
    
    UIImageView *moneyImageV = [[UIImageView alloc] init];
    moneyImageV.image = BCImage(帑库银票);
    [self.backScrollView addSubview:moneyImageV];
    [moneyImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(leftL.mas_bottom).offset(5);
        make.left.mas_equalTo(LEFT_Margin);
        make.width.mas_equalTo(BCWidth - 30);
        make.height.mas_equalTo(100);
    }];
    
}

- (void)initFourView {
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.backScrollView addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(815);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(TOP_Margin);
        make.width.mas_equalTo(BCWidth);
        
    }];
    
    //    头部标题
    UILabel *leftL = [[UILabel alloc] init];
    leftL.text = @"葫芦回收";
    leftL.textColor = TITLE_COLOR;
    leftL.font = Regular(15);
    [self.backScrollView addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(divideView.mas_bottom);
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(40);
        
    }];
    
    
    UIImageView *moneyImageV = [[UIImageView alloc] init];
    moneyImageV.image = BCImage(葫芦回收);
    [self.backScrollView addSubview:moneyImageV];
    [moneyImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(leftL.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(132);
        make.bottom.equalTo(self.backScrollView).offset(-170);
    }];
    
}
#pragma mark 懒加载
- (UIScrollView *)backScrollView {
    
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight )];
//        _backScrollView.delegate = self;
//
        _backScrollView.backgroundColor = White;
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        
        [_backScrollView addTapGestureWithBlock:^{
              [self.navigationController pushViewController:[CoinGoodDetailViewController new] animated:YES];
        }];
        
    }
    
    
    return _backScrollView;
}




@end

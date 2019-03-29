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
#import "CoinCertifyViewController.h"
#import "CoinNotDevelopViewController.h"
#import "CoinSearchViewController.h"
#import "CoinPayNotFristViewController.h"
#import "CoinLoginViewController.h"
#import "CoinMemberSucceedViewController.h"
#import "CoinBorrowMoneyViewController.h"
@interface CoinHomeViewController ()<ClickImageLoopViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

{
    NSString *banaUrl;//轮播图链接
    NSString *huluUrl;//葫芦回收链接
    UIButton *loginBtn;
    CGFloat oldY;
    UICollectionView *myCollectionView;//3c
}

@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) UIView *navView;//导航栏
@property (nonatomic, strong) NSMutableArray *goodArray;//商品数据
@end

@implementation CoinHomeViewController
static NSString *cellID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
     
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
     
     [self.view addSubview:self.backScrollView];
    
    
    _goodArray = [NSMutableArray arrayWithCapacity:1];
    
    [self initView];
    
    [self initSecondView];
    
    [self initThridView];
    
    [self initFourView];
    
    
    [self initNavView];

    
    //为了第一次安装app出现的问题
    if ([Tool isConnectionAvalible]) {
        
        [self getData];
        
    } else {
        
//        WOWONoDataView *view = [[WOWONoDataView alloc] initWithImageName:@"order" text:@"网络似乎出现了问题" detailText:nil buttonTitle:@"点击刷新"];
//        [self.view addSubview:view];
//        [view.button addtargetBlock:^(UIButton *button) {

//           
//            [self getData];
//        }];
//        

//
//            [self getData];
//        }];
        
   
    }
   
    [NOTIFICATION_CENTER addObserver:self selector:@selector(loginSuccess) name:Login_Success object:nil];

}

- (void)loginSuccess{
    [loginBtn setTitle:@"" forState:UIControlStateNormal];
    [loginBtn setImage:[UIImage imageNamed:@"我的 (1)"] forState:UIControlStateNormal];
    [loginBtn addtargetBlock:^(UIButton *button) {
        self.tabBarController.selectedIndex = 3;
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
  
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //    版本更新
    [self upDateVersion];
}
#pragma mark 网络请求
- (void)getData {
    
    [KTooL HttpPostWithUrl:@"Index/homepage" parameters:nil loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [self.backScrollView.mj_header endRefreshing];
        
        NSLog(@"===%@",responseObject);
        if ([[responseObject objectNilForKey:@"status"]integerValue] == 1) {
            
            [_goodArray addObjectsFromArray:[[responseObject objectNilForKey:@"data"] objectForKey:@"goods_list"]];
            
            NSArray *arr = [[responseObject objectNilForKey:@"data"] objectForKey:@"banner_list"];
           
            if (arr.count > 0 && !BCArrayIsEmpty(arr)) {
                
                banaUrl = [[arr firstObject] objectForKey:@"ad_link"];

            }
            
            huluUrl = [[responseObject objectNilForKey:@"data"] objectForKey:@"hulu_receive_url"];
            
//            刷新界面
            [myCollectionView reloadData];
        } else {
            
         
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        VCToast(error.description, 1);
    }];
    
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
//    跳转到搜索界面
    [topBtn addtargetBlock:^(UIButton *button) {
       
        [self.navigationController pushViewController:[CoinSearchViewController new] animated:YES];
    }];
    
    
    
    UIImageView *seachImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_Margin, 2.5, 17, 25)];
    seachImageView.image = BCImage(搜索框logo);
    
    [topBtn addSubview:seachImageView];
    
    
    UIImageView *seachImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(seachImageView.right + 15, 8, 14, 14)];
    seachImageView1.image = BCImage(放大镜);
    
    [topBtn addSubview:seachImageView1];
    
    
    
    
//    登录按钮
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(BCWidth - 60, topBtn.top, 60, 30)];
   
    [loginBtn setTitleColor:White forState:UIControlStateNormal];
    loginBtn.titleLabel.font = Regular(15);
    
    
        [_navView addSubview:loginBtn];
    
    
    if ([Tool isLogin]) {
        [loginBtn setImage:[UIImage imageNamed:@"我的 (1)"] forState:UIControlStateNormal];
        [loginBtn addtargetBlock:^(UIButton *button) {
            self.tabBarController.selectedIndex = 3;
        }];
    } else {
        
         [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn addtargetBlock:^(UIButton *button) {
            CoinLoginViewController *VC = [[CoinLoginViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }];
    }
    
    
}
- (void)initView {
    
    
//    轮播图
  
    CarouselView *view = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, 170) displayImages:@[@"首页banner"] andClickEnable:YES];
    view.delegete = self;
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
    [backBtn addtargetBlock:^(UIButton *button) {
       
         self.tabBarController.selectedIndex = 1;
    }];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(divideView.mas_bottom);
       make.left.mas_equalTo(BCWidth - 100 - LEFT_Margin);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
     [backBtn imagePositionStyle:ImagePositionStyleRight spacing:7];
    
    
//    左右滑动
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置UICollectionView为横向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 每一行cell之间的间距


        flowLayout.itemSize = CGSizeMake((BCWidth - 40)/2 , 160);// 该行代码就算不写,item也会有默认尺寸
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 212, BCWidth, 160) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = White;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.bounces = NO;
    myCollectionView = collectionView;
    [self.backScrollView addSubview:collectionView];
     collectionView.showsHorizontalScrollIndicator = NO;
    [myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];

    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _goodArray.count;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    
    
    
    return UIEdgeInsetsMake(0, 15, 0, 15);
    
    
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    UIImageView *imageV = [cell.contentView viewWithTag:100];
    if (!imageV) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.tag = 100 ;
        imageV.backgroundColor = ImageColor;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        [cell.contentView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo((BCWidth - 40)/2);
            make.height.mas_equalTo(110);
            
        }];
        
        //        商品标题
                        UILabel *titleL = [[UILabel alloc] init];
                        titleL.text = @"HUAWEI Mate 20 Pro";
                        titleL.textColor = TITLE_COLOR;
                        titleL.tag = 200;
                        titleL.font = Regular(12);
                        [cell.contentView addSubview:titleL];
        
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
                        [cell.contentView addSubview:moneyL];
                        [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
                            make.left.mas_equalTo(titleL.mas_left);
                            make.top.equalTo(titleL.mas_bottom).offset(5);
                            make.height.mas_equalTo(10);
                        }];
        
        
        
        
                        UILabel *priceL = [[UILabel alloc] init];
                        priceL.tag = 300 ;
                        priceL.textColor = COLOR(251, 82, 24);
                        priceL.font = Regular(18);
        
                        [cell.contentView addSubview:priceL];
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
                        [cell.contentView addSubview:moneyL1];
                        [moneyL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
                            make.left.equalTo(priceL.mas_right).offset(2);
                            make.top.equalTo(moneyL.mas_top).offset(2);
                            make.height.mas_equalTo(8);
                        }];
        
        
        
        
                //        下划线
        
        
        
                        UILabel *segLabel = [[UILabel alloc] init];
                        segLabel.tag = 400 ;
        
                        segLabel.textColor = COLOR(153, 153, 153);
                        segLabel.font = Regular(12);
                        [cell.contentView addSubview:segLabel];
                        [segLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
                            make.left.equalTo(moneyL1.mas_right).offset(2);
                            make.top.mas_equalTo(moneyL1.mas_top);
                            make.height.mas_equalTo(15);
                        }];
        
    }
    
        
    UIImageView *image = [cell.contentView viewWithTag:100 ];
    UILabel *title = [cell.contentView  viewWithTag:200 ];
    UILabel *price = [cell.contentView  viewWithTag:300];
    UILabel *fenqi = [cell.contentView  viewWithTag:400 ];
    
    [image sd_setImageWithURL:[NSURL URLWithString:[[_goodArray objectAtIndex:indexPath.row] objectForKey:@"original_img"] ]];
    title.text = [[_goodArray objectAtIndex:indexPath.row] objectForKey:@"goods_name"];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld起",[[[_goodArray objectAtIndex:indexPath.row] objectForKey:@"shop_price"] integerValue] ]];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular12Font};
    [str setAttributes:firstAttributes range:NSMakeRange(str.length - 1,1)];
    
    price.attributedText = str;
    
    
    
    NSDictionary * firstAttributes1 = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[[_goodArray objectAtIndex:indexPath.row] objectForKey:@"fenqi_info"] attributes:firstAttributes1];
    
    fenqi.attributedText = str1;
    
    
  
   
    
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
      //        跳转商品详情界面
    CoinGoodDetailViewController *vc = [[CoinGoodDetailViewController alloc] init];
    vc.goodID = [[_goodArray objectAtIndex:indexPath.row] objectForKey:@"goods_id"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma  mark 严选专区

- (void)initSecondView {
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.backScrollView addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(385);
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
        
        [backV addTapGestureWithBlock:^{
            
            [self.navigationController pushViewController:[CoinNotDevelopViewController new] animated:YES];
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
      NSArray *imageArr1 = @[@"羊毛被 拷贝",@"宝 拷贝"];
    for (int i = 0; i < 2; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
       
        imageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr1[i]]];
        [self.backScrollView addSubview:imageV];
        [imageV addTapGestureWithBlock:^{
           
            [self.navigationController pushViewController:[CoinNotDevelopViewController new] animated:YES];
        }];
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
        
        make.top.mas_equalTo(665);
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
    [moneyImageV addTapGestureWithBlock:^{
       
        self.tabBarController.selectedIndex = 2;
    }];
    
    
}

- (void)initFourView {
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.backScrollView addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(835);
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
        make.bottom.equalTo(self.backScrollView).offset(-80);
    }];
    
    [moneyImageV addTapGestureWithBlock:^{
        CoinH5ViewController *vc = [[CoinH5ViewController alloc] init];
        vc.url = self->huluUrl;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
}
#pragma mark 懒加载
- (UIScrollView *)backScrollView {
    
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight )];

        _backScrollView.delegate = self;
        _backScrollView.backgroundColor = White;
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.showsHorizontalScrollIndicator = NO;
       
        MJRefreshStateHeader *header = [self loadMJRefresh:^{
           
            [self getData];
        }];
        
        
        _backScrollView.mj_header = header;
       
//        [_backScrollView addTapGestureWithBlock:^{
//
//            [self.navigationController pushViewController:[CoinCertifyViewController new] animated:YES];
//        }];
        
    }
    
    
    return _backScrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual: self.backScrollView]) {
        
        NSLog(@"===%f",scrollView.contentOffset.y);
       CGFloat alphaValue = MIN(1, scrollView.contentOffset.y/(BCNaviHeight * 2));
        
       
            
            _navView.backgroundColor = ACOLOR(242,48,48, alphaValue);
        

    }
}




#pragma mark 点击轮播图
- (void)didClickImageLoopIndex:(NSInteger)index{
     CoinH5ViewController *vc = [[CoinH5ViewController alloc] init];
    vc.url = banaUrl;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 版本更新
- (void)upDateVersion {
   
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    
    [KTooL HttpPostWithUrl:@"User/app_version" parameters:@{@"reg_from":@"3",@"version_nubmer":app_Version} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            NSDictionary *dataDic = [responseObject objectNilForKey:@"data"];
            
            if ([[dataDic objectNilForKey:@"status"] integerValue] == 1) {
                [self showSystemAlertTitle:[NSString stringWithFormat:@"更新:%@",[dataDic objectNilForKey:@"title"]] message:[dataDic objectNilForKey:@"update_content"] cancelTitle:nil confirmTitle:@"现在更新" cancel:nil confirm:^{
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dataDic objectNilForKey:@"link"]]];
                }];
            }
            
            
        } else {
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
}

@end

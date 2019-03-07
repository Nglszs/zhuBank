//
//  CoinGoodDetailViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinGoodDetailViewController.h"
#import "CarouselView.h"
#import "BCCouponView.h"
#import "BCDivideView.h"
#import "BCGoodView.h"

@interface CoinGoodDetailViewController ()<UIScrollViewDelegate>
{
    UIImageView *backImageView;//滑竿
    UIButton *selectedBtn;
}
@property (nonatomic, strong) UIScrollView *backScrollView;//底部scrollview
@property (nonatomic, strong) UIView *headView;//头部标签

@end

@implementation CoinGoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.titleView = self.headView;
   
    [self.view addSubview:self.backScrollView];
    
   
    
    [self initView];
    
    [self initSecondView];
    
    [self initBottomView];
    
    [self initBottomButton];
    
    [self getData];
}


- (void)initView {
    
    //    轮播图
    
    CarouselView *view = [[CarouselView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, 358) displayImages:@[BCImage(首页banner),BCImage(首页banner),BCImage(首页banner)] andClickEnable:YES];
    
    [self.backScrollView addSubview:view];
    
   
    
    
//    价格
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"¥ 5399"];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:Regular16Font};
    [str setAttributes:firstAttributes range:NSMakeRange(0,1)];
    
    UILabel *priceL = [[UILabel alloc] init];
    
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
    [self.backScrollView addSubview:segLabel];
    [segLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(priceL.mas_right).offset(2);
        make.bottom.equalTo(priceL.mas_bottom);
        make.height.mas_equalTo(11);
    }];
    
    
    
//    分期
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.text = @"分期：￥1100*6期";
    titleL.textColor = COLOR(166, 166, 166);
    titleL.textAlignment = NSTextAlignmentRight;
    titleL.font = Regular(12);
    [self.backScrollView addSubview:titleL];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BCWidth - LEFT_Margin - 100);
        make.bottom.equalTo(priceL.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(12);
        
    }];
    
    
    
//    商品标题
    NSArray *titleA = @[@"正品",@"自营",@"包邮"];
    for (int i = 0; i < 3 ; i++) {
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
  

    nameLabel.numberOfLines = 0;
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
    
    UIImageView *divideView = [[UIImageView alloc] init];
    divideView.backgroundColor = DIVI_COLOR;
    [self.backScrollView addSubview:divideView];
    [divideView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(480);
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
    [self.backScrollView addSubview:easeView];
    [easeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(leftL.mas_right);
        make.top.equalTo(leftL.mas_top);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(BCWidth - 85);
    }];
    
    
//    点击打开优惠券
    
    [easeView addTapGestureWithBlock:^{
       
        
        BCCouponView *vv = [[BCCouponView alloc] initWithFrame:CGRectMake(0, BCHeight, BCWidth, BCHeight) andUserID:@""];
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
    
    NSArray *titleA = @[@"满3000减300",@"满2000减200"];
    for (int i = 0; i < 2 ; i++) {
        UIButton *activityBtn = [UIButton new];
        [activityBtn setTitleColor:COLOR(254, 36, 72) forState:UIControlStateNormal];
        [activityBtn setTitle:titleA[i] forState:UIControlStateNormal];
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
        
        
        BCGoodView *vv = [[BCGoodView alloc] initWithFrame:CGRectMake(0, BCHeight, BCWidth, BCHeight) andGoodID:@""];
        [self.view addSubview:vv];
        [UIView animateWithDuration:.25 animations:^{//评论页从底部显示动画
            
            vv.top = 0;
        }];
    }];
    
    
    UILabel *rightL = [[UILabel alloc] init];
    rightL.text = @"樱粉金 8G+128G 全网通";
    rightL.textColor = COLOR(103, 103, 103);
    rightL.font = Regular(13);
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
    
    
    //    点击打开分期
    
    [easeView2 addTapGestureWithBlock:^{
        
        
        BCDivideView *vv = [[BCDivideView alloc] initWithFrame:CGRectMake(0, BCHeight, BCWidth, BCHeight) andGoodID:@""];
        [self.view addSubview:vv];
        [UIView animateWithDuration:.25 animations:^{//评论页从底部显示动画
            
            vv.top = 0;
        }];
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
    
    UIImageView *rightImage2 = [[UIImageView alloc] init];
    rightImage2.image = BCImage(Back---Icon-);
    [easeView2 addSubview:rightImage2];
    [rightImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(rightImage.mas_left);
        make.centerY.equalTo(rightL1);
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
        make.top.mas_equalTo(self.backScrollView.height - 50 - BCNaviHeight);
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
    
    
}

#pragma mark 商品详情页
- (void)initSecondView {
    
    
    
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
        make.top.mas_equalTo(39);
        make.height.mas_equalTo(3);
        
    }];
}

#pragma mark 网络请求
- (void)getData {
    
    [KTooL HttpPostWithUrl:@"Goods/goodsinfo" parameters:@{@"goods_id":_goodID} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        if ([[responseObject objectNilForKey:@"status"]integerValue] == 1) {
            
            
        } else {
            
            VCToast(@"请求失败", 1);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        VCToast(error.description, 1);
    }];
    
}

#pragma mark 懒加载加载需要的视图
- (UIView *)headView {
    if (!_headView) {
        
        
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , BCWidth - 50, 40)];
      
        _headView.backgroundColor = ThemeColor;
        
        
        
        
        
        NSArray *titleArr1 = @[@"商品",@"详情"];
        for(int i = 0; i < titleArr1.count; i++) {
            UIButton *segmentButton1 = [[UIButton alloc] init];
            
            segmentButton1.titleLabel.font = Regular(17);
            [segmentButton1 setTitle:titleArr1[i] forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            [segmentButton1 setTitleColor:COLOR(252, 148, 37) forState:UIControlStateSelected];
            
            
            segmentButton1.tag = 200 + i;
            [segmentButton1 addTarget:self action:@selector(clickTopButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [_headView addSubview:segmentButton1];
            [segmentButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo( i*150 + 50);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(40);
            }];
            
            if (i == 0) {
                backImageView = [[UIImageView alloc] init];
                backImageView.backgroundColor = COLOR(252, 148, 37);
                [_headView addSubview:backImageView];
                [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.width.equalTo(segmentButton1);
                    make.top.mas_equalTo(39);
                    make.height.mas_equalTo(3);
                    
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
        _backScrollView.scrollEnabled = NO;
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

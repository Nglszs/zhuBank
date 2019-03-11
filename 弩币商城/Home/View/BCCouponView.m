//
//  BCCouponView.m
//  弩币商城
//
//  Created by Jack on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "BCCouponView.h"

@implementation BCCouponView
{
    NSString *goodID;
    NSDictionary *dataDic;
    
}
- (instancetype)initWithFrame:(CGRect)frame andUserID:(NSString *)ID {
    goodID = ID;
    return [self initWithFrame:frame];
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
          [self getData];
      
       
        
    }
    return self;
}

#pragma mark 网络请求
- (void)getData {
    
    [KTooL HttpPostWithUrl:@"goods/coupons_page" parameters:@{@"goods_id":goodID,@"goods_price":@"3480"} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        if (BCStatus) {
            
            dataDic = [responseObject objectNilForKey:@"data"];
            
            
            [self initView];
            
        } else {
            
            ViewToast(@"请求失败", 1);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        ViewToast(error.description, 1);
    }];
    
}
- (void)initView {
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [self addGestureRecognizer:panGes];
    
    
    
    //背景
    UIView *backView = [[UIView alloc]initWithFrame:BCBound];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self addSubview:backView];
    
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,  BCHeight - 440 , BCWidth, 440)];
    headView.backgroundColor = White;
    [self addSubview:headView];
    
    
    
    // 标题
   UILabel *countL = [[UILabel alloc] initWithFrame:headView.bounds];
    countL.textAlignment = NSTextAlignmentCenter;
    countL.font = Regular(16);
    countL.textColor = COLOR(51, 51, 51);
    countL.text = @"可用优惠券";
    [headView addSubview:countL];
    [countL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(BCWidth);
    }];
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    [arr addObjectsFromArray:[dataDic objectNilForKey:@"cash_coupons_info"]];
     [arr addObjectsFromArray:[dataDic objectNilForKey:@"transfer_coupons_info"]];
    
//    优惠券
    for (int i = 0; i < arr.count; i++) {
    
//        背景
        UIImageView *imageV = [[UIImageView alloc] init];
        [headView addSubview:imageV];
        
        
        NSDictionary *dic = [arr objectAtIndex:i];
        
        if ([[dic objectForKey:@"coupons_type"] isEqualToString:@"运费抵用券"]) {
            
            imageV.image = BCImage(可用优惠券运费bj);
            
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(LEFT_Margin);
                make.width.mas_equalTo(BCWidth - 30);
                make.height.mas_equalTo(70);
                make.top.equalTo(countL.mas_bottom).offset(10 + i * (80 + 15));
            }];
            
            
            
            UILabel *moneyL = [[UILabel alloc] init];
            moneyL.text = [NSString stringWithFormat:@"¥ %@",[dic objectForKey:@"money"]];
            moneyL.textColor = COLOR(171, 193, 65);
            moneyL.font = Regular(24);
            [imageV addSubview:moneyL];
            [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.top.mas_equalTo((LEFT_Margin));
                make.height.mas_equalTo(19);
            }];
            
            
            
            UILabel *moneyL1 = [[UILabel alloc] init];
            moneyL1.text = @"运费抵扣券";
            moneyL1.textColor = COLOR(171, 193, 65);
            moneyL1.font = Regular(13);
            [imageV addSubview:moneyL1];
            [moneyL1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(moneyL.mas_right).offset(20);
                make.bottom.equalTo(moneyL);
                make.height.mas_equalTo(13);
            }];
            
            UILabel *timeL = [[UILabel alloc] init];
            timeL.text = [NSString stringWithFormat:@"有效期 %@",[dic objectForKey:@"use_date"]];
            timeL.textColor = ACOLOR(171, 193, 65,.7);
            timeL.font = Regular(12);
            [imageV addSubview:timeL];
            [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(LEFT_Margin);
                make.bottom.mas_equalTo(-LEFT_Margin);
                make.height.mas_equalTo(12);
            }];
            
        } else {
            
            imageV.image = BCImage(可用优惠券商品bj);
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(LEFT_Margin);
                make.width.mas_equalTo(BCWidth - 30);
                make.height.mas_equalTo(80);
                make.top.equalTo(countL.mas_bottom).offset(10 + i * (80 + 15));
            }];
            
            
            
//            标题  价格等等
            UILabel *moneyL = [[UILabel alloc] init];
            moneyL.text = [NSString stringWithFormat:@"¥ %@",[dic objectForKey:@"money"]];
            moneyL.textColor = COLOR(254, 100, 38);
            moneyL.font = Regular(24);
            [imageV addSubview:moneyL];
            [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.top.mas_equalTo((LEFT_Margin));
                make.height.mas_equalTo(19);
            }];
            
            
            
            UILabel *moneyL1 = [[UILabel alloc] init];
            moneyL1.text = @"现金抵扣券";
            moneyL1.textColor = COLOR(254, 100, 38);
            moneyL1.font = Regular(13);
            [imageV addSubview:moneyL1];
            [moneyL1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(moneyL.mas_right).offset(20);
                make.bottom.equalTo(moneyL);
                make.height.mas_equalTo(13);
            }];
            
            
            UILabel *useL = [[UILabel alloc] init];
            useL.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"condition"]];;
            useL.textColor = ACOLOR(254, 100, 38,.7);
            useL.font = Regular(12);
            [imageV addSubview:useL];
            [useL mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(LEFT_Margin);
                make.top.equalTo(moneyL.mas_bottom).offset(5);
                make.height.mas_equalTo(12);
            }];
            
            
            
            UILabel *timeL = [[UILabel alloc] init];
          timeL.text = [NSString stringWithFormat:@"有效期 %@",[dic objectForKey:@"use_date"]];
          timeL.textColor = ACOLOR(254, 100, 38,.7);
          timeL.font = Regular(12);
            [imageV addSubview:timeL];
            [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(LEFT_Margin);
                make.top.equalTo(useL.mas_bottom).offset(5);
                make.height.mas_equalTo(12);
            }];
            
        }
    }
    
    
    
//    关闭按钮
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(16);
    [backBtn1 setTitle:@"关闭" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.backgroundColor = Red;
    [headView addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
    
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(BCWidth);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        [self removeCommentCuView];
    }];
    
}

//防止手势冲突
- (void)move:(UIPanGestureRecognizer *)sender {
    
    
    
    
}

- (void)removeCommentCuView {
    
    if (self) {
        
        
        [UIView animateWithDuration:.25 animations:^{
            self.top = BCHeight;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
        if (_backBlock) {
            _backBlock();
        }
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self removeCommentCuView];
}
@end

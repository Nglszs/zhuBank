//
//  BCUseCouPonView.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "BCUseCouPonView.h"

@implementation BCUseCouPonView
{
    NSInteger isUseMoney,goodNum;
    UIButton *selectedBtn;
    NSString *goodID,*item_ID;
    NSArray *dataArr;//优惠券数组
}

- (void)getData{
    
    [KTooL HttpPostWithUrl:@"Order/select_coupons" parameters:@{@"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID],@"coupons_type":@(isUseMoney),@"goods_id":goodID,@"item_id":item_ID,@"num":@(goodNum)} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        if (BCStatus) {
            dataArr = [[responseObject objectNilForKey:@"data"] objectNilForKey:@"coupons_info"];
            [self initView];
            
        } else {
            
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
}

- (instancetype)initWithFrame:(CGRect)frame andUserID:(NSString *)ID withMoney:(NSInteger)isMoney withItemID:(nonnull NSString *)itemID endNum:(NSInteger)num{
    isUseMoney = isMoney;
    goodID = ID;
    item_ID = itemID;
    goodNum = num;
    return [self initWithFrame:frame];
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self getData];
        
        
    }
    return self;
}
- (void)initView {
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [self addGestureRecognizer:panGes];
    
    
    
    //背景
    UIView *backView = [[UIView alloc]initWithFrame:BCBound];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self addSubview:backView];
    
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,  BCHeight - 440 - BCNaviHeight, BCWidth, 440)];
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
    
    
    if (dataArr.count <= 0) {
     UILabel *notDivi = [[UILabel alloc] init];
        notDivi.text = @"暂无可使用优惠券哦~";
        notDivi.textColor = COLOR(102, 102, 102);
        notDivi.font = [UIFont systemFontOfSize:17];
        notDivi.textAlignment = NSTextAlignmentCenter;
       
        [headView addSubview:notDivi];
        [notDivi mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(headView.mas_centerY);
            make.width.mas_equalTo(BCWidth);
            make.height.mas_equalTo(15);
        }];
        
       
    }
    
    
    //    优惠券
    for (int i = 0; i < dataArr.count; i++) {
          NSDictionary *dic = [dataArr objectAtIndex:i];
        //        背景
        UIImageView *imageV = [[UIImageView alloc] init];
        [headView addSubview:imageV];
        
        
        UIButton *backBtn= [[UIButton alloc] init];
        
        [backBtn setImage:BCImage(椭圆 2) forState:UIControlStateNormal];
         [backBtn setImage:BCImage(组 2-2) forState:UIControlStateSelected];
        [imageV addSubview:backBtn];
        
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(imageV);
            make.right.mas_equalTo(-28);
            make.height.mas_equalTo(24);
            make.width.mas_equalTo(24);
        }];
        
        [imageV addTapGestureWithBlock:^{
           
            backBtn.selected = !backBtn.selected;
            
            if (backBtn!= selectedBtn) {
                
                selectedBtn.selected = NO;
                backBtn.selected = YES;
                selectedBtn = backBtn;
                
            }else{
                
                selectedBtn.selected = YES;
            }
            
//            选择的优惠券
            if (self.backBlock) {
             
                NSString *ID = [dic objectForKey:@"id"];
                NSString *money  = [dic objectForKey:@"money"];
                self.backBlock(@{@"id":ID,@"money":money});
            }
            
            [self removeCommentCuView];
            
        }];
        
        if (isUseMoney == 0) {//如果是现金券
            
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
            useL.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"condition"]];
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
            
//
//
            
        } else {
            
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
        
//        if (_backBlock) {
//            _backBlock();
//        }
    }
    
}



@end

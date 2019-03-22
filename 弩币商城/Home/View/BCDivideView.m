//
//  BCDivideView.m
//  弩币商城
//
//  Created by Jack on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "BCDivideView.h"

@implementation BCDivideView
{
     UIView *divideV;//分期界面
    UILabel *notDivi;//不分期
     UIButton *selectedBtn,*diviBtn,*diviNumBtn;  //按钮单选逻辑
    NSDictionary *dataDic;
    NSString *goodID;
    NSString *stages,*numMonth;
    UILabel *leftL1;
    NSString *price;
}
- (instancetype)initWithFrame:(CGRect)frame andGoodID:(nonnull NSString *)ID withPrice:(nonnull NSString *)pirce{
    price = pirce;
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
    
    [KTooL HttpPostWithUrl:@"goods/stage_select" parameters:@{@"goods_id":goodID} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
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
    countL.text = @"选择分期和月供计算";
    [headView addSubview:countL];
    [countL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(BCWidth);
    }];
    
    
    
//     选择是否分期
    UILabel *leftL = [[UILabel alloc] init];
    leftL.textColor = TITLE_COLOR;
    leftL.font = Regular(15);
    leftL.text = @"选择是否分期";
    [headView addSubview:leftL];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(32);
        make.height.mas_equalTo(15);
        make.top.equalTo(countL.mas_bottom).offset(10);
    }];
    
    
    
    //退出按钮
    UIButton *exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
    exitButton.frame=CGRectMake(BCWidth - 37, 14, 22, 22);
    [headView addSubview:exitButton];
    [exitButton addTarget:self action:@selector(removeCommentCuView) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *titleA = @[@"不分期",@"分期"];
    for (int i = 0; i < 2 ; i++) {
        UIButton *activityBtn = [UIButton new];
        [activityBtn setTitleColor:COLOR(102, 102, 102) forState:UIControlStateNormal];
        [activityBtn setTitleColor:White forState:UIControlStateSelected];
        [activityBtn setBackgroundColor:White forState:UIControlStateNormal];
        [activityBtn setBackgroundColor:COLOR(254, 0, 0) forState:UIControlStateSelected];
        [activityBtn setTitle:titleA[i] forState:UIControlStateNormal];
        [activityBtn.titleLabel setFont:Regular(12)];
        activityBtn.layer.borderWidth = 1;
        activityBtn.layer.borderColor = COLOR(170, 170, 170).CGColor;
        activityBtn.tag = 100 + i;
        activityBtn.layer.cornerRadius = 4;
        activityBtn.clipsToBounds = YES;
        [headView addSubview:activityBtn];
        
        [activityBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftL);
            make.left.equalTo(leftL.mas_right).offset(i * (50 + 28) + 20);
            
            make.size.mas_equalTo(CGSizeMake(50, 23));
        }];
        
        if (i == 1) {
            activityBtn.selected = YES;
            selectedBtn = activityBtn;
        }
        
    }
//    不分期
    notDivi = [[UILabel alloc] init];
    notDivi.text = @"您选择的是不分期请直接点击下一步哦~";
    notDivi.textColor = COLOR(102, 102, 102);
    notDivi.font = [UIFont systemFontOfSize:17];
    notDivi.textAlignment = NSTextAlignmentCenter;
    notDivi.hidden = YES;
    [headView addSubview:notDivi];
    [notDivi mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(headView.mas_centerY);
        make.width.mas_equalTo(BCWidth);
        make.height.mas_equalTo(15);
    }];
    
//    如果点击了分期界面
    divideV = [[UIView alloc] init];
  
    [headView addSubview:divideV];
    [divideV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(BCWidth);
        make.top.equalTo(leftL.mas_bottom).offset(20);
        make.bottom.mas_equalTo(-50);
        
    }];
    
    leftL1 = [[UILabel alloc] init];
    leftL1.textColor = TITLE_COLOR;
    leftL1.font = Regular(11);
    leftL1.text = @"￥266.75*36期";
    [divideV addSubview:leftL1];
    
    [leftL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(R(155));
        make.height.mas_equalTo(12);
        
      
    }];

    
    
    UILabel *leftL2 = [[UILabel alloc] init];
    leftL2.textColor = TITLE_COLOR;
    leftL2.font = Regular(15);
    leftL2.text = @"首付";
    [divideV addSubview:leftL2];
    [leftL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(32);
        make.height.mas_equalTo(15);
        make.top.equalTo(leftL1.mas_bottom).offset(18);
    }];
    
  

    NSArray *titleArr = [[dataDic objectForKey:@"list"] objectForKey:@"first_pay"];
    
    for (int i = 0; i < titleArr.count ; i++) {
        UIButton *activityBtn = [UIButton new];
        [activityBtn setTitleColor:COLOR(102, 102, 102) forState:UIControlStateNormal];
        [activityBtn setTitleColor:White forState:UIControlStateSelected];
        [activityBtn setBackgroundColor:White forState:UIControlStateNormal];
        [activityBtn setBackgroundColor:COLOR(254, 0, 0) forState:UIControlStateSelected];
        [activityBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [activityBtn.titleLabel setFont:Regular(12)];
        activityBtn.layer.borderWidth = 1;
        activityBtn.layer.borderColor = COLOR(170, 170, 170).CGColor;
        activityBtn.tag = 200 + i;
        activityBtn.layer.cornerRadius = 4;
        activityBtn.clipsToBounds = YES;
        [divideV addSubview:activityBtn];
        
        [activityBtn addTarget:self action:@selector(clickDivi:) forControlEvents:UIControlEventTouchUpInside];
        
        [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(i%4 * (50 + (BCWidth - 200 - 64)/3) + 32);
            make.top.equalTo(leftL2.mas_bottom).offset(20 + 35 * (i/4));
            make.size.mas_equalTo(CGSizeMake(50, 23));
        }];
        
        if (i == 0) {
            activityBtn.selected = YES;
            diviBtn = activityBtn;
        }
        
    }
    
    
//    分期数
    UILabel *leftL3 = [[UILabel alloc] init];
    leftL3.textColor = TITLE_COLOR;
    leftL3.font = Regular(15);
    leftL3.text = @"分期数";
    [divideV addSubview:leftL3];
    [leftL3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(32);
        make.height.mas_equalTo(15);
        make.top.equalTo(leftL2.mas_bottom).offset(100);
    }];
    
    
    NSArray *titleArr1 = [[dataDic objectForKey:@"list"] objectForKey:@"period_num"];
    
    for (int i = 0; i < titleArr1.count ; i++) {
        UIButton *activityBtn = [UIButton new];
        [activityBtn setTitleColor:COLOR(102, 102, 102) forState:UIControlStateNormal];
        [activityBtn setTitleColor:White forState:UIControlStateSelected];
        [activityBtn setBackgroundColor:White forState:UIControlStateNormal];
        [activityBtn setBackgroundColor:COLOR(254, 0, 0) forState:UIControlStateSelected];
        [activityBtn setTitle:titleArr1[i] forState:UIControlStateNormal];
        [activityBtn.titleLabel setFont:Regular(12)];
        activityBtn.layer.borderWidth = 1;
        activityBtn.layer.borderColor = COLOR(170, 170, 170).CGColor;
        activityBtn.tag = 300 + i;
        activityBtn.layer.cornerRadius = 4;
        activityBtn.clipsToBounds = YES;
        [divideV addSubview:activityBtn];
        
        [activityBtn addTarget:self action:@selector(clickDiviNum:) forControlEvents:UIControlEventTouchUpInside];
        
        [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(i%4 * (50 + (BCWidth - 200 - 64)/3) + 32);
            make.top.equalTo(leftL3.mas_bottom).offset(20 + 35 * (i/4));
            make.size.mas_equalTo(CGSizeMake(50, 23));
        }];
        
        if (i == titleArr1.count - 1) {
            activityBtn.selected = YES;
            diviNumBtn = activityBtn;
            [activityBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    
    
    
    //    关闭按钮
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(16);
    [backBtn1 setTitle:@"下一步" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.backgroundColor = Red;
    [headView addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(BCWidth);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        if (self.backBlock && selectedBtn.tag == 101) {//当选择分期的时候才会返回
            NSDictionary *dic = @{@"fenqi":leftL1.text,@"lixi":@[diviBtn.currentTitle,diviNumBtn.currentTitle]};
            self.backBlock(dic);
        }
        [self removeCommentCuView];
    }];
    
}


#pragma mark 点击是否分期
- (void)buttonClick:(UIButton *)button {
    
    
    if (button!= selectedBtn) {
        
        selectedBtn.selected = NO;
        button.selected = YES;
        selectedBtn = button;
        
    }else{
        
        selectedBtn.selected = YES;
    }
    
    
    if (button.tag == 100) {
        
        divideV.hidden = YES;
        notDivi.hidden = NO;
    } else {
        notDivi.hidden = YES;
        divideV.hidden = NO;
    }
}

#pragma mark 点击分期比例
- (void)clickDivi:(UIButton*)button {
    
    if (button!= diviBtn) {
        
       diviBtn.selected = NO;
        button.selected = YES;
        diviBtn = button;
        
    }else{
        
        diviBtn.selected = YES;
    }
    
    NSLog(@"==%@",diviBtn.currentTitle);
      [self getDiviData];
}

- (void)clickDiviNum:(UIButton *)button{
    
    if (button!= diviNumBtn) {
        
        diviNumBtn.selected = NO;
        button.selected = YES;
        diviNumBtn = button;
        
    }else{
        
        diviNumBtn.selected = YES;
    }
    
    NSLog(@"==%@",diviNumBtn.currentTitle);
    [self getDiviData];
}

#pragma mark 刷新分期利息
- (void)getDiviData {
    
    NSLog(@"==%@]]]%@",diviBtn.currentTitle,diviNumBtn.currentTitle);
  
    NSString *divi = @"0";
    if ([diviBtn.currentTitle isEqualToString:@"零首付"]) {
        divi = @"0";
    } else {
        
        NSString *newStr = [diviBtn.currentTitle substringToIndex:1];
        divi = [NSString stringWithFormat:@"%.1f",[newStr floatValue]/10];
    }
    
    [KTooL HttpPostWithUrl:@"goods/stage_select" parameters:@{@"goods_id":goodID,@"period":diviNumBtn.currentTitle,@"shou_pay":divi,@"q_fenqi":@"1",@"goods_price":price,@"goods_num":@"1"} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        if (BCStatus) {
          
            NSDictionary *dic = [[responseObject objectNilForKey:@"data"] objectNilForKey:@"fenqi_info"];
              leftL1.text = [NSString stringWithFormat:@"￥%.2f*%@期",[[dic objectNilForKey:@"per_money"]floatValue],[dic objectNilForKey:@"period"]];
            
        } else {
            
            ViewToast(@"请求失败", 1);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        ViewToast(error.description, 1);
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
        
        
    }
    
}


@end

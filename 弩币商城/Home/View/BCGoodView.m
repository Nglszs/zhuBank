//
//  BCGoodView.m
//  弩币商城
//
//  Created by Jack on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "BCGoodView.h"

@implementation BCGoodView

{
    UIView *divideV;//分期界面
    UIButton *selectedBtn,*diviBtn,*diviNumBtn;  //按钮单选逻辑
    NSDictionary *dataDic;
    NSString *goodID;
    NSInteger shopNumber;//选择商品数量
     CGFloat max_Value;//商品最大值
    NSDictionary *paramS;//请求参数
    UIImageView *leftI;
    UILabel *moneyL;
    UILabel *moneyL1;//分期
    UILabel *countL;
    NSMutableArray *titleArr;//颜色
    NSMutableArray *titleA;//内存
    NSString *item_ID;//传给提交订单
    NSInteger buy_num,color_tag,size_tag;
}
- (instancetype)initWithFrame:(CGRect)frame andGoodID:(nonnull NSString *)ID withPara:(nonnull NSDictionary *)params buyNum:(NSInteger)num color:(NSInteger)colorTag size:(NSInteger)sizeTag{
    paramS = params;
    buy_num = num;
    color_tag = colorTag;
    size_tag = sizeTag;
    item_ID = @"";
    goodID = ID;
    return [self initWithFrame:frame];
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        max_Value = 99;
       
        [self getData];
        
    }
    return self;
}

#pragma mark 网络请求
- (void)getData {
    
    [KTooL HttpPostWithUrl:@"goods/spec_page" parameters:@{@"goods_id":goodID} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
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
- (CGFloat)widthOfString:(NSString *)string{
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 23)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
    
   
}

- (void)initView {
    

    
    
    //背景
    UIView *backView = [[UIView alloc]initWithFrame:BCBound];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self addSubview:backView];
    
    
    UIScrollView *headView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  BCHeight - 440 , BCWidth, 440)];
    headView.backgroundColor = White;
    
    [self addSubview:headView];
    
    
    
    //退出按钮
    UIButton *exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
    exitButton.frame=CGRectMake(BCWidth - 37, 14, 22, 22);
    [headView addSubview:exitButton];
    [exitButton addtargetBlock:^(UIButton *button) {
        
        if (self.backBlock ) {
            
            
            self.backBlock(@{@"cancel":@"1"});
        }
        [self removeFromSuperview];
    }];
    
    
    NSDictionary *newDic = [dataDic objectNilForKey:@"goods_info"];
    
    NSDictionary *newDic1 = [dataDic objectNilForKey:@"fenqi_info"];
    
     max_Value = [[newDic objectNilForKey:@"store_count"] floatValue];
    leftI = [[UIImageView alloc] init];
    leftI.backgroundColor = ImageColor;
     [leftI sd_setImageWithURL:[NSURL URLWithString:[newDic objectNilForKey:@"original_img"]]];
    [headView addSubview:leftI];
    [leftI mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(LEFT_Margin);
        make.width.height.mas_equalTo(60);
        
    }];
    
    
    
//     价格等等
    moneyL = [[UILabel alloc] init];
    moneyL.text =  [NSString stringWithFormat:@"¥ %ld",[[newDic objectNilForKey:@"goods_price"] integerValue]];
    
    moneyL.textColor = COLOR(254, 0, 0);
    moneyL.font = Regular(17);
    [headView addSubview:moneyL];
    [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(leftI.mas_right).offset(20);
        make.top.mas_equalTo(36);
        make.height.mas_equalTo(13);
    }];
    
    
    NSString *fenqi = [NSString stringWithFormat:@"分期 ¥%.2f*%@期",[[newDic1 objectNilForKey:@"per_money"] floatValue],[newDic1 objectNilForKey:@"periods"]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:fenqi];
    NSDictionary * firstAttributes = @{NSForegroundColorAttributeName:COLOR(102, 102, 102)};
    
    NSString *stt = [NSString stringWithFormat:@"%.2f",[[newDic1 objectNilForKey:@"per_money"] floatValue]];
    
    [str setAttributes:firstAttributes range:NSMakeRange(stt.length + 4,fenqi.length - stt.length - 4)];
    
   moneyL1  = [[UILabel alloc] init];
   
    moneyL1.textColor = COLOR(254, 0, 0);
    moneyL1.font = Regular(13);
     moneyL1.attributedText = str;

    
   

    [headView addSubview:moneyL1];
    [moneyL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(moneyL.mas_left);
        make.top.equalTo(moneyL.mas_bottom).offset(12);
        make.height.mas_equalTo(12);
    }];
   
    if ([[paramS objectForKey:@"q_fenqi"] integerValue] != 1) {//不是分期就隐藏
        moneyL1.hidden = YES;
    }
    

    
//    // 标题
    countL = [[UILabel alloc] initWithFrame:headView.bounds];
    countL.textAlignment = NSTextAlignmentRight;
    countL.font = Regular(11);
    countL.textColor = COLOR(102, 102, 102);
    countL.text = [NSString stringWithFormat:@"剩余库存：%@",[newDic objectNilForKey:@"store_count"] ];
  
    [headView addSubview:countL];
    [countL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(BCWidth - 70 - 43);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(70); make.top.equalTo(moneyL.mas_bottom).offset(12);
       
    }];
    
    
//    数量
    
        UILabel *leftL = [[UILabel alloc] init];
        leftL.textColor = TITLE_COLOR;
        leftL.font = Regular(13);
        leftL.text = @"数量";
        [headView addSubview:leftL];
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.left.mas_equalTo(LEFT_Margin);
            make.height.mas_equalTo(15);
            make.top.equalTo(leftI.mas_bottom).offset(25);
        }];
    
    
    _countTextField = [[UITextField alloc] init];
    shopNumber = buy_num?buy_num:1;
    _countTextField.keyboardType = UIKeyboardTypeNumberPad;
    _countTextField.delegate = self;
    _countTextField.textColor = COLOR(102, 102, 102);
    _countTextField.text = [NSString stringWithFormat:@"%ld",shopNumber];
    _countTextField.textAlignment = NSTextAlignmentCenter;
    _countTextField.layer.borderWidth = 1;
   _countTextField.layer.borderColor = COLOR(153, 153, 153).CGColor;
    _countTextField.font = Regular(18);
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 30);
    leftBtn.tag = 50;
    [leftBtn setImage:BCImage(-) forState:UIControlStateNormal];
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.borderColor = COLOR(153, 153, 153).CGColor;
    _countTextField.leftView = leftBtn;
    _countTextField.leftViewMode = UITextFieldViewModeAlways;
    [leftBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn setImage:BCImage(+) forState:UIControlStateNormal];
    rightBtn.tag = 100;
    rightBtn.layer.borderWidth = 1;
   rightBtn.layer.borderColor = COLOR(153, 153, 153).CGColor;
    _countTextField.rightView = rightBtn;
    [rightBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _countTextField.rightViewMode = UITextFieldViewModeAlways;
    
    [headView addSubview:_countTextField];
    [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.equalTo(leftL.mas_bottom).offset(6);
        make.left.mas_equalTo(LEFT_Margin);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
        
    }];
    
    
  
    


    
    titleArr = [NSMutableArray arrayWithCapacity:1];//颜色
    
    titleA = [NSMutableArray arrayWithCapacity:1];//内存

    NSArray *sepDic = [dataDic objectNilForKey:@"spec_info"];
    for (NSDictionary *dic in sepDic) {
        if ([[dic objectNilForKey:@"name"] isEqualToString:@"颜色"]) {
            [titleArr addObjectsFromArray:[dic objectNilForKey:@"spec_detail"]];
        }

        if ([[dic objectNilForKey:@"name"]isEqualToString:@"版本"]) {

             [titleA addObjectsFromArray:[dic objectNilForKey:@"spec_detail"]];
        }

    }
    
   
    //      颜色
    
   
    
    UILabel *leftL2 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_Margin, 165, 30, 13)];
    leftL2.textColor = TITLE_COLOR;
    leftL2.font = Regular(13);
    leftL2.text = @"颜色";
    [headView addSubview:leftL2];
    if (titleArr.count <= 0) {//如果没有颜色
        leftL2.height = 0;
    }
    
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = leftL2.bottom + 15;//用来控制button距离父视图的高
   
    for (int i = 0; i < titleArr.count ; i++) {
        NSDictionary *colorDic = titleArr[i];
         CGFloat tmpW = [self widthOfString:[colorDic objectForKey:@"item"]];
        UIButton *activityBtn = [UIButton new];
        [activityBtn setTitleColor:COLOR(102, 102, 102) forState:UIControlStateNormal];
        [activityBtn setTitleColor:White forState:UIControlStateSelected];
        [activityBtn setBackgroundColor:White forState:UIControlStateNormal];
        [activityBtn setBackgroundColor:COLOR(254, 0, 0) forState:UIControlStateSelected];
        [activityBtn setTitle:[colorDic objectNilForKey:@"item"] forState:UIControlStateNormal];
        [activityBtn.titleLabel setFont:Regular(12)];
        activityBtn.layer.borderWidth = 1;
        activityBtn.layer.borderColor = COLOR(170, 170, 170).CGColor;
        activityBtn.tag = 200 + i;
        activityBtn.layer.cornerRadius = 4;
        activityBtn.clipsToBounds = YES;
        [headView addSubview:activityBtn];
        
        [activityBtn addTarget:self action:@selector(clickDivi:) forControlEvents:UIControlEventTouchUpInside];
     
        activityBtn.frame = CGRectMake(LEFT_Margin + w, h, tmpW + 30 , 23);
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(LEFT_Margin + w + tmpW + 30 > BCWidth){
            w = 0; //换行时将w置为0
            h = h + activityBtn.frame.size.height + LEFT_Margin;//距离父视图也变化
            activityBtn.frame = CGRectMake(LEFT_Margin + w, h, tmpW + 30, 23);//重设button的frame
        }
        w = activityBtn.frame.size.width + activityBtn.frame.origin.x;
       
        if (color_tag ) {
            if (i == color_tag) {
                activityBtn.selected = YES;
                diviBtn = activityBtn;
                if (titleA.count <= 0) {
                    [activityBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
                }
            }
           
        } else {
            
            if(i == 0) {
            activityBtn.selected = YES;
            diviBtn = activityBtn;
            if (titleA.count <= 0) {
                [activityBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            
        }
        }
    }

    
   
    
    

  

    if (titleArr.count > 0) {//如果有颜色的话
        
        //    版本
        UILabel *leftL3 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_Margin, h + 45, 30, 13)];
        leftL3.textColor = TITLE_COLOR;
        leftL3.font = Regular(13);
        leftL3.text = @"版本";
        [headView addSubview:leftL3];
        
        NSArray *titleArr1 = @[@"公开版"];
        
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
            [headView addSubview:activityBtn];
            activityBtn.frame = CGRectMake(LEFT_Margin, leftL3.bottom + 15, 50, 23);
            [activityBtn addTarget:self action:@selector(clickDiviNum:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if (i == 0) {
                activityBtn.selected = YES;
                diviNumBtn = activityBtn;
            }
            
        }
        
        h += 110;
    }
    

//         内存
        UILabel *leftL4 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_Margin, h , 30, 13)];
        leftL4.textColor = TITLE_COLOR;
        leftL4.font = Regular(13);
        leftL4.text = @"内存";
        [headView addSubview:leftL4];
    if (titleA.count <= 0) {//如果内存没有的话
        
        leftL4.height = 0;
    }
    
    
    
    CGFloat w1 = 0;
    h +=25;
    for (int i = 0; i < titleA.count ; i++) {
        
                       NSDictionary *sizeDic = titleA[i];
         CGFloat tmpW = [self widthOfString:[sizeDic objectForKey:@"item"]];
                    UIButton *activityBtn = [UIButton new];
                    [activityBtn setTitleColor:COLOR(102, 102, 102) forState:UIControlStateNormal];
                    [activityBtn setTitleColor:White forState:UIControlStateSelected];
                    [activityBtn setBackgroundColor:White forState:UIControlStateNormal];
                    [activityBtn setBackgroundColor:COLOR(254, 0, 0) forState:UIControlStateSelected];
                    [activityBtn setTitle:[sizeDic objectNilForKey:@"item"] forState:UIControlStateNormal];
                    [activityBtn.titleLabel setFont:Regular(12)];
                    activityBtn.layer.borderWidth = 1;
                    activityBtn.layer.borderColor = COLOR(170, 170, 170).CGColor;
                    activityBtn.tag = 100 + i;
                    activityBtn.layer.cornerRadius = 4;
                    activityBtn.clipsToBounds = YES;
                    [headView addSubview:activityBtn];
                    [activityBtn.titleLabel adjustsFontSizeToFitWidth];
                    [activityBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        activityBtn.frame = CGRectMake(LEFT_Margin + w1, h , tmpW + 30 , 23);
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(LEFT_Margin + w1 + tmpW + 30 > BCWidth){
            w1 = 0; //换行时将w置为0
            h = h + activityBtn.frame.size.height + LEFT_Margin;//距离父视图也变化
            activityBtn.frame = CGRectMake(LEFT_Margin + w1, h, tmpW + 30, 23);//重设button的frame
        }
        w1 = activityBtn.frame.size.width + activityBtn.frame.origin.x;
        
        if (size_tag ) {
            
            if (i == size_tag) {
                activityBtn.selected = YES;
                selectedBtn = activityBtn;
                [activityBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
           
        }else{
            
            if (i == 0) {
        
                        activityBtn.selected = YES;
                        selectedBtn = activityBtn;
                        [activityBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
                    }
        
                }
    }
    if (h < headView.height) {
        h = headView.height + 45;
    } else {
        
        h += 30;
    }

     headView.contentSize = CGSizeMake(BCWidth,  h );
//
    //    关闭按钮
    UIButton *backBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, BCHeight - 50, BCWidth, 50)];
    backBtn1.titleLabel.font = Regular(16);
    [backBtn1 setTitle:@"确定" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.backgroundColor = Red;
    [self addSubview:backBtn1];
   
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
        if ([countL.text isEqualToString:@"剩余库存：0"]) {
            
            ViewToast(@"当前库存为0，不能下单", 1);
            return ;
        }
        if (self.backBlock ) {

           
            self.backBlock(@{@"arr":@[_countTextField.text,item_ID],@"size":[NSString stringWithFormat:@"%@ %@",diviBtn.currentTitle,selectedBtn.currentTitle],@"history":@[@(shopNumber),@(diviBtn.tag - 200),@(selectedBtn.tag - 100)]});
        }

        [self removeCommentCuView];
    }];

}



#pragma mark 点击选择颜色
- (void)clickDivi:(UIButton*)button {
    
    if (button!= diviBtn) {
        
        diviBtn.selected = NO;
        button.selected = YES;
        diviBtn = button;
        
    }else{
        
        diviBtn.selected = YES;
    }
     [self getDiviData];
}

#pragma mark 选择版本
- (void)clickDiviNum:(UIButton *)button{
    
    if (button!= diviNumBtn) {
        
        diviNumBtn.selected = NO;
        button.selected = YES;
        diviNumBtn = button;
        
    }else{
        
        diviNumBtn.selected = YES;
    }
     [self getDiviData];
}

#pragma mark 选择内存
- (void)buttonClick:(UIButton *)button{
    
    if (button!= selectedBtn) {
        
        selectedBtn.selected = NO;
        button.selected = YES;
        selectedBtn = button;
        
    }else{
        
        selectedBtn.selected = YES;
    }
     [self getDiviData];
}

#pragma mark 刷新商品利息
- (void)getDiviData {
    
    
    NSString *colorID = @"";
    if (titleArr.count > 0) {
      colorID = [[titleArr objectAtIndex:diviBtn.tag - 200] objectForKey:@"id"];
    }
   
    
    NSString *sizeID = @"";
    if (titleA.count > 0) {
         sizeID = [[titleA objectAtIndex:selectedBtn.tag - 100] objectForKey:@"id"];
    }
  
    
    NSString *itemID = [[dataDic objectForKey:@"goods_info"] objectForKey:@"item_id"];
    
    [KTooL HttpPostWithUrl:@"goods/spec_page" parameters:@{@"goods_id":goodID,@"goods_num":_countTextField.text,@"spec_keys":[NSString stringWithFormat:@"%@_%@",colorID,sizeID],@"item_id":itemID,@"shou_pay":[paramS objectForKey:@"shou_pay"],@"q_fenqi":[paramS objectForKey:@"q_fenqi"],@"period":[paramS objectForKey:@"period"]} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        if (BCStatus) {
            
            NSDictionary *dic = [responseObject objectNilForKey:@"data"];
            NSDictionary *newDic = [dic objectNilForKey:@"goods_info"];
           
            item_ID = [newDic objectNilForKey:@"item_id"];
            NSDictionary *newDic1 = [dic objectNilForKey:@"fenqi_info"];
            
           
                countL.text = [NSString stringWithFormat:@"剩余库存：%@",[newDic objectNilForKey:@"store_count"]];
             max_Value = [[newDic objectNilForKey:@"store_count"] floatValue];
            
             moneyL.text =  [NSString stringWithFormat:@"¥ %ld",[[newDic objectNilForKey:@"goods_price"] integerValue]];
            
            
            NSString *fenqi = [NSString stringWithFormat:@"分期 ¥%.2f*%@期",[[newDic1 objectNilForKey:@"per_money"] floatValue],[newDic1 objectNilForKey:@"periods"]];
            
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:fenqi];
            NSDictionary * firstAttributes = @{NSForegroundColorAttributeName:COLOR(102, 102, 102)};
            
            NSString *stt = [NSString stringWithFormat:@"%.2f",[[newDic1 objectNilForKey:@"per_money"] floatValue]];
            
            [str setAttributes:firstAttributes range:NSMakeRange(stt.length + 4,fenqi.length - stt.length - 4)];
            
            moneyL1.attributedText = str;
            
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


#pragma mark textfield 代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (string.length <= 0) {
        return YES;
    }
    
    //禁止输入空格
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    
    if (![string isEqualToString:tem]) {
        return NO;
    }
    
    
    if ([string length] > 0)
    {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if([textField.text length] == 0)
        {
            if (single == '0'){//首字母不能为0
                
                
                return NO;
            }
        }
    }
    
    //  只能输入数字
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
     return  [string isEqualToString:filtered];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [self checkTextFieldNumberWithUpdate];
//    if (self.returnData) {
//        self.returnData([_countTextField.text floatValue]);
//    }
}
/// 检查TextField中数字的合法性,并修正
- (void)checkTextFieldNumberWithUpdate
{
    NSString *minValueString = nil;
    NSString *max_ValueString = nil;
    
    max_Value = MAX(max_Value, 1);
    minValueString = [NSString stringWithFormat:@"%.f",1.0];
    max_ValueString = [NSString stringWithFormat:@"%.f",max_Value];
    
    NSLog(@"]]]%f",[_countTextField.text floatValue]);
    if ( [_countTextField.text floatValue] < 0.00) {
        
        
        _countTextField.text = minValueString;
        
    }
    
    if (_countTextField.text.length == 0) {
        
        _countTextField.text = minValueString;
    }
    
    [_countTextField.text floatValue] > max_Value ? _countTextField.text = max_ValueString : nil;
    
    
}
#pragma mark 减少或者增加数量
- (void)clickButton:(UIButton *)btn {
    
    
    
    [self checkTextFieldNumberWithUpdate];
    
    CGFloat number = [_countTextField.text floatValue];
    
    if (btn.tag == 50) {//减
        
        shopNumber = MAX(1, --number);
        _countTextField.text = [NSString stringWithFormat:@"%ld",shopNumber];
        
    } else {//加
        
        shopNumber = MIN(max_Value, ++number);
        _countTextField.text = [NSString stringWithFormat:@"%ld", shopNumber];
        
    }
    if (shopNumber >= max_Value) {
        
        ViewToast(@"已超出商品最大值", 1);
        return;
    }
    
    [self getDiviData];
//    if (self.returnData) {
//        self.returnData(_shopNumber);
//    }
    
}
@end

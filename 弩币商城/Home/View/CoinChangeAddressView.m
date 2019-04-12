//
//  CoinChangeAddressView.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinChangeAddressView.h"
#import "BRAddressPickerView.h"
@interface CoinChangeAddressView()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField * NameTF;
@property (nonatomic,strong)UITextField * PhoneNumberTF;
@property (nonatomic,strong)UITextField * CityTF;
@property (nonatomic,strong)UITextField * AddressTF;
@property (nonatomic,strong)NSMutableArray * CityArray;
@property (nonatomic,copy)NSString * province;
@property (nonatomic,copy)NSString * city;
@property (nonatomic,copy)NSString * district;
@end
@implementation CoinChangeAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self request];
    }
    return self;
}
- (void)initView{
    self.CityArray = [NSMutableArray array];
    self.NameTF = [UITextField new];
    self.PhoneNumberTF = [UITextField new];
    self.CityTF = [UITextField new];
    self.AddressTF = [UITextField new];
    self.PhoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    [self SetTextFiled:self.NameTF leftString:@"收货人：" topSpace:(45 * 1) placeholder:nil];
    
    self.NameTF.delegate = self;
    [self SetTextFiled:self.PhoneNumberTF leftString:@"手机号码：" topSpace:(45 * 2) placeholder:nil];
    
    self.PhoneNumberTF.delegate = self;
    [self SetTextFiled:self.CityTF leftString:@"所在地区：" topSpace:(45 * 3) placeholder:nil];
    
    
    [self SetTextFiled:self.AddressTF leftString:@"详细地址：" topSpace:(45 * 4) placeholder:nil];
    [self.NameTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.PhoneNumberTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];

    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = COLOR(181, 181, 181);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(0.5);
    }];
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton * affirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.affirmButton = affirmButton;
    [affirmButton setBackgroundColor:COLOR(255, 0, 0) forState:(UIControlStateNormal)];
    [self addSubview:affirmButton];
    [affirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
    affirmButton.titleLabel.font = Regular(17);
    [affirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    affirmButton.adjustsImageWhenHighlighted = NO;
    
}

-(void)changedTextField:(UITextField *)textField
{
    int i = 0;
    if (textField == self.NameTF) {
        i = 1000000;
    }
    if (textField == self.PhoneNumberTF) {
        i = 11;
    }
    if (textField.text.length > i) {
        textField.text = [textField.text substringToIndex:i];
    }
}

- (void)SetTextFiled:(UITextField *)textField leftString:(NSString *)leftString topSpace:(CGFloat)topSpace placeholder:(NSString *)placeholder{
    UIView * view = [UIView new];

    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(45);
        make.top.equalTo(self).offset((topSpace - 45));
    }];
    
    UILabel * label = [[UILabel alloc] init];
    label.text = leftString;
    
    label.textColor = COLOR(51, 51, 51);
    label.font = Regular(13);
    [view addSubview:label];
    CGFloat width = [self calculateRowWidth:leftString];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(view);
        make.width.mas_equalTo(width);
    }];
   
    textField.font = Regular(13);
    [view addSubview:textField];
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    textField.textColor = COLOR(51, 51, 51);
    CGFloat hh = 0;
    if (textField == self.CityTF) {
        hh = -40;
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"查看更多"];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-26);
            make.centerY.equalTo(view);
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(20);
        }];
    }
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(5);
        make.centerY.equalTo(label);
        make.right.equalTo(view).offset(hh);
    }];
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR(181, 181, 181);
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(view);
        make.height.mas_equalTo(0.5);
    }];
    textField.delegate = self;
    
    
}

- (CGFloat)calculateRowWidth:(NSString *)string {
     NSDictionary *dic = @{NSFontAttributeName: Regular(13)};
     CGRect rect = [string boundingRectWithSize:CGSizeMake(0, MAXFLOAT)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading attributes:dic context:nil];
      return rect.size.width;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.CityTF) {
        [self endEditing:YES];
        [BRAddressPickerView showAddressPickerWithShowType:(BRAddressPickerModeArea) dataSource:self.CityArray defaultSelected:nil isAutoSelect:nil themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
            
            self.CityTF.text = [NSString stringWithFormat:@"%@ %@ %@",province.name,city.name,area.name];
            self.province = province.code;
            self.city = city.code;
            self.district = area.code;
        } cancelBlock:^{
            
        }];
        
        return NO;
    }
    return YES;
}


- (void)request{
    [KTooL HttpPostWithUrl:@"Order/all_region" parameters:nil loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[CoinAddressCityModel class] json:responseObject[@"data"]];
            for (int i = 0 ; i < self.dataArray.count; i++) {
                CoinAddressCityModel * model = self.dataArray[i];
                // 赋值给省
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                dict[@"code"] = model.idStr;
                dict[@"name"] = model.name;
                [self.CityArray addObject:dict];
                
                // 赋值给市
                NSMutableArray * array2 = [NSMutableArray array];
                for (CoinAddressCityChildModel * model2 in model.child_info) {
                    NSMutableDictionary * dict2 = [NSMutableDictionary dictionary];
                    dict2[@"name"] = model2.name;
                    dict2[@"code"] = model2.idStr;
                    [array2 addObject:dict2];
                    
                    NSMutableArray * array3 = [NSMutableArray array];
                    // 赋值区
                    for (CoinAddressCityChild2Mode * model3 in model2.child_info2) {
                        NSMutableDictionary * dict3 = [NSMutableDictionary dictionary];
                        dict3[@"name"] = model3.name;
                        dict3[@"code"] = model3.idStr;
                        [array3 addObject:dict3];
                    }
                    dict2[@"arealist"] = array3;
                }
                dict[@"citylist"] = array2;
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)AddAddress:(void (^)(BOOL))isSucceed
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    if (BCStringIsEmpty(self.province)) {
        ViewToast(@"请选择地址", 1);
        return;
    }
    if (self.NameTF.text.length == 0) {
        ViewToast(@"请填写收货人", 1);
        return;
    }
    if (self.AddressTF.text.length == 0) {
        ViewToast(@"请填写详细地址", 1);
        return;
    }
    if (self.PhoneNumberTF.text.length == 0) {
        ViewToast(@"请填写手机号码", 1);
        return;
    }
    if (![self isMobileNumber:self.PhoneNumberTF.text]) {
        ViewToast(@"请填写正确的手机号码", 1);
        return;
    }
    dict[@"province"] = self.province;// 省
    dict[@"city"] = self.city;//  市
    dict[@"district"] = self.district; //区
    dict[@"consignee"] = self.NameTF.text;
    dict[@"mobile"] = self.PhoneNumberTF.text;
    dict[@"address"] = self.AddressTF.text;
    [KTooL HttpPostWithUrl:@"Order/new_address_submit" parameters:dict loadString:@"正在提交" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            ViewToast(@"添加成功", 2);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserAddressSuccess" object:nil];
        }else{
            ViewToast(BCMsg, 2);
        }
        isSucceed(BCStatus);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         isSucceed(NO);
    }];
    
}
- (void)EditAddress:(void (^)(BOOL))isSucceed{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
   
    if (BCStringIsEmpty(self.province)) {
        ViewToast(@"请选择地址", 1);
        return;
    }
    if (self.NameTF.text.length == 0) {
        ViewToast(@"请填写收货人", 1);
        return;
    }
    if (self.AddressTF.text.length == 0) {
        ViewToast(@"请填写详细地址", 1);
        return;
    }
    if (self.PhoneNumberTF.text.length == 0) {
        ViewToast(@"请填写手机号码", 1);
        return;
    }
    if ([self isMobileNumber:self.PhoneNumberTF.text]) {
        ViewToast(@"请填写正确的手机号码", 1);
        return;
    }
    dict[@"address_id"] = self.address_id;
    dict[@"province"] = self.province;// 省
    dict[@"city"] = self.city;//  市
    dict[@"district"] = self.district; //区
    dict[@"consignee"] = self.NameTF.text;
    dict[@"mobile"] = self.PhoneNumberTF.text;
    dict[@"address"] = self.AddressTF.text;
     [KTooL HttpPostWithUrl:@"Order/edit_address_submit" parameters:dict loadString:@"正在提交" success:^(NSURLSessionDataTask *task, id responseObject) {
        isSucceed(BCStatus);
        if (!BCStatus) {
            ViewToast(responseObject[@"msg"], 2);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        isSucceed(NO);
    }];
    
}

- (void)requestAddress{
   
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"address_id"] = self.address_id;

    [KTooL HttpPostWithUrl:@"Order/edit_address" parameters:dict loadString:@"正在加载" success:^(NSURLSessionDataTask *task, id responseObject) {
        if (BCStatus) {
            NSDictionary * dict = responseObject[@"data"];
            if (!BCDictIsEmpty(dict)) {
                [self upDataUI:dict];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)upDataUI:(NSDictionary *)dict{
    self.NameTF.text = dict[@"consignee"];
    self.PhoneNumberTF.text = dict[@"mobile"];
    self.CityTF.text = dict[@"address_area"];
    self.AddressTF.text = dict[@"address"];
    self.province = [NSString stringWithFormat:@"%@",dict[@"province"]];
    self.city = [NSString stringWithFormat:@"%@", dict[@"city"]];
    self.district = [NSString stringWithFormat:@"%@",dict[@"district"]];
}

- (void)setAddress_id:(NSString *)address_id{
    _address_id = address_id;
    if (!BCStringIsEmpty(address_id)) {
         [self requestAddress];
    }
   
}
@end

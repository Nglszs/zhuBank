//
//  CoinRegisterView.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinRegisterView : UIView
@property (nonatomic,strong)UIButton * RegisterButton;
@property (nonatomic,strong)UITextField * PhoneNumberTF;
@property (nonatomic,strong)UITextField * CodeTF;
@property (nonatomic,strong)UITextField * PassWordTF1;
@property (nonatomic,strong)UITextField * PassWordTF2;
@property (nonatomic,strong)UIButton * GetCodeButton;
@property (nonatomic,strong)UILabel * userProtocol;// 用户协议
@property (nonatomic,strong)UILabel * privacyProtocol;
@end

NS_ASSUME_NONNULL_END

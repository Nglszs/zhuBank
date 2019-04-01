//
//  CoinMemberDredgeCell.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/24.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinMemberDredgeCell : UITableViewCell

@property (nonatomic,strong)UIButton * dredgeButton;

@property (nonatomic,strong)UIButton * agreementBtn;
@property (nonatomic,copy)NSString * end_time;
@property (nonatomic,weak)UIViewController * SelfVC;
@property (nonatomic,copy)NSString * service_agreement;
@end

NS_ASSUME_NONNULL_END

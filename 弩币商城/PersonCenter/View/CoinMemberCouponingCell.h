//
//  CoinMemberCouponingCell.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinMemberCouponingCell : UITableViewCell
@property (nonatomic,strong)UIButton * agreementBtn;
// 优惠券礼包
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,weak)UIViewController * SeleVC;

@end

NS_ASSUME_NONNULL_END

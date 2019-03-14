//
//  CoinConfirmCommoditListCell.h
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/27.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface CoinConfirmCommoditListCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier leftTitle:(NSString *)leftTitleStr leftTitleColor:(UIColor *)leftTitleColor tagString:(NSString *)tagString rightStr:(NSString *)rightStr rightStrColor:(UIColor *)rightStrColor isShowSelectImage:(BOOL)isShowSelectImage;



// 发票信息
@property (nonatomic,strong)NSDictionary * invoice_infoData;

// 总价
@property (nonatomic,copy)NSString * total_price;
// 运费
@property  (nonatomic,copy)NSString * transfer_price;

@property (nonatomic,copy)NSString * coupons_reduce;// 满减券减的钱数
@property (nonatomic,copy)NSString * coupons_reduce_id;//满减券id
@property (nonatomic,copy)NSString * coupons_transfer;// 运费券减的钱数
@property (nonatomic,copy)NSString * coupons_transfer_id;

@end

NS_ASSUME_NONNULL_END

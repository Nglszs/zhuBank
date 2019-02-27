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
@end

NS_ASSUME_NONNULL_END

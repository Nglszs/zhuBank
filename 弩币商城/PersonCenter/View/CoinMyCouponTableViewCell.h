//
//  CoinMyCouponTableViewCell.h
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ViewCellHeightDelegate <NSObject>

- (void)refreshCell:(NSInteger)selectedIndex;

@end

@interface CoinMyCouponTableViewCell : UITableViewCell

@property (nonatomic , assign) NSInteger type;//1是已使用，2是已过期
@property (nonatomic , strong) UIButton *activityBtn;
@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UIView *detailV;
@property (nonatomic, weak)     id <ViewCellHeightDelegate> delegate;
- (void)setDataForCell:(NSDictionary *)data;

+ (CGFloat)getCellHeight:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END

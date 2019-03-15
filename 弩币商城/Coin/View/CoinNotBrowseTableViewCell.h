//
//  CoinNotBrowseTableViewCell.h
//  弩币商城
//
//  Created by Jack on 2019/3/15.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinNotBrowseTableViewCell : UITableViewCell
@property(nonatomic, strong) UILabel *segLabel,*segLabel1;
- (void)setValueData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END

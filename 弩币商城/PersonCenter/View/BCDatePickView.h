//
//  BCDatePickView.h
//  映币
//
//  Created by Jack on 2018/12/24.
//  Copyright © 2018 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BCDatePickView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, copy) void(^selectBlock)(NSString  *indexPath);









@end



//
//  DefineFrame.h
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#ifndef DefineFrame_h
#define DefineFrame_h

#define BCBound  [UIScreen mainScreen].bounds
#define BCWidth   [UIScreen mainScreen].bounds.size.width
#define BCHeight  [UIScreen mainScreen].bounds.size.height


//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define BCNaviHeight ([Tool isIphoneXSerise]?88:64)


#define BCTabHeight ([Tool isIphoneXSerise]?34:0)

#define R(value) (value * BCWidth/375)

#define LEFT_Margin 15
#define TOP_Margin 10
#endif /* DefineFrame_h */

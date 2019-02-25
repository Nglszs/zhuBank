//
//  DefineColor.h
//  映币
//
//  Created by Jack on 2018/12/11.
//  Copyright © 2018年 Jack. All rights reserved.
//

#ifndef DefineColor_h
#define DefineColor_h

#define White          [UIColor whiteColor]
#define Red            [UIColor redColor]
#define ImageColor     [UIColor lightGrayColor]


#define ThemeColor White

#define LabelBackColor COLOR(0, 5, 34)

#define LineColor    COLOR(91, 81, 112)


#define Gray_Color COLOR(102, 102, 102)

#define  Color213 COLOR(213, 213, 213)


//底部tabbar颜色
#define TabTitleSeletedolor   ACOLOR(217, 193, 115, 1)
#define TabTitleNormalColor   ACOLOR(204, 204, 204, 1)



#define RandomColor  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

#define COLOR(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

#define ACOLOR(R, G, B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#endif /* DefineColor_h */

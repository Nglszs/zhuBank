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

#define  Color242 COLOR(242, 242, 242)
#define DIVI_COLOR COLOR(238, 238, 238)

#define TITLE_COLOR COLOR(51, 51, 51)

//底部tabbar颜色
#define TabTitleSeletedolor   ACOLOR(236, 81, 84, 1)
#define TabTitleNormalColor   ACOLOR(93, 93, 93, 1)



#define RandomColor  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

#define COLOR(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

#define ACOLOR(R, G, B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#endif /* DefineColor_h */

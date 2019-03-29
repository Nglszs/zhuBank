//
//  WOWONoDataView.m
//  WormwormLife
//
//  Created by 张文彬 on 2018/2/10.
//  Copyright © 2018年 张文彬. All rights reserved.
//

#import "WOWONoDataView.h"

@implementation WOWONoDataView
{
    UIImageView *imageView;
    UILabel *textLabel;
    UILabel *detailTextLabel;
    UIButton *button;
    
}
- (instancetype)initWithImageName:(NSString *)imageName text:(NSString *)text detailText:(NSString *)detailText buttonTitle:(NSString *)buttonTitle {
    self = [super init];
    if (self) {
        self.backgroundColor = White;
        
        CGFloat y = 160;
        
        imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:imageName];
        [imageView sizeToFit];
        imageView.center= CGPointMake(BCWidth / 2, y) ;
       
        [self addSubview:imageView];
        
        y = imageView.bottom + 25;
        
        textLabel = [[UILabel alloc]init];
        textLabel.text = text;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = COLOR(102, 102, 102);
        textLabel.font = [UIFont systemFontOfSize:17];
        [textLabel sizeToFit];
        textLabel.width = BCWidth - 20;
       
        textLabel.center = CGPointMake(BCWidth / 2, y);
        textLabel.height = 20;
        [self addSubview:self.text = textLabel];
        
        y = textLabel.bottom + 15;
        
        
        
        if (detailText.length > 0) {
            detailTextLabel = [[UILabel alloc]init];
            detailTextLabel.textAlignment = NSTextAlignmentCenter;
            detailTextLabel.text = detailText;
            detailTextLabel.textColor =COLOR(102, 102, 102);
            detailTextLabel.font = [UIFont systemFontOfSize:13];
            detailTextLabel.width = BCWidth - 20;
            detailTextLabel.height = 20;

           
            detailTextLabel.center = CGPointMake(BCWidth/2, y);
            [self addSubview:  detailTextLabel];
            y = detailTextLabel.bottom + 25;
        }
        
        
        if (buttonTitle.length > 0) {
            button = [[UIButton alloc]init];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            [button setTitleColor:White forState:UIControlStateNormal];
            button.layer.cornerRadius = 5;
            button.titleLabel.font = Regular(16);
            button.backgroundColor = COLOR(255, 0, 0);
            button.width = BCWidth - 50;
            button.height = 35;
           
            button.center = CGPointMake(BCWidth/2, y + 40);
            [self addSubview:self.button = button];
        }
        
    }
    return self;
    
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_isAdjust) {
        CGFloat y = self.height/2 - imageView.height;
        imageView.top = y;
        y = imageView.bottom + 25;
        textLabel.top = y;
        detailTextLabel.top = y;
        button.top = y + 50;
    }
    
    
}
@end

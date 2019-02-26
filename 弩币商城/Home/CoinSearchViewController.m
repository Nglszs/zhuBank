//
//  CoinSearchViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinSearchViewController.h"
#import "CoinSearchResultViewController.h"
@interface CoinSearchViewController ()

@property (nonatomic,strong)UITextField * SearchTF;
@end

@implementation CoinSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:COLOR(51, 51, 51)}];
    [self initView];
}

// 布局
- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * SearchView = [UIView new];
    [self.view addSubview:SearchView];
    [SearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(self.view).offset(10);
        make.height.mas_offset(45);
    }];
    SearchView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    SearchView.layer.borderColor = COLOR(245, 245, 245).CGColor;
    SearchView.layer.borderWidth = 0.5;
    
    UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.backgroundColor = COLOR(225, 37, 22);
    [SearchView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(SearchView);
        make.width.mas_equalTo(80);
    }];
    [btn addTarget:self action:@selector(GoSearch:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.SearchTF = [UITextField new];
    self.SearchTF.placeholder = @"搜索商品";
    
    [self.SearchTF setValue:COLOR(153, 153, 153) forKeyPath:@"_placeholderLabel.textColor"];
    [self.SearchTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [SearchView addSubview:self.SearchTF];
    self.SearchTF.returnKeyType = UIReturnKeySearch;
    
    [self.SearchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SearchView).offset(15);
        make.right.equalTo(btn.mas_left);
        make.centerY.equalTo(SearchView);
    }];
    
    UILabel * label = [UILabel new];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"热门搜索" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:1.0]}];
    
    label.attributedText = string;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SearchView);
        make.top.equalTo(SearchView.mas_bottom).offset(20);
        
    }];
    [self SetLabel:@[@"苹果",@"华为",@"小米",@"oppo",@"三星"]];
   
}

- (void)SetLabel:(NSArray<NSString *>*)titles{
    CGFloat x = 15; //每行x轴的初始位置
    CGFloat y = 110; //间隙+label的高度
    
    for (int i = 0; i < titles.count; i++) {
        
        UILabel *label = [self labelWithTitle:titles[i]];
        CGFloat width = label.frame.size.width + 30;
        
        if (x + width + 15 > BCWidth) {
            y += 40;//换行
            x = 15; //15位置开始，即x的初始位置
        }
        
        label.frame = CGRectMake(x, y, width, 30);
        [self.view addSubview:label];
        x += width + 10;//宽度+间隙
    }
    
}

- (UILabel *)labelWithTitle:(NSString *)title{
    
    UILabel *label = [[UILabel alloc] init];
     label.font = [UIFont systemFontOfSize:12];
    label.text = title;
    [label sizeToFit];
    label.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    label.layer.cornerRadius = 13;
    label.clipsToBounds = YES;
    label.userInteractionEnabled = YES;
   
    label.textColor = COLOR(136, 136, 136);
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)GoSearch:(UIButton *)button{
    CoinSearchResultViewController * vc = [CoinSearchResultViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

//
//  CoinBaseViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBaseViewController.h"

@interface CoinBaseViewController ()

@end

@implementation CoinBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = White;
}

- (void)viewDidAppear:(BOOL)animated {
    
    //    由于自定义了返回按钮，所以必须重写代理
    if (!self.navigationController.isNavigationBarHidden) {
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        
        
    }
}

- (void)setBackLeftBar:(NSString *)backTitle{
    
    //  返回
    
    
    
    
    
    UIButton *backBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0,R(48), R(48))];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [backBtn setTitle:backTitle forState:UIControlStateNormal];
    [backBtn setTitleColor:White forState:UIControlStateNormal];
    backBtn.titleLabel.font = MediumFont(15);
    
    [backBtn setImage:BCImage(Path Copy) forState:UIControlStateNormal];
    [backBtn imagePositionStyle:ImagePositionStyleDefault spacing:7];
    UIBarButtonItem *backBut = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    //    如果自定义leftBarButtonItem返回按钮的话，侧滑手势会失效
    self.navigationItem.leftBarButtonItem = backBut;
    
    
    
    
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)setCustomRightBar:(NSString *)rightTitle click:(void (^)(void))clickRight {
    
    UIButton *backBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0,R(48), R(48))];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [backBtn setTitle:rightTitle forState:UIControlStateNormal];
    [backBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    backBtn.titleLabel.font = Regular(15);
    
    UIBarButtonItem *backBut = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backBut;
    [backBtn addtargetBlock:^(UIButton *button) {
        
        clickRight();
    }];
    
}
- (MJRefreshStateHeader *)loadMJRefresh:(void (^)(void))completion {
    
    //正常
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
            if (completion) {
                completion();
            }
    
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
    
    
//    //动画类刷新
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        if (completion) {
//            completion();
//        }
//    }];
//    
//    header.lastUpdatedTimeLabel.hidden= YES;
//    header.stateLabel.hidden = YES;
//    
//    
//    
//    //设置普通状态的动画图片
//    [header setImages:[self normalImages] forState:MJRefreshStateIdle];
//    
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    [header setImages:[self refreshImages] forState:MJRefreshStatePulling];
//    
//    // 设置正在刷新状态的动画图片
//    [header setImages:[self refreshImages] forState:MJRefreshStateRefreshing];
    
    return header;
    
}

- (NSMutableArray *)normalImages
{
    
    NSMutableArray  *normalImages = [[NSMutableArray alloc] init];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"wowo_refresh_1"]];
    
    [normalImages addObject:image];
    
    return normalImages;
}

//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    
    NSMutableArray *refreshImages = [[NSMutableArray alloc] init];
    
    //                循环添加图片
    for (NSUInteger i = 1; i <= 35; i++ ) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"wowo_refresh_%ld", i]];
        [refreshImages addObject:image];
        
    }
    
    return refreshImages;
}

- (void)dealloc {
    
    [NOTIFICATION_CENTER removeObserver:self];
    
    NSLog(@"%@已被释放",NSStringFromClass([self class]));
}

@end

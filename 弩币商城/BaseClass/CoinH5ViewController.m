//
//  CoinH5ViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/7.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinH5ViewController.h"

@interface CoinH5ViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation CoinH5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if (BCStringIsEmpty(self.url)) {
        
        VCToast(@"h5地址不能为空", 1);
        
        return;
    }
    
    if (![self.url hasPrefix:@"http"]&&![self.url hasPrefix:@"https"]) {
        
        VCToast(@"h5地址错误", 1);
        
        return;
    }
    
    [self SetReturnButton];
self.commWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight-BCNaviHeight) ];
    self.title = self.titleStr;
NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]
                                                          cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                      timeoutInterval:15.0];
    [self.commWebView loadRequest:theRequest];
    self.commWebView.UIDelegate=self;
    self.commWebView.navigationDelegate=self;
    [self.view addSubview:self.commWebView];
    
    
   
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.progressTintColor=Red;
    _progressView.trackTintColor =Color242;
    //    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    
    [self.commWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.commWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    // Do any additional setup after loading the view.
}

- (void)back {
    if ([_commWebView canGoBack]) {
        [_commWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)reloadWebView {
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]
                                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                          timeoutInterval:15.0];
    [self.commWebView loadRequest:theRequest];
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (![self.navigationController.viewControllers containsObject:self]) {
        if (self.backBlock) {
            self.backBlock();
        }
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progressView.progress = self.commWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else if ([keyPath isEqualToString:@"title"]){
        
//        self.navigationItem.titleLabel.text = self.commWebView.title;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    //    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
   
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}

- (void)dealloc {
    
    [self.commWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.commWebView removeObserver:self forKeyPath:@"title"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
@end

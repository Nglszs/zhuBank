//
//  CoinSetSexViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinSetSexViewController.h"

@interface CoinSetSexViewController ()
{
    UIButton *selectedBtn;
}
@end

@implementation CoinSetSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    NSArray *titleA = @[@"图层 2",@"图层 1"];
    NSArray *titleA1 = @[@"图层 2 拷贝",@"图层 1 拷贝"];
    for (int i = 0; i < 2 ; i++) {
        UIButton *activityBtn = [UIButton new];
       
       
        [activityBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",titleA[i]]] forState:UIControlStateNormal];
         [activityBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",titleA1[i]]] forState:UIControlStateSelected];
       
      
        activityBtn.tag = 100 + i;
       
        [self.view addSubview:activityBtn];
        
        [activityBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(60);
            make.left.mas_equalTo((BCWidth - 120)/3 +i*((BCWidth - 120)/3 + 60));
            
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        
        if (i == 0) {
            activityBtn.selected = YES;
            selectedBtn = activityBtn;
        }
        
    }
    
    
    
    
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(17);
    [backBtn1 setTitle:@"确认修改" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 17;
    
    backBtn1.backgroundColor = COLOR(255, 0, 0);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(164);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(185);
    }];
    
    [backBtn1 addtargetBlock:^(UIButton *button) {
        
        
        [KTooL HttpPostWithUrl:@"UserCenter/set_sex" parameters:@{@"sex":@(selectedBtn.tag - 99)} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            NSLog(@"===%@",responseObject);
            
            
            if (BCStatus) {
                
                VCToast(@"修改成功", 1);
                 [NOTIFICATION_CENTER postNotificationName:Reresh_UserInfo object:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            } else {
                
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            
        }];
        
    }];
}


- (void)buttonClick:(UIButton *)button {
    
    if (button!= selectedBtn) {
        
        selectedBtn.selected = NO;
        button.selected = YES;
        selectedBtn = button;
        
    }else{
        
        selectedBtn.selected = YES;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

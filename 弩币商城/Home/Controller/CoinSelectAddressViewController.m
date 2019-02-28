//
//  CoinSelectAddressViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/28.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinSelectAddressViewController.h"
#import "CoinSelectAddresCell.h"
#import "CoinChangeAddressViewController.h"
@interface CoinSelectAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation CoinSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地址";
    [self initView];
    
}


- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    [self.tableView registerClass:[CoinSelectAddresCell class] forCellReuseIdentifier:@"CoinSelectAddresCell"];
    UIButton * addAddressButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addAddressButton.titleLabel.font = Regular(17);
    [addAddressButton setTitle:@"+新建地址" forState:(UIControlStateNormal)];
    [addAddressButton addTarget:self action:@selector(addAddressAction:) forControlEvents:(UIControlEventTouchUpInside)];
    addAddressButton.backgroundColor = COLOR(255, 0, 0);
    [self.view addSubview:addAddressButton];
    [addAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
}


- (void)addAddressAction:(UIButton *)btn{
    CoinChangeAddressViewController * vc = [[CoinChangeAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinSelectAddresCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinSelectAddresCell"];
    cell.selectionStyle = 0;
    return cell;
}



@end

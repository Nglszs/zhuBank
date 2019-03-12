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
@property (nonatomic,strong)NSArray * dataArray;
@end

@implementation CoinSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地址";
    [self initView];
    [self SetReturnButton];
   
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self request];
}


- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
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
    vc.address_id = @"";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinSelectAddresCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinSelectAddresCell"];
    cell.dataDict = self.dataArray[indexPath.row];
    cell.selectionStyle = 0;
    cell.editBtn.tag = 1000 + indexPath.row;
    [cell.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}


- (void)request{
    [KTooL HttpPostWithUrl:@"Order/select_address" parameters:nil loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (BCStatus) {
            self.dataArray = responseObject[@"data"];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)editBtnAction:(UIButton *)btn{
    CoinChangeAddressViewController * vc = [[CoinChangeAddressViewController alloc] init];
    vc.address_id = self.dataArray[btn.tag - 1000][@"address_id"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end

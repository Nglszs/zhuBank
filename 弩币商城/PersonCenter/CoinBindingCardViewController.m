//
//  CoinBindingCardViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinBindingCardViewController.h"
#import "BankCardCell.h"

@interface CoinBindingCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation CoinBindingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray arrayWithCapacity:1];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerClass:[BankCardCell class] forCellReuseIdentifier:@"BankCardCell"];
    self.title = @"可绑定的银行卡";
    self.tableView.tableFooterView = [UIView new];
    [self SetReturnButton];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR(51, 51, 51),
                                                                      NSFontAttributeName : Regular(17)}];

    [self getData];
}

- (void)getData {
    
    [KTooL HttpPostWithUrl:@"MaterialVerify/bank_list" parameters:@{@"type":@(_type)} loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"===%@",responseObject);
        
        
        if (BCStatus) {
            
            NSArray *arr = [responseObject objectNilForKey:@"data"];
            [_dataArr addObjectsFromArray:arr];
            [self.tableView reloadData];
            
        } else {
            
            VCToast(@"加载数据失败", 1);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BankCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BankCardCell"];
    cell.selectionStyle = 0;
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    [cell.BankImageView sd_setImageWithURL:[dic objectNilForKey:@"pic"]];
    cell.BankNameLabel.text = [dic objectNilForKey:@"name"];
    cell.BankMoneyLabel.text =[dic objectNilForKey:@"limit"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


@end

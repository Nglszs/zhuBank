//
//  CoinSearchResultViewController.m
//  弩币商城
//
//  Created by 暴瑞瑞 on 2019/2/26.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinSearchResultViewController.h"
#import "CoinSearchResultCell.h"
#import "CoinSearchResultModel.h"
#import "HttpTool.h"

#import <MJRefresh/MJRefresh.h>

@interface CoinSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong)UISearchBar * searchBar;
@property (nonatomic,strong)NSArray * DataArray;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,assign)int page;
@end

@implementation CoinSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self SetReturnButton];
    [self RequestKeyword:self.keyword];
    self.page = 1;
}

// 初始化视图
- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initButton];
    [self initTableView];
    [self initSearchBar];
}

// 头部按钮
- (void)initButton{
    UIButton * SalesButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [SalesButton setTitle:@"销量" forState:(UIControlStateNormal)];
    [SalesButton setTitleColor:COLOR(35, 35, 35) forState:(UIControlStateNormal)];
    [self.view addSubview:SalesButton];
    [SalesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.width.equalTo(self.view).multipliedBy(0.5);
    }];
    SalesButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    
    UIButton * PriceButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [PriceButton setTitle:@"销量" forState:(UIControlStateNormal)];
    [PriceButton setTitleColor:COLOR(35, 35, 35) forState:(UIControlStateNormal)];
    [self.view addSubview:PriceButton];
    [PriceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(SalesButton);
        make.left.equalTo(SalesButton.mas_right);
        make.width.equalTo(self.view).multipliedBy(0.5);
    }];
    PriceButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIView * lineView1 = [UIView new];
    lineView1.backgroundColor = COLOR(224, 224, 224);
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(SalesButton);
    }];
    
    UIView * lineView2 = [UIView new];
    lineView2.backgroundColor = COLOR(224, 224, 224);
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(SalesButton);
    }];
}

// 初始化tableView
- (void)initTableView{
    UITableView * tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.tableFooterView = [UIView new];
    tabView.mj_footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self RequestKeyword:self.keyword];
    }];
    self.tableView = tabView;
    [self.view addSubview:tabView];
    [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(40);
    }];
    
}

#pragma mark  tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinSearchResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinSearchResultCell"];
    if (cell == nil) {
        cell = [[CoinSearchResultCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CoinSearchResultCell"];
    }
    cell.model = self.DataArray[indexPath.row];
    cell.selectionStyle = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

// 初始化导航栏
- (void)initSearchBar{
    UIView*titleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,BCWidth-70,30)];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, BCWidth - 70, 30)];
    
    self.searchBar.text = self.keyword;
    
    self.searchBar.layer.cornerRadius = 15;
    
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    self.searchBar.barTintColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
    self.searchBar.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    self.searchBar.delegate = self;
    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
    
    UITextField*searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.textColor = COLOR(51, 51, 51);
    searchField.backgroundColor = COLOR(242, 242, 242);
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [self RequestKeyword:searchBar.text];
    return YES;
}

- (void)RequestKeyword:(NSString *)keyword{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"keyword"] = self.keyword;
    dict[@"sort"] = @"sales_sum";
    dict[@"way"] = @"1";
    dict[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [[HttpTool sharedHttpTool] HttpPostWithUrl:@"Search/results" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        if (BCStatus) {
            NSArray * array = responseObject[@"data"][@"goods_list"];
            if (!BCArrayIsEmpty(array)) {
                self.DataArray =  [NSArray yy_modelArrayWithClass:[CoinSearchResultModel class] json:array];
                [self.tableView reloadData];
            }else{
                [self.tableView.mj_footer resetNoMoreData];
            }
        }else{
              [self.tableView.mj_footer resetNoMoreData];
        }
      
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
@end

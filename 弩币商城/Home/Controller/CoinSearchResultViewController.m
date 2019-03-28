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
#import "CoinGoodDetailViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface CoinSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong)UISearchBar * searchBar;
@property (nonatomic,strong)NSMutableArray * DataArray;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,assign)int page;

// 销量排序 0 其他的  1 升序  2 降序
@property (nonatomic,assign)NSInteger SalesTop;

// 价格排序 0 其他的  1 升序  2 降序
@property (nonatomic,assign)NSInteger PriceTop;

@property (nonatomic,strong)UIImageView * SalesTopImage;
@property (nonatomic,strong)UIImageView * SalesBtnImage;

@property (nonatomic,strong)UIImageView * PriceTopImage;
@property (nonatomic,strong)UIImageView * PriceBtnImage;
@property (nonatomic,strong)UIView * NoDataView;
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
    [self initNoDataView];
    self.SalesTop = 1;
    self.PriceTop = 0;
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
    [PriceButton setTitle:@"价格" forState:(UIControlStateNormal)];
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
    
    self.SalesTopImage = [[UIImageView alloc] initWithImage:BCImage(上拷贝)];
    [SalesButton addSubview:self.SalesTopImage];
    [self.SalesTopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(SalesButton.mas_centerY).offset(-0.5);
        make.left.equalTo(SalesButton.titleLabel.mas_right).offset(5);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(4);
    }];
    
    self.SalesBtnImage = [[UIImageView alloc] initWithImage:BCImage(下拷贝2)];
    [SalesButton addSubview:self.SalesBtnImage];
    [self.SalesBtnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(SalesButton.mas_centerY).offset(0.5);
        make.left.equalTo(SalesButton.titleLabel.mas_right).offset(5);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(4);
    }];
    
    
    
    self.PriceTopImage = [[UIImageView alloc] initWithImage:BCImage(上拷贝)];
    [PriceButton addSubview:self.PriceTopImage];
    [self.PriceTopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(PriceButton.mas_centerY).offset(-0.5);
        make.left.equalTo(PriceButton.titleLabel.mas_right).offset(5);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(4);
    }];
    
    self.PriceBtnImage = [[UIImageView alloc] initWithImage:BCImage(下拷贝2)];
    [PriceButton addSubview:self.PriceBtnImage];
    [self.PriceBtnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PriceButton.mas_centerY).offset(0.5);
        make.left.equalTo(PriceButton.titleLabel.mas_right).offset(5);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(4);
    }];
    SalesButton.adjustsImageWhenHighlighted = NO;
    [SalesButton addTarget:self action:@selector(SalesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    PriceButton.adjustsImageWhenHighlighted = NO;
    [PriceButton addTarget:self action:@selector(PriceButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
- (void)SalesButtonAction:(UIButton *)btn{
    self.SalesTop =  btn.selected ? 1 : 2;
    self.PriceTop = 0;
    btn.selected = !btn.selected;
    [self RequestKeyword:self.keyword];
    
}
- (void)PriceButtonAction:(UIButton *)btn{
    self.PriceTop =  btn.selected ? 1 : 2;
    self.SalesTop = 0;
    
    btn.selected = !btn.selected;
    [self RequestKeyword:self.keyword];
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
    tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinGoodDetailViewController * vc = [CoinGoodDetailViewController new];
    CoinSearchResultModel * model = self.DataArray[indexPath.row];
    vc.goodID = model.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
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
    searchField.font = Regular(15);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.DataArray removeAllObjects];
    self.page = 1;
    self.keyword = searchBar.text;
    [self RequestKeyword:self.keyword];
    [searchBar resignFirstResponder];
}

- (void)RequestKeyword:(NSString *)keyword{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"keyword"] = keyword;
    dict[@"sort"] = self.SalesTop == 0? @"price" : @"sales_sum";
    dict[@"way"] = self.SalesTop == 0 ? [NSString stringWithFormat:@"%ld",(long)self.PriceTop] :[NSString stringWithFormat:@"%ld",(long)self.SalesTop];
    dict[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [[HttpTool sharedHttpTool] HttpPostWithUrl:@"Search/results" parameters:dict loadString:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        if (BCStatus) {
            
            NSArray * array = responseObject[@"data"][@"goods_list"];
            if (!BCArrayIsEmpty(array)) {
                if (self.page == 1) {
                    [self.DataArray removeAllObjects];
                }
                NSArray * arr =  [NSArray yy_modelArrayWithClass:[CoinSearchResultModel class] json:array];
                [self.DataArray addObjectsFromArray:arr];
                [self.tableView reloadData];
                 [self.tableView.mj_footer endRefreshing];
                self.NoDataView.hidden = YES;
            }else{
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
             
            }
        }else{
           
              [self.tableView.mj_footer endRefreshingWithNoMoreData];
            if (BCArrayIsEmpty(self.DataArray)) {
                self.NoDataView.hidden = NO;
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];

}

- (void)initNoDataView{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tableView);
    }];
    UILabel * label = [UILabel new];
    label.text = @"抱歉暂时没有相关结果，换个筛选条件试试吧";
    label.numberOfLines = 0;
    [view addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view).offset(50);
        make.left.right.equalTo(view);
        
    }];
    
    view.hidden = YES;
    self.NoDataView = view;
    
    
}
- (NSMutableArray *)DataArray{
    if (_DataArray == nil) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

- (void)setSalesTop:(NSInteger)SalesTop{
    _SalesTop = SalesTop;
    if (SalesTop != 0) {
        self.PriceTop = 0;
        
        self.SalesTopImage.image = SalesTop == 1 ? BCImage(上拷贝2) :  BCImage(上拷贝) ;
        self.SalesBtnImage.image = SalesTop == 2? BCImage(下拷贝3) :  BCImage(下拷贝2) ;
    }else{
        self.SalesBtnImage.image = BCImage(下拷贝2);
        self.SalesTopImage.image = BCImage(上拷贝);
    }
}

- (void)setPriceTop:(NSInteger)PriceTop{
    _PriceTop = PriceTop;
    if (PriceTop != 0) {
        self.SalesTop = 0;
        self.PriceTopImage.image = PriceTop == 1 ? BCImage(上拷贝2) :  BCImage(上拷贝) ;
        self.PriceBtnImage.image = PriceTop == 2? BCImage(下拷贝3) :  BCImage(下拷贝2) ;
    }else{
        self.PriceBtnImage.image = BCImage(下拷贝2);
        self.PriceTopImage.image = BCImage(上拷贝);
    }
}
@end

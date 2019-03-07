//
//  CoinClassfyViewController.m
//  弩币商城
//
//  Created by Jack on 2019/2/25.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinClassfyViewController.h"
#import "CoinClassfyLeftTVCell.h"
#import "CoinClassfyCollectionCell.h"
#import "UIViewController+Common.h"
#import "CoinConfirmOrderViewController.h"
#import "HttpTool.h"
#import "CoinSearchViewController.h"
#import "CoinClassLeftModel.h"
@interface CoinClassfyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UICollectionView * CollectionView;
@property (nonatomic,strong)NSIndexPath * selectIndex;
@property (nonatomic,strong)UISearchBar * searchBar;
@property (nonatomic,strong)NSArray * LeftDataArray;
@property (nonatomic,strong)NSArray * RightDataArray;
@end

@implementation CoinClassfyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self request];
}

- (void)initView{
    [self initTableView];
    [self initCollectionView];
    [self initSearchBar];
    [self setNavitemImage:@"密码" type:RightNavItem];
}

- (void)initTableView{
    self.view.backgroundColor = COLOR(238, 238, 238);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.mas_offset(88);
    }];
    
    self.tableView.tableFooterView = [UIView new];
  
}

- (void)initCollectionView{
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    self.CollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flow];
    self.CollectionView.delegate = self;
    self.CollectionView.dataSource = self;
    self.CollectionView.backgroundColor =  COLOR(238, 238, 238);
    [self.view addSubview:self.CollectionView];
    [self.CollectionView registerClass:[CoinClassfyCollectionCell class] forCellWithReuseIdentifier:@"CoinClassfyCollectionCell"];
    [self.CollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_right).offset(12);
        make.top.bottom.equalTo(self.view);
        make.right.equalTo(self.view).offset(-12);
    }];
    [self.CollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
}

- (void)initSearchBar{
     UIView*titleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,BCWidth-100,30)];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, BCWidth - 100, 30)];
    
    self.searchBar.placeholder = @"iPhone XS Max";
    
    self.searchBar.layer.cornerRadius = 15;
    
    self.searchBar.layer.masksToBounds = YES;
       self.searchBar.backgroundImage = [[UIImage alloc] init];
    self.searchBar.barTintColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
     self.searchBar.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    self.searchBar.delegate = self;
      [titleView addSubview:self.searchBar];
     self.navigationItem.titleView = titleView;
    
    UITextField*searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = COLOR(242, 242, 242);
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    CoinSearchViewController * vc = [CoinSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

#pragma mark  tableview  delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.LeftDataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinClassfyLeftTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CoinClassfyLeftTVCell"];
    if (cell == nil) {
        cell = [[CoinClassfyLeftTVCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CoinClassfyLeftTVCell"];
        
    }
    if (indexPath.row == self.selectIndex.row) {
        cell.isSelect = YES;
    }else{
        cell.isSelect = NO;
    }
    cell.selectionStyle =   UITableViewCellSelectionStyleNone;
    CoinClassLeftModel * model = self.LeftDataArray[indexPath.row];
    cell.title = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.selectIndex.row) {
        return;
    }
    self.selectIndex = indexPath;
    CoinClassLeftModel * model =  self.LeftDataArray[indexPath.row];
    self.RightDataArray = model.tmenu;
    [self.CollectionView reloadData];
    [self.tableView reloadData];
}
#pragma mark    CollectionView   delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.RightDataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CoinClassRightModel * model = self.RightDataArray[section];
    return model.sub_menu.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CoinClassfyCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CoinClassfyCollectionCell" forIndexPath:indexPath];
    CoinClassRightModel * model = self.RightDataArray[indexPath.section];
    CoinClassItemModel * model2 = model.sub_menu[indexPath.row];
    cell.name = model2.name;
    cell.image = model2.image;
    return cell;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((BCWidth - 88 - 12 - 12) / 3, 80);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.frame.size.width, 35);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
    }
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    for (UIView * view in headerView.subviews) {
        [view removeFromSuperview];
    }
    headerView.backgroundColor = COLOR(238, 238, 238);
    UILabel * label = [UILabel new];
    label.textColor = COLOR(102, 102, 102);
    label.font = TextFont(13);
    CoinClassRightModel * model = self.RightDataArray[indexPath.section];
    label.text = model.name;
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView);
        make.bottom.equalTo(headerView).offset(-5);
        
    }];
   
    return headerView;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CoinConfirmOrderViewController * vc = [CoinConfirmOrderViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)request{
   
    [[HttpTool sharedHttpTool] HttpPostWithUrl:@"Goods/categoryList" parameters:nil loadString:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (!BCArrayIsEmpty(responseObject[@"data"])) {
            self.LeftDataArray = [NSArray yy_modelArrayWithClass:[CoinClassLeftModel class] json:responseObject[@"data"]];
            if (!BCArrayIsEmpty(self.LeftDataArray)) {
                CoinClassLeftModel * model = self.LeftDataArray[0];
                self.RightDataArray = model.tmenu;
            }
          
          
            [self.tableView reloadData];
            [self.CollectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
}
@end

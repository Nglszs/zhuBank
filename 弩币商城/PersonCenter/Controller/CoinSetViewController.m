//
//  CoinSetViewController.m
//  弩币商城
//
//  Created by Jack on 2019/3/1.
//  Copyright © 2019年 詹姆斯. All rights reserved.
//

#import "CoinSetViewController.h"
#import "CoinChangeNickNameViewController.h"
#import "CoinSetSexViewController.h"
#import "BCDatePickView.h"
#import "CoinChangePhoneViewController.h"
#import "CoinChangePayCodeViewController.h"
#import "CoinChangePasswordViewController.h"

@interface CoinSetViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    
    NSArray *leftArr;
}
@property (nonatomic, strong) UITableView *playTableview;
@property (nonatomic, strong)  UIImageView *headImageView;//头像

@property (strong, nonatomic) UIImagePickerController *imagePicker;//拍照
@end

@implementation CoinSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
    leftArr = @[@"头像",@"昵称",@"性别",@"生日",@"手机",@"修改登录密码",@"交易密码",@"收货地址"];
    [self.view addSubview:self.playTableview];
    
//    退出登录
    UIButton *backBtn1 = [[UIButton alloc] init];
    backBtn1.titleLabel.font = Regular(17);
    [backBtn1 setTitle:@"安全退出" forState:UIControlStateNormal];
    [backBtn1 setTitleColor:White forState:UIControlStateNormal];
    backBtn1.layer.cornerRadius = 5;
    
    backBtn1.backgroundColor = COLOR(255, 0, 0);
    [self.view addSubview:backBtn1];
    [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(414);
        make.left.mas_equalTo(LEFT_Margin);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(BCWidth - 30);
    }];
    
    
}
#pragma mark tableview 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section==0?5:3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.section == 0&&indexPath.row == 0) {
        
        return 66;
    } else {
        
        
        return 46;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellID = @"cell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = White;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        左侧标题
        UILabel *leftL = [[UILabel alloc] init];
        leftL.text = @"3C产品";
        leftL.tag = 100;
        leftL.textColor = TITLE_COLOR;
        leftL.font = Regular(13);
        [cell.contentView addSubview:leftL];
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(LEFT_Margin);
            make.centerY.equalTo(cell.contentView);
            make.height.mas_equalTo(46);
            
        }];
        
        
        
        UIImageView *rightImage = [[UIImageView alloc] init];
        rightImage.image = BCImage(Back---Icon-);
        [cell.contentView addSubview:rightImage];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-LEFT_Margin);
            make.centerY.equalTo(cell.contentView);
        }];
        
        
        UILabel *rightL = [[UILabel alloc] init];
        rightL.text = @"Jack";
        rightL.tag = 200;
        rightL.textColor = COLOR(103, 103, 103);
        rightL.font = Regular(13);
        [cell.contentView addSubview:rightL];
        [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(rightImage.mas_left).offset(-TOP_Margin);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(46);
        }];
        
//      分割线
        UIImageView *lineImage = [[UIImageView alloc] init];
        lineImage.tag = 300;
        lineImage.backgroundColor = COLOR(218, 218, 218);
        
        [cell.contentView addSubview:lineImage];
        [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(BCWidth);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    
    UILabel *leftL = [cell.contentView viewWithTag:100];
    UILabel *rightL = [cell.contentView viewWithTag:200];
    
    if (indexPath.section == 0) {//上部分cell
        
        if (indexPath.row == 0) {
            
            rightL.hidden = YES;
           
            
            
            _headImageView = [[UIImageView alloc] init];
            _headImageView.image = BCImage(头像);
            _headImageView.layer.cornerRadius = 26;
            _headImageView.clipsToBounds = YES;
            [cell.contentView addSubview:_headImageView];
            [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(7);
                make.right.mas_equalTo(-LEFT_Margin);
                make.width.height.mas_equalTo(52);
                
            }];
        }
        
        leftL.text = leftArr[indexPath.row];
        
        
    } else {
        
        leftL.text = leftArr[indexPath.row + 5];
        rightL.hidden = YES;
    }
    

    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        
        
        switch (indexPath.row) {
            case 0:
            {
                [self showSystemSheetTitle:nil message:nil buttonTitle:@[@"相册",@"拍照"] handler:^(NSUInteger buttonIndex) {
                    
                    [self cameraFromUIImagePickerController:buttonIndex];
                }];
            }
                break;
            case 1:
            {
                [self.navigationController pushViewController:[CoinChangeNickNameViewController new] animated:YES];
            }
                break;
            case 2:
            {
                [self.navigationController pushViewController:[CoinSetSexViewController new] animated:YES];
            }
                break;
            case 3:
            {
                BCDatePickView *rev = [[BCDatePickView alloc] initWithFrame: CGRectMake(0, BCHeight, BCWidth, BCHeight) ];
                [SHARE_APPLICATION.keyWindow addSubview:rev];
                [UIView animateWithDuration:.25 animations:^{//评论页从底部显示动画
                    
                    rev.top = 0;
                }];
                
                rev.selectBlock = ^(NSString *indexPath) {
                    
                    NSLog(@"%@",indexPath);
                    
                };
                
            }
                
                break;
            case 4:
            {
                 [self.navigationController pushViewController:[CoinChangePhoneViewController new] animated:YES];
            }
                break;
            default:
                break;
        }
        
        
    } else {
        
        switch (indexPath.row) {
            case 0:
            {
                [self.navigationController pushViewController:[CoinChangePasswordViewController new] animated:YES];
            }
                break;
            case 1:
            {
                [self.navigationController pushViewController:[CoinChangePayCodeViewController new] animated:YES];
            }
                break;
            case 2:
            {
                [self.navigationController pushViewController:[CoinSetSexViewController new] animated:YES];
            }
                break;
            
            default:
                break;
        }
    }
}


#pragma mark 上传头像
- (void)cameraFromUIImagePickerController:(NSUInteger)type {
    
    
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.navigationBar.translucent = NO;//解决调起相册 中的照片被导航栏遮挡
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    if (type == 0) {//相册
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    } else {
      _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
   
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
}

#pragma mark 得到拍照图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        UIImage *newImage;
        if (self.imagePicker.allowsEditing) {//如果可以编辑
            
            newImage = [info objectForKey:UIImagePickerControllerEditedImage];
            
        } else {
            
            newImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        
        [_headImageView setImage:newImage];
//
//        [NOTIFICATION_CENTER postNotificationName:Change_Camer object:@{@"image":newImage}];
        
        
    }
    
    
    
    
    
//    imageName = [[self getNowTimeTimestamp]stringByAppendingPathExtension:@"jpg"];
//
//    NSString *filePath =[kPathTemp stringByAppendingPathComponent:
//                         [NSString stringWithFormat:@"%@", imageName]];  // 保存文件的名称
//    imagePath = filePath;
//    BOOL result =[ UIImageJPEGRepresentation(headImageView.image, .2)  writeToFile:filePath  atomically:YES]; // 保存成功会返回YES
//    if (result == YES) {
//        NSLog(@"保存成功");
//    }
//
//    [self startUpload];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}


#pragma mark 取消拍照
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (UITableView *)playTableview {
    
    
    if (!_playTableview) {
       
        _playTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BCWidth, BCHeight) style:UITableViewStyleGrouped];
        _playTableview.delegate = self;
        _playTableview.dataSource = self;
        _playTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _playTableview.backgroundColor = ThemeColor;
        _playTableview.backgroundColor = DIVI_COLOR;
        _playTableview.showsVerticalScrollIndicator = NO;
        _playTableview.showsHorizontalScrollIndicator = NO;
        
    }
    
    
    return _playTableview;
}

@end

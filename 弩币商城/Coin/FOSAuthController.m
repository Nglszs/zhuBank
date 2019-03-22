//
//  FOSAuthController.m
//  FOSHCTDemo
//
//  Created by Wei Niu on 2019/2/14.
//  Copyright © 2019年 Fosafer. All rights reserved.
//

#import "FOSAuthController.h"
#import <FosaferHumanCard/FosaferHumanCard.h>
#import <CoreMotion/CoreMotion.h>


#define FOS_SERVER      @"https://api.fosafer.com/compound_auth/v3"
/// 请与商务人员进行索取对应值
#define kHCLicense      @""
#define kHCSdkType      @""
#define kHCBundleID     @""


#define kMemberId    @""
#define kTerminalId  @""
#define kCerPasswd   @""

@interface FOSAuthController ()<FOSAuthenticatorDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *hintLabel;

@end

@implementation FOSAuthController {
    
    NSString *_name;
    NSString *_cardNo;
    
    FOSAuthenticator *_authenticator;
    AVCaptureSession *_cachedSession;
    
    CMMotionManager *_motionManager;
    
    // 手机是否竖直
    BOOL _isPortrait;
    // pop操作记录
    BOOL _isPop;
    // 完成当前流程记录
    BOOL _finished;
    // 记录当前流程的开始时刻
    BOOL _overTime;
    // 进入非活动状态标识符
    BOOL _isNotActivity;
    
    CFTimeInterval _startDetectTime;
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self checkCameraPermission:YES]) {
        [self startDetect];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_authenticator cancel];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"人证比对";
    
    _name = [self.params objectForKey:@"name"];
    _cardNo = [self.params objectForKey:@"cardNo"];
    
    [self initSubviews];
    
}


- (void)initSubviews {
    
    self.imageView.frame = self.view.bounds;
    self.imageView.image = [UIImage imageNamed:@"face_scan_background"];
    [self.view addSubview:self.imageView];
    
    self.hintLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
    self.hintLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 200);
    self.hintLabel.text = @"请对准检测框";
    [self.view addSubview:self.hintLabel];
    
}


- (void)startDetect {
    
    
 
    
    [self startMontionDetect];
    
    _isPop = NO;
    _finished = NO;
    _overTime = NO;
    _isNotActivity = NO;

    // 设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    if (_name.length <= 0 || _cardNo.length <= 0) {
        NSLog(@"输入信息有误");
        return;
    }
    
    [params setObject:_name forKey:FOS_KEY_NAME];
    [params setObject:_cardNo forKey:FOS_KEY_CADR_NO];

    [params setObject:FOS_SERVER forKey:FOS_KEY_SERVER];
    [params setObject:[NSNumber numberWithInt:EFace] forKey:FOS_KEY_AUTH_TYPE];
    [params setObject:[UIColor clearColor] forKey:FOS_KEY_FACE_OBJECT_COLOR];

    [params setObject:kHCSdkType forKey:FOS_KEY_SDK_TYPE];
    [params setObject:kHCLicense forKey:FOS_KEY_SDK_LICENSE];
    [params setObject:kHCBundleID forKey:FOS_KEY_LICENSE_BUNDLEID];


    [params setObject:kMemberId forKey:FOS_KEY_MEMBER_ID];
    [params setObject:kTerminalId forKey:FOS_KEY_TERMINAL_ID];
    [params setObject:kCerPasswd forKey:FOS_KEY_CER_PASSWORD];
    [params setObject:[self currentTimeForStringType:0] forKey:FOS_KEY_TRADE_DATE];
    [params setObject:[self getNowTimeStamp] forKey:FOS_KEY_TRANS_ID];

    NSMutableDictionary *optDict = [[NSMutableDictionary alloc] init];
    // 是否进行后端活体检测 true进行活体检测，false不进行活体检测
    [optDict setObject:@"true" forKey:@"alivedet"];
    // 是否返照片，photo，返照片，noPhoto，不返照片
    [optDict setObject:@"noPhoto" forKey:@"is_photo"];
    [optDict setObject:@"true" forKey:@"pre_deal"];
    if (optDict.count > 0) {
        NSString *optStr = [self convertToJsonData:optDict];
        [params setObject:optStr forKey:FOS_KEY_OPT_PARAM];
    }

    CGFloat pre_scale = 0.7;
    if (self.view.frame.size.height >= 812) {
        pre_scale = 0.8;
    }
    [params setObject:[NSNumber numberWithFloat:pre_scale] forKey:FOS_CAMERA_PREVIEWLAYER_SCALE];

    if (_authenticator) {
        _authenticator = nil;
    }

    _authenticator = [[FOSAuthenticator alloc] initWithParams:params preview:self.view videoSession:_cachedSession];
    if (![_cachedSession isEqual:[_authenticator videoSession]]) {
        _cachedSession = [_authenticator videoSession];
    }

    __block FOSAuthenticator *authenticator = _authenticator;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
        id result = [authenticator prepare];
        if (result == nil) {
            dispatch_async(dispatch_get_main_queue(), ^() {

            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^() {
                authenticator = nil;
                NSLog(@"prepare error: %@", result);
                if ([result isKindOfClass:[NSError class]]) {
                    NSError *error = result;
                    NSDictionary *dict = error.userInfo;
                    NSString *msg = [dict objectForKey:@"msg"];
                    NSString *str = @"";
                    if (msg.length > 0) {
                        str = [NSString stringWithFormat:@"发生错误：%@\n code : %ld", msg,(long)error.code];
                    }else {
                        str = [NSString stringWithFormat:@"发生错误: %@\n code : %ld\n",[error localizedDescription],(long)error.code];
                    }
                    NSLog(@"发生错误(%@)",str);

                } else {
                    NSString *msg = [result objectForKey:@"msg"];
                    int code = [[result objectForKey:@"code"] intValue];
                    NSLog(@"发生错误(%@)",[NSString stringWithFormat:@"发生错误：%@\n code : %d", msg,code]);

                }
            });
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^() {
            [authenticator startWorking];
            authenticator.delegate = self;
            authenticator = nil;
        });
    });
}

#pragma mark - Public Action

- (void)startMontionDetect{
    
    if (_motionManager) {
        [self stopMotionDetect];
    }
    
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 1;
    }
    [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        if (!error) {
            [self outputAccelertionData:accelerometerData.acceleration];
        }else{
            NSLog(@"motion manger error :%@", error);
        }
    }];
}

- (void)outputAccelertionData:(CMAcceleration)acceleration{
    
    if (acceleration.y <= -0.95) {
//        NSLog(@"竖直方向");
        _isPortrait = YES;
    }else {
        _isPortrait = NO;
    }
}

- (void)stopMotionDetect {
    if (_motionManager) {
        [_motionManager stopAccelerometerUpdates];
        _motionManager = nil;
    }
}


#pragma mark - Private Action

/// 获取当前时间(订单时间)
- (NSString *)currentTimeForStringType:(NSInteger)type {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (type == 1) {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }else {
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
    }
    NSString *time = [formatter stringFromDate:[NSDate date]];
    return time;
}

// 获取当前时间戳(订单号)
- (NSString *)getNowTimeStamp{
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timeStamp = [NSString stringWithFormat:@"%.f",interval];
    return timeStamp ;
    
}

// dict to json
- (NSString *)convertToJsonData:(NSDictionary *)dict{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"dict to data happen error %@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}


- (BOOL)checkCameraPermission:(BOOL)block {
    __block BOOL hasCameraPermission = YES;
    NSString *mediaType = AVMediaTypeVideo;
    dispatch_semaphore_t waitCameraPermission = dispatch_semaphore_create(0);
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        hasCameraPermission = granted;
        dispatch_semaphore_signal(waitCameraPermission);
    }];
    if (block) {
        dispatch_semaphore_wait(waitCameraPermission, DISPATCH_TIME_FOREVER);
    }
    if (!hasCameraPermission) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"无法使用相机"
                                                                       message:@"没有相机访问权限"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction * action) {}]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    return hasCameraPermission;
}

- (void)alertTitle:(NSString *)title message:(NSString *)message type:(NSInteger)type{
    __weak typeof (self)weakSelf = self;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * action) {
                                     
                                                [weakSelf.navigationController popViewControllerAnimated:YES];
                                            }]];
    if (type == 1) {
        [alert addAction:[UIAlertAction actionWithTitle:@"再试一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [weakSelf startDetect];
            
        }]];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - FOSAuthenticator Delegate

- (void)authenticatorDidStartWorking:(FOSAuthenticator *)authenticator {
    _startDetectTime = CACurrentMediaTime();
}

- (void)authenticator:(FOSAuthenticator *)authenticator faceInfo:(NSDictionary *)faceInfo {
    
    // 超时判断
    NSInteger delayInSeconds = 10;
    CFTimeInterval detectTime = CACurrentMediaTime() - _startDetectTime;
    if (detectTime > delayInSeconds) {
        
        if (_finished || _isPop || _isNotActivity) {
            return;
        }
        _overTime = YES;
        [_authenticator cancel];
        [self alertTitle:@"发生错误" message:@"操作超时" type:1];
    }
    
    int detectResult = [[faceInfo objectForKey:@"detect_result"] intValue];
    
    
    if (!_isPortrait) {
        self.hintLabel.text = @"请竖直手机";
        return;
    }
    
    
    BOOL large = [[faceInfo objectForKey:@"fos_large"] boolValue];
    BOOL small = [[faceInfo objectForKey:@"fos_small"] boolValue];
    BOOL dark = [[faceInfo objectForKey:@"fos_dark"] boolValue];
    BOOL bright = [[faceInfo objectForKey:@"fos_bright"] boolValue];
    
    if(!dark){
        self.hintLabel.text = @"光线不足";
    }else if(!bright){
        self.hintLabel.text = @"光线过强";
    }else if (!large) {
        self.hintLabel.text = @"请远离一点";
    } else if(!small){
        self.hintLabel.text = @"请靠近一点";
    } else {
        self.hintLabel.text = @"请将人脸移入框内";
    }
    
    // 检测阶段关闭竖直
    [self stopMotionDetect];
    NSLog(@"检测结果---%d",detectResult);
    if (detectResult == 0) {
        _finished = YES;
        [_authenticator finishWorking];
    }
}

- (void)authenticatorDidEndCollecting:(FOSAuthenticator *)authenticator {
    NSLog(@"authenticatorDidEndCollecting ");
    self.hintLabel.text = @"数据发送中...";
    
    if (_isPop || _overTime || _isNotActivity) {
        return;
    }
    
}

- (void)authenticator:(FOSAuthenticator *)authenticator collectedImages:(NSArray *)images {
    for (NSData *image in images) {
        NSLog(@"<<<image: %ld", (long)[image length]);
        //        UIImage *uiimage = [UIImage imageWithData:image];
        //        UIImageWriteToSavedPhotosAlbum(uiimage, self, nil, nil);
    }
    
}

- (void)authenticator:(FOSAuthenticator *)authenticator error:(NSError *)error {
    //    __weak typeof (self)WeakSelf = self;
    
    
    
    error = nil;
}

- (void)authenticator:(FOSAuthenticator *)authenticator result:(NSDictionary *)result {
    self.hintLabel.text = @"";
    NSError *error = [result objectForKey:@"error"];
    if (error) {
        
        if (error.code == FOS_ERROR_CONNECTION_TIMED_OUT) {
            // TODO 网络连接超时
        } else if (error.code == FOS_ERROR_CANNOT_CONNECT_TO_HOST) {
            // TODO 无法连接到服务器
        } else if (error.code == FOS_ERROR_CONNECTION_LOST) {
            // TODO 网络连接丢失
        } else {
            
        }
        
        return;
    }
    
    if (_isPop || _overTime || _isNotActivity) {
        return;
    }
    
//    __weak typeof (self)WeakSelf = self;

    NSDictionary *dict = [result objectForKey:@"parsedResults"];
    BOOL success = [[dict objectForKey:@"success"] boolValue];
    NSDictionary *data = [dict objectForKey:@"data"];
    NSString *code = [data objectForKey:@"code"];
    NSString *desc = [data objectForKey:@"desc"];
    if (success && [code isEqualToString:@"0"]) {
        [self alertTitle:@"" message:desc type:0];
    } else {
        NSString *msg;
        NSString *errorMsg = [dict objectForKey:@"errorMsg"];
        if (errorMsg.length > 0) {
            msg = errorMsg;
        } else {
            msg = desc;
        }
        [self alertTitle:@"" message:msg type:1];
    }

}

#pragma mark - Getter & Setter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView sizeToFit];
    }
    return _imageView;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.textColor = [UIColor redColor];
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.font = [UIFont systemFontOfSize:20];
        
    }
    return _hintLabel;
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

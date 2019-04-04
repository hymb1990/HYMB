//
//  SSLVC.m
//  HYMB
//
//  Created by sgft on 2018/9/11.
//  Copyright © 2018年 hymb. All rights reserved.
//

#import "SSLVC.h"

@interface SSLVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@end

@implementation SSLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    
    //请求地址
    NSString *url =  [NSString stringWithFormat:@"%@%@", GZYPT_Base_Url, GZYPT_accountlogin_login];
    //请求参数
    NSDictionary *parameters = @{
                                 @"userType":@"1",
                                 @"loginName":@"15011144605",
                                 @"password":@"qwer1234"
                                 };
    
    
    [[NetworkService sharedNetworkService] postRequestWithTarget:self url:url parameters:parameters showHud:YES block:^(id responseObject, NSError *error) {
        // 请求成功
        if([responseObject[@"code"] isEqualToString:@"OK"]) {
            [Util showMessageWithView:self.view Title:@"登录成功" Image:nil HideAfter:2];
            //存储登录状态为Yes
            [Util saveInfoObject:@"yes" forKey:@"loginState"];
            //存储登录人类型1为个人，2为企业
            [Util saveInfoObject:parameters[@"userType"] forKey:@"userType"];
            //存储用户名
            [Util saveInfoObject:parameters[@"loginName"] forKey:@"loginName"];
            //存储密码
            [Util saveInfoObject:parameters[@"password"] forKey:@"password"];
            
            if (![Util isNullWithStr:responseObject[@"data"][@"userId"]]) {
                //存储用户Id
                [Util saveInfoObject:responseObject[@"data"][@"userId"] forKey:@"userId"];
            }else {
                
            }
            
            if (![Util isNullWithStr:responseObject[@"data"][@"token"]]) {
                //存储token
                [Util saveInfoObject:responseObject[@"data"][@"token"] forKey:@"token"];
            }else {
                
            }
        }
    }];
    
}


- (IBAction)logoutAction:(id)sender {
    
    if (![Util getInfoObjectForKey:@"token"]) {
        [Util showMessageWithView:self.view Title:@"未登录" Image:nil HideAfter:2];
        return;
    }
    
    //请求地址
    NSString *url = [NSString stringWithFormat:@"%@%@", GZYPT_Base_Url, GZYPT_userrealname_logOut];
    //请求参数
    NSDictionary *parameters = @{@"token":[Util getInfoObjectForKey:@"token"]};
    
    
    [[NetworkService sharedNetworkService] getRequestWithTarget:self url:url parameters:parameters showHud:YES block:^(id responseObject, NSError *error) {
        // 请求成功
        if([responseObject[@"code"] isEqualToString:@"OK"]) {
            [Util showMessageWithView:self.view Title:@"退出成功" Image:nil HideAfter:2];
            //删除登录状态
            [Util removeInfoObjectForKey:@"loginState"];
            //删除登录人类型
            [Util removeInfoObjectForKey:@"userType"];
            //删除loginName
            [Util removeInfoObjectForKey:@"loginName"];
            //删除password
            [Util removeInfoObjectForKey:@"password"];
            //删除token
            [Util removeInfoObjectForKey:@"token"];
            //删除userId
            [Util removeInfoObjectForKey:@"userId"];
        }
    }];
    
}

- (IBAction)upLoadHeader:(id)sender {
    
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//照相机
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"本地相簿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//本地相簿
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheetController addAction:action1];
    [actionSheetController addAction:action2];
    [actionSheetController addAction:cancelAction];
    [self presentViewController:actionSheetController animated:YES completion:nil];
}



#pragma mark - UIImagePickerController Delegate
//完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        
#pragma mark -- 上传头像
        [self uploadHeaderImage:image];
        
    }else {
        [Util showMessageWithView:self.view Title:@"所选非图片类型" Image:nil HideAfter:2];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 上传头像
- (void)uploadHeaderImage:(UIImage *)image {
    
    if (!image) {
        [Util showMessageWithView:self.view Title:@"请选择头像" Image:nil HideAfter:1];
        return;
    }
    
    image = [Util imageCompressWithSimple:image];
    NSData *data = [Util compressOriginalImage:image toMaxDataSizeKBytes:500.0];
    
    
    AFHTTPSessionManager *manager = [ AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:100.0];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    //设置https
    if (openHttpsSSL) {
        [SSLManager openSSLCertificatesWith:manager requesType:@"51"];
    }
    [manager.requestSerializer setValue:OpenId forHTTPHeaderField:@"openId"];
    [manager.requestSerializer setValue:Secret forHTTPHeaderField:@"secret"];
    
    //设置请求头
    [manager.requestSerializer setValue:[Util getInfoObjectForKey:@"token"] forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:[Util getInfoObjectForKey:@"userId"] forHTTPHeaderField:@"userId"];
    
    [manager POST:GZYPT_Upload_Url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (YES) {
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            
            /*
             此方法参数
             1. 要上传的[二进制数据]
             2. 对应网站上[upload.php中]处理文件的[字段"file"]
             3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
             */
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MYLog(@"%@", GZYPT_Upload_Url);
        MYLog(@"%@", @"");
        MYLog(@"%@", responseObject);
        
        //上传成功
        if ([responseObject[@"code"]isEqualToString:@"OK"]) {
            
            NSString *path = responseObject[@"data"];
            NSString *imagePath = [NSString stringWithFormat:@"%@%@?viewType=INLINE", GZYPT_Upload_Url, path];
            [self.headerImage sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed|SDWebImageAllowInvalidSSLCertificates completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYLog(@"%@", GZYPT_Upload_Url);
        MYLog(@"%@", @"");
        MYLog(@"%@", error);
    }];
    
    
    
    
}



@end

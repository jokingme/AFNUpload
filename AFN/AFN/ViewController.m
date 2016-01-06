//
//  ViewController.m
//  AFN
//
//  Created by Fankai on 16/1/5.
//  Copyright © 2016年 Joker. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "MyButton.h"


@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *start;
@property (nonatomic, strong) UIButton *stop;
@property (nonatomic, strong) UIButton *resume;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self upDataImg];

}

- (void)upDataImg
{
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 50, 270, 50)];
    [self.view addSubview:_progressView];
    _progressView.progress = 0.0;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 270, 400)];
    [self.view addSubview:_imageView];
    
    _start = [MyButton buttonWithFrame:CGRectMake(150, 100, 75, 50) Title:@"上传" action:@selector(starttask) target:self];
    _stop = [MyButton buttonWithFrame:CGRectMake(50, 100, 75, 50) Title:@"暂停" action:@selector(stoptask) target:self];
    _resume = [MyButton buttonWithFrame:CGRectMake(250, 100, 75, 50)  Title:@"继续" action:@selector(resumetask) target:self];
    
    [self.view addSubview:_start];[self.view addSubview:_stop];[self.view addSubview:_resume];
}

//- (UIButton *)buttonWithFrame:(CGRect)frame Title:(NSString *)title action:(SEL)action
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = frame;
//    [button setTitle:title forState:UIControlStateNormal];
//    //    [button setTitle:otherTitle forState:UIControlStateDisabled];
//    //    [button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
//    //    [button setBackgroundImage:disabledButtonBackgroundImage forState:UIControlStateDisabled];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [button setBackgroundColor:[UIColor purpleColor]];
//    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    //    button.enabled = NO;
//    
//    return button;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //UIImagePickerControllerSourceTypePhotoLibrary,
    //UIImagePickerControllerSourceTypeCamera,
    //UIImagePickerControllerSourceTypeSavedPhotosAlbum
    //创建UIImagePickerController
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    //创建UIAlertController
    UIAlertController *ccc = [UIAlertController alertControllerWithTitle:@"haha" message:@"hehe" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *add = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    UIAlertAction *ade = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"删除");
    }];
    UIAlertAction *adf = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:ipc animated:YES completion:nil];
        NSLog(@"相册");
    }];
    UIAlertAction *acf = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:nil];
        NSLog(@"拍照");
    }];
    
    [ccc addAction:add];
    [ccc addAction:ade];
    [ccc addAction:adf];
    [ccc addAction:acf];
    
    [self presentViewController:ccc animated:YES completion:^{
        
    }];

}

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获得image
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    NSLog(@"%@",image);
}

#pragma mark - ----------------- ----------------- ----------------- ----------------- ----------------

- (void)starttask
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"hehe"] = @"hahahha";
    
    NSString *url = @"http://afnetworking.sinaapp.com/upload2server.json";
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *fileData = UIImagePNGRepresentation(self.imageView.image);
        [formData appendPartWithFileData:fileData name:@"image" fileName:@"hahah.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) { //进度条
        self.progressView.progress = uploadProgress.fractionCompleted;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"successed");
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed");
    }];
  
}

- (void)stoptask
{
    NSLog(@"服务器不支持");
}

- (void)resumetask
{
    NSLog(@"服务器不支持");
}

//- (void)actionSheet
//{
//    
//    UIAlertController *ccc = [UIAlertController alertControllerWithTitle:@"haha" message:@"hehe" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *add = [UIAlertAction actionWithTitle:@"quxiao" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"quxiao");
//    }];
//    UIAlertAction *ade = [UIAlertAction actionWithTitle:@"lllxiao" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"lllxiao");
//    }];
//    UIAlertAction *adf = [UIAlertAction actionWithTitle:@"kaishi" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"kaishi");
//    }];
//    
//    [ccc addAction:add];
//    [ccc addAction:ade];
//    [ccc addAction:adf];
//    
//    [self presentViewController:ccc animated:YES completion:^{
//        
//    }];
//    
//}

@end

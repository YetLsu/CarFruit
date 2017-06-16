//
//  NFTakePhotoViewController.m
//  guonongda
//
//  Created by guest on 16/10/11.
//  Copyright © 2016年 聂凡. All rights reserved.
//

#import "NFTakePhotoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface NFTakePhotoViewController ()
//执行输入和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureSession *session;
//输入流
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
//照片输出流对象
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
//预览图层，显示照相机拍摄到的画面
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
//设备
@property (nonatomic, strong) AVCaptureDevice *device;

//展示拍照获取的照片
@property (nonatomic, strong) UIImageView *imageShowView;

//闪光灯按钮
@property (nonatomic, strong) UIButton *lightButton;
//前后镜头切换按钮
@property (nonatomic, strong) UIButton *toggleButton;
//拍照按钮
@property (nonatomic, strong) UIButton *shutterButton;
//拍照取消／重新拍摄按钮
@property (nonatomic, strong) UIButton *cancleButton;
//使用照片按钮
@property (nonatomic, strong) UIButton *useImageButton;


//放置预览图层的View
//@property (nonatomic, strong) UIView *cameraShowView;
@end

@implementation NFTakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSession];
    
    [self setupContent];
}

- (void)setupSession{
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _device = [self frontCamera];
    _session = [[AVCaptureSession alloc] init];
    _deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:nil];
    
    _stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    if ([self.session canAddInput:self.deviceInput]) {
        [self.session addInput:self.deviceInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _previewLayer.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:_previewLayer];
    
    [_session startRunning];
    if ([_device lockForConfiguration:nil]) {
        if ([_device isFlashModeSupported:AVCaptureFlashModeOff]) {
            [_device setFlashMode:AVCaptureFlashModeOff];
        }
        [_device unlockForConfiguration];
    }
    
}


- (void)setupContent{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    imageView.hidden = YES;
    self.imageShowView = imageView;
    [self.view addSubview:imageView];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topView];
//    闪光灯
    _lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _lightButton.frame = CGRectMake(15, 20 + 2, 60, 40);
    [_lightButton setImage:[UIImage imageNamed:@"camro_lightoff"] forState:UIControlStateNormal];
    [_lightButton addTarget:self action:@selector(changeFlashLightModel) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_lightButton];
//    前置摄像头
    _toggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _toggleButton.frame = CGRectMake(kScreenWidth - 60 - 15, 20 + 2, 60, 40);
    [_toggleButton setImage:[UIImage imageNamed:@"camro_change"] forState:UIControlStateNormal];
    [_toggleButton addTarget:self action:@selector(toggleCamera) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_toggleButton];

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    
//    拍照按钮
    _shutterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shutterButton.frame = CGRectMake((kScreenWidth - 80)/2, 10, 80, 80);
    [_shutterButton setImage:[UIImage imageNamed:@"camro_take"] forState:UIControlStateNormal];
    [_shutterButton setImage:[UIImage imageNamed:@"camro_take2"] forState:UIControlStateHighlighted];
    [_shutterButton addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_shutterButton];
//    取消／重新拍摄
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleButton.frame = CGRectMake(15, 20, 80, 60);
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancleButton addTarget:self action:@selector(cancleAciton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_cancleButton];
//    使用照片
    _useImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _useImageButton.frame = CGRectMake(kScreenWidth - 80 - 15, 20, 80, 60);
    [_useImageButton setTitle:@"使用照片" forState:UIControlStateNormal];
    _useImageButton.hidden = YES;
    _useImageButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_useImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_useImageButton addTarget:self action:@selector(useImageAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_useImageButton];
}

#pragma mark - 使用照片
- (void)useImageAction{
    NSLog(@"使用照片");

}


#pragma mark - 取消和重新拍摄
- (void)cancleAciton:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString: @"取消"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if ([button.titleLabel.text isEqualToString:@"重新拍摄"]){
//        重新拍摄
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.imageShowView setImage:nil];
        self.imageShowView.hidden = YES;
        _shutterButton.hidden = NO;
        _useImageButton.hidden = YES;
        [self.session startRunning];
    }

}


#pragma mark - 拍照方法
- (void)shutterCamera
{
    AVCaptureConnection *videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        return;
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:imageData];
        [_cancleButton setTitle:@"重新拍摄" forState:UIControlStateNormal];
        _useImageButton.hidden = NO;
        _shutterButton.hidden = YES;
        self.imageShowView.hidden = NO;
        self.imageShowView.image = image;
        [self.session stopRunning];
    }];
}

#pragma mark - 改变闪光灯模式
- (void)changeFlashLightModel{
    if ([_device lockForConfiguration:nil]) {
        if (_device.flashMode == AVCaptureFlashModeOff) {
            [_lightButton setImage:[UIImage imageNamed:@"camro_lighton"] forState:UIControlStateNormal];
            _device.flashMode = AVCaptureFlashModeOn;
        }else if(_device.flashMode == AVCaptureFlashModeOn){
            [_lightButton setImage:[UIImage imageNamed:@"camro_lightauto"] forState:UIControlStateNormal];
            _device.flashMode = AVCaptureFlashModeAuto;
        }else{
            [_lightButton setImage:[UIImage imageNamed:@"camro_lightoff"] forState:UIControlStateNormal];
            _device.flashMode = AVCaptureFlashModeOff;
            
        }
        [_device unlockForConfiguration];
    }
    
}

#pragma mark - 切换镜头方法
- (void)toggleCamera{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"cube";
        
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [[_deviceInput device] position];
        if (position == AVCaptureDevicePositionBack) {
            newVideoInput = [AVCaptureDeviceInput deviceInputWithDevice:[self frontCamera] error:&error];
            animation.subtype = kCATransitionFromLeft;
        }else if (position == AVCaptureDevicePositionFront){
            newVideoInput = [AVCaptureDeviceInput deviceInputWithDevice:[self backCamera] error:&error];
            animation.subtype = kCATransitionFromRight;
            
        }else{
            return;
        }
        [self.previewLayer addAnimation:animation forKey:nil];
        if (newVideoInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.deviceInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                self.deviceInput = newVideoInput;
            } else {
                [self.session addInput:self.deviceInput];
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }

    }

}

//获取前后摄像头对象的方法
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            
            return device;
        }
    }
    return nil;
}
//前摄像头
- (AVCaptureDevice *)frontCamera{
    
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}
//后摄像头
- (AVCaptureDevice *)backCamera{
    
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

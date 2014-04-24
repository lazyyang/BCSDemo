//
//  ZYViewController.m
//  BCSDemo
//
//  Created by SMIT on 14-4-15.
//  Copyright (c) 2014年 SMIT. All rights reserved.
//

#import "ZYViewController.h"
#import "NSString+URLSignature.h"
#import "NSString+URLEncoding.h"
#import <AFNetworking/AFNetworking.h>
#import "ZYBCSCloudManager.h"



@interface ZYViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong,nonatomic) ZYBCSCloudManager *cloudManager;

@end

@implementation ZYViewController

- (void)dealloc
{
    self.cloudManager = nil;
}

- (void)btnClicked:(UIButton *)button
{
    NSLog(@"Clicked");
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置拍照后的照片可以被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"void");

    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int mydate = (long long int)time;
    [self.cloudManager uploadDataToBCSWithData:imageData WithFileName:[NSString stringWithFormat:@"%lld.png",mydate] WithFinishedBlock:^{
        NSLog(@"success");
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"上传成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    } WithFailedBlock:^{
        NSLog(@"failed");
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"上传失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cloudManager = [[ZYBCSCloudManager alloc]init];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"打开相册" forState:UIControlStateNormal];
    btn.bounds = CGRectMake(0, 0, 100, 50);
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

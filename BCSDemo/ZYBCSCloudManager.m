//
//  ZYBCSCloudManager.m
//  BCSDemo
//
//  Created by 杨争 on 4/15/14.
//  Copyright (c) 2014 SMIT. All rights reserved.
//

#import "ZYBCSCloudManager.h"
#import "NSString+URLSignature.h"
#import "NSString+URLEncoding.h"
#import <AFNetworking/AFNetworking.h>


@implementation ZYBCSCloudManager

- (void)uploadDataToBCSWithData:(NSData *)aData WithFileName:(NSString *)aFileName WithFinishedBlock:(UpdateFinishedBlockd)aFinishedBlock WithFailedBlock:(UpdateFailedBlocked)aFailedBlock
{
    NSString *flag = [NSString stringWithFormat:@"MBO\nMethod=POST\nBucket=dafdadfda\nObject=/%@\n",aFileName];
    //@"MBO\nMethod=POST\nBucket=dafdadfda\nObject=/u5.jpeg\n";
    NSString *signature = [flag hmac_sha1:SecretKey text:flag];
    NSLog(@"%@",signature.urlEncodeString);
    //@"MBO";
    
    NSString *updateURL = [NSString stringWithFormat:@"http://bcs.duapp.com/dafdadfda/%@?sign=MBO:%@:%@",aFileName,APIKey,signature.urlEncodeString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:updateURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData :aData name:aFileName fileName:aFileName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        aFinishedBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        aFailedBlock();
    }];

}

@end

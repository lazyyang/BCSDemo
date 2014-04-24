//
//  NSString+URLSignature.h
//  BCSDemo
//
//  Created by SMIT on 14-4-15.
//  Copyright (c) 2014年 SMIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLSignature)
- (NSString *)hmac_sha1:(NSString *)key text:(NSString *)text;
@end

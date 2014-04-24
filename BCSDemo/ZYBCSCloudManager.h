//
//  ZYBCSCloudManager.h
//  BCSDemo
//
//  Created by 杨争 on 4/15/14.
//  Copyright (c) 2014 SMIT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^UpdateFinishedBlockd)(void);
typedef void(^UpdateFailedBlocked)(void);


@interface ZYBCSCloudManager : NSObject

- (void)uploadDataToBCSWithData:(NSData *)aData WithFileName:(NSString *)aFileName WithFinishedBlock:(UpdateFinishedBlockd)aFinishedBlock WithFailedBlock:(UpdateFailedBlocked)aFailedBlock;

@end

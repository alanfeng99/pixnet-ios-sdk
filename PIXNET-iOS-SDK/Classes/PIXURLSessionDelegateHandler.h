//
//  PIXURLSessionDelegateHandler.h
//  PIXNET-iOS-SDK
//
//  Created by Dolphin Su on 5/20/14.
//  Copyright (c) 2014 Dolphin Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PIXAPIHandler.h"

@interface PIXURLSessionDelegateHandler : NSObject<NSURLSessionDelegate, NSURLSessionDataDelegate>
-(instancetype)initWithFilePath:(NSString *)filePath completion:(PIXHandlerCompletion)completion;
@end

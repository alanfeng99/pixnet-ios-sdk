//
//  PIXURLSessionDelegateHandler.m
//  PIXNET-iOS-SDK
//
//  Created by Dolphin Su on 5/20/14.
//  Copyright (c) 2014 Dolphin Su. All rights reserved.
//


#import "PIXURLSessionDelegateHandler.h"
#import "NSError+PIXCategory.h"

@interface PIXURLSessionDelegateHandler();
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) PIXHandlerCompletion completion;
@end


@implementation PIXURLSessionDelegateHandler
-(instancetype)initWithFilePath:(NSString *)filePath completion:(PIXHandlerCompletion)completion{
    self = [super init];
    if (self) {
        _filePath = filePath;
        _completion = completion;
    }
    return self;
}

-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
    NSLog(@"URLSession error: %@", error);
    _completion(NO, nil, error);
}
-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
//    SecTrustRef trustRef = challenge.protectionSpace.serverTrust;
//    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:trustRef]);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}
-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    NSLog(@"URLSession did finished: %@", session);
    _completion(YES, nil, nil);
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    NSLog(@"totalBytesSent: %lli, totalBytesExpectedToSend: %lli", totalBytesSent, totalBytesExpectedToSend);
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSError *jsonError;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    if (jsonError) {
        _completion(NO, nil, jsonError);
    } else {
        if ([result[@"error"] intValue] != 0) {
            NSLog(@"server response error: %@", result);
            _completion(NO, nil, [NSError PIXErrorWithServerResponse:result]);
        } else {
            _completion(YES, result, nil);
        }
    }
}
@end

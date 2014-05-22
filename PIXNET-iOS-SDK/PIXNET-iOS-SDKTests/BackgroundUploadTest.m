//
//  BackgroundUploadTest.m
//  PIXNET-iOS-SDK
//
//  Created by Dolphin Su on 5/20/14.
//  Copyright (c) 2014 Dolphin Su. All rights reserved.
//
#import "PIXNETSDK.h"
#import "PIXTestObjectGenerator.h"
#import "UserForTest.h"
#import <XCTest/XCTest.h>

@interface BackgroundUploadTest : XCTestCase
@property (nonatomic, strong) UserForTest *testUser;

@end

@implementation BackgroundUploadTest

- (void)setUp
{
    [super setUp];
    _testUser = [[UserForTest alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    [PIXNETSDK setConsumerKey:_testUser.consumerKey consumerSecret:_testUser.consumerSecret];
    __block BOOL done = NO;
    
    [PIXNETSDK logout];
    
    __block BOOL authed = NO;
    //登入
    [PIXNETSDK authByXauthWithUserName:_testUser.userName userPassword:_testUser.userPassword requestCompletion:^(BOOL succeed, id result, NSError *error) {
        done = YES;
        if (succeed) {
            NSLog(@"auth succeed!");
            authed = YES;
        } else {
            XCTFail(@"auth failed: %@", error);
        }
        
    }];
    while (!done) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
//    UIImage *image = [UIImage imageNamed:@"pixFox.jpg"];
//    NSData *data = UIImageJPEGRepresentation(image, 0.7);
//    NSDictionary *params = @{<#key#>: <#object, ...#>}
//    [[PIXAPIHandler new] callAPI:@"album/elements" httpMethod:@"POST" shouldAuth:YES uploadData:data parameters:params requestCompletion:^(BOOL succeed, id result, NSError *errorMessage) {
//        if (succeed) {
//            [self succeedHandleWithData:result completion:completion];
//        } else {
//            completion(NO, nil, errorMessage);
//        }
//    }];
}
@end

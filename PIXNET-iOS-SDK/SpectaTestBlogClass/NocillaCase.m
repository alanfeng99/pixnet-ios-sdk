//
//  NocillaCase.m
//  PIXNET-iOS-SDK
//
//  Created by dennis on 2015/10/5.
//  Copyright © 2015年 Dolphin Su. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "Nocilla.h"
#import "PIXBlog.h"
#import "UserForTest.h"

SpecBegin(Nocilla)
__block UserForTest *userForTest = nil;
describe(@"For not Auth", ^{
    
     beforeAll(^{
         userForTest = [[UserForTest alloc] init];
         [[LSNocilla sharedInstance] start];
     });
     
     afterAll(^{
         [[LSNocilla sharedInstance] stop];
     });
     
     afterEach(^{
         [[LSNocilla sharedInstance] clearStubs];
     });
    
    
    //列出部落格資訊
    it(@"blog info return error=int0", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":0}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getBlogInformationWithUserName:userForTest.userName completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).to.beTruthy();
                expect(result).notTo.beNil();
                done();
                
            }];
            
        });
    });
    it(@"blog info return error=char0", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":\"0\"}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getBlogInformationWithUserName:userForTest.userName completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).to.beTruthy();
                expect(result).notTo.beNil();
                done();
                
            }];
            
        });
    });
    it(@"blog info return error=char", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":\"any string\"}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getBlogInformationWithUserName:userForTest.userName completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
                
            }];
            
        });
    });
    it(@"blog info return error=int", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":100}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getBlogInformationWithUserName:userForTest.userName completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
                
            }];
            
        });
    });
    it(@"blog info return error=char100", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":\"100\"}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getBlogInformationWithUserName:userForTest.userName completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
                
            }];
            
        });
    });
    it(@"blog info return statusCode=403", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(403).withBody(@"{\"error\":\"100\"}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getBlogInformationWithUserName:userForTest.userName completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
                
            }];
            
        });
    });
    //列出部落格熱門及相關標籤
    it(@"blog hot tags", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":\"100\"}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getSuggestedTagsWithUser:userForTest.userName completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
                
            }];
            
        });
    });
    
    it(@"blog no 'error' in json", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"tags\":\"100\"}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getSuggestedTagsWithUser:@"&%$^&#" completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
                
            }];
            
        });
    });
    
    //列出部落格全站分類
    it(@"blog when bool is nil", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":0}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getSiteCategoriesForBlogWithGroups:nil isIncludeThumbs:nil completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).to.beTruthy();
                expect(result).notTo.beNil();
                done();
            }];
        });
    });
    it(@"blog return json =nil", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getSiteCategoriesForBlogWithGroups:nil isIncludeThumbs:nil completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
            }];
        });
    });
    
    
    //列出所有部落格個人分類
    it(@"blog category list more than 10 Categories", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":\"0\"}");
        
        waitUntil(^(DoneCallback done) {
            [[PIXBlog new] getBlogAllArticlesWithUserName:userForTest.userName password:userForTest.userPassword page:100 perpage:1 userCategories:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11"] status:PIXArticleStatusPublic isTop:NO trimUser:YES shouldAuth:NO completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
            }];
        });
    });
    it(@"blog category list int inside", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":\"0\"}");
        
        waitUntil(^(DoneCallback done) {
            [[PIXBlog new] getBlogAllArticlesWithUserName:userForTest.userName password:userForTest.userPassword page:100 perpage:1 userCategories:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @(10)] status:PIXArticleStatusPublic isTop:NO trimUser:YES shouldAuth:NO completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
            }];
        });
    });
    
    //測試Error Codes
    it(@"blog info return error=int0", ^{
        stubRequest(@"GET", @"https://emma.pixnet.cc/blog/*".regex).andReturn(200).withBody(@"{\"error\":1,\"code\":\"3900\"}");
        
        waitUntil(^(DoneCallback done) {
            
            [[PIXBlog new] getBlogInformationWithUserName:userForTest.userName completion:^(BOOL succeed, id result, NSError *error) {
                expect(succeed).notTo.beTruthy();
                expect(result).to.beNil();
                done();
                
            }];
            
        });
    });

});

SpecEnd
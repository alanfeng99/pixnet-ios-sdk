//
//  UserForTest.h
//  PIXNET-iOS-SDK
//
//  Created by Dolphin Su on 4/30/14.
//  Copyright (c) 2014 Dolphin Su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserForTest : NSObject
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPassword;
@property (nonatomic, copy) NSString *consumerKey;
@property (nonatomic, copy) NSString *consumerSecret;
@property (nonatomic, copy) NSString *callbaclURL;
@property (nonatomic, copy) NSArray *friendNames;
@property (nonatomic, copy) NSString *subscriptionUser;
@property (nonatomic, strong) NSArray *blockUsers;
@property (nonatomic, copy) NSString *cellphone;
@property (nonatomic, copy) NSString *privateArticle;
@property (nonatomic, copy) NSString *publicArticle;
@property (nonatomic, copy) NSString *privateComment;
@property (nonatomic, copy) NSString *publicComment;
@end

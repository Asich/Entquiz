//
// Created by Mustafin Askar on 18/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "AuthApi.h"
#import "AFHTTPSessionManager.h"


@implementation AuthApi {}

+ (void)registerWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure {
    [self POST:@"/register" parameters:@{@"username" : name, @"password" : password} success:success failure:failure];
}

+ (void)loginWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure {
    [self POST:@"/login" parameters:@{@"username" : name, @"password" : password} success:success failure:failure];
}

@end
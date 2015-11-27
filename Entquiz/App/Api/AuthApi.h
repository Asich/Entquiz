//
// Created by Mustafin Askar on 18/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiClient.h"


@interface AuthApi : ApiClient

+ (void)registerWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure;
+ (void)loginWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure;
+ (void)registerPushDeviceToke:(NSString *)deviceToken success:(Success)success failure:(Failure)failure;
+ (void)logout;

@end
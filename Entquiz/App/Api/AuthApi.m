//
// Created by Mustafin Askar on 18/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "AuthApi.h"
#import "AFHTTPSessionManager.h"
#import "User.h"
#import "SecurityTokenManager.h"
#import "Consts.h"


@implementation AuthApi {}

+ (void)registerWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure {
    [self POST:@"/register" parameters:@{@"username" : name, @"password" : password} success:success failure:failure];
}

+ (void)loginWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure {
    [self POST:@"/login" parameters:@{@"username" : name, @"password" : password} success:success failure:failure];
}

+ (void)registerPushDeviceToke:(NSString *)deviceToken success:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];

    [self POST:@"/registerDevice" parameters:@{@"deviceId" : deviceToken, @"deviceOS" : @"iOS"} success:success failure:failure];
}


/**
* Logout method removes accessToken from KeyChain
* removes userId and username from userdefaults
* and call completion block
*
* @param userDataClearedCompletion - block that calls in the end
*/
+ (void)logoutCompletionBlock:(void (^)())userDataClearedCompletion {
    [User sharedInstance].accessToken = nil;
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUsernameKey];
    [[SecurityTokenManager sharedManager] removeTokenForUserName:userName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserIdKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUsernameKey];

    if (userDataClearedCompletion) {
        userDataClearedCompletion();
    }
}


@end
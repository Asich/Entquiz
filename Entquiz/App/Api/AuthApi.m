//
// Created by Mustafin Askar on 18/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "AuthApi.h"
#import "User.h"
#import "SecurityTokenManager.h"
#import "Consts.h"


@implementation AuthApi {}


/**
 * Sign in
 *
 * @param name - user name
 * @param password - user password
 * @param success
 * @param failure
 */
+ (void)registerWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure {
    [self POST:@"/register" parameters:@{@"username" : name, @"password" : password} success:success failure:failure];
}


/**
 * Login
 *
 * @param name - user name
 * @param password - user password
 * @param success
 * @param failure
 */
+ (void)loginWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure {
    [self POST:@"/login" parameters:@{@"username" : name, @"password" : password} success:success failure:failure];
}


/**
* Registers push device token in server link with user in database
*
* @param deviceToken
* @param success
* @param failure
*/
+ (void)registerPushDeviceToken:(NSString *)deviceToken success:(Success)success failure:(Failure)failure {
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
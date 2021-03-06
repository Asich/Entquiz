//
// Created by Mustafin Askar on 18/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiClient.h"


@interface AuthApi : ApiClient


/**
 * Sign in
 *
 * @param name - user name
 * @param password - user password
 * @param success
 * @param failure
 */
+ (void)registerWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure;


/**
 * Login
 *
 * @param name - user name
 * @param password - user password
 * @param success
 * @param failure
 */
+ (void)loginWithName:(NSString *)name andPassword:(NSString *)password success:(Success)success failure:(Failure)failure;


/**
* Registers push device token in server link with user in database
*
* @param deviceToken
* @param success
* @param failure
*/
+ (void)registerPushDeviceToken:(NSString *)deviceToken success:(Success)success failure:(Failure)failure;


/**
* Logout method removes accessToken from KeyChain
* removes userId and username from userdefaults
* and call completion block
*
* @param userDataClearedCompletion - block that calls in the end
*/
+ (void)logoutCompletionBlock:(void (^)())userDataClearedCompletion;

@end
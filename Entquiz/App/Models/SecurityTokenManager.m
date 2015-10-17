//
// Created by Mustafin Askar on 26/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "SecurityTokenManager.h"
#import "SSKeychain.h"

#define kService @"askar.Entquiz"

@implementation SecurityTokenManager {}

+ (id)sharedManager {
    static SecurityTokenManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

#pragma mark -

- (void)writeToken:(NSString *)token userName:(NSString *)userName {
    [SSKeychain setPassword:token
                 forService:kService
                    account:userName];
}

- (NSString *)readTokenForUserName:(NSString *)userName {
    return [SSKeychain passwordForService:kService
                           account:userName];
}

@end
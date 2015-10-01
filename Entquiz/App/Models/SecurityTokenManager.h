//
// Created by Mustafin Askar on 26/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SecurityTokenManager : NSObject

+ (id)sharedManager;

- (void)writeToken:(NSString *)token userName:(NSString *)userName;
- (NSString *)readTokenForUserName:(NSString *)userName;

@end
//
// Created by Mustafin Askar on 08/07/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "User.h"


@implementation User {}

+ (instancetype)sharedInstance {
    static User *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[User alloc] init];
    });
    return sharedInstance;
}

@end
//
// Created by Mustafin Askar on 08/07/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *userId;

+ (instancetype)sharedInstance;

@end
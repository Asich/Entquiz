//
// Created by Mustafin Askar on 21/11/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PushNotificationHandler : NSObject

+ (void)handlePushWithUserInfo:(NSDictionary *)userInfo;

@end
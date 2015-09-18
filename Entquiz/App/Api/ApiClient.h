//
//  ApiClient.h
//  Entquiz
//
//  Created by Mustafin Askar on 15/09/2015.
//  Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface ApiClient : AFHTTPRequestOperationManager

typedef void (^Success)(id response);
typedef void (^Failure)(NSInteger code, NSString *message);

+ (AFHTTPRequestOperationManager *)sharedManager;

+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

@end

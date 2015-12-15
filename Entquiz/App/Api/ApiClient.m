//
//  ApiClient.m
//  Entquiz
//
//  Created by Mustafin Askar on 15/09/2015.
//  Copyright (c) 2015 askar. All rights reserved.
//

//#define kAPIBaseURLString @"http://bitvazagrant.kz"
#define kAPIBaseURLString @"http://192.168.1.6:9000"

//#define kLogs NO
#define kLogs YES


#import "ApiClient.h"
#import "NSObject+Json.h"

@implementation ApiClient

+ (AFHTTPRequestOperationManager *)sharedManager {
    static dispatch_once_t once;
    static AFHTTPRequestOperationManager *sharedManager;
    dispatch_once(&once, ^ {
        sharedManager = [AFHTTPRequestOperationManager manager];
        sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return sharedManager;
}

#pragma mark - POST

+ (void)POST:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    if (kLogs) {
        NSLog(@"---- ---- ---- ---- ---- -------- ---- ---- ----");
        NSLog(@"path: %@", path);
        NSLog(@"parameters: %@", [parameters JSONRepresentation]);
    }

    [[self sharedManager] POST:[self apiUrlWithPath:path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (kLogs) {
            NSLog(@"response: %@", [responseObject JSONRepresentation]);
            NSLog(@"---- ---- ---- ---- ---- -------- ---- ---- ----");
        }
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (kLogs) {
            NSLog(@"response: %@", error.description);
            NSLog(@"---- ---- ---- ---- ---- -------- ---- ---- ----");
        }
        failure(error.code, error.description);
    }];
}

#pragma mark - GET

+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    if (kLogs) {
        NSLog(@"---- ---- ---- ---- ---- -------- ---- ---- ----");
        NSLog(@"path: %@", path);
        NSLog(@"parameters: %@", [parameters JSONRepresentation]);
    }
    [[self sharedManager] GET:[self apiUrlWithPath:path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (kLogs) {
            NSLog(@"response: %@", [responseObject JSONRepresentation]);
            NSLog(@"---- ---- ---- ---- ---- -------- ---- ---- ----");
        }
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (kLogs) {
            NSLog(@"response: %@", error.description);
            NSLog(@"---- ---- ---- ---- ---- -------- ---- ---- ----");
        }
        failure(error.code, error.description);
    }];
}

#pragma mark -

+ (NSString *)apiUrlWithPath:(NSString *)path {
    NSString *url = [NSString stringWithFormat:@"%@%@", kAPIBaseURLString, path];
    return url;
}


@end

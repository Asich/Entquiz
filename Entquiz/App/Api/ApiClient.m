//
//  ApiClient.m
//  Entquiz
//
//  Created by Mustafin Askar on 15/09/2015.
//  Copyright (c) 2015 askar. All rights reserved.
//

#define kAPIBaseURLString @"http://bitvazagrant.kz"
//#define kAPIBaseURLString @"http://192.168.1.10:9000"


#import "ApiClient.h"

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
    [[self sharedManager] POST:[self apiUrlWithPath:path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.code, error.description);
    }];
}

#pragma mark - GET

+ (void)GET:(NSString *)path parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    [[self sharedManager] GET:[self apiUrlWithPath:path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.code, error.description);
    }];
}

#pragma mark -

+ (NSString *)apiUrlWithPath:(NSString *)path {
    NSString *url = [NSString stringWithFormat:@"%@%@", kAPIBaseURLString, path];
    return url;
}


@end

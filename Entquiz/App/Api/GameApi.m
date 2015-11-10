//
// Created by Mustafin Askar on 08/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "GameApi.h"
#import "User.h"
#import "NSObject+Json.h"


@implementation GameApi {}


/**
*  Start new game or connect to the game
*
*/
+ (void)startWithSuccess:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];

    [self GET:@"/start" parameters:nil success:success failure:failure];
}


/**
*  Get roundData
*
*/
+ (void)submitRoundWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];

    NSLog(@"submitRoundWithParams: %@", [params JSONRepresentationPretyPrinted:YES]);
    [self POST:@"/submitRound" parameters:params success:success failure:failure];
}


/**
*  Submit answers
*
*/
+ (void)getRoundDataWithGameId:(NSNumber *)gameId success:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];

    [self GET:[NSString stringWithFormat:@"/getRoundData/%@", gameId] parameters:nil success:success failure:failure];
}


@end
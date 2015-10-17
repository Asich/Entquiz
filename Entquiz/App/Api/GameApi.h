//
// Created by Mustafin Askar on 08/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiClient.h"


@interface GameApi : ApiClient

/**
*  Start new game or connect to the game
*
*/
+ (void)startWithSuccess:(Success)success failure:(Failure)failure;


/**
*  Get roundData
*
*/
+ (void)getRoundDataWithGameId:(NSNumber *)gameId success:(Success)success failure:(Failure)failure;


/**
*  Submit answers
*
*/
+ (void)submitRoundWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;


@end
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
*  Get roundData use for reload
*
*/
+ (void)getRoundDataWithGameId:(NSNumber *)gameId success:(Success)success failure:(Failure)failure;


/**
*  Submit answers
*
*/
+ (void)submitRoundWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

/**
* Find opponent for game with
*
*/
+ (void)findOpponentWithName:(NSString *)name success:(Success)success failure:(Failure)failure;

/**
* Invite for game with
*
*/
+ (void)inviteOpponentWithOpponentId:(NSNumber *)opponentId success:(Success)success failure:(Failure)failure;

/**
* Accept invite for game
*
*/
+ (void)acceptInviteForGameOpponentId:(NSNumber *)opponentId success:(Success)success failure:(Failure)failure;

/**
*  Reject invite for game
*
*/
+ (void)rejectInviteForGameOpponentId:(NSNumber *)opponentId success:(Success)success failure:(Failure)failure;


@end
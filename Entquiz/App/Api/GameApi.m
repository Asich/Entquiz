//
// Created by Mustafin Askar on 08/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "GameApi.h"
#import "User.h"


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
*  Submit answers
*
*/
+ (void)submitRoundWithParams:(NSDictionary *)params success:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];

    [self POST:@"/submitRound" parameters:params success:success failure:failure];
}


/**
*  Get roundData
*
*/
+ (void)getRoundDataWithGameId:(NSNumber *)gameId success:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];

    [self GET:[NSString stringWithFormat:@"/getRoundData/%@", gameId] parameters:nil success:success failure:failure];
}

/**
* Find opponent
*
*/
+ (void)findOpponentWithName:(NSString *)name success:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];
    [self POST:@"/findOpponent" parameters:@{@"username" : name} success:success failure:failure];
}

/**
* Invite for game
*
*/
+ (void)inviteOpponentWithOpponentId:(NSNumber *)opponentId success:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];
    [self POST:@"/inviteForGame" parameters:@{@"userId" : opponentId} success:success failure:failure];
}

/**
* Accept invite for game
*
*/
+ (void)acceptInviteForGameOpponentId:(NSNumber *)opponentId success:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];
    [self POST:@"/acceptInviteForGame" parameters:@{@"opponentId" : opponentId} success:success failure:failure];
}

/**
*  Reject invite for game
*
*/
+ (void)rejectInviteForGameOpponentId:(NSNumber *)opponentId success:(Success)success failure:(Failure)failure {
    [[self sharedManager].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[User sharedInstance].accessToken]
                                  forHTTPHeaderField:@"Authorization"];
    [self POST:@"/rejectInviteForGame" parameters:@{@"opponentId" : opponentId} success:success failure:failure];
}

@end
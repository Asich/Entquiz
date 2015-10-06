//
// Created by Mustafin Askar on 05/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "LocalJsonWrapper.h"
#import "GameRound.h"


@implementation LocalJsonWrapper {}

+ (id)parseLocalJSON:(NSString *)jsonFileName {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonFileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions) kNilOptions error:&error];
    return json;
}

+ (GameRound *)gameWithLocalJson {
    GameRound *game = [GameRound instanceFromDictionary:[self parseLocalJSON:@"game"]];
    return game;
}

@end
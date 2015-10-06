//
// Created by Mustafin Askar on 05/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameRound;


@interface LocalJsonWrapper : NSObject

+ (id)parseLocalJSON:(NSString *)jsonFileName;
+ (GameRound *)gameWithLocalJson;

@end
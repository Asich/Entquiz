//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScoreContainerView : UIView

- (id)initWithPlayerName:(NSString *)playerName opponentName:(NSString *)opponentName;

@property (nonatomic, strong) NSString *playerName;
@property (nonatomic, strong) NSString *opponentName;
@property (nonatomic, strong) NSString *score;

@end
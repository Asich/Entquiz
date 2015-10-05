//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RoundResultView : UIView

- (id)initWithRoundNumber:(NSInteger)roundNumber categoryName:(NSString *)categoryName;

- (void)setPlayerAnswerRight;
- (void)setPlayerAnswerFalse;

- (void)setOpponentAnswerRight;
- (void)setOpponentAnswerFalse;

@end
//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "ScoreContainerView.h"
#import "ALView+PureLayout.h"


@interface ScoreContainerView() {}
@property(nonatomic, strong) UILabel *scoreLabel;
@property(nonatomic, strong) UILabel *playerNameLabel;
@property(nonatomic, strong) UILabel *opponentNameLabel;
@end

@implementation ScoreContainerView {}

- (id)initWithPlayerName:(NSString *)playerName opponentName:(NSString *)opponentName {
    self = [super initForAutoLayout];
    if (self) {
        self.score = @"0 : 0";
        self.playerName = playerName;
        self.opponentName = opponentName;
        [self configUI];
    }
    return self;
}

#pragma mark - configUI

- (void)configUI {
    [self autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth]];

    self.playerNameLabel = [[UILabel alloc] init];
    self.opponentNameLabel = [[UILabel alloc] init];
    self.scoreLabel = [[UILabel alloc] init];

    self.playerNameLabel.numberOfLines = 0;
    self.opponentNameLabel.numberOfLines = 0;

    self.playerNameLabel.textAlignment = NSTextAlignmentRight;
    self.opponentNameLabel.textAlignment = NSTextAlignmentLeft;
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;

    [self addSubview:self.playerNameLabel];
    [self addSubview:self.opponentNameLabel];
    [self addSubview:self.scoreLabel];


    //autolayout
    [self.playerNameLabel autoSetDimension:ALDimensionWidth toSize:100];
    [self.opponentNameLabel autoSetDimension:ALDimensionWidth toSize:100];
    [self.scoreLabel autoSetDimension:ALDimensionWidth toSize:50];

    [self.scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.scoreLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.playerNameLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.scoreLabel withOffset:-10];
    [self.opponentNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.scoreLabel withOffset:10];

    [self.playerNameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.scoreLabel];
    [self.opponentNameLabel autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.scoreLabel];

    [self.playerNameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.opponentNameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];



    //setting data to the views
    self.playerNameLabel.text = self.playerName;
    self.opponentNameLabel.text = self.opponentName;
    self.scoreLabel.text = self.score;

}

#pragma mark - setters / getters

- (void)setPlayerName:(NSString *)playerName {
    _playerName = playerName;
    self.playerNameLabel.text = playerName;
}

- (void)setOpponentName:(NSString *)opponentName {
    _opponentName = opponentName;
    self.opponentNameLabel.text = opponentName;
}

- (void)setScore:(NSString *)score {
    _score = score;
    self.scoreLabel.text = score;
}

@end
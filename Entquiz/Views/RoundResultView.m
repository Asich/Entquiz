//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "RoundResultView.h"
#import "ALView+PureLayout.h"
#import "ResultStatusContainerView.h"
#import "UIFont+Extension.h"


@interface RoundResultView() {}
@property (nonatomic, assign) NSInteger roundNumber;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) ResultStatusContainerView *playerResultContainer;
@property (nonatomic, strong) ResultStatusContainerView *opponentResultContainer;
@end

@implementation RoundResultView {}

- (id)initWithRoundNumber:(NSInteger)roundNumber categoryName:(NSString *)categoryName {
    self = [super initForAutoLayout];
    if (self) {

        self.roundNumber = roundNumber;
        self.categoryName = categoryName;

        [self configUI];
    }
    return self;
}

#pragma mark - set/get

- (void)setPlayerAnswerRight {
    [self.playerResultContainer addAnswerSuccess];
}

- (void)setPlayerAnswerFalse {
    [self.playerResultContainer addAnswerFailure];
}

- (void)setOpponentAnswerRight {
    [self.opponentResultContainer addAnswerSuccess];
}

- (void)setOpponentAnswerFalse {
    [self.opponentResultContainer addAnswerFailure];
}


#pragma mark - config ui

- (void)configUI {
    self.backgroundColor = [UIColor clearColor];

    UIView *centerContainer = [[UIView alloc] init];
    centerContainer.backgroundColor = [UIColor clearColor];
    [self addSubview:centerContainer];


    UILabel *roundNumberLabel = [[UILabel alloc] init];
    roundNumberLabel.font = [UIFont entMediumFontWithSize:12];
    roundNumberLabel.text = [NSString stringWithFormat:@"РАУНД %li", (long)self.roundNumber];
    [centerContainer addSubview:roundNumberLabel];

    UILabel *categoryNameLabel = [[UILabel alloc] init];
    categoryNameLabel.font = [UIFont systemFontOfSize:10];
    categoryNameLabel.numberOfLines = 0;
    categoryNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    categoryNameLabel.textAlignment = NSTextAlignmentCenter;
    categoryNameLabel.text = self.categoryName;
    [centerContainer addSubview:categoryNameLabel];

    self.playerResultContainer = [[ResultStatusContainerView alloc] initWithMaxAnswers:@""];
    self.opponentResultContainer = [[ResultStatusContainerView alloc] initWithMaxAnswers:@""];
    [self addSubview:self.playerResultContainer];
    [self addSubview:self.opponentResultContainer];


////////////////////////////////////////////////////////////////////////////////
    ///autolayout for:
    //self width
    [self autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] - 30];
    [self autoSetDimension:ALDimensionHeight toSize:44];

    //centerContainer with roundNumberLabel and categoryNameLabel inside
    [centerContainer autoSetDimension:ALDimensionWidth toSize:80];
    [centerContainer autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:2];
    [centerContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:2];
    [centerContainer autoAlignAxisToSuperviewAxis:ALAxisVertical];

    //round and category labels
    [roundNumberLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [roundNumberLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [categoryNameLabel autoSetDimension:ALDimensionWidth toSize:80];
    [categoryNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:roundNumberLabel];
    [categoryNameLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];

    //player and opponent containers
    [self.playerResultContainer autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:centerContainer withOffset:-10];
    [self.playerResultContainer autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.opponentResultContainer autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:centerContainer withOffset:10];
    [self.opponentResultContainer autoPinEdgeToSuperviewEdge:ALEdgeTop];
}

@end
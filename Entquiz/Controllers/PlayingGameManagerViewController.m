//
// Created by Mustafin Askar on 07/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "PlayingGameManagerViewController.h"
#import "LocalJsonWrapper.h"
#import "ChooseCategoryViewController.h"
#import "GameRound.h"
#import "QuestionViewController.h"
#import "RoundData.h"

@interface PlayingGameManagerViewController() {}

@property (nonatomic, strong) NSMutableArray *answeredQuestions;

@end

@implementation PlayingGameManagerViewController {

}

- (id)init {
    self = [super init];
    if (self) {
        self.answeredQuestions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - config actions

- (void)startGame {
    __weak PlayingGameManagerViewController *wSelf = self;

    GameRound *gameRound = [LocalJsonWrapper gameWithLocalJson];
    ChooseCategoryViewController *vc = [[ChooseCategoryViewController alloc] initWithRoundData:gameRound.data];
    vc.onRoundCategoryClick = ^(RoundCategory *roundCategory) {
        //todo: ChooseCategoryViewController will pop after calling this block
        //the show vc for 1st queston in category
        RoundData *roundData = [gameRound getRoundDataByRoundCategory:roundCategory];
        QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithQuestion:roundData.questions[0]];
        questionViewController.onAnswerClick = ^(Answer *answer) {
            [wSelf.answeredQuestions addObject:answer];
        };
        [wSelf.navigationController pushViewController:questionViewController animated:YES];
    };
    [self presentViewController:vc animated:YES completion:nil];


}

#pragma mark - config ui

- (void)configUI {

}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

}

@end
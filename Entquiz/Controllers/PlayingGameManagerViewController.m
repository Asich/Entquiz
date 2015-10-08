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
#import "RoundCategory.h"
#import "UIViewController+Extensions.h"

@interface PlayingGameManagerViewController() {}
@end

@implementation PlayingGameManagerViewController {}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self startGame];
}

#pragma mark - config actions

- (void)startGame {
    __weak PlayingGameManagerViewController *wSelf = self;

    GameRound *gameRound = [LocalJsonWrapper gameWithLocalJson];

    ChooseCategoryViewController *vc = [[ChooseCategoryViewController alloc] initWithRoundData:gameRound.data];
    vc.onRoundCategoryClick = ^(RoundData *roundData) {
        //todo: ChooseCategoryViewController will pop after calling this block
        //the show vc for 1st queston in category
        [wSelf showQuestionWithRoundData:roundData];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)showQuestionWithRoundData:(RoundData *)roundData {
    NSLog(@"showQuestionWithGameRound");

    __weak PlayingGameManagerViewController *wSelf = self;

    QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithQuestion:roundData.questions];
    [wSelf.navigationController pushViewController:questionViewController animated:YES];
}

#pragma mark - config ui

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

}

@end
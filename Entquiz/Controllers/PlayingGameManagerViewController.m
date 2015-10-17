//
// Created by Mustafin Askar on 07/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <PureLayout/PureLayoutDefines.h>
#import <PureLayout/ALView+PureLayout.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "PlayingGameManagerViewController.h"
#import "LocalJsonWrapper.h"
#import "ScoreContainerView.h"
#import "GameRound.h"
#import "ChooseCategoryViewController.h"
#import "QuestionViewController.h"
#import "RoundData.h"
#import "Answer.h"
#import "RoundResultView.h"
#import "GameRoundUser.h"
#import "RoundCategory.h"
#import "GameApi.h"
#import "NSObject+Json.h"


@interface PlayingGameManagerViewController() {}
@property (nonatomic, strong) GameRound *gameRound;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ScoreContainerView *scoreContainerView;
@property (nonatomic, strong) NSMutableArray *roundResultViews;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end



@implementation PlayingGameManagerViewController {}

- (id)init {
    self = [super init];
    if (self) {
        self.roundResultViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self startGame];
}


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - config actions

/**
*  INITIAL START GAME METHOD
*
*
*/
- (void)startGame {
    __weak PlayingGameManagerViewController *wSelf = self;


    //todo: startGame method api
    //
    //
    //self.gameRound = [LocalJsonWrapper gameWithLocalJson];



    [SVProgressHUD show];
    [GameApi startWithSuccess:^(id response) {

        NSLog(@"startWithSuccess: %@", [response JSONRepresentationPretyPrinted:YES]);

        self.gameRound = [GameRound instanceFromDictionary:response];

        [self buildResultVies];


        //if gameRound has no opponent yet
        //choose category
        //and then answer on 3 questions
        if (!self.gameRound.opponent) {
            ChooseCategoryViewController *vc = [[ChooseCategoryViewController alloc] initWithRoundData:self.gameRound.data];
            [self presentViewController:vc animated:YES completion:nil];
            vc.onRoundCategoryClick = ^(RoundData *roundData) {
                [wSelf showQuestionWithRoundData:roundData];
            };
        } else {
            [self showQuestionWithRoundData:self.gameRound.data[0]];
        }



        [SVProgressHUD dismiss];
    } failure:^(NSInteger code, NSString *message) {
        [SVProgressHUD dismiss];
    }];

}


/**
*
*  TODO: VERY IMPORTANT METHOD
*
*  ADD RoundResultView INTO ScoreContainerView
*  ANTER PLAYER ANSWERS THE QUESTIONS
*
*
*  TODO: ADD SCORE
*/

- (void)showQuestionWithRoundData:(RoundData *)roundData {
    __weak PlayingGameManagerViewController *wSelf = self;

    QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithQuestion:roundData.questions];
    questionViewController.onAllQuestionsAnswered = ^(NSArray *answers) {

        //todo: draw oppponent score
        [wSelf addRoundResultViewWithCategory:roundData.category andAnswers:answers];
        [wSelf submitRoundWithRoundData:roundData andAnswers:answers];

    };
    [wSelf.navigationController pushViewController:questionViewController animated:YES];
}


- (void)submitRoundWithRoundData:(RoundData *)roundData andAnswers:(NSArray *)answers {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"gameId"] = self.gameRound.gameId;
    params[@"catId"] =  roundData.category.roundCategoryId;
    params[@"roundId"] = self.gameRound.roundId;


    for (int i = 0; i < answers.count; i++) {

        Answer *answer = answers[(NSUInteger) i];

        NSString *questionKey = [NSString stringWithFormat:@"q%iId", i + 1];
        NSString *answerKey = [NSString stringWithFormat:@"a%iId", i + 1];

        params[questionKey] = answer.quesId;
        params[answerKey] = answer.answerId;
    }

    [GameApi submitRoundWithParams:params success:^(id response) {
        NSLog(@"response: %@", response);
    } failure:^(NSInteger code, NSString *message) {
        NSLog(@"failure: %@", message);
    }];
}

- (void)clickStatusButton {

}

- (void)refreshTable {
    [self.refreshControl endRefreshing];

    [GameApi getRoundDataWithGameId:self.gameRound.gameId success:^(id response) {
        NSLog(@"getRoundData: %@", [response JSONRepresentationPretyPrinted:YES]);

        GameRound *gameRound1 = [GameRound instanceFromDictionary:response];

        if (r)


    } failure:^(NSInteger code, NSString *message) {
        NSLog(@"failure: %@", message);
    }];
}


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#pragma mark - config ui

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom];


    UIButton *statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [statusButton setTitle:@"Ждем" forState:UIControlStateNormal];
    [statusButton addTarget:self action:@selector(clickStatusButton) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:statusButton];
    [statusButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [statusButton autoAlignAxisToSuperviewAxis:ALAxisVertical];



    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.scrollView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

}


- (void)buildResultVies {

    self.scoreContainerView = [[ScoreContainerView alloc] initWithPlayerName:self.gameRound.user.username opponentName:self.gameRound.opponent ? self.gameRound.opponent.username : @"-"];
    [self.scrollView addSubview:self.scoreContainerView];

    //autolayout
    [self.scoreContainerView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [self.scoreContainerView autoAlignAxisToSuperviewAxis:ALAxisVertical];
}


- (void)addRoundResultViewWithCategory:(RoundCategory *)roundCategory andAnswers:(NSArray *)answers {

    RoundResultView *roundResultView1 = [[RoundResultView alloc] initWithRoundNumber:1 categoryName:roundCategory.name];
    [self.scrollView addSubview:roundResultView1];

    for (Answer *answer in answers) {
        if (answer.isTrue) {
            [roundResultView1 setPlayerAnswerRight];
        } else {
            [roundResultView1 setPlayerAnswerFalse];
        }
    }


    /////
    UIView *lastResultView = [self.roundResultViews lastObject];
    if (lastResultView) {
        [roundResultView1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lastResultView withOffset:5];
    } else {
        [roundResultView1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.scoreContainerView withOffset:5];
    }
    [roundResultView1 autoAlignAxisToSuperviewAxis:ALAxisVertical];

    [self.roundResultViews addObject:roundResultView1];
}


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

}

@end
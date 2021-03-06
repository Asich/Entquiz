//
// Created by Mustafin Askar on 07/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <PureLayout/PureLayoutDefines.h>
#import <PureLayout/ALView+PureLayout.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <UIAlertView+Blocks/UIAlertView+Blocks.h>
#import "PlayingGameManagerViewController.h"
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
#import "Question.h"
#import "UIViewController+Extensions.h"
#import "Consts.h"
#import "QuestionQues.h"
#import "OpAnswer.h"
#import "TMDiskCache.h"

@interface PlayingGameManagerViewController() {}
@property (nonatomic, strong) NSNumber *opponentId;
@property (nonatomic, strong) GameRound *gameRound;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ScoreContainerView *scoreContainerView;
@property (nonatomic, strong) NSMutableArray *roundResultViews;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIButton *statusButton;
@end


@implementation PlayingGameManagerViewController {}

- (id)init {
    self = [super init];
    if (self) {
        self.roundResultViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithOpponentId:(NSNumber *)opponentId {
    self = [super init];
    if (self) {
        self.opponentId = opponentId;
        self.roundResultViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];

    if (!self.opponentId) {
        [self startGame];
    } else {
        [self acceptInvitStartGame];
    }
}


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - config actions

/**
*  ACCEPT INVITE START GAME
*
*/

- (void)acceptInvitStartGame {
    __weak PlayingGameManagerViewController *wSelf = self;
    [SVProgressHUD show];

    [GameApi acceptInviteForGameOpponentId:self.opponentId success:^(id response) {

        self.gameRound = [GameRound instanceFromDictionary:response];

        [self buildScoreContainerView];


        //if gameRound has no opponent yet
        //choose category
        //and then answer on 3 questions
        //if gameRound has opponent
        //show question to answer
        if (!self.gameRound.opponent) {

            ChooseCategoryViewController *vc = [[ChooseCategoryViewController alloc] initWithRoundData:self.gameRound.data];
            [self presentViewController:vc animated:YES completion:nil];
            vc.onRoundCategoryClick = ^(RoundData *roundData) {
                [wSelf showQuestionWithRoundData:roundData];
            };

        } else {

            if (self.gameRound.data.count == 0) {

            } else {
                [self showQuestionWithRoundData:self.gameRound.data[0]];
            }

        }


        [SVProgressHUD dismiss];
    } failure:^(NSInteger code, NSString *message) {
        [UIAlertView showWithTitle:nil message:kCannotStartGameAlertMessage cancelButtonTitle:@"ОК" otherButtonTitles:nil tapBlock:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    }];
}

/**
*  INITIAL START GAME
*
*
*/
- (void)startGame {

    [SVProgressHUD show];
    [GameApi startWithSuccess:^(id response) {

        self.gameRound = [GameRound instanceFromDictionary:response];

        [self buildScoreContainerView];
        [self reloadStatusButtonTitle];

        [SVProgressHUD dismiss];

    } failure:^(NSInteger code, NSString *message) {
        [UIAlertView showWithTitle:nil message:kCannotStartGameAlertMessage cancelButtonTitle:@"ОК" otherButtonTitles:nil tapBlock:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    }];

}


/**
*  Add RoundResultView into ScoreContainerView
*  AFTER PLAYER ANSWERS THE QUESTIONS
*
*/

- (void)showQuestionWithRoundData:(RoundData *)roundData {
    __weak PlayingGameManagerViewController *wSelf = self;

    QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithQuestion:roundData.questions];
    questionViewController.onAllQuestionsAnswered = ^(NSArray *answers) {

        //todo: set ждем
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

        params[questionKey] = answer.quesId  ? : [NSNull null];
        params[answerKey] = answer.answerId  ? : [NSNull null];
    }

    [GameApi submitRoundWithParams:params success:^(id response) {
    } failure:^(NSInteger code, NSString *message) {
    }];
}


//todo: draw opponent answers when opponent ends round

- (void)refreshTable {
    [self.refreshControl endRefreshing];

    [GameApi getRoundDataWithGameId:self.gameRound.gameId success:^(id response) {

        self.gameRound = [GameRound instanceFromDictionary:response];

        [self reloadStatusButtonTitle];

    } failure:^(NSInteger code, NSString *message) {
    }];
}

- (void)reloadStatusButtonTitle {
    if (self.gameRound.data.count > 0) {
            [self.statusButton setTitle:kPlay forState:UIControlStateNormal];
        } else {
            [self.statusButton setTitle:kWait forState:UIControlStateNormal];
        }
}

- (void)clickStatusButton {
    __weak PlayingGameManagerViewController *wSelf = self;

    if (self.gameRound.data.count == 1) {

        [self showQuestionWithRoundData:self.gameRound.data[0]];

        [[TMDiskCache sharedCache] setObject:self.gameRound.data[0] forKey:[NSString stringWithFormat:@"round%i", self.roundResultViews.count + 1] block:^(TMDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
            NSLog(@"fileURL: %@", fileURL);
        }];

    } else if (self.gameRound.data.count > 1) {

        ChooseCategoryViewController *vc = [[ChooseCategoryViewController alloc] initWithRoundData:self.gameRound.data];
        [self presentViewController:vc animated:YES completion:nil];
        vc.onRoundCategoryClick = ^(RoundData *roundData) {
            [wSelf showQuestionWithRoundData:roundData];

            [[TMDiskCache sharedCache] setObject:roundData forKey:[NSString stringWithFormat:@"round%i", self.roundResultViews.count + 1] block:^(TMDiskCache *cache, NSString *key, id <NSCoding> object, NSURL *fileURL) {
                NSLog(@"fileurl: %@", fileURL);
            }];
        };

    } else {

    }
}

#pragma mark - config ui

- (void)configUI {
    [self addDefaultBackground];

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:self.scrollView];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom];


    self.statusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.statusButton setTitle:kWait forState:UIControlStateNormal];
    [self.statusButton addTarget:self action:@selector(clickStatusButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.statusButton];
    [self.statusButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.statusButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50];


    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.scrollView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

}


- (void)buildScoreContainerView {

    self.scoreContainerView = [[ScoreContainerView alloc] initWithPlayerName:self.gameRound.user.username opponentName:self.gameRound.opponent ? self.gameRound.opponent.username : @"-"];
    [self.scrollView addSubview:self.scoreContainerView];

    //autolayout
    [self.scoreContainerView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [self.scoreContainerView autoAlignAxisToSuperviewAxis:ALAxisVertical];
}


- (void)addRoundResultViewWithCategory:(RoundCategory *)roundCategory andAnswers:(NSArray *)answers {

    RoundResultView *roundResultView1 = [[RoundResultView alloc] initWithRoundNumber:self.roundResultViews.count + 1 categoryName:roundCategory.name];
    [self.scrollView addSubview:roundResultView1];
    [self.roundResultViews addObject:roundResultView1];


    //fill round view with user results
    for (Answer *answer in answers) {
        if (answer.isTrue) {
            [roundResultView1 setPlayerAnswerRight];
        } else {
            [roundResultView1 setPlayerAnswerFalse];
        }
    }


    //if gameRound data has only one category
    //this means that current round is user's reply
    //so fill round view with opponents results

    if (self.gameRound.data.count == 1) {

        RoundData *roundData = self.gameRound.data[0];
        NSArray *questions = roundData.questions;

        [self drawOpponentAnswer:roundResultView1
                       questions:questions
                 opponentAnswers:self.gameRound.opAnswers];


        RoundResultView *lastResultView = [self.roundResultViews lastObject];
        NSInteger lastObjectIndex = [self.roundResultViews indexOfObject:lastResultView];
        if (lastObjectIndex - 1 > 0) {
            RoundResultView *prevResultView = self.roundResultViews[(NSUInteger) (lastObjectIndex - 1)];

            RoundData *savedRoundData = [[TMDiskCache sharedCache] objectForKey:[NSString stringWithFormat:@"round%i", lastObjectIndex - 1]];

            [self drawOpponentAnswer:prevResultView
                           questions:savedRoundData.questions
                     opponentAnswers:self.gameRound.opAnswers];

        }
    }


    /////
    if (self.roundResultViews.count == 1) {
        [roundResultView1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.scoreContainerView withOffset:5];
    } else {
        UIView *lastResultView = self.roundResultViews[self.roundResultViews.count - 2];
        [roundResultView1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lastResultView withOffset:5];
    }
    [roundResultView1 autoAlignAxisToSuperviewAxis:ALAxisVertical];

}

- (void)drawOpponentAnswer:(RoundResultView *)roundResultView
                 questions:(NSArray *)questions
           opponentAnswers:(NSArray *)opponentAnswers {

    for (Question *question in questions) {
        for (OpAnswer *opAnswer in opponentAnswers) {
            if ([question.ques.catId isEqualToNumber:opAnswer.catId]) {

                Answer *answer;

                if ([question.ques.questionQuesId isEqualToNumber:opAnswer.q1Id]) {
                    answer = [question getAnswerById:opAnswer.a1Id];
                } else if ([question.ques.questionQuesId isEqualToNumber:opAnswer.q2Id]) {
                    answer = [question getAnswerById:opAnswer.a2Id];
                } else if ([question.ques.questionQuesId isEqualToNumber:opAnswer.q3Id]) {
                    answer = [question getAnswerById:opAnswer.a3Id];
                }

                if ([answer isTrue]) {
                    [roundResultView setOpponentAnswerRight];
                } else {
                    [roundResultView setOpponentAnswerFalse];
                }
            }
        }
    }
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {}

@end
//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "QuestionViewController.h"
#import "Question.h"
#import "QuestionQues.h"
#import "AnswerTimerView.h"
#import "UIImageView+AFNetworking.h"
#import "Answer.h"
#import "UIButton+BackgroudForState.h"
#import "NSObject+PWObject.h"


@interface QuestionViewController() {}

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSMutableArray *answers;

@property (nonatomic, strong) Question *currentQuestion;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *questionContainer;
@property (nonatomic, strong) AnswerTimerView *timerView;
@end

@implementation QuestionViewController {}

- (id)initWithQuestion:(NSArray *)questions {
    self = [super init];
    if (self) {
        self.questions = questions;
        self.answers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];


    Question *question = self.questions[0];
    [self startQuestion:question];
}

#pragma mark - config actions

- (void)clickOnAnswer:(UIButton *)answerButton {
    __weak QuestionViewController *wSelf = self;

    Answer *selectedAnswer = self.currentQuestion.answers[(NSUInteger) answerButton.tag];
    [self.answers addObject:selectedAnswer];

    //block button ui and show green background if right or red background if wrong answer
    //go to next question
    //
    [wSelf.timerView stop];
    [self colorButton:answerButton accordingToSelectedAnswer:selectedAnswer];
    [self performBlock:^{
        [wSelf.questionContainer removeFromSuperview];
        [wSelf goToNextQuestion];
    } afterDelay:1];
}

- (void)colorButton:(UIButton *)answerButton accordingToSelectedAnswer:(Answer *)selectedAnswer {
    self.questionContainer.userInteractionEnabled = NO;
    if ([selectedAnswer isTrue]) {
        [answerButton setBackgroundColor:[UIColor greenColor] forState:UIControlStateNormal];
    } else {
        [answerButton setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

- (void)timeEnd {
    Answer *wrongAnswer = [[Answer alloc] init];
    wrongAnswer.isTrue = NO;
    [self.answers addObject:wrongAnswer];
    [self.questionContainer removeFromSuperview];
    [self goToNextQuestion];
}

- (void)goToNextQuestion {
    if (![self.questions.lastObject isEqual:self.currentQuestion]) {
        NSInteger nextQuestionIndex = [self.questions indexOfObject:self.currentQuestion] + 1;
        [self startQuestion:self.questions[(NSUInteger) nextQuestionIndex]];
    } else {
        if (self.onAllQuestionsAnswered) {
            self.onAllQuestionsAnswered(self.answers);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - config ui

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
}

#pragma mark - game logic

- (void)startQuestion:(Question *)question {

    NSLog(@"quseiton: %@", question);

    self.currentQuestion = question;

    self.questionContainer = [[UIView alloc] init];
    self.questionContainer.backgroundColor = [UIColor purpleColor];
    self.questionContainer.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.questionContainer];
    [self.questionContainer autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth]];
    [self.questionContainer autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.questionContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.questionContainer autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.questionContainer autoPinEdgeToSuperviewEdge:ALEdgeTrailing];


    NSMutableArray *viewsPark = [[NSMutableArray alloc] init];

    if (question.ques.img.length > 0) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:question.ques.img]];
        [self.questionContainer addSubview:imageView];
        [imageView autoSetDimension:ALDimensionHeight toSize:imageView.image.size.height];
        [imageView autoSetDimension:ALDimensionWidth toSize:imageView.image.size.width];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
        [imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [viewsPark addObject:imageView];
    }

    UILabel *questionLabel = [[UILabel alloc] init];
    questionLabel.backgroundColor = [UIColor yellowColor];
    questionLabel.numberOfLines = 0;
    questionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    questionLabel.textAlignment = NSTextAlignmentCenter;
    questionLabel.text = question.ques.title;
    [self.questionContainer addSubview:questionLabel];

    UIView *lastViewInPark = viewsPark.lastObject;
    if (lastViewInPark) {
        [questionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lastViewInPark];
    } else {
        [questionLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    }
    [questionLabel autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] - 30];
    [questionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];


    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button1.tag = 0;
    button1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button1.titleLabel.textAlignment = NSTextAlignmentCenter;
    button1.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.questionContainer addSubview:button1];
    [button1 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button1 autoSetDimension:ALDimensionHeight toSize:130];
    [button1 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:questionLabel];
    [button1 autoPinEdgeToSuperviewEdge:ALEdgeLeading];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button2.tag = 1;
    button2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button2.titleLabel.textAlignment = NSTextAlignmentCenter;
    button2.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.questionContainer addSubview:button2];
    [button2 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button2 autoSetDimension:ALDimensionHeight toSize:130];
    [button2 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:questionLabel];
    [button2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:button1];

    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button3 setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button3.tag = 2;
    button3.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button3.titleLabel.textAlignment = NSTextAlignmentCenter;
    button3.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.questionContainer addSubview:button3];
    [button3 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button3 autoSetDimension:ALDimensionHeight toSize:130];
    [button3 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:button1];
    [button3 autoPinEdgeToSuperviewEdge:ALEdgeLeading];

    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button4 setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button4.tag = 3;
    button4.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button4.titleLabel.textAlignment = NSTextAlignmentCenter;
    button4.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.questionContainer addSubview:button4];
    [button4 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button4 autoSetDimension:ALDimensionHeight toSize:130];
    [button4 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:button2];
    [button4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:button3];

    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button5 setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button5.tag = 4;
    button5.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button5.titleLabel.textAlignment = NSTextAlignmentCenter;
    button5.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.questionContainer addSubview:button5];
    [button5 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button5 autoSetDimension:ALDimensionHeight toSize:130];
    [button5 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button5 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:button3];
    [button5 autoPinEdgeToSuperviewEdge:ALEdgeLeading];


    Answer *answer = question.answers[0];
    Answer *answer1 = question.answers[1];
    Answer *answer2 = question.answers[2];
    Answer *answer3 = question.answers[3];
    Answer *answer4 = question.answers[4];

    [button1 setTitle:answer.title forState:UIControlStateNormal];
    [button2 setTitle:answer1.title forState:UIControlStateNormal];
    [button3 setTitle:answer2.title forState:UIControlStateNormal];
    [button4 setTitle:answer3.title forState:UIControlStateNormal];
    [button5 setTitle:answer4.title forState:UIControlStateNormal];

    self.timerView = [[AnswerTimerView alloc] init];
    [self.questionContainer addSubview:self.timerView];
    [self.timerView autoSetDimension:ALDimensionHeight toSize:40];
    [self.timerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:button5];
    [self.timerView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.timerView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.timerView autoPinEdgeToSuperviewEdge:ALEdgeBottom];

    [self.timerView startWithCompletion:^{
        [self timeEnd];
    }];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

}

@end
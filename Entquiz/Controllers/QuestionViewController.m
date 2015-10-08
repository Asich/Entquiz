//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import <FrameAccessor/ViewFrameAccessor.h>
#import "QuestionViewController.h"
#import "Question.h"
#import "QuestionQues.h"
#import "UIImageView+AFNetworking.h"
#import "Answer.h"
#import "UIButton+BackgroudForState.h"
#import "NSObject+PWObject.h"
#import "IQUIView+IQKeyboardToolbar.h"


@interface QuestionViewController() {}

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSMutableArray *answeredQuestions;

@property (nonatomic, strong) Question *currentQuestion;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *questionContainer;
@end

@implementation QuestionViewController {}

- (id)initWithQuestion:(NSArray *)questions {
    self = [super init];
    if (self) {
        self.questions = questions;
        self.answeredQuestions = [[NSMutableArray alloc] init];
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
    [self.answeredQuestions addObject:selectedAnswer];

    //block button ui and show green background if right or red background if wrong answer
    //go to next question
    //
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
    [self.questionContainer autoSetDimension:ALDimensionHeight toSize:300];
    [self.questionContainer autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.questionContainer autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.questionContainer autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.questionContainer autoPinEdgeToSuperviewEdge:ALEdgeTrailing];


    NSMutableArray *viewsPark = [[NSMutableArray alloc] init];

    if (question.ques.img) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:question.ques.img]];
        [self.questionContainer addSubview:imageView];
        [imageView autoSetDimension:ALDimensionHeight toSize:imageView.image.size.height];
        [imageView autoSetDimension:ALDimensionWidth toSize:imageView.image.size.width];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
        [imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [viewsPark addObject:imageView];
    }

    UILabel *label = [[UILabel alloc] init];
    label.text = question.ques.title;
    [self.questionContainer addSubview:label];

    UIView *lastViewInPark = viewsPark.lastObject;
    if (lastViewInPark) {
        [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lastViewInPark];
    } else {
        [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    }
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];


    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setBackgroundColor:[UIColor yellowColor] forState:UIControlStateNormal];
    button1.tag = 0;
    [self.questionContainer addSubview:button1];
    [button1 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button1 autoSetDimension:ALDimensionHeight toSize:100];
    [button1 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label];
    [button1 autoPinEdgeToSuperviewEdge:ALEdgeLeading];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setBackgroundColor:[UIColor brownColor] forState:UIControlStateNormal];
    button2.tag = 1;
    [self.questionContainer addSubview:button2];
    [button2 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button2 autoSetDimension:ALDimensionHeight toSize:100];
    [button2 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label];
    [button2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:button1];

    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button3 setBackgroundColor:[UIColor blueColor] forState:UIControlStateNormal];
    button3.tag = 2;
    [self.questionContainer addSubview:button3];
    [button3 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button3 autoSetDimension:ALDimensionHeight toSize:100];
    [button3 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:button1];
    [button3 autoPinEdgeToSuperviewEdge:ALEdgeLeading];

    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button4 setBackgroundColor:[UIColor blackColor] forState:UIControlStateNormal];
    button4.tag = 3;
    [self.questionContainer addSubview:button4];
    [button4 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button4 autoSetDimension:ALDimensionHeight toSize:100];
    [button4 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:button2];
    [button4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:button3];


    Answer *answer = question.answers[0];
    Answer *answer1 = question.answers[1];
    Answer *answer2 = question.answers[2];
    Answer *answer3 = question.answers[3];

    [button1 setTitle:answer.title forState:UIControlStateNormal];
    [button2 setTitle:answer1.title forState:UIControlStateNormal];
    [button3 setTitle:answer2.title forState:UIControlStateNormal];
    [button4 setTitle:answer3.title forState:UIControlStateNormal];

}

- (void)goToNextQuestion {
    if (![self.questions.lastObject isEqual:self.currentQuestion]) {
        NSInteger nextQuestionIndex = [self.questions indexOfObject:self.currentQuestion] + 1;
        [self startQuestion:self.questions[(NSUInteger) nextQuestionIndex]];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

}

@end
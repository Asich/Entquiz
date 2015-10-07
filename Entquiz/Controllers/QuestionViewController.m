//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "QuestionViewController.h"
#import "Question.h"
#import "QuestionQues.h"
#import "UIImageView+AFNetworking.h"
#import "Answer.h"


@interface QuestionViewController() {}

@property (nonatomic, strong) Question *question;

@end

@implementation QuestionViewController {}

- (id)initWithQuestion:(Question *)question {
    self = [super init];
    if (self) {
        self.question = question;
    }
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - config actions

- (void)clickOnAnswer:(UIButton *)answerButton {
    if (self.onAnswerClick) {
        Answer *selectedAnswer = self.question.answers[(NSUInteger) answerButton.tag];
        self.onAnswerClick(selectedAnswer);
    }
}

#pragma mark - config ui

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    
    NSMutableArray *viewsPark = [[NSMutableArray alloc] init];
    
    if (self.question.ques.img) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:self.question.ques.img]];
        [scrollView addSubview:imageView];
        [imageView autoSetDimension:ALDimensionHeight toSize:imageView.image.size.height];
        [imageView autoSetDimension:ALDimensionWidth toSize:imageView.image.size.width];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
        [imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [viewsPark addObject:imageView];
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.question.ques.title;
    [scrollView addSubview:label];

    UIView *lastViewInPark = viewsPark.lastObject;
    if (lastViewInPark) {
        [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lastViewInPark];
    } else {
        [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    }
    [label autoAlignAxisToSuperviewAxis:ALAxisVertical];


    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.tag = 0;
    [scrollView addSubview:button1];
    [button1 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button1 autoSetDimension:ALDimensionHeight toSize:100];
    [button1 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label];
    [button1 autoPinEdgeToSuperviewEdge:ALEdgeLeading];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.tag = 1;
    [scrollView addSubview:button2];
    [button2 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button2 autoSetDimension:ALDimensionHeight toSize:100];
    [button2 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label];
    [button2 autoPinEdgeToSuperviewEdge:ALEdgeTrailing];

    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    button3.tag = 2;
    [scrollView addSubview:button3];
    [button3 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button3 autoSetDimension:ALDimensionHeight toSize:100];
    [button3 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:button1];
    [button3 autoPinEdgeToSuperviewEdge:ALEdgeLeading];

    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    button4.tag = 3;
    [scrollView addSubview:button4];
    [button4 addTarget:self action:@selector(clickOnAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [button4 autoSetDimension:ALDimensionHeight toSize:100];
    [button4 autoSetDimension:ALDimensionWidth toSize:[ASize screenWidth] / 2];
    [button4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:button2];
    [button4 autoPinEdgeToSuperviewEdge:ALEdgeTrailing];


    Answer *answer = self.question.answers[0];
    Answer *answer1 = self.question.answers[1];
    Answer *answer2 = self.question.answers[2];
    Answer *answer3 = self.question.answers[3];
    [button1 setTitle:answer.title forState:UIControlStateNormal];
    [button2 setTitle:answer1.title forState:UIControlStateNormal];
    [button3 setTitle:answer2.title forState:UIControlStateNormal];
    [button4 setTitle:answer3.title forState:UIControlStateNormal];
    
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

}

@end
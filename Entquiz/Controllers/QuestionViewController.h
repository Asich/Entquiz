//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;
@class Answer;
@class AnswerTimerView;


@interface QuestionViewController : UIViewController

- (id)initWithQuestion:(NSArray *)questions;

@property (nonatomic, copy) void (^onAllQuestionsAnswered)(NSArray *answeredQuestions);

@end
//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;
@class Answer;


@interface QuestionViewController : UIViewController

- (id)initWithQuestion:(Question *)question;

@property (nonatomic, copy) void (^onAnswerClick)(Answer *answer);

@end
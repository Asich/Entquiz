//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ResultStatusContainerView : UIView

- (id)initWithMaxAnswers:(NSString *)maxAnswers;
- (void)addAnswerSuccess;
- (void)addAnswerFailure;

@end
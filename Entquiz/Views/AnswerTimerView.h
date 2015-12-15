//
// Created by Mustafin Askar on 08/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AnswerTimerView : UIView

- (void)startWithCompletion:(void (^)())completionBlock;
- (void)stop;

@property(nonatomic, strong) UISlider *timerSlider;

@end
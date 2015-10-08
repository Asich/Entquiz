//
// Created by Mustafin Askar on 08/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "AnswerTimerView.h"
#import "NSObject+PWObject.h"


@interface AnswerTimerView ()
@end

@implementation AnswerTimerView {

}

- (id)init {
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark -

- (void)configUI {
    self.backgroundColor = [UIColor yellowColor];

    self.timerSlider = [[UISlider alloc] init];
    //[self.timerSlider setThumbImage:[UIImage new] forState:UIControlStateNormal];
    self.timerSlider.userInteractionEnabled = NO;
    self.timerSlider.tintColor = [UIColor redColor];
    [self addSubview:self.timerSlider];

    [self.timerSlider autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.timerSlider autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [self.timerSlider autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
}

- (void)startWithCompletion:(void (^)())completionBlock {
    [UIView animateWithDuration:20 animations:^{
        [self.timerSlider setValue:1 animated:YES];
    } completion:^(BOOL finished) {
        if (finished) {
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}

- (void)stop {
    [self.layer removeAllAnimations];
}

@end
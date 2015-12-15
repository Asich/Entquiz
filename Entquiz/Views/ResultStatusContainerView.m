//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <PureLayout/ALView+PureLayout.h>
#import "ResultStatusContainerView.h"


#define kMaxAnswers 3

@interface ResultStatusContainerView() {}
@property (nonatomic, strong) NSMutableArray *statusViews;
@end

@implementation ResultStatusContainerView {

}

- (id)initWithMaxAnswers:(NSString *)maxAnswers {
    self = [super initForAutoLayout];
    if (self) {
        [self initVars];
        [self configUI];
    }
    return self;
}

- (void)initVars {
    self.statusViews = [[NSMutableArray alloc] init];
}

#pragma mark - config ui

- (void)configUI {
    self.backgroundColor = [UIColor lightGrayColor];
    [self autoSetDimension:ALDimensionHeight toSize:42];
    [self autoSetDimension:ALDimensionWidth toSize:95];
}

- (void)rearangeStatusViews {
    if (self.statusViews.count == 1) {
        UIView *view = self.statusViews.lastObject;
        [self addSubview:view];

        [view autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:1];
        [view autoPinEdgeToSuperviewEdge:ALEdgeTop];
    } else {
        UIView *view = self.statusViews.lastObject;
        [self addSubview:view];

        NSUInteger indexOfView = [self.statusViews indexOfObject:view];
        UIView *previousView = self.statusViews[indexOfView - 1];
        [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:previousView withOffset:1];
        [view autoPinEdgeToSuperviewEdge:ALEdgeTop];

    } 
}

- (void)addAnswerSuccess {
    [self addStatusViewIsSuccess:YES];
    [self rearangeStatusViews];
}

- (void)addAnswerFailure {
    [self addStatusViewIsSuccess:NO];
    [self rearangeStatusViews];
}

- (void)addStatusViewIsSuccess:(BOOL)isSuccess {
    if (self.statusViews.count <= kMaxAnswers) {
        UIView *statusView = [[UIView alloc] init];
        statusView.backgroundColor = isSuccess ? [UIColor greenColor] : [UIColor redColor];
        [self.statusViews addObject:statusView];

        [statusView autoSetDimension:ALDimensionHeight toSize:40];
        [statusView autoSetDimension:ALDimensionWidth toSize:30];
    }
}

@end
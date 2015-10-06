//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "GameViewController.h"
#import "ALView+PureLayout.h"
#import "ScoreContainerView.h"
#import "User.h"
#import "RoundResultView.h"
#import "LocalJsonWrapper.h"


@implementation GameViewController {

}

- (id)init {
    self = [super init];
    if (self) {
        [self initVars];
    }
    return self;
}

- (void)initVars {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - config actions

- (void)configActions {

}

#pragma mark - config ui

- (void)configUI {

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.alwaysBounceVertical = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom];


    ScoreContainerView *scoreContainerView = [[ScoreContainerView alloc] initWithPlayerName:@"Asich" opponentName:@"Mura"];
    [scrollView addSubview:scoreContainerView];

    [scoreContainerView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [scoreContainerView autoAlignAxisToSuperviewAxis:ALAxisVertical];


    //Round 1
    RoundResultView *roundResultView1 = [[RoundResultView alloc] initWithRoundNumber:1 categoryName:@"История Казахстана"];
    [scrollView addSubview:roundResultView1];
    [roundResultView1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:scoreContainerView withOffset:5];
    [roundResultView1 autoAlignAxisToSuperviewAxis:ALAxisVertical];


    RoundResultView *roundResultView2 = [[RoundResultView alloc] initWithRoundNumber:2 categoryName:@"Английский язык"];
    [scrollView addSubview:roundResultView2];
    [roundResultView2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:roundResultView1 withOffset:5];
    [roundResultView2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [roundResultView2 autoPinEdgeToSuperviewEdge:ALEdgeBottom];

}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

}

@end
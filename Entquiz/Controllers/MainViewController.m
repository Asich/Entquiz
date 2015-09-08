//
// Created by Mustafin Askar on 08/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "MainViewController.h"
#import "AAForm.h"
#import "StartGameViewController.h"

#define kSettingsButtonTitle @"Settings"
#define kStatisticsButtonTitle @"Statistics"
#define kNewGameButtonTitle @"Новая игра"

@implementation MainViewController {

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

- (void)showStatistics {

}

- (void)showSettings {

}

- (void)startNewGame {
    StartGameViewController *vc = [[StartGameViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - config ui

- (void)configUI {
    //right button statistics
    //left button settings
    //profile info : name, ava
    //new game button
    //history

    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:kSettingsButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
    self.navigationItem.leftBarButtonItem = settingsButton;
    
    UIBarButtonItem *statisticsButton = [[UIBarButtonItem alloc] initWithTitle:kStatisticsButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(showStatistics)];
    self.navigationItem.rightBarButtonItem = statisticsButton;
    

    CGRect frame = CGRectMake(0, 0, [ASize screenWidth], [ASize screenHeight]);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];

    AAForm *form = [[AAForm alloc] initWithScrollView:scrollView];
    
    UIButton *newGameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [newGameButton setTitle:kNewGameButtonTitle forState:UIControlStateNormal];
    [newGameButton addTarget:self action:@selector(startNewGame) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:newGameButton marginTop:150 centered:YES];

}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
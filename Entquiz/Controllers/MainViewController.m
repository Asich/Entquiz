//
// Created by Mustafin Askar on 08/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "MainViewController.h"
#import "AAForm.h"
#import "StartGameViewController.h"
#import "User.h"
#import "StatisticsViewController.h"
#import "SettingsViewController.h"
#import "GameApi.h"
#import "NSObject+Json.h"

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

    NSLog(@"user token %@", [User sharedInstance].accessToken);

//    NSDictionary *params = @{
//            @"gameId" : @36,
//            @"roundNum" : @1,
//            @"catId" : @8,
//            @"q1Id" : @54,
//            @"q2Id" : @55,
//            @"q3Id" : @56,
//            @"a1Id" : @71,
//            @"a2Id" : @80,
//            @"a3Id" : @87
//    };
//    [GameApi submitRoundWithParams:params success:^(id response) {
//        NSLog(@"response: %@", response);
//    } failure:^(NSInteger code, NSString *message) {
//        NSLog(@"failure: %@", message);
//    }];
}

#pragma mark - config actions

- (void)showStatistics {
    StatisticsViewController *vc = [[StatisticsViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)showSettings {
    SettingsViewController *vc = [[SettingsViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
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

    UILabel *userName = [[UILabel alloc] init];
    userName.text = [NSString stringWithFormat:@"Вы в сети как %@", [User sharedInstance].userName];
    [userName sizeToFit];
    [form pushView:userName marginLeft:15 marginTop:50];
    
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
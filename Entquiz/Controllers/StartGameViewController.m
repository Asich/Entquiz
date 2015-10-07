//
// Created by Mustafin Askar on 08/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "StartGameViewController.h"
#import "AAForm.h"
#import "PlayingGameManagerViewController.h"


#define kFindRibalButtonTitle @"Найти соперника"
#define kRandomRivalButtonTitle @"Случайный соперник"

@implementation StartGameViewController {

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

- (void)findRival {

}

- (void)randomRival {
    //todo: after loading the first round category with question and game will start in server
    PlayingGameManagerViewController *vc = [[PlayingGameManagerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - config ui

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];

    CGRect frame = CGRectMake(0, 0, [ASize screenWidth], [ASize screenHeight]);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    AAForm *form = [[AAForm alloc] initWithScrollView:scrollView];
    
    UIButton *findRivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [findRivalButton setTitle:kFindRibalButtonTitle forState:UIControlStateNormal];
    [findRivalButton addTarget:self action:@selector(findRival) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:findRivalButton marginTop:150 centered:YES];

    UIButton *randomRivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [randomRivalButton setTitle:kRandomRivalButtonTitle forState:UIControlStateNormal];
    [randomRivalButton addTarget:self action:@selector(randomRival) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:randomRivalButton marginTop:20 centered:YES];

}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
//
// Created by Mustafin Askar on 01/10/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIViewController+Extensions.h"
#import "AAForm.h"
#import "UIButton+EntStyle.h"
#import "AuthApi.h"


@implementation SettingsViewController {

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

- (void)logout {
    [AuthApi logout];
}

#pragma mark - config ui

- (void)configUI {
    [self addDefaultBackground];
    [self setNavigationBarTransparent];
    [self defaultNavigationBarTitleColor];


    CGRect frame = CGRectMake(0, 0, [ASize screenWidth], [ASize screenHeight]);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    AAForm *form = [[AAForm alloc] initWithScrollView:scrollView];

    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton applyEntStyleGreen];
    [logoutButton setTitle:@"Выйти" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:logoutButton marginTop:50 centered:YES];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {

}

@end
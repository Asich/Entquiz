//
// Created by Mustafin Askar on 08/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "LoginViewController.h"
#import "StdTextField.h"
#import "AAForm.h"
#import "MainViewController.h"
#import "StdButton.h"

#define kLofinTextFieldPlaceholder @"Логин"
#define kLoginButtonTitle @"Войти"
#define kForgotPasswordButtonTitle @"Забыл пароль"

@interface LoginViewController ()
@property(nonatomic, copy) NSString *kPasswordTextFieldPlaceholder;
@end

@implementation LoginViewController {

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

- (void)login {
    MainViewController *vc = [[MainViewController alloc] init];
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

    StdTextField *loginTextField = [[StdTextField alloc] init];
    loginTextField.placeholder = kLofinTextFieldPlaceholder;
    [form pushView:loginTextField marginTop:150 centered:YES];

    StdTextField *passwordTextField = [[StdTextField alloc] init];
    self.kPasswordTextFieldPlaceholder = @"Пароль";
    passwordTextField.placeholder = self.kPasswordTextFieldPlaceholder;
    [form pushView:passwordTextField marginTop:20 centered:YES];

    StdButton *loginButton = [[StdButton alloc] initWithTitle:kLoginButtonTitle];
    [form pushView:loginButton marginTop:150 centered:YES];

//    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [loginButton setTitle:kLoginButtonTitle forState:UIControlStateNormal];
//    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [form pushView:loginButton marginTop:20 centered:YES];

    UIButton *forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgotPasswordButton setTitle:kForgotPasswordButtonTitle forState:UIControlStateNormal];
    [form pushView:forgotPasswordButton marginTop:150 centered:YES];
}

#pragma mark - mem worn

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
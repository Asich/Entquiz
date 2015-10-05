//
// Created by Mustafin Askar on 08/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "LoginViewController.h"
#import "StdTextField.h"
#import "AAForm.h"
#import "MainViewController.h"
#import "ApiClient.h"
#import "AuthApi.h"
#import "SVProgressHUD.h"
#import "User.h"
#import "UIWebView+AFNetworking.h"

#define kUserNameTextFieldPlaceholder @"Логин"
#define kPasswordTextFieldPlaceholder @"Пароль"
#define kEnterButtonTitle @"Войти"
#define kForgotPasswordButtonTitle @"Забыл пароль"

@interface LoginViewController ()
@property(nonatomic, strong) StdTextField *userNameTextField;
@property(nonatomic, strong) StdTextField *passwordTextField;
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
    __weak LoginViewController *wSelf = self;
    
    if (self.userNameTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        [SVProgressHUD showWithStatus:@"Вход"];
        [AuthApi loginWithName:self.userNameTextField.text andPassword:self.passwordTextField.text success:^(id response) {
            NSLog(@"REGISTER SUCCESS RESPONSE: %@", response);

            if ([response[@"success"] boolValue]) {
                NSLog(@"authorized user");

                [User sharedInstance].userName = self.userNameTextField.text;
                [User sharedInstance].accessToken = response[@"token"];
                
                [wSelf gotoMainViewController];
            }

            [SVProgressHUD dismiss];
        } failure:^(NSInteger code, NSString *message) {
            NSLog(@"REGISTER FAILURE MESSAGE: %@", message);
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)gotoMainViewController {
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

    self.userNameTextField = [[StdTextField alloc] init];
    self.userNameTextField.placeholder = kUserNameTextFieldPlaceholder;
    [form pushView:self.userNameTextField marginTop:150 centered:YES];

    self.passwordTextField = [[StdTextField alloc] init];
    self.passwordTextField.placeholder = kPasswordTextFieldPlaceholder;
    [form pushView:self.passwordTextField marginTop:20 centered:YES];


    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginButton setTitle:kEnterButtonTitle forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:loginButton marginTop:20 centered:YES];

    UIButton *forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgotPasswordButton setTitle:kForgotPasswordButtonTitle forState:UIControlStateNormal];
    [form pushView:forgotPasswordButton marginTop:150 centered:YES];
}

#pragma mark - mem worn

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
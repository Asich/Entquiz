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
#import "SecurityTokenManager.h"
#import "UIButton+EntStyle.h"
#import "UIColor+Extensions.h"
#import "UIFont+Extension.h"
#import "UIViewController+Extensions.h"

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
                [User sharedInstance].userId = response[@"userId"];

                //For token based authentication
                //save userName to userDefaults
                [[NSUserDefaults standardUserDefaults] setObject:self.userNameTextField.text forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults] setObject:response[@"userId"] forKey:@"userId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //save secure token for name
                [[SecurityTokenManager sharedManager] writeToken:response[@"token"] userName:self.userNameTextField.text];


                //REGISTER DEVICE TOKEN FOR PUSH
                NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"devicePushTokenId"];
                if (deviceToken) {
                    [AuthApi registerPushDeviceToke:deviceToken success:^(id response2) {
                        NSLog(@"Device token register success");
                    } failure:^(NSInteger code, NSString *message) {
                        NSLog(@"Device token register fail");
                    }];
                }

                //TOGO MAINVC
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
    [self addDefaultBackground];

    CGRect frame = CGRectMake(0, 0, [ASize screenWidth], [ASize screenHeight]);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];

    AAForm *form = [[AAForm alloc] initWithScrollView:scrollView];

    self.userNameTextField = [[StdTextField alloc] init];
    self.userNameTextField.placeholder = kUserNameTextFieldPlaceholder;
    [form pushView:self.userNameTextField marginTop:150 centered:YES];

    self.passwordTextField = [[StdTextField alloc] init];
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.placeholder = kPasswordTextFieldPlaceholder;
    [form pushView:self.passwordTextField marginTop:20 centered:YES];


    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton applyEntStyleGreen];
    [loginButton setTitle:kEnterButtonTitle forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:loginButton marginTop:20 centered:YES];

    UIButton *forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgotPasswordButton setTitleColor:[UIColor entGreenColor] forState:UIControlStateNormal];
    forgotPasswordButton.titleLabel.font = [UIFont entMediumFontWithSize:13];
    [forgotPasswordButton setTitle:kForgotPasswordButtonTitle forState:UIControlStateNormal];
    [form pushView:forgotPasswordButton marginTop:150 centered:YES];
}

#pragma mark - mem worn

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
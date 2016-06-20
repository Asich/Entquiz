//
//  RegistrationViewController.m
//  Entquiz
//
//  Created by Mustafin Askar on 08/09/2015.
//  Copyright (c) 2015 askar. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AAForm.h"
#import "AuthApi.h"
#import "SVProgressHUD.h"
#import "SecurityTokenManager.h"
#import "StdTextField.h"
#import "UIViewController+Extensions.h"
#import "User.h"
#import "MainViewController.h"
#import "UIButton+EntStyle.h"
#import "Consts.h"


@interface RegistrationViewController ()
@property(nonatomic, strong) StdTextField *userNameTextField;
@property(nonatomic, strong) StdTextField *passwordTextField;
@end

@implementation RegistrationViewController

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}

#pragma mark - config actions

- (void)register {
    __weak RegistrationViewController *wSelf = self;

    if (self.userNameTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        [SVProgressHUD showWithStatus:kRegister];
        [AuthApi registerWithName:self.userNameTextField.text andPassword:self.passwordTextField.text success:^(id response) {
            [SVProgressHUD dismiss];

            if ([response[@"success"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:kRegisterSuccess];
                [wSelf login];
            }

        } failure:^(NSInteger code, NSString *message) {
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)login {
    __weak RegistrationViewController *wSelf = self;

    if (self.userNameTextField.text.length > 0 && self.passwordTextField.text.length > 0) {

        [SVProgressHUD showWithStatus:@"Вход"];
        [AuthApi loginWithName:self.userNameTextField.text andPassword:self.passwordTextField.text success:^(id response) {

            if ([response[@"success"] boolValue]) {
                NSLog(@"authorized user");

                [User sharedInstance].userName = self.userNameTextField.text;
                [User sharedInstance].accessToken = response[@"token"];

                //For token based authentication
                //save userName to userDefaults
                [[NSUserDefaults standardUserDefaults] setObject:self.userNameTextField.text forKey:kUsernameKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //save secure token for name
                [[SecurityTokenManager sharedManager] writeToken:response[@"token"] userName:self.userNameTextField.text];

                //REGISTER DEVICE TOKEN FOR PUSH
                NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:kDevicePushTokenId];
                if (deviceToken) {
                    [AuthApi registerPushDeviceToken:deviceToken success:^(id response2) {
                        NSLog(@"Device token register success");
                    }                        failure:^(NSInteger code, NSString *message) {
                        NSLog(@"Device token register fail");
                    }];
                }

                [wSelf gotoMainViewController];
            }

            [SVProgressHUD dismiss];
        } failure:^(NSInteger code, NSString *message) {
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
    self.passwordTextField.placeholder = kPasswordButtonTitle;
    [form pushView:self.passwordTextField marginTop:20 centered:YES];

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton applyEntStyleGray];
    [registerButton setTitle:kRegisterButtonTitle forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(register) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:registerButton marginTop:20 centered:YES];

}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

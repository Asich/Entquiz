//
//  RegistrationViewController.m
//  Entquiz
//
//  Created by Mustafin Askar on 08/09/2015.
//  Copyright (c) 2015 askar. All rights reserved.
//

#import "RegistrationViewController.h"
#import "StdTextField.h"
#import "AAForm.h"
#import "AuthApi.h"
#import "SVProgressHUD.h"

#define kLofinTextFieldPlaceholder @"Логин"
#define kLoginButtonTitle @"Пароль"
#define kRegisterButtonTitle @"Создать"

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
    if (self.userNameTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        [SVProgressHUD showWithStatus:@"Регистрация"];
        [AuthApi registerWithName:self.userNameTextField.text andPassword:self.passwordTextField.text success:^(id response) {
            NSLog(@"REGISTER SUCCESS RESPONSE: %@", response);
            [SVProgressHUD dismiss];
        } failure:^(NSInteger code, NSString *message) {
            NSLog(@"REGISTER FAILURE MESSAGE: %@", message);
            [SVProgressHUD dismiss];
        }];
    }
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
    self.userNameTextField.placeholder = kLofinTextFieldPlaceholder;
    [form pushView:self.userNameTextField marginTop:150 centered:YES];

    self.passwordTextField = [[StdTextField alloc] init];
    self.passwordTextField.placeholder = kLoginButtonTitle;
    [form pushView:self.passwordTextField marginTop:20 centered:YES];

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
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

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

#define kLofinTextFieldPlaceholder @"Логин"
#define kLoginButtonTitle @"Пароль"
#define kRegisterButtonTitle @"Создать"

@interface RegistrationViewController ()

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

#pragma mark -

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
    passwordTextField.placeholder = kLoginButtonTitle;
    [form pushView:passwordTextField marginTop:20 centered:YES];

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [registerButton setTitle:kRegisterButtonTitle forState:UIControlStateNormal];
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

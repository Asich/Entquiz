//
//  IndexViewController.m
//  Entquiz
//
//  Created by Mustafin Askar on 27/06/2015.
//  Copyright (c) 2015 askar. All rights reserved.
//

#import "IndexViewController.h"
#import "AAForm.h"
#import "RegistrationViewController.h"
#import "LoginViewController.h"

#define kButtonWidth 200
#define kButtonHeight 40
#define kAppNameTitleString @"БЗГ"
#define kCreateButtonTitle @"Создать аккаунт"
#define kEnterButtonTitle @"Вход"
#define kAppNameTitleFont @"Helvetica-Neue"

@interface IndexViewController ()
@property (nonatomic, strong) RegistrationViewController *registrationVC;
@property (nonatomic, strong) LoginViewController *loginVC;
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self buildUI];
}

#pragma mark - config actions

- (void)createAccount {
    self.registrationVC = [[RegistrationViewController alloc] init];
    [self.navigationController pushViewController:self.registrationVC animated:YES];
}

- (void)login {
    self.loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:self.loginVC animated:YES];
}

#pragma mark - build UI

- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];

    CGRect frame = CGRectMake(0, 0, [ASize screenWidth], [ASize screenHeight]);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    AAForm *form = [[AAForm alloc] initWithScrollView:scrollView];

    UILabel *testLabel = [[UILabel alloc] init];
    testLabel.font = [UIFont fontWithName:kAppNameTitleFont size:30];
    testLabel.text = kAppNameTitleString;
    [testLabel sizeToFit];
    [form pushView:testLabel marginTop:30 centered:YES];

    UIButton *createAccountButton = [UIButton buttonWithType:UIButtonTypeSystem];
    createAccountButton.frame = CGRectMake(0, 0, kButtonWidth, kButtonHeight);
    [createAccountButton setTitle:kCreateButtonTitle forState:UIControlStateNormal];
    [createAccountButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [createAccountButton addTarget:self action:@selector(createAccount) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:createAccountButton marginTop:100 centered:YES];

    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    enterButton.frame = CGRectMake(0, 0, kButtonWidth, kButtonHeight);
    [enterButton setTitle:kEnterButtonTitle forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [enterButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:enterButton marginTop:20 centered:YES];
    
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

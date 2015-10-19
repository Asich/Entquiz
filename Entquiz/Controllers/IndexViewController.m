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
#import "SecurityTokenManager.h"
#import "MainViewController.h"
#import "User.h"
#import "UIColor+Extensions.h"
#import "UIFont+Extension.h"
#import "UIViewController+Extensions.h"
#import "UIButton+BackgroudForState.h"
#import "UIButton+EntStyle.h"

#define kAppNameTitleString @"Битва за грант"
#define kCreateButtonTitle @"Создать аккаунт"
#define kEnterButtonTitle @"Вход"


@interface IndexViewController ()
@property (nonatomic, strong) RegistrationViewController *registrationVC;
@property (nonatomic, strong) LoginViewController *loginVC;
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configUI];
    [self authenticateUser];
}

- (void)authenticateUser {
    //todo do authentication with token

    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];

    if (userName) {
        NSString *secureToken = [[SecurityTokenManager sharedManager] readTokenForUserName:userName];
        [User sharedInstance].accessToken = secureToken;
        [User sharedInstance].userName = userName;
        [User sharedInstance].userId = userId;

        if (secureToken) {
            MainViewController *mainViewController = [[MainViewController alloc] init];
            [self.navigationController pushViewController:mainViewController animated:YES];
        }
    }
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

- (void)configUI {
    [self addDefaultBackground];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNavigationBarTransparent];
    [self defaultNavigationBarTitleColor];


    CGRect frame = CGRectMake(0, 0, [ASize screenWidth], [ASize screenHeight]);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    AAForm *form = [[AAForm alloc] initWithScrollView:scrollView];

    UILabel *testLabel = [[UILabel alloc] init];
    testLabel.font = [UIFont entMediumFontWithSize:15];
    testLabel.textColor = [UIColor lightGrayColor];
    testLabel.text = kAppNameTitleString;
    [testLabel sizeToFit];
    [form pushView:testLabel marginTop:30 centered:YES];

    UIButton *createAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [createAccountButton applyEntStyleGray];
    [createAccountButton setTitle:kCreateButtonTitle forState:UIControlStateNormal];
    [createAccountButton addTarget:self action:@selector(createAccount) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:createAccountButton marginTop:150 centered:YES];

    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [enterButton applyEntStyleGreen];
    [enterButton setTitle:kEnterButtonTitle forState:UIControlStateNormal];
    [enterButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [form pushView:enterButton marginTop:10 centered:YES];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

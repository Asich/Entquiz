//
// Created by Mustafin Askar on 21/11/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import <UIAlertView+Blocks/UIAlertView+Blocks.h>
#import "FindOpponentViewController.h"
#import "UIViewController+Extensions.h"
#import "AAForm.h"
#import "StdTextField.h"
#import "UIButton+EntStyle.h"
#import "GameApi.h"
#import "NSObject+Json.h"
#import "SVProgressHUD.h"
#import "GameRoundUser.h"


@interface FindOpponentViewController ()
@property (nonatomic, strong) StdTextField *opponentNameTextField;
@property (nonatomic, strong) UIButton *findOpponentButton;
@property (nonatomic, strong) GameRoundUser *foundOpponentUser;
@property (nonatomic, strong) AAForm *form;
@property (nonatomic, strong) UIButton *inviteOpponentButton;
@end

@implementation FindOpponentViewController {

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

- (void)findOpponent {
    if (self.opponentNameTextField.text.length > 0) {
        [SVProgressHUD show];
        [GameApi findOpponentWithName:self.opponentNameTextField.text success:^(id response) {
            if (response[@"user"]) {
                self.foundOpponentUser = [GameRoundUser instanceFromDictionary:response[@"user"]];

                [self showFoundOpponentUser:self.foundOpponentUser];
            }
            [SVProgressHUD dismiss];
        } failure:^(NSInteger code, NSString *message) {
            [UIAlertView showWithTitle:nil message:@"Не удалось найти соперника" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)clickInviteOpponentButton {
    if (self.foundOpponentUser) {
        [SVProgressHUD show];
        [GameApi inviteOpponentWithOpponentId:self.foundOpponentUser.gameRoundUserId success:^(id response) {
            NSLog(@"response: %@", [response JSONRepresentation]);
            if ([response[@"success"] boolValue]) {
                NSString *alertMessage = [NSString stringWithFormat:@"Вы пригласили %@", self.foundOpponentUser.username];
                [UIAlertView showWithTitle:nil message:alertMessage cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            }
            [SVProgressHUD dismiss];
        } failure:^(NSInteger code, NSString *message) {
            [UIAlertView showWithTitle:nil message:@"Не удалось пригласить соперника" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            [SVProgressHUD dismiss];
        }];
    }
}

/**
* Draw inviteOpponentButton allways but if exist - remove
*
*/
- (void)showFoundOpponentUser:(GameRoundUser *)foundOpponentUser {
    if (self.inviteOpponentButton) {
        [self.form removeView:self.inviteOpponentButton];
    }
    self.inviteOpponentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.inviteOpponentButton applyEntStyleGray];
    NSString *buttonTitle = [NSString stringWithFormat:@"Пригласить %@", foundOpponentUser.username];
    [self.inviteOpponentButton setTitle:buttonTitle forState:UIControlStateNormal];
    [self.inviteOpponentButton addTarget:self action:@selector(clickInviteOpponentButton) forControlEvents:UIControlEventTouchUpInside];
    [self.form pushView:self.inviteOpponentButton beforeView:self.findOpponentButton marginTop:40 centered:YES];
}

#pragma mark - config ui

- (void)configUI {
    [self addDefaultBackground];

    CGRect frame = CGRectMake(0, 0, [ASize screenWidth], [ASize screenHeight]);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];

    self.form = [[AAForm alloc] initWithScrollView:scrollView];

    self.opponentNameTextField = [[StdTextField alloc] init];
    self.opponentNameTextField.placeholder = @"Введите имя соперника";
    [self.form pushView:self.opponentNameTextField marginTop:50 centered:YES];

    self.findOpponentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.findOpponentButton applyEntStyleGreen];
    [self.findOpponentButton setTitle:@"Найти соперника" forState:UIControlStateNormal];
    [self.findOpponentButton addTarget:self action:@selector(findOpponent) forControlEvents:UIControlEventTouchUpInside];
    [self.form pushView:self.findOpponentButton marginTop:20 centered:YES];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
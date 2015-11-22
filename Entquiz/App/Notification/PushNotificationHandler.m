//
// Created by Mustafin Askar on 21/11/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "PushNotificationHandler.h"
#import "UIAlertView+Blocks.h"
#import "PlayingGameManagerViewController.h"
#import "AppDelegate.h"


#define kTypeInviteForGame @"inviteForGame"

@implementation PushNotificationHandler {}

+ (void)handlePushWithUserInfo:(NSDictionary *)userInfo {
    NSString *type = (NSString *)userInfo[@"type"];
//    NSString *message = userInfo[@"aps"][@"alert"];
    
    if ([type isEqualToString:kTypeInviteForGame]) {
        [self notifyAboutInviteForGameWithUserInfo:userInfo];
    }
}

#pragma mark - actions

+ (void)notifyAboutInviteForGameWithUserInfo:(NSDictionary *)userInfo {
    NSString *message = userInfo[@"aps"][@"alert"];
    NSNumber *opponentId = userInfo[@"userId"];

    [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"Нет" otherButtonTitles:@[@"Да"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if ( buttonIndex != alertView.cancelButtonIndex ) {
            UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
            UINavigationController *nc = (UINavigationController *) keyWindow.rootViewController;
            PlayingGameManagerViewController *vc = [[PlayingGameManagerViewController alloc] initWithOpponentId:opponentId];
            [nc pushViewController:vc animated:YES];
        } else {

        }
    }];
}

@end
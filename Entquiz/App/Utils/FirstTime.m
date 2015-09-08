//
//  FirstTime.m
//  ggg
//
//  Created by Mustafin Askar on 28/01/2014.
//  Copyright (c) 2014 askar. All rights reserved.
//

#import "FirstTime.h"

@implementation FirstTime

+ (BOOL)isAppLaunchedFirstTime {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        return NO;
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
}

@end

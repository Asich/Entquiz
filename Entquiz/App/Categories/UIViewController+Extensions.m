//
// Created by Mustafin Askar on 28/09/15.
// Copyright (c) 2015 askar. All rights reserved.
//

#import "UIViewController+Extensions.h"
#import "UIColor+Extensions.h"


@implementation UIViewController (Extensions)

- (void)addDefaultBackground {
    self.view.backgroundColor = [UIColor fromRGB:0xEEEEEE];
}

- (void)setNavigationBarTransparent {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)defaultNavigationBarTitleColor {
    self.navigationController.navigationBar.tintColor = [UIColor entquizGrayColor];
}

@end